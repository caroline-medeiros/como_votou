# app/services/camara_service.rb

class CamaraService
  BASE_URL = "https://dadosabertos.camara.leg.br/api/v2/"

  def initialize
    @conn = Faraday.new(url: BASE_URL) do |f|
      f.response :json
      f.adapter Faraday.default_adapter
      f.headers["User-Agent"] = "ComoVotouProjetoEducacional/1.0"
      f.headers["Accept"] = "application/json"
    end
  end

  def import_parties
    response = @conn.get("partidos", { itens: 100, ordem: "ASC", ordenarPor: "sigla" })
    unless response.success?
      return
    end

    partidos_json = response.body["dados"]

    partidos_json.each do |dado|
      party = Party.find_or_initialize_by(api_id: dado["id"])
      party.name = dado["nome"]
      party.acronym = dado["sigla"]
      if party.save
        print "."
      else
        puts "\nErro ao salvar #{party.name}: #{party.errors.full_messages}"
      end
    end
  end

  def import_deputies
    response = @conn.get("deputados", { itens: 1000, ordem: "ASC", ordenarPor: "nome" })

    unless response.success?
      return
    end

    deputados_json = response.body["dados"]

    deputados_json.each do |dado|
      party = Party.find_by(acronym: dado["siglaPartido"])

      if party.nil?
        puts "Partido não encontrado para: #{dado['nome']} (#{dado['siglaPartido']})"
        next
      end

      deputy = Deputy.find_or_initialize_by(api_id: dado["id"])

      deputy.name = dado["nome"]
      deputy.state = dado["siglaUf"]
      deputy.email = dado["email"]
      deputy.photo_url = dado["urlFoto"]
      deputy.party = party

      if deputy.save
        print "."
      else
        puts "\nErro ao salvar #{deputy.name}: #{deputy.errors.full_messages}"
      end
    end
  end

  def import_recent_votings(days_ago = 30)
    limit_date = Date.today - days_ago.days
    if limit_date.year < Date.today.year
      limit_date = Date.new(Date.today.year, 1, 1)
    end

    data_inicio = limit_date.strftime("%Y-%m-%d")
    data_fim = Date.today.strftime("%Y-%m-%d")

    response = @conn.get("votacoes", {
      dataInicio: data_inicio,
      dataFim: data_fim,
      ordenarPor: "dataHoraRegistro",
      ordem: "DESC",
      itens: 100
    })

    unless response.success?
      puts "Erro na requisição: #{response.status}"
      return
    end

    votacoes = response.body["dados"] || []

    if votacoes.empty?
      puts "Nenhuma votação encontrada no período."
      return
    end

    saved_count = 0

    votacoes.each do |voto_api|
      next unless voto_api["siglaOrgao"] == "PLEN"

      proposition = nil
      if voto_api["uriProposicaoPrincipal"]
        prop_api_id = voto_api["uriProposicaoPrincipal"].split("/").last
        proposition = find_or_import_proposition(prop_api_id.to_s)
      end

      voting = Voting.find_or_initialize_by(api_id: voto_api["id"].to_s)

      voting.datetime = voto_api["dataHoraRegistro"]
      voting.result = voto_api["aprovacao"] == 1 ? "Aprovada" : "Rejeitada/Outros"
      voting.description = voto_api["descricao"]
      voting.proposition = proposition

      if voting.save
        saved_count += 1
        print "."
      end
    end
  end

  def import_votes_from_existing_votings
    votings_to_process = Voting.left_joins(:votes).where(votes: { id: nil })
    total = votings_to_process.count


    votings_to_process.each_with_index do |voting, index|
      response = @conn.get("votacoes/#{voting.api_id}/votos")

      unless response.success?
        if response.status == 404
          puts "Votação Simbólica (sem votos individuais). Pulando..."
        else
          puts "Erro #{response.status}: #{response.body}"
        end
        next
      end

      votos_json = response.body["dados"]

      if votos_json.empty?
        puts "Lista de votos vazia."
        next
      end

      deputies_map = Deputy.all.index_by(&:api_id)
      votes_created = 0

      votos_json.each do |voto_api|
         deputy_api_id = voto_api["deputado_"]["id"].to_s
         deputy = deputies_map[deputy_api_id]

         if deputy
           Vote.create(
             voting: voting,
             deputy: deputy,
             vote_type: voto_api["tipoVoto"]
           )
           votes_created += 1
         end
      end

      puts "#{votes_created} votos importados."
    end
  end

  private

  def find_or_import_proposition(api_id)
    existing = Proposition.find_by(api_id: api_id)
    return existing if existing

    response = @conn.get("proposicoes/#{api_id}")
    return nil unless response.success?

    dados = response.body["dados"]

    Proposition.create(
      api_id: dados["id"],
      title: "#{dados['siglaTipo']} #{dados['numero']}/#{dados['ano']}",
      description: dados["ementa"],
      status: dados["statusProposicao"]["descricaoSituacao"],
      year: dados["ano"]
    )
  rescue => e
    nil
  end
end

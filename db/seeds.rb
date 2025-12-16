# db/seeds.rb

puts "🌱 Iniciando o seed do banco de dados..."

# 1. Limpar dados antigos (para não duplicar se rodar 2x)
# A ordem importa por causa das chaves estrangeiras (primeiro apaga quem depende)
Vote.destroy_all
Voting.destroy_all
Proposition.destroy_all
Deputy.destroy_all
Party.destroy_all

puts "🧹 Banco limpo!"

# 2. Criando Partidos (Parties)
party_a = Party.create!(
  name: "Partido do Progresso",
  acronym: "PPG",
  api_id: 10
)

party_b = Party.create!(
  name: "Movimento Liberal",
  acronym: "MOL",
  api_id: 20
)

party_c = Party.create!(
  name: "União Central",
  acronym: "UNC",
  api_id: 30
)

puts "✅ 3 Partidos criados."

# 3. Criando Deputados (Deputies)
deputies = []

# Deputados do PPG (Partido A)
deputies << Deputy.create!(
  name: "João da Silva",
  api_id: 101,
  state: "SP",
  email: "joao@camara.leg.br",
  party: party_a,
  photo_url: "https://randomuser.me/api/portraits/men/1.jpg"
)

deputies << Deputy.create!(
  name: "Maria Oliveira",
  api_id: 102,
  state: "RJ",
  email: "maria@camara.leg.br",
  party: party_a, # Mesma legenda
  photo_url: "https://randomuser.me/api/portraits/women/2.jpg"
)

# Deputados do MOL (Partido B)
deputies << Deputy.create!(
  name: "Carlos Empresário",
  api_id: 103,
  state: "MG",
  email: "carlos@camara.leg.br",
  party: party_b,
  photo_url: "https://randomuser.me/api/portraits/men/3.jpg"
)

deputies << Deputy.create!(
  name: "Ana Libertária",
  api_id: 104,
  state: "RS",
  email: "ana@camara.leg.br",
  party: party_b,
  photo_url: "https://randomuser.me/api/portraits/women/4.jpg"
)

# Deputado do UNC (Partido C - O "Centrão")
deputies << Deputy.create!(
  name: "Roberto Negociador",
  api_id: 105,
  state: "BA",
  email: "roberto@camara.leg.br",
  party: party_c,
  photo_url: "https://randomuser.me/api/portraits/men/5.jpg"
)

puts "✅ 5 Deputados criados."

# 4. Criando uma Proposição (Lei)
proposition = Proposition.create!(
  api_id: 2567,
  title: "PL 4567/2024",
  description: "Dispõe sobre o aumento do incentivo fiscal para empresas de tecnologia verde e inteligência artificial.",
  status: "Aguardando Sanção",
  year: 2024
)

puts "✅ Proposição criada: #{proposition.title}"

# 5. Criando a Sessão de Votação (Voting)
voting = Voting.create!(
  api_id: 998877,
  proposition: proposition,
  datetime: DateTime.now - 2.days, # Aconteceu 2 dias atrás
  description: "Votação em primeiro turno do texto base.",
  result: "Aprovada"
)

puts "✅ Votação criada para a #{proposition.title}"

# 6. Registrando os Votos (Votes)
# Aqui vamos simular:
# PPG (Partido A) orientou SIM.
# MOL (Partido B) orientou NÃO (diz que é gasto público).
# UNC (Partido C) liberou a bancada.

Vote.create!(voting: voting, deputy: deputies[0], vote_type: "Sim") # João (PPG) - Fiel
Vote.create!(voting: voting, deputy: deputies[1], vote_type: "Não") # Maria (PPG) - Rebelde! Votou contra o partido
Vote.create!(voting: voting, deputy: deputies[2], vote_type: "Não") # Carlos (MOL) - Fiel
Vote.create!(voting: voting, deputy: deputies[3], vote_type: "Não") # Ana (MOL) - Fiel
Vote.create!(voting: voting, deputy: deputies[4], vote_type: "Abstenção") # Roberto (UNC) - Em cima do muro

puts "✅ 5 Votos registrados."
puts "🚀 SEED FINALIZADO COM SUCESSO!"

namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando o BD ...") {%x(rails db:drop)}

      show_spinner("Criando o BD ...") {%x(rails db:create)}

      show_spinner("Migrando o BD ...") {%x(rails db:migrate)}

      %x(rails dev:add_coins)

      %x(rails dev:add_mining_types)

    else
      puts "Você não está em ambiente de desenvolvimento!"
    end
  end

  desc "Cadastro de Moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando moedas...") do
    coins = [
  {
    description: "Bitcoin",
    acronym: "BTC",
    url_image: "https://cdn-icons-png.flaticon.com/256/10454/10454604.png"
  },

  {
    description: "Ethereum",
    acronym: "ETH",
    url_image: "https://cdn.iconscout.com/icon/premium/png-256-thumb/ethereum-2752194-2285011.png?f=webp"
  },

  {
    description: "Dash",
    acronym: "DASH",
    url_image: "https://cryptologos.cc/logos/dash-dash-logo.png"
  },

  {
    description: "BNB",
    acronym: "BNB",
    url_image: "https://icons.iconarchive.com/icons/cjdowner/cryptocurrency-flat/256/Binance-Coin-BNB-icon.png"
  }
]

coins.each do |coin|
  sleep(1)
  Coin.find_or_create_by!(coin)
end
end
end

desc "Cadastro Tipos de Mineração"
  task add_mining_types: :environment do
    show_spinner("Cadastrando tipos de mineração...") do
    mining_types = [
      {description: "Proof of work", acronym: "PoW"},
      {description: "Proof of Stake", acronym: "PoS"},
      {description: "Proof of Capacity", acronym: "PoC"}
    ]
    mining_types.each do |mining_type|
      sleep(1)
      MiningType.find_or_create_by!(mining_type)
    end
  end
    end

  private

  def show_spinner(msg_start, msg_end = "Concluído com sucesso!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
      spinner.auto_spin
    yield
    spinner.success(("#{msg_end}"))
  end
end

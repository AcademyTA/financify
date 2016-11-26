require 'faker'

STOCK_TICKERS = %w{ ABT ANF ADPT ADBE AMD ADVS AES AET AFFX AFL A APD AKAM ACV AL AA ATI AGN ALL AT ALTR AMZN AEP AM AIG AHC AEE AXP AMTD AMGN APC ADI BUD TWX APA AAPL AMAT AMCC ADM ARIA ARW ASH T ADSK ADP AZO AVY AVA AVP BHI BLL BAC BK ONE BCR BKS ABX BAX BBT BCE BDX BBBY BMS BBY BBH HRB BA BCC BSX BP BGG BMY BRCM BRCD BC BR CPN CPB COF CAH CCL CAT CELG CTX CTL CEN CF CHKP CVX CHL CB CI CINF CC CSCO C CTXS CCU CLX CMS CNET COKE KO CCE CL CMCSK CMA CA CSC CAG ED CAL CVG CTB GLW COST CR CREE CCK CSX CVS DHR DRI DE DAL DEL DLX DIA DDS DIS DG DLTR D DOV DOW DTE DUK DNB DD ELNK EMN ETN EBAY ELON DISH ECL EIX EMC EMR EC ETR ENZ EFX XOM FDX FITB FDC FE FLEX FLR FMC F FOSL FOX FPL BEN FCX FCEL GCI GPS GM GD GE GIS GPC G GT GOOG GRA GWW GES HAL HIG HAS HCA HLTH HP HSY HLT HD HMC HON HUM HBAN ITW N INCY INFY IR INTC IPG ISIL INTL IBM IFF IP INTU ITT JBL JKHY JP JNJ JCI JNPR KBH K KMG KEY KMB KLAC KSS KKD KR KYO LRCX LEG LXK LLY LNC LLTC LMT LPX LOW MAR MMC MAS MAT MXIM MBI MDR MCD MCK MDT MRK MDP MET MGM MTG MU MSFT MSTR MIL MMM JPM MYGN QQQ NSM NAV NCR NTAP NYT NWL NEM NEWP GAS NKE NOK JWN NSC NTRS NOC NVLS NUE NVDA OXY ODP OMC OKE ONVI ORCL OSIS OI PCAR PSUN PZZA PH PAYX JCP PSFT PEP PKI PFE PCG MO PHG PNW PBI PIXR PDG PLUG PMCS PNC RL PCH PWAV PPG PPL PX PCLN PG PGR PDLI PVN PEG PHM QGENF QLGC QLTI QCOM QSFT ZQK RSH RMBS RTN RHAT RBK REGN RCOM RIMM RMD RFMD ROK ROH RDC RD RML R TSG SAFC SWY SLAB SNDK SANM SAPE SLE SBC SGP SLB SCH SFA SEE S SRE SC SHW SEBL SIAL SILI SKX SLM SNA SNE SO SOTR LUV FON STJ SWK SPLS SBUX STT SUN STI SVU SBL SNV SYY TROW TGT TEK TLAB TIN THC TER TXN TXT LTD TMO TNB TIBX TIF TBL TKR TTN TJX TOM TMK TM TOY RIG TRB YUM TUP TXU TYC USB UN UNP UPC UIS UPS USM UTX UNH UVV UVN UCL UNM UST MRO X UTSI VANS VRSN VZ VRTS VFC VIA VC VOD VMC WB WAG WMT WM WMI WPI WLP WFC WEN WY WHR WMB WOR WWY WWE XRX XLNX YHOO ZIGO }

## Create Admin Users
User.create(
  email: 'jason@example.com',
  first_name: 'Jason',
  last_name: 'Tam',
  password: 12345678
)

User.create(
  email: 'admin@example.com',
  first_name: 'Admin',
  last_name: 'Istrator',
  password: 12345678
)

## Create test Users
30.times do
  user  = Faker::StarWars.character
  email = user.delete(' ').downcase
  names = user.split(' ')

  User.create(
    email: "#{email}@example.com",
    first_name: names.first,
    last_name: names.last,
    password: 12345678
  )
end

30.times do
  user  = Faker::GameOfThrones.character
  email = user.delete(' ').downcase
  names = user.split(' ')

  User.create(
    email: "#{email}@example.com",
    first_name: names.first,
    last_name: names.last,
    password: 12345678
  )
end

## Create Stocks
stocks = StockQuote::Stock.quote(STOCK_TICKERS)

stocks.each do |stock|
  if stock.name.present?
    Stock.find_or_create_by(
      ticker:     stock.symbol,
      name:       stock.name,
      last_price: stock.open,
    )
  end
end

## Create Friendships and Portfolios
all_users  = User.all
all_stocks = Stock.all

all_users.each do |user|
  friends   = all_users.sample(15)
  portfolio = all_stocks.sample(8)

  friends.reject! { |friend| friend.id == user.id }
  user.friends += friends

  user.stocks  += portfolio
end


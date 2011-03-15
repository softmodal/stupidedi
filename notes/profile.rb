require "stupidedi"
require "ruby-prof"

config = Stupidedi::Configuration.new
config.interchange.register(Stupidedi::Dictionaries::Interchanges::FiveOhOne::InterchangeDef, "00501")
config.functional_group.register(Stupidedi::Dictionaries::FunctionalGroups::FiftyTen::FunctionalGroupDef, "005010")
config.transaction_set.register(Stupidedi::Dictionaries::FunctionalGroups::FiftyTen::TransactionSetDefs::HC837, "005010")
config.transaction_set.register(Stupidedi::Dictionaries::FunctionalGroups::FiftyTen::TransactionSetDefs::HP835, "005010")
config.transaction_set.register(Stupidedi::Guides::FiftyTen::X222::HC837, "005010X222")

input     = Stupidedi::Reader::Input.build(File.open(ARGV.first))
tokenizer = Stupidedi::Reader::StreamReader.new(input)
parser    = Stupidedi::Builder_::StateMachine.build(config)

result = RubyProf.profile do
  parser.read!(tokenizer)
end

RubyProf::GraphPrinter.new(result).print($stdout)

pp parser
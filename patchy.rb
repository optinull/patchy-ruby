$LOAD_PATH.unshift "."

require "trollop"
require "lib/cpu"
require "lib/tools/assembler"

opts = Trollop::options do
  opt :info, "Display all available info"
  opt :instructions, "Display instruction set"
  opt :arch, "Display architecture description"
  opt :assemble, "Assemble source", :type => :string
  opt :out, "Output file", :type => :string, :default => "out.bin"
  opt :debug, "Verbose debug logging"
end

if opts.info
  opts[:arch] = true
  opts[:instructions] = true
end

patchy = Patchy::CPU.new
assembler = Patchy::Assembler.new opts.debug

if opts.instructions
  puts patchy.instructions_s
elsif opts.assemble
  bin = assembler.assemble File.open(opts.assemble, "r")
end
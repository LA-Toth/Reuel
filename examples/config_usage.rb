#!/usr/bin/env ruby

$: << File.dirname(File.dirname(File.realpath(__FILE__)))
require 'reuel/config.rb'


cfg = Reuel::Config.new

puts 'Default content'
puts cfg.config


puts 'Set a basic item (simple => 42)'
cfg.set('simple', 42)

puts 'Set a deeper item (an.example to 3.14)'
cfg.set('an.example', 3.14)

puts 'Expected output something like:'
puts '{'
puts 'simple => 42,'
puts 'an => { example => 3.14 },'
puts '}'
puts cfg.config

#!/usr/bin/env ruby

# Copyright 2016-2017 Laszlo Attila Toth
# Distributed under the terms of the GNU General Public License v3

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
puts cfg.config

puts 'Get 3.14'
puts cfg.get('an.example')

puts 'Append 5 and 10 to a (new) list'
puts cfg.append('a.list', 5)
puts cfg.append('a.list', 10)

puts 'Print the list'
puts cfg.get('a.list')

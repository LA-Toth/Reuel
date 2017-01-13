# Copyright 2016-2017 Laszlo Attila Toth
# Distributed under the terms of the GNU General Public License v3

module Reuel
  #class EntryNotFound < KeyError
  #	nil
  #end

  class Config

    public

    def initialize
      @config = Hash.new
    end

    attr_reader :config

    # @param [String] entry The entry name in config tree, eg. commands.splitlog.delimiter
    # @param [Object] value The value of the entry, it can have any type, eg. ':', or 3.14
    def set(entry, value)
      c, key = get_container_and_key(entry)

      if c.include?(key) and key.instance_of?(Hash)

	c[key] = value
      end
    end

    # @param [String] entry The entry name in config tree, eg. commands.splitlog.delimiter, which represents a list
    # @param [Object] value The value of the entry, it can have any type, eg. ':', or 3.14
    def append(entry, value)
      c, key = get_container_and_key(entry)

      c[key] = [] unless c.include?(key)
      c[key] << value
    end

    # @param [String] entry The entry name in config tree, eg. commands.splitlog.delimiter, which represents a set
    # @param [Object] value The value of the entry, it can have any type, eg. ':', or 3.14
    def add_to_set(entry, value)
      c, key = get_container_and_key(entry)

      c[key] = Set.new unless c.include?(key)
      c[key] << value
    end

    # @param [String] entry The entry name in config tree, eg. commands.splitlog.delimiter
    def get(entry)
      puts entry
      keys = entry.split('.')
      puts keys
      puts @config
      c = @config
      puts c
      return c

      begin
	keys.each { |key| c = c[key] }
	c = c[key]
      rescue KeyError
	return @config.default
      end
      c
    end


    protected

    # @param [String] entry
    def get_container_and_key(entry)
      parents = entry.split('.')
      key = parents.pop

      c = @config

      parents.each do |parent|
	c[parent] = Hash.new unless c.include?(parent)
	c = c[parent]
      end

      return c, key
    end

  end

end

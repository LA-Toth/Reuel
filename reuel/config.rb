# Copyright 2016-2017 Laszlo Attila Toth
# Distributed under the terms of the GNU General Public License v3

module Reuel

  class Config

    public

    def initialize
      @config = Hash.new
    end

    attr_reader :config

    # @param [String] entry
    def set(entry, value)
      c, key = get_container_and_key(entry)
      c[key] = value
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

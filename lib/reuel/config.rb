# frozen_string_literal: true

# Copyright 2016-2023 Laszlo Attila Toth
# Distributed under the terms of the GNU General Public License v3

module Reuel
  # class EntryNotFound < KeyError
  #	nil
  # end

  class Config
    def initialize
      @config = {}
    end

    attr_reader :config

    # @param [String] entry The entry name in config tree, eg. commands.splitlog.delimiter
    # @param [Object] value The value of the entry, it can have any type, eg. ':', or 3.14
    def set(entry, value)
      c, key = get_container_and_key(entry)

      return unless !c.include?(key) || !c[key].instance_of?(Hash)

      c[key] = value # rubocop: disable Lint/UselessSetterCall
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
      keys = entry.split('.')
      c = @config

      begin
        keys.each do |key|
          c = c[key]
        end
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
        c[parent] = {} unless c.include?(parent)
        c = c[parent]
      end

      [c, key]
    end
  end
end

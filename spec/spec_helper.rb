# coding: utf-8

require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
  add_filter '/doc/'
  add_filter '/tmp/'
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'coordinates'

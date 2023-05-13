# frozen_string_literal: true

require 'rubocop'

require_relative 'rubocop/hc'
require_relative 'rubocop/hc/version'
require_relative 'rubocop/hc/inject'

RuboCop::Hc::Inject.defaults!

require_relative 'rubocop/cop/hc_cops'

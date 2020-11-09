require 'cfnvpn/log'
require 'cfnvpn/templates/vpn'

module CfnVpn
  class Compiler
    include CfnVpn::Log

    def initialize(name, config)
      @name = name
      @config = config
    end

    def compile
      logger.debug "Compiling cloudformation"
      template = CfnVpn::Templates::Vpn.new()
      template.render(@name, @config)
      logger.debug "Validating cloudformation"
      valid = template.validate
      logger.debug "Clouformation Template\n\n#{JSON.parse(valid.to_json).to_yaml}"
      return JSON.parse(valid.to_json).to_yaml
    end

  end
end
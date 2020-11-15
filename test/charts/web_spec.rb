# frozen_string_literal: true

require_relative '../test_helper'

describe Chart.new('charts/web') do
  describe 'pod replicas' do
    it 'defaults to 1' do
      jq('.spec.replicas', resource('Deployment')).must_equal 1
    end

    it 'accepts integer as value' do
      chart.value replicaCount: 3

      jq('.spec.replicas', resource('Deployment')).must_equal 3
    end
  end

  describe 'arguments' do
    it 'configures custom arguments' do
      args = %w[ls -l /etc]
      chart.value(web: { arguments: args })

      jq('.spec.template.spec.containers[0].args', resource('Deployment')).must_equal args
    end

    it 'configures no custom arguments' do
      chart.value(web: { arguments: nil })

      jq('.spec.template.spec.containers[0].args', resource('Deployment')).must_be_nil
    end
  end

  describe 'with secrets' do
    before do
      chart.value(
        web: {
          secrets: {
            TEST: 'blaat',
            ANOTHER: 'lol'
          }
        }
      )
    end

    it 'configures an secret resource' do
      jq('.data', resource('Secret')).must_equal({ 'TEST' => 'blaat', 'ANOTHER' => 'lol' })
    end

    it 'configures a proper name' do
      jq('.metadata.name', resource('Secret')).must_equal('web-secrets')
    end

    it 'mounts the secret as environment variables' do
      jq('.spec.template.spec.containers[0].envFrom', resource('Deployment')).must_equal([{ 'secretRef' => { 'name' => 'web-secrets' } }])
    end

    it 'adds a annotations with checksum of secrets' do
      jq('.spec.template.metadata.annotations."checksum/secrets"', resource('Deployment')).must_equal('4951f9bfd8a2ab4dfaa5bb379ef28d4816c9048f58f41d853de2ee5f4f1bf428')
    end
  end
end

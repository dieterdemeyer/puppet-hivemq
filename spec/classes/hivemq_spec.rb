#!/usr/bin/env rspec

require 'spec_helper'

describe 'hivemq' do
  let(:params) { { :version => '2.1.0-1.cgk.el6' } }
  it { should contain_class 'hivemq' }
end

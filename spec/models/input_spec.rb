# encoding: utf-8

require 'spec_helper'

describe Input do

    before do
        @input = Input.new
    end

    subject { @input }

    it { should respond_to(:text) }
    it { should respond_to(:type) }
    it { should respond_to(:date) }
    it { should respond_to(:institution) }
    it { should respond_to(:subtype) }
    it { should respond_to(:status) }
    it { should respond_to(:user_id) }

    pending "temos que testar se para cada subtype de Input os attr_accessible estão corretos e protegidos contra mass assignment"

end

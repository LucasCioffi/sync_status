require 'rails_helper'

class DummyService < ApplicationService
  def call
    # Dummy implementation for testing
    @result = "Success"
  end
end

RSpec.describe ApplicationService do
  describe '.call' do
    it 'initializes an instance and calls constructor' do
      service_instance = DummyService.call
      expect(service_instance.result).to eq("Success")
    end
  end

  describe '#success?' do
    context 'when there are no errors' do
      it 'returns true' do
        service_instance = DummyService.call
        expect(service_instance.success?).to be_truthy
      end
    end

    context 'when there are errors' do
      it 'returns false' do
        allow_any_instance_of(ApplicationService).to receive_message_chain(:errors, :any?).and_return(true)
        service_instance = DummyService.call
        expect(service_instance.success?).to be_falsy
      end
    end
  end

  describe '#failure?' do
    context 'when there are no errors' do
      it 'returns false' do
        service_instance = DummyService.call
        expect(service_instance.failure?).to be_falsy
      end
    end

    context 'when there are errors' do
      it 'returns true' do
        allow_any_instance_of(ApplicationService).to receive_message_chain(:errors, :any?).and_return(true)
        service_instance = DummyService.call
        expect(service_instance.failure?).to be_truthy
      end
    end
  end

  describe '#call' do
    it 'raises NotImplementedError' do
      expect { ApplicationService.new.call }.to raise_error(NotImplementedError)
    end
  end
end

require 'rails_helper'

RSpec.describe PropertiesController, type: :request do
  describe '#index' do
    let(:page) { 3 }
    let(:size) { 7 }
    
    context 'when page 1 size 5' do
      let(:page) { 1 }
      let(:size) { 5 }

      before do
        puts "abc"
      end

      it 'returns first page response with 5 entries' do
        page
        size  
      end

      it 'returns first page response with 5 entries' do
        page
        size  
      end
    end

    context 'when page 2 size 10' do
      let(:page) { 2 }
      let(:size) { 10 }

      before do
        
      end

      it 'returns second page response with 10 entries' do
        page 
        size
      end

      it 'returns second page response with 10 entries' do
        page 
        size
      end
    end
  end

  describe '#new' do
    
  end

  describe '#show' do
    
  end
  
  describe '#edit' do
    
  end

  describe '#create' do
    
  end

  describe '#update' do
    
  end

  describe '#destroy' do
    
  end
end

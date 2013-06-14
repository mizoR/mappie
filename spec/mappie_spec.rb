# -*- coding: utf-8 -*-
require 'spec_helper'

describe Mappie do

  class Blog
    attr_accessor :body, :category_id

    include Mappie

    mappie :category

    def initialize(params={})
      @body        = params[:body]
      @category_id = params[:category_id]
    end
  end

  class Category
    attr_accessor :id, :name

    def initialize(params={})
      @id   = params[:id]
      @name = params[:name]
    end

    class << self
      include Enumerable

      def each
        @_categories.each do |category|
          yield category
        end
      end
    end

    # @categories = [
    #   <Category :id=>1, :name=>"A">,
    #   <Category :id=>2, :name=>"B">,
    #   <Category :id=>3, :name=>"C">,
    #   <Category :id=>4, :name=>"D">
    # ]
    @_categories = %w(A B C D).map.with_index do |name, i|
      Category.new(:id => i + 1, :name => name)
    end
  end

  describe do
    it do
      blog = Blog.new(:body => 'Foo', :category_id => 3)
      expect(blog.category).to be_a(Category)
      expect(blog.category.id).to eql(3)
      expect(blog.category.name).to eql('C')
    end

    it do
      blog = Blog.new(:body => 'Baz', :category_id => 0)
      expect(blog.category).to be_nil
    end
  end
end

# Mappie

TODO: Write a gem description

## Usage

```
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

  blog = Blog.new(
    :body => 'Foo',
    :category_id => 3
  )
  blog.category   #=> <Category :body=>'Foo', :category_id=>3>
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

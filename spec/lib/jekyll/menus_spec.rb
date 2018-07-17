require 'jekyll'
require 'jekyll/menus'

RSpec.describe Jekyll::Menus, 'basic functionality' do
    before(:each) do
        @site = double("Jekyll Site", :data => {}, :pages => [], :collections => [])
    end

    it 'should be constructible' do
        menus = Jekyll::Menus.new(@site)

        expect(menus).not_to be_nil
    end

    describe 'data menus' do
        it 'should compile the menus in the data' do
            data_menu = {
                header: {
                    url: '/api',
                    title: 'API Documentation',
                    identifier: 'api'
                }
            }
            jekyll_menus = {
                :header => [{
                    :url=>"/api",
                    :title=>"API Documentation",
                    :identifier=>"api", "weight"=>-1,
                    "_frontmatter"=>false
                }]
            }
            @site.data["menus"] = data_menu

            menus = Jekyll::Menus.new(@site)

            expect(menus.menus).to eq(jekyll_menus)
        end
    end

    describe 'frontmatter menus' do

        describe 'in pages' do
            it 'should build a menu defined in the frontmatter' do
                page_with_menu_definition = double(
                    :data => {
                        'menus' => {
                            'header' => {
                                '_frontmatter' => '',
                                'identifier' => 'header',
                                'title' => 'A Menu',
                                'url' => 'www.example.com',
                                'weight' => nil
                            }}},
                    :relative_path => nil
                )
                @site.pages << page_with_menu_definition
                jekyll_menus = {"header" => [{
                    "_frontmatter" => nil,
                    "identifier" => "header",
                    "title" => "A Menu",
                    "url" => "www.example.com",
                    "weight" => -1
                }]}

                menus = Jekyll::Menus.new(@site)

                expect(menus.menus).to eq(jekyll_menus)
            end

            it 'should build defaults from the page when they are not specified in the frontmatter' do
                page_with_menu_reference = double(
                    :data => {'menus' => ['main'], 'ext' => 'ext'}, 
                    :url => 'www.example.com', 
                    :path => 'path', 
                    :relative_path => 'relpath'
                )
                @site.pages << page_with_menu_reference
                jekyll_menus = {"main" => [{
                    "url"=>"www.example.com",
                    "identifier"=>"path",
                    "_frontmatter"=>"relpath",
                    "title"=>nil,
                    "weight"=>-1
                }]}

                menus = Jekyll::Menus.new(@site)

                expect(menus.menus).to eq(jekyll_menus)
            end
        end

        describe 'in collections' do
            it 'should build a menu defined in the frontmatter of member pages' do
                page_with_menu_definition = double(
                    :data => {
                        'menus' => {
                            'header' => {
                                '_frontmatter' => '',
                                'identifier' => 'header',
                                'title' => 'A Menu',
                                'url' => 'www.example.com',
                                'weight' => nil
                    }}},
                    :relative_path => nil
                )
                @site = double("Jekyll Site", 
                    :data => {}, 
                    :pages => [], 
                    :collections => [ [ "name", double(:docs => [page_with_menu_definition]) ] ]
                )

                jekyll_menus = {"header" => [{
                    "_frontmatter" => nil,
                    "identifier" => "header",
                    "title" => "A Menu",
                    "url" => "www.example.com",
                    "weight" => -1
                }]}

                menus = Jekyll::Menus.new(@site)

                expect(menus.menus).to eq(jekyll_menus)
            end

            it 'should build defaults from the page when they are not specified in the frontmatter' do
                page_with_menu_reference = double(
                    :data => {'menus' => ['main'], 'ext' => 'ext'}, 
                    :url => 'www.example.com', 
                    :path => 'path', 
                    :relative_path => 'relpath'
                )
                @site = double("Jekyll Site", 
                    :data => {}, 
                    :pages => [], 
                    :collections => [ [ "name", double(:docs => [page_with_menu_reference]) ] ]
                )

                jekyll_menus = {"main" => [{
                    "url"=>"www.example.com",
                    "identifier"=>"path",
                    "_frontmatter"=>"relpath",
                    "title"=>nil,
                    "weight"=>-1
                }]}

                menus = Jekyll::Menus.new(@site)

                expect(menus.menus).to eq(jekyll_menus)
            end
        end
    end
end

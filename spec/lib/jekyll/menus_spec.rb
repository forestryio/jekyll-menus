require 'jekyll'
require 'jekyll/menus'

RSpec.describe Jekyll::Menus, 'basic functionality' do
    before(:each) do
        @site = double('Jekyll Site', :data => {}, :pages => [], :collections => [])
    end

    it 'should be constructible' do
        menus = Jekyll::Menus.new(@site)

        expect(menus).not_to be_nil
    end

    describe 'data menus' do
        it 'should compile the menus in the data' do
            data_menu = {
                'header' => {
                    'url' => 'www.example.com',
                    'title' => 'A Menu',
                    'identifier' => 'header'
                }
            }
            jekyll_menus = {
                'header' => [{
                    'url' => 'www.example.com',
                    'title' => 'A Menu',
                    'identifier' => 'header',
                    'weight' => -1,
                    '_frontmatter' => false
                }]
            }
            @site.data['menus'] = data_menu

            menus = Jekyll::Menus.new(@site)

            expect(menus.menus).to eq(jekyll_menus)
        end
    end

    describe 'frontmatter menus' do

        def page_with_menu_definition
            double(
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
        end

        def page_with_menu_reference 
            double(
                :data => {'menus' => ['header'], 'ext' => 'ext'}, 
                :url => 'www.example.com', 
                :path => 'path', 
                :relative_path => 'relpath'
            )
        end

        def expected_well_defined_menu_output
            { 
                'header' => [{
                    '_frontmatter' => nil,
                    'identifier' => 'header',
                    'title' => 'A Menu',
                    'url' => 'www.example.com',
                    'weight' => -1
                }]
            }
        end

        def expected_default_menu_output
            {
                'header' => [{
                    'url' => 'www.example.com',
                    'identifier' => 'path',
                    '_frontmatter' => 'relpath',
                    'title' => nil,
                    'weight' => -1
                }]
            }
        end

        describe 'in pages' do
            it 'should build a menu defined in the frontmatter' do
                @site.pages << page_with_menu_definition
                

                menus = Jekyll::Menus.new(@site)

                expect(menus.menus).to eq(expected_well_defined_menu_output)
            end

            it 'should build defaults from the page when they are not specified in the frontmatter' do
                @site.pages << page_with_menu_reference

                menus = Jekyll::Menus.new(@site)

                expect(menus.menus).to eq(expected_default_menu_output)
            end
        end

        describe 'in collections' do
            it 'should build a menu defined in the frontmatter of member pages' do
                @site.collections << [ 'name', double(:docs => [ page_with_menu_definition ]) ]

                menus = Jekyll::Menus.new(@site)

                expect(menus.menus).to eq(expected_well_defined_menu_output)
            end

            it 'should build defaults from the page when they are not specified in the frontmatter' do
                @site.collections << [ 'name', double(:docs => [ page_with_menu_reference ]) ]

                menus = Jekyll::Menus.new(@site)

                expect(menus.menus).to eq(expected_default_menu_output)
            end
        end
    end
end

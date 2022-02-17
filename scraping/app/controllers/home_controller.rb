class HomeController < ApplicationController
  def teste
    import_data_from_site_target
  end
  def import_data_from_site_target

    agent = Mechanize.new
    page = agent.get('http://localhost:3000')
    login_form = page.form
    login_form.field_with(name: 'user[email]').value = 'example@example.com'
    login_form.field_with(name: 'user[password]').value = '123456'
    product_list_page = agent.submit(login_form)
    @product_list_page=product_list_page
    creat_document product_list_page

  end

  def creat_document product_list_page
    # Cria um novo arquivo para guardar a lista de produtos
    out_file = File.new('product_list.txt', 'w')
    out_file.puts 'Product List:'
    # Realiza o looping para pegar todas as paginas de produtos
    loop do
      # Pega todas as linhas de produtos
      product_list_page.search('tbody tr').each do |p|
        # Extrai as colunas dos produtos, organiza e escreve no arquivo
        f = p.search('td')
        line = "title: #{f[0].text}, "
        line += "brand: #{f[1].text}, "
        line += "description: #{f[2].text}, "
        line += "price: #{f[3].text}"
        out_file.puts line
      end

      # Se nao tiverem mais paginas para serem extraidas ele para o looping
      break unless product_list_page.link_with(text: 'Next ›')

      # Pula de pagina
      product_list_page = product_list_page.link_with(text: 'Next ›').click
    end
    out_file.close
  end
end

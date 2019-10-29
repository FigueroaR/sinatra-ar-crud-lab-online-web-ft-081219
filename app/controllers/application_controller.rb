
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  get '/articles' do
    @articles = Article.all
    #binding.pry
    erb :index
  end

  get '/articles/new' do 
    #binding.pry
    erb :new 
  end 

  get '/articles/:id' do
      @article = Article.find_by(params[:id])
      #@article = Article.find_by(id:params[:id])      
      #binding.pry
      if @article 
        erb :show
      else 
        redirect '/articles'
      end
      
  end

  get '/articles/:id/edit' do
    
    @article = Article.find_by(params[:id])
    erb :edit
  end

  patch '/articles/:id' do 
    binding.pry
    @article = Article.find_by(params[:id])
    if @article.update(params[:article])
      redirect "/articles/#{@article.id}"
    else
      redirect "/articles/#{@article.id}/edit"
    end
    
    
  end

  post '/articles' do
    #binding.pry
    @article = Article.new(params)
    if @article.save
      redirect "/articles/#{@article.id}"
    else
      redirect 'articles/new'
    end
    
  end


  
end

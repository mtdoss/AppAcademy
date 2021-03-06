class PostsController < ApplicationController
  before_action :must_be_post_author, only: [:edit, :update]
  
  def new
    @post = Post.new
    @post.sub_id = params[:sub_id]
    @subs = Sub.all
      # @sub = Sub.find(params[:sub][:id])
  end
  
  def create
    @post = Post.new(post_params)
    
    if @post.save
      redirect_to post_url(@post) 
    else
      flash.now[:errors] = @post.errors.full_messages
      @post = Post.new
      render :new
    end
  end
  
  def edit
    @post = Post.find(params[:id])
    @post.sub_id = params[:sub_id]
    @subs = Sub.all
    # @sub = Sub.find(params[:sub][:id])
  end
  
  def update
    @post = Post.find(params[:id])
    
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      @post = Post.find(params[:id])
      render :edit
    end
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  
  private
  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_id, :author_id)
  end
  
  def must_be_post_author
    @post = Post.find(params[:id])
    unless @post.author_id == current_user.id
      flash[:errors] = ["Can't edit someone else's post"]
      redirect_to sub_url(@post.sub)
    end
  end
end

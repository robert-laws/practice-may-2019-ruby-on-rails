class DemoController < ApplicationController

  layout 'application'

  def index
    @id_values = [1, 2, 3, 4, 5]
    @greeting = "Howdy '' everyone!!"
  end

  def hello
    # instance variables are available to the view
    @array = ["bob", "hal", "gil", "kal"]
    @id = params['id']
    @page = params[:page]
    render 'demo/hello'
    # render 'hello' -> implicit use of 
    # can use render 'hello'
  end

  def other_hello
    # redirect to different controller action & view template
    redirect_to(controller: 'demo', action: 'hello')
  end

  def lynda
    # redirect to an external url
    redirect_to 'https://www.lynda.com'
  end

  def escape_output
    
  end
end

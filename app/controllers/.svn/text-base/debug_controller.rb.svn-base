class DebugController < ApplicationController

  def index
    render :text => %Q(
      <pre>
      #{session.to_yaml} 
      #{cookies.to_yaml}
      </pre>
    )
  end
  
end

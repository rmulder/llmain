class TransactionTermsController < ApplicationController
  # GET /transaction_terms
  # GET /transaction_terms.xml
  def index
    @transaction_terms = TransactionTerm.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @transaction_terms }
    end
  end

  # GET /transaction_terms/1
  # GET /transaction_terms/1.xml
  def show
    @transaction_term = TransactionTerm.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @transaction_term }
    end
  end

  # GET /transaction_terms/new
  # GET /transaction_terms/new.xml
  def new
    @transaction_term = TransactionTerm.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @transaction_term }
    end
  end

  # GET /transaction_terms/1/edit
  def edit
    @transaction_term = TransactionTerm.find(params[:id])
  end

  # POST /transaction_terms
  # POST /transaction_terms.xml
  def create
    @transaction_term = TransactionTerm.new(params[:transaction_term])

    respond_to do |format|
      if @transaction_term.save
        format.html { redirect_to(@transaction_term, :notice => 'Transaction terms was successfully created.') }
        format.xml  { render :xml => @transaction_term, :status => :created, :location => @transaction_term }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @transaction_term.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /transaction_terms/1
  # PUT /transaction_terms/1.xml
  def update
    @transaction_term = TransactionTerm.find(params[:id])

    respond_to do |format|
      if @transaction_term.update_attributes(params[:transaction_term])
        format.html { redirect_to(@transaction_term, :notice => 'Transaction terms was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @transaction_term.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /transaction_terms/1
  # DELETE /transaction_terms/1.xml
  def destroy
    @transaction_term = TransactionTerm.find(params[:id])
    @transaction_term.destroy

    respond_to do |format|
      format.html { redirect_to(transaction_terms_index_url) }
      format.xml  { head :ok }
    end
  end
end

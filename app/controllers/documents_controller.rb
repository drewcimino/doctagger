class DocumentsController < ApplicationController
  def index
    @documents    = Document.order(created_at: :desc).all
    @new_document = Document.new
  end

  def create
    @document = Document.new(document_params)

    respond_to do |format|
      if @document.save
        format.html { redirect_to :back, notice: 'Document was successfully created.' }
      else
        format.html { redirect_to :back, alert: 'There was a problem creating your document.' }
      end
    end
  end

  def destroy
    Document.find(params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to :back, notice: 'Document was successfully destroyed.' }
    end
  end

  private

  def document_params
    params.require(:document).permit(:provided_tags, :content)
  end
end

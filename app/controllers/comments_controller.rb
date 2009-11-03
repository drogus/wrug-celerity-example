class CommentsController < ApplicationController
  resource_controller
  belongs_to :post

  create.wants.html { redirect_to smart_url(parent_url_options) }
  create.wants.js { flash[:success] = nil }
  update.wants.html { redirect_to smart_url(parent_url_options) }
  destroy.wants.html { redirect_to smart_url(parent_url_options) }
end

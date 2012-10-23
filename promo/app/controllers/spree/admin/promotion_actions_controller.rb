class Spree::Admin::PromotionActionsController < Spree::Admin::BaseController
  def create
    @calculators = Spree::Promotion::Actions::CreateAdjustment.calculators
    @promotion = Spree::Promotion.find(params[:promotion_id])
    @promotion_action = params[:action_type].constantize.new(params[:promotion_action])
    @promotion_action.promotion = @promotion

    result = @promotion_action.save
    if result
      flash.notice = I18n.t(:successfully_created, :resource => I18n.t(:promotion_action))
    end

    respond_to do |format|
      format.html { redirect_to spree.edit_admin_promotion_path(@promotion)}
      format.js do
        unless result
          render 'failed', :layout => false
        else
          render :layout => false
        end
      end
    end
  end

  def destroy
    @promotion = Spree::Promotion.find(params[:promotion_id])
    @promotion_action = @promotion.promotion_actions.find(params[:id])

    result = @promotion_action.destroy
    if result
      flash.notice = I18n.t(:successfully_removed, :resource => I18n.t(:promotion_action))
    end

    respond_to do |format|
      format.html { redirect_to spree.edit_admin_promotion_path(@promotion)}
      format.js do
        unless result
          render 'failed', :layout => false
        else
          render :layout => false
        end
      end
    end
  end
end

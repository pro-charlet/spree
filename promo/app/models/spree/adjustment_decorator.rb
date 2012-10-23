module Spree
  Adjustment.class_eval do
    scope :promotion, where(:originator_type => 'Spree::PromotionAction')

    scope :from_promotion_action, lambda { |action|
      adj_tbl = Adjustment.table_name
      pa_tbl  = PromotionAction.table_name

      joins(%Q{
        INNER JOIN #{pa_tbl}
           ON #{adj_tbl}.originator_type = 'Spree::PromotionAction' AND
              #{adj_tbl}.originator_id = #{pa_tbl}.id}).
      where("#{pa_tbl}.type" => action.class.name,
            "#{pa_tbl}.id"   => action.id)
    }
  end
end

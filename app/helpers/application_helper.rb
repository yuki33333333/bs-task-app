module ApplicationHelper
  def sort_option
    [ ['作成日が新しい順', 'new_create_date'], ['終了期限が古い順', 'old_limit_date'] ]
  end
end

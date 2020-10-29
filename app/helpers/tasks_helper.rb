module TasksHelper
  SORT_OPTION_ARRAY = ['new_create_date', 'old_limit_date']

  def sort_option
    [ ['新着順', SORT_OPTION_ARRAY[0]], ['終了期限が古い順', SORT_OPTION_ARRAY[1]] ]
  end
end

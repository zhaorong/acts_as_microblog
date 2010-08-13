module ActsAsMicroblogsHelper
  # 如果Rails.configuration.cache_classes==false,则每次请求加载所有模型类
  unless Rails.configuration.cache_classes
    require File.dirname(__FILE__) + '/../../require_all'
    require_all RAILS_ROOT + '/app/models'
  end
end

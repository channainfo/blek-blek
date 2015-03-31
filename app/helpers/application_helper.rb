module ApplicationHelper
  def page_title(title)
    content_for(:title) { title + " - " + ENV['APP_NAME'] }
  end

  def index_in_paginate(index)
    page = params[:page].to_i
    offset_page = page > 1 ? page - 1 : 0
    index + Kaminari.config.default_per_page * offset_page
  end

  def page_header title, options={},  &block
     content_tag :div,:class => "action-header clearfix" do
        if block_given? 
          content_title = content_tag :div, :class => "pull-left" do
            content_tag(:h3, title, :class => "header-title")
          end

          output = with_output_buffer(&block)
          content_link = content_tag(:div, output, {:class => "pull-right"})
          content_title + content_link
        else
          content_tag(:h3, title, :class => "header-title")
        end
     end
  end

  def input_row options={}, &block
    options[:class] = "#{options[:class]} input-row"
    content_tag :div, with_output_buffer(&block), options
  end

  def breadcrumb_admin(options=nil)
    breadcrumb_create options, "Home", admin_root_url
  end

  def breadcrumb(options=nil)
    breadcrumb_create options, "Home", root_url
  end

  def breadcrumb_create options, home_text, home_url
    content_tag(:ul, breadcrumb_str(options, home_text, home_url), :class => "breadcrumb")
  end

  def breadcrumb_str options, home_text, home_url
    items = []
    char_sep = " ".html_safe
    if options.blank?
      icon = content_tag "i", " ", :class => "icon-user  icon-home"
      items << content_tag(:li, icon + home_text , :class => "active")
    else
      items <<  content_tag(:li , :class => "active") do
        link_to(home_text, home_url ) + content_tag(:span, char_sep, :class => "divider")
      end

      options.each do |option|
        option.each do |key, value|
          if value
          items << content_tag(:li) do
            link_to(key, value) + content_tag(:span, char_sep, :class => "divider")
          end 
          else
            items << content_tag(:li, key, :class =>"active") 
          end
        end
      end 
    end
    items.join("").html_safe
  end

  def errors_for(record)
    content_tag :ul, class: 'record-error' do 
      result = ""
      record.errors.full_messages.each do |message|
        result += content_tag('li', message, class: 'record-error-field')
      end
      result.html_safe
    end
  end

  def flash_config
    config = {key: '', value: ''}
    flash.map do |key, value|
      config[:key] = key
      config[:value] = value
    end
    config
  end

  def notification_box
    content_tag :div, '', id: 'notification'
  end

  def flash_messages

    trans = { 'alert' => 'alert-danger', 'notice' => 'alert alert-success' }

    content_tag :div, class: 'notification' do
      flash.map do |key, value|
        content_tag 'div', value, class: "alert #{trans[key]} alert-body"
      end.join('.').html_safe
    end
  end

  def active_index active
    active ? ' active ' : ''
  end

  def boolean_word bool_value
    if bool_value
      "<i style='color:green; font-size: 120%;' class='glyphicon glyphicon-ok-circle'> </i>".html_safe
    else
      "<i style='color:red; font-size: 120%;' class='glyphicon glyphicon-remove-circle'> </i>".html_safe
    end
  end
end

class CategoriesDatatable < ApplicationDatatable
  delegate :edit_admins_category_path, to: :@view

  private

  def data
    categories.all.map do |record|
      [].tap do |column|
        column << record.title
        column << "#{record.status} <i class='fa #{Settings.category.status[record.status]} status'></i>"
        column << record.topics.size
        column << record.posts.size
        column << record.total_views
        column << record.morderators.size
        column << record.posts.where(status: :uncheck).size
        column << record.users.size

        links = []
        links << link_to("Xem", [:admins, record])
        links << link_to("Sửa", edit_admins_category_path(record))
        links << link_to("Xóa", [:admins, record], method: :delete, data: { confirm: "Bạn chắc chứ?" }, class: "link-remote", id: "delete-#{record.id}", remote: true)
        column << links.join(" | ")
      end
    end
  end

  def count
    Category.count
  end

  def total_entries
    categories.total_count
  end

  def categories
    @categories ||= fetch_categories
  end

  def fetch_categories
    search_string = []
    columns.each do |term|
      search_string << "#{term} like :search"
    end

    categories = Category.includes(:morderators, :topics, :posts, :users ).order("#{sort_column} #{sort_direction}")
    categories = categories.page(page).per(per_page)
    categories = categories.where(search_string.join(" or "), search: "%#{params[:search][:value]}%")
  end

  def columns
    %w(title status)
  end
end

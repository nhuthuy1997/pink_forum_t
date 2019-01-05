class TopicsDatatable < ApplicationDatatable
  delegate :edit_admins_topic_path, to: :@view

  private

  def data
    topics.all.map do |record|
      [].tap do |column|
        column << record.title
        column << "#{record.status} <i class='fa #{Settings.topic.status[record.status]} status'></i>"
        column << record.category.title
        column << record.posts.size
        column << record.posts.where(status: :uncheck).size
        column << record.users.size

        links = []
        links << link_to("Xem", [:admins, record])
        links << link_to("Sửa", edit_admins_topic_path(record))
        links << link_to("Xóa", [:admins, record], method: :delete, data: { confirm: "Bạn chắc chứ?" }, class: "link-remote", id: "delete-#{record.id}", remote: true)
        column << links.join(" | ")
      end
    end
  end

  def count
    Topic.count
  end

  def total_entries
    topics.total_count
  end

  def topics
    @topics ||= fetch_topics
  end

  def fetch_topics
    search_string = []
    columns.each do |term|
      search_string << "#{term} like :search"
    end

    topics = Topic.includes(:category, :posts, :user, :topic_bannings, users: :topic_bannings).order("#{sort_column} #{sort_direction}")
    topics = topics.page(page).per(per_page)
    topics = topics.where(search_string.join(" or "), search: "%#{params[:search][:value]}%")
  end

  def columns
    %w(title status category_id)
  end
end

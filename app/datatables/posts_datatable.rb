class PostsDatatable < ApplicationDatatable
  delegate :admins_post_path, to: :@view

  private

  def data
    posts.all.map do |record|
      [].tap do |column|
        column << record.title
        column << "#{record.status} <i class='fa #{Settings.post.status[record.status]} status'></i>"
        column << record.author.name
        column << record.views
        column << record.topic.title
        column << record.category.title
        column << record.total_votes
        column << record.comments.size
        column << record.created_at.strftime(Settings.post.time_format)

        links = []
        links << link_to("Xem", [:admins, record])

        if record.uncheck?
          links << link_to("Duyệt", admins_post_path(record, accept: 1), class: "link-remote", id: "update-#{record.id}", method: :patch, remote: true)
          links << link_to("Không duyệt", admins_post_path(record, accept: 0), class: "link-remote", id: "update-#{record.id}", method: :patch, remote: true)
        else
          links << link_to((record.publish? ? "Không duyệt" : "Duyệt"), admins_post_path(record, accept: record.publish? ? 0 : 1), class: "link-remote", id: "update-#{record.id}", method: :patch, remote: true)
        end
        links << link_to("Xóa", [:admins, record], method: :delete, data: { confirm: "Bạn chắc chứ?" }, class: "link-remote", id: "delete-#{record.id}", remote: true)
        column << links.join(" | ")
      end
    end
  end

  def count
    Post.count
  end

  def total_entries
    posts.total_count
  end

  def posts
    @posts ||= fetch_posts
  end

  def fetch_posts
    search_string = []
    columns.each do |term|
      search_string << "#{term} like :search"
    end

    posts = Post.includes(:topic, :votes, :comments, :author, topic: :category).where.not(status: :draft).order("#{sort_column} #{sort_direction}")
    posts = posts.page(page).per(per_page)
    posts = posts.where(search_string.join(" or "), search: "%#{params[:search][:value]}%")
  end

  def columns
    %w(title status user_id views topic_id)
  end
end

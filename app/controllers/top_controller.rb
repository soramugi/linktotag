class TopController < ApplicationController
  before_action :set_link_url, only: [:tag]

  def index
  end

  def tag
    type = params[:type] || 'tag'

    html = open(@link_uri.to_s).read
    body, title = ExtractContent.analyse(html)

    imgsrc = html_to_imgsrc(body.empty? ? html : body)
    link_text = ''
    link_text = view_context.image_tag(imgsrc) + view_context.raw('<br />') unless imgsrc.nil?
    link_text += title

    render text: view_context.link_to(
      link_text,
      @link_uri.to_s
    )
  end

  private
  def set_link_url
    @link_uri = URI.parse(expand_url(params[:link]))
  end

  def expand_url(url)
    uri = url.kind_of?(URI) ? url : URI.parse(url)
    Net::HTTP.start(uri.host, uri.port) do |io|
      r = io.head(uri.path)
      r['Location'] || uri.to_s
    end
  end

  def html_to_imgsrc(html)
    doc = Nokogiri::HTML(html)
    doc.css('img').first.attribute('src').value
  rescue
  end
end

require 'rails_helper'

RSpec.describe Article, type: :model do
  current_user = User.first_or_create!(email: 'test@example.com', password: 'password', password_confirmation: 'password')

  it "Empty article is invalid" do
    article = Article.new
    expect(article).to be_invalid
  end

  it "Invalid article without title" do
    article = Article.new(
      title: nil,
      body: 'test body'
    )
    expect(article).to be_invalid
  end

  it "Valid article with title" do
    article = Article.new(
      title: 'test title',
      body: 'test body'
    )
    expect(article).to be_valid
  end

  it "Generated article URL" do
    article = Article.new(
      title: 'test title url',
      body: 'test body'
    )
    expect(article.url).to_not be_empty
  end

  it "Truncated article short body" do
    short_body_177 = "Donate: If you use this site regularly and would like to help keep the site on the Internet, please consider donating a small sum to help pay for the hosting and bandwidth bill."

    article = Article.new(
      title: 'test title short_body',
      short_body: short_body_177
    )

    expect(short_body_177.length > Article::SHOR_BODY_LENGTH).to be(true)
    expect(article.short_body.length).to be(Article::SHOR_BODY_LENGTH)
  end
end

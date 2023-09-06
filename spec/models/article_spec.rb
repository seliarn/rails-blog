require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:current_user) { create(:user) }
  let(:short_body_177) { "Donate: If you use this site regularly and would like to help keep the site on the Internet, please consider donating a small sum to help pay for the hosting and bandwidth bill." }

  it "Empty article is invalid" do
    article = Article.new
    expect(article).to be_invalid
  end

  it "Invalid article without author" do
    article = Article.new(
      title: 'article without author',
      body: 'test body'
    )
    expect(article).to be_invalid
  end

  it "Invalid article without title" do
    article = current_user.articles.new(
      title: nil,
      body: 'test body'
    )
    expect(article).to be_invalid
  end

  it "Valid article" do
    article = current_user.articles.new(
      title: 'test title',
      body: 'test body'
    )
    expect(article).to be_valid
  end

  it "Generated article URL" do
    article = current_user.articles.new(
      title: 'test title url',
      body: 'test body'
    )
    expect(article.url).to_not be_empty
  end

  it "Article short body is too long" do
    article = current_user.articles.new(
      title: 'test title short_body',
      short_body: short_body_177
    )

    expect(article.short_body.length > Article::SHOR_BODY_LENGTH).to be(true)
    expect(article).to be_invalid
  end

  it "Article short body has valid length" do
    short_body_150 = short_body_177.truncate(Article::SHOR_BODY_LENGTH)

    article = current_user.articles.new(
      title: 'test title short_body',
      short_body: short_body_150
    )

    expect(article.short_body.length <= Article::SHOR_BODY_LENGTH).to be(true)
    expect(article).to be_valid
  end
end

# app/views/api/authors/_author.json.jbuilder
json.extract! author, :id, :name
json.url author_url(author, format: :json)


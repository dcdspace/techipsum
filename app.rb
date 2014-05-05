require 'sinatra'
require 'nokogiri'
require 'open-uri'
require './generator.rb'

#get list of random tech words to merge into paragraphs
page = Nokogiri::HTML(open('http://en.wikipedia.org/wiki/List_of_buzzwords?action=render'))
techArray = []
page.css('body > ul:nth-child(13) > li > a').each do |el|
  puts el.text
  techArray << el.text.downcase
end
#function to randomize array and merge arrays
def ordered_random_merge(a,b)
  a, b = a.dup, b.dup
  a.map{rand(b.size+1)}.sort.reverse.each do |index|
    b.insert(index, a.pop)
  end
  b
end
get '/generate' do
  redirect '/'
end
post '/generate' do
  randomArray = []
  wordinput = params[:randomwords]

  sentenceinput = params[:randomsentence]

#get tech pages from Wikipedia and mix them up into random sentences
  15.times do
    randomPage = Nokogiri::HTML(open('http://en.wikipedia.org/w/index.php?title=Special%3ARandomInCategory&category=technology'))
    randomPage.css('p').each do |el|
      el.text.split(/\W+/).each do |word|
        puts word
        randomArray << word.downcase
      end
      #puts el.text.split(/\W+/)
    end
  end
  techArray.inspect
  randomArray.inspect
  input = params[:words].to_i
  paras = params[:paragraphs].to_i
  if paras == 1
    @parastat = '1 paragraph'
  else
    @parastat = paras.to_s + ' paragraphs'
  end
  puts paras

  if (paras < 0 || paras > 12)
    paras = 10
  end


  newArray = ordered_random_merge(randomArray.shuffle, techArray.shuffle)
  @newArray = newArray.take(input)
  @finalArray = newArray.join(' ').squeeze(' ')
  paragraphs = @finalArray.split(/\s*?\r\s*/).map do |paragraph|
    puts paragraph.scan(/[[:alnum:]]+/).uniq
#@paragraphs = Generator.make_tech(5, 0, newArray)

    i = 0
    sentenceArray = []
    while i < newArray.count do
      if wordinput == 'static'
        wordNum = params[:words].to_i - 1
        @wordstat = params[:words]
      elsif wordinput == 'random'
        wordNum = rand(5..20)
        @wordstat = 'random # of'
      end
      sentence = newArray[i..i+wordNum].join(" ") + '. '
      sentenceArray << sentence.capitalize.gsub!(/^\"|\"?$/, '')
      i += wordNum+1
    end
    x = 0
    paragraphs = []
    while x < sentenceArray.count do
      if sentenceinput == 'static'
        sentenceNum = params[:sentences].to_i - 1
        @sentencestat = params[:sentences]
      elsif sentenceinput == 'random'
        sentenceNum = rand(10..25)
        @sentencestat = 'random # of'
      end
      paragraph = sentenceArray[x..x+sentenceNum]
      paragraphs << paragraph
      x += sentenceNum+1

    end
    puts paragraphs.inspect
    @paragraphs = paragraphs[0..paras-1]
    erb :main
  end
end

get '/' do

  erb :index
end
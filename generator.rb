require 'nokogiri'
require 'open-uri'
class Generator

  def Generator.make_sentence(words)
    sentence = ''
    length = rand(4..15)
    include_comma = false
    if (length >= 7 && rand(0..2) > 0)
      include_comma = true
    end

    if words.count >0
      words[0] = words[0].capitalize
      i = 0
      while i<length do
        if i > 0
          if (i >= 3 && i != length-1 && include_comma == true)
            if (rand(0..1) == 1)
              sentence = sentence.to_s.gsub('"', '') + ', '
              include_comma = false
            else
              sentence << ' '
            end
          else
            sentence << ' '
          end
          sentence << words[i].to_s.gsub('"', '')
        end
        sentence = sentence + '. '
        i += 1
      end
      sentence
    end
  end


  def Generator.make_paragraph (words)

    para = ''
    length = rand(4..7)
    i = 0

    while i<length do

      para << Generator.make_sentence(words) + ' '

      i += 1
    end

    para

  end

  def Generator.make_tech(num_pars = 5, num_sentence = 0, words)
    paragraphs = []
    if num_sentence > 0
      num_pars  = 1
    end


    i = 0

    while i<num_pars do
      if num_sentence > 0
        s = 0
        while s<num_sentence do
          words << Generator.make_sentence(words)
          s += 1
        end
      else
        words << Generator.make_paragraph(words)
      end

      paragraphs[i] = words
      i += 1
    end
  paragraphs
  end
end
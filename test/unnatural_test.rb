# coding: utf-8
require 'test_helper'

module Unnatural
  algorithms.each do |mod|
    describe mod do
      unicode_examples = [
        # examples from naturally gem
        # https://github.com/dogweather/naturally
        %w(АБ1 АБ2 АБ3 АБ4 АБ10 АБ12 АД5 АД8 АЩФ8 АЩФ12 ЫВА1),
        %w(2 3 4 5 10 11 12 12а 12б 12в 13а 13б)
      ]

      ascii_examples = [
        %w(a b),
        %w(a B),
        %w(a aa),
        %w(1 2),
        %w(2 10),
        %w(a2 a10),
        %w(1 1.1),
        %w(000a 0b),

        # examples from naturally gem
        # https://github.com/dogweather/naturally
        %w(676 676.1 676.2 676.3 676.9 676.10 676.11 676.12),
        %w(350 351 352 352.1 352.5 353.1 354 354.3 354.4 354.5 354.45),
        %w(7.1 7a),
        %w(335 335.1 336 336a 337 337.1 337.2 337.15 337a),
        %w(PBLI PC1 PC3 PC5 PC7 PC9 PC10 PC11 PC12 PC13 PC14 PROF2 SBP1 SBP3),
        %w(2 3 4 5 10 11 12 12a 12b 12c 13a 13b),
        %w(item_1 item_2 item_3 item_4 item_5 item_6 item_7 item_10 item_11),
        %w(1 2 3 a b c),
        %w(1 1.1 1.2 1.3 2 3 a a.1 a.2 a.3 b b.1 c),
        %w(1.1 1.a.1),
        %w(1a1 1aa aaa),

        # examples from naturalsort gem
        # https://github.com/johnnyshields/naturalsort
        %w(a1 a2 A3 a10 A11 a12 a21 A29),
        %w(a1 a2 a3 a10 a11 a12 a21 a29),
        %w(aaa aaa2 aaa3 aaa4),
        %w(A001 A003 A007 A08 A011 A20 A200),
        %w(x2-g8 x2-y7 x2-y08 x8-y8),
        %w(x02-g8 x2-y7 x02-y08 x8-y8),
        %w(img1.png img2.png img10.png img12.png)
      ]

      ascii_examples.each do |array|
        it "sorts ascii strings #{array.inspect}" do
          assert_equal array, mod.sort(array)
          assert_equal array, mod.sort(array.reverse)
          assert_equal array, mod.sort(array.shuffle)
        end
      end

      if RUBY_ENGINE == 'jruby'
        it "sorts unicode strings"
      else
        unicode_examples.each do |array|
          it "sorts unicode strings #{array.inspect}" do
            assert_equal array, mod.sort(array)
            assert_equal array, mod.sort(array.reverse)
            assert_equal array, mod.sort(array.shuffle)
          end
        end
      end
    end
  end
end

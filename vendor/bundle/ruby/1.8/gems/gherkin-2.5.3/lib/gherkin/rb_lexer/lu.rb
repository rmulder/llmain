
# line 1 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/lu.rb.rl"
require 'gherkin/lexer/i18n_lexer'

module Gherkin
  module RbLexer
    class Lu #:nodoc:
      
# line 123 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/lu.rb.rl"

 
      def initialize(listener)
        @listener = listener
        
# line 16 "lib/gherkin/rb_lexer/lu.rb"
class << self
	attr_accessor :_lexer_actions
	private :_lexer_actions, :_lexer_actions=
end
self._lexer_actions = [
	0, 1, 0, 1, 1, 1, 2, 1, 
	3, 1, 4, 1, 5, 1, 6, 1, 
	7, 1, 8, 1, 9, 1, 10, 1, 
	11, 1, 12, 1, 13, 1, 16, 1, 
	17, 1, 18, 1, 19, 1, 20, 1, 
	21, 1, 22, 1, 23, 2, 2, 18, 
	2, 3, 4, 2, 13, 0, 2, 14, 
	15, 2, 17, 0, 2, 17, 1, 2, 
	17, 16, 2, 17, 19, 2, 18, 6, 
	2, 18, 7, 2, 18, 8, 2, 18, 
	9, 2, 18, 10, 2, 18, 16, 2, 
	20, 21, 2, 22, 0, 2, 22, 1, 
	2, 22, 16, 2, 22, 19, 3, 4, 
	14, 15, 3, 5, 14, 15, 3, 11, 
	14, 15, 3, 12, 14, 15, 3, 13, 
	14, 15, 3, 14, 15, 18, 3, 17, 
	14, 15, 4, 2, 14, 15, 18, 4, 
	3, 4, 14, 15, 4, 17, 0, 14, 
	15
]

class << self
	attr_accessor :_lexer_key_offsets
	private :_lexer_key_offsets, :_lexer_key_offsets=
end
self._lexer_key_offsets = [
	0, 0, 21, 22, 23, 43, 44, 45, 
	47, 49, 54, 59, 64, 69, 73, 77, 
	79, 80, 81, 82, 83, 84, 85, 86, 
	87, 88, 89, 90, 91, 92, 93, 94, 
	95, 96, 98, 103, 110, 115, 116, 117, 
	118, 119, 120, 121, 122, 123, 124, 125, 
	126, 127, 134, 136, 138, 140, 142, 144, 
	146, 148, 150, 152, 154, 156, 158, 160, 
	162, 164, 166, 186, 187, 188, 189, 190, 
	191, 192, 193, 194, 195, 196, 197, 198, 
	199, 200, 201, 202, 203, 204, 216, 218, 
	220, 222, 224, 226, 228, 230, 232, 234, 
	236, 238, 240, 242, 244, 246, 248, 250, 
	252, 254, 256, 258, 260, 262, 264, 266, 
	268, 270, 272, 274, 276, 278, 280, 282, 
	284, 286, 288, 290, 292, 294, 296, 298, 
	300, 302, 304, 306, 308, 310, 312, 314, 
	316, 318, 320, 322, 324, 326, 328, 330, 
	332, 334, 336, 338, 340, 342, 344, 346, 
	348, 349, 350, 351, 352, 353, 354, 355, 
	356, 357, 358, 359, 360, 361, 377, 379, 
	381, 383, 385, 387, 389, 391, 393, 395, 
	397, 399, 401, 403, 405, 407, 409, 411, 
	413, 415, 417, 419, 421, 423, 425, 427, 
	429, 431, 433, 435, 437, 439, 441, 443, 
	445, 447, 449, 451, 453, 455, 457, 459, 
	461, 463, 465, 467, 469, 471, 473, 477, 
	479, 481, 483, 485, 487, 489, 491, 493, 
	495, 497, 499, 501, 503, 504, 505, 506, 
	507, 508, 509, 510, 511, 512, 513, 514, 
	515, 516, 517, 518, 519, 520, 521, 522, 
	523, 538, 540, 542, 544, 546, 548, 550, 
	552, 554, 556, 558, 560, 562, 564, 566, 
	568, 570, 572, 574, 576, 578, 580, 582, 
	584, 586, 588, 590, 592, 594, 596, 598, 
	600, 602, 604, 606, 608, 610, 612, 614, 
	618, 620, 622, 624, 626, 628, 630, 632, 
	634, 636, 638, 640, 642, 644, 645, 646, 
	647, 648, 649, 650, 651, 652, 653, 654, 
	671, 673, 675, 677, 679, 681, 683, 685, 
	687, 689, 691, 693, 695, 697, 699, 701, 
	703, 705, 707, 709, 711, 713, 715, 717, 
	719, 721, 723, 725, 727, 729, 731, 733, 
	735, 737, 739, 741, 743, 745, 747, 749, 
	751, 753, 755, 757, 759, 761, 763, 765, 
	767, 769, 771, 773, 775, 777, 779, 781, 
	783, 785, 787, 791, 793, 795, 797, 799, 
	801, 803, 805, 807, 809, 811, 813, 815, 
	817, 820, 821, 822, 823, 824, 825, 826, 
	827, 828, 829, 830, 831, 832, 833, 837, 
	843, 846, 848, 854, 874
]

class << self
	attr_accessor :_lexer_trans_keys
	private :_lexer_trans_keys, :_lexer_trans_keys=
end
self._lexer_trans_keys = [
	-17, 10, 32, 34, 35, 37, 42, 64, 
	66, 70, 72, 80, 83, 97, 100, 109, 
	117, 119, 124, 9, 13, -69, -65, 10, 
	32, 34, 35, 37, 42, 64, 66, 70, 
	72, 80, 83, 97, 100, 109, 117, 119, 
	124, 9, 13, 34, 34, 10, 13, 10, 
	13, 10, 32, 34, 9, 13, 10, 32, 
	34, 9, 13, 10, 32, 34, 9, 13, 
	10, 32, 34, 9, 13, 10, 32, 9, 
	13, 10, 32, 9, 13, 10, 13, 10, 
	95, 70, 69, 65, 84, 85, 82, 69, 
	95, 69, 78, 68, 95, 37, 32, 10, 
	10, 13, 13, 32, 64, 9, 10, 9, 
	10, 13, 32, 64, 11, 12, 10, 32, 
	64, 9, 13, 101, 105, 115, 112, 105, 
	108, 108, 101, 114, 58, 10, 10, 10, 
	32, 35, 70, 124, 9, 13, 10, 117, 
	10, 110, 10, 107, 10, 116, 10, 105, 
	10, 111, 10, 110, 10, 97, 10, 108, 
	10, 105, 10, 116, -61, 10, -87, 10, 
	10, 105, 10, 116, 10, 58, 10, 32, 
	34, 35, 37, 42, 64, 66, 70, 72, 
	80, 83, 97, 100, 109, 117, 119, 124, 
	9, 13, 117, 110, 107, 116, 105, 111, 
	110, 97, 108, 105, 116, -61, -87, 105, 
	116, 58, 10, 10, 10, 32, 35, 37, 
	64, 66, 70, 72, 80, 83, 9, 13, 
	10, 95, 10, 70, 10, 69, 10, 65, 
	10, 84, 10, 85, 10, 82, 10, 69, 
	10, 95, 10, 69, 10, 78, 10, 68, 
	10, 95, 10, 37, 10, 101, 10, 105, 
	10, 115, 10, 112, 10, 105, 10, 108, 
	10, 108, 10, 101, 10, 114, 10, 58, 
	10, 117, 10, 110, 10, 107, 10, 116, 
	10, 105, 10, 111, 10, 110, 10, 97, 
	10, 108, 10, 105, 10, 116, -61, 10, 
	-87, 10, 10, 105, 10, 116, 10, 97, 
	10, 110, 10, 110, 10, 101, 10, 114, 
	10, 103, 10, 114, 10, 111, 10, 110, 
	10, 100, 10, 108, 10, 97, 10, 110, 
	10, 103, 10, 32, 10, 118, 10, 117, 
	10, 109, 10, 32, 10, 83, 10, 122, 
	10, 101, 10, 110, 10, 97, 10, 114, 
	10, 105, 10, 111, 97, 110, 110, 101, 
	114, 103, 114, 111, 110, 100, 58, 10, 
	10, 10, 32, 35, 37, 42, 64, 70, 
	80, 83, 97, 100, 109, 117, 119, 9, 
	13, 10, 95, 10, 70, 10, 69, 10, 
	65, 10, 84, 10, 85, 10, 82, 10, 
	69, 10, 95, 10, 69, 10, 78, 10, 
	68, 10, 95, 10, 37, 10, 32, 10, 
	117, 10, 110, 10, 107, 10, 116, 10, 
	105, 10, 111, 10, 110, 10, 97, 10, 
	108, 10, 105, 10, 116, -61, 10, -87, 
	10, 10, 105, 10, 116, 10, 58, 10, 
	108, 10, 97, 10, 110, 10, 103, 10, 
	32, 10, 118, 10, 117, 10, 109, 10, 
	32, 10, 83, 10, 122, 10, 101, 10, 
	110, 10, 97, 10, 114, 10, 105, 10, 
	111, 10, 32, 110, 119, 10, 101, 10, 
	114, 10, 97, 10, 110, 10, 110, -61, 
	10, -92, 10, 10, 103, 10, 101, 10, 
	104, 10, 111, 10, 108, 10, 108, 108, 
	97, 110, 103, 32, 118, 117, 109, 32, 
	83, 122, 101, 110, 97, 114, 105, 111, 
	58, 10, 10, 10, 32, 35, 37, 42, 
	64, 70, 83, 97, 100, 109, 117, 119, 
	9, 13, 10, 95, 10, 70, 10, 69, 
	10, 65, 10, 84, 10, 85, 10, 82, 
	10, 69, 10, 95, 10, 69, 10, 78, 
	10, 68, 10, 95, 10, 37, 10, 32, 
	10, 117, 10, 110, 10, 107, 10, 116, 
	10, 105, 10, 111, 10, 110, 10, 97, 
	10, 108, 10, 105, 10, 116, -61, 10, 
	-87, 10, 10, 105, 10, 116, 10, 58, 
	10, 122, 10, 101, 10, 110, 10, 97, 
	10, 114, 10, 105, 10, 111, 10, 32, 
	110, 119, 10, 101, 10, 114, 10, 97, 
	10, 110, 10, 110, -61, 10, -92, 10, 
	10, 103, 10, 101, 10, 104, 10, 111, 
	10, 108, 10, 108, 122, 101, 110, 97, 
	114, 105, 111, 58, 10, 10, 10, 32, 
	35, 37, 42, 64, 70, 72, 80, 83, 
	97, 100, 109, 117, 119, 9, 13, 10, 
	95, 10, 70, 10, 69, 10, 65, 10, 
	84, 10, 85, 10, 82, 10, 69, 10, 
	95, 10, 69, 10, 78, 10, 68, 10, 
	95, 10, 37, 10, 32, 10, 117, 10, 
	110, 10, 107, 10, 116, 10, 105, 10, 
	111, 10, 110, 10, 97, 10, 108, 10, 
	105, 10, 116, -61, 10, -87, 10, 10, 
	105, 10, 116, 10, 58, 10, 97, 10, 
	110, 10, 110, 10, 101, 10, 114, 10, 
	103, 10, 114, 10, 111, 10, 110, 10, 
	100, 10, 108, 10, 97, 10, 110, 10, 
	103, 10, 32, 10, 118, 10, 117, 10, 
	109, 10, 32, 10, 83, 10, 122, 10, 
	101, 10, 110, 10, 97, 10, 114, 10, 
	105, 10, 111, 10, 32, 110, 119, 10, 
	101, 10, 114, 10, 97, 10, 110, 10, 
	110, -61, 10, -92, 10, 10, 103, 10, 
	101, 10, 104, 10, 111, 10, 108, 10, 
	108, 32, 110, 119, 101, 114, 97, 110, 
	110, -61, -92, 103, 101, 104, 111, 108, 
	108, 32, 124, 9, 13, 10, 32, 92, 
	124, 9, 13, 10, 92, 124, 10, 92, 
	10, 32, 92, 124, 9, 13, 10, 32, 
	34, 35, 37, 42, 64, 66, 70, 72, 
	80, 83, 97, 100, 109, 117, 119, 124, 
	9, 13, 0
]

class << self
	attr_accessor :_lexer_single_lengths
	private :_lexer_single_lengths, :_lexer_single_lengths=
end
self._lexer_single_lengths = [
	0, 19, 1, 1, 18, 1, 1, 2, 
	2, 3, 3, 3, 3, 2, 2, 2, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 2, 3, 5, 3, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 5, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 18, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 10, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 14, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 4, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	13, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 4, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 15, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 4, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	3, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 2, 4, 
	3, 2, 4, 18, 0
]

class << self
	attr_accessor :_lexer_range_lengths
	private :_lexer_range_lengths, :_lexer_range_lengths=
end
self._lexer_range_lengths = [
	0, 1, 0, 0, 1, 0, 0, 0, 
	0, 1, 1, 1, 1, 1, 1, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 1, 1, 1, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 1, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 1, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 1, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 1, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	1, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 1, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 1, 1, 
	0, 0, 1, 1, 0
]

class << self
	attr_accessor :_lexer_index_offsets
	private :_lexer_index_offsets, :_lexer_index_offsets=
end
self._lexer_index_offsets = [
	0, 0, 21, 23, 25, 45, 47, 49, 
	52, 55, 60, 65, 70, 75, 79, 83, 
	86, 88, 90, 92, 94, 96, 98, 100, 
	102, 104, 106, 108, 110, 112, 114, 116, 
	118, 120, 123, 128, 135, 140, 142, 144, 
	146, 148, 150, 152, 154, 156, 158, 160, 
	162, 164, 171, 174, 177, 180, 183, 186, 
	189, 192, 195, 198, 201, 204, 207, 210, 
	213, 216, 219, 239, 241, 243, 245, 247, 
	249, 251, 253, 255, 257, 259, 261, 263, 
	265, 267, 269, 271, 273, 275, 287, 290, 
	293, 296, 299, 302, 305, 308, 311, 314, 
	317, 320, 323, 326, 329, 332, 335, 338, 
	341, 344, 347, 350, 353, 356, 359, 362, 
	365, 368, 371, 374, 377, 380, 383, 386, 
	389, 392, 395, 398, 401, 404, 407, 410, 
	413, 416, 419, 422, 425, 428, 431, 434, 
	437, 440, 443, 446, 449, 452, 455, 458, 
	461, 464, 467, 470, 473, 476, 479, 482, 
	485, 487, 489, 491, 493, 495, 497, 499, 
	501, 503, 505, 507, 509, 511, 527, 530, 
	533, 536, 539, 542, 545, 548, 551, 554, 
	557, 560, 563, 566, 569, 572, 575, 578, 
	581, 584, 587, 590, 593, 596, 599, 602, 
	605, 608, 611, 614, 617, 620, 623, 626, 
	629, 632, 635, 638, 641, 644, 647, 650, 
	653, 656, 659, 662, 665, 668, 671, 676, 
	679, 682, 685, 688, 691, 694, 697, 700, 
	703, 706, 709, 712, 715, 717, 719, 721, 
	723, 725, 727, 729, 731, 733, 735, 737, 
	739, 741, 743, 745, 747, 749, 751, 753, 
	755, 770, 773, 776, 779, 782, 785, 788, 
	791, 794, 797, 800, 803, 806, 809, 812, 
	815, 818, 821, 824, 827, 830, 833, 836, 
	839, 842, 845, 848, 851, 854, 857, 860, 
	863, 866, 869, 872, 875, 878, 881, 884, 
	889, 892, 895, 898, 901, 904, 907, 910, 
	913, 916, 919, 922, 925, 928, 930, 932, 
	934, 936, 938, 940, 942, 944, 946, 948, 
	965, 968, 971, 974, 977, 980, 983, 986, 
	989, 992, 995, 998, 1001, 1004, 1007, 1010, 
	1013, 1016, 1019, 1022, 1025, 1028, 1031, 1034, 
	1037, 1040, 1043, 1046, 1049, 1052, 1055, 1058, 
	1061, 1064, 1067, 1070, 1073, 1076, 1079, 1082, 
	1085, 1088, 1091, 1094, 1097, 1100, 1103, 1106, 
	1109, 1112, 1115, 1118, 1121, 1124, 1127, 1130, 
	1133, 1136, 1139, 1144, 1147, 1150, 1153, 1156, 
	1159, 1162, 1165, 1168, 1171, 1174, 1177, 1180, 
	1183, 1187, 1189, 1191, 1193, 1195, 1197, 1199, 
	1201, 1203, 1205, 1207, 1209, 1211, 1213, 1217, 
	1223, 1227, 1230, 1236, 1256
]

class << self
	attr_accessor :_lexer_indicies
	private :_lexer_indicies, :_lexer_indicies=
end
self._lexer_indicies = [
	1, 3, 2, 4, 5, 6, 7, 8, 
	9, 10, 11, 12, 13, 14, 15, 16, 
	17, 15, 18, 2, 0, 19, 0, 2, 
	0, 3, 2, 4, 5, 6, 7, 8, 
	9, 10, 11, 12, 13, 14, 15, 16, 
	17, 15, 18, 2, 0, 20, 0, 21, 
	0, 23, 24, 22, 26, 27, 25, 30, 
	29, 31, 29, 28, 34, 33, 35, 33, 
	32, 34, 33, 36, 33, 32, 34, 33, 
	37, 33, 32, 39, 38, 38, 0, 3, 
	40, 40, 0, 42, 43, 41, 3, 0, 
	44, 0, 45, 0, 46, 0, 47, 0, 
	48, 0, 49, 0, 50, 0, 51, 0, 
	52, 0, 53, 0, 54, 0, 55, 0, 
	56, 0, 57, 0, 58, 0, 0, 59, 
	61, 62, 60, 0, 0, 0, 0, 63, 
	64, 65, 64, 64, 67, 66, 63, 3, 
	68, 8, 68, 0, 69, 0, 70, 0, 
	71, 0, 72, 0, 73, 0, 74, 0, 
	75, 0, 76, 0, 77, 0, 78, 0, 
	80, 79, 82, 81, 82, 83, 84, 85, 
	84, 83, 81, 82, 86, 81, 82, 87, 
	81, 82, 88, 81, 82, 89, 81, 82, 
	90, 81, 82, 91, 81, 82, 92, 81, 
	82, 93, 81, 82, 94, 81, 82, 95, 
	81, 82, 96, 81, 97, 82, 81, 98, 
	82, 81, 82, 99, 81, 82, 100, 81, 
	82, 101, 81, 103, 102, 104, 105, 106, 
	107, 108, 109, 110, 111, 112, 113, 114, 
	115, 116, 117, 115, 118, 102, 0, 119, 
	0, 120, 0, 121, 0, 122, 0, 123, 
	0, 124, 0, 125, 0, 126, 0, 127, 
	0, 128, 0, 129, 0, 130, 0, 131, 
	0, 132, 0, 133, 0, 134, 0, 136, 
	135, 138, 137, 138, 139, 140, 141, 140, 
	142, 143, 144, 145, 146, 139, 137, 138, 
	147, 137, 138, 148, 137, 138, 149, 137, 
	138, 150, 137, 138, 151, 137, 138, 152, 
	137, 138, 153, 137, 138, 154, 137, 138, 
	155, 137, 138, 156, 137, 138, 157, 137, 
	138, 158, 137, 138, 159, 137, 138, 160, 
	137, 138, 161, 137, 138, 162, 137, 138, 
	163, 137, 138, 164, 137, 138, 165, 137, 
	138, 166, 137, 138, 167, 137, 138, 168, 
	137, 138, 169, 137, 138, 170, 137, 138, 
	171, 137, 138, 172, 137, 138, 173, 137, 
	138, 174, 137, 138, 175, 137, 138, 176, 
	137, 138, 177, 137, 138, 178, 137, 138, 
	179, 137, 138, 180, 137, 138, 181, 137, 
	182, 138, 137, 183, 138, 137, 138, 184, 
	137, 138, 169, 137, 138, 185, 137, 138, 
	186, 137, 138, 187, 137, 138, 188, 137, 
	138, 189, 137, 138, 190, 137, 138, 191, 
	137, 138, 192, 137, 138, 193, 137, 138, 
	169, 137, 138, 194, 137, 138, 195, 137, 
	138, 196, 137, 138, 197, 137, 138, 198, 
	137, 138, 199, 137, 138, 200, 137, 138, 
	201, 137, 138, 202, 137, 138, 203, 137, 
	138, 204, 137, 138, 205, 137, 138, 206, 
	137, 138, 207, 137, 138, 208, 137, 138, 
	209, 137, 138, 169, 137, 210, 0, 211, 
	0, 212, 0, 213, 0, 214, 0, 215, 
	0, 216, 0, 217, 0, 218, 0, 219, 
	0, 220, 0, 222, 221, 224, 223, 224, 
	225, 226, 227, 228, 226, 229, 230, 231, 
	232, 233, 234, 235, 233, 225, 223, 224, 
	236, 223, 224, 237, 223, 224, 238, 223, 
	224, 239, 223, 224, 240, 223, 224, 241, 
	223, 224, 242, 223, 224, 243, 223, 224, 
	244, 223, 224, 245, 223, 224, 246, 223, 
	224, 247, 223, 224, 248, 223, 224, 249, 
	223, 224, 250, 223, 224, 251, 223, 224, 
	252, 223, 224, 253, 223, 224, 254, 223, 
	224, 255, 223, 224, 256, 223, 224, 257, 
	223, 224, 258, 223, 224, 259, 223, 224, 
	260, 223, 224, 261, 223, 262, 224, 223, 
	263, 224, 223, 224, 264, 223, 224, 265, 
	223, 224, 250, 223, 224, 266, 223, 224, 
	267, 223, 224, 268, 223, 224, 269, 223, 
	224, 270, 223, 224, 271, 223, 224, 272, 
	223, 224, 273, 223, 224, 274, 223, 224, 
	275, 223, 224, 276, 223, 224, 277, 223, 
	224, 278, 223, 224, 279, 223, 224, 280, 
	223, 224, 281, 223, 224, 265, 223, 224, 
	250, 282, 283, 223, 224, 284, 223, 224, 
	282, 223, 224, 285, 223, 224, 286, 223, 
	224, 282, 223, 287, 224, 223, 282, 224, 
	223, 224, 288, 223, 224, 289, 223, 224, 
	290, 223, 224, 291, 223, 224, 292, 223, 
	224, 282, 223, 293, 0, 294, 0, 295, 
	0, 296, 0, 297, 0, 298, 0, 299, 
	0, 300, 0, 301, 0, 302, 0, 303, 
	0, 304, 0, 305, 0, 306, 0, 307, 
	0, 308, 0, 309, 0, 310, 0, 312, 
	311, 314, 313, 314, 315, 316, 317, 318, 
	316, 319, 320, 321, 322, 323, 324, 322, 
	315, 313, 314, 325, 313, 314, 326, 313, 
	314, 327, 313, 314, 328, 313, 314, 329, 
	313, 314, 330, 313, 314, 331, 313, 314, 
	332, 313, 314, 333, 313, 314, 334, 313, 
	314, 335, 313, 314, 336, 313, 314, 337, 
	313, 314, 338, 313, 314, 339, 313, 314, 
	340, 313, 314, 341, 313, 314, 342, 313, 
	314, 343, 313, 314, 344, 313, 314, 345, 
	313, 314, 346, 313, 314, 347, 313, 314, 
	348, 313, 314, 349, 313, 314, 350, 313, 
	351, 314, 313, 352, 314, 313, 314, 353, 
	313, 314, 354, 313, 314, 339, 313, 314, 
	355, 313, 314, 356, 313, 314, 357, 313, 
	314, 358, 313, 314, 359, 313, 314, 360, 
	313, 314, 354, 313, 314, 339, 361, 362, 
	313, 314, 363, 313, 314, 361, 313, 314, 
	364, 313, 314, 365, 313, 314, 361, 313, 
	366, 314, 313, 361, 314, 313, 314, 367, 
	313, 314, 368, 313, 314, 369, 313, 314, 
	370, 313, 314, 371, 313, 314, 361, 313, 
	372, 0, 373, 0, 374, 0, 375, 0, 
	376, 0, 377, 0, 378, 0, 379, 0, 
	381, 380, 383, 382, 383, 384, 385, 386, 
	387, 385, 388, 389, 390, 391, 392, 393, 
	394, 395, 393, 384, 382, 383, 396, 382, 
	383, 397, 382, 383, 398, 382, 383, 399, 
	382, 383, 400, 382, 383, 401, 382, 383, 
	402, 382, 383, 403, 382, 383, 404, 382, 
	383, 405, 382, 383, 406, 382, 383, 407, 
	382, 383, 408, 382, 383, 409, 382, 383, 
	410, 382, 383, 411, 382, 383, 412, 382, 
	383, 413, 382, 383, 414, 382, 383, 415, 
	382, 383, 416, 382, 383, 417, 382, 383, 
	418, 382, 383, 419, 382, 383, 420, 382, 
	383, 421, 382, 422, 383, 382, 423, 383, 
	382, 383, 424, 382, 383, 425, 382, 383, 
	410, 382, 383, 426, 382, 383, 427, 382, 
	383, 428, 382, 383, 429, 382, 383, 430, 
	382, 383, 431, 382, 383, 432, 382, 383, 
	433, 382, 383, 434, 382, 383, 425, 382, 
	383, 435, 382, 383, 436, 382, 383, 437, 
	382, 383, 438, 382, 383, 439, 382, 383, 
	440, 382, 383, 441, 382, 383, 442, 382, 
	383, 443, 382, 383, 444, 382, 383, 445, 
	382, 383, 446, 382, 383, 447, 382, 383, 
	448, 382, 383, 449, 382, 383, 450, 382, 
	383, 425, 382, 383, 410, 451, 452, 382, 
	383, 453, 382, 383, 451, 382, 383, 454, 
	382, 383, 455, 382, 383, 451, 382, 456, 
	383, 382, 451, 383, 382, 383, 457, 382, 
	383, 458, 382, 383, 459, 382, 383, 460, 
	382, 383, 461, 382, 383, 451, 382, 58, 
	462, 463, 0, 464, 0, 462, 0, 465, 
	0, 466, 0, 462, 0, 467, 0, 462, 
	0, 468, 0, 469, 0, 470, 0, 471, 
	0, 472, 0, 462, 0, 473, 474, 473, 
	0, 477, 476, 478, 479, 476, 475, 0, 
	481, 482, 480, 0, 481, 480, 477, 483, 
	481, 482, 483, 480, 477, 484, 485, 486, 
	487, 488, 489, 490, 491, 492, 493, 494, 
	495, 496, 497, 498, 496, 499, 484, 0, 
	500, 0
]

class << self
	attr_accessor :_lexer_trans_targs
	private :_lexer_trans_targs, :_lexer_trans_targs=
end
self._lexer_trans_targs = [
	0, 2, 4, 4, 5, 15, 17, 31, 
	34, 37, 67, 152, 228, 301, 384, 387, 
	390, 392, 398, 3, 6, 7, 8, 9, 
	8, 8, 9, 8, 10, 10, 10, 11, 
	10, 10, 10, 11, 12, 13, 14, 4, 
	14, 15, 4, 16, 18, 19, 20, 21, 
	22, 23, 24, 25, 26, 27, 28, 29, 
	30, 404, 32, 33, 33, 4, 16, 35, 
	36, 4, 35, 34, 36, 38, 39, 40, 
	41, 42, 43, 44, 45, 46, 47, 48, 
	49, 48, 49, 49, 4, 50, 51, 52, 
	53, 54, 55, 56, 57, 58, 59, 60, 
	61, 62, 63, 64, 65, 66, 4, 4, 
	5, 15, 17, 31, 34, 37, 67, 152, 
	228, 301, 384, 387, 390, 392, 398, 68, 
	69, 70, 71, 72, 73, 74, 75, 76, 
	77, 78, 79, 80, 81, 82, 83, 84, 
	85, 84, 85, 85, 4, 86, 100, 110, 
	125, 135, 145, 87, 88, 89, 90, 91, 
	92, 93, 94, 95, 96, 97, 98, 99, 
	4, 101, 102, 103, 104, 105, 106, 107, 
	108, 109, 66, 111, 112, 113, 114, 115, 
	116, 117, 118, 119, 120, 121, 122, 123, 
	124, 126, 127, 128, 129, 130, 131, 132, 
	133, 134, 136, 137, 138, 139, 140, 141, 
	142, 143, 144, 145, 146, 147, 148, 149, 
	150, 151, 153, 154, 155, 156, 157, 158, 
	159, 160, 161, 162, 163, 164, 165, 164, 
	165, 165, 4, 166, 180, 181, 197, 207, 
	214, 217, 220, 222, 167, 168, 169, 170, 
	171, 172, 173, 174, 175, 176, 177, 178, 
	179, 4, 66, 182, 183, 184, 185, 186, 
	187, 188, 189, 190, 191, 192, 193, 194, 
	195, 196, 198, 199, 200, 201, 202, 203, 
	204, 205, 206, 207, 208, 209, 210, 211, 
	212, 213, 180, 215, 216, 218, 219, 221, 
	223, 224, 225, 226, 227, 229, 230, 231, 
	232, 233, 234, 235, 236, 237, 238, 239, 
	240, 241, 242, 243, 244, 245, 246, 247, 
	248, 247, 248, 248, 4, 249, 263, 264, 
	280, 287, 290, 293, 295, 250, 251, 252, 
	253, 254, 255, 256, 257, 258, 259, 260, 
	261, 262, 4, 66, 265, 266, 267, 268, 
	269, 270, 271, 272, 273, 274, 275, 276, 
	277, 278, 279, 281, 282, 283, 284, 285, 
	286, 263, 288, 289, 291, 292, 294, 296, 
	297, 298, 299, 300, 302, 303, 304, 305, 
	306, 307, 308, 309, 310, 311, 310, 311, 
	311, 4, 312, 326, 327, 343, 353, 363, 
	370, 373, 376, 378, 313, 314, 315, 316, 
	317, 318, 319, 320, 321, 322, 323, 324, 
	325, 4, 66, 328, 329, 330, 331, 332, 
	333, 334, 335, 336, 337, 338, 339, 340, 
	341, 342, 344, 345, 346, 347, 348, 349, 
	350, 351, 352, 354, 355, 356, 357, 358, 
	359, 360, 361, 362, 363, 364, 365, 366, 
	367, 368, 369, 326, 371, 372, 374, 375, 
	377, 379, 380, 381, 382, 383, 31, 385, 
	386, 388, 389, 391, 393, 394, 395, 396, 
	397, 398, 399, 400, 402, 403, 401, 399, 
	400, 401, 399, 402, 403, 5, 15, 17, 
	31, 34, 37, 67, 152, 228, 301, 384, 
	387, 390, 392, 398, 0
]

class << self
	attr_accessor :_lexer_trans_actions
	private :_lexer_trans_actions, :_lexer_trans_actions=
end
self._lexer_trans_actions = [
	43, 0, 0, 54, 3, 1, 0, 29, 
	1, 29, 29, 29, 29, 29, 29, 29, 
	29, 29, 35, 0, 0, 0, 7, 135, 
	48, 0, 102, 9, 5, 45, 130, 45, 
	0, 33, 122, 33, 33, 0, 11, 106, 
	0, 0, 114, 25, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 57, 0, 110, 23, 0, 
	27, 118, 27, 51, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 57, 
	140, 0, 54, 0, 81, 84, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 21, 31, 126, 
	60, 57, 31, 63, 57, 63, 63, 63, 
	63, 63, 63, 63, 63, 63, 66, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 57, 
	140, 0, 54, 0, 69, 33, 84, 84, 
	84, 84, 84, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	13, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 13, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 57, 140, 0, 
	54, 0, 72, 33, 84, 84, 84, 84, 
	84, 84, 84, 84, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 15, 15, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 57, 
	140, 0, 54, 0, 78, 33, 84, 84, 
	84, 84, 84, 84, 84, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 19, 19, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 57, 140, 0, 54, 
	0, 75, 33, 84, 84, 84, 84, 84, 
	84, 84, 84, 84, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 17, 17, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 37, 37, 54, 37, 87, 
	0, 0, 39, 0, 0, 93, 90, 41, 
	96, 90, 96, 96, 96, 96, 96, 96, 
	96, 96, 96, 99, 0
]

class << self
	attr_accessor :_lexer_eof_actions
	private :_lexer_eof_actions, :_lexer_eof_actions=
end
self._lexer_eof_actions = [
	0, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43
]

class << self
	attr_accessor :lexer_start
end
self.lexer_start = 1;
class << self
	attr_accessor :lexer_first_final
end
self.lexer_first_final = 404;
class << self
	attr_accessor :lexer_error
end
self.lexer_error = 0;

class << self
	attr_accessor :lexer_en_main
end
self.lexer_en_main = 1;


# line 128 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/lu.rb.rl"
      end
 
      def scan(data)
        data = (data + "\n%_FEATURE_END_%").unpack("c*") # Explicit EOF simplifies things considerably
        eof = pe = data.length
 
        @line_number = 1
        @last_newline = 0
 
        
# line 785 "lib/gherkin/rb_lexer/lu.rb"
begin
	p ||= 0
	pe ||= data.length
	cs = lexer_start
end

# line 138 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/lu.rb.rl"
        
# line 794 "lib/gherkin/rb_lexer/lu.rb"
begin
	_klen, _trans, _keys, _acts, _nacts = nil
	_goto_level = 0
	_resume = 10
	_eof_trans = 15
	_again = 20
	_test_eof = 30
	_out = 40
	while true
	_trigger_goto = false
	if _goto_level <= 0
	if p == pe
		_goto_level = _test_eof
		next
	end
	if cs == 0
		_goto_level = _out
		next
	end
	end
	if _goto_level <= _resume
	_keys = _lexer_key_offsets[cs]
	_trans = _lexer_index_offsets[cs]
	_klen = _lexer_single_lengths[cs]
	_break_match = false
	
	begin
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + _klen - 1

	     loop do
	        break if _upper < _lower
	        _mid = _lower + ( (_upper - _lower) >> 1 )

	        if data[p] < _lexer_trans_keys[_mid]
	           _upper = _mid - 1
	        elsif data[p] > _lexer_trans_keys[_mid]
	           _lower = _mid + 1
	        else
	           _trans += (_mid - _keys)
	           _break_match = true
	           break
	        end
	     end # loop
	     break if _break_match
	     _keys += _klen
	     _trans += _klen
	  end
	  _klen = _lexer_range_lengths[cs]
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + (_klen << 1) - 2
	     loop do
	        break if _upper < _lower
	        _mid = _lower + (((_upper-_lower) >> 1) & ~1)
	        if data[p] < _lexer_trans_keys[_mid]
	          _upper = _mid - 2
	        elsif data[p] > _lexer_trans_keys[_mid+1]
	          _lower = _mid + 2
	        else
	          _trans += ((_mid - _keys) >> 1)
	          _break_match = true
	          break
	        end
	     end # loop
	     break if _break_match
	     _trans += _klen
	  end
	end while false
	_trans = _lexer_indicies[_trans]
	cs = _lexer_trans_targs[_trans]
	if _lexer_trans_actions[_trans] != 0
		_acts = _lexer_trans_actions[_trans]
		_nacts = _lexer_actions[_acts]
		_acts += 1
		while _nacts > 0
			_nacts -= 1
			_acts += 1
			case _lexer_actions[_acts - 1]
when 0 then
# line 9 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/lu.rb.rl"
		begin

          @content_start = p
          @current_line = @line_number
          @start_col = p - @last_newline - "#{@keyword}:".length
        		end
when 1 then
# line 15 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/lu.rb.rl"
		begin

          @current_line = @line_number
          @start_col = p - @last_newline
        		end
when 2 then
# line 20 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/lu.rb.rl"
		begin

          @content_start = p
        		end
when 3 then
# line 24 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/lu.rb.rl"
		begin

          @docstring_content_type_start = p
        		end
when 4 then
# line 27 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/lu.rb.rl"
		begin

          @docstring_content_type_end = p
        		end
when 5 then
# line 31 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/lu.rb.rl"
		begin

          con = unindent(@start_col, utf8_pack(data[@content_start...@next_keyword_start-1]).sub(/(\r?\n)?([\t ])*\Z/, '').gsub(/\\"\\"\\"/, '"""'))
          con_type = utf8_pack(data[@docstring_content_type_start...@docstring_content_type_end]).strip
          @listener.doc_string(con_type, con, @current_line) 
        		end
when 6 then
# line 36 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/lu.rb.rl"
		begin

          p = store_keyword_content(:feature, data, p, eof)
        		end
when 7 then
# line 40 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/lu.rb.rl"
		begin

          p = store_keyword_content(:background, data, p, eof)
        		end
when 8 then
# line 44 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/lu.rb.rl"
		begin

          p = store_keyword_content(:scenario, data, p, eof)
        		end
when 9 then
# line 48 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/lu.rb.rl"
		begin

          p = store_keyword_content(:scenario_outline, data, p, eof)
        		end
when 10 then
# line 52 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/lu.rb.rl"
		begin

          p = store_keyword_content(:examples, data, p, eof)
        		end
when 11 then
# line 56 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/lu.rb.rl"
		begin

          con = utf8_pack(data[@content_start...p]).strip
          @listener.step(@keyword, con, @current_line)
        		end
when 12 then
# line 61 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/lu.rb.rl"
		begin

          con = utf8_pack(data[@content_start...p]).strip
          @listener.comment(con, @line_number)
          @keyword_start = nil
        		end
when 13 then
# line 67 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/lu.rb.rl"
		begin

          con = utf8_pack(data[@content_start...p]).strip
          @listener.tag(con, @current_line)
          @keyword_start = nil
        		end
when 14 then
# line 73 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/lu.rb.rl"
		begin

          @line_number += 1
        		end
when 15 then
# line 77 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/lu.rb.rl"
		begin

          @last_newline = p + 1
        		end
when 16 then
# line 81 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/lu.rb.rl"
		begin

          @keyword_start ||= p
        		end
when 17 then
# line 85 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/lu.rb.rl"
		begin

          @keyword = utf8_pack(data[@keyword_start...p]).sub(/:$/,'')
          @keyword_start = nil
        		end
when 18 then
# line 90 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/lu.rb.rl"
		begin

          @next_keyword_start = p
        		end
when 19 then
# line 94 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/lu.rb.rl"
		begin

          p = p - 1
          current_row = []
          @current_line = @line_number
        		end
when 20 then
# line 100 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/lu.rb.rl"
		begin

          @content_start = p
        		end
when 21 then
# line 104 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/lu.rb.rl"
		begin

          con = utf8_pack(data[@content_start...p]).strip
          current_row << con.gsub(/\\\|/, "|").gsub(/\\n/, "\n").gsub(/\\\\/, "\\")
        		end
when 22 then
# line 109 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/lu.rb.rl"
		begin

          @listener.row(current_row, @current_line)
        		end
when 23 then
# line 113 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/lu.rb.rl"
		begin

          if cs < lexer_first_final
            content = current_line_content(data, p)
            raise Gherkin::Lexer::LexingError.new("Lexing error on line %d: '%s'. See http://wiki.github.com/cucumber/gherkin/lexingerror for more information." % [@line_number, content])
          else
            @listener.eof
          end
        		end
# line 1038 "lib/gherkin/rb_lexer/lu.rb"
			end # action switch
		end
	end
	if _trigger_goto
		next
	end
	end
	if _goto_level <= _again
	if cs == 0
		_goto_level = _out
		next
	end
	p += 1
	if p != pe
		_goto_level = _resume
		next
	end
	end
	if _goto_level <= _test_eof
	if p == eof
	__acts = _lexer_eof_actions[cs]
	__nacts =  _lexer_actions[__acts]
	__acts += 1
	while __nacts > 0
		__nacts -= 1
		__acts += 1
		case _lexer_actions[__acts - 1]
when 23 then
# line 113 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/lu.rb.rl"
		begin

          if cs < lexer_first_final
            content = current_line_content(data, p)
            raise Gherkin::Lexer::LexingError.new("Lexing error on line %d: '%s'. See http://wiki.github.com/cucumber/gherkin/lexingerror for more information." % [@line_number, content])
          else
            @listener.eof
          end
        		end
# line 1077 "lib/gherkin/rb_lexer/lu.rb"
		end # eof action switch
	end
	if _trigger_goto
		next
	end
end
	end
	if _goto_level <= _out
		break
	end
	end
	end

# line 139 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/lu.rb.rl"
      end

      def unindent(startcol, text)
        text.gsub(/^[\t ]{0,#{startcol}}/, "")
      end

      def store_keyword_content(event, data, p, eof)
        end_point = (!@next_keyword_start or (p == eof)) ? p : @next_keyword_start
        content = unindent(@start_col + 2, utf8_pack(data[@content_start...end_point])).rstrip
        content_lines = content.split("\n")
        name = content_lines.shift || ""
        name.strip!
        description = content_lines.join("\n")
        @listener.__send__(event, @keyword, name, description, @current_line)
        @next_keyword_start ? @next_keyword_start - 1 : p
      ensure
        @next_keyword_start = nil
      end
      
      def current_line_content(data, p)
        rest = data[@last_newline..-1]
        utf8_pack(rest[0..rest.index(10)||-1]).strip # 10 is \n
      end

      if (RUBY_VERSION =~ /^1\.9/)
        def utf8_pack(array)
          array.pack("c*").force_encoding("UTF-8")
        end
      else
        def utf8_pack(array)
          array.pack("c*")
        end
      end
    end
  end
end

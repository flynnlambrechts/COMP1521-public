########################################################################
# COMP1521 23T1 -- Assignment 1 -- Othello!
#
#
# !!! IMPORTANT !!!
# Before starting work on the assignment, make sure you set your tab-width to 8!
# It is also suggested to indent with tabs only.
# Instructions to configure your text editor can be found here:
#   https://cgi.cse.unsw.edu.au/~cs1521/22T1/resources/mips-editors.html
# !!! IMPORTANT !!!
#
#
# This program was written by YOUR-NAME-HERE (z5555555)
# on INSERT-DATE-HERE
#
# Version 1.0 (06-03-2023): Team COMP1521 <cs1521@cse.unsw.edu.au>
#
########################################################################

#![tabsize(8)]

# Constant definitions.
# !!! DO NOT ADD, REMOVE, OR MODIFY ANY OF THESE DEFINITIONS !!!

# Bools
TRUE  = 1
FALSE = 0

# Players
PLAYER_EMPTY = 0
PLAYER_BLACK = 1
PLAYER_WHITE = 2

# Character shown when rendering board
WHITE_CHAR         = 'W'
BLACK_CHAR         = 'B'
POSSIBLE_MOVE_CHAR = 'x'
EMPTY_CELL_CHAR    = '.'

# Smallest and largest possible board sizes (standard Othello board size is 8)
MIN_BOARD_SIZE = 4
MAX_BOARD_SIZE = 12

# There are 8 directions a capture line can have (2 vertical, 2 horizontal and 4 diagonal).
NUM_DIRECTIONS = 8

# Some constants for accessing vectors
VECTOR_ROW_OFFSET = 0
VECTOR_COL_OFFSET = 4
SIZEOF_VECTOR     = 8


########################################################################
# DATA SEGMENT
# !!! DO NOT ADD, REMOVE, MODIFY OR REORDER ANY OF THESE DEFINITIONS !!!
	.data
	.align 2

# The actual board size, selected by the player
board_size:		.space 4

# Who's turn it is - either PLAYER_BLACK or PLAYER_WHITE
current_player:		.word PLAYER_BLACK

# The contents of the board
board:			.space MAX_BOARD_SIZE * MAX_BOARD_SIZE

# The 8 directions which a line can have when capturing
directions:
	.word	-1, -1  # Up left
	.word	-1,  0  # Up
	.word	-1,  1  # Up right
	.word	 0, -1  # Left
	.word	 0,  1  # Right
	.word	 1, -1  # Down left
	.word	 1,  0  # Down
	.word	 1,  1  # Down right

welcome_to_reversi_str:		.asciiz "Welcome to Reversi!\n"
board_size_prompt_str:		.asciiz "How big do you want the board to be? "
wrong_board_size_str_1:		.asciiz "Board size must be between "
wrong_board_size_str_2:		.asciiz " and "
wrong_board_size_str_3:		.asciiz "\n"
board_size_must_be_even_str:	.asciiz "Board size must be even!\n"
board_size_ok_str:		.asciiz "OK, the board size is "
white_won_str:			.asciiz "The game is a win for WHITE!\n"
black_won_str:			.asciiz "The game is a win for BLACK!\n"
tie_str:			.asciiz "The game is a tie! Wow!\n"
final_score_str_1:		.asciiz	"Score for black: "
final_score_str_2:		.asciiz ", for white: "
final_score_str_3:		.asciiz ".\n"
whos_turn_str_1:		.asciiz "\nIt is "
whos_turn_str_2:		.asciiz "'s turn.\n"
no_valid_move_str_1:		.asciiz "There are no valid moves for "
no_valid_move_str_2:		.asciiz "!\n"
game_over_str_1:		.asciiz "There are also no valid moves for "
game_over_str_2:		.asciiz "...\nGame over!\n"
enter_move_str:			.asciiz "Enter move (e.g. A 1): "
invalid_row_str:		.asciiz "Invalid row!\n"
invalid_column_str:		.asciiz "Invalid column!\n"
invalid_move_str:		.asciiz "Invalid move!\n"
white_str:			.asciiz "white"
black_str:			.asciiz "black"
board_str:			.asciiz "Board:\n   "

############################################################
####                                                    ####
####   Your journey begins here, intrepid adventurer!   ####
####                                                    ####
############################################################

################################################################################
#
# Implement the following functions,
# and check these boxes as you finish implementing each function.
#
#  - [X] main
#  - [X] read_board_size
#  - [X] initialise_board
#  - [X] place_initial_pieces
#  - [X] play_game
#  - [X] announce_winner
#  - [X] count_discs
#  - [X] play_turn
#  - [X] place_move
#  - [X] player_has_a_valid_move
#  - [X] is_valid_move
#  - [X] capture_amount_from_direction
#  - [X] other_player
#  - [X] current_player_str
#  - [X] print_board			(provided for you)
################################################################################



################################################################################
# .TEXT <main>
	.text
main:
	# Args:     void
	#
	# Returns:
	#    - $v0: int
	#
	# Frame:    [$ra]
	# Uses:     [$a0, $v0]
	# Clobbers: [$a0, $v0]
	#
	# Locals:
	#   None
	#
	# Structure:
	#   main
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

main__prologue:
	begin
	push	$ra
main__body:
	la	$a0, welcome_to_reversi_str		# printf("Welcome to Reversi!\n")
	li	$v0, 4
	syscall 

	jal	read_board_size
	jal	initialise_board
	jal	place_initial_pieces
	jal	play_game

main__epilogue:
	pop	$ra
	end
	jr	$ra					# return;


################################################################################
# .TEXT <read_board_size>
	.text
read_board_size:
	# Args:     void
	#
	# Returns:  void
	#
	# Frame:    [$ra]
	# Uses:     [$a0, $v0, $t0, $t1]
	# Clobbers: [$a0, $v0, $t0, $t1]
	#
	# Locals:
	#   - $t0: board_size
	#   - $t1: remainder
	#
	# Structure:
	#   read_board_size
	#   -> [prologue]
	#   -> body
	#      -> loop_start
	#      	   -> bad_board_size
	#      	   -> good_board_size
	#      	   -> even_board_size
	#      -> loop_end
	#   -> [epilogue]

read_board_size__prologue:
	begin
	push	$ra

read_board_size__body:
read_board_size__loop_start:
	la	$a0, board_size_prompt_str		
	li	$v0, 4
	syscall						# printf("How big do you want the board to be? ")

	li	$v0, 5					
	syscall						# scanf("%d", &board_size);
	move 	$t0, $v0				

	blt	$t0, MIN_BOARD_SIZE, read_board_size__bad_board_size
	bgt	$t0, MAX_BOARD_SIZE, read_board_size__bad_board_size
	b  	read_board_size__good_board_size
read_board_size__bad_board_size:
	li	$v0, 4
	la	$a0, wrong_board_size_str_1		
	syscall						# printf("Board size must be between ")	

	li	$v0, 1
	la	$a0, MIN_BOARD_SIZE
	syscall						# printf("%d", MIN_BOARD_SIZE)

	li	$v0, 4
	la	$a0, wrong_board_size_str_2		
	syscall						# printf(" and ")	

	li	$v0, 1
	la	$a0, MAX_BOARD_SIZE
	syscall						# printf("%d", MAX_BOARD_SIZE)

	li	$v0, 11
	li	$a0, '\n'
	syscall						# putchar('\n');

	b	read_board_size__loop_start		# continue
read_board_size__good_board_size:
	rem 	$t1, $t0, 2				# int remainder = board_size % 2
	beq	$t1, 0, read_board_size__even_board_size# if (remainder == 0) goto read_board_size__even_board_size
	
	li	$v0, 4
	la	$a0, board_size_must_be_even_str		
	syscall						# printf("Board size must be even!\n")

	b	read_board_size__loop_start		# continue
read_board_size__even_board_size:
	li	$v0, 4
	la	$a0, board_size_ok_str		
	syscall						# printf("OK, the board size is ")

	li	$v0, 1
	move	$a0, $t0
	syscall						# printf("%d", board_size)

	li	$v0, 11
	li	$a0, '\n'
	syscall						# putchar('\n');

	sw	$t0, board_size
							# break
read_board_size__loop_end:

read_board_size__epilogue:
	pop	$ra
	end
	jr	$ra					# return;


################################################################################
# .TEXT <initialise_board>
	.text
initialise_board:
	# Args:     void
	#
	# Returns:  void
	#
	# Frame:    [$ra]
	# Uses:     [$t0, $t1, $t2, $t3, $t4]
	# Clobbers: [$t0, $t1, $t2, $t3, $t4]
	#
	# Locals:
	#   - $t0: row
	#   - $t1: col
	#   - $t2: board_size
	#   - $t3: &board[row][col]
	#   - $t4: PLAYER_EMPTY
	#
	# Structure:
	#   initialise_board
	#   -> [prologue]
	#       -> body
	#          -> for_row
	#          -> for_row__init
	#          -> for_row__cond
	#          -> for_row__body
	#             -> print_row_num
	#             -> for_col
	#             -> for_col__init
	#             -> for_col__cond
	#             -> for_col__body
	#             -> for_col__step
	#             -> for_col__end
	#          -> for_row__step
	#          -> for_row__end
	#   -> [epilogue] 

initialise_board__prologue:
	begin
	push 	$ra

initialise_board__body:
	lw	$t2, board_size
	li	$t4, PLAYER_EMPTY
initialise_board__for_row:
initialise_board__for_row__init:
	li	$t0, 0					# int row = 0
initialise_board__for_row__cond:
	bge	$t0, $t2, initialise_board__for_row__end# while (row < board_size) {
initialise_board__for_row__body:
initialise_board__for_col:
initialise_board__for_col__init:
	li	$t1, 0					#     int col = 0
initialise_board__for_col__cond:
	bge	$t1, $t2, initialise_board__for_col__end#     while (col < board_size) {
initialise_board__for_col__body:
	mul	$t3, $t0, MAX_BOARD_SIZE		#         &board[row][col] = row * MAX_BOARD_SIZE
	add	$t3, $t3, $t1				#                            + col
	addi	$t3, board				#                            + &board

	sb	$t4, ($t3)				#	  board[i][j] = PLAYER_EMPTY

initialise_board__for_col__step:
	addi	$t1, $t1, 1				#     col++;
	b 	initialise_board__for_col__cond
initialise_board__for_col__end:

initialise_board__for_row__step:
	addi	$t0, $t0, 1				# row++;
	b initialise_board__for_row__cond

initialise_board__for_row__end:
initialise_board__epilogue:
	pop	$ra
	end
	jr	$ra		# return;


################################################################################
# .TEXT <place_initial_pieces>
	.text
place_initial_pieces:
	# Args:     void
	#
	# Returns:  void
	#
	# Frame:    [$ra]
	# Uses:     [$t0, $t1, $t2, $t3]
	# Clobbers: [$t0, $t1, $t2, $t3]
	#
	# Locals:
	#   - $t0: row
	#   - $t1: col
	#   - $t2: &board[row][col]
	#   - $t3: Temporary Value either PLAYER_WHITE OR PLAYER_BLACK
	#
	# Structure:
	#   place_initial_pieces
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

place_initial_pieces__prologue:
	begin
	push	$ra

place_initial_pieces__body:
	lw	$t0, board_size				# row = board_size
	div	$t0, $t0, 2				#     / 2
	sub	$t0, $t0, 1				#     - 1
	
	move	$t1, $t0				# col = board_size / 2 - 1

	mul	$t2, $t0, MAX_BOARD_SIZE		#  &board[row][col] = row * MAX_BOARD_SIZE
	add	$t2, $t2, $t1				#      + col
	addi	$t2, board				#      + &board

	li	$t3, PLAYER_WHITE
	sb	$t3, ($t2)				# board[row][col] = PLAYER_WHITE

	addi	$t0, $t0, 1				# row = board_size / 2
	move	$t1, $t0				# col = board_size / 2

	mul	$t2, $t0, MAX_BOARD_SIZE		#  &board[row][col] = row * MAX_BOARD_SIZE
	add	$t2, $t2, $t1				#      + col
	addi	$t2, board				#      + &board

	li	$t3, PLAYER_WHITE
	sb	$t3, ($t2)				# board[row][col] = PLAYER_WHITE

	sub	$t0, $t0, 1				# row = board_size / 2 - 1
	
	mul	$t2, $t0, MAX_BOARD_SIZE		#  &board[row][col] = row * MAX_BOARD_SIZE
	add	$t2, $t2, $t1				#      + col
	addi	$t2, board				#      + &board

	li	$t3, PLAYER_BLACK
	sb	$t3, ($t2)				# board[row][col] = PLAYER_BLACK

	move	$t1, $t0				# col = board_size / 2 - 1
	addi	$t0, $t0, 1				# row = board_size / 2	

	mul	$t2, $t0, MAX_BOARD_SIZE		#  &board[row][col] = row * MAX_BOARD_SIZE
	add	$t2, $t2, $t1				#      + col
	addi	$t2, board				#      + &board

	li	$t3, PLAYER_BLACK
	sb	$t3, ($t2)				# board[row][col] = PLAYER_BLACK

place_initial_pieces__epilogue:
	pop	$ra
	end
	jr	$ra					# return;


################################################################################
# .TEXT <play_game>
	.text
play_game:
	# Args:     void
	#
	# Returns:  void
	#
	# Frame:    [$ra]
	# Uses:     [$v0]
	# Clobbers: [$v0]
	#
	# Locals:
	#   - None
	#
	# Structure:
	#   play_game
	#   -> [prologue]
	#       -> body
	#          -> while_playing_turn
	#	   -> while_playing_turn__end
	#   -> [epilogue]

play_game__prologue:
	begin
	push	$ra
play_game__body:

while_playing_turn:
	jal 	play_turn
	beq 	$v0, FALSE, while_playing_turn__end
	b 	while_playing_turn
while_playing_turn__end:

	jal	announce_winner

play_game__epilogue:
	pop	$ra
	end
	jr	$ra					# return;


################################################################################
# .TEXT <announce_winner>
	.text
announce_winner:
	# Args:     void
	#
	# Returns:  void
	#
	# Frame:    [$ra, $s0, $s1]
	# Uses:     [$v0, $a0, $s0, $s1]
	# Clobbers: [$v0, $a0]
	#
	# Locals:
	#   - $s0: black_count
	#   - $s1: white_count
	#
	# Structure:
	#   announce_winner
	#   -> [prologue]
	#       -> body
	#	   -> black_win
	#	   -> white_win
	#	   -> tie
	#	   -> summary
	#   -> [epilogue]

announce_winner__prologue:
	begin
	push	$ra
	push	$s0
	push	$s1
announce_winner__body:
	li	$a0, PLAYER_BLACK			# arguments = PLAYER_BLACK
	jal	count_discs				
	move	$s0, $v0				# black_counter = count_discs(PLAYER_BLACK)

	li	$a0, PLAYER_WHITE			# arguments = PLAYER_WHITE
	jal	count_discs				
	move	$s1, $v0				# white_counter = count_discs(PLAYER_WHITE)
	
	bgt	$s1, $s0, announce_winner__white_win			# if (white_count > black_count) {		
	bgt	$s0, $s1, announce_winner__black_win			# } else if (black_count > white_count) {
	b	announce_winner__tie					# } else {
announce_winner__white_win:
	la	$a0, white_won_str				# print_string = "The game is a win for WHITE!\n"
	li	$v0, 4
	syscall						# printf(print_string)

	li	$a0, PLAYER_EMPTY			# arguments = PLAYER_EMPTY
	jal	count_discs
	add	$s1, $s1, $v0				# white_count += count_discs(PLAYER_EMPTY);

	b	announce_winner__summary
announce_winner__black_win:
	la	$a0, black_won_str			# print_string = "The game is a win for BLACK!\n"
	li	$v0, 4
	syscall						# printf(print_string)

	li	$a0, PLAYER_EMPTY			# arguments = PLAYER_EMPTY
	jal	count_discs
	add	$s0, $s0, $v0				# black_count += count_discs(PLAYER_EMPTY);

	b	announce_winner__summary
announce_winner__tie:
	la	$a0, tie_str				# print_string = "The game is a win for BLACK!\n"
	li	$v0, 4
	syscall						# printf(print_string)
announce_winner__summary:
	la	$a0, final_score_str_1			# print_string = "Score for black: "
	li	$v0, 4
	syscall						# printf(print_string)

	move	$a0, $s0				# args = black_count
	li	$v0, 1
	syscall						# printf("%d", black_count)

	la	$a0, final_score_str_2			# print_string = ", for white: "
	li	$v0, 4
	syscall						# printf(print_string)

	move	$a0, $s1				# args = white_count
	li	$v0, 1
	syscall						# printf("%d", white_count)

	la	$a0, final_score_str_3			# print_string = ".\n"
	li	$v0, 4
	syscall						# printf(print_string)

announce_winner__epilogue:
	pop	$s1
	pop	$s0
	pop 	$ra
	end
	jr	$ra					# return;


################################################################################
# .TEXT <count_discs>
	.text
count_discs:
	# Args:
	#    - $a0: int player
	#
	# Returns:
	#    - $v0: unsigned int
	#
	# Frame:    [$ra]
	# Uses:     [$v0, $a0, $t0, $t1, $t2, $t3, $t4, $t5]
	# Clobbers: [$v0, $a0, $t0, $t1, $t2, $t3, $t4, $t5]
	#
	# Locals:
	#   - $t0: count
	#   - $t1: row
	#   - $t2: col
	#   - $t3: board_size
	#   - $t4: &board_size[row][col]
	#   - $t5: board_size[row][col]
	#
	# Structure:
	#   count_discs
	#   -> [prologue]
	#       -> body
	#          -> for_row
	#          -> for_row__init
	#          -> for_row__cond
	#          -> for_row__body
	#              -> for_col
	#              -> for_col__init
	#              -> for_col__cond
	#              -> for_col__body
	#              -> for_col__step
	#              -> for_col__end
	#          -> for_row__step
	#          -> for_row__end
	#   -> [epilogue]

count_discs__prologue:
	begin
	push	$ra
count_discs__body:
	li	$t0, 0					# int count = 0
	lw	$t3, board_size				# board_size
count_discs__for_row:
count_discs__for_row__init:
	li	$t1, 0					# int row = 0
count_discs__for_row__cond:
	bge	$t1, $t3, count_discs__for_row__end	
count_discs__for_row__body:

count_discs__for_col:
count_discs__for_col__init:
	li	$t2, 0					# int col = 0
count_discs__for_col__cond:
	bge	$t2, $t3, count_discs__for_col__end
count_discs__for_col__body:
	mul	$t4, $t1, MAX_BOARD_SIZE		#  &board[row][col] = row * MAX_BOARD_SIZE
	add	$t4, $t4, $t2				#      + col
	addi	$t4, board				#      + &board

	lb	$t5, ($t4)				# board[row][col]
	bne	$t5, $a0, count_discs__for_col__step	# board[row][col] != player goto end of loop
	
	addi	$t0, $t0, 1				# count++
count_discs__for_col__step:
	addi	$t2, $t2, 1				# col++
	b	count_discs__for_col__cond
count_discs__for_col__end:

count_discs__for_row__step:
	addi	$t1, $t1, 1				# row++
	b 	count_discs__for_row__cond
count_discs__for_row__end:

	move	$v0, $t0				# prepare to return count
count_discs__epilogue:
	pop	$ra
	end
	jr	$ra					# return;


################################################################################
# .TEXT <play_turn>
	.text
play_turn:
	# Args:     void
	#
	# Returns:
	#    - $v0: int
	#
	# Frame:    [$ra, $s0, $s1]
	# Uses:     [$a0, $v0, $s0, $s1, $t2, $t3]
	# Clobbers: [$a0, $v0, $t2, $t3]
	#
	# Locals:
	#   - $s0: move_row
	#   - $s1: move_col
	#   - $t2: move_col_letter
	#   - $t3: board_size
	#
	# Structure:
	#   play_turn
	#   -> [prologue]
	#       -> body
	# 	   -> invalid_move	
	# 	   -> valid_move
	#	      -> if1
	#	      	 -> if1_body
	#	      -> if2
	#	      	 -> if2_body
	#	      -> if3
	#	      	 -> if3_body
	#	      -> end_ifs
	#	   -> return_true
	#	   -> return_false

	#   -> [epilogue]

play_turn__prologue:
	begin
	push 	$ra
	push	$s0
	push	$s1
play_turn__body:
	la	$a0, whos_turn_str_1			# print_string = "\nIt is "
	li	$v0, 4
	syscall						# printf("\nIt is ");

	jal	current_player_str			
	move	$a0, $v0				# print_string = current_player_str()
	li	$v0, 4
	syscall						# printf("%s")

	la	$a0, whos_turn_str_2			# print_string = "'s turn.\n"
	li	$v0, 4
	syscall						# printf("'s turn.\n");

	jal	print_board				# print_board();
	
	jal	player_has_a_valid_move

	beq	$v0, 0, play_turn__invalid_move		# if (!player_has_a_valid_move()) {
	b 	play_turn__valid_move
play_turn__invalid_move:
	la	$a0, no_valid_move_str_1		# print_string = "There are no valid moves for "
	li	$v0, 4
	syscall						# printf(print_string);
	
	jal 	current_player_str			# current_player_str()
	move	$a0, $v0				# print_string = current_player_str()
	li	$v0, 4
	syscall						# printf("%s");

	la	$a0, no_valid_move_str_2		# print_string = "...\n"
	li	$v0, 4
	syscall						# printf(print_string);

	jal	other_player
	sw	$v0, current_player			# current_player = other_player();

	jal     player_has_a_valid_move			# player_has_a_valid_move()
	beq 	$v0, 1, play_turn__return_true

	la	$a0, game_over_str_1			# print_string = "There are also no valid moves for "
	li	$v0, 4
	syscall						# printf(print_string);
	
	jal 	current_player_str			# current_player_str()
	move	$a0, $v0				# print_string = current_player_str()
	li	$v0, 4
	syscall						# printf("%s");

	la	$a0, game_over_str_2			# print_string = "...\nGame over!\n"
	li	$v0, 4
	syscall						# printf(print_string);
	
	b	play_turn__return_false
play_turn__valid_move:
	la	$a0, enter_move_str			# print_string = "Enter move (e.g. A 1): "
	li	$v0, 4
	syscall						# printf(print_string);
	
	li	$v0, 12					
	syscall						
	move	$t2, $v0				# scanf("%c", &move_col_letter)

	li	$v0, 5				
	syscall						
	move	$s0, $v0				# scanf("%d", &move_row)

	addi	$s0, $s0, -1				# move_row -= 1;

	sub	$s1, $t2, 'A'				# int move_col = move_col_letter - 'A';

	lw	$t3, board_size

play_turn__if1:
	lw	$t3, board_size

	blt	$s0, 0, play_turn__if1__body		# (move_row < 0 
	bge	$s0, $t3, play_turn__if1__body		# || move_row >= board_size)
	b	play_turn__if2
play_turn__if1__body:
	la	$a0, invalid_row_str			# print_string = "Invalid row!\n"
	li	$v0, 4
	syscall						# printf(print_string);

	b	 play_turn__return_true
play_turn__if2:
	lw	$t3, board_size

	blt	$s1, 0, play_turn__if2__body		# (move_col < 0 
	bge	$s1, $t3, play_turn__if2__body		# || move_col >= board_size)
	b	play_turn__if3
play_turn__if2__body:
	la	$a0, invalid_column_str			# print_string = "Invalid column!\n"
	li	$v0, 4
	syscall						# printf(print_string);

	b	 play_turn__return_true
play_turn__if3:
	move	$a0, $s0				# arguments = (move_row,
	move	$a1, $s1				#              move_col)
	jal	is_valid_move				# is_valid_move(move_row, move_col)
	
	beq	$v0, 0, play_turn__if3__body	# if valid move continue
	b 	play_turn__end_ifs
play_turn__if3__body:
	la	$a0, invalid_move_str			# print_string = "Invalid move!\n"
	li	$v0, 4
	syscall						# printf(print_string);

	b	 play_turn__return_true
play_turn__end_ifs:
	move	$a0, $s0				# arguments = (move_row,
	move	$a1, $s1				#              move_col)
	jal	place_move				# place_move(move_row, move_col)
	
	jal 	other_player				# other_player()
	sw	$v0, current_player			# current_player = other_player();

	b	play_turn__return_true
play_turn__return_true:
	li	$v0, TRUE
	b	play_turn__epilogue
play_turn__return_false:
	li	$v0, FALSE
	b	play_turn__epilogue
play_turn__epilogue:
	pop	$s1
	pop	$s0
	pop	$ra
	end
	jr	$ra					# return;


################################################################################
# .TEXT <place_move>
	.text
place_move:
	# Args:
	#    - $a0: int row
	#    - $a1: int col
	#
	# Returns:  void
	#
	# Frame:    [$ra, $s0, $s1, $s2, $s3]
	# Uses:     [$a0, $a1, $a2, $s0, $s1, $s2, $s3, $t0, $t1, $t2, $t3, $t4, $t5]
	# Clobbers: [$a0, $a1, $a2, $t0, $t1, $t2, $t3, $t4, $t5]
	
	#
	# Locals:
	#   - $s0: direction
	#   - $s1: delta
	#   - $s2: move_row
	#   - $s3: move_col	
	#   - $t0: capture_amt
	#   - $t1: i
	#   - $t2: row
	#   - $t3: col
	#   - $t4: current_player
	#   - $t5: &board[row][col]
	#
	# Structure:
	#   place_move
	#   -> [prologue]
	#       -> body
	#          -> loop
	#          -> loop__init
	#          -> loop__cond
	#          -> loop__body
	#             -> for_i
	#             -> for_i__init
	#             -> for_i__cond
	#             -> for_i__body
	#             -> for_i__step
	#             -> for_i__end
	#          -> loop__step
	#          -> loop__end
	#   -> [epilogue]

place_move__prologue:
	begin
	push	$ra
	push	$s0
	push	$s1
	push	$s2
	push	$s3
place_move__body:
	move	$s2, $a0
	move	$s3, $a1
place_move__loop:
place_move__loop__init:
	li	$s0, 0					# direction = 0
place_move__loop__cond:
	bge	$s0, NUM_DIRECTIONS, place_move__loop__end
place_move__loop__body:
	mul	$s1, $s0, SIZEOF_VECTOR			# delta = direction * SIZEOF_VECTOR
	add	$s1, $s1, directions			#         + directions

	move	$a0, $s2				# arguments = (move_row,
	move	$a1, $s3				#              move_col,
	move	$a2, $s1				#              delta)
	jal	capture_amount_from_direction		# capture_amount_from_direction(move_row, move_col, delta);
	move	$t0, $v0				# int capture_amt = return from previous

place_move__for_i:
place_move__for_i__init:
	li	$t1, 0					# int i = 0
place_move__for_i__cond:
	bgt	$t1, $t0, place_move__for_i__end	# i <= capture_amt
place_move__for_i__body:	
	lw	$t2, VECTOR_ROW_OFFSET($s1)				# row = delta->row
	mul	$t2, $t2, $t1				#       * i
	add	$t2, $t2, $s2				#       + move_row

	lw	$t3, VECTOR_COL_OFFSET($s1)				# col = delta->col
	mul	$t3, $t3, $t1				# 	* i
	add	$t3, $t3, $s3				#	+ move_col

	mul	$t5, $t2, MAX_BOARD_SIZE		#  &board[row][col] = row * MAX_BOARD_SIZE
	add	$t5, $t5, $t3				#      + col
	addi	$t5, board				#      + &board

	lb	$t4, current_player			# current_player
	sb	$t4, ($t5)				# board[row][col] = current_player;		
place_move__for_i__step:
	addi 	$t1, $t1, 1				# i++
	b	place_move__for_i__cond
place_move__for_i__end:
place_move__loop__step:
	addi	$s0, $s0, 1				# direction++
	b	place_move__loop__cond
place_move__loop__end:

place_move__epilogue:
	pop	$s3
	pop	$s2
	pop	$s1
	pop	$s0
	pop	$ra
	end
	jr	$ra					# return;


################################################################################
# .TEXT <player_has_a_valid_move>
	.text
player_has_a_valid_move:
	# Args:     void
	#
	# Returns:
	#    - $v0: int
	#
	# Frame:    [$ra, $s0, $s1, $s2]
	# Uses:     [$a0, $a1, $s0, $s1, $s2]
	# Clobbers: [$a0, $a1]
	#
	# Locals:
	#   - $s0: row
	#   - $s1: col
	#   - $s2: board_size
	#
	# Structure:
	#   player_has_a_valid_move
	#   -> [prologue]
	#       -> body
	# 	   -> for_row
	# 	   -> for_row__init
	# 	   -> for_row__cond
	# 	   -> for_row__body
	# 	      -> for_col
	# 	      -> for_col__init
	# 	      -> for_col__cond
	# 	      -> for_col__body
	# 	      -> for_col__step
	# 	      -> for_col__end
	# 	   -> for_row__step
	# 	   -> for_row__end
	#   -> [epilogue]

player_has_a_valid_move__prologue:
	begin
	push	$ra
	push	$s0
	push	$s1
	push	$s2
player_has_a_valid_move__body:
	lw	$s2, board_size
player_has_a_valid_move__for_row:
player_has_a_valid_move__for_row__init:
	li	$s0, 0;					# int row = 0
player_has_a_valid_move__for_row__cond:
	bge	$s0, $s2, player_has_a_valid_move__for_row__end
player_has_a_valid_move__for_row__body:
player_has_a_valid_move__for_col:
player_has_a_valid_move__for_col__init:
	li	$s1, 0;					# int col = 0
player_has_a_valid_move__for_col__cond:
	bge	$s1, $s2, player_has_a_valid_move__for_col__end
player_has_a_valid_move__for_col__body:
	move	$a0, $s0				# args = (row,
	move	$a1, $s1				#         col)
	jal	is_valid_move				# is_valid_move(row, col)

	beq	$v0, 1, player_has_a_valid_move__return_true

player_has_a_valid_move__for_col__step:
	addi	$s1, 1					# col++
	b	player_has_a_valid_move__for_col__cond
player_has_a_valid_move__for_col__end:
player_has_a_valid_move__for_row__step:
	addi	$s0, 1					# row++
	b	player_has_a_valid_move__for_row__cond
player_has_a_valid_move__for_row__end:

player_has_a_valid_move__return_false:
	li	$v0, FALSE				# prepare to return FALSE
	b 	player_has_a_valid_move__epilogue
player_has_a_valid_move__return_true:
	li	$v0, TRUE				# prepare to return TRUE
	b 	player_has_a_valid_move__epilogue

player_has_a_valid_move__epilogue:
	pop	$s2
	pop	$s1
	pop	$s0
	pop	$ra
	end
	jr	$ra					# return;


################################################################################
# .TEXT <is_valid_move>
	.text
is_valid_move:
	# Args:
	#    - $a0: int row
	#    - $a1: int col
	#
	# Returns:
	#    - $v0: int
	#
	# Frame:    [$ra, $s0, $s1, $s2]
	# Uses:     [$v0, $a0, $a1, $s0, $s1, $s2, $t0, $t1]
	# Clobbers: [$v0, $a0, $a1, $t0, $t1]
	#
	# Locals:
	#   - $s0: row
	#   - $s1: col
	#   - $s2: direction
	#   - $t0: &board[row][col]
	#   - $t1: board[row][col]
	#
	# Structure:
	#   is_valid_move
	#   -> [prologue]
	#       -> body
	# 	   -> for_loop
	# 	   -> for_loop__init
	# 	   -> for_loop__cond
	# 	   -> for_loop__body
	# 	   -> for_loop__step
	# 	   -> for_loop__end
	#   -> [epilogue]

is_valid_move__prologue:
	begin
	push	$ra
	push	$s0
	push	$s1
	push	$s2
is_valid_move__body:
	move	$s0, $a0
	move	$s1, $a1

	mul	$t0, $s0, MAX_BOARD_SIZE		#  &board[row][col] = row * MAX_BOARD_SIZE
	add	$t0, $t0, $s1				#      + col
	addi	$t0, board				#      + &board

	lb	$t1, ($t0)				# board[row][col]
	bne	$t1, PLAYER_EMPTY, is_valid_move__return_false

is_valid_move__for_loop:
is_valid_move__for_loop__init:
	li	$s2, 0					# int direction = 0;
is_valid_move__for_loop__cond:
	# direction < NUM_DIRECTIONS			
	bge	$s2, NUM_DIRECTIONS, is_valid_move__for_loop__end			
is_valid_move__for_loop__body:
	
	move	$a0, $s0				# arguments = (row,
	move	$a1, $s1				#	       col,
	mul	$a2, $s2, SIZEOF_VECTOR			#	       &directions[direction] 	       
	addi	$a2, directions				#	      )
	jal	capture_amount_from_direction		# capture_amount_from_direction(arguments)

	bne	$v0, 0, is_valid_move__return_true
is_valid_move__for_loop__step:
	addi	$s2, 1					# direction++
	b	is_valid_move__for_loop__cond
is_valid_move__for_loop__end:

	b 	is_valid_move__return_false
is_valid_move__return_false:
	li	$v0, FALSE				# prepare to return FALSE
	b	is_valid_move__epilogue
is_valid_move__return_true:
	li	$v0, TRUE				# prepare to return TRUE
	b	is_valid_move__epilogue
is_valid_move__epilogue:
	pop	$s2
	pop	$s1
	pop	$s0
	pop	$ra
	end
	jr	$ra					# return;


################################################################################
# .TEXT <capture_amount_from_direction>
	.text
capture_amount_from_direction:
	# Args:
	#    - $a0: int row
	#    - $a1: int col
	#    - $a2: const vector *delta
	#
	# Returns:
	#    - $v0: unsigned int
	#
	# Frame:    [$ra, $s0, $s1, $s2]
	# Uses:     [$v0, $a0, $a1, $a2, $t0, $t1, $t2, $t3, $t4, $s0, $s1, $s2]
	# Clobbers: [$v0, $a0, $a1, $a2, $t0, $t1, $t2, $t3, $t4]
	#
	# Locals:
	#   - $s0: row
	#   - $s1: col
	#   - $s2: delta
	#   - $t0: opposite
	#   - $t1: line_length
	#   - $t2: temp (board_size, delta->row, delta->col, current_player)
	#   - $t3: &board[row][col]
	#   - $t4: board[row][col]
	
	#
	# Structure:
	#   capture_amount_from_direction
	#   -> [prologue]
	#       -> body
	#          -> while
	#          -> while__step
	#          -> while__end
	#          -> return__zero
	#   -> [epilogue]

capture_amount_from_direction__prologue:
	begin
	push	$ra
	push	$s0
	push	$s1
	push	$s2
capture_amount_from_direction__body:
	move	$s0, $a0
	move	$s1, $a1
	move	$s2, $a2

	jal	other_player				# jump to other_player
	move	$t0, $v0				# opposite = other_player()
	
	li	$t1, 0					# int line_length = 0
capture_amount_from_direction__while:
	lw	$t2, VECTOR_ROW_OFFSET($s2)		# delta->row	
	add	$s0, $s0, $t2				# row += delta->row;
	
	lw	$t2, VECTOR_COL_OFFSET($s2)		# delta->col	
	add	$s1, $s1, $t2				# col += delta->col;

	lw	$t2, board_size				# board_size

	# if (row < 0 
	blt	$s0, 0, capture_amount_from_direction__return__zero
	# || row >= board_size
	bge	$s0, $t2, capture_amount_from_direction__return__zero
	# || col < 0
	blt	$s1, 0, capture_amount_from_direction__return__zero
	# || col >= board_size)
	bge	$s1, $t2, capture_amount_from_direction__return__zero

	mul	$t3, $s0, MAX_BOARD_SIZE		#  &board[row][col] = row * MAX_BOARD_SIZE
	add	$t3, $t3, $s1				#      + col
	addi	$t3, board				#      + &board
	lb	$t4, ($t3)				# board[row][col]

	# if (board[row][col] != opposite)
	bne	$t4, $t0, capture_amount_from_direction__while__end

capture_amount_from_direction__while__step:
	addi	$t1, 1					# line_length++
	b	capture_amount_from_direction__while
capture_amount_from_direction__while__end:
	lw	$t2, current_player
	# if (board[row][col] != current_player)
	bne	$t4, $t2, capture_amount_from_direction__return__zero

	move	$v0, $t1				# prepare to return line length
	b 	capture_amount_from_direction__epilogue	# return line_length;
capture_amount_from_direction__return__zero:
	li	$v0, 0
	b	capture_amount_from_direction__epilogue
capture_amount_from_direction__epilogue:
	pop	$s2
	pop	$s1
	pop	$s0
	pop	$ra
	end
	jr	$ra					# return;


################################################################################
# .TEXT <other_player>
	.text
other_player:
	# Args:     void
	#
	# Returns:
	#    - $v0: int
	#
	# Frame:    [$ra]
	# Uses:     [$v0, $t0]
	# Clobbers: [$v0, $t0]
	#
	# Locals:
	#   - $t0: current_player
	#
	# Structure:
	#   other_player
	#   -> [prologue]
	#       -> body
	#	   -> return_black
	#	   -> return_white
	#   -> [epilogue]

other_player__prologue:
	begin
other_player__body:
	lb	$t0, current_player			# current_player
	# if (current_player == PLAYER_WHITE)
	beq	$t0, PLAYER_WHITE, other_player__return_black		
	b	other_player__return_white		# else
other_player__return_black:
	li	$v0, PLAYER_BLACK			# prepare to return PLAYER_BLACK
	b	other_player__epilogue	
other_player__return_white:
	li	$v0, PLAYER_WHITE			# prepare to return PLAYER_WHITE
	b	other_player__epilogue
other_player__epilogue:
	end
	jr	$ra					# return;


################################################################################
# .TEXT <current_player_str>
	.text
current_player_str:
	# Args:     void
	#
	# Returns:
	#    - $v0: const char *
	#
	# Frame:    [$ra]
	# Uses:     [$v0, $t0]
	# Clobbers: [$v0, $t0]
	#
	# Locals:
	#   - $t0: current_player
	#
	# Structure:
	#   current_player_str
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

current_player_str__prologue:
	begin
current_player_str__body:
	lb	$t0, current_player			# current_player
	# if (current_player == PLAYER_WHITE)
	beq	$t0, PLAYER_WHITE, current_player_str__return_white		
	b	current_player_str__return_black	# else
current_player_str__return_black:
	li	$v0, black_str				# prepare to return "black"
	b	current_player_str__epilogue	
current_player_str__return_white:
	li	$v0, white_str				# prepare to return "white"
	b	current_player_str__epilogue
current_player_str__epilogue:
	end
	jr	$ra					# return;


################################################################################
################################################################################
###                    PROVIDED FUNCTION — DO NOT CHANGE                     ###
################################################################################
################################################################################

################################################################################
# .TEXT <print_board>
# YOU DO NOT NEED TO CHANGE THE print_board FUNCTION
	.text
print_board:
	# Args: void
	#
	# Returns:  void
	#
	# Frame:    [$ra, $s0, $s1]
	# Uses:     [$a0, $v0, $t2, $t3, $t4, $s0, $s1]
	# Clobbers: [$a0, $v0, $t2, $t3, $t4]
	#
	# Locals:
	#   - $s0: col
	#   - $s1: row
	#   - $t2: board_size, row + 1
	#   - $t3: &board[row][col]
	#   - $t4: board[row][col]
	#
	# Structure:
	#   print_board
	#   -> [prologue]
	#   -> body
	#      -> header_loop
	#      -> header_loop__init
	#      -> header_loop__cond
	#      -> header_loop__body
	#      -> header_loop__step
	#      -> header_loop__end
	#      -> for_row
	#      -> for_row__init
	#      -> for_row__cond
	#      -> for_row__body
	#          -> print_row_num
	#          -> for_col
	#          -> for_col__init
	#          -> for_col__cond
	#          -> for_col__body
	#              -> white
	#              -> black
	#              -> possible_move
	#              -> output_cell
	#          -> for_col__step
	#          -> for_col__end
	#      -> for_row__step
	#      -> for_row__end
	#   -> [epilogue]

print_board__prologue:
	begin
	push	$ra
	push	$s0
	push	$s1

print_board__body:
	li	$v0, 4
	la	$a0, board_str
	syscall						# printf("Board:\n   ");

print_board__header_loop:
print_board__header_loop__init:
	li	$s0, 0					# int col = 0;

print_board__header_loop__cond:
	lw	$s1, board_size
	bge	$s0, $s1, print_board__header_loop__end # while (col < board_size) {

print_board__header_loop__body:
	li	$v0, 11
	addi	$a0, $s0, 'A'
	syscall						#     printf("%c", 'A' + col);

	li	$a0, ' '
	syscall						#     putchar(' ');

print_board__header_loop__step:
	addi	$s0, $s0, 1				#     col++;
	b	print_board__header_loop__cond		# }

print_board__header_loop__end:
	li	$v0, 11
	li	$a0, '\n'
	syscall						# printf("\n");

print_board__for_row:
print_board__for_row__init:
	li	$s0, 0					# int row = 0;

print_board__for_row__cond:
	lw	$t2, board_size
	bge	$s0, $t2, print_board__for_row__end	# while (row < board_size) {

print_board__for_row__body:
	addi	$t2, $s0, 1
	bge	$t2, 10, print_board__print_row_num	#     if (row + 1 < 10) {

	li	$v0, 11
	li	$a0, ' '
	syscall						#         printf("%d ", row + 1);

print_board__print_row_num:				#     }
	li	$v0, 1
	move	$a0, $t2
	syscall						#     printf("%d", row + 1);

	li	$v0, 11
	li	$a0, ' '
	syscall						#     putchar(' ');

print_board__for_col:
print_board__for_col__init:
	li	$s1, 0					#     int col = 0;

print_board__for_col__cond:
	lw	$t2, board_size
	bge	$s1, $t2, print_board__for_col__end	#     while (col < board_size) {

print_board__for_col__body:
	mul	$t3, $s0, MAX_BOARD_SIZE		#         &board[row][col] = row * MAX_BOARD_SIZE
	add	$t3, $t3, $s1				#                            + col
	addi	$t3, board				#                            + &board

	lb	$t4, ($t3)				#         char cell = board[row][col];

	beq	$t4, PLAYER_WHITE, print_board__white	#         if (cell == PLAYER_WHITE) goto print_board__white;
	beq	$t4, PLAYER_BLACK, print_board__black	#         if (cell == PLAYER_BLACK) goto print_board__black;

	move	$a0, $s0
	move	$a1, $s1
	jal	is_valid_move
	bnez	$v0, print_board__possible_move		#         if (is_valid_move(row, col)) goto print_board__possible_move;

	li	$a0, EMPTY_CELL_CHAR			#         c = EMPTY_CELL_CHAR;
	b	print_board__output_cell		#         goto print_board__output_cell;

print_board__white:
	li	$a0, WHITE_CHAR				#         c = WHITE_CHAR;
	b	print_board__output_cell		#         goto print_board__output_cell;

print_board__black:
	li	$a0, BLACK_CHAR				#         c = BLACK_CHAR;
	b	print_board__output_cell		#         goto print_board__output_cell;

print_board__possible_move:
	li	$a0, POSSIBLE_MOVE_CHAR			#         c = POSSIBLE_MOVE_CHAR;
	b	print_board__output_cell		#         goto print_board__output_cell;

print_board__output_cell:
	li	$v0, 11
	syscall						#         printf("%c", c);

	li	$a0, ' '
	syscall						#         putchar(' ');

print_board__for_col__step:
	addi	$s1, $s1, 1				#         col++;
	b	print_board__for_col__cond		#     }

print_board__for_col__end:
	li	$v0, 11
	li	$a0, '\n'
	syscall						#     putchar('\n');

print_board__for_row__step:
	addi	$s0, $s0, 1				#     row++;
	b	print_board__for_row__cond		# }

print_board__for_row__end:
print_board__epilogue:
	pop	$s1
	pop	$s0
	pop	$ra
	end
	jr	$ra					# return;

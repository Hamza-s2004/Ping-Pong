[org 0x0100]
jmp main_starting
;;;;;;;;;;;;;;;;DATA;;;;;;;;;;;;;;;;;;;;;;;;
Original_Ball_Location: dw 2000 ;12th row nad 40th column it will be used to restore starrting value of ball

ball: dw 2000 ;12th row and 40th column

pattern_choice: dw 0 ;this will be used to check that user want pattern or not 0 means not and 1 means allowed

direction_ball: dw 164 ;direction of ball (ball movement depends on this)

pattern_choice_ask: dw 'Enter P for patterns or enter N if you do not want it..'
pattern_choice_length: dw 55

left_paddle: dw 640 ;left paddle position
right_paddle: dw 798 ;right paddle position

player_1_score: dw 0
player_2_score: dw 0

player_1_won: dw 'PLAYER 1 WON!!!!!!!!!!'
player_2_won: dw 'PLAYER 2 WON!!!!!!!!!!'
player_won_length: dw 22
restart_game: dw 'Press r to restart the game or press e to exit the game'
restart_game_length: dw 55

pattern_1: dw 510 
pattern_2: dw 550
pattern_3: dw 600

upper_wall: dw 320
lower_wall: dw 3678

welcome: dw 'WELCOME TO THE PING PONG GAME!!!!!!'
welcome_length: dw 35

creator: db 'Hamza Shabbir 23F-0546              Rana Rajab 23F-0624' 
creator_length: dw 55
;;;;;;;;;;;;;;;;Now the subroutines start;;;;;;;;;;;;;;;


delay:
	push cx
	mov cx,0FFFFh
	delay_loop1:
		loop delay_loop1
	mov cx,0FFFFh
	delay_loop2:
		loop delay_loop2
	pop cx
	ret





clrScreen: ;this will work clearing the screen
	push es
	push di
	push ax
	push cx
	mov ax,0xb800
	mov es,ax
	mov cx,2000 ;because we want to reach di 4000
	cld
	xor di,di ;mov di,0
	mov ax, 0x0720 ;space 
	rep stosw ;this will print spaces
	pop cx
	pop ax
	pop di
	pop es

	ret








pause_game:
	push ax
	
	pausing_game_loop:

		;checking which key is pressed now
		mov ah,0h
		int 16h

		cmp ah,0x19 ;'P'
		jne pausing_game_loop

	pause_game_end:
		pop ax
		ret

draw_welcome:
	push ax
	push cx
	push si
	push es
	push di
	mov ax,0xb800
	mov es,ax
	xor ax,ax
	mov ah,0x04
	mov cx,[welcome_length]
	mov di,686
	mov si,welcome ;welcome is string
	welcome_loop:
		lodsb
		stosw
		loop welcome_loop
	welcome_loop_end:
	pop di
	pop es
	pop si
	pop cx
	pop ax
	ret




		
draw_pattern_choice: ;this will print pattern choice string
	push ax
	push cx
	push si
	push es
	push di
	mov ax,0xb800
	mov es,ax
	mov si,pattern_choice_ask
	mov cx,[pattern_choice_length]
	mov di,1140
	mov ah,0x07
	draw_pattern_choice_loop:
		lodsb
		stosw
		loop draw_pattern_choice_loop
	pop di
	pop es
	pop si
	pop cx
	pop ax
	ret



draw_score:
	push ax
	push es
	push di
	mov ax,0xb800
	mov es,ax
	mov di,170
	mov ax,[player_1_score]
	mov ah,0x07
	add al,0x30
	mov [es:di],ax
	mov di,308
	xor ax,ax
	mov ax,[player_2_score]
	mov ah,0x07
	add al,0x30

	mov [es:di],ax
	pop di
	pop es
	pop ax
	ret


draw_pattern: ;this will print patterns 
	push bp
	mov bp,sp
	push ax
	push di
	push es


	mov di,[bp+4] ;it has location that where we will print ( di = location )
	mov ax,0xb800
	mov es,ax
	mov cx,2
	wave_loop:
		mov word[es:di],0x075E
		add di,162
		mov word[es:di],0x075E
		sub di,158
		mov word[es:di],0x075E
		loop wave_loop
	pop es
	pop di
	pop ax
	pop bp

	ret 2



draw_player_won:
	push bp
	mov bp,sp
	push ax
	push cx
	push si
	push es
	push di
	mov ax,0xb800
	mov es,ax
	xor ax,ax
	mov di,830 ;(5*160)+30
	mov ah,0x07
	mov si,[bp+6];player won string 
	mov cx,[bp+4];player won length
	player_won_loop:
		lodsb
		stosw
		loop player_won_loop

	player_won_end:
	pop di
	pop es
	pop si
	pop cx
	pop ax
	pop bp
	ret 4

draw_restart_exit_option:
	push ax
	push es
	push di
	push si

	mov ax,0xb800
	mov es,ax
	mov di,830
	add di,160
	mov ah,0x07
	mov si,restart_game
	mov cx,[restart_game_length]
	draw_restart_game_loop:
		lodsb
		stosw
		loop draw_restart_game_loop
	restart_game_loop_end:
		pop si
		pop di
		pop es
		pop ax
		ret	

draw_creator:
	push ax
	push cx
	push si
	push es
	push di
	mov ax,0xb800
	mov es,ax
	xor ax,ax
	mov di,3700;(23*160)+20
	mov si,creator
	mov cx,[creator_length]
	mov ah,0x07
	creator_loop:
		lodsb
		stosw
		loop creator_loop

	pop di
	pop es
	pop si
	pop cx
	pop ax
	ret




draw_boundary:
	push es
	push di
	push ax
	push cx
	mov ax,0xb800
	mov es,ax
	std ;i did this becuase lower_wall if porint to the end of lower wall so we need to print it reversely
	mov di,[lower_wall]
	mov cx,80
	mov ax,0x042D
	rep stosw

	cld
	mov di,[upper_wall]
	mov cx,80
	mov ax,0x042D
	rep stosw
	pop cx
	pop ax
	pop di
	pop es
	ret




draw_ball:
	push ax
	push es
	push di
	mov ax,0xb800
	mov es,ax
	xor di,di
	mov di,[ball] ;di = position of ball
	mov word[es:di],0x024F ;02 for green color and 4F for 'O'
	pop di
	pop es
	pop ax
	ret

	
draw_paddle:
	push ax
	push es
	push di

	mov ax,0xb800
	mov es,ax
	xor di,di


	;i have used 0x097C where 09 is for blue color + intensity and 7C is for this: |

	;printing left paddle
	mov di,[left_paddle]
	sub di,160 ;for printing upper part of paddle
	mov word[es:di],0x097C
	add di,160 ;for printing middle part of paddle
	mov word[es:di],0x097C
	add di,160
	mov word[es:di],0x097C ;for printing lower part of paddle

	;printing right paddle
	mov di,[right_paddle]
	sub di,160 ;for printing upper part of paddle
	mov word[es:di],0x097C
	add di,160 ;for printing middle part of paddle
	mov word[es:di],0x097C
	add di,160 ;for printing lower part of paddle
	mov word[es:di],0x097C
	pop di
	pop es
	pop ax
	ret


	reset_ball_position:

		push ax
		mov ax,[Original_Ball_Location]
		mov [ball],ax
		pop ax
		ret


	check_ball_crossed_left_right_and_increase_score_count:
		push ax
		push bx
		push dx
		xor dx,dx
		mov bx,160
		mov ax,[ball]
		div bx
		cmp dx,0
		jne player_1_checking
		;why i am comparing these direction balls because i dont why but my code is incrementing fr player 2 even if the ball crosses the right boundary it counts score for player 2
		; so using cmp with directions checks if it is the score for player1 or for player 2. In the right colum the ball will come with direction of 164, -156 so i am using these compares to check i am on left or right column
		cmp word[direction_ball],164
		je player_1_increment
		cmp word[direction_ball],-156
		je player_1_increment
		mov ax,[player_2_score]
		inc ax
		mov [player_2_score],ax
		call reset_ball_position



		
		player_1_checking:
		xor dx,dx
		mov bx,160
		mov ax,[ball]
		add ax,2
		div bx
		cmp dx,2
		jne end_checking_left_right
		player_1_increment:
		mov ax,[player_1_score]
		inc ax
		mov [player_1_score],ax
		call reset_ball_position
		jmp end_checking_left_right
		
		end_checking_left_right:
			pop dx
			pop bx
			pop ax
			ret




	



;this subroutine is used to move ball (checking if ball has crossed boundaries to reflect it back or ball is collied with paddle so that it will be reflected back by paddle)
move_ball:

	push ax
	push dx

	;after every paddle collision i jmped to the boundary crossing because if the ball is coming to the cornors then after paddle collision it will go out of boundary so we will check it to fix this problem :)
	;now checking collision of ball with paddle
	check_left_paddle_collision:
		
		;checking collision of ball with middle part of paddle
		mov ax,[left_paddle]
		add ax,4
		;this is what i understand for this to make collision visible
		;we add 4 to make ball collision visible because if ball will come with direction of -164, 156 so there is a gap of 4 thats why we added 4 so that we can see collision visibly
		cmp [ball],ax
		jne check_left_paddle_upper_part_collision ;if it is not equal then it means we need to check for upper part
		add word[direction_ball],8
		jmp boundary_crossing_checker

	check_left_paddle_upper_part_collision:
		;remember ax have left paddle middle part
		sub ax,160 ;to make ax point to the upper part of left paddle
		cmp [ball],ax
		jne check_left_paddle_lower_part_collision ;if it is not equal then we need to check for lower part of paddle
		add word[direction_ball],8
		jmp boundary_crossing_checker

	check_left_paddle_lower_part_collision:
		;remember ax have upper part of paddle
		add ax,320 ;adding 320 becuase ax is position at upper part and we have middle part also so if we add 160 ie will point middle part thats why we added 320 to point lower part
		cmp [ball],ax
		jne check_right_paddle_collision ;if it is not equal thats means left paddle has no problem so now we will check for upper part
		add word[direction_ball],8
		jmp boundary_crossing_checker

		;now checking collision with right paddle

	check_right_paddle_collision:

		mov ax,[right_paddle]
		sub ax,2 
		;this is what i understand for this to make collision visible
		;we subtracted 2 to make ball collision visible because if ball will come with direction of 164, -156 so there is a gap of 2 in di thats why we subtracted 2 so that we can see collision visibly
		cmp [ball],ax
		jne check_right_paddle_upper_part_collision ;if this is not equal then we need to check for upper part
		sub word[direction_ball],8
		jmp boundary_crossing_checker

	check_right_paddle_upper_part_collision:
		;remember ax have right paddle middle part
		sub ax,160 ;to make ax point to the upper part of right paddle
		cmp [ball],ax
		jne check_right_paddle_lower_part_collision ;if this is not equal than we need to check for lower part
		sub word[direction_ball],8
		jmp boundary_crossing_checker

	check_right_paddle_lower_part_collision:
		;remember ax have upper part of right paddle
		add ax,320 ;adding 320 becuase ax is position at upper part and we have middle part also so if we add 160 it will point middle part thats why we added 320 to point lower part
		cmp [ball],ax
		jne boundary_crossing_checker ;if it is not equal then there is nothing to check thats why we go to the move_ball_end
		sub word[direction_ball],8
		jmp boundary_crossing_checker

	boundary_crossing_checker:
	;why did not we added ball with direction at the start of subroutine (function) because first we need to check that after adding ball with direction it is crossing boundaries or not

		mov ax,[direction_ball] ;ax= direction_ball
		mov dx, [ball] ;dx=ball
		add dx,ax ;ball=ball+direction (ball is dx)
		mov ax,[upper_wall]
		add ax,160
		cmp dx,ax ;comparing with upper_wall to check if it crosses the upper wall
		jge check_bottom_boundry ;if it is greater than upper_wall it means it is correct no need to make changes so we will go to check bottom boundary

		add word[direction_ball],320 ;direction_ball = direction_ball + 320
		jmp move_ball_end
	check_bottom_boundry:
		;remember dx have ball = ball+direction
		mov ax,[lower_wall]
		sub ax,160
		cmp dx,ax ; comparing dx with lower_wall to check if it has crossed the bottom wall
		jle move_ball_end ;if it is lesser so it means it is going good so no need to make changes so we will go to the end

		sub word[direction_ball],320
		jmp move_ball_end

	move_ball_end:
		mov ax,[direction_ball] ;ax = direction_ball
		add [ball],ax ;ball = ball + direction_ball
	
		pop dx
		pop ax
		ret


move_paddle:
	push ax
	push dx
	;left paddle movement
	;checking if any key is pressed or not

	mov ah,1h
	int 16h
	jz check_right_paddle_movement ;if ZF=1 then jump because it means no key is pressed

	;checking which key is pressed now
	mov ah,0h
	int 16h
	
	;ah will have the ascii of character which is pressed

	cmp ah,0x19 ;'P'
	jne check_for_w
	;before pausing we need to print ball, score and creator name
	call draw_ball
	call draw_score
	;drawing my name (Hamza) and group partner name: (Rajab) with roll numbers
	call draw_creator
	call pause_game

	check_for_w:

	cmp ah,0x11 ;'W'
	je move_left_paddle_up

	cmp ah,0x1F ;'S'
	je move_left_paddle_down
	jmp check_right_paddle_movement

	move_left_paddle_up:
		mov dx,[upper_wall]
		add dx,320 ;to point 2nd line and we did this becuase paddle is pointing middle part so it should go max up to 2nd row otherwise upper part will go out pf boundary
		cmp word[left_paddle],dx ;comparing left paddle position with dx (which is 2nd row of the boundary) because paddle position is pointing middle element but we have upper part of paddle also which will be at 1st row of boundary
		je end_paddle_movement ;jump if equal because it means we cannot go more up otherwise paddle will go out of screen
		sub word[left_paddle],160 ;making paddle go up by moving it 1 row up by subtracting 160
		jmp end_paddle_movement


	move_left_paddle_down:
		mov dx,[lower_wall] ;lower wall is pointing end of boundary
		sub dx,158 ;to make dx point to the start of boundary
		sub dx,320 ;i subtracted 320 because if i do sub 160 then it wil lpoint last last line of boundary but we need to compare it paddle and paddle is pointing middle part so thats why i did 320 to check if paddle is at end so we will not move it further down
		cmp word[left_paddle],dx ;comparing left paddle position with dx (which is 2nd last row of boundary) becuase paddle position is pointing middle element and we have lower part also which will be at last row of boundary
		je end_paddle_movement ;jump if equal because it means we cannot go more down otherwise paddle will go out of screen
		add word[left_paddle],160 ;making paddle go down by moving it 1 row down by adding 160
		jmp end_paddle_movement


	check_right_paddle_movement:

	;right paddle movement
	
	; remember ah will have the ascii of character which is pressed

	cmp ah,0x48 ;'up arrow'
	je move_right_paddle_up

	cmp ah,0x50 ;'down arrow'
	je move_right_paddle_down
	jmp end_paddle_movement

	move_right_paddle_up:
		mov dx,[upper_wall]
		add dx,158 ;to go to the end of upper boundary
		add dx,320 ;to go to 2nd row becuase paddle if pointing at middle part and middle part cannot go further up othwerwise upper part of paddle will go out of boundary
		cmp word[right_paddle],dx ;comparing right paddle position with dx (which is end of 2nd row end of boundary) because paddle position is pointing middle element but we have upper part of paddle also which will be at 1st row of boundary
		je end_paddle_movement ;jump if equal because it means we cannot go more up otherwise paddle will go out of screen
		sub word[right_paddle],160 ;making paddle go up by moving it 1 row up by subtracting 160
		jmp end_paddle_movement


	move_right_paddle_down:
		mov dx,[lower_wall]
		sub dx,320 ;to point 2 nd last row end and paddle is pointing middle part so middle part cannot go more down than 2nd last row because otherwise the lower part will go out of boundary
		cmp word[right_paddle],dx ;comparing right paddle position with dx (which is end of 2rd last row of boundary) becuase paddle position is pointing middle element and we have lower part also which will be at last row of boundry
		je end_paddle_movement ;jump if equal because it means we cannot go more down otherwise paddle will go out of screen
		add word[right_paddle],160 ;making paddle go down by moving it 1 row down by adding 160

	end_paddle_movement:
	pop dx
	pop ax
	ret

check_user_choice_about_pattern_and_update_it:
	push ax
	xor ax,ax
	checker:
	mov ah,1h
	int 16h
	;checking if user is pressing any key or not if not then again loop start so that we will wait for user input
	jz checker ;if ZF=1 then jump because it means no key is pressed

	mov ah,0h
	int 16h
	
	;ah will have ascii of character which user has entered
	cmp ah,0x19;'P'
	jne check_for_N
	mov word[pattern_choice],1
	jmp check_user_choice_about_pattern_and_update_it_end
	check_for_N: ;we are checking n that user has not allowed pattern
	cmp ah,0x31;'N'
	jne checker
	check_user_choice_about_pattern_and_update_it_end:
	pop ax
	ret

	


	
fix_pattern_crossing_boundary:
	push bp
	mov bp,sp
	push dx
	push bx
	push ax

	mov bx,[bp+6] ;bx have pattern address
	mov dx,[bp+4] ;dx have di value
	mov ax,[upper_wall]
	mov [bx],ax ;now again starting pattern from above
	add [bx],dx

	check_pattern_next:
		pop ax
		pop bx
		pop dx
		pop bp

		ret 4



main_starting:

call clrScreen
call draw_welcome
call draw_creator
call draw_pattern_choice
call check_user_choice_about_pattern_and_update_it




main_start:
	mov word[player_1_score],0
	mov word[player_2_score],0
	main_loop:
		call delay
		call delay
		call clrScreen

		cmp word[pattern_choice],1 ;we are checking that user want to print pattern or not if it is 0 it means user has not allowed to print pattern and if it is 1 it means user has allowed pattern
		jne main_next

		;this is used to print pattern
		mov ax,[pattern_1]
		push ax
		call draw_pattern
		;adding 160 to get to next line
		add word[pattern_1],160
		;checking if pattern is crossing boundary or not
		mov ax,[lower_wall]
		cmp [pattern_1],ax
		jl pattern_2_print ;comparing if the pattern has crossed the boundary or not

		mov ax,pattern_1
		push ax
		mov ax,190
		push ax
		call fix_pattern_crossing_boundary ;this is used to fix pattern crossing boundary problem

		;print pattern 2
		pattern_2_print:
		mov ax,[pattern_2]
		push ax
		call draw_pattern ;i have pushed pattern size
		add word[pattern_2],160 
		mov ax,[lower_wall]
		cmp [pattern_2],ax
		jl pattern_3_print ;comparing if the pattern has crossed the boundary or not
		mov ax,pattern_2
		push ax
		mov ax,230
		push ax
		call fix_pattern_crossing_boundary ;this is used to fix pattern crossing boundary problem

		;printing pattern 3
		pattern_3_print:
		mov ax,[pattern_3]
		push ax
		call draw_pattern
		add word[pattern_3],160
		mov ax,[lower_wall]
		cmp [pattern_3],ax
		jl main_next ;comparing if the pattern has crossed the boundary or not
		mov ax,pattern_3
		push ax
		mov ax,280
		push ax
		call fix_pattern_crossing_boundary ;this is used to fix pattern crossing boundary problem



		main_next:
		call draw_boundary
		
		;drawing and moving paddle
		call draw_paddle
		call move_paddle
		
		;drawing and moving ball
		call draw_ball
		call move_ball

		
		;drawing score of players
		call draw_score
		;drawing my name (Hamza) and group partner name: (Rajab) with roll numbers
		call draw_creator

		call check_ball_crossed_left_right_and_increase_score_count ;this will check left right boundary and increases the score of players
		;checking score if it is grather or equal than 5 or not
		cmp word[player_1_score],5
		jl player2_score_check ;if it is less then checking player 2 score
		mov ax,player_1_won ;pushing string 
		push ax
		mov ax,[player_won_length] ;pushing string size
		push ax
		jmp draw_player_won_and_check_for_restart_or_exit_loop ;jumping to the end because player 1 has won and now we need to print and show choice for exit and restart

		player2_score_check: ;checking if player 2 has won or not
		;again checking score
		cmp word[player_2_score],5 ;i have condition of 5 score
		jl main_loop
		;passing parameters for function to print player 2 won
		mov ax,player_2_won
		push ax
		mov ax,[player_won_length]
		push ax
	;reason of pushing this is because i have made 1 subroutine for both printing player won

	draw_player_won_and_check_for_restart_or_exit_loop:
		call clrScreen
		call draw_player_won ;calling to draw who won (i have pushed player string address and length above ) 
		call draw_restart_exit_option ;this will draw restart and exit option
		;checking which key is pressed now
		checker_for_exit_restart_game:
		mov ah,0h
		int 16h
	
		;ah will have the ascii of character which is pressed

		cmp ah,0x13 ;'r' ;it is for restarting the gmae
		je main_start
		cmp ah,0x12 ;'e' it is to exit game
		jne checker_for_exit_restart_game ;we did this to make infinite loop until user enter r or e 

	main_loop_end:

	mov ax,0x4c00
	int 0x21


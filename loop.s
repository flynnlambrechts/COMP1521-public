# x $t0

main
	#int xx = 24;
	li $t0, 24
loop_start:
	bge $t0, 42, loop_end

	# print x


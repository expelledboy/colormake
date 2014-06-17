all:
	#-----------------------> test1
	@./colormake.sh test1
	#-----------------------> test2
	@./colormake.sh test2
	#-----------------------> test3
	@-./colormake.sh test3
	#-----------------------> test4
	@-./colormake.sh test4
	#-----------------------> done
	

test1:
	# make comments

test2:
	echo "warn: issue"
	echo "error: issue"

test3:
	$(error issue)

test4:
	crash

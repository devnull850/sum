NAME = sum

all: $(NAME).o
	ld -o $(NAME) -T $(NAME).ld $(NAME).o

$(NAME).o: $(NAME).s
	as -o $(NAME).o $(NAME).s

clean:
	rm $(NAME) $(NAME).o

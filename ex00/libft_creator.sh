#!/bin/sh

# Compile all source files
cc -Wall -Wextra -Werror -Iincludes -c ft_putchar.c
cc -Wall -Wextra -Werror -Iincludes -c ft_swap.c
cc -Wall -Wextra -Werror -Iincludes -c ft_putstr.c
cc -Wall -Wextra -Werror -Iincludes -c ft_strlen.c
cc -Wall -Wextra -Werror -Iincludes -c ft_strcmp.c

# Create library
ar rcs libft.a ft_putchar.o ft_swap.o ft_putstr.o ft_strlen.o ft_strcmp.o

# Clean intermediate files
rm -f ft_putchar.o ft_swap.o ft_putstr.o ft_strlen.o ft_strcmp.o

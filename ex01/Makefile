# Compiler and flags
CC = cc
CFLAGS = -Wall -Wextra -Werror
INCLUDES = -Iincludes

# Project structure
SRCS_DIR = srcs
SRCS = ft_putchar.c ft_swap.c ft_putstr.c ft_strlen.c ft_strcmp.c
OBJS = $(addprefix $(SRCS_DIR)/, $(SRCS:.c=.o))
DEPENDS = $(OBJS:.o=.d)
LIB = libft.a

# Default rule (compile library)
all: $(LIB)

# Link library from object files
$(LIB): $(OBJS)
	ar rcs $@ $^

# Compile .c to .o with header dependencies
$(SRCS_DIR)/%.o: $(SRCS_DIR)/%.c
	$(CC) $(CFLAGS) $(INCLUDES) -MMD -c $< -o $@

# Clean temporary files
clean:
	rm -f $(OBJS) $(DEPENDS)

# Full clean (objects + library)
fclean: clean
	rm -f $(LIB)

# Rebuild from scratch
re: fclean all

# Include auto-generated dependencies
-include $(DEPENDS)

.PHONY: all clean fclean re

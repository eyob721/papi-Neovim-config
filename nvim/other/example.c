#include <stdio.h>
#include <stdlib.h>

/**
 *
 *
 */
int main(void)
{
	char *str = NULL;

	str = malloc(sizeof(char));
	if (!str)
	{
		exit(1);
	}
	return EXIT_SUCCESS;
}

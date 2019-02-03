PREFIX=		/usr/local
MANPREFIX=	${PREFIX}/man

#CC=

CFLAGS=		-march=native -DSHELL=\"$SHELL\"
LDFLAGS=	-s -static

SRC=		stty.c
OBJ=		${SRC:.c=.o}

all: stty

.c.o:
	@echo CC $<
	@${CC} -c ${CFLAGS} $<

${OBJ}: pathconf.h

stty: ${OBJ}
	@echo CC -o $@
	@${CC} -o $@ ${OBJ} ${LDFLAGS}

install: all
	@echo "Installing in ${PREFIX}"
	@install -Dm755 stty ${PREFIX}/bin
	@install -Dm644 stty.1 ${MANPREFIX}/man1

clean:
	rm -f *.o stty

uninstall:
	@echo "Uninstalling from ${PREFIX}"
	@rm -f ${PREFIX}/bin/stty
	@rm -f ${MANPREFIX}/man1/stty.1

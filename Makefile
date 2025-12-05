CC = gcc
all: bin/manager_main bin/worker_main bin/clock_main bin/user_main bin/ticket_dispenser_main bin/add_users_main
CFLAGS = -g -Wall -Wvla -Wextra -Werror -Wpedantic -Wconversion -Wstrict-prototypes -Wsign-conversion -D_GNU_SOURCE -Iinclude/

INCLUDES = include/*.h

COMMON_DEPS = $(INCLUDES)

PROJ_DEPS = build/utils.o build/config.o build/sem.o build/msg.o build/shm.o build/ftok_key.o build/log.o build/calendar.o build/notification.o

build/%.o: src/%.c $(COMMON_DEPS)
	$(CC) $(CFLAGS) -c $< -o $@

bin/manager_main: build/manager_main.o build/sem_utils.o build/seats.o build/stats_handler.o $(PROJ_DEPS)
	$(CC) $(CFLAGS) -o bin/manager_main build/manager_main.o build/sem_utils.o build/seats.o build/stats_handler.o $(PROJ_DEPS)

bin/worker_main: build/worker_main.o build/sem_utils.o build/seats.o build/worker.o $(PROJ_DEPS)
	$(CC) $(CFLAGS) -o bin/worker_main build/worker_main.o build/sem_utils.o build/seats.o build/worker.o $(PROJ_DEPS)

bin/clock_main: build/clock_main.o build/sem_utils.o build/clock.o $(PROJ_DEPS)
	$(CC) $(CFLAGS) -o bin/clock_main build/clock_main.o build/sem_utils.o build/clock.o $(PROJ_DEPS)

bin/user_main: build/user_main.o build/sem_utils.o build/user.o $(PROJ_DEPS)
	$(CC) $(CFLAGS) -o bin/user_main build/user_main.o build/sem_utils.o build/user.o $(PROJ_DEPS)

bin/ticket_dispenser_main: build/ticket_dispenser_main.o build/sem_utils.o build/seats.o build/ticket_dispenser.o $(PROJ_DEPS)
	$(CC) $(CFLAGS) -o bin/ticket_dispenser_main build/ticket_dispenser_main.o build/sem_utils.o build/seats.o build/ticket_dispenser.o $(PROJ_DEPS)

bin/add_users_main: build/add_users_main.o build/sem_utils.o $(PROJ_DEPS)
	$(CC) $(CFLAGS) -o bin/add_users_main build/add_users_main.o build/sem_utils.o $(PROJ_DEPS)

clean:
	rm -f build/* bin/*


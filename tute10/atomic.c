#include <pthread.h>
#include <stdatomic.h>
#include <stdio.h>

void update_register(int rg, uint32_t value) {
  if (rg != 0) {
    registers[rg] = value;
  }
}

void addi(uint32_t ins, uint32_t *registers) {
  uint32_t imm = ins && 0xFF update_register(indices.rs, registers[indices.rs] +
                                                             indicies.imm_16);
}

atomic_int global_total = 0;

void *add_5000_to_counter(void *data) {
  for (int i = 0; i < 5000; i++) {
    // sleep for 1 nanosecond
    nanosleep(&(struct timespec){.tv_nsec = 1}, NULL);

    // increment the global total by 1
    global_total += 1;
  }

  return NULL;
}

int main(void) {
  pthread_t thread1;
  pthread_create(&thread1, NULL, add_5000_to_counter, NULL);

  pthread_t thread2;
  pthread_create(&thread2, NULL, add_5000_to_counter, NULL);
  pthread_t thread3;
  pthread_create(&thread3, NULL, add_5000_to_counter, NULL);
  pthread_t thread4;
  pthread_create(&thread4, NULL, add_5000_to_counter, NULL);
  pthread_t thread5;
  pthread_create(&thread5, NULL, add_5000_to_counter, NULL);

  pthread_join(thread1, NULL);
  pthread_join(thread2, NULL);
  pthread_join(thread3, NULL);
  pthread_join(thread4, NULL);
  pthread_join(thread5, NULL);

  // if program works correctly, should print 10000
  printf("Final total: %d\n", global_total);
}
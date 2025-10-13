#define READING 0x01
#define WRITING 0x02
#define AS_BYTES 0x04
#define AS_BLOCKS 0x08
#define LOCKED 0x10

// mark the device as locked for writing blocks
unsigned char device = LOCKED | WRITING | AS_BLOCKS;

// set the device as locked, leaving other flags unchanged
device = device | LOCKED;

// remove the lock on a device, leaving other flags unchanged
device = device & (~LOCKED);

// swap a device between reading and writing, leaving other flags unchanged
device = device ^ (READING | WRITING)
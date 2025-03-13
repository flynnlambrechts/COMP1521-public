int cube[4][4][4];

int nzeroes = 0;
for (int x = 0; x < 4; x++)
    for (int y = 0; y < 4; y++)
        for (int z = 0; z < 4; z++)
            if (cube[x][y][z] == 0)
                nzeroes++;
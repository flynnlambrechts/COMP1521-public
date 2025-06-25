/**
 * C function to multiply a matrix by a scalar.
 * 
 * nrows:  Number of rows in the matrix
 * ncols:  Number of columns in the matrix
 * M:      Matrix M
 * factor: Scalar factor to multiply by
 */
void change (int nrows, int ncols, int M[nrows][ncols], int factor)
{
    for (int row = 0; row < nrows; row++) {
        for (int col = 0; col < ncols; col++) {
            M[row][col] = factor * M[row][col];
        }
    }
}
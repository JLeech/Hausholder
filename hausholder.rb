require "matrix"

class Matrix
    def []=(i,j,k)
        @rows[i][j]=k
    end
end

def print_matrix(mat)
    for i in 0..(mat.row_count-1)
        for j in 0..(mat.column_count-1)
            printf " #{mat[i,j]}"
        end
        puts
    end
end 

def count_vector(vec)
	e1 = Vector.elements(create_unary_vec(vec.size))
	return vec + Math.sqrt(metric(vec)) * e1
end

def create_unary_vec(number)
	vec = []
	for i in 0..number-1
		vec.push(0)
	end
	vec[0] = 1
	return vec
end

def insert_vector(col,matr,place)
	for i in (0..matr.row_count-1)
		matr[i,place] = col[i]
	end
	return matr
end

def metric(vec)
	return vec.inner_product(vec)
end

def hause_matrix(vec)
	hause_vec = count_vector(vec)
	sub_matrix = Matrix.identity(vec.size)
	for i in (0..hause_vec.size-1) do 
		for j in (0..hause_vec.size-1) do
			sub_matrix[i,j] = hause_vec[i]*hause_vec[j]
		end
	end

  	sub_matrix = sub_matrix * 2.0 / metric(hause_vec)
	return  Matrix.identity(vec.size) - sub_matrix
end

def zeroing(matr)
	for i in (0..matr.row_count-1)
		for j in (0..matr.column_count-1)
			matr[i,j] = 0.0 if (matr[i,j] < 0.0000000001) && (matr[i,j] > -0.0000000001)
		end
	end
	return matr
end

def triangle(matr)
	for j in (0..matr.column_count-1)
		matr = insert_vector(hause_matrix(matr.column(j)) * matr.column(j), matr,j)
		matr = zeroing(matr)
	end
	print_matrix(matr)
end

matr = Matrix[[3,1,1,1],[1,2,1,1],[5,1,1,1],[1,1,1,1]]
column = matr.column(0)
#matr = insert_vector(count_vector(column),matr,0)

#matr = insert_vector(hause_matrix(column) * column, matr,0)
#matr = zeroing(matr)
triangle(matr)

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

def sgn(x)
	return -1 if x<0
	return 1 if x +=0
end

def count_vector(vec,position)
	cutted_vec = Vector.elements(vec.to_a.drop(position))
	e1 = Vector.elements(create_unary_vec(cutted_vec.size))
	hause_vec = (cutted_vec + sgn(cutted_vec[0])*Math.sqrt(metric(cutted_vec)) * e1).to_a
	for i in 1..position	
		hause_vec.insert(0,0)
	end
	return Vector.elements(hause_vec)
end

def create_unary_vec(number)
	vec = []
	for i in 0..number-1
		vec.push(0)
	end
	vec[0] = 1
	return vec
end


def hause_matrix(vec,position)
	hause_vec = count_vector(vec,position)
	sub_matrix = Matrix.identity(hause_vec.size)
	for i in (0..hause_vec.size-1) do 
		for j in (0..hause_vec.size-1) do
			sub_matrix[i,j] = hause_vec[i]*hause_vec[j]
		end
	end

  	sub_matrix = sub_matrix * 2.0 / metric(hause_vec)
	return  Matrix.identity(hause_vec.size) - sub_matrix
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

def zeroing(matr)
	for i in (0..matr.row_count-1)
		for j in (0..matr.column_count-1)
			matr[i,j] = 0.0 if (matr[i,j] < 0.0000000001) && (matr[i,j] > -0.0000000001)
		end
	end
	return matr
end

def make_triangle(matr)
	global_hause_matrix = Matrix.identity(matr.column_count)
	for j in (0..matr.column_count-2)
		local_hause_matrix = hause_matrix(matr.column(j),j)
		matr = insert_vector(local_hause_matrix * matr.column(j), matr,j)
		#matr = zeroing(matr)
		global_hause_matrix = global_hause_matrix * local_hause_matrix
	end
	#print_matrix(matr)
	return [global_hause_matrix,matr]
end

def make_hessen(matr)
	for j in (0..matr.column_count-3)
		matr = insert_vector(hause_matrix(matr.column(j),j+1) * matr.column(j), matr,j)
	end
	zeroing(matr)
	print_matrix(matr)
end

matr = Matrix[[3,4,5,6],[1,2,3,4],[5,6,7,4],[1,3,9,5]]

hause_matrix,triangle = make_triangle(matr)
#print_matrix (hause_matrix * triangle)
matr = Matrix[[3,4,5,6],[1,2,3,4],[5,6,7,4],[1,3,9,5]]
make_hessen(matr)

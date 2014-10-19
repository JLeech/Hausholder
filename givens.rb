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

def mod(x)
    if x > 0
        return x
    else
        return x*-1
    end
end

def insert_vector(col,matr,place)
    for i in (0..matr.row_count-1)
        matr[i,place] = col[i]
    end
    return matr
end


def count_givens_cs(arg,to_zero)
    puts "arg: #{arg}"
    puts "tze: #{to_zero}"

    if to_zero == 0
        return [1.0,0.0]
    else
        if mod(to_zero) > mod(arg)
            tmp = (-to_zero)/arg
            s = 1.0/Math::sqrt(1.0 + tmp**2)
            c = s*tmp
        else
            tmp = (-arg)/to_zero
            c = 1.0/Math::sqrt(1.0 + tmp**2)
            s = c*tmp
        end
        return [c,s]
    end
end

def zero_place_2(place,vec)
    c,s = count_givens_cs(vec[place-1],vec[place])
    return Matrix[[1,0,0],[0,c,s],[0,-s,c]] * vec
end

def zero_place(place,vec)

    c,s = count_givens_cs(vec[place-1],vec[place])
    #return Matrix[[1,0,0],[0,c,s],[0,-s,c]] * vec
    #return Matrix[[-1,0,0],[0,1,0],[0,0,2]] * vec
    return Matrix[[c,s,0],[-s,c,0],[0,0,1]] * vec
end

puts zero_place_2(2, zero_place(1, Vector.elements([1.0, 1.0, 3.0])))
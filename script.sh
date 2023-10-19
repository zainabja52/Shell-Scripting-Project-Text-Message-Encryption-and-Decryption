echo "choose a number to choose encryption or decryption"
choice="Encryption Decryption"
select option in $choice;do
        if [ $REPLY = 1 ] #encryption was chosen
        then
        echo "You have chosed encryption"
        echo "Please input the name of the plain text file"
        read file #readinf the file
                if [ ! -e "$file" -o ! -f "$file" ] #checks if the file is valid
                then
                echo "File not accepted"
                break
                fi
                if [ grep '[^A-Za-z" "]' $file | wc -l -ge 1 ] #checks if the file has nonalphabatical characters
                then
                echo "The file is not acceptable" 
                exit 2
                else
                #if the file does not have any non-alphabet :

                #finding key :

                string=$(cat $file) #save the file contents
                for word in $string #reading every word at a time
                do
                word=`echo $word | tr '[A-Z]' '[a-z]'`  #convert to small letters
                counter=1
                sum=0
                 while [ $counter -le $( echo -n $word | wc -c ) ] #numbering char in a word 
                do
                char=$(echo -n $word | cut -c $counter) #reading every char at a time in a word
                ascii=$(echo -n "$char" | od -An -t dC) #getting the ascii characters
                key=$((ascii-96)) #what we needed
                ((sum+=key)) 
                ((counter+=1))

                echo char:$char "->" key :$key 
                done
                echo "sum=$sum"
                sum=$((sum % 256))
                max=0
                if [ $sum -gt $max ] #calculating the max
                then
                max=$sum
                fi
                echo "............"
                done

                binaryasciiconvert=`printf " %08d" $(bc <<< "ibase=10;obase=2;$max")` #convert the key value to binary
                echo "The Key in decimal : = $max , The key in binary = $binaryasciiconvert" 
                #key found

                echo "Enter the name of cipher file" #cipher file to store result of encrption part
                read filename
                if [ -e $filename ]
                then
                echo "The file was found "
                echo -n "" > $filename
                else
                echo "The file does not exist "
                break
                fi

                for word in $string #reading every word at a time
                do
                counter=1
                sum=0
                 while [ $counter -le $( echo -n $word | wc -c ) ] #numbering char in a word 
                do
                char=$(echo -n $word | cut -c $counter) #reading every char at a time in a word
                ascii=$(echo -n "$char" | od -An -t dC) #getting the ascii characters
                binary=$(printf "%08d" $(bc <<< "ibase=10;obase=2;$ascii")) #convert ascci code to binary
                xor=$(perl -e 'printf("%.8b",oct("0b".$ARGV[0])^oct("0b".$ARGV[1]))' $binaryasciiconvert $binary)  #xor between key and ascii char
                value=$(echo $xor | sed 's/\(....\)\(....\)/\2\1/' ) #swapping 1st 4-bit with last 4-bit
                ((counter+=1)) # incerment counter by one
                echo $value >> $filename #store the swapped value in cipher file
        done
done
        newKey=$(echo $binaryasciiconvert | sed 's/\(....\)\(....\)/\2\1/' ) #swapping 1st 4-bit with last 4-bit
        echo $newKey >> $filename #add key value as the last character of the generated file.
        fi
else
        if [ $REPLY = 2 ] #you chosed decryption
        then
        echo "you have chosed decryption"

        echo "Please input the name of the cipher text file" #this is the file we want to decrypt its contain
        read file
        if [ ! -e "$file" -o ! -f "$file" ] #checks if the file is valid
                then
                echo "File not accepted"
                break
        else #if the file valid

        swapkey=`tail -1 $file`  #get the last line inside the cipher file since it equals the key value after swap 
        key=$(echo $swapkey | sed 's/\(....\)\(....\)/\2\1/' ) #swapping 1st 4-bit with last 4-bit 
        decimalkey=$((2#$key))          #convert key value from binary to decimal
        echo "The value of the key in decimal : $decimalkey" #print

        echo "Please input the name of the plain text file" 
        read cfile #reading the file
                if [ ! -e "$cfile" -o ! -f "$cfile" ] #checks if the file is valid
                then
                echo "File not accepted"
                break
               fi

                str=$(sed '$d' $file) #store the file contain without the last line
                for val in $str #for each character in the encrypted file
                        do
                        newVal=$(echo $val | sed 's/\(....\)\(....\)/\2\1/') #swap the first 4-bit with the last for bit
                        binaryvalue=`echo $newVal` #store value 
                        decimalvalue=$((2#$binaryvalue)) # convert it from binary to decimal
                        xorvalue=$(("$decimalkey" ^ "$decimalvalue")) #XOR between the key and each character from the encrypted file.
                        charvalue=$(printf \\$(printf '%03o' "$xorvalue")) # convert the result of xor from decimal to characters
                        echo $charvalue >> $cfile #store the result in the plain text file
                done
        fi
                        else # if user choose something except 1 or 2 this messge will appears
                        echo "you chosed a wrong number"
                        exit 0
                fi
        fi
done


#script to compare similarity of sequence 
# a should be reference sequence
#All the sequence should have same length 

a="abcde"
b="abcde"
c="gbcge"
d="abcde"
e="abcge"
f="gbcge"
g="gbcte"
h="abcde"
library(stringr)

#start empty vector for length similarity counter and amino acid
similarity=c()
seq=c()
for (i in 1:nchar(a)){
  one= str_sub(a,i,i)
  two=str_sub(b,i,i)
  three=str_sub(c,i,i)
  four=str_sub(d,i,i)
  five=str_sub(e,i,i)
  six=str_sub(f,i,i)
  seven=str_sub(g,i,i)
  eight=str_sub(h,i,i)
  
#make a vector of amino acid at particular position   
 aa= c(one,two,three,four,five,six,seven,eight)
 #look for the pattern that is similar to one
 
 p=grep(pattern=one, aa, value=TRUE)
 # no of letters that match the pattern 
 x=length(p)
 #igone missing values -  and line separators "\n"
 if (aa[1]=="-" |aa[1]=="\n") x=0
 
 #add values to the empty vectors 
  similarity=append (similarity,x)
  seq=append(seq,one)
}

#amino acid positions

pos=c(1:nchar(a))

#amino acid sequence
noquote(seq)
#convert into data frame 

data=data.frame(pos,similarity,seq)

library(ggplot2)
ggplot(data,aes(pos,similarity,fill=similarity))+
  geom_bar(stat="identity")
length(seq)
nchar(a)

View(data)

#there are gaps thats why we see 3000 aa 
#but there are only 2100 aa in SVA 
#now getting graph only for SVA aminoacids
#get rid of positions that has -
library(dplyr)

#extract the rows where y is not equal to zero 
data1=filter(data, similarity!=0)
#now we have to redifine the position 
data1$aa_position= c(1:length(data1$seq))
View(data1)
#now plot for extracted data 
library(ggplot2)
#library(gghighlight)
#library(ggalt)

#select the data that need to be highlted
data2=filter(data1,similarity>5)
ggplot(data1,aes(aa_position,similarity,fill=similarity))+
  geom_bar(stat="identity")
  #geom_encircle(aes(x=aa_position,y=similarity),
                #data=data2,color="red",alpha=0.1, size=4,
                #expand=0)



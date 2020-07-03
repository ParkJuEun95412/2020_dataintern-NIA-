#0703
#데이터 정제를 위한 조건문
#벡터인경우
test <- c(15,20,30,NA,45)
test[test<40] # 값이 40미만인 요소
test[test%%3!=0] #3으로 나누어 떨어지지 않는 요소추출: 3의 배수가 아닌것
test[is.na(test)] #NA인 요소 추출
test[!is.na(test)] #NA가 아닌ㄴ 요소 추출
#2의 배수이면서 NA가 아닌 요소 추출
test[test%%2==0&!is.na(test)]
#연산자 공부 다시!!!(%%, |, &)

#데이터 프레임인경우
characters <- data.frame(name=c('하나','두나','세나'),age=c(30,16,21),gender=factor(c('M','F','M')))
characters
#왜 끝에 ,를 붙이는 거지???
characters[characters$gender=="F",] #성별이 여성인 행 추출
#30살 미만이고 성별이 남성인 행
characters[characters$age<30&characters$gender=='M',]

#자동으로 요인으로 인식
characters$gender


#if문 이용하기(if, else if, else)

#짝수홀수구분
x <- 5
if(x%%2==0){
  print('x는 짝수') #조건문이 참일 때 실행
} else {
  print('x는 홀수') #조건문이 거짓일 때 실행
}

#x가 0, 양수, 음수 구분 (다중 조건 else if)
x <- -1
if(x>0){
  print('x는 0보다 큰수')
}else if(x<0){
  print('x는 0보다 작은수')
}else{
  print('x is zero')
}

#학점구하기
x <- 100
if(x>=90){
  print('학점은 A')
}else if(x>=80){
  print('학점은 B')
}else if(x>=70){
  print('학점은 C')
}else{
  print('학점은 F')
}

#유효자릿수표시?????????
x <- c(1:10)
options(digits = 1) #출력되는 수들의 자리수가 바뀜
sqrt(x) #제곱근 계산 

#ifelse(조건식, 참값, 거짓값)
sqrt(ifelse(x>=0,x,NA)) # NaN 이 발생하지 않게 음수면 표시

#반복문
#repeat문을 이용해 1부터 10까지 숫자 증가
i <- 1 #i의 시작값은 1
repeat{
  if(i>10){ #i가 10을 넘으면 반복을 중단
    break
  }else{
    print(i)
    i=i+1 #i를 1증가시킴
    #print(i) print의 위치에 따라 출력값이 바뀜 증가식 위에 위치해있는지 아래에 위치해 있는지에 따라
  }
}

#while문 이용해서 1부터 10까지 숫자 증가
i <- 1
while(i<=10){
  print(i)
  i=i+1
}

#for문을 이용해서 1부터 10까지 숫자 증가
i <- 1
for(i in 1:10){
  print(i)
}

#추가: Paste
num <- 17
paste("나는",num,'세이다')
paste('나는 10년뒤에',num+10,'세이다')
#print('나는',num,'세이다')???????????


#while문을 이용해서 구구단 2단 만들기
i <- 1
while(i<10) {
  print(paste(2,'x',i,'=',2*i))
  i=i+1
}

#for문을 이용해서 구구단 2단 만들기
i <- 1
for(i in 1:9) {
  print(paste(2,'x',i,'=',2*i))
}

#for문을 이용해서 구구단 2~9단 만들기
i <- 1
for (i in 2:9){
  for(j in 1:9) {
    print(paste(i,'x',j,'=',i*j))
  }
}

#1부터 10까지의 수 중 짝수만 출력
i <- 1
for (i in 1:10){
  if(i%%2==0){
    print(i)
  }
}
#사용자정의함수
#하나의 인수로 입력하면, 그 수의 제곱까지를 배열로 출력하는 사용자 정의함수

func <- function(a){
  return(1:a^2)
}
func(5)

#transMile() 함수 정의
transMile <- function(x){
  tmile=x*1.6
  result=paste(tmile,'km',sep='')
  return(result)
}
transMile(5)

#계승 구하는 사용자 함수
fact <- function(x){
  fa=1
  while(x>1){
    fa=fa*x
    #print(fa)
    x=x-1
    #print(x)
  }
  return(fa)
}
fact(5)

#1~100까지의 수 중에서 3의 배수이면서 4의 배수는 아닌 수의 합
func <- function(x){
  sum=0
  for(i in 1:x){

    if(i%%3==0&i%%4!=0)
    sum=sum+i
  }
  return(sum)
}

func(100)

#방법2
sumf <- function(x,y){
  start <- 1:100
  temp <- start[start%%x == 0]
  result <- sum(temp[temp%%y != 0])
  return(cat(x,"의 배수이면서",y,"의 배수가 아닌 수들의 합은",result,"입니다."))
}
sumf(3,4)

#x와 n을 입력하면 1부터 n까지의 수 중에서 x의 배수 합을 구해주는 사용자 정의함수
times <- function(x,n){
  sum=0
  for(i in 1:n){
    if(i%%x==0){
      sum=sum+i
    }
  }
  return(sum)
}
times(3,100)

#결측값처리
#is.na함수를 이용해 결측값 처리하기
str(airquality) #airquality 데이터의 구조를 살펴봄 (153객체, 6개의 변수)

#airquality 데이터에서 NA는 TRUE, 아니면 FALSE
head(is.na(airquality))
#개수 확인 (NA개수가 총 44개)
table(is.na(airquality))
table(is.na(airquality$Ozone))# NA 37/116
table(is.na(airquality$Solar.R))# NA 7/146
table(is.na(airquality$Wind))# NA 0/153
table(is.na(airquality$Temp))# NA 0/153
table(is.na(airquality$Month))# NA 0/153
table(is.na(airquality$Day))# NA 0/153

mean(airquality$Temp)
mean(airquality$Ozone)

#결측치처리하기 => 결측치 영역이 담긴 행 제거하고 처리
#1.결측값이 없는 영역만 선택해서 새로운 프레임으로 만들어서 처리
air_narm<- airquality[!is.na(airquality$Solar.R),]
mean(air_narm$Solar.R)
str(air_narm)
#2. na.omit()함수를 이용해서 결측값 무시하고 새로운 프레임을 만들어서 처리
air_narm <- na.omit(airquality)
mean(air_narm$Solar.R)
#3. mean함수 내에 속성인 na.rm()를 이용해서 결측값을 제거하고 처리
mean(airquality$Solar.R,na.rm=T)

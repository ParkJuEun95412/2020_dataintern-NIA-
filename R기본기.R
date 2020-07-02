1+2
# 한줄만 실행: "run" 혹은 ctrl+enter
# 여러줄 실행: 마우스로 여러줄 선택후 "run" 혹은 ctrl+enter
# 전체 실행: "source"-"Source with Echo" 혹은 ctrl+shift+enter

cars
# 현재 데이터셋의 구조 확인
str(cars)
# 차트 그리기
plot(cars)

## 작업 디렉토리의 지정##
#현재위치표시
getwd()
#현재디렉토리 변경  setwd('/위치경로')
setwd('c:/r')

#라이브러리(패키지)의 설치 및 사용

#보조기억장치에 저장ff
install.packages("ggplot2")
#주기억장치로 불러오기
library(ggplot2)
search()

10000
#5자리수부터는 지수형태로 저장
100000
1000000
1e2 #e가 10이라고 생각하기 1*(10)^2
3e2
3e-1 #1*(10)^-1 소수점자리로 변경

sum(1,NA,2) # NA: 결측값, 잘못된 값이 들어 올 경우(Not Available)
sum(1,NULL,2) # NULL: 값이 없을 경우

#결측치 처리 na.rm = T NA값을 제거하고 계산
sum(1,NA,2,na.rm = T)

# 2. 데이터형과 연산
# 변수
x<-1
y<-2
x
y
z<-x+y
z
x<-1
x<-x+1
x<-x+3
x

#변수명 규칙

#대소문자 구분
X
#변수명에 특수문자 사용불가
a@<-2

initial_value<-1

# c 함수를 통해 만들어지는 것: vector
blood.type=c('A','B','O','AB')
blood.type

#숫자로 시작하는 변수명 불가
1a<-1
#_로 시작하는 변수명 불가
_al<-1

a_1<-1

#예약어는 사용불가
if<-1
for<-1

# 생성된 변수 모두 확인하기
objects()

name<-'박주은'

# alt+'-' <- 단축키


# 데이터형 자동인식
x <- 5
y <- 2

x/y

#복소수
xi <- 1+2i
yi <- 1-2i
xi+yi

str <-"Hello, World!"
str

blood.type <- factor(c('A','B','O','AB'))
blood.type

#논리형을 말할때는 대문자 T(TRUE)/F(FALSE)
t
T
F

#양/음 의 무한대
xinf <- Inf
yinf <- -Inf

#계산못함
xinf/yinf

#데이터형 변환 함수

#넌왜 정수가 아니니?
#정수형
is.integer(1)

#숫자형
is.numeric(0.1L)

#넌 또 왜 정수니?
a <- 1L
is.integer(a) 

#as.integer
x <- as.integer(1)
x
is.integer(x)

1+2
'1'+'2'

#숫자를 강제로 변환

as.numeric('1')+as.numeric('2')

#산술연산자
5+2
5-2
5*2
5/2
5^2
5%%2
5%/%2
5<5
5<=5
5>5
5>=5
5==5  
5!=5
!TRUE
TRUE|FALSE
#논리연산자
0|5
0&5

TRUE&FALSE
isTRUE(TRUE)

#벡터 생성
#R은 마지막지정숫자까지 출력
1:7
7:1

#c함수
c(1:5)
c(1,2,3,c(4:6)) #c함수안에 중첩사용
x <- c(1,2,3)
x
y <- c() #빈벡터생성(비어있는 방)
y <- c(y,c(1:3)) #다시해보기!
y

#seq함수(from=시작, to=끝, by=증가, length.out=결과값크기를 기준 자동으로 간격조절)
a <- seq(1,10,3)
a
b <- seq(1,10, by=2)
b
seq(1,10,2) #파라미터명 생략가능

seq(1,10,0.1)
seq(1,10,length.out = 5) 

#rep함수
rep(c(1:3),times=2) #반복 연달아 불어오기  times는 전체반복횟수
rep(c(1:3),each=2) #개별인수의 반봅횟수 지정 = each

rep(seq(0,10,2),times=2)

#벡터연산
x <- c(2,4,6,8,10)
length(x)
#[]는 요소위치를 의미-한개만 가능
x[1]
x[1,2,3]
#여러개를 불러오기위해서는 c를 이용해서 묶어주기
x[c(1,2,3)]
#-는 제외를 의미
x[-c(1,2,3)]

x[-1]
x[-c(1,3,5)]
x[c(1:3)]

a <- c(1,2,3)

#추가
x <- append(x,a,after=3) #벡터, 추가할값(벡터도가능), 위치
x
#인수 확인  확인하고싶은 값 %in% 벡터
3 %in% x

#벡터끼리 연산수행
x <- c(1,2,3,4)
y <- c(5,6,7,8)
z <- c(3,4)
w <- c(5,6,7)

#2:4 2:6개 같이 배수관계끼리는 순차적으로 연산, 2:3개는 배수관계가 아니므로 연산이 불가
x+2
x+y
x+z
z+w

#총 10번을 순차적으로 돌아서 확인(결과물 총 10개)
x=1:10
x>5

#all any 함수 : 전체 조건 검토
#all (and,그리고)
all(x>5)
#any (or,또한)
any(x>5)

head(x)
tail(x)
head(x,3)
tail(x,3)

#union intersect setdiff setequal 벡터간집합연산
x <- c(1,2,3)
y <- c(3,4,5)
z <- c(3,1,2)

union(x,y) #합집합(중복데이터제거)
intersect(x,y) #교집합
setdiff(x,y) #차집합 선행인자에서 뒤에꺼 빼줌
setequal(x,y) #x와 y의 값이 동일한지 비교(위치상관 없음)
setequal(x,z) #x와 z의 값이 동일한지 비교(위치상관 없음)

vec1 <- c('봄','여름','가을','겨울')
vec2 <- c('봄','여름','늦여름','초가을')

#1. 합치시오
union(vec1,vec2)

#2. vec1-vec2
setdiff(vec1,vec2)

#3.vec1과 vec2 모두 있는 결과 출력
intersect(vec1,vec2)

#4. vec1에서 '가을'을 제외하고 출력
vec1[-3]


#배열생성
#array 함수 : N차원 배열 생성
x <- array(1:5,c(2,4)) #앞에는 들어갈 값, 뒤에는 차원c(행,열)
x
x[,1] #1열
x[,2] #2열

#행과 열 이름 설정
dimnamex =  list(c('1st','2nd'),c('1st','2nd','3rd','4th')) #행열의이름을 만들어주기위해
x <- array(1:5,c(2,4),dimnames = dimnamex) #값, 차원, dimnames(행열이름))
x

x["1st",] #별칭으로 불러올수있음
x[,"4th"]

#할당연산자는 대체로 <-  지만 = 도 사용가능

x <- 1:12
x
matrix(x,nrow=3) #nrow의 의미는 3행 matrix(벡터, nrow=행수, byrow=T) #열우선/default F 일경우 행우선
mat3=matrix(x,nrow=3,byrow=T)
mat3

#컬럼이름에 별칭 부여
colnames(mat3) <- c('first','second','third','four')
mat3

#벡터를 묶어 배열 생성 bind (rbind:행단위, cbind:열단위)
v1 <- c(1,2,3,4)
v2 <- c(5,6,7,8)
v3 <- c(9,10,11,12)
cbind(v1,v2,v3)
rbind(v1,v2,v3)

#배열연산
#2x2 행렬 2개를 각각 x,y에 저장
x <- array(1:4,dim=c(2,2)) 
x
y <- array(5:8,dim=c(2,2))
y
x+y
x-y
x*y


x <- array(1:12,c(3,4))
x

#apply함수: 행 열로 함수적용
apply(x,1,mean) #1:행
apply(x,2,mean) #2:열

#dim 함수: 배열크기
dim(x)
sample(x)
sample(x,10) #x에서 10개 추출
sample(10) #임의로 추출?????

#데이터프레임만들기
name <- c('하나','두나','세나')
age <- c(22,20,25)
gender <- c('M','F',"M")
blood <- c("A","O","B")

patients <- data.frame(name,age,gender,blood)
patients

#edit함수 이용해 데이터프레임 생성
test <- data.frame() #빈데이터프레임생성
test <- edit(test) #편집기 따로 팝업창으로 뜨고 거기에 작성가능
test

patients$name #name열의 값 출력 데이터프레임$열
patients[1,] #1행 의 모든값
patients[,2] #2열의 모든것
patients[3,1] #3행1열의 값

patients[patients$name=='하나',] #name이 하나인 행을 불러준다
patients[patients$name=='하나',c('name','age')] #name 이 하나인 행의 name,age열만 보여주겠다(다시!!!)

patients[patients$name=='세나',c('name','blood')]

# attach, detach, subset 함수(df함수)

head(cars) #head함수 초기값 6줄
cars$speed
speed 
attach(cars) #데이터프레임에 속성(column)을 변수로 만들어준다
speed
detach(cars) #속성 변수사용 해제제
speed
#데이터속성을 이용해 함수 적용
mean(cars$speed)
max(cars$dist)

#subset 일부 데이터만 추출 (df, 조건, select=출력열(화면))
subset(cars, speed>20) #speed가 20 초과인 값만 출력
subset(cars,speed=20) #결과는 나오지만 우리가 원하는 결과값이 아님???????
subset(cars,speed==20) #speed가 20인 값만 출력
subset(cars,speed>20, select=c(dist)) #속도 20초과, dist 열 추출
subset(cars,speed>20,select=-c(dist)) #속도 20초과, dist 열 제외 추출

NO <- c(1:5)
NAME <- c('김진수','주시현','최경우','이동근','윤정웅')
ADDRESS <- c('대구','대전','포항','제주','경기')
TEL <- c('1111','2222','3333','4444','5555')
HOBBY <- c('독서','미술','놀고먹기','먹고놀기','잠자기')

member <- data.frame(NO,NAME,ADDRESS,TEL,HOBBY)
member
#1.no,name,tel 컬럼만 출력하시오
subset(member,select=c(NO,NAME,TEL))
#2.tel 빼고 출력하시오
subset(member,select=-c(TEL))
#3.컬럼명을 '번호,이름,주소,취미'로 변경하시오
colnames(member) <- c('번호','이름','주소','TEL','HOBBY')
member


#리스트
patients <- data.frame(name <- c('하나','두나','세나'),
                       age <- c(22,20,25),
                       gender <- c('M','F',"M"),
                       blood <- c("A","O","B"))
patients
no.patients <- data.frame(day=c(1:6),no=c(50,60,55,52,65,58))
no.patients

listPatients <- list(patients,no.patients) #list로 두개의 데이터프레임을 연결
listPatients

#각 데이터에 이름 부여하면서 추가
listPatients=list(patients=patients,no.patients=no.patients)
listPatients

#리스트 요소선택
listPatients$patients #요소명 입력
listPatients[[1]] #인덱스 입력
listPatients[['patients']] #인덱스 내에 요소명 입력(''필요)

#apply함수 (lapply => 결과값 list, sapply=>vector???)
l=lapply(listPatients$no.patients,mean)
s=sapply(listPatients$no.patients,mean)

str(l)
str(s)

#데이터취득과 정제

#파일불러오기(txt파일-주의! 마지막 빈행 추가, encoding시 ansi로 변경)
students <- read.table("C:/r/students.txt",header=T)
students

#구조확인
str(students)

#파일을 있는 형태 그대로 읽음
students <- read.table("C:/r/students.txt",header=T,as.is=T)
students
#파일을 읽을 때 문장을 요인(factor)으로 인식하지 않도록 설정
students <- read.table("C:/r/students.txt",header=T,stringsAsFactors = F)
students

students<- read.csv("C:/r/std2.csv",header=T,as.is=T)
students
str(students)

students$name <- as.character(students$name)
str(students)

#도움말보기 ?붙이기
?write.table

#문장에 큰따옴표가 표시됨(그대로)
write.table(students,file="C:/r/output.txt")
#문장에 큰따옴표가 표시되지 않음
write.table(students,file="C:/r/output2.txt",quote=F)


#0707
#데이터 준비
four_sessions <- read.csv('c:/r/data/four_sessions.csv')

#분산분석(ANOVA) 

#일원 분산 분석 (독립변수가 하나일때)
#출력방법만 다를 뿐 같은 결과물을 출력해낸다

#aov() 함수 사용
summary(aov(Time~Page,data=four_sessions))
#oneway.test() 사용
oneway.test(four_sessions$Time~four_sessions$Page,var=T) 

#카이제곱검정
#데이터 준비
click_rate <- read.csv('c:/r/data/click_rates.csv')

clicks <- matrix(click_rate$Rate, nrow=3,ncol=2,byrow=TRUE)
#뉴스 헤드라인 별 클릭 수 데이터
head(clicks)

#chisq.test()
chisq.test(clicks,simulate.p.value = TRUE) #귀무가설 채택 
![그림1](https://user-images.githubusercontent.com/57995077/86680326-68ac1b80-c039-11ea-95fb-41883c9831a4.png)

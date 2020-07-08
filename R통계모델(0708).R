#킹카운티주택정보예제
house <- read.csv('c:/r/data/house_sales.csv',sep='\t')
head(house)
#   DocumentDate SalePrice PropertyID  PropertyType         ym zhvi_px  zhvi_idx
# 1   2014-09-16    280000    1000102     Multiplex 2014-09-01  405100 0.9308364
# 2   2006-06-16   1000000    1200013 Single Family 2006-06-01  404400 0.9292279
# 3   2007-01-29    745000    1200019 Single Family 2007-01-01  425600 0.9779412
# 4   2008-02-25    425000    2800016 Single Family 2008-02-01  418400 0.9613971
# 5   2013-03-29    240000    2800024 Single Family 2013-03-01  351600 0.8079044
# 6   2009-03-30    349900    3600090     Townhouse 2009-03-01  369800 0.8497243
#   AdjSalePrice NbrLivingUnits SqFtLot SqFtTotLiving SqFtFinBasement Bathrooms
# 1       300805              2    9373          2400               0      3.00
# 2      1076162              1   20156          3764            1452      3.75
# 3       761805              1   26036          2060             900      1.75
# 4       442065              1    8618          3200            1640      3.75
# 5       297065              1    8620          1720               0      1.75
# 6       411781              1    1012           930               0      1.50
#   Bedrooms BldgGrade YrBuilt YrRenovated TrafficNoise LandVal ImpsVal ZipCode
# 1        6         7    1991           0            0   70000  229000   98002
# 2        4        10    2005           0            0  203000  590000   98166
# 3        4         8    1947           0            0  183000  275000   98166
# 4        5         7    1966           0            0  104000  229000   98168
# 5        4         7    1948           0            0  104000  205000   98168
# 6        2         8    2008           0            0  170000  207000   98144
#   NewConstruction ZipGroup
# 1           FALSE        3
# 2            TRUE        3
# 3           FALSE        3
# 4           FALSE        3
# 5           FALSE        3
# 6            TRUE        4
head(house[,c("AdjSalePrice","SqFtTotLiving","SqFtLot","Bathrooms","Bedrooms","BldgGrade")])
str(house)
#다중선형회귀모델
(house_lm <- lm(AdjSalePrice~SqFtTotLiving+SqFtLot+Bathrooms+Bedrooms+BldgGrade,data=house,na.action = na.omit))
#na.action=na.omit na값을 무시하고 계산해라

#stepAIC()함수를 이용한 단계적 회귀
#패키지("MASS")설치
install.packages("MASS")
library(MASS)

colnames(house)

#전체 요인에 대하여 회귀모델 생성
house_full <- lm(AdjSalePrice~SqFtTotLiving+SqFtLot+Bathrooms+Bedrooms+BldgGrade+PropertyType+NbrLivingUnits+SqFtFinBasement+YrBuilt+YrRenovated+NewConstruction,data=house,na.action = na.omit)
#stepAIC() 요소간의 다중공선성을 검사해서 예측변수를 제거하고 최소의 AIC값을 만듦
step_lm <- stepAIC(house_full,direction="both") #변수선택방법은 단계적 선택, direction='both'(요소를 추가하고 후진하면서 최소의 AIC값을 도출)
#direction의 옵션값: 'both'(default),'forward':전진(요소추가),'backward':후진(요소제거)

#AIC/BIC/CP/DA(판별분석): 표를 읽는 방법/ PCA(주성분분석): 통계분석법(범주형자료, 가중치부여)???????

#회귀분석에서는 다중공선성(독립변수들간의 상관계수를 구함) 문제를 반드시 해결해야함



(house_lm <- lm(AdjSalePrice~SqFtTotLiving+SqFtLot+Bathrooms+Bedrooms+BldgGrade,data=house,na.action = na.omit))

#Call:
#lm(formula = AdjSalePrice ~ SqFtTotLiving + SqFtLot + Bathrooms + 
#    Bedrooms + BldgGrade + PropertyType, data = house, na.action = na.omit)

#Coefficients:
#              (Intercept)              SqFtTotLiving                    SqFtLot  
#               -4.469e+05                  2.234e+02                 -7.041e-02  
#               Bathrooms                   Bedrooms                  BldgGrade  
#               -1.597e+04                 -5.090e+04                  1.094e+05  
#PropertyTypeSingle Family      PropertyTypeTownhouse  
#               -8.469e+04                 -1.151e+05  


#계수가 (-)인 값이 많아서 교란변수 확인이 필요

# house 데이터의 zipcode는 우편번호를 나타내는 범주형변수입니다.
# zipcode의 경우  원-핫인코딩으로 변형 시 너무 많은 이진 더미를 생성할 수 있읍니다.
# 아래와 같이 우편번호를 5개의 그룹으로 통합 ZipGroup 변수에 저장합니다.


#참고: 파이프라인 단축키 shift+ctrl+M
library(dplyr) #파이프라인 %>% 사용하기 위한 패키지
zip_groups <- house %>%
  mutate(resid = residuals(house_lm)) %>%   # 새로운 열 만들기
  group_by(ZipCode) %>%
  summarize(med_resid = median(resid),
            cnt = n()) %>%
  # sort the zip codes by the median residual
  arrange(med_resid) %>%
  mutate(cum_cnt = cumsum(cnt),
         ZipGroup = factor(ntile(cum_cnt, 5)))



house <- house %>%
  left_join(dplyr::select(zip_groups, ZipCode, ZipGroup), by='ZipCode')

house$ZipGroup

(house_lm <- lm(AdjSalePrice~SqFtTotLiving+SqFtLot+Bathrooms+Bedrooms+BldgGrade+PropertyType+ZipGroup,data=house,na.action = na.omit))

#Call:
#lm(formula = AdjSalePrice ~ SqFtTotLiving + SqFtLot + Bathrooms + 
#    Bedrooms + BldgGrade + PropertyType + ZipGroup, data = house, 
#    na.action = na.omit)

#Coefficients:
#              (Intercept)              SqFtTotLiving                    SqFtLot  
#               -6.744e+05                  2.115e+02                  4.763e-01  
#                Bathrooms                   Bedrooms                  BldgGrade  
#                5.482e+03                 -4.128e+04                  9.927e+04  
#PropertyTypeSingle Family      PropertyTypeTownhouse                  ZipGroup2  
#                2.101e+04                 -7.747e+04                  5.421e+04  
#                ZipGroup3                  ZipGroup4                  ZipGroup5  
#                1.175e+05                  1.785e+05                  3.391e+05  

#상호작용 표현하는 formula 
#formula=종속변수~설명변수1*설명변수2
(lm(AdjSalePrice~SqFtTotLiving*ZipGroup+SqFtLot+Bathrooms+Bedrooms+BldgGrade,data=house,na.action = na.omit))

# Call:
# lm(formula = AdjSalePrice ~ SqFtTotLiving * ZipGroup + SqFtLot + 
#     Bathrooms + Bedrooms + BldgGrade, data = house, na.action = na.omit)

# Coefficients:
#             (Intercept)            SqFtTotLiving                ZipGroup2  
#              -4.546e+05                1.283e+02               -2.131e+04  
#               ZipGroup3                ZipGroup4                ZipGroup5  
#               1.246e+04                6.041e+03               -1.718e+05  
#                 SqFtLot                Bathrooms                 Bedrooms  
#               7.514e-01               -1.728e+04               -3.806e+04  
#               BldgGrade  SqFtTotLiving:ZipGroup2  SqFtTotLiving:ZipGroup3  
#               1.012e+05                3.712e+01                4.176e+01  
# SqFtTotLiving:ZipGroup4  SqFtTotLiving:ZipGroup5  
#               7.343e+01                2.343e+02  



# 상호작용과 주효과 추가 예시
# 연비mpg(종속변수) 마력hp(독립변수) 중량wt(독립변수)

data(mtcars)
head(mtcars)
#                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
# Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
# Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
# Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
# Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
# Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
# Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1

fit_01 <- lm(formula = mpg~hp*wt,data=mtcars) #상호작용 *
summary(fit_01)

# Call:
# lm(formula = mpg ~ hp * wt, data = mtcars)

# Residuals:
#     Min      1Q  Median      3Q     Max 
# -3.0632 -1.6491 -0.7362  1.4211  4.5513 

# Coefficients:
#             Estimate Std. Error t value Pr(>|t|)    
# (Intercept) 49.80842    3.60516  13.816 5.01e-14 ***
# hp          -0.12010    0.02470  -4.863 4.04e-05 ***
# wt          -8.21662    1.26971  -6.471 5.20e-07 ***
# hp:wt        0.02785    0.00742   3.753 0.000811 *** # 두변수의 상호작용 연관도
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

# 모든변수가 0.05이하이기때문에 영향을 미친다고 할 수 있다.

# Residual standard error: 2.153 on 28 degrees of freedom
# Multiple R-squared:  0.8848,	Adjusted R-squared:  0.8724 
# F-statistic: 71.66 on 3 and 28 DF,  p-value: 2.981e-13

# 회귀식 결과 
# mpg=49.8-0.12*hp-8.22*wt+0.0278=*hp*wt

# 상호작용을 그래프로 작성
plot(mpg~hp,data=mtcars,main='Interaction of hp:wt')
 
# curve(함수식, add=TRUE) 기존 그래프에 겹쳐 그림
# wt에 2.2를 대입하면
# 49.8-0.12*hp-8.22*wt(2.2)+0.027*hp*wt(2.2)=31.71-0.06*x

curve(31.71-0.06*x,add=TRUE)
curve(23.49-0.03*x,add=TRUE,lty=2,col=2)
curve(15.28-0.003*x, add=TRUE, lty=3,col=3)

#lty(line type) 선의 모양(1~6)
legend("topright",c('2.2','3.2','4.2'),title='wt',lty=1:3,col=1:3)

#차의 중량이 늘어날수록
#마력과 연비의 관계가 약해짐을 알수있음

# 다중 선형회귀
str(trees)
# 'data.frame':	31 obs. of  3 variables:
#  $ Girth : num  8.3 8.6 8.8 10.5 10.7 10.8 11 11 11.1 11.2 ...
#  $ Height: num  70 65 63 72 81 83 66 75 80 75 ...
#  $ Volume: num  10.3 10.3 10.2 16.4 18.8 19.7 15.6 18.2 22.6 19.9 ...

summary(trees)
#      Girth           Height       Volume     
#  Min.   : 8.30   Min.   :63   Min.   :10.20  
#  1st Qu.:11.05   1st Qu.:72   1st Qu.:19.40  
#  Median :12.90   Median :76   Median :24.20  
#  Mean   :13.25   Mean   :76   Mean   :30.17  
#  3rd Qu.:15.25   3rd Qu.:80   3rd Qu.:37.30  
#  Max.   :20.60   Max.   :87   Max.   :77.00 

# 지름,키(독립변수)/ 부피(종속변수)
# 가설: 부피는 지름이 클수록, 키가 클수록 클 것이다.

# scatterplot3d

install.packages("scatterplot3d")
library(scatterplot3d)

# 함수로trees 데이터의분포를확인하기
scatterplot3d(trees$Girth,trees$Height,trees$Volume)

# 다중선형회귀모델생성
(m<- lm(Volume~Girth+Height, data=trees))

# trees 데이터와회귀모델을중첩하여시각화하기
s <- scatterplot3d(trees$Girth,trees$Height,trees$Volume,pch=20,type='h',angle=55)
s$plane3d(m)

# 임의의 값을 지름과 길이에 넣기
(n.data <- data.frame(Girth=c(8.5,13.0,19.0),Height=c(72,86,85)))
#   Girth Height
# 1   8.5     72
# 2  13.0     86
# 3  19.0     85

# 예측하기 (회귀식과 결과값 동일)
(n.y <- predict(m,newdata = n.data))
#         1         2         3 
#  6.457794 32.394034 60.303746 

# 임의의 값에 대해 예상결과 시각화
s <- scatterplot3d(c(8.5,13.0,19.0),c(72,86,85),n.y,pch=20,type='h',color='red',angle=55)
s$plane3d(m)

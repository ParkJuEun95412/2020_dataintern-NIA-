#킹카운티주택정보예제
house <- read.csv('c:/r/data/house_sales.csv',sep='\t')
head(house[,c("AdjSalePrice","SqFtTotLiving","SqFtLot","Bathrooms","Bedrooms","BldgGrade")])
str(house)
#다중선형회귀모델
(house_lm <- lm(AdjSalePrice~SqFtTotLiving+SqFtLot+Bathrooms+Bedrooms+BldgGrade,data=house,na.action = na.omit))
#na.action=na.omit na값을 무시하고 계산해라


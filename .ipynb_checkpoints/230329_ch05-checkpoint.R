# ch05. 데이터 가공 (dplyr 패키지 활용)

install.packages("dplyr")
library(dplyr)

## 같은 함수의 이름이 다른 패키지에 있는 경우 ::로 특정할 수 있음
## ex) dplyr::filter()

nrow(mtcars)
str(mtcars)

################################5-1 dplyr 함수 ########################################

dfilter = dplyr::filter
dfilter(mtcars, cyl==4) 
# dplyr 패키지 함수, mtcars에서 cyl==4인 행을 모두 추출
# filter(ds, col==조건)

dfilter(mtcars, cyl>=6 & mpg>20)
# 2가지 이상 조건(&연산자 활용)

head(select(mtcars, am, gear, cyl))
# select(dataset, col1, col2, col3, ...)
# SQL의 select와 비슷한 개념, 특정 열만 추출

head(arrange(mtcars, wt))
head(arrange(mtcars, mpg, desc(wt)))
# arrange(ds, col1, col2, col3, ...)
# col1, col2, col3, ... 순서로 오름차순 정렬 (desc(변수명)으로 내림차순 정렬 가능)
# 데이터형 여러개가 섞여있으면 숫자가 우선

head(mutate(mtcars, years="1974"))
# mutate(ds, 컬럼명=데이터)로 새로운 컬럼 추가

head(mutate(mtcars, mpg_rank=rank(mpg)))
# rank함수는 해당 변수에 대한 데이터셋 내의 순위를 매김
# rank average -> 동순위면 (19+20)/2 = 19.5와 같이 표현

distinct(mtcars, cyl)
distinct(mtcars, gear)
# 해당 변수에 대한 중복값을 모두 제거하고, 한개만 보여줌
distinct(mtcars, gear, cyl)
# 여러개 변수에 동시에 적용할 수도 있음

summarise(mtcars, cly.mean = mean(cyl), cyl.min = min(cyl), cyl.max = max(cyl))
# 데이터셋을 요약해서 보여줌
# summarise(ds, colname = 통계량(변수), colname = 통계량(변수), ... )
summarise(mtcars, mean(cyl), min(cyl),max(cyl))
# 변수명 없이 쓰면 기본 통계량(변수명)형태로 컬럼 생성

gr_cyl = group_by(mtcars, cyl)
gr_cyl
# 데이터셋을 그룹별로 요약해서 보여줌

summarise(gr_cyl, n())
# 그룹별 개체 수 확인
summarise(gr_cyl, n_distinct(gear))
# n_distinct(컬럼) : 해당 컬럼에 대한 중복 제거 
# n() 함수와 n_distinct()함수는 단독사용 X -> filter, summarise, mutate에서만 사용 가능

sample_n(mtcars, 10)
# 무작위 10개 데이터 추출

sample_frac(mtcars, 0.2)
# 전체 데이터의 20%를 무작위 추출

group_by(mtcars, cyl) %>% summarise(n())
# 파이프 연산자 : 연결하여 연산
# 데이터셋 %>%조건 또는 계산 %>% 데이터 셋

# gr_cyl = group_by(mtcars, cyl)
# summarise(gr_cyl, n())
# 와 같음

# 순위 생성 후, 순위에 따라 정렬 
# 파이프 연산자 미사용 시
mp_rank <- mutate(mtcars, mpg_rank = rank(mpg))
arrange(mp_rank, mpg_rank)

# 파이프 연산자 사용 시 (위 두줄과 동일한 코드)
mutate(mtcars, mpg_rank = rank(mpg)) %>% arrange(mpg_rank)


#############################5-2 데이터 가공하기###################################

# 정제와 가공
# - 정제: 불필요한 내용 제거, 정리
# - 가공 : 데이터를 나한테 필요한 형태로 변형 또는 재생산

library(readxl)
exdata1 <- read_excel("./Source/Sample1.xlsx")
View(exdata1)

exdata1 %>% select(ID)
# == select(exdata1, ID)

exdata1 %>% select(ID, AREA, Y21_CNT)
# == select(exdata1, ID, AREA, Y21_CNT)

# 특정 데이터 제외하고 추출
exdata1 %>% select(-AREA)
# AREA 제외하고 나머지 컬럼 가져오기

exdata1 %>% select(-AREA, -Y21_CNT) %>% group_by(SEX) %>% summarise(mean(Y20_AMT))

exdata1 %>% filter(AREA == "서울" & Y21_CNT >= 10) %>% select(-AREA)

exdata1 %>% arrange(AGE)
exdata1 %>% arrange(desc(Y20_AMT))

exdata1 %>% arrange(AGE, desc(Y21_AMT)) #A
exdata1 %>% arrange(AGE) %>% arrange(desc(Y21_AMT)) #B
# A,B는 서로 다름, 중첩 정렬 안됨

exdata1 %>% summarise(TOT_Y21_AMT = sum(Y21_AMT))

#### 데이터 결합
library(readxl)
m_history <- read_excel("./Source/Sample2_m_history.xlsx")
f_history <- read_excel("./Source/Sample3_f_history.xlsx")
View(m_history)
View(f_history)

# 데이터 결합하기(세로) # dplyr::bind_rows
library(dplyr)
exdata_bindjoin <- bind_rows(m_history, f_history)
View(exdata_bindjoin)

# 데이터 결합하기(가로) # left_join, inner_join, full_join
jeju_y21_history <- read_excel("./Source/Sample4_y21_history.xlsx")
jeju_y20_history <- read_excel("./Source/Sample5_y20_history.xlsx")
jeju_y21_history
jeju_y20_history

# left : table1 기준으로 결합
exdata_leftjoin = left_join(jeju_y21_history, jeju_y20_history, by="ID")
exdata_leftjoin
# inner : 두 테이블에 모두 있는 데이터만 결합
exdata_innerjoin = inner_join(jeju_y21_history, jeju_y20_history, by="ID")
exdata_innerjoin
# full : 두 테이블에 모두 있는 데이터를 결합 
exdata_fulljoin = full_join(jeju_y21_history, jeju_y20_history, by="ID")
exdata_fulljoin

############################5-3데이터 구조 변환################################
install.packages("reshape2")
library(reshape2)

head(airquality)

# column name을 소문자로 변경
names(airquality) <- tolower(names(airquality))
ls(airquality)

# melt 데이터 모양 변경
melt_test = melt(airquality)
head(melt_test)
str(airquality) # 153 obs with 6variables
str(melt_test) # 918 obs with 2 variables
View(melt_test)

melt_test_2 = melt(airquality, id.vars = c("month", "wind"), measure.vars = "ozone")
str(melt_test_2)
head(melt_test_2)

# cast : 세로로 긴 데이터의 내용을 컬럼데이터로 변환
aq_melt <- melt(airquality, id.vars = c("month", "day"), na.rm = TRUE)
head(aq_melt)
View(aq_melt)

aq_dcast <- dcast(aq_melt, month + day ~ variable) 
# month + day는 식별자
# ~ variable은 나머지 변수 의미
head(aq_dcast)

# acast 함수 : 벡터, 행렬, 배열로 변환
head(acast(aq_melt, day~month~variable)) #행~열~변수 #변수별 행렬로 변환

head(acast(aq_melt, month~variable, mean)) #행~열, 요약 # 요약값 행렬
head(acast(aq_melt, month~variable, sum))
head(acast(aq_melt, month~variable, length))



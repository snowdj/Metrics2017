**=============================================================**
**       Econometrics 2017(fall)- Stata- Introduction(II)      **
**                      Nanjing University                     **
**                        Xiaoguang Ling                       **
**					        2017.9.25                          **
**==============================================================**

*the help file of ttest
help ttest
use "C:\Users\Xiaoguang\OneDrive\2017Econometrics\Stata-Introduction\rawdata\Training.dta",clear
ttest age==24, level(99)
**==============================================================**
**                      1. t test(2 samples)                    **
**==============================================================**
clear all
use "C:\Users\Xiaoguang\OneDrive\2017Econometrics\Stata-Introduction\rawdata\Training.dta"

Ho: there is no difference between re74(train=0)&re74(train=1)
ttest  re74 , by(train) 
Ho: there is no difference between re78(train=0)&re78(train=1)
ttest  re78 , by(train) 

**==============================================================**
**                      2. Import datasets                      **
**==============================================================**
(1)data import
use "C:\Users\Xiaoguang\OneDrive\2017Econometrics\Stata-Introduction\rawdata\Training.dta",clear

(2)for csv,txt& xlsx
insheet using "C:\Users\Xiaoguang\OneDrive\2017Econometrics\Stata-Introduction\rawdata\Training.csv",clear

insheet using "C:\Users\Xiaoguang\OneDrive\2017Econometrics\Stata-Introduction\rawdata\Training.txt",clear

import excel "C:\Users\Xiaoguang\OneDrive\2017Econometrics\Stata-Introduction\rawdata\Training.xlsx", sheet("training") firstrow clear

save "C:\Users\Xiaoguang\OneDrive\2017Econometrics\Stata-Introduction\workingdata\Training_cleaned.dta",replace
* DO NOT USE * / \ < > | ? as filename

**==============================================================**
**          3. log file:to record your results                  **
**==============================================================**
log using "C:\Users\Xiaoguang\OneDrive\2017Econometrics\Stata-Introduction\log\matrix"  

matrix input a = (1,2\3,4)
matrix list a
matrix input b = (1,1\1,1)
matrix list b
log off 
matrix c=a+b
log on 
matrix list c

log close //critical！

**==============================================================**
**                      4. basic commands                       **
**==============================================================**


4.1 New packages
which ttest
help estpost
SSC //the Statistical Software Components (SSC) archive(the Boston College Archive)

*ssc install newprogramname 
help estpost
ssc install estpost
help estpost
ssc install esttab

ssc hot
ssc new

4.2 Data Description
clear all 
global root "C:\Users\Xiaoguang\OneDrive\2017Econometrics\Stata-Introduction"  
cd "$root/rawdata" 
use Training, clear  

des 
sum
tab mostrn
tab mostrn train 

collapse re74 re75 re78 ,by(train) 
list 

4.3 Pictures
*scatter: Education and earnings in 1974
use Training, clear
tab re74 
drop if re74>30
twoway scatter re74 educ, msize(small) title(Education and earnings in 1974) ///
legend(off) ytitle("earnings in 1974") xtitle("Years of education")|| ///
lfit re74 educ,  lwidth(thin)

*pie: earning level in 1978
use Training, clear 
sum re78,d
gen level=0
replace level=1 if re78>0&re78<=20
replace level=2 if re78>20

*histogram
histogram re78,width(2)

graph pie ,over(level) legend(label(1 "No earning") label(2 "Normal")  ///
label(3 "Well-off"))  plabel(_all percent)

graph save "$root/pictures/pie"

4.5 Output
*about the stored results in stata
ttest age==25
return list

*ttest for more than one variables
estpost ttest re74 re75 re78,by(train) 

esttab using $root/tables/ttest.csv, ///
replace wide star title("T-test of earnings")

esttab using $root/tables/ttest.csv, aux(se %9.4f) ///
replace wide star title("T-test of earnings")

	   


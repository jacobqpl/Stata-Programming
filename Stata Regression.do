
************************************ Learning 1 ********************************
cd "/Users/peilinqiu/Desktop/Stata Programming/"
use "GSS2012.dta"


*** Simple Regression
ssc install fre
fre happy7

sum educ
reg happy7 educ
reg happy7 educ, noheader
reg happy7 educ, notable

display 5.2 + 0.0225*12

margins, at(educ=12) nopvalue
margins, at(educ=(12 16 20)) nopvalue
margins, at(educ=(0 (4) 20)) nopvalue vsquish

marginsplot
margins, at(educ=(0(1)20)) vsquish
marginsplot

ssc install recast
marginsplot, recast(line) recastci(rarea)
marginsplot, noci


*** Multiple Regression
sum educ age childs weekswrk
fre class
fre socfrend
reg happy7 age educ childs class weekswrk socfrend

margins, at(childs=(0 1 2 3)) vsquish nopvalue
margins, at(childs=(0 1 2 3) weekswrk=0) vsquish nopvalue

reg happy7 age educ childs class weekswrk socfrend

help lincom
lincom childs*2
lincom weekswrk*26

margins, at(weekswrk=(0 52))

reg happy7 age educ childs class weekswrk socfrend, beta

estat esize
estat esize, omega

reg happy7 age educ childs class weekswrk socrel socommun socfrend socbar

test socrel socommun socfrend socbar

testparm socrel socommun socfrend socbar, equal

test (socrel + socommun + socfrend)/3 = socbar

************************************ Learning 2 ********************************
*** More Details about Regression
use GSS2012.dta

*** regression result options
reg happy7 socfrend class health
reg happy7 socfrend class health, beta
reg happy7 socfrend class health, beta noheader
reg happy7 socfrend class health, notable
reg happy7 socfrend class health, noheader pformat(%4.2f)
reg happy7 socfrend class health, noheader sformat(%4.1f)

reg happy7 socfrend class health, noheader cformat(%4.2f)
reg happy7 socfrend class health, noheader cformat(%4.2f) pformat(%4.2f) sformat(%4.1f)


*** redisplaying results
reg
sum educ childs
reg
reg, beta
reg, level(99)


*** identifying the estimation sample
reg happy7 socfrend class health
estat summarize
sum educ childs
sum educ childs if e(sample)
tab class if e(sample)


*** stored results
ereturn list

reg happy7 socfrend class health
estimates store hap1

reg happy7 socfrend class health age educ childs
estimates store hap2

estimates dir


*** displaying results with the estimates table command
estimates table
estimates table hap1
estimates table hap1 hap2, stats(r2)


************************************ Learning 3 ********************************
*** Presenting regression results ***

*** presenting a single model
use GSS2012.dta
reg happy7 socfrend age educ childs class health
estimate table

estimates table, varlabel varwidth(35)
estimates table, varlabel varwidth(35) drop(_cons)
estimates table, varlabel varwidth(35) drop(_cons) b(%6.3f)
estimates table, varlabel varwidth(35) drop(_cons) b(%6.3f) se
estimates table, varlabel varwidth(35) drop(_cons) b(%6.3f) star(0,05 0.01 0,001)
estimates table, varlabel varwidth(35) drop(_cons) b(%6.3f) star(0,05 0.01 0,001) stats(N r2) 

*** presenting multiple models
* Model 1
reg happy7 socfrend
estimates store mod1

* Model 2
reg happy7 socfrend age educ childs class
estimates store mod2

* Model 3
reg happy7 socfrend age educ childs class health
estimates store mod3

estimates table mod1 mod2 mod3
estimates table mod1 mod2 mod3, varlabel varwidth(35) drop(_cons) b(%6.3f) star(0,05 0.01 0,001) stats(N r2) 


*** presenting a single model with esttab
ssc install estout, replace

reg happy7 socfrend age educ childs class health
estimates table

esttab
esttab using table2a.rtf
esttab using table2b.rtf, nocons ar2 wide
esttab using table2c.rtf, nocons ar2 wide ci
esttab using table2d.rtf, nocons ar2 wide b(%6,3f) ci(%6.3f)
esttab using table2e.rtf, nocons ar2 wide b(%6,3f) ci(%6.3f) label


label variable happy7 "Happiness"
esttab using table2f.rtf, nocons ar2 wide b(%6,3f) ci(%6.3f) label


*** presenting multiple models with esttab
estimates table mod1 mod2 mod3
estimates table mod1 mod2 mod3 using table2g.rtf



*** more commands for presenting regression results
ssc install outreg
ssc install outreg2
ssc install xml_tab, replace























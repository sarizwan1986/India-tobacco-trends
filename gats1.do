//restrict data to 15 to 49 years
drop if age<15
drop if age>49

//any slt use variable 
gen anyslt=.
recode anyslt .=1 if c01<=2
recode anyslt .=0
label variable anyslt "Any SLT use"
label define yesno 1 "Yes" 0 "No"
label values anyslt yesno

//any smoking variable 
gen anysmoke=.
recode anysmoke .=1 if b01<=2
recode anysmoke .=0
label variable anysmoke "Any Smoking"
label values anysmoke yesno

//any tobacco use variable
gen anytob=.
recode anytob .=1 if (anyslt==1 | anysmoke==1)
recode anytob .=0
label variable anytob "Any tobacco use"
label values anytob yesno

//exclusive slt use 
gen eslt=.
recode eslt .=1 if (anyslt==1 & anysmoke==0)
recode eslt .=0
label variable eslt "Exclusive SLT use"
label values eslt yesno

//exclusive smoking
gen esmoke=.
recode esmoke .=1 if (anyslt==0 & anysmoke==1)
recode esmoke .=0
label variable esmoke "Exclusive smoking"
label values esmoke yesno

//dual use
gen dual=.
recode dual .=1 if (anyslt==1 & anysmoke==1)
recode dual .=0
label variable dual "Dual use"
label values dual yesno

//proportions anyslt
proportion anyslt [pweight=gatsweight]
putexcel A1=matrix(r(table)', names) using "gats1", sheet(anyslt6) modify

proportion anyslt [pweight=gatsweight], over(a01)
putexcel A5=matrix(r(table)', names) using "gats1", sheet(anyslt6) modify

proportion anyslt [pweight=gatsweight], over(stateclubbed)
putexcel A15=matrix(r(table)', names) using "gats1", sheet(anyslt6) modify

proportion anyslt [pweight=gatsweight], over(a01 stateclubbed)
putexcel A90=matrix(r(table)', names) using "gats1", sheet(anyslt6) modify

//proportions anysmok
proportion anysmoke [pweight=gatsweight]
putexcel A1=matrix(r(table)', names) using "gats1", sheet(anysmoke6) modify

proportion anysmoke [pweight=gatsweight], over(a01)
putexcel A5=matrix(r(table)', names) using "gats1", sheet(anysmoke6) modify

proportion anysmoke [pweight=gatsweight], over(stateclubbed)
putexcel A15=matrix(r(table)', names) using "gats1", sheet(anysmoke6) modify

proportion anysmoke [pweight=gatsweight], over(a01 stateclubbed)
putexcel A90=matrix(r(table)', names) using "gats1", sheet(anysmoke6) modify

//proportions anytob
proportion anytob [pweight=gatsweight]
putexcel A1=matrix(r(table)', names) using "gats1", sheet(anytob6) modify

proportion anytob [pweight=gatsweight], over(a01)
putexcel A5=matrix(r(table)', names) using "gats1", sheet(anytob6) modify

proportion anytob [pweight=gatsweight], over(stateclubbed)
putexcel A15=matrix(r(table)', names) using "gats1", sheet(anytob6) modify

proportion anytob [pweight=gatsweight], over(a01 stateclubbed)
putexcel A90=matrix(r(table)', names) using "gats1", sheet(anytob6) modify

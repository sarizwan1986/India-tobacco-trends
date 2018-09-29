//restrict data to 15 to 49 years
drop if hv08>49
drop if hv08<15

//any slt use variable 
gen anyslt=.
recode anyslt .=1 if (hv97==1 | hv97==3 | hv97==5)
recode anyslt .=0
label variable anyslt "Any SLT use"
label define yesno 1 "Yes" 0 "No"
label values anyslt yesno

//any smoking variable 
gen anysmoke=.
recode anysmoke .=1 if hv98<=2
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
proportion anyslt [pweight=shhwt], over(state1)
putexcel A15=matrix(r(table)', names) using "dlhs4", sheet(anyslt7) modify

proportion anyslt [pweight=shhwt], over(hv05 state1)
putexcel A90=matrix(r(table)', names) using "dlhs4", sheet(anyslt7) modify

//proportions anysmok
proportion anysmoke [pweight=shhwt], over(state1)
putexcel A15=matrix(r(table)', names) using "dlhs4", sheet(anysmoke7) modify

proportion anysmoke [pweight=shhwt], over(hv05 state1)
putexcel A90=matrix(r(table)', names) using "dlhs4", sheet(anysmoke7) modify

//proportions anytob
proportion anytob [pweight=shhwt], over(state1)
putexcel A15=matrix(r(table)', names) using "dlhs4", sheet(anytob7) modify

proportion anytob [pweight=shhwt], over(hv05 state1)
putexcel A90=matrix(r(table)', names) using "dlhs4", sheet(anytob7) modify

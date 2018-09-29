//restrict data to 15 to 49 years
drop if AGE>49
drop if AGE<15

//any slt use variable 
gen anyslt=.
recode anyslt .=1 if CONSM_TOBACCO==1
recode anyslt .=0
label variable anyslt "Any SLT use"
label define yesno 1 "Yes" 0 "No"
label values anyslt yesno

//any smoking variable 
gen anysmoke=.
recode anysmoke .=1 if CONSM_BIRI_ETC==1
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
proportion anyslt [pweight=MULT_COMB]
putexcel A1=matrix(r(table)', names) using "nsso52", sheet(anyslt3) modify

proportion anyslt [pweight=MULT_COMB], over(SEX)
putexcel A5=matrix(r(table)', names) using "nsso52", sheet(anyslt3) modify

proportion anyslt [pweight=MULT_COMB], over(STATE)
putexcel A15=matrix(r(table)', names) using "nsso52", sheet(anyslt3) modify

proportion anyslt [pweight=MULT_COMB], over(SEX STATE)
putexcel A90=matrix(r(table)', names) using "nsso52", sheet(anyslt3) modify

//proportions anysmok
proportion anysmoke [pweight=MULT_COMB]
putexcel A1=matrix(r(table)', names) using "nsso52", sheet(anysmoke3) modify

proportion anysmoke [pweight=MULT_COMB], over(SEX)
putexcel A5=matrix(r(table)', names) using "nsso52", sheet(anysmoke3) modify

proportion anysmoke [pweight=MULT_COMB], over(STATE)
putexcel A15=matrix(r(table)', names) using "nsso52", sheet(anysmoke3) modify

proportion anysmoke [pweight=MULT_COMB], over(SEX STATE)
putexcel A90=matrix(r(table)', names) using "nsso52", sheet(anysmoke3) modify

//proportions anytob
proportion anytob [pweight=MULT_COMB]
putexcel A1=matrix(r(table)', names) using "nsso52", sheet(anytob3) modify

proportion anytob [pweight=MULT_COMB], over(SEX)
putexcel A5=matrix(r(table)', names) using "nsso52", sheet(anytob3) modify

proportion anytob [pweight=MULT_COMB], over(STATE)
putexcel A15=matrix(r(table)', names) using "nsso52", sheet(anytob3) modify

proportion anytob [pweight=MULT_COMB], over(SEX STATE)
putexcel A90=matrix(r(table)', names) using "nsso52", sheet(anytob3) modify

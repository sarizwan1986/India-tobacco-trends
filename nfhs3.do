//restrict data to 15 to 49 years
drop if v012<15
drop if v012>49

//any slt use variable 
gen anyslt=.
recode anyslt .=1 if (v463c==1 | v463d==1 | v463e==1 | v463f==1 | v463g==1)
recode anyslt .=0
label variable anyslt "Any SLT use"
label define yesno 1 "Yes" 0 "No"
label values anyslt yesno

//any smoking variable 
gen anysmoke=.
recode anysmoke .=1 if (v463a==1 | v463b==1 | v463x==1)
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

//create state sample weight by dividing by 1000000
gen weighting= v005/1000000

//proportions anyslt
proportion anyslt [pweight=weighting]
putexcel A1=matrix(r(table)', names) using "nfhs3", sheet(anyslt5) modify

proportion anyslt [pweight=weighting], over(hv104)
putexcel A5=matrix(r(table)', names) using "nfhs3", sheet(anyslt5) modify

proportion anyslt [pweight=weighting], over(stateclubbed)
putexcel A15=matrix(r(table)', names) using "nfhs3", sheet(anyslt5) modify

proportion anyslt [pweight=weighting], over(hv104 stateclubbed)
putexcel A90=matrix(r(table)', names) using "nfhs3", sheet(anyslt5) modify

//proportions anysmok
proportion anysmoke [pweight=weighting]
putexcel A1=matrix(r(table)', names) using "nfhs3", sheet(anysmoke5) modify

proportion anysmoke [pweight=weighting], over(hv104)
putexcel A5=matrix(r(table)', names) using "nfhs3", sheet(anysmoke5) modify

proportion anysmoke [pweight=weighting], over(stateclubbed)
putexcel A15=matrix(r(table)', names) using "nfhs3", sheet(anysmoke5) modify

proportion anysmoke [pweight=weighting], over(hv104 stateclubbed)
putexcel A90=matrix(r(table)', names) using "nfhs3", sheet(anysmoke5) modify

//proportions anytob
proportion anytob [pweight=weighting]
putexcel A1=matrix(r(table)', names) using "nfhs3", sheet(anytob5) modify

proportion anytob [pweight=weighting], over(hv104)
putexcel A5=matrix(r(table)', names) using "nfhs3", sheet(anytob5) modify

proportion anytob [pweight=weighting], over(stateclubbed)
putexcel A15=matrix(r(table)', names) using "nfhs3", sheet(anytob5) modify

proportion anytob [pweight=weighting], over(hv104 stateclubbed)
putexcel A90=matrix(r(table)', names) using "nfhs3", sheet(anytob5) modify

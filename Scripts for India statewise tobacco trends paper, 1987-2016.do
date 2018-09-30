			*****************************************************************************
			SCRIPTS WRITTEN IN STATA FOR INDIA STATE WISE TOBACCO TRENDS PAPER, 1987-2016
			***************************************************************************** 

					 ****************************************
					  SECTION A: GENERAL SCHEMA FOR ANALYSIS
					 ****************************************

				       **Part I - Data preprocessing steps**

//Set working directory and log file
cd “pathname of the folder in the system”
capture log using logfilename, text replace

//Load the dataset
Use "pathname of the datafile.dta", clear

//restrict age to 15 to 49 years
drop if age>49
drop if age<15

//create standardised tobacco use indicators from consitutent variables

//create any smokeless use indicator
gen anyslt=.
recode anyslt .=1 if (question1==appropriate code | question2==appropriate code)
//Question* means variable names of smokeless tobacco use and appropriate codes indicates current use
recode anyslt .=0
label variable anyslt "Any SLT use"
label define yesno 1 "Yes" 0 "No"
label values anyslt yesno

//create any smoked tobacco use indicator 
gen anysmoke=.
recode anysmoke .=1 if (question1==appropriate code|question2==appropriate code)
//Question* means variable names of smoked tobacco use and appropriate codes indicates current use
recode anysmoke .=0
label variable anysmoke "Any Smoking"
label values anysmoke yesno

//derive any tobacco use indicator 
gen anytob=.
recode anytob .=1 if (anyslt==1 | anysmoke==1)
recode anytob .=0
label variable anytob "Any tobacco use"
label values anytob yesno

//derive exclusive smokeless tobacco use indicator 
gen eslt=.
recode eslt .=1 if (anyslt==1 & anysmoke==0)
recode eslt .=0
label variable eslt "Exclusive SLT use"
label values eslt yesno

//derive exclusive smoked tobacco use indicator 
gen esmoke=.
recode esmoke .=1 if (anyslt==0 & anysmoke==1)
recode esmoke .=0
label variable esmoke "Exclusive smoking"
label values esmoke yesno

//derive dual tobacco use indicator 
gen dual=.
recode dual .=1 if (anyslt==1 & anysmoke==1)
recode dual .=0
label variable dual "Dual use"
label values dual yesno

//For NFHS surveys, weighting variable needs to be derived by dividing original weight by 1000000
gen weighting= originalweight/1000000

	**Part II - Statistical analysis - calculation of prevalence and 95% CI**

						**1. Any smokeless tobacco use**
		
//calculate prevalence, national level
proportion anyslt [pweight=weightingvariable]
putexcel A1=matrix(r(table)', names) using "surveyname", sheet(anyslt) modify

//calculate prevalence, gender wise
proportion anyslt [pweight=weightingvariable], over(gendervariable)
putexcel A5=matrix(r(table)', names) using "surveyname", sheet(anyslt) modify

//calculate prevalence, state wise
proportion anyslt [pweight=weightingvariable], over(statevariable)
putexcel A15=matrix(r(table)', names) using "surveyname", sheet(anyslt) modify

//calculate prevalence, state-gender wise
proportion anyslt [pweight=weightingvariable], over(gendervariable statevariable)
putexcel A90=matrix(r(table)', names) using "surveyname", sheet(anyslt) modify

						**2. Any smoked tobacco use**

//calculate prevalence, national level
proportion anysmoke [pweight=weightingvariable]
putexcel A1=matrix(r(table)', names) using "surveyname", sheet(anysmoke) modify

//calculate prevalence, gender wise
proportion anysmoke [pweight=weightingvariable], over(gendervariable)
putexcel A5=matrix(r(table)', names) using "surveyname", sheet(anysmoke) modify

//calculate prevalence, state wise
proportion anysmoke [pweight=weightingvariable], over(statevariable)
putexcel A15=matrix(r(table)', names) using "surveyname", sheet(anysmoke) modify

//calculate prevalence, state-gender wise
proportion anysmoke [pweight=weightingvariable], over(gendervariable statevariable)
putexcel A90=matrix(r(table)', names) using "surveyname", sheet(anysmoke) modify
						
						  **3. Any tobacco use**
						
//calculate prevalence, national level
proportion anytob [pweight=weightingvariable]
putexcel A1=matrix(r(table)', names) using "surveyname", sheet(anytob) modify

//calculate prevalence, gender wise
proportion anytob [pweight=weightingvariable], over(gendervariable)
putexcel A5=matrix(r(table)', names) using "surveyname", sheet(anytob) modify

//calculate prevalence, state wise
proportion anytob [pweight=weightingvariable], over(statevariable)
putexcel A15=matrix(r(table)', names) using "surveyname", sheet(anytob) modify

//calculate prevalence, state-gender wise
proportion anytob [pweight=weightingvariable], over(gendervariable statevariable)
putexcel A90=matrix(r(table)', names) using "surveyname", sheet(anytob) modify

________________________________________________________________________________
--------------------------------------------------------------------------------					 
					 
				  *****************************************
				   SECTION B: CODES FOR INDIVIDUAL SURVEYS
				  *****************************************

					   ***************************
						1. NSSO 43 CODES
					   ***************************
			   
//Load the dataset
Use "pathname of the datafile.dta", clear
					   
//restrict data to 15 to 49 years
drop if B4_q5>49
drop if B4_q5<15

//any slt use variable 
gen anyslt=.
recode anyslt .=1 if (B4_q14<=2 | B4_q15<=2 | B4_q16<=2)
recode anyslt .=0
label variable anyslt "Any SLT use"
label define yesno 1 "Yes" 0 "No"
label values anyslt yesno

//any smoking variable 
gen anysmoke=.
recode anysmoke .=1 if B4_q13<=2
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
proportion anyslt [pweight=Wgt]
putexcel A1=matrix(r(table)', names) using "nsso43", sheet(anyslt1) modify

proportion anyslt [pweight=Wgt], over(B4_q4)
putexcel A5=matrix(r(table)', names) using "nsso43", sheet(anyslt1) modify

proportion anyslt [pweight=Wgt], over(State)
putexcel A15=matrix(r(table)', names) using "nsso43", sheet(anyslt1) modify

proportion anyslt [pweight=Wgt], over(B4_q4 State)
putexcel A90=matrix(r(table)', names) using "nsso43", sheet(anyslt1) modify

//proportions anysmok
proportion anysmoke [pweight=Wgt]
putexcel A1=matrix(r(table)', names) using "nsso43", sheet(anysmoke1) modify

proportion anysmoke [pweight=Wgt], over(B4_q4)
putexcel A5=matrix(r(table)', names) using "nsso43", sheet(anysmoke1) modify

proportion anysmoke [pweight=Wgt], over(State)
putexcel A15=matrix(r(table)', names) using "nsso43", sheet(anysmoke1) modify

proportion anysmoke [pweight=Wgt], over(B4_q4 State)
putexcel A90=matrix(r(table)', names) using "nsso43", sheet(anysmoke1) modify

//proportions anytob
proportion anytob [pweight=Wgt]
putexcel A1=matrix(r(table)', names) using "nsso43", sheet(anytob1) modify

proportion anytob [pweight=Wgt], over(B4_q4)
putexcel A5=matrix(r(table)', names) using "nsso43", sheet(anytob1) modify

proportion anytob [pweight=Wgt], over(State)
putexcel A15=matrix(r(table)', names) using "nsso43", sheet(anytob1) modify

proportion anytob [pweight=Wgt], over(B4_q4 State)
putexcel A90=matrix(r(table)', names) using "nsso43", sheet(anytob1) modify


					   ***************************
						2. NSSO 50 CODES
					   ***************************

//Load the dataset
Use "pathname of the datafile.dta", clear

//restrict data to 15 to 49 years
drop if B4_q5>49
drop if B4_q5<15

//any slt use variable 
gen anyslt=.
recode anyslt .=1 if (B4_q16==1 | B4_q17<=1 | B4_q18<=1 | B4_q16==2 | B4_q17<=2 | B4_q18<=2)
recode anyslt .=0
label variable anyslt "Any SLT use"
label define yesno 1 "Yes" 0 "No"
label values anyslt yesno

//any smoking variable 
gen anysmoke=.
recode anysmoke .=1 if B4_q15==1|B4_q15==2
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
proportion anyslt [pweight=Wgt_Combined]
putexcel A1=matrix(r(table)', names) using "nsso50", sheet(anyslt2) modify

proportion anyslt [pweight=Wgt_Combined], over(B4_q4)
putexcel A5=matrix(r(table)', names) using "nsso50", sheet(anyslt2) modify

proportion anyslt [pweight=Wgt_Combined], over(State)
putexcel A15=matrix(r(table)', names) using "nsso50", sheet(anyslt2) modify

proportion anyslt [pweight=Wgt_Combined], over(B4_q4 State)
putexcel A90=matrix(r(table)', names) using "nsso50", sheet(anyslt2) modify

//proportions anysmok
proportion anysmoke [pweight=Wgt_Combined]
putexcel A1=matrix(r(table)', names) using "nsso50", sheet(anysmoke2) modify

proportion anysmoke [pweight=Wgt_Combined], over(B4_q4)
putexcel A5=matrix(r(table)', names) using "nsso50", sheet(anysmoke2) modify

proportion anysmoke [pweight=Wgt_Combined], over(State)
putexcel A15=matrix(r(table)', names) using "nsso50", sheet(anysmoke2) modify

proportion anysmoke [pweight=Wgt_Combined], over(B4_q4 State)
putexcel A90=matrix(r(table)', names) using "nsso50", sheet(anysmoke2) modify

//proportions anytob
proportion anytob [pweight=Wgt_Combined]
putexcel A1=matrix(r(table)', names) using "nsso50", sheet(anytob2) modify

proportion anytob [pweight=Wgt_Combined], over(B4_q4)
putexcel A5=matrix(r(table)', names) using "nsso50", sheet(anytob2) modify

proportion anytob [pweight=Wgt_Combined], over(State)
putexcel A15=matrix(r(table)', names) using "nsso50", sheet(anytob2) modify

proportion anytob [pweight=Wgt_Combined], over(B4_q4 State)
putexcel A90=matrix(r(table)', names) using "nsso50", sheet(anytob2) modify


					   ***************************
						3. NSSO 52 CODES
					   ***************************

//Load the dataset
Use "pathname of the datafile.dta", clear
					   
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


					   ***************************
						4. NFHS 2 CODES
					   ***************************

					   
//Load the dataset
Use "pathname of the datafile.dta", clear

//restrict data to 15 to 49 years
drop if hv105>49
drop if hv105<15

//any slt use variable 
gen anyslt=.
recode anyslt .=1 if sh24==1
recode anyslt .=0
label variable anyslt "Any SLT use"
label define yesno 1 "Yes" 0 "No"
label values anyslt yesno

//any smoking variable 
gen anysmoke=.
recode anysmoke .=1 if sh26==1
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

//create sample weight by dividing by 1000000
gen weighting= hv005/1000000

//proportions anyslt
proportion anyslt [pweight=weighting]
putexcel A1=matrix(r(table)', names) using "nfhs2", sheet(anyslt4) modify

proportion anyslt [pweight=weighting], over(hv104)
putexcel A5=matrix(r(table)', names) using "nfhs2", sheet(anyslt4) modify

proportion anyslt [pweight=weighting], over(statenew)
putexcel A15=matrix(r(table)', names) using "nfhs2", sheet(anyslt4) modify

proportion anyslt [pweight=weighting], over(hv104 statenew)
putexcel A90=matrix(r(table)', names) using "nfhs2", sheet(anyslt4) modify

//proportions anysmok
proportion anysmoke [pweight=weighting]
putexcel A1=matrix(r(table)', names) using "nfhs2", sheet(anysmoke4) modify

proportion anysmoke [pweight=weighting], over(hv104)
putexcel A5=matrix(r(table)', names) using "nfhs2", sheet(anysmoke4) modify

proportion anysmoke [pweight=weighting], over(statenew)
putexcel A15=matrix(r(table)', names) using "nfhs2", sheet(anysmoke4) modify

proportion anysmoke [pweight=weighting], over(hv104 statenew)
putexcel A90=matrix(r(table)', names) using "nfhs2", sheet(anysmoke4) modify

//proportions anytob
proportion anytob [pweight=weighting]
putexcel A1=matrix(r(table)', names) using "nfhs2", sheet(anytob4) modify

proportion anytob [pweight=weighting], over(hv104)
putexcel A5=matrix(r(table)', names) using "nfhs2", sheet(anytob4) modify

proportion anytob [pweight=weighting], over(statenew)
putexcel A15=matrix(r(table)', names) using "nfhs2", sheet(anytob4) modify

proportion anytob [pweight=weighting], over(hv104 statenew)
putexcel A90=matrix(r(table)', names) using "nfhs2", sheet(anytob4) modify


					   ***************************
						5.  NFHS 3 CODES
					   ***************************
			
//Load the dataset
Use "pathname of the datafile.dta", clear
		   
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

//create sample weight by dividing by 1000000
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

					   ***************************
						6. NFHS 4 CODES
					   ***************************

//Load the dataset
Use "pathname of the datafile.dta", clear					   
					   
//restrict data to 15 to 49 years
drop if v012<15
drop if v012>49

//any slt use variable 
gen anyslt=.
recode anyslt .=1 if (v463c==1 | v463d==1 | v463f==1 | v463g==1 | s710e==1)
recode anyslt .=0
label variable anyslt "Any SLT use"
label define yesno 1 "Yes" 0 "No"
label values anyslt yesno

//any smoking variable 
gen anysmoke=.
recode anysmoke .=1 if (v463a==1 | v463b==1 | v463e==1 | s707==1 | s710c==1)
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

//create sample weight by dividing by 1000000
gen weighting= v005/1000000

//proportions anyslt
proportion anyslt [pweight=weighting]
putexcel A1=matrix(r(table)', names) using "nfhs4", sheet(anyslt8) modify

proportion anyslt [pweight=weighting], over(hv104)
putexcel A5=matrix(r(table)', names) using "nfhs4", sheet(anyslt8) modify

proportion anyslt [pweight=weighting], over(stateclubbed)
putexcel A15=matrix(r(table)', names) using "nfhs4", sheet(anyslt8) modify

proportion anyslt [pweight=weighting], over(hv104 stateclubbed)
putexcel A90=matrix(r(table)', names) using "nfhs4", sheet(anyslt8) modify

//proportions anysmok
proportion anysmoke [pweight=weighting]
putexcel A1=matrix(r(table)', names) using "nfhs4", sheet(anysmoke8) modify

proportion anysmoke [pweight=weighting], over(hv104)
putexcel A5=matrix(r(table)', names) using "nfhs4", sheet(anysmoke8) modify

proportion anysmoke [pweight=weighting], over(stateclubbed)
putexcel A15=matrix(r(table)', names) using "nfhs4", sheet(anysmoke8) modify

proportion anysmoke [pweight=weighting], over(hv104 stateclubbed)
putexcel A90=matrix(r(table)', names) using "nfhs4", sheet(anysmoke8) modify

//proportions anytob
proportion anytob [pweight=weighting]
putexcel A1=matrix(r(table)', names) using "nfhs4", sheet(anytob8) modify

proportion anytob [pweight=weighting], over(hv104)
putexcel A5=matrix(r(table)', names) using "nfhs4", sheet(anytob8) modify

proportion anytob [pweight=weighting], over(stateclubbed)
putexcel A15=matrix(r(table)', names) using "nfhs4", sheet(anytob8) modify

proportion anytob [pweight=weighting], over(hv104 stateclubbed)
putexcel A90=matrix(r(table)', names) using "nfhs4", sheet(anytob8) modify


					   ***************************
						7. DLHS 4 CODES
					   ***************************  

//Load the dataset
Use "pathname of the datafile.dta", clear
					   
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

					   
					   ***************************
						8. GATS 1 CODES
					   ***************************  

//Load the dataset
Use "pathname of the datafile.dta", clear
		
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
					   
					   				   
					   ***************************
						9. GATS 2 CODES
					   ***************************
					
//Load the dataset
Use "pathname of the datafile.dta", clear

	
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
putexcel A1=matrix(r(table)', names) using "gats2", sheet(anyslt9) modify

proportion anyslt [pweight=gatsweight], over(a01)
putexcel A5=matrix(r(table)', names) using "gats2", sheet(anyslt9) modify

proportion anyslt [pweight=gatsweight], over(state)
putexcel A15=matrix(r(table)', names) using "gats2", sheet(anyslt9) modify

proportion anyslt [pweight=gatsweight], over(a01 state)
putexcel A90=matrix(r(table)', names) using "gats2", sheet(anyslt9) modify

//proportions anysmok
proportion anysmoke [pweight=gatsweight]
putexcel A1=matrix(r(table)', names) using "gats2", sheet(anysmoke9) modify

proportion anysmoke [pweight=gatsweight], over(a01)
putexcel A5=matrix(r(table)', names) using "gats2", sheet(anysmoke9) modify

proportion anysmoke [pweight=gatsweight], over(state)
putexcel A15=matrix(r(table)', names) using "gats2", sheet(anysmoke9) modify

proportion anysmoke [pweight=gatsweight], over(a01 state)
putexcel A90=matrix(r(table)', names) using "gats2", sheet(anysmoke9) modify

//proportions anytob
proportion anytob [pweight=gatsweight]
putexcel A1=matrix(r(table)', names) using "gats2", sheet(anytob9) modify

proportion anytob [pweight=gatsweight], over(a01)
putexcel A5=matrix(r(table)', names) using "gats2", sheet(anytob9) modify

proportion anytob [pweight=gatsweight], over(state)
putexcel A15=matrix(r(table)', names) using "gats2", sheet(anytob9) modify

proportion anytob [pweight=gatsweight], over(a01 state)
putexcel A90=matrix(r(table)', names) using "gats2", sheet(anytob9) modify

clear

version 8
set mem 200m
set matsize 600


use JCRDATA 


************************************************************************************
** FACTION DUMMIES (MOST RECENT FACTION BEFORE THE END OF THE WAR)
************************************************************************************

gen Faction_Last = Faction_00

replace Faction_Last=Faction_99 if Faction_Last==6 | Faction_Last==.
replace Faction_Last=Faction_98 if Faction_Last==6 | Faction_Last==.
replace Faction_Last=Faction_97 if Faction_Last==6 | Faction_Last==.
replace Faction_Last=Faction_96 if Faction_Last==6 | Faction_Last==.
replace Faction_Last=Faction_92 if Faction_Last==6 | Faction_Last==.
replace Faction_Last=Join_91 if Faction_Last==6 | Faction_Last==.
replace Faction_Last=4 if surveyid==12040

gen SLA = (Faction_Last==1) if Faction_Last!=.
gen RUF = (Faction_Last==2) if Faction_Last!=.
gen AFRC= (Faction_Last==3) if Faction_Last!=.
gen CDF = (Faction_Last==4) if Faction_Last!=.
gen WSB = (Faction_Last==5) if Faction_Last!=.
gen NONE = (Faction_Last==6) if Faction_Last!=.


************************************************************************************
** DEPENDENT VARIABLES
************************************************************************************

gen DEPENDENT_VARS = .
lab var DEPENDENT_VARS  "__________________________

************************************************************************************
** DELINKED
************************************************************************************

egen TOP = rmax( P_Complain_local P_Complain_Freetown P_Complain_Trad P_Complain_Faction P_Complain_NGOs P_Complain_Elections P_Complain_Peaceful P_Complain_Internat P_Complain_Fight)
gen DELINKED = (P_Complain_Faction!=TOP) if P_Complain_Faction!=.
replace DELINKED = 0 if Free_time==5 | Start_B==5


************************************************************************************
** Employment
************************************************************************************
gen EMPLOY=1 if r_job_now!=.
replace EMPLOY=0 if r_job_now==0 | r_job_now==11  | r_job_now==12 


************************************************************************************
** Belief in Democracy
************************************************************************************

gen DEMBELIEF = 0 if  P_Complain_Elections!=.
replace DEMBELIEF = 1 if   P_Complain_Elections!=. &  P_Complain_Elections==TOP
replace DEMBELIEF = 1 if   P_Complain_Freetown!=. &  P_Complain_Freetown==TOP
replace DEMBELIEF = 1 if   P_Complain_local!=. &  P_Complain_local==TOP
drop TOP


************************************************************************************
** Acceptance (Today)
************************************************************************************

gen ACCEPTED = (Prob_Acc_Fam_Today + Prob_Acc_Neighb_Today==6)  if Prob_Acc_Fam_Today!=.  & Prob_Acc_Neighb_Today!=.  


 
************************************************************************************
** Independent Variables  
************************************************************************************

gen INDEPENDENT_VARS = .
lab var INDEPENDENT_VARS  "__________________________

**** DISTRUST 
************************************************************************************
gen N = 0
	foreach V in Renege_Gov Renege_SLA Renege_RUF Renege_AFRC Renege_CDF Renege_WSB Renege_Peo Renege_Other  {
	replace N = N+ `V' if `V'!=.
	}
gen DISTRUST = Lome_Ren==2 if Lome_Ren!=.
	foreach var in SLA RUF AFRC CDF WSB {
	replace DISTRUST = 0 if N==1 & Renege_`var'==1 & `var'==1
	}
drop N
lab var DISTRUST "Distrust -- belief that another faction would renege

**** DISSATISFACTION 
************************************************************************************

gen DISSATISFIED = 0 if Lome_Worst!=.
replace DISSATISFIED = 1 if SLA==1 & Lome_Worst==2
replace DISSATISFIED = 1 if RUF==1 & Lome_Worst==3
replace DISSATISFIED = 1 if AFRC==1 & Lome_Worst==4
replace DISSATISFIED = 1 if CDF==1 & Lome_Worst==5
replace DISSATISFIED = 1 if WSB==1 & Lome_Worst==6
lab var DISSATISFIED "Dissatisfaction with group's terms at Lome


**** ETHNICITY
************************************************************************************
gen MENDE = (Tribe1==1) if Tribe1!=.


**** EDUCATION
************************************************************************************

gen EDUCATE = 0
replace EDUCATE = 1 if r_educa>1
replace EDUCATE = 2 if r_educa>3
label define EDU 0 None 1 Primary 2 More
label values EDUCATE EDU
lab var EDUCATE "Education: None, Primary or More


**** POVERTY
************************************************************************************

gen POOR= (walls==1)  if walls!=.


**** OFFICER
************************************************************************************

gen OFFICER = (rank_2>=8)*(rank_2<16) if rank_2!=.
replace OFFICER = 1 if rank_2==16 | rank_2==21 
lab var OFFICER "Officer in the faction




**** ABUSIVE UNIT
************************************************************************************

factor  Food_regular  Food_whenever trouble_steal_civ trouble_rape_civ trouble_amputate_civ Food_forced Prot_Civ Edu_Civ 
score ABUSE_CIVILIANS
lab var ABUSE "Index of civilian Abuse based on Food_regular  Food_whenever trouble_steal_civ trouble_rape_civ trouble_amputate_civ Food_forced Prot_Civ Edu_Civ 
egen tempt=max(ABUSE)
egen templ=min(ABUSE)
replace ABUSE = (ABUSE - templ)/(tempt-templ)
drop tempt templ

egen SFD_ABUSE = mean(ABUSE_C), by(SF_R RESPLOC_L2 Period)
lab var SFD_ABUSE "Unit ABUSE based on Subfaction and District
egen FCH_ABUSE = mean(ABUSE_C), by(Faction_R RESPLOC_L3 Period)
lab var FCH_ABUSE "Unit ABUSE based on Faction and Chiefdom 

gen ABUSIVE = (FCH_ABUSE + SFD_ABUSE)/2
replace ABUSIVE=FCH_ABUSE if ABUSIVE==.
replace ABUSIVE=SFD_ABUSE if ABUSIVE==.


**** District Wealth
************************************************************************************

factor  D_p0food  D_rent  
score DIST_WEALTH
egen tempt=max(DIST_WEALTH)
egen templ=min(DIST_WEALTH)
replace DIST_WEALTH = (DIST_WEALTH - templ)/(tempt-templ)
drop tempt templ


preserve
egen SUFFERING = mean(ABUSIVE), by(RESPLOC_L3)
egen tagt = tag(RESPLOC_L3)
drop if tagt!=1
keep SUFFERING RESPLOC_L3
ren RESPLOC_L3 Cdom
sort Cdom
save TEMP, replace
restore

gen Cdom = SURV_LOC_L3
sort Cdom
merge Cdom using TEMP
drop _m Cdom
egen FTSUFFERING = mean(SUFFERING) if SURV_LOC_L1==3
replace SUFFERING = FTSUFFERING if SURV_LOC_L3==301000 | SURV_LOC_L3==302000 
drop FTSUFFERING



************************************************************************************
** PROGRAM VARS
************************************************************************************

gen PROGRAM_VARS = .
lab var PROGRAM "__________________________


****  ENTER
************************************************************************************

gen GO_DDR = 2-Enter_DDR
lab var GO_DDR "Binary - did respondent enter DDR program
label define BIN01 0 No 1 Yes 
label values GO_DDR BIN01

****  COMPLETE
************************************************************************************

gen COMPLETE_DDR = GO_DDR
replace COMPLETE_DDR= 0 if  DDR_Completed==2


****  SPILLOVER
************************************************************************************

egen PER_DEMOB = mean (GO_DDR), by (SURV_LOC_L3)


gen OTHER = .
lab var OTHER "__________________________

drop if surveyid==.


************************************************************************************
************************************************************************************
***** ANALYSIS
************************************************************************************
************************************************************************************


************************************************************************************
** TABLE 2: DEPENDENT VARIABLES
************************************************************************************

sum DELINKED  EMPLOY DEMBELIEF ACCEPTED 
sum DELINKED  EMPLOY DEMBELIEF ACCEPTED  if CDF==1
sum DELINKED  EMPLOY DEMBELIEF ACCEPTED  if RUF==1

ttest DELINKED  if CDF==1 | RUF==1, by(CDF)
ttest EMPLOY  if CDF==1 | RUF==1, by(CDF)
ttest DEMB  if CDF==1 | RUF==1, by(CDF)
ttest ACCEPTED if CDF==1 | RUF==1, by(CDF)



************************************************************************************
** TABLE 3 Examine correlations of key DVs
************************************************************************************

pwcorr 	DELINKED  EMPLOY DEMBELIEF ACCEPTED 
factor 	DELINKED  EMPLOY DEMBELIEF ACCEPTED 
alpha 	DELINKED  EMPLOY DEMBELIEF ACCEPTED 
* if value is above .7 or .8, seen as reliable


************************************************************************************
** TABLE 4: Basic Multivariate Regression 
************************************************************************************

global X_Vars (DISTRUST DISSATISFIED age gender MENDE EDUCATE POOR reason_abducted reason_suppor OFFICER ABUSIVE DIST_WEALTH  SUFFERING SLA AFRC CDF WSB)

xi: dprobit DELINKED $X_Vars , cluster (SURV_LOC_L3)
outreg using T4, 3aster bracket bdec(3) addstat(Pseudo R2, e(r2_p)) replace

xi: dprobit EMPLOY $X_Vars , cluster (SURV_LOC_L3)
outreg using T4, 3aster bracket bdec(3)  addstat(Pseudo R2, e(r2_p)) append

xi: dprobit DEMBELIEF $X_Vars , cluster (SURV_LOC_L3)
outreg using T4, 3aster bracket bdec(3) addstat(Pseudo R2, e(r2_p)) append

xi: dprobit ACCEPTED 	 $X_Vars , cluster (SURV_LOC_L3)
outreg using T4, 3aster bracket bdec(3) addstat(Pseudo R2, e(r2_p)) append




************************************************************************************
** TABLE 5:  Multivariate Regression with GO_DDR and COMPLETE_DDR
************************************************************************************

global X_Vars (DISTRUST DISSATISFIED age gender MENDE EDUCATE POOR reason_abducted reason_suppor OFFICER ABUSIVE DIST_WEALTH  SUFFERING SLA AFRC CDF WSB)

xi: dprobit DELINKED GO_DDR DISTRUST DISSATISFIED	 $X_Vars , cluster (SURV_LOC_L3)
outreg using T5, 3aster bracket bdec(3) addstat(Pseudo R2, e(r2_p)) replace

xi: dprobit EMPLOY GO_DDR DISTRUST DISSATISFIED  $X_Vars , cluster (SURV_LOC_L3)
outreg using T5, 3aster bracket bdec(3)  addstat(Pseudo R2, e(r2_p)) append

xi: dprobit DEMBELIEF GO_DDR DISTRUST DISSATISFIED $X_Vars , cluster (SURV_LOC_L3)
outreg using T5, 3aster bracket bdec(3) addstat(Pseudo R2, e(r2_p)) append

xi: dprobit ACCEPTED GO_DDR DISTRUST DISSATISFIED  $X_Vars , cluster (SURV_LOC_L3)
outreg using T5, 3aster bracket bdec(3) addstat(Pseudo R2, e(r2_p)) append

xi: dprobit DELINKED COMPLETE_DDR  DISTRUST DISSATISFIED  	 $X_Vars , cluster (SURV_LOC_L3)
outreg using T5, 3aster bracket bdec(3) addstat(Pseudo R2, e(r2_p)) append

xi: dprobit EMPLOY COMPLETE_DDR  DISTRUST DISSATISFIED  $X_Vars , cluster (SURV_LOC_L3)
outreg using T5, 3aster bracket bdec(3)  addstat(Pseudo R2, e(r2_p)) append

xi: dprobit DEMBELIEF COMPLETE_DDR  DISTRUST DISSATISFIED    $X_Vars , cluster (SURV_LOC_L3)
outreg using T5, 3aster bracket bdec(3) addstat(Pseudo R2, e(r2_p)) append

xi: dprobit ACCEPTED COMPLETE_DDR  DISTRUST DISSATISFIED     $X_Vars , cluster (SURV_LOC_L3)
outreg using T5, 3aster bracket bdec(3) addstat(Pseudo R2, e(r2_p)) append




************************************************************************************
** Table 6: Multivariate Regression GO_DDR and COMPLETE_DDR with INTERACTIONS
************************************************************************************

global X_Vars (DISTRUST DISSATISFIED age gender MENDE EDUCATE POOR reason_abducted reason_suppor OFFICER ABUSIVE DIST_WEALTH  SUFFERING SLA AFRC CDF WSB)


xi: dprobit DELINKED i.DISTRUST*GO_DDR i.DISSATISFIED*GO_DDR	 $X_Vars , cluster (SURV_LOC_L3)
outreg using T6, 3aster bracket bdec(3) addstat(Pseudo R2, e(r2_p)) replace

xi: dprobit EMPLOY i.DISTRUST*GO_DDR  i.DISSATISFIED*GO_DDR  $X_Vars , cluster (SURV_LOC_L3)
outreg using T6, 3aster bracket bdec(3)  addstat(Pseudo R2, e(r2_p)) append

xi: dprobit DEMBELIEF i.DISTRUST*GO_DDR   i.DISSATISFIED*GO_DDR $X_Vars , cluster (SURV_LOC_L3)
outreg using T6, 3aster bracket bdec(3) addstat(Pseudo R2, e(r2_p)) append

xi: dprobit ACCEPTED i.DISTRUST*GO_DDR  i.DISSATISFIED*GO_DDR  $X_Vars , cluster (SURV_LOC_L3)
outreg using T6, 3aster bracket bdec(3) addstat(Pseudo R2, e(r2_p)) append


xi: dprobit DELINKED i.COMPLETE_DDR*DISTRUST  i.COMPLETE_DDR*DISSATISFIED  	 $X_Vars , cluster (SURV_LOC_L3)
outreg using T6, 3aster bracket bdec(3) addstat(Pseudo R2, e(r2_p)) append

xi: dprobit EMPLOY i.COMPLETE_DDR*DISTRUST  i.COMPLETE_DDR*DISSATISFIED   $X_Vars , cluster (SURV_LOC_L3)
outreg using T6, 3aster bracket bdec(3)  addstat(Pseudo R2, e(r2_p)) append

xi: dprobit DEMBELIEF i.COMPLETE_DDR*DISTRUST  i.COMPLETE_DDR*DISSATISFIED  $X_Vars , cluster (SURV_LOC_L3)
outreg using T6, 3aster bracket bdec(3) addstat(Pseudo R2, e(r2_p)) append

xi: dprobit ACCEPTED i.COMPLETE_DDR*DISTRUST  i.COMPLETE_DDR*DISSATISFIED  $X_Vars , cluster (SURV_LOC_L3)
outreg using T6, 3aster bracket bdec(3) addstat(Pseudo R2, e(r2_p)) append




************************************************************************************
****** TABLE 7 SPILLOVER
************************************************************************************

xi: dprobit DELINKED GO_DDR  PER_DEMOB   $X_Vars , cluster (SURV_LOC_L3)
outreg using T7, 3aster bracket bdec(3) addstat(Pseudo R2, e(r2_p)) replace

xi: dprobit EMPLOY GO_DDR PER_DEMOB    $X_Vars , cluster (SURV_LOC_L3)
outreg using T7, 3aster bracket bdec(3)  addstat(Pseudo R2, e(r2_p)) append

xi: dprobit DEMBELIEF GO_DDR PER_DEMOB   $X_Vars , cluster (SURV_LOC_L3)
outreg using T7, 3aster bracket bdec(3) addstat(Pseudo R2, e(r2_p)) append

xi: dprobit ACCEPTED GO_DDR PER_DEMOB   $X_Vars , cluster (SURV_LOC_L3)
outreg using T7, 3aster bracket bdec(3) addstat(Pseudo R2, e(r2_p)) append

estsimp  probit ACCEPTED GO_DDR PER_DEMOB   DISTRUST DISSATISFIED age gender MENDE EDUCATE POOR reason_abducted reason_suppor OFFICER ABUSIVE DIST_WEALTH  SUFFERING CDF RUF, cluster (SURV_LOC_L3)
setx PER_DEMOB 0 GO_DDR 0
simqi
setx PER_DEMOB .87 GO_DDR 0
simqi
setx PER_DEMOB 1 GO_DDR 0
simqi



xi: dprobit DELINKED i.GO_DDR*PER_DEMOB   $X_Vars , cluster (SURV_LOC_L3)
outreg using T7, 3aster bracket bdec(3) addstat(Pseudo R2, e(r2_p)) append

xi: dprobit EMPLOY i.GO_DDR*PER_DEMOB    $X_Vars , cluster (SURV_LOC_L3)
outreg using T7, 3aster bracket bdec(3)  addstat(Pseudo R2, e(r2_p)) append

xi: dprobit DEMBELIEF i.GO_DDR*PER_DEMOB   $X_Vars , cluster (SURV_LOC_L3)
outreg using T7, 3aster bracket bdec(3) addstat(Pseudo R2, e(r2_p)) append

xi: dprobit ACCEPTED i.GO_DDR*PER_DEMOB   $X_Vars , cluster (SURV_LOC_L3)
outreg using T7, 3aster bracket bdec(3) addstat(Pseudo R2, e(r2_p)) append


gen GO_DDR_PER_DEMOB= GO_DDR*PER_DEMOB
drop b1-b18
estsimp  probit ACCEPTED GO_DDR GO_DDR_PER_DEMOB PER_DEMOB   DISTRUST DISSATISFIED age gender MENDE EDUCATE POOR reason_abducted reason_suppor OFFICER ABUSIVE DIST_WEALTH  SUFFERING CDF RUF, cluster (SURV_LOC_L3)
setx PER_DEMOB 0 GO_DDR 0 GO_DDR_PER_DEMOB 0
simqi
setx PER_DEMOB .87 GO_DDR 0 GO_DDR_PER_DEMOB 0
simqi
setx PER_DEMOB 1 GO_DDR 0 GO_DDR_PER_DEMOB 0
simqi



**************************************************************************************
** TABLE 8:  Propensity Score Matching
**************************************************************************************

* ssc install psmatch2, replace


xi: psmatch2 GO_DDR $X_Vars i.SURV_LOC_L2, outcome(DELINKED)  
xi: psmatch2 GO_DDR $X_Vars i.SURV_LOC_L2, outcome(EMPLOY )  
xi: psmatch2 GO_DDR $X_Vars i.SURV_LOC_L2, outcome(DEMBE)  
xi: psmatch2 GO_DDR $X_Vars i.SURV_LOC_L2, outcome(ACCEPTED)   

xi: psmatch2 GO_DDR, outcome(DELINKED) mahal($X_Vars i.SURV_LOC_L2)
xi: psmatch2 GO_DDR, outcome(EMPLOY) mahal($X_Vars i.SURV_LOC_L2)
xi: psmatch2 GO_DDR, outcome(DEMBE) mahal($X_Vars i.SURV_LOC_L2)
xi: psmatch2 GO_DDR, outcome(ACCEPTED) mahal($X_Vars i.SURV_LOC_L2)


xi: psmatch2 COMP $X_Vars i.SURV_LOC_L2, outcome(DELINKED)  
xi: psmatch2 COMP $X_Vars i.SURV_LOC_L2, outcome(EMPLOY )  
xi: psmatch2 COMP $X_Vars i.SURV_LOC_L2, outcome(DEMBE)  
xi: psmatch2 COMP $X_Vars i.SURV_LOC_L2, outcome(ACCEPTED)   


xi: psmatch2 COMP, outcome(DELINKED) mahal($X_Vars i.SURV_LOC_L2)
xi: psmatch2 COMP, outcome(EMPLOY) mahal($X_Vars i.SURV_LOC_L2)
xi: psmatch2 COMP, outcome(DEMBE) mahal($X_Vars i.SURV_LOC_L2)
xi: psmatch2 COMP, outcome(ACCEPTED) mahal($X_Vars i.SURV_LOC_L2)


**************************************************************************************
**  APPENDIX: Summary Stats
**************************************************************************************

tabstat DISTRUST DISSATISFIED  age gender MENDE reason_abducted reason_support EDUCATE POOR OFFICER ABUSIVE DIST_WEALTH SUFFERING GO_DDR COMPLETE_DDR PER_DEMOB, stats(count mean sd min max) col(stats)

exit








**************************************************************************************
**************************************************************************************
**************************************************************************************
**************************************************************************************
**************************************************************************************




************************************************************************************
** EXTRA MATERIAL 1: FOOTNOTE: CHECK FOR BIVARIATE GROUP SPECIFIC EFFECTS
************************************************************************************

ttest DELINKED if RUF==1, by(GO_DDR)
ttest EMPLOY if RUF==1, by(GO_DDR)
ttest DEMBELIEF if RUF==1, by(GO_DDR)
ttest ACCEPTED if RUF==1, by(GO_DDR)

ttest DELINKED if RUF==1, by(COMPLETE_DDR)
ttest EMPLOY if RUF==1, by(COMPLETE_DDR)
ttest DEMBELIEF if RUF==1, by(COMPLETE_DDR)
ttest ACCEPTED if RUF==1, by(COMPLETE_DDR)

xi: dprobit EMPLOY i.RUF*GO_DDR $X_Vars , cluster (SURV_LOC_L3)
test  GO_DDR +  _IRUFXGO_DD_1=0

xi: dprobit DEMBELIEF i.RUF*GO_DDR $X_Vars , cluster (SURV_LOC_L3)
test  GO_DDR +  _IRUFXGO_DD_1=0


************************************************************************************
** EXTRA MATERIAL 2:  FOOTNOTE: CHECK FOR EFFECTS OF INTERMEDIATE STAGES OF TREATMENT 
************************************************************************************
gen TREAT = 0
replace TREAT =1 if DDR_Education==1 | COMPLETE_DDR==1

xi: dprobit DELINKED GO_DDR $X_Vars , cluster (SURV_LOC_L3)
xi: dprobit EMPLOY GO_DDR $X_Vars , cluster (SURV_LOC_L3)
xi: dprobit DEMBELIEF GO_DDR $X_Vars , cluster (SURV_LOC_L3)
xi: dprobit ACCEPTED GO_DDR $X_Vars , cluster (SURV_LOC_L3)

xi: dprobit DELINKED TREAT $X_Vars , cluster (SURV_LOC_L3)
xi: dprobit EMPLOY TREAT $X_Vars , cluster (SURV_LOC_L3)
xi: dprobit DEMBELIEF TREAT $X_Vars , cluster (SURV_LOC_L3)
xi: dprobit ACCEPTED TREAT $X_Vars , cluster (SURV_LOC_L3)

gen TREAT2=0
replace TREAT2=1 if GO_DDR==1 & DDR_Education==2 
replace TREAT2=2 if GO_DDR==1 & DDR_Education==1 & COMPLETE_DDR==0
replace TREAT2=3 if GO_DDR==1 & DDR_Education==1 & COMPLETE_DDR==1
replace TREAT2 = . if surveyid==.

xi: dprobit DELINKED i.TREAT2 $X_Vars , cluster (SURV_LOC_L3)
xi: dprobit EMPLOY i.TREAT2 $X_Vars , cluster (SURV_LOC_L3)
xi: dprobit DEMBELIEF i.TREAT2 $X_Vars , cluster (SURV_LOC_L3)
xi: dprobit ACCEPTED i.TREAT2 $X_Vars , cluster (SURV_LOC_L3)

tabstat DELINKED, by (TREAT2)
tabstat EMPLOY, by (TREAT2)
tabstat DEMBELIEF, by (TREAT2)
tabstat ACCEPTED, by (TREAT2)



************************************************************************************
****** EXTRA MATERIAL 3:  NOT REPORTED: SPILLOVER (ON COMPLETED VAR)
************************************************************************************
/*
xi: dprobit DELINKED COMPLETE_DDR  PER_DEMOB   $X_Vars , cluster (SURV_LOC_L3)
outreg using T10, 3aster bracket bdec(3) addstat(Pseudo R2, e(r2_p)) replace

xi: dprobit EMPLOY COMPLETE_DDR PER_DEMOB    $X_Vars , cluster (SURV_LOC_L3)
outreg using T10, 3aster bracket bdec(3)  addstat(Pseudo R2, e(r2_p)) append

xi: dprobit DEMBELIEF COMPLETE_DDR PER_DEMOB   $X_Vars , cluster (SURV_LOC_L3)
outreg using T10, 3aster bracket bdec(3) addstat(Pseudo R2, e(r2_p)) append

xi: dprobit ACCEPTED COMPLETE_DDR PER_DEMOB   $X_Vars , cluster (SURV_LOC_L3)
outreg using T10, 3aster bracket bdec(3) addstat(Pseudo R2, e(r2_p)) append

xi: dprobit DELINKED i.COMPLETE_DDR*PER_DEMOB   $X_Vars , cluster (SURV_LOC_L3)
outreg using T10, 3aster bracket bdec(3) addstat(Pseudo R2, e(r2_p)) append

xi: dprobit EMPLOY i.COMPLETE_DDR*PER_DEMOB    $X_Vars , cluster (SURV_LOC_L3)
outreg using T10, 3aster bracket bdec(3)  addstat(Pseudo R2, e(r2_p)) append

xi: dprobit DEMBELIEF i.COMPLETE_DDR*PER_DEMOB   $X_Vars , cluster (SURV_LOC_L3)
outreg using T10, 3aster bracket bdec(3) addstat(Pseudo R2, e(r2_p)) append

xi: dprobit ACCEPTED i.COMPLETE_DDR*PER_DEMOB   $X_Vars , cluster (SURV_LOC_L3)
outreg using T10, 3aster bracket bdec(3) addstat(Pseudo R2, e(r2_p)) append
*/




************************************************************************************
** EXTRA MATERIAL 4: NOT REPORTED: INTERVENTIONS  ENTERED JOINTLY *** 
************************************************************************************
/* 
xi: dprobit ACCEPTED 	 GO_DDR COMPLETE_DDR  i.DISTRUST DISTRUST i.DISSATISFIED DISSATISFIED $X_Vars , cluster (SURV_LOC_L3)
outreg using T3, 3aster bracket bdec(3) addstat(Pseudo R2, e(r2_p)) replace

xi: dprobit ACCEPTED 	 GO_DDR i.DISTRUST*COMPLETE_DDR  $X_Vars , cluster (SURV_LOC_L3)
outreg using T3, 3aster bracket bdec(3) addstat(Pseudo R2, e(r2_p)) append

xi: dprobit ACCEPTED 	 GO_DDR i.DISSATISFIED*COMPLETE_DDR  $X_Vars , cluster (SURV_LOC_L3)
outreg using T3, 3aster bracket bdec(3) addstat(Pseudo R2, e(r2_p)) append

xi: dprobit EMPLOY GO_DDR COMPLETE_DDR $X_Vars , cluster (SURV_LOC_L3)
outreg using T3, 3aster bracket bdec(3)  addstat(Pseudo R2, e(r2_p)) append

xi: dprobit EMPLOY GO_DDR i.DISTRUST*COMPLETE_DDR   $X_Vars , cluster (SURV_LOC_L3)
outreg using T3, 3aster bracket bdec(3)  addstat(Pseudo R2, e(r2_p)) append

xi: dprobit EMPLOY GO_DDR i.DISSATISFIED*COMPLETE_DDR   $X_Vars , cluster (SURV_LOC_L3)
outreg using T3, 3aster bracket bdec(3)  addstat(Pseudo R2, e(r2_p)) append

xi: dprobit DELINKED GO_DDR COMPLETE_DDR $X_Vars , cluster (SURV_LOC_L3)
outreg using T3, 3aster bracket bdec(3) addstat(Pseudo R2, e(r2_p)) append

xi: dprobit DELINKED GO_DDR i.DISTRUST*COMPLETE_DDR   $X_Vars , cluster (SURV_LOC_L3)
outreg using T3, 3aster bracket bdec(3) addstat(Pseudo R2, e(r2_p)) append

xi: dprobit DELINKED GO_DDR i.DISSATISFIED*COMPLETE_DDR   $X_Vars , cluster (SURV_LOC_L3)
outreg using T3, 3aster bracket bdec(3) addstat(Pseudo R2, e(r2_p)) append

xi: dprobit DEMBELIEF GO_DDR COMPLETE_DDR $X_Vars , cluster (SURV_LOC_L3)
outreg using T3, 3aster bracket bdec(3) addstat(Pseudo R2, e(r2_p)) append

xi: dprobit DEMBELIEF GO_DDR i.DISTRUST*COMPLETE_DDR   $X_Vars , cluster (SURV_LOC_L3)
outreg using T3, 3aster bracket bdec(3) addstat(Pseudo R2, e(r2_p)) append

xi: dprobit DEMBELIEF GO_DDR i.DISSATISFIED*COMPLETE_DDR   $X_Vars , cluster (SURV_LOC_L3)
outreg using T3, 3aster bracket bdec(3) addstat(Pseudo R2, e(r2_p)) append

*/




************************************************************************************
** EXTRA MATERIAL 5: PROPENSITY WITH COMMON SUPPORT LIMITATION 
************************************************************************************



* xi: psmatch2 GO_DDR $X_Vars i.SURV_LOC_L2, outcome(DELINKED) common 
* xi: psmatch2 GO_DDR $X_Vars i.SURV_LOC_L2, outcome(EMPLOY ) common 
* xi: psmatch2 GO_DDR $X_Vars i.SURV_LOC_L2, outcome(DEMBE) common 
* xi: psmatch2 GO_DDR $X_Vars i.SURV_LOC_L2, outcome(ACCEPTED) common  


* xi: psmatch2 COMP $X_Vars i.SURV_LOC_L2, outcome(DELINKED) common 
* xi: psmatch2 COMP $X_Vars i.SURV_LOC_L2, outcome(EMPLOY ) common 
* xi: psmatch2 COMP $X_Vars i.SURV_LOC_L2, outcome(DEMBE) common 
* xi: psmatch2 COMP $X_Vars i.SURV_LOC_L2, outcome(ACCEPTED) common  


* MAHAL
* xi: psmatch2 GO_DDR, outcome(ACCEPTED) mahal($X_Vars i.SURV_LOC_L2)

* WITH COMMON SUPPORT ; NO REPLACEMENT; NEAREST NEIGHBOR
* xi: psmatch2 GO_DDR $X_Vars i.SURV_LOC_L2 , outcome(ACCEPTED) neighbor(1) common noreplace

* KERNEL MATCHING
*  psmatch2 GO_DDR PER_DEMOB , outcome(ACCEPTED) kernel kerneltype(epan) 

exit

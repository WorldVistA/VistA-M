DVBCAOCK ;ALB/GTS-557/THM-AGENT ORANGE/RESIDUALS OF DIOXIN ; 5/21/91  9:56 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs",HD9="Full Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 1710 Worksheet" S HD7="RESIDUALS OF DIOXIN EXPOSURE (AGENT ORANGE)",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",HD7
 W !!!!,"Narrative:  "
 S LNS="__________",LX="TXT" F I=1:1 S LY=$T(@LX+I) Q:LY["$END"  W ?13,$P(LY,";;",2),!
 W !!,"A.  Initial data base for possible exposure to toxic chemicals:",!!,"Branch of service: ",LNS,?33,"Service serial number: ",LNS,!!
 S X="month/year",Y="from __________ to __________" W "Dates of service:",!?26,X,?40,X,!!,"Last period: ",?21,Y,!!?26,X,?40,X,!!,"Next to last period: ",Y,!!
 W "Date of birth: __________",!!,"Marital status: ___ married ___ divorced ___ separated",!!!
 W "Did veteran have military service in Vietnam? ___ Yes  ___ No",!!,"If yes, list all tours of duty in Vietnam:",!!?7,X,?35,X,!,"From:",?30,"To:",! D HD2
 W "Indicate the Corps or area where veteran served in Vietnam:",!!,"I Corps ___ II Corps ___ III Corps ___ IV Corps ___ Sea duty ___",!!,"More than one ___ Don't know ___ Other (specify)",LNS,!!
 W "List military units in which veteran served (specify complete",!,"unabbreviated titles such as company, battalion, etc.):",!!!!!
 W "B.  Veteran's exposure to Agent Orange (indicate one category for",!?5,"each circumstance):",!!?36,"Definitely  Probably  Not    Definitely",!?39,"yes",?50,"yes",?58,"sure",?69,"no",!!
 W ?3,"1. Veteran was involved in",!?3,"handling or spraying A.O.",!!?3,"2. Veteran was not directly",!?3,"sprayed but was in a recently",!?3,"sprayed area.",!!
 W ?3,"3. Veteran was exposed to",!?3,"herbicides other than A.O.",!!?3,"4. Veteran was directly",!?3,"sprayed with Agent Orange.",!!?3,"5. Veteran ate food or drink",!?3,"that could have been contaminated.",!!!
 W !!,"C.  Indicate how many exposures the veteran alleges:",!!!,"D.  Indicate the nature of each exposure:",! D HD2
 W "E.  Medical history (include symptoms at time of exposure or",!?4,"later attributed by veteran to exposure):",!!!!!!!,"F.  Subjective complaints:",!!!!!!!,"G.  Objective findings:",!!
 W ?2,"a. Height _____ weight _____ pulse _____ blood pressure _______",!! G ^DVBCAOC1
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for ",HD7,!,"for ",NAME,!!!
 Q
 ;
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
 ;
TXT ;
 ;;Chloracne or other acneform disease consistant with
 ;;chloracne, non-Hodgkins lymphoma, and soft-tissue
 ;;sarcomas are presumtive Agent Orange-related
 ;;disabilities.  Veterans who served in Vietnam and
 ;;in the waters offshore are presumed to have been
 ;;exposed to Agent Orange and/or other herbicides
 ;;which may contain dioxin.  Attention should be paid
 ;;to examination of the skin, nervous system, muscular
 ;;function, liver, kidneys, lymphatic system and mental
 ;;status.  Questioning should attempt to uncover details
 ;;of exposure and any adverse affects.
 ;;$END

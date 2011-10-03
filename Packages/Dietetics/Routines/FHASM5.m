FHASM5 ; HISC/REL - Energy/Calorie Factors ;3/20/95  08:18
 ;;5.5;DIETETICS;**8**;Jan 28, 2005;Build 28
 I AGE<19 G PED
 S CB="Energy" D GETW G HARRIS:CB=3,KIL^FHASM1:CB=0 W !!,"Calculate Energy Needs by:  "
 W !!?6,"1  Harris-Benedict",!?6,"2  Kcal/Kg",!?6,"3  Mifflin-St Jeor"
 W !,?6,"4  Enter Manually"
E2 W !!,"Choose:  " W:CENB CENB_"// " R CM:DTIME S:CM=U FHQUIT=1 G:'$T!(CM["^") KIL^FHASM1
 I CM="",CENB S CM=CENB
 I "1234"'[CM!(CM'?1N) W !,*7,"Choose Either 1, 2, 3 or 4" G E2
 S CENB=CM
 S:CM=1 FHCM="Harris-Benedict"
 S:CM=2 FHCM="Kcal/Kg"
 S:CM=3 FHCM="Mifflin-St Jeor"
 S:CM=4 FHCM="Enter Manually"
 G HARRIS:CM=1,KCAL:CM=2,MIF:CM=3,MAN
MAN ; Manual Entry
M1 W !!,"Enter Energy Requirements (Kcal/day):  " W:KCAL'="" KCAL_"// " R X:DTIME G:'$T!(X["^") KIL^FHASM1
 I (X'=""),(KCAL'=X) S KCAL=X
 S KCAL=+$J(KCAL,0,0) I KCAL'>0 W *7,!,"KCAL must be greater than 0" G M1
 G P5
MIF ;Mifflin - St. Jeor entry; adding this new calculation for cal needs.
 I SEX="M" S KCAL=10*(W2)+(6.25*(2.5*HGT))-(5*AGE)+5
 I SEX="F" S KCAL=10*(W2)+(6.25*(2.5*HGT))-(5*AGE)-161
 S KCAL=$J(KCAL,0,0)
 G P5
SUR ;add for s/p bariatic surgery
 ;S KCAL=20*W2
 ;S KCAL=KCAL+20,KCAL=$J(KCAL,0,0)
 ;G P5
PED ; Pediatric
 S FHCM=" Pediatric"
 I AGE<11 S KCAL=$S(AGE<.6:115,AGE<1:105,AGE<4:100,AGE<7:85,1:86) G P1
 I SEX="M" S KCAL=$S(AGE<15:60,1:42) G P1
 S KCAL=$S(AGE<15:48,1:38)
P1 S KCAL=+$J(KCAL*WGT/2.2,0,0) G P5
HARRIS ; Harris Method
 I SEX="F" S KCAL=(655.10+(9.56*W2)+(1.85*HGT*2.54)-(4.68*AGE))
 I SEX="M" S KCAL=(66.47+(13.75*W2)+(5.0*HGT*2.54)-(6.67*AGE))
 S KCAL=$J(KCAL,0,0)
H1 W !!,"Is patient confined to bed (Y/N): " W:FHYN'="" FHYN_"//" W:FHYN="" "N //" R AF:DTIME
 I '$T!(AF["^") S FHQUIT=1 G KIL^FHASM1
 I AF="",FHYN'="" S AF=FHYN
 I AF="",FHYN="" S AF="N"
 S X=AF D TR^FHASM1 S AF=X
 I $P("YES",AF,1)'="",$P("NO",AF,1)'="" W *7,!,"  Answer YES or NO" G H1
 S FHYN=AF
 S AF=$S(AF?1"Y".E:1.2,1:1.3) W "  (Activity Factor = ",AF,")"
 W !!?27,"Injury/Stress Factors",!
 W !,"Surgery",?25,"1.1 - 1.3",?40,"Skeletal Trauma",?65,"1.35",!,"Major Sepsis",?25,"1.6",?40,"Severe Burn",?65,"2.1"
 W !,"Blunt Trauma",?25,"1.35",?40,"Trauma w/ Steroid",?65,"1.68",!,"Starvation",?25,".7",?40,"Trauma on Ventilator",?65,"1.6"
 W !,"Mild Infection",?25,"1.2",?40,"0-20% BSA Burn",?65,"1.25",!,"Moderate Infection",?25,"1.4",?40,"20-40% BSA Burn",?65,"1.5"
 W !,"Long Bone Fracture",?25,"1.6",?40,">40% BSA Burn",?65,"1.85",!,"Peritonitis",?25,"1.15"
 W !,"Stress - Low",?25,"1.3",?40,"Anabolism",?65,"1.5-1.75"
 W !,"       - Moderate",?25,"1.5",?40,"Cancer",?65,"1.6"
 W !,"       - Severe",?25,"2.0"
 W !!,"BEE = ",KCAL," Kcal/day"
H2 W !!,"Select Energy Factor:  " W:SEF SEF_"// " R EF:DTIME S:EF=U FHQUIT=1 G:'$T!(EF["^") KIL^FHASM1
 I EF="",SEF S EF=SEF
 I EF<.7!(EF>2.5) W !,*7,"Energy Factor must be Between .7 and 2.5" G H2
 S:EF<1 EF=0_EF
 S SEF=EF
 S FHEF="Energy Factor of "_EF
 S KCAL=+$J(KCAL*AF*EF,0,0) G P5
KCAL ; KCAL Method
 W !!?35,"Caloric Factors"
 W !!,"Basal Energy",?30,"25",!,"Ambulatory w/ Weight Maint.",?30,"30"
 W !,"Malnutrition w/ Mild Sepsis",?30,"40",!,"Injuries/ Sepsis - Severe",?30,"50"
 W !,"Burn - Extensive",?30,"80",!,"Non-Dialysis Renal Failure",?30,"35"
 W !,"Dialysis",?30,"40",!,"Dialysis w/ Diabetes",?30,"30",!,"Anabolism",?30,"35-45"
 W !,"Conservative Mgnt Pre-Dialysis:"
 W !,"    (<60 years old)",?30,"35"
 W !,"    (>60 years old)",?30,"30-35"
 S FHECAL=""
P4 W !!,"Enter Kcal/Kg (10-100): " W:EKKG'="" EKKG_"// " R FHECAL:DTIME I '$T!(FHECAL["^") S FHQUIT=1 G KIL^FHASM1
 I FHECAL="",EKKG'="" S FHECAL=EKKG
 I FHECAL'?1.3N!(FHECAL<10)!(FHECAL>100) W !,*7,"Kcal/Kg Must be Between 10 and 100" G P4
 I FHECAL'="" S (EKKG,KCAL)=FHECAL
 S FHKCAL="Caloric Factor of "_KCAL
 S KCAL=+$J(KCAL*W2,0,0)
P5 ;
 S FHFEC=""
 S:FHEF'="" FHFEC=FHFEC_FHEF_", "
 S:FHCM'="" FHFEC=FHFEC_FHCM_", "
 S:FHKCAL'="" FHFEC=FHFEC_FHKCAL
 S:FHCFRBO'="" FHFEC=FHFEC_" and "_FHCFRBO
 W !!,"Enter Caloric Requirements (Kcal/day): ",KCAL,"// " R X:DTIME I '$T!(X["^") G KIL^FHASM1
 I X="",KCAL S X=KCAL
 I X'="",X'?.N.1".".N!(X<1)!(X>10000) W *7,!?5,"Enter a value between 1-10000" G P5
 I X'="",X'=KCAL S KCAL=+$J(X,0,0) S FHFEC="User sets the Calorie data"
NEXT G ^FHASM6
GETW W !!,"Calculate ",CB," Requirements Based On:" S CM="12"
 W !!?2,"1  Actual Body Weight",!?2,"2  Target Body Weight"
 I WGT/IBW'<1.2 W !?2,"3  Obese Calculation" S CM="123"
E1 W !!,"Choose:  " W:CFRBO CFRBO_"// " R CB:DTIME I '$T!(CB["^") S CB=0,FHQUIT=1 Q
 I CB="",CFRBO S CB=CFRBO
 I CM'[CB!(CB'?1N) W !,*7,"Choose either 1 or 2" W:CM["3" " or 3" G E1
 S CFRBO=CB
 S W2=$S(CB=2:IBW,CB=3:WGT-IBW*.25+IBW,1:WGT)/2.2 S:CB=3 CM=1
 S FHCFRBO=$S(CB=1:"Actual Body Wt",CB=2:"Target Body Wt",CB=3:"Obese Calculation",1:"")
 Q

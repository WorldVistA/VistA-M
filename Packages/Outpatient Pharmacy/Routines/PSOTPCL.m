PSOTPCL ;BIRM/PDW-EDIT TPC INSTITUTION LETTERS
 ;;7.0;OUTPATIENT PHARMACY;**145,227**;DEC 1997
 Q
EDIT ; Manual edit of institution letter information in 52.92
 Q  ;placed out of order by patch PSO*7*227
 W @IOF
 W !,"                             Transitional Pharmacy Care"
 W !,"                       Edit Institution  Letter  Information"
EDIT2 W !!,"(You may add a NEW Institution at this point.)",!
 D PSTINT
 K DIC,DA
 S DIC=52.92,DIC(0)="AEQML",DIC("W")="W ?40,$$GET1^DIQ(52.92,+Y,.02) W:$$CHKINST^PSOTPCL(+Y) ?69,"" Incomp""",DIC("A")="Select/Add TPB INSTITUTION: ",DLAYGO=52.92
 D ^DIC K DLAYGO
 G:Y'>0 EXIT
 S DA=+Y,DR="[INSTITUTION EDIT]",DDSFILE=52.92
 D ^DDS
 G EDIT2
 ;
EXIT K DIC,DIE,DR,DDSFILE
 W @IOF
 Q
PSTINT ;Take institution entries from 52.91 & stuff into 52.92
 S LOCDA=0 F  S LOCDA=$O(^PS(52.91,"AC",LOCDA)) Q:LOCDA'>0  D LOCDA
 Q
LOCDA ;Get physical and mailing address
 I $D(^PS(52.92,LOCDA,0)) Q
 N FAC,FDA
 ; set FAC(FLD#)=(INTvalue of FLD#); ex:  FAC(.01)=500 :"Birmingham VAMC"
 ;
 F XX=.01,.02,1.01,1.02,1.03,1.04 S FAC(XX)=$$GET1^DIQ(4,LOCDA,XX,"I")
 F XX=4.01,4.02,4.03,4.04,4.05 S FAC(XX)=$$GET1^DIQ(4,LOCDA,XX,"I")
 ;
 ; build/map fields from iNSTITUTION file to TPB INSTITUTION LETTER
 ; file into FDA
 ; "XFDL^YFLD," stuff XFLD of file 52.92 with YFLD of file 4
 ;
 F XX=".01^.01",".05^1.01",".06^1.02",".07^1.03",".08^1.04",".09^.02","1.01^4.01","1.02^4.02","1.03^4.03","1.04^4.04","1.05^4.05" D
 . S XFLD=+XX,YFLD=$P(XX,U,2)
 . S FDA(52.92,"+1,",XFLD)=FAC(YFLD)
 S FDA(52.92,"+1,",.01)=LOCDA,LOCDA(1)=LOCDA
 D UPDATE^DIE("","FDA","LOCDA","MSG")
 Q
SEL ;Select divisions
 ; returns arrays
 ; for testing
 W !!,"SELECTION OF INSTITUTION(S)",!
 K DIVNM,DIVDA,DIVX
 S DIVDA=0 F I=1:1 S DIVDA=$O(^PS(52.92,"B",DIVDA)) Q:DIVDA'>0  D
 . Q:$$CHKINST(DIVDA)  ; only completed institutions
 . S DIV=$$GET1^DIQ(52.92,DIVDA,.01)  S INST(DIVDA)=DIV
 K DIR S DIR(0)="S^A:ALL INSTITUTIONS;S:SELECT INSTITUTIONS"
 D ^DIR K DIR
 G:Y="A" ALL
 G:Y="S" SELECT
 K INST
 Q
SELECT ; select range of divisioins
 K INST,DIC
 S DIC="^PS(52.92,",DIC(0)="AEQM"
 F  S DIC("W")="W ?40,$E($$GET1^DIQ(52.92,+Y,.02),1,18) I $$CHKINST^PSOTPCL(+Y) W ?60,""Incomplete""" D ^DIC Q:Y'>0  D
 . I $$CHKINST(+Y) W !,"Sorry, data for that institution is incomplete",! Q
 . S INST(+Y)=$$GET1^DIQ(52.92,+Y,.01)
ALL K PSOSTOP
 I '$D(INST) S INST="" W !,"None Selected - Quitting",! H 3 Q
 W !!,"You have selected:",! S DIV=0 F II=1:1 D:'(II#18) PG Q:$G(PSOSTOP)  S DIV=$O(INST(DIV)) Q:'DIV  W !,?5,INST(DIV)
 S DIR(0)="Y",DIR("A")="Is this correct ",DIR("B")="YES" D ^DIR
 K DIR
 Q:Y
 G SEL
 ;
PG K DIR S DIR(0)="E",DIR("A")="CR - CONTINUE  ^ - Quit" D ^DIR
 S:X["^" PSOSTOP=1
 Q
INSTCHK() ; check required fields of INST in the array INST(INSTDA)
 N FAC S FAC=0
 S INSTDA=0 F  S INSTDA=$O(INST(INSTDA)) Q:INSTDA'>0  S XX=$$CHKINST(INSTDA) I $L(XX) W !,"Sorry, required field(s) are missing from ",INST(INSTDA) S FAC=1
 I $G(FAC) D
 . W !,"= = = = ="
 . W !!,"The above institution(s) will need to have their letter information edited",!,"before the letters for that facility can be printed",!
 . K DIR S DIR(0)="EO" D ^DIR K DIR
 . I X["^" S PSOSTOP=1
 Q FAC
 ;
CHKINST(INSTDA) ; check institution in 52.92 for required edited fields
 N XX,FAC,PAR S FAC=""
 ; see if parent, parent checks OK
 S PAR=$$GET1^DIQ(52.92,INSTDA,.02,"I") I PAR S XX=$$CHKINST(PAR) Q XX
 F YY=.05,.07,.08,2.01 S XX=$$GET1^DIQ(52.92,INSTDA,YY) I $L(XX)=0 S FAC=FAC_YY_","
 Q FAC
PTCHK() ; Check file 52.91 for INST fields and 52.92 for INSTUTITONs present
 N INST,CHK,INSTDA S INSTDA=0,CHK=0
 F  S INSTDA=$O(^PS(52.91,"AC",INSTDA)) Q:INSTDA'>0  D
 . I $D(^PS(52.92,INSTDA)) Q
 . S CHK=1
 . W !!,$$GET1^DIQ(4,INSTDA,.01),!," is missing from the TRANSITIONAL RX INSTITUTION LETTERS file #52.92",!,"and is being added."
 . S LOCDA=INSTDA N INST,FAC D LOCDA ; add INSTDA to # 52.92
 I CHK D
 . W !,"= = = = ="
 . W !!,"The above institution(s) will need to have their letter information edited",!,"before the letters for that facility can be printed",!
 . K DIR S DIR(0)="EO",DIR("A")="<cr> - Continue" D ^DIR K DIR
 Q CHK

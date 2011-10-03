MCARAP ;WASH ISC/SAE-MEDICINE AUTO INSTRUMENT INTERFACE SUMMARY PRINT ;5/7/96  09:40
 ;;2.3;Medicine;**16**;09/13/1996
 ;
 D NOW^%DTC S Y=% D DD^%DT S MCDAY=$E(Y,1,12),MCTIME=$E(Y,13,18)
 K GOOD,BAD,J,DIC,ENTRY,DATE1,DATE2,PDATE,IJ,ZIP,REDO,NAME,ALL
 W @IOF,?17,"MEDICINE AUTO INSTRUMENT SUMMARY OF RECORDS TRANSFER"
 W !!!!,?5,"S",?10,"SUCCESSFUL RECORD TRANSFERS"
 W !!,?5,"U",?10,"UNSUCCESSFUL RECORD TRANSFERRAL ATTEMPTS"
 W !!,?5,"A",?10,"ALL RECORD TRANSFERRAL ATTEMPTS"
ASK R !!!,"Enter selection(S,U,A), '?' for help, or return to escape: ",RPT:DTIME
 G EXIT1^MCARAP1:'$T,EXIT1^MCARAP1:RPT="" K GOOD,BAD,ALL
 I RPT="S" S GOOD=1 K BAD G NAME
 I RPT="U" S BAD=1 K GOOD G NAME
 I RPT="A" S ALL=1 K GOOD,BAD G NAME
 I RPT="?" D QMARK^MCARAP2
 I RPT="?" D PROMPT G EXIT1^MCARAP1:'$T,EXIT1^MCARAP1:ZIP=U D QMARK2^MCARAP2,PROMPT G EXIT1^MCARAP1:'$T,EXIT1^MCARAP1:ZIP=U,MCARAP
 I RPT=U!(RPT="") G EXIT1^MCARAP1
 G MCARAP
PROMPT R !!,"Press return to continue, or '^' to escape: ",ZIP:DTIME Q
UPDATE ; Kill all nodes for entries more than 1 month old
 D NOW^%DTC S X1=%
 W @IOF,!,?14,"MEDICINE AUTO INSTRUMENT SUMMARY OF RECORDS TRANSFER"
 W !!!,?14,"Enter the number of days of reports you wish to retain"
 W !,?14,"(30 day minimum), or return to escape: ",*7 R PERIOD:DTIME G:'$T!(PERIOD=U)!(PERIOD="") EXIT1^MCARAP1 G:PERIOD<30 UPDATE
 S X2=-PERIOD D C^%DTC S EXDAY=X ; B
 S PDATE=0 F IJ=1:1 S PDATE=$O(^MCAR(700.5,"C",PDATE)) Q:PDATE=""  Q:PDATE>EXDAY  D STYPE^MCARAP1 I $D(TYPE) K TYPE S ENT="",ENTRY(IJ)=$O(^MCAR(700.5,"C",PDATE,ENT))
 F IJ=1:1 Q:'$D(ENTRY(IJ))  S DIK="^MCAR(700.5,",DA=ENTRY(IJ) D ^DIK
 K MCARA,EXDAY,IJ,DIK,ENT,ENTRY,PDATE,PERIOD Q
NAME R !!,"Enter Patient Name (if single Patient search), or '^' to escape: ",NAME:DTIME
 I '$T K NAME G EXIT^MCARAP1
 I NAME=U K NAME G EXIT1^MCARAP1
 I NAME="?" W !,"Enter name (examples: SM/SMITH/SMITH,BILL/SMITH,BILL M)",!,"...or press return to search all Patients)" G NAME
 I NAME?1." ".E W !,"Leading spaces not acceptable",*7 G NAME
 I '$D(NAME)!(NAME="") K NAME G DATE1
 S:NAME[", " NAME=$P(NAME,",")_","_$P(NAME,", ",2) S:NAME["  " NAME=$P(NAME,"  ")_" "_$P(NAME,"  ",2)
 S NAMEE=$E(NAME,1,($L(NAME)-1))_$C($A($E(NAME,$L(NAME)))-1)_"ZZZ"
 K ^TMP($J,"MCARA")
 F J=1:1 S NAMEE=$O(^MCAR(700.5,"PT",NAMEE)) Q:NAMEE=""  Q:NAME'=$E(NAMEE,1,$L(NAME))  S RN=$O(^(NAMEE,0)),^TMP($J,"MCARA",J)=NAMEE_U_$P(^MCAR(700.5,RN,0),U,3)
 G:'$D(^TMP($J,"MCARA")) NAME2
 W ! F J=1:1 Q:'$D(^TMP($J,"MCARA",J))  W !,?5,J,?10,$P(^(J),U),?40,$P(^(J),U,2)
NAME1 R !!,"Enter Number: ",ZIP:DTIME G EXIT1^MCARAP1:'$T,EXIT1^MCARAP1:ZIP=U
 I ZIP="" W !!,"No Individual Patient selected",*7 K NAME G NAME
 I ZIP="?" W !,"Enter Number to select Patient, press return to continue, or enter ^ to exit" G NAME1
 I '$D(^TMP($J,"MCARA",ZIP)) W !,"No Individual Patient selected",*7 G NAME1
 S NAME=$P(^TMP($J,"MCARA",ZIP),U)
 G DATE1
NAME2 W !,"No Entries found in Summary File",*7 G NAME
DATE1 ; Enter starting date of range of dates for report
 W !! K DTOUT S %DT="AEXPT",%DT("A")="Enter Starting Date: ",%DT("B")="TODAY",%DT(0)="-NOW"
 D ^%DT I X="" K %DT(0) Q
 G:$D(DTOUT) MCARAP G:X=U EXIT1^MCARAP1
 I Y=-1 W *7 R !!,"Invalid date, press return to continue, or ^ to exit: ",ZIP:DTIME G EXIT1^MCARAP1:'$T,EXIT1^MCARAP1:ZIP=U W ! G DATE1
 S DATE1=Y
DATE2 K DTOUT S %DT="AEXPT",%DT("A")="Enter Ending Date: ",%DT("B")="TODAY",%DT(0)="-NOW"
 D ^%DT I X="" K %DT(0) Q
 G:$D(DTOUT) MCARAP G:X=U EXIT1^MCARAP1
 I Y=-1 W *7 R !!,"Invalid date, press return to continue, or ^ to exit: ",ZIP:DTIME G EXIT1^MCARAP1:'$T,EXIT1^MCARAP1:ZIP=U W ! G DATE2
 S DATE2=Y I DATE2<DATE1 W *7 R !!,"Starting date must precede or equal ending date",!,"Press return to continue, or ^ to exit: ",ZIP:DTIME G EXIT1^MCARAP1:'$T,EXIT1^MCARAP1:ZIP=U W ! G DATE1
DEVICE ; Select Device
 K IO("Q") S %ZIS="Q" D ^%ZIS G EXIT1^MCARAP1:POP
QUE ; Perform queueing if selected
 I $D(IO("Q")) S ZTRTN="^MCARAP1",ZTSAVE("DATE*")="",ZTDESC="Medicine Auto Instrument Interface Summary Report" S:$D(GOOD) ZTSAVE("GOOD")="" S:$D(BAD) ZTSAVE("BAD")="" S:$D(NAME) ZTSAVE("NAME")="" S REDO=1
 I $D(IO("Q")) S:$D(MCARA) ZTSAVE("MCARA")=MCARA S:$D(ALL) ZTSAVE("ALL")="" D ^%ZTLOAD K ZTSK,IO("Q") G EXIT1^MCARAP1
 U IO
 G ^MCARAP1

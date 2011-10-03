SDWLRAD ;;IOFO BAY PINES/TEH - ADHOC WAIT LIST REPORT;06/12/2002 ; 20 Aug 2002  2:10 PM
 ;;5.3;scheduling;**263**;AUG 13 1993
 ;
 ;
 ;******************************************************************
 ;                             CHANGE LOG
 ;                                               
 ;   DATE                        PATCH                   DESCRIPTION
 ;   ----                        -----                   -----------
 ;   
 ;   
 ;   
 ;   
EN ;Header
 D HD
 S SDWLINST="",SDWLE=0 K ^TMP("SDWLRAD",$J),DIC,DIR,DR,DIE
 D INS
 D DATE G INS:E
 D CAT G DATE:E
 D PRI G CAT:E
 D OPEN G PRI:E
 D FORM G OPEN:E
 D DIS
 I E D QUE
 Q
INS ;Get Institution
 W !! S DIC(0)="QEMA",DIC("A")="Select Institution ALL // ",DIC=4,DIC("S")="I $D(^SDWL(409.32,""C"",+Y))" D ^DIC I Y<0,'SDWLE S Y="ALL"
 G INS:Y<0,END:$D(DUOUT)
 I Y="All"!(Y="")!(Y="all")!(Y="ALL") D
 .S SDWLINST="ALL",SDWLE=1 S ^TMP("SDWLRAD",$J,"INS","ALL")=""
 I 'SDWLE S SDWLERR=1,^TMP("SDWLRAD",$J,"INS",Y)="" G INS
 Q
DATE ;Date range selection
 S SDWLERR=0 W ! S %DT="AE",%DT("A")="Beginning Date: " D ^%DT G E1:Y<1 S SDWLBDT=Y
 S %DT(0)=SDWLBDT,%DT("A")="Ending Date: " D ^%DT G DATE:Y<1 S SDWLEDT=Y K %DT(0),%DT("A")
 I SDWLEDT<SDWLBDT W !,"Beginning Date must be greater than Ending Date." G DATE
 S ^TMP("SDWLRAD",$J,"DATE",SDWLBDT_"^"_SDWLEDT)="" Q
E1 S %=1 W !,"Print Report for ALL dates? " D YN^DICN S ^TMP("SDWLRAD",$J,"DATE","ALL")=""
 I %=2 S SDWLERR=1 Q
 I %=-1 G END
 Q
CAT ;Report category selection
 W !!,"    *** Report Category Selection ***" S SDWLERR=0
 S SDWLCAT=0,DIR(0)="S0^1:Clinic;2:Select Service/Specialty",DIR("L",1)="C. Clinic",DIR("L")="S. Service/Specialty"
 D ^DIR
 I X="^" S SDWLERR=1 Q
 I X="" S SDWLERR=1 Q
 I X'?1"C".E,X'?1"S".E W " Invalid Selection." G CAT
 W !!,"Select Category for Report Output",!
 S SDWLX=$S(X="C":"Clinic: ALL/ ",X="S":"Service/Specialty: ALL/ ")
 S SDWLF=$S(X="C":409.32,X="S":409.31)
CT1 W !! S DIC(0)="QEMA",DIC("A")=SDWLX,DIC=SDWLF D ^DIC I 'SDWLCAT,Y<1 S ^TMP("SDWLRAD",$J,"CAT","ALL")="" G CT2
 I SDWLCAT,Y<0 S SDWLERR=1 Q 
 I 'SDWLCAT,Y<0 S SDWLERR=1 Q
 S SDWLCAT=1
 S ^TMP("SDWLRAD",$J,"CAT",Y)="" G CT1
CT2 Q
PRI ;Priority
 K DIR,DIC S SDWLERR=0
 S DIR(0)="S0^1:F:Future;I:Immediate",DIR("L",2)="     F. Future",DIR("L")="     I. Immediate",DIR("L",1)="Select One of the Following: "
 D ^DIR
 I X="" S SDWLERR=1 Q
 I X="^" S SDWLERR=1 Q
 S ^TMP("SDWLRAD",$J,"PRI",X)=""
 Q
OPEN ;OPEN Wait List Entries  
 S %=1 W !!,"Do you want to 'OPEN' Wait List Entries " D YN^DICN
 I %=-1 S SDWLERR=1
 S ^TMP("SDWLRAD",$J,"OPEN",%)=""
 Q
FORM ;Report Format
 S SDWLERR=0,DIR(0)="SO^1:D:Detailed;S:Summary",DIR("L",2)="D. Detailed",DIR("L")="S. Summary",DIR("L",1)="Select One of the Following: "
 D ^DIR
 I X="",X="^" S SDWLERR=1
 S ^TMP("SDWLRAD",$J,"FORM",X)=""
 Q
DIS ;Display Parameters
 S SDWLERR=0 W !!,?80-$L("*** Selected Report Parameters ***")\2,"*** Selected Report Parameters",!
 F SDWLI="CAT","DATE","INS","FORM","OPEN","PRI" D
 .S X="SDWL"_SDWLI,@X=$O(^TMP("SDWLRAD",$J,SDWLI,""))
 I SDWLINS'="ALL" D
 .I 'E W !,"Institution: ALL INSTITUTIONS"
 W !,"Date Desired Range: " S Y=$P(SDWLDATE,U,1) D DD^%DT S SDWLBD=Y S Y=$P(SDWLDATE,U,2) D DD^%DT S SDWLED=Y W " ",SDWLBD," to ",SDWLED
 W !,"Report Category: ",$S(SDWLCAT="C":" Clinic",1:" Service/Specialty")
 W !,"Priority: ",$S(SDWLPRI="I":" Immediate",1:" Future")
 W !,"Output Format: ",$S(SDWLFORM="D":" Detailed",1:" Summary")
 I SDWLOPEN W !,"Printing 'OPEN' Entries Only."
 S %=1 W !!,"Are these Parameters Correct " D YN^DICN I %=2 S SDWLERR=1 W !,"  This Report will NOT be queued to print."
 I %-1 W !,"   This Report will NOT be queued and returning." S SDWLERR=2
QUE ;Queue Report
 Q
HD W:$D(IOF) @IOF W !,?80-$L("Appointment Wait List Report")\2,"Appointment Wait List Report"
 Q
END Q

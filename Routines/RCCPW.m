RCCPW ;WASH-ISC@ALTOONA,PA/TJK-CO-PAY WAIVER ;11/23/94  9:52 AM
V ;;4.5;Accounts Receivable;;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 N SITE,MO,YR,LINE,BEG,END,START,QUIT,DIR,DIRUT,LNNO,TEXT
ENTERDT I +$E(DT,6,7)>7 W !,*7,"This data can only be entered between the 1st and the 7th of the month."  H 3 Q
 S SITE=$$SITE^RCMSITE()
 S MO=$E(DT,4,5)-1,YR=$E(DT,2,3) S:$L(MO)'=2 MO="0"_MO
 I +MO=0 S MO=12,YR=YR-1 S:+YR=0 YR=100
 S YR=YR+200
 S DIR("A")="Enter Month/Year of Waiver Data"
 S DIR(0)="D^:"_(YR_MO_31)_":EP"
 S Y=YR_MO_"00" D DD^%DT S DIR("B")=Y
 D ^DIR Q:Y<0  K DIR
 I $E(Y,4,5)="00" W !,*7,"You must enter month and year" G ENTERDT
 S BEG=$E(Y,1,5)_"00",END=$E(Y,1,5)_32
 S START=9
READ F I=START:1:20 Q:$D(QUIT)  D ENTER(I)
 I $D(QUIT),QUIT S START=QUIT K QUIT G READ
 Q:$D(QUIT)
DISPLAY ;Display user input-allows editing of data
 W @IOF F I=9:1:20 D
    .W !,"LINE ",I,?10,$S(I#2:"SC",1:"NSC")_","_$$TEXT(I)
    .W ?40,"# OF BILLS: ",$J($P(LINE(I),U),6),"  ","Amount: ",$J($P(LINE(I),U,2),12,2)
    .Q
 K DIR S DIR(0)="Y",DIR("A")="Is Data Correct",DIR("B")="NO"
 D ^DIR G LOAD:Y Q:$D(DIRUT)
 K DIR S DIR(0)="NO^9:20:0",DIR("A")="Line Number to Edit" D ^DIR
 G DISPLAY:Y="",DISPLAY:$D(DIRUT) D ENTER(Y) G DISPLAY
LOAD ;CALLS TASKMAN TO DO BACKGROUND JOB
 K ^TMP("RCCPW",$J) F I=9:1:20 S ^TMP("RCCPW",$J,I)=LINE(I)
 S ZTRTN="^RCCPW1",ZTSAVE("BEG")="",ZTSAVE("END")="",ZTSAVE("SITE")=""
 S ZTSAVE("^TMP(""RCCPW"",$J,")="",ZTDTH=$H,ZTIO="" D ^%ZTLOAD
 K ^TMP("RCCPW",$J) W !,*7,"Report Queued"
 K ZTDTH,ZTIO,ZTRTN,ZTSAVE
 Q
ENTER(LNNO) ;Data entry done here--needs Line number
 W !!,"Data Entry for Line ",LNNO,!,$S(I#2:"SC",1:"NSC")," ",$$TEXT(LNNO)
 K DIR,X,Y S DIR(0)="N^0:999999:0",DIR("A")="Enter Total Number of Bills"
 I $P($G(LINE(LNNO)),U) S DIR("B")=$P(LINE(LNNO),U)
 D ^DIR,CHECK Q:$D(QUIT)
 S $P(LINE(LNNO),U)=Y
 K DIR,X,Y S DIR(0)="N^0:999999999.99:2",DIR("A")="Enter Total Amount"
 I $P($G(LINE(LNNO)),U,2) S DIR("B")=$P(LINE(LNNO),U,2)
 D ^DIR,CHECK Q:$D(QUIT)
 K DIR S $P(LINE(LNNO),U,2)=Y
 Q
CHECK ;
 K QUIT
 I X?1"^"1.2N S QUIT=$E(X,2,3) Q:QUIT'>LNNO  I QUIT>LNNO W !,*7,"No Forward Jumping Allowed" S QUIT=LNNO Q
 I $D(DIRUT) S QUIT="" Q
 Q
TEXT(I) ;Computes Line Text
 S TEXT=$S(I<11:"Initial Waiver Request",I<13:"Waiver Request Resolved",I<15:"Appeal Waiver",I<17:"Appeal Waiver Resolved",I<19:"Waiver Approved Refund",1:"Appeal Approved Refund")
 Q TEXT

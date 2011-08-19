PRCSAPP ;WISC/KMB-NEW 2237 APPROVAL ; 10-27-93 12:00
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
START ;
 N APPREQ,MESSAGE,YY,XY,SPENDCP,ALL,LOOP,FOUND,PRCS1,%,AA,TEST,II,CPARRAY
 N FND,CPVAR,STOP1,SLP,PRCSDA,PRCSI,CONT,LINE
 S (FND,STOP1,TEST,FOUND,ALL,PRC("CP"))=0,XY="",AA=0,SPENDCP=0
 K CPCK S APPREQ=1 W !!,"Please wait while I check your control points..." D ^PRCSUT1
 I '$D(CPCK) W !,"You have no transactions ready for approval." Q
SETUP ; set up array of all cps user has access to
 D STA^PRCSUT I '$D(PRC("SITE")) W !,$P($T(MESSAGE+1),";;",2) Q
 S MESSAGE="" D ESIG^PRCUESIG(DUZ,.MESSAGE) I MESSAGE<1 W !,$P($T(MESSAGE+2),";;",2) Q
 ;
 S (AA,PRC("CP"))=0 F  S PRC("CP")=$O(^PRC(420,"A",DUZ,PRC("SITE"),PRC("CP"))) Q:PRC("CP")=""  D
 .Q:$G(^PRC(420,PRC("SITE"),1,+PRC("CP"),0))=""
 .I $P($G(^(0)),"^",19)'=1,$D(^PRC(420,"A",DUZ,PRC("SITE"),PRC("CP"),1)),$D(CPCK(PRC("CP"))) S CPARRAY(AA)=PRC("CP"),AA=AA+1
 D INQUIRE W !!,"***END OF PROCESSING***" D LINE K CPCK Q
INQUIRE ;
 S %=1 W !,"Loop thru all control points" D YN^DICN Q:%=-1  S:%=1 ALL=1 I %=0 W !,$P($T(MESSAGE+3),";;",2),! H 1 G INQUIRE
INQUIRE1 ;
 I %=2 W @IOF D LINE R !,"Select CONTROL POINT: ",XY:DTIME Q:XY["^"!(XY="")  I XY'?1.N D SHOW G INQUIRE1
 F II=0:1:AA-1 S FOUND=0 Q:STOP1=-1  I $D(CPARRAY(II)) I (+XY=CPARRAY(II)!ALL=1) D PROCESS Q:STOP1=-1!(ALL=0)
 I FOUND=0 S %=2 W !,$P($T(MESSAGE+4),";;",2),! D LINE H 2 G INQUIRE1
 Q
PROCESS ;
 S FOUND=1,PRC("CP")=CPARRAY(II),CONT=0
 W @IOF D LINE
 S %=1 W !!,"Loop thru all transactions for CP ",CPARRAY(II) D YN^DICN S:%=-1 STOP1=-1 Q:%=-1  I %=0 W !,$P($T(MESSAGE+5),";;",2),! H 1 G PROCESS
 I %=1 G PROCESS2
PROCESS1 ;
 Q:CONT=1  D LOOKUP Q:(CONT=1)  S:$D(Y) YY=+Y D CHECK G PROCESS1
PROCESS2 ;
 ; start here if all transactions selected
 S CPVAR=PRC("SITE")_"-"_PRC("CP"),SLP="0-0-0"
 F PRCSI=0:0 S SLP=$O(^PRCS(410,"F",CPVAR_"-"_$P(SLP,"-",3))) Q:$P(CPVAR,"-",1,2)'=$P(SLP,"-",1,2)!(SLP="")  Q:STOP1=-1  S PRCSDA=$O(^PRCS(410,"F",SLP,0)) Q:PRCSDA'>0  I $D(^PRCS(410,PRCSDA,0)) D CHECK
 I FND=0 W !,"No transactions found for this control point.",! D LINE
 H 2 S FND=0 Q
CHECK ;
 S:$D(YY) DA=YY S:$D(PRCSDA) DA=PRCSDA
 Q:'$D(DA)  S FND=1 D CHEC^PRCSAPP1
 ; if all checks are passed, go on for final approval
 I SPENDCP=0 D FINAL^PRCSAPP2
 S SPENDCP=0 Q
LOOKUP ;
 S PRCSID=1,PRC("CP")=CPARRAY(II),DIC="^PRCS(410,",DIC(0)="AEQ",D="F"
 S DIC("S")="I +^(0)=PRC(""SITE""),+$P(^(0),""-"",4)=PRC(""CP""),$D(^PRC(420,""A"",DUZ,PRC(""SITE""),PRC(""CP""),1))"
 W @IOF D LINE
 W !,$P($T(MESSAGE+6),";;",2),!
 S DIC("A")="Select TRANSACTION: " D ^PRCSDIC K PRCSID,DIC,DIC("S"),DIC("A")
 S:Y<0 CONT=1 Q
SHOW ;
 W !,"Select from the following control points: ",!
 F II=0:1:AA I $D(CPARRAY(II)) W !,?10,$P($G(^PRC(420,PRC("SITE"),1,CPARRAY(II),0)),"^")
 H 4
 Q
LINE ;
 W ! F LINE=1:1:53 W "_"
 W !! Q
MESSAGE ;
 ;;Please contact your ADP Site manager to grant system access.
 ;;Contact your Site Manager for an electronic signature code.
 ;;Enter Yes to loop thru all your CPs, No to select only one.
 ;;Control Point has no transactions for approval!
 ;;Enter yes or no
 ;;Enter the last four digits,i.e.,'0094',of transaction number

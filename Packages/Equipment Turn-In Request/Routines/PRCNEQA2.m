PRCNEQA2 ;SSI/ALA-Equipment Committee Approval ;[ 09/11/96  2:01 PM ]
 ;;1.0;Equipment/Turn-In Request;;Sep 13, 1996
BEG K DIR,Y,^TMP($J,"APP") S PRCNX=0,PRCNT=0,PRCNZ=-17,PG=1
BLST ; Build list of Equipment Requests
 S PRCNX=$O(^PRCN(413,PRCNX)) G:PRCNX'>0 BPRT
 I $P(^PRCN(413,PRCNX,0),U,7)=31 D
 . S PRCNT=PRCNT+1,^TMP($J,"APP",PG,PRCNT)=PRCNX
 . I PRCNT=12 S PG=PG+1
 G BLST
BPRT ; Update display number and print a screenful
 S NPG=PG,PG=1
BLP ; Main loop: get input & process help
 D HDR
 I PRCNT=0 D  Q
 . W !!,"NO RECORDS TO PROCESS"
 . R !!,"Press return to continue: ",PRCNX:DTIME
 K ^TMP($J,"APP","D"),DUOUT S X=0,ER=0,ER(0)=""
SEL I NPG>1 S DIR(0)="SM^S:Select Requests;N:Next Page;P:Previous Page"
 I NPG=1 G SEL1
 S DIR("A")="Select Action "
 D ^DIR K DIR S VTI=$$UP^XLFSTR(X) I VTI["^" Q
 I VTI="N",PG+1>NPG W !,"No Next Page" G SEL
 I VTI="P",PG-1<1 W !,"No Previous Page" G SEL
 I VTI="N" S PG=PG+1 G BLP
 I VTI="P" S PG=PG-1 G BLP
SEL1 ;
 S DIR("A")="Select numbers to process",DIR(0)="L^1:"_PRCNT
 D ^DIR Q:$G(DIRUT)=1  S EQLS=Y K DIR,Y,X
 F J=1:1 S EQDA=$P(EQLS,",",J) Q:EQDA=""  D
 . S PPG="" F  S PPG=$O(^TMP($J,"APP",PPG)) Q:PPG=""  D
 .. Q:$G(^TMP($J,"APP",PPG,EQDA))=""
 .. S ^TMP($J,"APP","D",^TMP($J,"APP",PPG,EQDA))=""
 Q
HDR ; Prints NX header and up to 12 lines of NX data
 D:'$D(IOF) HOME^%ZIS
 W @IOF,?15,EQXT_" in the following Equipment Requests",!
 W !,"Num#",?7,"Rank",?13,"Request #",?33,"Service",?60,"# Items",?70,"Amount",!
 F I=1:1:79 W "-"
 S Y="" F  S Y=$O(^TMP($J,"APP",PG,Y)) Q:Y=""  S D0=^TMP($J,"APP",PG,Y) D
 . D GETSUMS W !,Y,?7,$P($G(^PRCN(413,D0,6)),U,3)
 . W ?13,$P($G(^PRCN(413,D0,0)),U) S SERV=$P(^DIC(49,$P(^(0),U,3),0),U)
 . W ?33,$E(SERV,1,25),?62,TQTY,?70,"$",$J(TOTAL,8,2)
 Q
GETSUMS ; Get line item total & display stuff
 S (D1,TQTY,TOTAL,LTOTAL)=0 NEW Y
 F  S D1=$O(^PRCN(413,D0,1,D1)) Q:'+D1  D  S TQTY=TQTY+1
 . S DR=15,DR(413.015)=6,DIQ(0)="C",DIQ="LBTOT"
 . S DIC=413,DA=D0,DA(1)=D1,DA(413.015)=D1 NEW D1
 . D EN^DIQ1
 . S LBN="" F  S LBN=$O(LBTOT(413.015,LBN)) Q:LBN=""  D
 .. S X=$G(LBTOT(413.015,LBN,6))
 .. S LTOTAL=LTOTAL+X
 . K DR,DIQ,LBTOT,DIC,X
 S TOTAL=TOTAL+LTOTAL F FN=20,22,24,53,54,60,63,65,66 D
 . S:FN<25 I=2,PN=FN-15 S:FN>25 I=7,PN=FN-51
 . S COST=$P($G(^PRCN(413,D0,I)),U,PN),TOTAL=TOTAL+COST
 Q

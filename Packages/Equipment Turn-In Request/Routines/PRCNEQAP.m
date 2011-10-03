PRCNEQAP ;SSI/ALA-Equipment Committee Approval ;[ 09/11/96  1:59 PM ]
 ;;1.0;Equipment/Turn-In Request;;Sep 13, 1996
EN ;Ask for approval type
 S DIR("A")="Select Approval Methodology"
 S DIR("A",2)=" "
 S DIR("A",1)="Select the appropriate approval methodology to process multiple transactions."
 S DIR("A",3)="Option 1 - APPROVE/FUNDED ALL LINE ITEMS should be used when all line items in a"
 S DIR("A",4)="transaction have been designated 'approve and funded' and are ready for 2237"
 S DIR("A",5)="processing."
 S DIR("A",6)="Option 2 - APPROVE/PENDING ALL LINE ITEMS should be used when all line items"
 S DIR("A",7)="in a transaction have been approved but funding is still pending."
 S DIR("A",8)="Option 3 - DISAPPROVE ALL LINE ITEMS should be used when all lines items in a"
 S DIR("A",9)="transaction have not been approved."
 S DIR("A",10)="Option 4 - DEFER ALL LINE ITEMS should be used when all line items in a"
 S DIR("A",11)="transaction should be deferred until a later decision cycle."
 S DIR("A",12)="Option 5 - Process Individual Line Items should be used when some line items"
 S DIR("A",13)="in the same transaction have been approved and some have not been approved."
 S DIR("A",14)=" "
 S DIR(0)="S^1:APPROVE/FUNDED ALL LINE ITEMS;2:APPROVE/PENDING ALL LINE ITEMS;3:DISAPPROVE ALL LINE ITEMS;4:DEFER ALL LINE ITEMS;5:PROCESS INDIVIDUAL LINE ITEMS"
 D ^DIR G EXIT:$G(DIRUT)=1 S EQXI=X,EQXT=Y(0)
BEG ;
 D ^PRCNEQA2 G EXIT:$G(DIRUT)=1!($G(VTI)="^")
 S STAT=$S(EQXI=1:19,EQXI=2:18,EQXI=3:16,EQXI=4:17,1:"")
 S STT=$S(EQXI=1:"AF",EQXI=2:"AP",EQXI=3:"DD",EQXI=4:"DF",1:"")
 S MSGN=$S(EQXI=1:43,EQXI=2:44,EQXI=3:40,EQXI=4:39,1:"")
 S IN="" F  S IN=$O(^TMP($J,"APP","D",IN)) Q:IN=""  D  I $G(DUOUT)=1 S DUOUT=0 G BEG
 . I EQXI<5 D FAP^PRCNEQA1 Q:$G(DUOUT)=1
 . I EQXI=5 D LINE^PRCNEQA1 Q:$G(DUOUT)=1!($G(DTOUT)=1)  D ^PRCNEQS
 . I $G(IN)'="" S PSER="" F  S PSER=$O(^PRCN(413,"P",PSER)) Q:PSER=""  D
 .. S RNK="" F  S RNK=$O(^PRCN(413,"P",PSER,RNK)) Q:RNK=""  K ^PRCN(413,"P",PSER,RNK,IN)
 . K PSER,X,RNK
EXIT K DIR,DIRUT,LTOTAL,PN,PRCNT,PRCNZ,SERV,TOTAL,TQTY,XX,PRCNZ,PRCNT,Y
 K ^TMP($J),EQXI,EQXT,EQLS,PRCNI,PRCNJ,PRCNK,PRCNN,PRCNT,PRCNL,SK,NTRN
 K ER,FN,IN,IN2,MSGN,STAT,STT,COST,D0,D1,I,PRCNX,D,DA,EQDA,J,LBN,LPRI
 K OLDPRI,PRIMAX,X,XMDT
 Q
HDR(X) ; Prints NX header and up to 18 lines of NX data
 D:'$D(IOF) HOME^%ZIS
 W @IOF,?15,EQXT_" in the following Equipment Requests",!!
 W !,"Num#",?7,"Rank",?13,"Request #",?33,"Service",?60,"# Items",?70,"Amount",!
 F I=1:1:79 W "-"
 F Y=X:1:X+17 Q:'$D(^TMP($J,"APP",Y))  S D0=^TMP($J,"APP",Y) D
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

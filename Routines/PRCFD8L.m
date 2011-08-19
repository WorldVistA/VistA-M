PRCFD8L ;WISC/LEM-FMS LIN,PVA,PVB,PVZ SEGMENTS ;7/24/97  14:07
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
LIN ;BUILD 'LIN' SEGMENT
 S DA(421.541)=LINE,DR="1;2;3;14;41" D EN^DIQ1
 S ^TMP($J,"PRCPV",LINE*4+1)="LIN^~"
 Q
PVA ;BUILD 'PVA' SEGMENT
 N SEG,ACCDATE,X1,X2,SERVDATE,CERTDATE
 S (SEG,ACCDATE)=""
 S (X2,SERVDATE)=PRCTMP(421.5,DA,11.5,"I")
 S (X1,CERTDATE)=PRCTMP(421.5,DA,61.9,"I")
 I X2,'X1 D
 . S X1=X2,X2=7 D C^%DTC S ACCDATE=X Q
 I SERVDATE,CERTDATE D
 . S X1=CERTDATE,X2=SERVDATE D ^%DTC
 . I X<8 S ACCDATE=CERTDATE Q
 . I X>7 S X1=SERVDATE,X2=7 D C^%DTC S ACCDATE=X Q
 S $P(SEG,U,1)="PVA" ; Segment ID
 S X="000"_PRCTMP(421.541,DA(421.541),4,"E")
 S $P(SEG,U,2)=$E(X,$L(X)-2,$L(X)) ; FMS Line Number
 S $P(SEG,U,3)=PRCF("TC") ; Reference Document Transaction Code
 S $P(SEG,U,4)=PRCF("TN") ; Transaction Number
 S $P(SEG,U,5)=$P(SEG,U,2) ; Reference Document FMS Line Number
 S $P(SEG,U,6)=$E(ACCDATE,2,3) ; Accept Year
 S $P(SEG,U,7)=$E(ACCDATE,4,5) ; Accept Month
 S $P(SEG,U,8)=$E(ACCDATE,6,7) ; Accept Day
 S $P(SEG,U,21)=PRCTMP(421.541,DA(421.541),.01,"I") ; BOC
 S X=PRCTMP(421.5,CI,2,"I")
 S $P(SEG,U,29)=$E(X,2,3) ; Vendor's Invoice Year
 S $P(SEG,U,30)=$E(X,4,5) ; Vendor's Invoice Month
 S $P(SEG,U,31)=$E(X,6,7) ; Vendor's Invoice Day
 S X=PRCTMP(421.541,DA(421.541),1,"I")
 S $P(SEG,U,33)=$FN(X,"",2) ; Line Amount
 S $P(SEG,U,34)="I" ;PRCTMP(421.541,DA(421.541),5,"I") ; Line Action (Increase/Decrease)
 S $P(SEG,U,35)=PRCTMP(421.541,DA(421.541),3,"I") ; Partial/Final Indicator
 S X=PRCTMP(421.5,CI,3,"I")
 S $P(SEG,U,36)=$E(X,2,3) ; Year Invoice Logged
 S $P(SEG,U,37)=$E(X,4,5) ; Month Invoice Logged
 S $P(SEG,U,38)=$E(X,6,7) ; Day Invoice Logged
 S X="" I PRCTMP(421.541,DA(421.541),4,"E")=991 S X="F"
 S $P(SEG,U,39)=X ; Line Type
 S $P(SEG,U,41)="~" ; Segment Delimiter
 S ^TMP($J,"PRCPV",LINE*4+2)=SEG
 Q
PVB ;BUILD 'PVB' SEGMENT
 N SEG
 S SEG="",$P(SEG,U,1)="PVB"
 Q:+PRCTMP(421.541,DA(421.541),2,"I")=PRCTMP(421.541,DA(421.541),1,"I")
 I PRCTMP(421.541,DA(421.541),2,"I")]"" D
 . S $P(SEG,U,8)=$FN(PRCTMP(421.541,DA(421.541),2,"I"),"",2) ; Liquidation Amount
 . S SEG=SEG_"^~",^TMP($J,"PRCPV",LINE*4+3)=SEG
 Q
PVC ;BUILD 'PVC' SEGMENT
 Q  ; No data for now - Don't send PVC segment.
 N SEG
 S SEG="",$P(SEG,U,1)="PVC",$P(SEG,U,5)="~"
 S ^TMP($J,"PRCPV",LINE*4+4)=SEG
 Q
 ;
CVNFY(A,B) ;return conversion FY
 N X,Y,Z S X="",Y=$O(^DIC(9.4,"B",A,"")) Q:Y="" X
 S Z=0 F  S Z=$O(^DIC(9.4,Y,22,Z)) Q:+Z'>0  I $E($G(^DIC(9.4,Y,22,Z,0)),1,$L(B))=B Q
 Q:+Z'>0 X
 S X=$P(^DIC(9.4,Y,22,Z,0),U,3)
 S:X X=$E(X,1,3)+1700+$S(+$E(X,4,5)>9:1,1:0)
 Q X
 ;
 ; USER OPTION TO SET UP SO to AR DATE
SOAR N DIR,X,X1,X2,PRCSOAR
SOAR0 S DIR(0)="D^DT:"_(DT+10000)_":EFX"
 S DIR("B")=$$FMTE^XLFDT($G(^PRC(411,"A IFCAP-Wide Parameters","SO 2 AR Date"))) S:DIR("B")="" DIR("B")="10/12"
 S DIR("A")=" "
 S DIR("A",1)="Enter the date on which FMS will accrue their prior year documents."
 S DIR("?")="The MM/DD/YY is provided by Central Office/FMS, normally via MailMan"
 D ^DIR I Y="^" G SOARQ
 I Y'>0 G SOAR0
 W !
 S PRCSOAR=Y
 S X1=Y,X2=1 D C^%DTC
 S DIR("A")="Is this correct?"
 S DIR("A",1)="IFCAP will allow 'SO's to be sent to Austin as 'AR's starting on "_$$FMTE^XLFDT(X,2)_"."
 S DIR(0)="Y"
 S DIR("B")="NO"
 S DIR("?")="Enter 'Y' to accept your entry, 'N' to change it"
 D ^DIR I $D(DIRUT) G SOARQ
 I Y S ^PRC(411,"A IFCAP-Wide Parameters","SO 2 AR Date")=PRCSOAR G SOARQ
 I 'Y W !! G SOAR0
SOARQ Q
 ;
SOARINIT S ^PRC(411,"A IFCAP-Wide Parameters","SO 2 AR Date")=2961004 Q

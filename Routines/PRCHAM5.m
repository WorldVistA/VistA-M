PRCHAM5 ;WISC/AKS,ID/RSD,SF-ISC/TKW-CONT. OF AMENDMENTS ;7-2-91/15:40
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
ENUI ; UPDATE FIELDS ON ITEM FILE THAT WERE CHANGED THROUGH AMENDMENT
 W !! D W W %B,! F I=0:0 S I=$O(%B(I)) Q:'I  W %B(I),!
 D YN^PRCFYN Q:%'=1  S I=0 D UPI Q
UPI S I=$O(^PRC(442,PRCHPO,2,I)) Q:'I  S Y=^(I,0) G:'$D(^PRC(441,+$P(Y,U,5),0)) UPI S Z=$O(^PRC(442,PRCHPO,2,I,1,0)) G:'$D(^(Z,0)) UPI I ^(0)'["*AMENDED*" G UPI
 S:$P(Y,U,13)'="" $P(^PRC(441,+$P(Y,U,5),0),U,5)=$P(Y,U,13)
 G:'$D(^PRC(441,+$P(Y,U,5),2,PRCHCV,0)) UPI S X=^(0)
 S:$P(Y,U,3)'="" $P(X,U,7)=$P(Y,U,3) S:$P(Y,U,12) $P(X,U,8)=$P(Y,U,12) S:$P(Y,U,9) $P(X,U,2)=$P(Y,U,9),$P(X,U,6)=DT S:$P(Y,U,6)'="" $P(X,U,4)=$P(Y,U,6)
 I $D(^PRC(442,PRCHPO,2,I,2)) S Z=$P(^(2),U,2) I Z]"",$D(^PRC(442,PRCHPO,1)) S $P(X,U,3)=$O(^PRC(440,+^(1),4,"B",Z,0)) S Z=$O(^PRC(440,PRCHCV,4,"B",Z,0)) I Z S $P(X,U,3)=Z
 S ^PRC(441,+$P(Y,U,5),2,PRCHCV,0)=X
 G UPI
EN7 ;PROMPT PAYMENT EDIT
 S DIC="^PRC(442,PRCHPO,5,",DIC(0)="AEQZ" D ^DIC Q:Y<0  S PRCHP=Y,PRCHP0=Y(0),PRCHO=$P(Y(0),U,1)_"/"_$P(Y(0),U,2)
 S %X="^PRC(442,PRCHPO,5,+PRCHP,",%Y="^PRC(443.6,PRCHPO,5,+PRCHP," D %XY^%RCR S ^PRC(443.6,PRCHPO,5,0)="^443.66A^"_$P(^PRC(442,PRCHPO,5,0),U,3,4)
 S DR="[PRCHAMPPP]",DIE="^PRC(443.6,",DA=PRCHPO D ^DIE K DIE
 S PRCHN=$S($D(^PRC(443.6,PRCHPO,5,+PRCHP,0)):$P(^(0),U,1)_"/"_$P(^(0),U,2),1:"@") Q:PRCHO=PRCHN
 S PRCHT=0 S:PRCHN="@" PRCHL1="*",^TMP("PRCHW",$J,1)="Prompt Payment "_PRCHO_" has been cancelled" Q
PONO I $D(PRCHNRQ) S PRCHP("A")="REQUISITION NUMBER",PRCHP("T")=8,PRCHP("S")=1 D EN^PRCHPAT Q
 I $D(PRCHIMP) S PRCHP("A")="IMPREST FUND P.O.NO.: ",PRCHP("T")=7,PRCHP("S")=3 D EN^PRCHPAT Q
 D ENPO^PRCHUTL Q
DOCID S Z=$P(^PRC(443.6,PRCHPO,0),"-",2),$P(^PRC(443.6,PRCHPO,18),"^",3)=$S(Z:$E(Z,2,6),1:$E(Z)_$E(Z,3,6)) K Z Q
W S %B="You have the choice to let the system automatically update the Item Master",%B(1)="File with the amended data.  If you choose to do this, the following",%B(2)="fields will be updated for ALL amended items on this order:"
 S %B(3)="   National Stock No.",%B(6)="   Vendor Stock No.",%B(7)="   Unit of Purchase",%B(8)="   Packaging Multiple",%B(9)="   Actual Unit Cost",%B(10)="   Contract Number."
 S %A="UPDATE ITEM FILE",%=2
 Q

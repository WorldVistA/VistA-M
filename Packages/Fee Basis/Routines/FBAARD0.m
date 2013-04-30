FBAARD0 ;AISC/GRR - DELETE REJECTS ENTERED IN ERROR (CONT.) ;3/28/2012
 ;;3.5;FEE BASIS;**132**;JAN 30, 1995;Build 17
 ;;Per VHA Directive 2004-038, this routine should not be modified.
HELPD ;
 W !!,"If you answer 'Yes' to this question, the reject flag will be deleted from all"
 W !,"locally rejected line items in this batch.  If you answer 'No', you will be"
 W !,"asked if you want to delete the reject flag from specific line items."
 Q
DELC ; specify line items rejected in error for batch type B9
 S (QQ,FBAAOUT)=0 W @IOF D HEDC^FBAACCB1 F I=0:0 S I=$O(^FBAAI("AH",B,I)) Q:I'>0!(FBAAOUT)  I $D(^FBAAI(I,0)) S Z(0)=^(0) D WRITC
 I QQ=0 W !,"No local rejects found in batch!" Q
RL S DIR(0)="N^1:"_QQ,DIR("A")="Delete reject flag for which line item" D ^DIR K DIR Q:$D(DIRUT)  S HX=X
 I '$D(QQ(HX)) W !,*7,"You already did that one !!" G RL
ASKSU S DIR(0)="Y",DIR("A")="Are you sure you want to delete the reject on item number "_HX,DIR("B")="NO" D ^DIR K DIR G:$D(DIRUT)!'Y RL
 S I=QQ(HX),(FBAAAP,FBAAMT)=+$P(^FBAAI(I,0),"^",9),FBII78=$P($G(^(0)),"^",5),FBMM=$E($P(^(0),U,6),4,5) S FBINVI=I D INPOST^FBAARD3 S I=FBINVI K FBINVI I $D(FBERR) G PROB^FBAARD1
 S FBX=$$DELREJ^FBAARR3(162.5,I_",")
 I 'FBX D
 . W !,"1358 was updated, but error occured while deleting the reject"
 . W !,"flag for line with IENS = "_I_","
 . W !,"  ",$P(FBX,"^",2)
 . S FBERR=1
 K QQ(HX),FBMM
 W !,"...Done"
 I '$D(^FBAAI("AH",B)) Q
RDMORE S DIR(0)="Y",DIR("A")=$S($G(FBERR):"",1:"Item Deleted.  ")_"Want to delete another",DIR("B")="YES" D ^DIR K DIR G RDMORE:$D(DIRUT),RL:Y
 Q
WRITC ;
 Q:$P($G(^FBAAI(I,"FBREJ")),"^",4)=1  ; skip interface rejects
 S QQ=QQ+1,QQ(QQ)=I D CMORE^FBAACCB1 Q

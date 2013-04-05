FBAARD2 ;AISC/GRR - DELETE REJECT CODE FOR AN ITEM (CONT.) ;3/26/2012
 ;;3.5;FEE BASIS;**132**;JAN 30, 1995;Build 17
 ;;Per VHA Directive 2004-038, this routine should not be modified.
DELT ; specify line items rejected in error for batch type B2
 ; select patient
 S J=$$ASKVET^FBAAUTL1("I $D(^FBAAC(""AG"",B,+Y))")
 Q:'J
 K QQ
 S QQ=0 W @IOF D HEDP^FBAACCB0
 F K=0:0 S K=$O(^FBAAC("AG",B,J,K)) Q:K'>0  D WRITT
 I QQ=0 W !,"No local rejects found in batch for this patient!" G DELT
RLT1 S DIR(0)="Y",DIR("A")="Delete Reject flag for all items for this patient",DIR("B")="YES" D ^DIR K DIR Q:$D(DIRUT)  G LOOPT:Y
RLT S DIR(0)="N^1:"_QQ,DIR("A")="Delete reject for which line item" D ^DIR K DIR Q:$D(DIRUT)  S HX=X
 I '$D(QQ(HX)) W !!,*7,"You just deleted that one!!" G RLT
ASKK S DIR(0)="Y",DIR("A")="Are you sure you want to delete reject for item number "_HX,DIR("B")="NO" D ^DIR K DIR G:$D(DIRUT)!'Y RLT
 S J=$P(QQ(HX),"^",1),K=$P(QQ(HX),"^",2)
 D STUFFT
RDMORT S DIR(0)="Y",DIR("A")=$S($G(FBERR):"",1:"Reject Flag deleted.  ")_"Want to delete another",DIR("B")="YES" D ^DIR K DIR G RDMORT:$D(DIRUT),RLT:Y
 Q
WRITT ;
 Q:$P($G(^FBAAC(J,3,K,"FBREJ")),"^",4)=1  ; skip interface reject
 S QQ=QQ+1,QQ(QQ)=J_"^"_K S Y(0)=^FBAAC(J,3,K,0) D SETT^FBAACCB0
 Q
STUFFT ;
 N FBX
 S FBAAMT=$P(^FBAAC(J,3,K,0),"^",3)
 D POST^FBAARD3 I $D(FBERR) G PROB^FBAARD1
 S FBX=$$DELREJ^FBAARR3("162.04",K_","_J_",")
 I 'FBX D
 . W !,"1358 was updated, but error occured while deleting the reject"
 . W !,"flag for line with IENS = "_K_","_J_","
 . W !,"  ",$P(FBX,"^",2)
 . S FBERR=1
 K QQ(HX)
 Q
LOOPT F HX=0:0 S HX=$O(QQ(HX)) Q:HX'>0  S J=$P(QQ(HX),"^",1),K=$P(QQ(HX),"^",2) D STUFFT
 W !,"...DONE!"
 G DELT
 ;
DELP ; specify line items rejected in error for batch type B5
RDI K QQ W !! S DIC="^FBAA(162.1,",DIC(0)="AEQ" D ^DIC Q:X="^"!(X="")  G:Y<0 RDI S A=+Y I '$D(^FBAA(162.1,"AF",B,A)) W !!,*7,"No payments rejected in this batch for that Invoice!" G RDI
 S QQ=0,FBIN=A W @IOF D SETV^FBAACCB0,HED^FBAACCB
 F B2=0:0 S B2=$O(^FBAA(162.1,"AF",B,A,B2)) Q:B2'>0  D WRITP
 I QQ=0 W !,"No local rejects found in batch for this invoice!" G DELP
RLP1 S DIR(0)="Y",DIR("A")="Delete Reject code for all items for this invoice",DIR("B")="YES" D ^DIR K DIR Q:$D(DIRUT)  G LOOPP:Y
RLP S DIR(0)="N^1:"_QQ,DIR("A")="Delete reject code for which line item" D ^DIR K DIR Q:$D(DIRUT)  S HX=X
 I '$D(QQ(HX)) W !!,*7,"You just deleted that one!!" G RLP
ASKJJ S DIR(0)="Y",DIR("A")="Are you sure you want to delete reject for item number "_HX,DIR("B")="NO" D ^DIR K DIR G:$D(DIRUT)!'Y RLP
 S A=$P(QQ(HX),"^",1),B2=$P(QQ(HX),"^",2)
 D STUFFP
RDMORP S DIR(0)="Y",DIR("A")=$S($G(FBERR):"",1:"Reject Flag deleted.  ")_"Want to delete another",DIR("B")="YES" D ^DIR K DIR G RDMORP:$D(DIRUT),RLP:Y
 Q
WRITP ;
 Q:$P($G(^FBAA(162.1,A,"RX",B2,"FBREJ")),"^",4)=1  ; skip interface rej.
 S QQ=QQ+1,QQ(QQ)=A_"^"_B2 S Z(0)=^FBAA(162.1,A,"RX",B2,0)
 D MORE^FBAACCB1
 Q
STUFFP ;
 N FBX
 S FBAAMT=$P(^FBAA(162.1,A,"RX",B2,0),"^",16)
 D POST^FBAARD3 I $D(FBERR) G PROB^FBAARD1
 S FBX=$$DELREJ^FBAARR3("162.11",B2_","_A_",")
 I 'FBX D
 . W !,"1358 was updated, but error occured while deleting the reject"
 . W !,"flag for line with IENS = "_B2_","_A_","
 . W !,"  ",$P(FBX,"^",2)
 . S FBERR=1
 K QQ(HX)
 Q
LOOPP F HX=0:0 S HX=$O(QQ(HX)) Q:HX'>0  S A=$P(QQ(HX),"^",1),B2=$P(QQ(HX),"^",2) D STUFFP
 W !,"...DONE!"
 G DELP

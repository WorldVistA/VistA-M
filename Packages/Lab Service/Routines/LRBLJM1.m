LRBLJM1 ;AVAMC/REG/CYM - EDIT POOLED UNIT 10/8/97  22:09 ;
 ;;5.2;LAB SERVICE**90,247**;;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 ;
 ; LRP=POOLED UNIT, LRC=INDIVIDUAL COMPONENT UNIT
 ; LR("ADJ") flags if component is added or deleted from pool
 ;
A S LR("ADJ")="A" W ! S DIC="^LRD(65,",DIC(0)="AEQMZ",DIC("A")="Select UNIT TO ADD: ",DIC("S")="I $S('$D(^(4)):1,$P(^(4),U)]"""":0,1:1)&($P(LRW,U)'=$P(^(0),U))&($P(^LAB(66,$P(^(0),U,4),0),U,26)=LRA)"
 D ^DIC K DIC Q:Y<1  S DA=+Y
 W !!,"Ok to add ",$P(Y(0),U)," to pool " S LRL=0,%=2 D YN^LRU Q:%'=1  D L1 I LRL Q
 S LRC=DA,G=^LRD(65,LRP,9,0),I=$P(G,U,3) D G ; gets next available modified to/from IEN for Pooled Unit
 S LRF=$P(Y(0),"^",4),LRG=$P(Y(0),"^"),^LRD(65,LRP,9,0)=$P(G,"^",1,2)_"^"_I_"^"_($P(G,"^",4)+1),^(I,0)=LRF_"^"_LRG_"^"_1
 D T S ^LRD(65,DA,4)="MO"_"^"_LRT_"^"_DUZ S:'$D(^LRD(65,DA,9,0)) ^(0)="^65.091PAI^"_I_"^" S G=^(0),X=DA,J=$P(G,"^",3) S:J']"" J=I S ^LRD(65,DA,9,0)=$P(G,"^",1,2)_"^"_J_"^"_($P(G,"^",4)+1),^(I,0)=$P(LRW,"^",4)_"^"_$P(LRW,"^")_"^"_2
 N NODE S NODE=$G(^LRD(65,DA,4)) ;Adds "added unit" disposition fields to audit trail
 S O="",X=$P(NODE,U),Z="65,4.1" D EN^LRUD
 S O="",X=$P(NODE,U,2),Z="65,4.2" D EN^LRUD
 S O="",X=$P(NODE,U,3),Z="65,4.3" D EN^LRUD
 ; Following line adds modified to/from fields (for COMPONENT unit) to audit trail for new component added to Pool
 I J S DA(1)=DA,DA=J D
 . S NODE=$G(^LRD(65,DA(1),9,DA,0))
 . S O="",X=$P(NODE,U),Z="65.091,.01" D EN^LRUD
 . S O="",X=$P(NODE,U,2),Z="65.091,.02" D EN^LRUD
 . S O="",X=$P(NODE,U,3),Z="65.091,.03" D EN^LRUD
 S DA=DA(1),DIK="^LRD(65,",DIK(1)="4.1^AC^APS" D EN1^DIK
 S X=LRT,DIK="^LRD(65,",DIK(1)="4.2^AB" D EN1^DIK
 ; Following line adds modified to/from fields (for POOLED unit) to audit trail for the new component added to Pool
 S DA=I,DA(1)=LRP,NODE=$G(^LRD(65,DA(1),9,DA,0))
 S X=$P(NODE,U),O="",Z="65.091,.01" D EN^LRUD
 S X=$P(NODE,U,2),O="",Z="65.091,.02" D EN^LRUD
 S X=$P(NODE,U,3),O="",Z="65.091,.03" D EN^LRUD
 S DA=LRP S O=$P($G(^LRD(65,DA,4)),U,4) I O]"" D
 . N NEWPOOL S NEWPOOL="("_(E+1)_")" ; Updates the pooled divided units field
 . I $D(^LRD(65,DA,4)) S $P(^LRD(65,DA,4),U,4)=NEWPOOL
 . S X=NEWPOOL,Z="65,4.4" D EN^LRUD
 D VOL Q
 ;
G ; get next available IEN for POOLED unit modified to/from multiple
 S I=I+1 I $D(^LRD(65,LRP,9,I,0)) G G
 Q
 ;
R S LR("ADJ")="R" W ! S A=0 F E=0:1 S A=$O(^TMP($J,A)) Q:'A!(LR("Q"))  S X=^(A) W !,$J(A,3),")",?7,$P(X,"^",3),?25,$P(X,"^",4) D:A#21=0 M^LRU Q:LR("Q")
 W !!,"Select UNIT TO REMOVE (1-",E,"): " R X:DTIME Q:X[U!(X="")  I +X'=X!(X<1)!(X>E) W $C(7),!,"Must enter a number from 1 to ",E G R
 S X=^TMP($J,X),(DA,LRC)=$P(X,U,2),LRI=+X,LRC(3)=$P(X,U,3) W "  ",LRC(3)
 W !,"Ok to remove ",LRC(3)," from pool " S LRL=0,%=2 D YN^LRU Q:%'=1  D L1 I LRL Q
B S DA(1)=LRP,DA=LRI D AUDIT ; Put deleted modified to/from entry from POOLED unit on audit trail
 S DA=LRP S O=$P($G(^LRD(65,DA,4)),U,4) I O]"" D
 . N NEWPOOL S NEWPOOL="("_(E-1)_")" ; Update the Pooled/Divided units field
 . I $D(^LRD(65,DA,4)) S $P(^LRD(65,DA,4),U,4)=NEWPOOL
 . S X=NEWPOOL,Z="65,4.4" D EN^LRUD
 D VOL
 S DA=0,DA(1)=LRC F B=0:0 S B=$O(^LRD(65,LRC,9,B)) Q:'B  S X=^(B,0) I +X=$P(LRW,"^",4),$P(X,"^",2)=$P(LRW,"^") S DA=B Q
 D:DA AUDIT,K Q  ; Put modified to/from entry from deleted COMPONENT unit on audit trail, then delete COMPONENT unit's disposition fields.
 Q
K S DA=DA(1),LRC=$S($D(^LRD(65,DA,4)):^(4),1:"") Q:$P(LRC,"^")'="MO"
 F LR(4.1)=1,2,3 X:$D(^DD(65,4.1,1,LR(4.1),2)) ^(2)
 S X=$P(LRC,"^",2) X:$D(^DD(65.4,4.2,1,1,2)) ^(2)
 K DA(1) S O="MO",X="",Z="65,4.1" D EN^LRUD S O=$P(LRC,"^",2),X="",Z="65,4.2" D EN^LRUD S O=$P(LRC,"^",3),X="Deleted",Z="65,4.3" D EN^LRUD
 K ^LRD(65,DA,4) Q
E S X=^LRD(65,DA(1),9,0) K ^(DA,0) S X(1)=$O(^LRD(65,DA(1),9,0)),^(0)=$P(X,"^",1,2)_"^"_X(1)_"^"_($P(X,"^",4)-1) Q
 ;
D W !!,"Ok to delete the ",$P(LRW,"^")," pool " S LRL=0,%=2 D YN^LRU Q:%'=1  F A=0:0 S A=$O(^TMP($J,A)) Q:'A  S DA=$P(^(A),"^",2) D L1 Q:LRL
 Q:LRL  F LRA=0:0 S LRA=$O(^TMP($J,LRA)) Q:'LRA  S X=^(LRA),(DA,DA(1),LRC)=$P(X,"^",2),LRI=+X,LRC(3)=$P(X,"^",3) D K S LRC=DA D
 . S DA(1)=LRP,DA=LRI
 . S NODE=$G(^LRD(65,LRP,9,LRI,0))
 . S X="Deleted",O=$P(NODE,U),Z="65.091,.01" D EN^LRUD
 . S X="Deleted",O=$P(NODE,U,2),Z="65.091,.02" D EN^LRUD
 . S X="Deleted",O=$P(NODE,U,3),Z="65.091,.03" D EN^LRUD
 . S LRCOMP=0 F  S LRCOMP=$O(^LRD(65,LRC,9,LRCOMP)) Q:'LRCOMP  S DA(1)=LRC,DA=LRCOMP D
 .. S NODE=$G(^LRD(65,LRC,9,LRCOMP,0))
 .. S X="Deleted",O=$P(NODE,U),Z="65.091,.01" D EN^LRUD
 .. S X="Deleted",O=$P(NODE,U,2),Z="65.091,.02" D EN^LRUD
 .. S X="Deleted",O=$P(NODE,U,3),Z="65.091,.03" D EN^LRUD
 .. S DIK="^LRD(65,"_DA(1)_",9," D ^DIK
 ; Above block of code places Modified to/from info from POOLED and COMPONENT units onto the audit trail
 S DA=LRP D DISP^LRBLAUD1 ; Collect ALL disposition data on a POOLED  unit (includes Transfusion Record if present) to be placed on audit trail if necessary
 K DA(1) S DA=LRP,Z="65,.01",O=$P(LRW,"^"),X="Deleted" D EN^LRUD K ^LRD(65,DA,4) D DISP1^LRBLAUD1 ; Place disposition data on audit trail if necessary
 S DA(1)=LRP I LRDSP]"" S O=LRDSP,X="Deleted",Z="65,4.1" D EN^LRUD
 I LRPTR]"",LRREC]"" S DA=LRREC,DIK="^LR(LRPTR,1.6," D ^DIK
 S DA=LRP,DIK="^LRD(65," D ^DIK Q
 ;
T S %DT="T",X="N" D ^%DT S LRT=Y Q
 ;
L1 I $D(LRLOCK)#2 L -^LRD(65,LRLOCK)
 S LRLOCK=DA L +^LRD(65,DA):1
 I '$T W !,$C(7),"ANOTHER TERMINAL IS EDITING ",$P(^LRD(65,DA),U) S LRL=1
 Q
AUDIT ; Puts deleted modified to/from entries onto audit trail
 N NODE S NODE=$G(^LRD(65,DA(1),9,DA,0))
 S O=$P(NODE,U),X="Deleted",Z="65.091,.01" D EN^LRUD
 S O=$P(NODE,U,2),X="Deleted",Z="65.091,.02" D EN^LRUD
 S O=$P(NODE,U,3),X="Deleted",Z="65.091,.03" D EN^LRUD
 D E
 Q
VOL ; Recalculate and updates POOLED unit volume, records change on audit trail
 N POOLVOL,UNITVOL,UNIT,NEWVOL
 S POOLVOL=$P(^LRD(65,LRP,0),U,11),O=POOLVOL
 S UNIT=$P(^LRD(65,LRC,0),U,4)
 S UNITVOL=$P(^LAB(66,UNIT,0),U,10)
 I LR("ADJ")="R" S NEWVOL=(POOLVOL-UNITVOL)
 I LR("ADJ")="A" S NEWVOL=(POOLVOL+UNITVOL)
 S $P(^LRD(65,LRP,0),U,11)=NEWVOL
 S X=NEWVOL,Z="65,.11" D EN^LRUD
 Q

FBCHEAP ;AISC/DMK-ENTER AMOUNT PAID FROM PRICER ;7/8/2003
 ;;3.5;FEE BASIS;**38,55,61,77**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
DIC W ! S DIC="^FBAA(161.7,",DIC(0)="AEQMZ",DIC("S")="I $P(^(0),U,15)=""Y""&($G(^(""ST""))=""P"")"_$S($D(^XUSEC("FBAASUPERVISOR",DUZ)):"",1:"&($P(^(0),U,5)=DUZ)") D ^DIC
 G END:X="^"!(X=""),DIC:Y<0 S FBN=+Y,FBN(0)=Y(0)
ASK S DIR(0)="Y",DIR("A")="Would you like to reject any invoices from the pricer",DIR("B")="NO" D ^DIR K DIR G END:$D(DIRUT),REJECT:Y
DIC1 W !! S DIC="^FBAAI(",DIC(0)="AEQMZ",DIC("A")="Select Patient: ",D="D",DIC("S")="I $P(^(0),U,17)=FBN",DIC("W")="W ?25,$S($D(^DPT($P(^(0),U,4),0)):$P(^(0),U),1:"""")" D ^DIC S DIE=DIC K DIC,D G END:X="^",DIC:X=""!(Y<0)
 S (DA,FBI)=+Y,FBI(0)=Y(0) G END:'$D(^FBAAI(FBI,0))
DISP S FBLISTC="" D HOME^%ZIS,START^FBCHDI2
 W !! S FBJ=$P(FBI(0),"^",8)
 ; set FB1725 flag = true if payment for a 38 U.S.C. 1725 claim
 S FB1725=$S($P(FBI(0),U,5)["FB583":+$P($G(^FB583(+$P(FBI(0),U,5),0)),U,28),1:0)
 S DR="26;S FBPAMT=X;W:FB1725 !?2,""**Payment is for emergency treatment under 38 U.S.C. 1725."";W:FB1725&($G(FBPAMT)>0) !?2,""  70% of Pricer Amount = ""_$J(.7*FBPAMT,0,2);8;S FBK=X"
 ;S DR(1,162.5,1)="S:(FBJ-FBK)'>0 Y=24;9//^S X=$S(FBJ-FBK:FBJ-FBK,1:"""");S:'X Y=24;10;S:X'=4 Y=24;18"
 S DR(1,162.5,1)="S FBX=$$ADJ^FBUTL2(FBJ-FBK,.FBADJ,1,,,1)"
 S DR(1,162.5,2)="@20;24R;S:$$INPICD^FBCSV1(X,$G(DA),$P($G(FBIN),""^"",6)) Y=""@20"";24.5R"
 S DR(1,162.5,3)="S FBX=$$RR^FBUTL4(.FBRRMK,2)"
 S DIE("NO^")=""
 D
 . N ICDVDT S ICDVDT=$P($G(FBIN),"^",6) D ^DIE
 K DIE("NO^") G END:$D(DTOUT)
 ; file adjustment reasons
 D FILEADJ^FBCHFA(FBI_",",.FBADJ)
 ; file remittance remarks
 D FILERR^FBCHFR(FBI_",",.FBRRMK)
 D TOT S $P(FBN(0),"^",9)=FBK(1),^FBAA(161.7,FBN,0)=FBN(0)
 D CHK I $D(FBCHSW) K FBCHSW G DIC1
 I '$D(FBCHSW) S DA=FBN,(DIC,DIE)="^FBAA(161.7,",DIC(0)="LQ",DR="11////^S X=""A""",DLAYGO=161.7 D ^DIE G DIC
 G DIC1:$O(^FBAAI("AC",FBN,FBI))
END K DA,DFN,DIC,DIE,DR,FBAAOUT,FBDX,FBI,FBIN,FBJ,FBK,FBLISTC,FBN,FBPROC,FBVEN,FBVID,I,J,K,L,POP,Q,VA,VADM,X,POP,YS,VAL,ZZ,Y,FBRR,FBTYPE,FBCHSW,DIRUT,FB1725,FBPAMT
 K FBADJ,FBRRMK
 D END^FBCHDI
 Q
REJECT S FBTYPE="B9"
 W ! S DIC="^FBAAI(",DIC(0)="AEQMZ",DIC("S")="I $P(^(0),U,17)=FBN&($P(^(0),U,9)="""")",DIC("W")="W ?25,$S($D(^DPT($P(^(0),U,4),0)):$P(^(0),U),1:"""")" D ^DIC G END:X=""!(X="^"),REJECT:Y<0 S FBI=+Y,FBI(0)=Y(0)
 S FBLISTC="" D HOME^%ZIS,START^FBCHDI2
RASK S DIR(0)="F^2:40",DIR("A")="Enter reason for rejecting (2-40 characters)",DIR("?")="Enter a reason for rejecting payment from Austin Pricer" D ^DIR K DIR G END:$D(DIRUT) S FBRR=X
ASKSU S DIR(0)="Y",DIR("A")="Are you sure you want to reject this item",DIR("B")="NO" D ^DIR K DIR G END:$D(DIRUT),DIC:'Y
 S (DLAYGO,DIDEL)=162.5,DIC(0)="AEQLM"
 S (DIC,DIE)="^FBAAI(",DA=FBI,DR="13////^S X=""P"";14////^S X=FBRR;15////^S X=FBN;20///^S X=""@""" D ^DIE
 S $P(FBN(0),"^",10)=$P(FBN(0),"^",10)-1,$P(FBN(0),"^",11)=$P(FBN(0),"^",11)-1,$P(FBN(0),"^",17)="Y",^FBAA(161.7,FBN,0)=FBN(0)
RASKSU I $O(^FBAAI("AC",FBN,FBI)) S DIR(0)="Y",DIR("A")="Reject another",DIR("B")="NO" D ^DIR K DIR G END:$D(DIRUT),REJECT:Y
 I $P(^FBAA(161.7,FBN,0),"^",11)=0 S (DIC,DIE)="^FBAA(161.7,",DIC(0)="AEQM",DA=FBN,DR="11////^S X=""V"";12////^S X=DT" D ^DIE G DIC
 G END
CHK F I=0:0 S I=$O(^FBAAI("AC",FBN,I)) Q:I'>0  I $D(^FBAAI(I,0)),$P(^(0),"^",9)="" S FBCHSW=1
 Q
TOT S FBK(1)=0 F I=0:0 S I=$O(^FBAAI("AC",FBN,I)) Q:'I  S FBK(1)=FBK(1)+$P($G(^FBAAI(I,0)),"^",9)
 Q

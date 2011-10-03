PRCHPAT ;ID/RSD-CREATE ENTRY IN FILE 442 ;1/13/93  15:46
V ;;5.1;IFCAP;**46**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ;ENTER NEW PAT IN FILE 442;
 ;;**VERSION 1.52**;
 K PRCHPO Q:'$D(PRC("SITE"))!('$D(DUZ))!('$D(PRCHP("T")))  Q:'$D(^PRCD(442.5,+PRCHP("T"),0))
 S PRCHP("A")=$S($D(PRCHP("A")):PRCHP("A"),1:"PAT NUMBER") K DA,DIC,DLAYGO
 S PRCHP("S")=+$G(PRCHP("S"))
 N ERR
 ;
ENPO S DIC="^PRC(442.6,",DIC(0)="QEMZ"
 S DIC("S")="I +$P(^(0),U,1)=PRC(""SITE""),+$P(^(0),U,5)=PRCHP(""S"")"
 S:$D(PRCHP("S2")) DIC("S")=DIC("S")_PRCHP("S2")
 W !!,"ENTER A NEW ",PRCHP("A")," OR A COMMON NUMBERING SERIES"
 W !?3,PRCHP("A"),": " R X:DTIME G:X=""!(X=U) ENPOQ
 I $E(X,1)="?" S D="C" D IX^DIC G ENPO
 ;
EN2 I $L(X)<4 S D="C" D IX^DIC G ENPO:Y<0,NUM
 ; check for valid common numbering series
 I X?6AN D CHKCNS G:ERR=1 ENPO
 S X=PRC("SITE")_"-"_X,DIC(0)="LEQ" I $D(^PRC(442,"B",X)) W !?3,PRCHP("A")," ",X," already exist !" G ENPO
 ;
ENPO1 K DIC("S") S PRCHP("NEW")="",DIC="^PRC(442,",DLAYGO=442 D ^DIC G ENPO:Y<0,W3:'+$P(Y,U,3) S (DA,PRCHPO)=+Y,%DT="T",X="NOW" D ^%DT
 S $P(^PRC(442,PRCHPO,0),U,2)=PRCHP("T"),$P(^(12),U,4,5)=DUZ_U_Y,^PRC(442,"F",PRCHP("T"),DA)=""
 D DOCID^PRCHUTL
 G ENPOQ
 ;
NUM L ^PRC(442.6,+Y,0):1 G:'$T W1 S X=$P(Y,U,2),Z=$S(+$P(Y(0),U,4)<$P(Y(0),U,2):+$P(Y(0),U,2),1:+$P(Y(0),U,4)),L=$L(X)#2-3
 ;
Z G:Z>$P(Y(0),U,3) W2 S Z="000"_Z,Z=$E(Z,$L(Z)+L,$L(Z)),X=X_Z I $D(^PRC(442,"B",X)) S Z=Z+1,X=$P(Y,U,2) G Z
 W !?3,"Are you adding '",X,"' as a new ",PRCHP("A"),$C(7) S %="" D YN^DICN I %'=1 L  G ENPO
 S $P(^PRC(442.6,+Y,0),U,4)=+Z,DIC(0)="L" L
 G ENPO1
 ;
CHKCNS ;check common numbering series
 ;
 N SAVEX,CNS,Y
 S SAVEX=X,ERR=0
 S CNS=$E(X,1,3)
 S X=CNS
 S DIC(0)="X"
 S D="C"
 S DIC="^PRC(442.6,"
 D IX^DIC
 I Y>0 S X=SAVEX Q
 I Y=-1 D
 . S X=$E(CNS,1,2)
 . S DIC(0)="X"
 . S D="C"
 . S DIC="^PRC(442.6,"
 . D IX^DIC
 I Y=-1 D
 . S ERR=1
 . W !?3," Not a valid Common Numbering Series.",$C(7)
 S X=SAVEX
 Q
 ;
W1 L  W !?3," Common numbering series is being edited by another user, try later",$C(7)
 G ENPO
 ;
W2 L  W !?3,"UPPER BOUND HAS BEEN EXCEEDED FOR COMMON NUMBERING SERIES ",$P(Y,U,2),$C(7)
 G ENPO
 ;
W3 W "   PAT Number already exist, please try again ",$C(7)
 G ENPO
 ;
ENPOQ K DIC,DLAYGO,%DT,PRCHP
 Q
 ;
EN1 ;INPUT TRANSFORM FOR APPROPRIATION IN FILE 430
 S Z0=DA,Z1=DA(1),Z2=$P(^PRCA(430,Z1,2,Z0,0),U,1),DIC("S")="I $P(^(0),U,5)]"""""
 S DIC="^PRCD(420.3,",DIC(0)="MEZQ",D="C" D IX^DIC K X G:Y<0 EN1Q S $P(^PRCA(430,Z1,2,Z0,0),U,5)=+Y I $P(Y(0),U,5)[" " S X=$P(Y(0),U,5) G EN1Q
 S PRC("APP")=$P(Y(0),U,3),(PRC("FY"),PRC("FYI"))=Z2 D ^PRCFY S X=PRC("APP")
EN1Q S DA=Z0,DA(1)=Z1 K PRC("APP"),PRC("FYI"),Z0,Z1,Z2,DIC D EN4
 Q
 ;
EN3 ;LOOK UP PO IN FILE 442
 K PRCHPO,PRCHNEW,DA,DIC,D0,DQ Q:'$D(PRC("SITE"))  S DIC="^PRC(442,",DIC(0)="QEAMZ"
 S D=$S($G(PRCHPC)=1:"APCS",$G(PRCHPC)=2:"APCP",$G(PRCHDELV):"APCD",1:"C")
 S DIC("A")=$S($D(PRCHP("A")):PRCHP("A"),1:"PURCHASE ORDER: "),DIC("S")="I +$P(^(0),U,1)=PRC(""SITE"")"_$S($D(PRCHP("S")):","_PRCHP("S"),1:"")
 ;W !! D IX^DIC K DIC,PRCHP S X="" Q:+Y<0  S (PRCHPO,DA)=+Y,X=$S($D(^PRC(442,DA,7)):$S($D(^PRCD(442.3,+^(7),0)):$P(^(0),U,2),1:""),1:"")
 W !! D IX^DIC K DIC,PRCHP S X="" Q:+Y<0  S (PRCHPO,DA)=+Y,X=$P($G(^PRCD(442.3,+$G(^PRC(442,DA,7)),0)),U,2) S:X=0 X=""
 Q
 ;
EN4 ;set appropriation to the flat field in the 430,AR file.
 Q:'$D(X)  S Z0=X S:$E(Z0,3)?1N Z0=$E(Z0,1,2)_" "_$E(Z0,4,7) S $P(^PRCA(430,DA(1),0),U,18)=Z0 K Z0
 Q

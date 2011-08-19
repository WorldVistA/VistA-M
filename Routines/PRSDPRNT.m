PRSDPRNT ;HISC/GWB-FILEMAN PRINT AND SEARCH CALLS ;6/14/93  09:34
 ;;4.0;PAID;;Sep 21, 1995
PRNT05 ;Personnel Print Option
 S PRSDUZ=DUZ(0),ASKFLG="P"
PRNT05A S DUZ(0)=DUZ(0)_"P",DICS="I $D(^DD(450,Y,8)),^DD(450,Y,8)[""P"""
 D ASK G:%=-1 EXIT
 S L=1,DIC=450 D EN1^DIP
 I $D(X),(X=U)!(X="") G EXIT
 W !! G PRNT05A
SRCH05 ;Personnel Search Option
 S PRSDUZ=DUZ(0),ASKFLG="S"
SRCH05A S DUZ(0)=DUZ(0)_"P",DICS="I $D(^DD(450,Y,8)),^DD(450,Y,8)[""P"""
 D ASK G:%=-1 EXIT
 S DIC=450 D EN^DIS
 I $D(X),(X=U)!(X="") G EXIT
 W !! G SRCH05A
PRNT04 ;Fiscal Print Option
 S PRSDUZ=DUZ(0),ASKFLG="P"
PRNT04A S DIC="^DIC(",DIC(0)="AQEI",DIC("B")=450
 S DIC("S")="I (Y=450)!(Y=458)!(Y=459)" D ^DIC
 G:Y=-1 EXIT
 I +Y=450 S DUZ(0)=DUZ(0)_"F",DICS="I $D(^DD(450,Y,8)),^DD(450,Y,8)[""F""" D ASK G:%=-1 EXIT
 S L=1,DIC=+Y D EN1^DIP
 I $D(X),(X=U)!(X="") G EXIT
 W !! G PRNT04A
SRCH04 ;Fiscal Search Option
 S PRSDUZ=DUZ(0),ASKFLG="S"
SRCH04A S DIC="^DIC(",DIC(0)="AQEI",DIC("B")=450
 S DIC("S")="I (Y=450)!(Y=458)!(Y=459)" D ^DIC
 G:Y=-1 EXIT
 I +Y=450 S DUZ(0)=DUZ(0)_"F",DICS="I $D(^DD(450,Y,8)),^DD(450,Y,8)[""F""" D ASK G:%=-1 EXIT
 S DIC=+Y D EN^DIS
 I $D(X),(X=U)!(X="") G EXIT
 W !! G SRCH04A
EXIT S DUZ(0)=PRSDUZ
 K %,ASKFLG,DIC,DICS,L,PRSDUZ,Y,DIS(0) W @IOF Q
ASK S %=2 W !!,"Include separated employees" D YN^DICN
 Q:%=-1
 I %=0 W !!,"Answer  NO if you wish your output to EXCLUDE separated employees.",!,"Answer YES if you wish your output to INCLUDE separated employees." G ASK
 I %=2,ASKFLG="P" S DIS(1)="I $D(^PRSPC(D0,1)),$P(^PRSPC(D0,1),U,33)=""N"""
 I %=2,ASKFLG="S" S DIS(0)="I $D(^PRSPC(D0,1)),$P(^PRSPC(D0,1),U,33)=""N"""
 W:%=1 !!,"Separated employees will be included.",!
 W:%=2 !!,"Separated employees will not be included.",!
 Q

ENLIB2 ;(WASH ISC)/DH-Package Utilities ;1/10/2001
 ;;7.0;ENGINEERING;**21,35,68**;Aug 17, 1993
PO ;Called when PO# entered into Equip File
 ;X=PO# and DA is Equip IEN
 S ENPO=X,ENPO(0)=0 I $D(^PRC(442,"B",ENPO)) S ENPO(0)=$O(^(ENPO,0))
 E  I $D(^PRC(442,"C",ENPO)) S ENPO(0)=$O(^(ENPO,0))
 I ENPO(0)'>0!('$D(^PRC(442,ENPO(0),0))) K ENPO Q
 S ENPO("FCP")=$P(^PRC(442,ENPO(0),0),U,3),ENPO("CC")=$P(^(0),U,5),ENPO("SUB")=$P(^(0),U,6)
 S (ENPO("VEN"),ENPO("SRV"),ENPO("SRC"))=""
 I $D(^PRC(442,ENPO(0),1)) S ENPO("VEN")=$P(^(1),U),ENPO("SRV")=$P(^(1),U,2),ENPO("SRC")=$P(^(1),U,7)
 I '$D(^ENG(6914,DA,8)) S ^ENG(6914,DA,8)="^^"_ENPO("FCP")_"^"_ENPO("CC")_"^"_ENPO("SUB") G PO1
 I $P(^ENG(6914,DA,8),U,3)="" S $P(^(8),U,3)=ENPO("FCP")
 I $P(^ENG(6914,DA,8),U,4)="" S $P(^(8),U,4)=ENPO("CC")
 I $P(^ENG(6914,DA,8),U,5)="" S $P(^(8),U,5)=ENPO("SUB")
PO1 I ENPO("VEN")]"" S:'$D(^ENG(6914,DA,2)) ^ENG(6914,DA,2)=ENPO("VEN") I $P(^ENG(6914,DA,2),U)="" S $P(^(2),U)=ENPO("VEN")
 I ENPO("SRV")]"" D SRV
 I ENPO("SRC")]"" S:'$D(^ENG(6914,DA,2)) $P(^ENG(6914,DA,2),U,14)=ENPO("SRC") I $P(^ENG(6914,DA,2),U,14)="" S $P(^(2),U,14)=ENPO("SRC")
EXIT K ENPO
 Q
 ;
ACC ;Toggle WO STATUS on basis of 2237
 ;Expects DA based on Work Order File
 I $D(^ENG(6920,DA,5)),$P(^(5),U,2)]"" Q
 S ENX="" I $D(^ENG(6920,DA,4)) S ENX=$P(^(4),U,2)
 I ENX'>0 K ENX Q
 I $D(^PRCS(410,ENX,9)),$P(^(9),U,3)]"" K ENX Q
 S (ENX(0),ENX(1))="" I $D(^PRCS(410,ENX,"IT")) S ENX(0)=$O(^PRCS(410,ENX,"IT",0)) S:ENX(0)>0 ENX(1)=$E($P(^PRCS(410,ENX,"IT",ENX(0),0),U,4),1,2)
 S $P(^ENG(6920,DA,4),U,3)=$S(ENX(1)=25:4,1:3)
 K ENX
 Q
 ;
ACCX ;  IFCAP entry point from File 410
 ;    DA => IEN to File 6914
 ;    +X => IEN to Work Order File
 Q:'$D(^ENG(6920,+X,0))  ; in case W.O. deleted and file 410 re-indexed
 N ENDA S ENDA=DA
 N DA S DA=+X,$P(^ENG(6920,DA,4),U,2)=ENDA
 D ACC
 Q
 ;
POWO ;  IFCAP entry point from File 442
 Q  ;May be activated in conjunction with a future IFCAP patch
 ;
SRV ;Service pointer
 I $D(^ENG(6914,DA,3)),$P(^(3),U,2)]"" Q  ;Don't overwrite
 S $P(^ENG(6914,DA,3),U,2)=ENPO("SRV"),^ENG(6914,"AC",ENPO("SRV"),DA)=""
 Q
 ;
CMRNOM ;Subheader on CMR
 Q:'$D(D0)  I '$D(ENCMR) S ENCMR=$S($D(^ENG(6914,D0,2)):$P(^(2),U,9),1:0) S:ENCMR="" ENCMR=0 I $D(^ENG(6914.1,ENCMR,0)) S ENCMR(0)=$P(^(0),U,5) I ENCMR(0)]"",$D(^DIC(49,ENCMR(0),0)) W !,?13,$P(^(0),U)," SERVICE" D CMRRO W !!
 I $D(^ENG(6914,D0,2)),$P(^(2),U,9)'=ENCMR S ENCMR=$P(^(2),U,9) S:ENCMR="" ENCMR=0 I $D(^ENG(6914.1,ENCMR,0)) S ENCMR(0)=$P(^(0),U,5) I ENCMR(0)]"",$D(^DIC(49,ENCMR(0),0)) W !,?13,$P(^(0),U)," SERVICE" D CMRRO W !!
 I '$D(ENNOMEN) S ENNOMEN=$S($D(^ENG(6914,D0,2)):$P(^(2),U,8),1:0) S:ENNOMEN="" ENNOMEN=0 D:$D(^ENCSN(6917,ENNOMEN,0)) CMRPRNT Q
 I $D(^ENG(6914,D0,2)),$P(^(2),U,8)=ENNOMEN Q
 I '$D(^ENG(6914,D0,2)) K ENNOMEN Q
 S ENNOMEN=$S($P(^ENG(6914,D0,2),U,8)]"":$P(^(2),U,8),1:0) D:$D(^ENCSN(6917,ENNOMEN,0)) CMRPRNT
 Q
CMRPRNT N X,DIWL,DIWR,DIWF K ^UTILITY($J,"W") S DIWL=1,DIWR=IOM,DIWF="W"
 W !!,"CATEGORY STOCK NUMBER: ",$P(^ENCSN(6917,ENNOMEN,0),U) F ENNX=0:0 S ENNX=$O(^ENCSN(6917,ENNOMEN,1,ENNX)) Q:ENNX'>0  I $D(^(ENNX,0)) S X=^(0) D ^DIWP
 D ^DIWW K ENNX
 Q
CMRRO ; CMR Responsible Official
 N ENRO,DIERR
 S ENRO=$$GET1^DIQ(6914.1,ENCMR,1)
 I ENRO]"" W !,?13,"Responsible Official: ",ENRO
 Q
 ;
WA ;Count the number of WORK ACTIONS
 ;called by the input transform of File 6920 Subfile 6920.035 Field .01
 N I,J,COUNT S COUNT=0
 F I=0:0 S I=$O(^ENG(6920,DA,8,I)) Q:I'>0  S COUNT=COUNT+1,J=$P(^(I,0),U) Q:J=X
 Q:COUNT<4  Q:J=X
 D EN^DDIOL("  Can't have more than four WORK ACTIONS.")
 K X
 Q
 ;
ASN ;Count the number of ALTERNATE STATION NUMBERS
 ;called by the input transform of File 6910 Subfile 6910.012 Field .01
 N I,J,COUNT S (COUNT,I)=0
 F  S I=$O(^DIC(6910,DA,3,I)) Q:'I  S COUNT=COUNT+1,J=$P(^(I,0),U) Q:J=X
 Q:COUNT<30  Q:J=X
 D EN^DDIOL("  Can't have more than thirty (30) ALTERNATE STATION NUMBERS.")
 K X
 Q
 ;ENLIB2

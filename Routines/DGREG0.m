DGREG0 ;ALB/JDS/AEG-REGISTER A PATIENT, CONT. ;03 OCT 85
 ;;5.3;Registration;**108,121,91,149,326,624**;Aug 13, 1993
REFILE F I=0,1,2,3 S A(I)="" S:$D(^DPT(DFN,"DIS",DFN1,I)) A(I)=^(I)
 S DIV=$S('$D(^DG(40.8,+$P(A(0),"^",4),0)):1,1:$P(A(0),"^",4))
 ;I $D(^DIC(195.4,1,"UP")) I ^("UP") S $P(DGFC,U,1)=DIV D ADM^RTQ3
 S X=+$P(A(0),"^",4),X=$S($D(^DG(40.8,X,"DEV")):^("DEV"),1:"1^1^1") F I=1:1:3 S:'$D(DGIO($P("10^PRF^RT","^",I))) DGIO($P("10^PRF^RT","^",I))=$S($P(X,U,I)]"":$P(X,U,I),1:1)
 S DGIO("HS")=DGIO("PRF") ;HS DEVICE=PROFILE DEVICE
 F I=10,"PRF","RT" I $D(DGIO(I)) S DGHIO(I)=DGIO(I)
 F I=1010,1010.176,1010.18,1010.17 S B(I)="" S:$D(^DPT(DFN,I)) B(I)=^(I)
 S INTL="",INTL=$$GET1^DIQ(200,+$P(A(0),"^",5),1,"I") S:INTL="" INTL=0
 S I=1010,B(I)=$P(A(0),"^",3)_"^"_$P(B(I)_"^^^^^^^^^","^",2,8)_"^"_(+A(0))_"^"_INTL_"^"_$P(B(I),"^",11,99)
 S:A(1)'="" B(1010.18)=A(1) S I1=$P(A(2),"^",6),I1=$P($S($D(^DIC(36,+I1,0)):^(0),1:""),"^",1),I=1010.176,B(I)=$P(A(2)_"^^^^","^",2,3)_"^"_$P(A(2),"^",7)_"^"_$E(I1,1,45)_"^"_$P(B(I),5,99)
 S X=3,X1=1,X2=2
MOVE S S(X1)=$P(A(X),"^",X2),S(X1+1)=$P(A(X),"^",X2+1),S(X1+2)=$P(A(X),"^",X2+2),S(X1+3)=$P(A(X),"^",X2+3)_$S($D(^DIC(5,+$P(A(X),"^",X2+4),0)):", "_$P(^(0),"^",2),1:"")_$S($P(A(X),"^",X2+5)'="":"  ",1:"")_$P(A(X),"^",X2+5)
 S:S(X1+2)="" S(X1+2)=S(X1+3),S(X1+3)="" S:S(X1+1)="" S(X1+1)=S(X1+2),S(X1+2)=S(X1+3),S(X1+3)="" S:S(X1)="" S(X1)=S(X1+1),S(X1+1)=S(X1+2),S(X1+2)=S(X1+3),S(X1+3)=""
 S I1=S(1) F I=2:1:4 S:S(I)'="" I1=I1_"/"_S(I)
 S:$P(A(3),"^",8)'="" I1=I1_" "_$P(A(3),"^",8) S I1=$E(I1,1,45),I=1010.17,B(I)=$P(B(I)_"^^^","^",1,3)_"^"_$P(A(3),"^",1)_"^"_I1_"^"_$P(B(I),"^",6,99)
 F I=1010,1010.176,1010.17,1010.18 S:B(I)'=""&(B(I)'?1"^"."^") ^DPT(DFN,I)=B(I)
 K B,S,I,I1,L,L1,L2,LL,LL1,LL2,DR,DEF
 D MT
 D CP
 D EN1^DGEN(DFN) ;enrollment
W1 F I=10,"PRF","RT","HS" I $D(DGHIO(I)) S DGIO(I)=DGHIO(I)
 K DGHIO
 G ^DGREG00
Q K:'$D(DGASKDEV) DGIO
Q1 ;If Send HL7 V2.3 messaging flag is set to SEND or SUSPEND and
 ;If user exits Register a Patient option or 10-10t Registration
 ;having edited some fields but not completing the Registration
 ;then send an A08 message
 I $P($$SEND^VAFHUTL(),"^",2) D HL7A08^VAFCDD01
 ;
QE K %,%DT,A,B,ANS,APD,B,CURR,DA,DB,DE,DEF,DGCLPR,DGDAY,DGDFN,DGE,DGERR,DGL,DGLL,DFMD,DGNEW,DGO,DIC,DIE,DINUM,DOW,DP,DR,I,I1,IOZBK,IOZFO,L,L1,L2,LL,LL1,LL2,MDCARD,PARA,PRF,RT,S,SC,SEEN
 K VAFHMRG,VAFHBEF,VAFHFLG,VET,X,X1,X2,Y,Y1,ZTSK,D0,D1,DIV,DLAYGO,J,PGM,Z
 G A^DGREG:('$D(DGRPFEE)&('$D(RGMPI))) Q
 ;
DT G DT^DIQ:Y
 Q
SSD Q:'$D(^DPT(DA(1),.321))  S DGZ1=0 F I=1:1:3 I $P(^DPT(DA(1),.321),"^",I)["Y" S DGZ1=1 Q
 I 'DGZ1 K DGZ1 Q
 S:'$D(^DPT("ASDPSD","B",SDIV,(9999999-DA)\1,DA(1))) ^(DA(1))=0 S:'$D(^DPT("ASDPSD","C",SDIV,SDX,9999999-DA,DA(1))) ^(DA(1))="E"
 K DGZ1 Q
SSDK I $D(^DPT("ASDPSD","C",SDIV,SDX,(9999999-DA),DA(1))) K ^(DA(1))
 Q
 ;
CP ;If not (autoexempt or MTested) & no CP test this year then
 ;prompt for add/edit cp test
 N DIV,DGIB,DGIBDT,DGX,X,DIRUT,DTOUT
 G:'$P($G(^DG(43,1,0)),U,41) QTCP ;USE CP FLAG
 S DGIBDT=$S($D(DFN1):9999999-DFN1,1:DT)
 D EN^DGMTCOR
 I +$G(DGNOCOPF) S DGMTCOR=0
 I DGMTCOR D THRESH^DGMTCOU1(DGIBDT) D EDT^DGMTCOU(DFN,DT)
 K DGNOCOPF
QTCP Q
MT ;Check if user requires a means test.  Ask user if s/he wants to
 ;proceed if one is required.
 N DGREQF,DIV
 D EN^DGMTR
 I DGREQF D MTDT:APD\1<DT,EDT^DGMTU(DFN,DT):$P($$MTS^DGMTU(DFN),U,2)="R"
 Q
 ;
MTDT ;Date of Test should be the same as the Registration Date
 N DA,DGMT,DGMTA,DGMTACT,DGMTDT,DGMTI,DGMTINF,DGMTP,DGMTYPT,DIE,DR
 S DGMT=$$LST^DGMTU(DFN) G MTDTQ:$P(DGMT,"^",2)'=DT
 S DGMTI=+DGMT,DGMTDT=APD\1,DGMTYPT=1
 S DGMTACT="STA" D PRIOR^DGMTEVT
 S DIE="^DGMT(408.31,",DA=DGMTI,DR=".01///^S X="_DGMTDT D ^DIE
 D AFTER^DGMTEVT S DGMTINF=1 D EN^DGMTEVT
MTDTQ Q

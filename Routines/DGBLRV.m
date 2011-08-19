DGBLRV ;ALB/BOK - PATIENT ADMISSION FORM/BILL REVIEW ; 18 SEP 86  11:00
 ;;5.3;Registration;**26,570**;Aug 13, 1993
 ;
 D LO^DGUTL K ^UTILITY($J)
START S DIC="^DPT(",DIC(0)="AEQMZ" D ^DIC G QUIT:Y'>0 S DFN=+Y I '$D(^DGPM("ATID1",DFN)) W !,"No admissions on file, will check scheduled admissions",! G SCHAD
 S DIC("S")="I $P(^(0),U,2)=1" D EN^DGPMUTL K DIC I Y'>0 W !,"Since an admission was not chosen, scheduled admissions for this patient will be checked",! G SCHAD
 S DGPMDA=+Y G IO
SCHAD I '$D(^DGS(41.1,"B",DFN)) W !,"No scheduled admissions on file" G QUIT
 S DGPMDA=0
IO K DIS(0) S DGPGM="RET^DGBLRV",DGVAR="DFN^DGPMDA" W !!,"This report requires 132 column output",! D ZIS^DGUTQ G QUIT:POP U IO S X=132 X ^%ZOSF("RM")
RET S:'$D(DGPMDA) DGPMDA=0 K DGADT,DGADX,DGINAD,DGSDT,DGSDX,I S DGINFO=^DPT(DFN,0) D PID^VADPT6
 I DGPMDA S DGI=$S($D(^DGPM(DGPMDA,0)):^(0),1:"") Q:DGI']""  S Y=$P(DGI,"^",1) D D^DIQ S DGADT=Y,DGADX=$P(DGI,"^",10),DGWD=$P(DGI,"^",6) G INS
 S DGI=$O(^DGS(41.1,"B",DFN,0)),DGI=^DGS(41.1,DGI,0),DGSDT=$P(DGI,U,2) S Y=DGSDT D D^DIQ S DGSDT=Y,DGSDX=$P(DGI,U,4),DGWD=$P(DGI,U,8)
 ;
INS ; -- new insurance logic, modified for IBBAPI insurance call, DG*570
 N DGIBINS,DGIBDT,DGDATA,DGIB,DGX
 S DGIBDT=$S($D(DGPMDA):+$G(^DGPM(DGPMDA,0)),$G(DGSDT):DGSDT,1:DT)
 S DGIBDT=$P(DGIBDT,".")
 S DGIB=$$INSUR^IBBAPI(DFN,DGIBDT,"R",.DGDATA,"*")
 S DGX="DGDATA(""IBBAPI"",""INSUR"")" M DGIBINS=@DGX
 S P=1,I=0
 I DGIB F  S I=$O(DGIBINS(I)) Q:'I  D
 . I DGIBINS(I,11)>DT!(DGIBINS(I,11)="") D
 . . K DGINAD D:DGI ADDR
 . . S I(P)=+DGIBINS(I,1)_U_DGIBINS(I,14)_U
 . . N DGGRP
 . . S DGGRP=DGIBINS(I,18) ; Group Policy Number
 . . S I(P)=I(P)_$G(DGGRP)_U
 . . S I(P)=I(P)_$P(DGIBINS(I,8),U,2)_U_$S($D(DGINAD):DGINAD,1:"NO ADDRESS ON FILE")
 . . S P=P+1
 ;
PRT K DIC S DIC(0)="M",X="DGBILLREVIEW",DIC="^DIC(47," D ^DIC G QUIT:Y'>0 S DGY=+Y I '$D(DIS(0)) I $$FIRST^DGUTL G Q
 S P=0 F DGLN=0:0 S DGLN=$O(^DIC(47,+DGY,1,DGLN)) Q:'DGLN  S J=^(DGLN,0),X1="" W ! F K=1:1 W $E($P(J,"{}",K),$S(K=1:1,X1']"":1,1:$L(X)+1),999) S X1=$P(J,"{",K+1),P=$S(DGLN<9:1,DGLN<14:2,1:3) Q:X1']""  D CKLN
Q W ! Q:$D(DIS(0))  I '$D(DGOPT) D CLOSE^DGUTQ
QUIT D ENDREP^DGUTL I '$D(DGPMA) K DFN,DGPMDA
 K DGADT,DGADX,DGI,DGIMULT,DGINAD,DGINFO,DGINS,DGLN,DGPGM,DGSDT,DGSDX,DGVAR,DGWD,DGY,DIC,I,J,K,P,X,X1,L,VA,Y,POP Q
 Q
 ;
CKLN S L=$S(DGLN>9&(DGLN<14):(DGLN-5),DGLN>14&(DGLN<19):(DGLN-10),1:DGLN)_K D @L Q
ADDR ; 
 S DGINAD=$S(DGIBINS(I,2)]"":DGIBINS(I,2)_", ",1:"")_$S(DGIBINS(I,2)]"":DGIBINS(I,3)_", ",1:"")_$S(DGIBINS(I,4)]"":$P(DGIBINS(I,4),U,2)_", ",1:"")_$S(DGIBINS(I,5)]"":DGIBINS(I,5)_", ",1:"")
 Q
21 S Y=DT D DT^DIQ Q
31 W $P(DGINFO,U,1) Q
32 W VA("PID") Q
51 W $S($D(DGIBINS(P)):$P(DGIBINS(P,1),U,2),1:"") Q
61 W $S($D(I(P)):$P(I(P),U,5),1:"") Q
71 W $S($D(DGIBINS(P)):DGIBINS(P,6),1:"") Q
72 W $S($D(I(P)):$P(I(P),U,2),1:"") Q
73 W $S($D(I(P)):$P(I(P),U,3),1:"") Q
81 W " " Q  ; Pre-certification phone# not currently available in API
82 W " " Q  ; Billing phone# not currently available in API
201 W $S($D(DGADX):DGADX,$D(DGSDX):DGSDX,1:"") Q
202 S X=$S(DGWD:DGWD,1:"-") W $S($D(^DIC(42,X,0)):$P(^(0),U,1),1:"") Q
211 W $S($D(DGSDT):DGSDT,1:"") Q
212 W $S($D(DGADT):DGADT,1:"") Q
 ;
EN1 S DIC="^DGPM(",BY="@.01",L=0,FLDS="[DGPMBLRV]",DHD="@"
 S DIS(0)="S DFN=$P(^DGPM(D0,0),U,3) I $P(^(0),""^"",2)=1,$D(^DPT(DFN,""VET"")),($P(^(""VET""),""^"",1)=""Y""),$$INSUR^IBBAPI(DFN,"""",""A"")"
 D EN1^DIP,QUIT K BY,DHD,DIC,DIS,FLDS,I Q
 ;
CK ;check logic to see if 3rd party review is asked
 ;***if this logic is altered, also change line EN1+1 in DIS(0)***
 I $S('$$INSUR^IBBAPI(DFN,"","A"):1,'$D(^DPT(DFN,"VET")):1,^("VET")'="Y":1,1:0) Q
ASK ;print TPR?
 W !,"PRINT THIRD PARTY REVIEW" S %=$S($D(DGDEF):DGDEF,1:2) D YN^DICN
 I %=2!(%<0) Q
 I '% W !!,"CHOOSE FROM",!?4,"YES - If you wish to print Third Party Review Sheet",!?4,"NO  - If you don't want to print Third Party Review Sheet",! G ASK
 Q:$D(DGNOQ)  ;quit if from 10/10 w/out registration
 K DGPTPR S DGPGM="RET^DGBLRV",DGVAR="DFN"_$S($D(DGPMDA):"^DGPMDA",1:"") K DIS D ZIS^DGUTQ I 'POP U IO D RET^DGBLRV
 K DGPGM,DGVAR Q

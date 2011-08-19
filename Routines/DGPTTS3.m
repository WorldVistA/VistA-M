DGPTTS3 ;ALB/MJK - Physical Mvt ; 11/30/06 8:46am
 ;;5.3;Registration;**26,61,549,729**;Aug 13, 1993;Build 59
 ;
EN ; -- entry used to update PTF rec
 ;  input: PTF := PTF#
 ;         DFN := pt#
 ;      DGPMCA := adm mvt #
 ;        DGDT := d/c date
 ;
 S DGPTIFN=PTF
 D FDT^DGPTUTL G ENQ:$S(DGDT:DGDT,1:DT)<Y
 I '$D(ZTQUEUED),'$G(DGQUIET) W !,"Now updating ward MPCR information..."
 S (DGBEG,DGSTART,DGLAST)=Y-.0000001
 S X=Y I $E(X,6,7)="00" S X1=X,X2=-1 D C^%DTC
 S DGPFYDT=$P(X,".")_".2359" ; last date/time in previous FY
 D KILL
 N DGRT S DGRT="^DGPM(""APCA"",DFN,DGPMCA)"
 ;
 ; -- build ward table
 S DGDATA="",DGADM0=$S($D(^DGPM(DGPMCA,0)):^(0),1:"")
 I DGADM0,DGADM0'>DGSTART S DGT=DGPFYDT D ^DGINPW I +DG1 S $P(DGXFR0,U,4)=+DG1 D TABLE
 I DGADM0,DGADM0>DGSTART S $P(DGXFR0,U,4)=$P(DGADM0,U,6),DGBEG=+DGADM0 D TABLE
 F DGXDT=DGSTART:0 S DGXDT=$O(@DGRT@(DGXDT)) Q:'DGXDT  F DGMVT=0:0 S DGMVT=$O(@DGRT@(DGXDT,DGMVT)) Q:'DGMVT  I $D(^DGPM(DGMVT,0)) S X=^(0) I $P(X,U,2)=2 S DGXFR0=$P(X,U,18)_"^^^"_$P(X,U,6) D TABLE
 G ENQ:DGDATA=""
 S DGEND=$S(DGDT:DGDT,1:DT) D DAYS S DGXDT=($S(DGDT:DGDT,1:"")),$P(DGDATA,U,3,4)=LEAVE_U_PASS,$P(DGDATA,U,7)=1 D CREATE
 ;
ENQ I $D(DGSACNT),DGSACNT>25 D FLCHK
 S L=DGPTIFN
 K DGRT,DGADM0,DG1,DGDATA,DGMDT,DGPTIFN,DGXFR0,DGXDT,DGM,X,DGM0,LEAVE,PASS,DGBEG,DGEND,DGSTART,DGWD,DGCDR,DGSP,DGADM0,DGPFYDT,DGT,DGA1,DGSAFTF,DGSACNT,DGWI,DGI
 Q
 ;
TABLE ; -- setup 535 node data
 ;  DGDATA := 1:ward cdr ^ 2:ward specialty  ^ 3:leave days ^ 4:pass days ^ ^ 6:ward ^ ^ ^ ^ 10:mvt date/time
 ;
 S DGWD=+$P(DGXFR0,U,4)
 G TABLEQ:'$D(^DIC(42,DGWD,0)) S DGSP=+$P(^(0),U,12)
 G TABLEQ:'$D(^DIC(42.4,DGSP,0)) S DGCDR=$P(^(0),U,6)
 ; -- create MPCR mvt if ward mpcr changes
 I DGDATA]"",+DGDATA'=DGCDR S DGEND=DGXDT D DAYS S $P(DGDATA,U,3,4)=LEAVE_U_PASS D CREATE S DGDATA=DGCDR_"^"_DGSP_"^^^^"_DGWD,DGLAST=DGBEG,DGBEG=DGEND
 I DGDATA="",DGCDR]"" S DGDATA=DGCDR_"^"_DGSP_"^^^^"_DGWD
TABLEQ Q
 ;
CREATE ; -- create MPCR mvt
 L +^DGPT(DGPTIFN,535) S Y=^DGPT(DGPTIFN,535,0),I=$P(Y,U,3)
L S I=I+1 G L:$D(^DGPT(DGPTIFN,535,I))
 S $P(^DGPT(DGPTIFN,535,0),U,3,4)=I_U_($P(Y,U,4)+1)
 S X=DGDATA,^DGPT(DGPTIFN,535,I,0)=I_U_$P(X,U,2)_U_$P(X,U,3)_U_$P(X,U,4)_"^^"_$P(X,U,6)_"^"_$P(X,U,7)_"^^^"_DGXDT L -^DGPT(DGPTIFN,535)
 K DA S DA=I,DA(1)=DGPTIFN,DIK="^DGPT("_DGPTIFN_",535," D IX1^DIK
CREATEQ S DGSACNT=I
 K DA,I,DIK Q
 ;
KILL ; -- clean out ward mvts
 F DGWI=0:0 S DGWI=$O(^DGPT(DGPTIFN,535,DGWI)) Q:'DGWI  S:$P(^(DGWI,0),U,17)="n" DGSAFTF(DGWI)=^(0) K DA S DA(1)=DGPTIFN,DA=DGWI,DIK="^DGPT("_DGPTIFN_",535," D ^DIK K DA
 S:'$D(^DGPT(DGPTIFN,535,0)) ^(0)="^45.0535^"
 K DIK,DGWI,DA Q
 ;
T ; -- test tag
 S DIC(0)="AEMQZ",DIC=45,DIC("S")="I $P(^(0),U,11)=1" D ^DIC K DIC Q:Y<0
PTF S PTF=+Y,DGDT=$S($D(^DGPT(L,70)):+^(70),1:0),DFN=+Y(0) D PM^DGPTUTL,EN:DGPMCA
 Q
 ;
DAYS ; -- calc leave and pass days from DGBEG to DGEND
 ; -- if last 501 date is after last 535 date then
 ;    calc from last 535 mvt d/t to last 501 mvt d/t
 ;
 ;      535          501    501        535
 ;       |------------|------|----------|
 ;        <<<<<<<<<<< total >>>>>>>>>>
 ;        <<<<<<< diff >>>>>>+<< pass >>
 ;
 S (PASS,LEAVE,DGDIFP,DGDIFL)=0 D MVT
 I DGMDT>DGBEG S DGE=DGEND,DGEND=DGMDT D DAYS0 S DGDIFL=LEAVE,DGDIFP=PASS,DGEND=DGE
 ; -- calc from last 535 mvt d/t to new 535 mvt d/t
 S (PASS,LEAVE)=0 D DAYS0
 ; -- substract 'diff' from 'total'
 S PASS=PASS-DGDIFP,LEAVE=LEAVE-DGDIFL
 K DGDIFL,DGDIFP,DGE Q
 ;
DAYS0 ;
 N DGMVT
 F DGMVTDT=(DGBEG-.0000001):0 S DGMVTDT=$O(@DGRT@(DGMVTDT)) Q:'DGMVTDT  F DGMVT=0:0 S DGMVT=$O(@DGRT@(DGMVTDT,DGMVT)) Q:'DGMVT  I $D(^DGPM(DGMVT,0)),$P(^(0),U,2)=2 S C=$P(^(0),U,18) I C=1!(C=2)!(C=3) D NEXT,DAYS1
 K DGMVTDT Q
 ;
DAYS1 S I=DGMVTDT,X2=$S(I<DGBEG:DGBEG,1:I),X1=$S(Y>DGBEG&(Y'>DGEND):Y,Y>DGEND!('Y):DGEND,1:X2)
 I X1>X2 D ^%DTC S:C=1 PASS=PASS+X S:C=2 LEAVE=LEAVE+X
 K C,X,Y,X1,X2,I
 Q
 ;
NEXT ; -- find next x-ref date
 N DGMVT
 F Y=DGMVTDT:0 S Y=$O(@DGRT@(Y)) Q:'Y  F DGMVT=0:0 S DGMVT=$O(@DGRT@(Y,DGMVT)) Q:'DGMVT  I $D(^DGPM(DGMVT,0)),$P(^(0),U,2)=2 G NEXTQ
NEXTQ Q
 ;
MVT ; -- find last 501 mvt d/t since the last 535 mvt d/t
 ;    and before the new 535 mvt d/t
 S DGMDT=""
 F M=DGLAST:0 S M=$O(^DGPT(DGPTIFN,"M","AM",M)) Q:'M!(M>DGEND)  S DGMDT=M
 K M Q
 ;
FLCHK ; -- check if more than 25 535s, then re-set x-mit flags
 I '$D(DGSACNT) G FLQ
 I DGSACNT<25 G FLQ
 S DGF1=0
 F DGWI=0:0 S DGWI=$O(DGSAFTF(DGWI)) Q:'DGWI!('$D(^DGPT(DGPTIFN,535,+DGWI,0)))  F DGI=1,2,10,16 S:$P(^(0),U,DGI)'=$P(DGSAFTF(DGWI),U,DGI) DGF1=1
 I 'DGF1,'DGWI F DGWI=0:0 S DGWI=$O(DGSAFTF(DGWI)) Q:'DGWI  S DA=DGWI,DA(1)=DGPTIFN,DIE="^DGPT("_DGPTIFN_",535,",DR="17///n" D ^DIE
FLQ K DGI,DGF1,DGWI,DGSAFTF,DGSACNT,DR,DA,DIE
 Q
 ;

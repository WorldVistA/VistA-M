DGPTC1 ;ALN/MJK - Census Record Processing; JAN 27, 2005
 ;;5.3;Registration;**37,413,643,701**;Aug 13, 1993
 ;
CEN ; -- determine if PTF rec is current Census rec
 ; input: PTF   := ptf rec #
 ;     DGPMCA   := corres. adm           (non-fee)
 ;     DGPMAN   := 0th node of corrs adm     "
 ;output: DGCI  := census rec #
 ;        DGCST := census rec status
 ;        DGCN  := census date entry to 45.86
 ;
 K DGCST,DGCI,DGCN,DGCN0,DGFEE
 S DGFEE=0
 G CENQ:'$D(^DGPT(PTF,0)) N DFN S DGPTF0=^(0),DFN=+DGPTF0
 ;G CENQ:$P(DGPTF0,U,4)
 D CEN^DGPTUTL I DGCN0=""!(DT'>DGCN0) K DGCN G CENQ
 ;I $P(DGPTF0,U,4) D FEE G CENQ  ;DG*701 reposition line 
 S DGT=$P(DGCN0,U)_".9" I '$P(DGPTF0,U,4) D WARD I 'Y K DGCN G CENQ
 ;if Fee Basis quit if admit > census date or admit < census date if disch
 I $P(DGPTF0,U,4)=1,$P(DGPTF0,U,2)>DGT G CENQ
 I $P(DGPTF0,U,4)=1,+$P($G(^DGPT(PTF,70)),U),$P(DGPTF0,U,2)<DGT G CENQ
 I $P(DGPTF0,U,4)=1 D FEE G CENQ
 S DGCST=0,DGCI=""
 F  S DGCI=$O(^DGPT("ACENSUS",PTF,DGCI)) Q:'DGCI  I $D(^DGPT(DGCI,0)),$P(^(0),U,13)=DGCN S DGCST=$P(^(0),U,6) Q:DGCST'=0  D  Q
 .S DGCI=$$RDGCI(DGCI),DGCST=1
CENQ K DGCN0,DGA1,DGT,X,DGPTF0,DGFEE Q
 ;
KVAR K DGCN,DGCI,DGCST Q
 ;
FEE ;
 S DGCST=0,DGCI="",DGFEE=1
 F  S DGCI=$O(^DGPT("ACENSUS",PTF,DGCI)) Q:'DGCI  I $D(^DGPT(DGCI,0)),$P(^(0),U,13)=DGCN S DGCST=$P(^(0),U,6) Q:DGCST'=0  D  Q
 . S DGCI=$$RDGCI(DGCI),DGCST=+$P(^DGPT(DGCI,0),U,6)
 Q
ACT ; -- census actions with input of X
 Q:'$D(X)
 S Y=2 D RTY^DGPTUTL
 I X="L" D CLS G ACTQ
 I X="P" D OPEN G ACTQ
 I X="E" S DGPTFLE=1,DGPTIFN=DGCI D EN^DGPTFREL K DGRTY,DGRTY0 G ^DGPTF
ACTQ K DGRTY,DGRTY0 G EN1^DGPTF4
 ;
RDGCI(DGCI) ;-- eliminating 'OPEN' status census record and duplicates
 S DGDL=DGCI,DGCIR="" D
 .F  S DGCIR=$O(^DGPT("ACENSUS",PTF,DGCIR),-1) Q:DGCIR<DGDL  D
 ..I $D(^DGPT(DGCIR,0)),$P(^(0),U,13)=DGCN S:DGCI=DGDL DGCI=DGCIR D
 ...I DGCIR<DGCI S DGPTIFN=DGCIR,DGRTY=2 D KDGP^DGPTFDEL,KDGPT^DGPTFDEL
 Q DGCI
 ;
CLS ;
 S DGFEE=0
 I $P(^DGPT(DGPTF,0),U,4)'=1 W !,"Updating TRANSFER DRGs..." S DGADM=$P(^DGPT(PTF,0),U,2) D SUDO1^DGPTSUDO
 S J=PTF,DGERR=-1,T2=^DG(45.86,DGCN,0)+.9,T1=$P(^(0),U,5)
 S DGPTFMTX=DGPTFMT S Y=T2 D FMT^DGPTUTL
 W !,"Performing edit checks..."
 ;-- init for Austin Edits
 K ^TMP("AEDIT",$J),^TMP("AERROR",$J) S DGACNT=0
 ;
 D LOG^DGPTFTR1:DGPTFMT=1,LOG^DGPTR1:DGPTFMT=2,COM1^DGPTFTR
 K DGLOGIC,T1,T2,DGCCO D LO^DGUTL
 I DGERR>0 K DGERR D ^DGPTF2 G CLSQ
 ;-- do austin edits
 ;
 D ^DGPTAE I DGERR>0 K DGERR D ^DGPTF2 G CLSQ
 K DGERR,^TMP("AEDIT",$J),DGACNT
 I $P(^DGPT(PTF,0),U,4) S DGFEE=1 D FEE1 G CLSQ:'DGCI
 I $P(^DGPT(PTF,0),U,4)'=1 D CREATE G CLSQ:'DGCI
 S DR="7////"_DUZ_";8///T",DA=DGCI,DIE="^DGPT(" D ^DIE K DIE,DR
 S (X,DINUM)=DGCI,DIC(0)="L",DIC="^DGP(45.84,",DIC("DR")="2///NOW;3////"_DUZ
 K DD,DO D FILE^DICN K DIC,DINUM
 F I=0,.11,.52,.321,.32,57,.3 S:$D(^DPT(DFN,I)) ^DGP(45.84,DGCI,$S(I=0:10,1:I))=^DPT(DFN,I)
 W !,"****** CENSUS CLOSED OUT ******" D HANG^DGPTUTL
 S DGCST=1
CLSQ S DGPTFMT=DGPTFMTX K DGPTFMTX,DGFEE Q
 ;
CREATE ; -- create census record
 W !,"Creating Census Record..."
 S Y=$P(^DGPT(PTF,0),U,2) D CREATE^DGPTFCR G CREATEQ:Y<0 S DGCI=+Y W "#",DGCI
 S DGEND=+^DG(45.86,DGCN,0)_".2359",DGBEG=+$P(^(0),U,5)
 S ^DGPT(DGCI,0)=$P(^DGPT(PTF,0),U,1,10)_"^2^"_PTF_"^"_DGCN,DGCSUF=$P(^(0),U,5)
 ;S ^DGPT(DGCI,0)=$P(^DGPT(PTF,0),U,1,5)_"^1^"_$P(^DGPT(PTF,0),U,7,10)_"^2^"_PTF_"^"_DGCN,DGCSUF=$P(^(0),U,5)
 S Y=DGEND D BS^DGPTC2 S X="",$P(X,U)=DGEND,$P(X,U,14)=Y
 I $D(^DGPT(PTF,70)) S Y=^(70) F I=8,9,10 S $P(X,U,I)=$P(Y,U,I)
 S ^DGPT(DGCI,70)=X D ASIH
 I $D(^DGPT(PTF,101)) S ^DGPT(DGCI,101)=^DGPT(PTF,101)
 F NODE="M","P","S",535 F I=0:0 S I=$O(^DGPT(PTF,NODE,I)) Q:'I  I $D(^DGPT(PTF,NODE,I,0)) S X=^(0) D @("SET"_NODE_"^DGPTC2")
 K DA,DIKLM S DA=DGCI,DIK="^DGPT(" D IX1^DIK
CREATEQ K X,Y,DGCSUF,DGBEG,DGEND Q
 ;
FEE1 ; -- create census record for fee record
 W !,"Creating Census Record..."
 S Y=$P(^DGPT(PTF,0),U,2) D CREATE^DGPTFCR G CREATEQ:Y<0 S DGCI=+Y W "#",DGCI
 S DGEND=+^DG(45.86,DGCN,0)_".2359",DGBEG=+$P(^(0),U,5)
 S ^DGPT(DGCI,0)=$P(^DGPT(PTF,0),U,1,10)_"^2^"_PTF_"^"_DGCN,DGCSUF=$P(^(0),U,5)
 I $D(^DGPT(PTF,70)) S ^DGPT(DGCI,70)=^DGPT(PTF,70)
 S $P(^DGPT(DGCI,70),U)=DGEND
 I $D(^DGPT(PTF,101)) S ^DGPT(DGCI,101)=^DGPT(PTF,101)
 F NODE="M","P","S",535 F I=0:0 S I=$O(^DGPT(PTF,NODE,I)) Q:'I  I $D(^DGPT(PTF,NODE,I,0)) S X=^(0) D @("SET"_NODE_"^DGPTC2")
 K DA,DIKLM S DA=DGCI,DIK="^DGPT(" D IX1^DIK
FEE1Q K X,Y,DGCSUF,DGBEG,DGEND Q
OPEN ; -- re-open census rec by deleting
 S DGPTIFN=DGCI D OPEN^DGPTFDEL S (DGCI,DGCST)=0
 K DGPTIFN Q
 ;
WARD ; -- ward @ census d/t for an adm(even if nhcu/dom adm that is ASIH)
 ;  input:  DGPMCA := corres adm
 ;          DGPMAN := corres adm 0th node
 ; output:       Y := ward ptr or null
 ;
 N MVT,M
 S Y=""
 I +DGPMAN>DGT Q
 I $D(^DGPM(+$P(DGPMAN,U,17),0)),+^(0)<DGT Q
 F %=(9999999.9999999-DGT):0 S %=$O(^DGPM("APMV",DFN,DGPMCA,%)) Q:'%  F MVT=0:0 S MVT=$O(^DGPM("APMV",DFN,DGPMCA,%,MVT)) Q:'MVT  I $D(^DGPM(MVT,0)) S M=^(0) I "^13^43^44^45^"'[(U_$P(M,U,18)_U),$D(^DIC(42,+$P(M,U,6),0)) S Y=+$P(M,U,6) G WARDQ
WARDQ Q
 ;
ASIH ; -- calc asih days
 N DGADM,DGREC,DGBDT,DGEDT,DGMVTP
 S X1=DGBEG,X2=-1 D C^%DTC S DGBDT=X
 S X1=$P(DGEND,"."),X2=1 D C^%DTC S DGEDT=X
 S DGADM=$P(^DGPT(DGCI,0),U,2) D ASIH^DGUTL2
 S $P(^DGPT(DGCI,70),U,8)=DGREC
 Q

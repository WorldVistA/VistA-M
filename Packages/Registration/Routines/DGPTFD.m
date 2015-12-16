DGPTFD ;ALB/MTC/ADL,HIOFO/FT,WOIFO/PMK - Sets Required Variables for DRG on 701 Screen ;6/2/15 11:28am
 ;;5.3;Registration;**60,441,510,785,850,884**;Aug 13, 1993;Build 31
 ;;ADL;Update for CSV Project;;Mar 24, 2003
 ;
 ; XLFSTR APIs - #10104
 ; ICDEX APIs - #5747
 ; ICDGTDRG APIs - #4052
 ; ICDXCODE APIs - #5699
 ;
EN1 ;-- entry point from 701
 Q:'$D(^DGPT(PTF,70))  S DGPT(70)=^(70)
 ;
 ;-- check for DXLS
 I $P(DGPT(70),U,10)="",$P(DGPT(70),U,11)="" G Q
 ;-- did patient die during care
 S DGEXP=$S($P(DGPT(70),U,3)>5:1,1:0)
 ;-- discharged against med advice
 S DGDMS=$S($P(DGPT(70),U,3)=4:1,1:0)
 ;-- transfer to acute care facility
 S DGTRS=$S($P(DGPT(70),U,13):1,1:0)
 ;-- sex,age
 S SEX=$P(^DPT(DFN,0),U,2),AGE=$S(+DGPT(70):+DGPT(70),1:DT)-$P(^(0),U,3)\10000,DOB=$P(^(0),U,3) ; DOB added by abr for ICD calc.
 ; DRP DG*5.3*850 If not discharged and census is open then use System Date, else get effective date.
 S DGDAT=$S(($G(DISDATE)="")!$G(DGCST,0)>0:DT,1:$$GETDATE^ICDGTDRG(PTF))
  ;-- build diagnosis string
 D EFFDATE^DGPTIC10(PTF)
 ;DRP If not discharged, and Effective date is valid and Census status is open then use Effective date
 I $G(DISDATE)="",+$G(EFFDATE),$G(DGCST,0)<1 S DGDAT=EFFDATE
 N DGPOA,DGPOACNT,DGDXPOA,DG701
 S DGDX="",DGDXPOA=""
 ;-- new record after 10/1/86
 S DGPOA=$$STR701P^DGPTFUT(PTF) ;returns string with POAs
 S DGPOACNT=1
 I '+DGPT(70)!(+DGPT(70)>2861000) D
 . S DG701=$$STR701^DGPTFUT(PTF) ;returns string with DX codes
 . ;F DGI=2:1:25 I $P(DG701,U,DGI)]"" S DGPOACNT=$G(DGPOACNT)+1 D
 . F DGI=2:1:25 I $P(DG701,U,DGI)]"" D
 .. S DGPTTMP=$$ICDDATA^ICDXCODE("DIAG",+$P(DG701,U,DGI),EFFDATE)
 .. I +DGPTTMP>0,$P(DGPTTMP,U,10) D
 ... S DGDX=DGDX_U_$P(DG701,U,DGI)
 ... ;I EFFDATE'<$$IMPDATE^LEXU("10D") S DGDXPOA=DGDXPOA_U_$$POA($P(DGPOA,U,DGPOACNT))
 ... I EFFDATE'<$$IMPDATE^LEXU("10D") S DGDXPOA=DGDXPOA_U_$$POA($P(DGPOA,U,DGI))
 ;-- old record format
 I +DGPT(70),+DGPT(70)<2861000 F DGI=0:0 S DGI=$O(^DGPT(PTF,"M","AM",DGI)) Q:DGI'>0  S DGJ=$O(^DGPT(PTF,"M","AM",DGI,0)) I $D(^DGPT(PTF,"M",+DGJ,0)) S DGNODE=$P(^(0),U,5,9) I DGNODE'="^^^^" D OLD
 ;
 S DGTMP=$S($P(DGPT(70),U,10):$P(DGPT(70),"^",10),1:$P(DGPT(70),U,11))
 S DGPTTMP=$$ICDDATA^ICDXCODE("DIAG",DGTMP,EFFDATE)
 I +DGPTTMP>0,$P(DGPTTMP,U,10) S DGDX=DGTMP_DGDX,DGDXPOA=$$POA($P(DGPOA,U,1))_DGDXPOA
 ;
 ;-- build surgery and procedure strings
 K DGSURG,DGPROC
 ;-- start with surgeries (401)
 F DGI=0:0 S DGI=$O(^DGPT(PTF,"S",DGI)) Q:DGI'>0  D
 .S X=$$STR401^DGPTFUT(PTF,DGI) ;returns string with procedure codes
 .I $$STRIP^XLFSTR(X,"^")'="" S K=+^DGPT(PTF,"S",DGI,0),K=$S('$D(DGSURG(K)):K,K[".":K_DGI_1,1:K_".0000"_DGI_1),DGSURG(K)="" S DGVAR=0 D TAG
 ;-- build DGSURG
 N I,X,Y,Z ; eliminate duplicates as we go
 N SUB S SUB=0
 I $D(DGSURG) S DGSURG=U F DGI=0:0 S DGI=$O(DGSURG(DGI)) Q:DGI'>0  D
 .S X=DGSURG(DGI)
 .F I=1:1:25 S Y=$P(X,U,I) Q:Y=""  D
 ..;Q:$L(DGSURG)>240 ; - no longer needed
 ..S Z=U_Y_U
 ..S ICDSURG(I)=Y
 ..S DGSURG=DGSURG_Y_U
 ..S DGPTTMP=$$ICDDATA^ICDXCODE("DIAG",Y,EFFDATE) ; added this line of code - PMK
 ..I +DGPTTMP>0,($P(DGPTTMP,U,10)) S SUB=SUB+1,DGSURG(SUB)=$P(DGPTTMP,U,2)
 ;-- procedures next old records before 10/1/87
 I +DGPT(70),+DGPT(70)<2871000 G DRG:'$D(^DGPT(PTF,"401P")) S DGPROC="",X=^("401P") D:X]""&(X'="^^^^")  G DRG
 . F DGI=1:1:5 I $P(X,U,DGI)]"" S DGPTTMP=$$ICDDATA^ICDXCODE("PROC",$P(X,U,DGI),EFFDATE) I +DGPTTMP>0,$P(DGPTTMP,U,10) S DGPROC=DGPROC_$P(X,U,DGI)_U
 ;-- get 601 (procedures)
 F DGI=0:0 S DGI=$O(^DGPT(PTF,"P",DGI)) Q:DGI'>0  D
 .S X=$$STR601^DGPTFUT(PTF,DGI) ;returns string with procedure codes
 .I $$STRIP^XLFSTR(X,"^")'="" S K=+^DGPT(PTF,"P",DGI,0),K=$S('$D(DGPROC(K)):K,K[".":K_DGI_1,1:K_".0000"_DGI_1),DGPROC(K)="" S DGVAR=1 D TAG
 ;-- build DGPROC and eliminate duplicates as we go
 I $D(DGPROC) S DGPROC=U F DGI=0:0 S DGI=$O(DGPROC(DGI)) Q:DGI'>0  D
 .S X=DGPROC(DGI)
 .F I=1:1:25 S Y=$P(X,U,I) Q:Y=""  D
 ..;Q:$L(DGPROC)>240 ; - no longer needed
 ..S Z=U_Y_U
 ..S DGPROC(I)=Y
 ..;Q:DGPROC[Z
 ..S DGPROC=DGPROC_Y_U
DRG ;
 S:'$D(DGCPT) DGDRGPRT=1 D ^DGPTICD  ;return DRG code even if inactive
 ;
Q K AGE,SEX,DGEXP,DGDMS,DGPT,DGTRS,DGDX,DGNODE,DGPROC,DGSURG,DGDRGPRT,DGI,DGJ,K,DOB,ICDSURG Q
 ;
OLD ;-- used to format diagnostic codes for old PTF records
 S X="" F DGJ=1:1:5 I $P(DGNODE,"^",DGJ)]"",$P($$CODEC^ICDEX(80,$P(DGNODE,"^",DGJ)),U,1)'=-1 S X=X_"^"_$P(DGNODE,"^",DGJ)
 S DGDX=X_$P(DGDX,"^",1,40)
 Q
TAG ;-- used to build sur/proc string date
 F DGJ=1:1:25 I $P(X,U,DGJ)]"" S DGPTTMP=$$ICDDATA^ICDXCODE("PROC",$P(X,U,DGJ),EFFDATE) I +DGPTTMP>0,$P(DGPTTMP,U,10) S:DGVAR=0 DGSURG(K)=DGSURG(K)_$P(X,U,DGJ)_U S:DGVAR=1 DGPROC(K)=DGPROC(K)_$P(X,U,DGJ)_U
 Q
POA(POA) ; Calculate of POA should be used in DRG
 ;  coordinate with POA^DGPTRI4
 ;
 ; -- On 8/9/2012 the ADT SME Determined that null POA should be defaulted to Yes
 ;    Due to the fact that the COTS PTF software was not uploading POA information.
 ;
 S POA=$G(POA)
 Q $S(POA="Y":"Y",POA="N":"N",POA="":"Y",POA="U":"U",POA="W":"W",1:"Y")
 ;

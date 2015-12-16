DGPTFJC ;ALB/ADL,HIOFT/FT - CLOSED PTF ;12/12/14 2:15pm
 ;;5.3;Registration;**158,510,517,590,636,635,701,729,785,850,884**;Aug 13, 1993;Build 31
 ;;ADL;;Update for CSV Project;;Mar 25, 2003
101 W !,"Enter '^N' for Screen N, RETURN for <MAS>,'^' to Abort: <MAS>//"
 D READ G Q^DGPTF:X=U,^DGPTFM:X="",^DGPTFJ:X?1"^".E D H G 101
 ;
H D HELP^DGPTFJ W ! Q
 ;
MAS W !!,"Enter '^N' for Screen N, RETURN for <",DGNUM,">,'^' to Abort: <",DGNUM,">//"
 D READ G Q^DGPTF:X=U,^DGPTFJ:X?1"^".E
 I X="" S (ST,ST1)=J+1 G @($S($D(DGZDIAG):"NDG",$D(DGZSER):"NSR",$D(DGZPRO):"NPR",$D(DGZSUR):"EN",+DGZPRF-1'=$P(DGZPRF,U,3):"NPS",1:"DONE")_"^DGPTFM")
 D H G MAS
 ;
401 S DGNUM=$S($D(S(DGZS0+1)):401_"-"_(DGZS0+1),1:"MAS")
 W !,"Enter '^N' for Screen N, RETURN for <",DGNUM,">,'^' to Abort: <",DGNUM,">//"
 D READ G Q^DGPTF:X=U,NEXM^DGPTFM5:X="",^DGPTFJ:X?1"^".E D H G 401
 ;
501 W !,"Enter '^N' for Screen N, RETURN for <",DGNUM,">,'^' to Abort: <",DGNUM,">//"
 D READ G Q^DGPTF:X=U,NEXM^DGPTFM4:X="",^DGPTFJ:X?1"^".E D H G 501
 ;
601 W !,"Enter '^N' for Screen N, RETURN for <",DGNUM,">,'^' to Abort: <",DGNUM,">//"
 D READ G Q^DGPTF:X=U,NEXP^DGPTFM6:X="",^DGPTFJ:X?1"^".E D H G 601
 ;
701 ;
 G ACT1^DGPTF41 ; new code
 ;
 ;Display screen prompt and process user response for 801 screen
801 W !,"Enter '^N' for Screen N, RETURN for <",DGNUM,">,'^' to Abort: <",DGNUM,">//"
 D READ G Q^DGPTF:X=U,NEXP^DGPTFM2:X="",^DGPTFJ:X?1"^".E D H G 801
READ ; -- read X
 R X:DTIME S:'$T X="^",DGPTOUT=""
 Q
 ;
EN ; DG*636 ; DG*5.3*850
 ; Called from Diagnosis fields in 501 movements
 ; Variable DGN is passed globally as a node identifier
 ;
 N EFFDATE,DGTEMP,IMPDATE,DGINAC
 D EFFDATE^DGPTIC10(DA(1))
 S K=$S($D(K):K,1:1),DGER=0 ;S DGPTDAT=$$GETDATE^ICDGTDRG(DA(1))
 ;
 ;if there is a disch and a previous movement, if disch
 ;is >Oct 1 (next FY) and movement <Oct 1, then use the movement date
 I $G(DGZM0)="" S DGZM0=1,M(DGZM0)="0^"  ; to prevent sys err from TD5^DGPTTS2 and ptf quick load (DG*701/729)
 N DGPTMVDT I DGPTDAT=$P($G(^DGPT(DA(1),70)),U,1)&(DGPTDAT=$P($G(^DGPT(DA(1),"M",1,0)),U,10))&($D(M(DGZM0)))&($P($G(M(DGZM0)),U)'=1) S DGPTMVDT=$P($G(^DGPT(DA(1),"M",2,0)),U,10)
 ;next line is if using "Add a code" in MAS screen
 I '$G(DGPTMVDT)&($D(DGADD))&($G(DGMOV)'=1) S DGPTMVDT=$P($G(^DGPT(DA(1),"M",2,0)),U,10)
 I $G(DGPTMVDT) D
 .;if same calendar year
 .I $E(DGPTDAT,1,3)=$E(DGPTMVDT,1,3),$E(DGPTDAT,4,7)>0930,$E(DGPTMVDT,4,7)<1001 S DGPTDAT=DGPTMVDT Q
 .;if different calendar year
 .I ($E(DGPTDAT,1,3)-$E(DGPTMVDT,1,3))>1 S DGPTDAT=DGPTMVDT Q
 .I $E(DGPTMVDT,4,7)<1001 S DGPTDAT=DGPTMVDT Q
 .I $E(DGPTDAT,4,7)>0930 S DGPTDAT=DGPTMVDT Q
 I $G(DGPMT)!$G(DGQWK) K M(DGZM0),DGZM0  ; DG*701/729
 S DGPTTMP=$$ICDDATA^ICDXCODE("DIAG",+Y,EFFDATE)
 I +DGPTTMP<0 D MSG("Can not use inactive codes.") S DGER=1 Q
 I '$P(DGPTTMP,U,10) S DGINAC=$P(DGPTTMP,U,12) I DGINAC<EFFDATE D MSG("Can not use inactive codes.") S DGER=1 Q
 ;end DG*636
 ;===================================================================
 ;
 ;Allow sex-unique ICD codes to be assigned to the opposite sex
 ;for 501 movements, output warning only (Ref: DG*5.3*884)
 I $P(DGPTTMP,U,11)]""&($P(DGPTTMP,U,11)'=$S($D(^DPT(+^DGPT(DA(1),0),0)):$P(^(0),U,2),1:"M")) D
 . D:K<24 MSG($P(DGPTTMP,U,2)_" should only be used with "_$S($P(DGPTTMP,U,11)="F":"FEMALES",1:"MALES")) S K=K+1 Q
 ;
 ; -- can't enter a code already in the movement
 I $D(^DGPT(DA(1),"M","AC",+Y,DA)) W !,"Cannot enter the same code twice." S DGER=1 Q
 ;
 S %=U_$P(^DGPT(DA(1),"M",DA,0),U,5,15),$P(%,U,7)=U ;take movement date out of %
 D NOT(+Y,%)
 Q:DGER
 D REQ(+Y,%)
 Q
 ;
EN1 ; called from 601 movement procedure codes and 401 Surgical operations
 S K=$S($D(K):K,1:1),DGER=0
 ;
 N EFFDATE,DGTEMP,IMPDATE,DGPTDAT
 ;
 ;Next 2 lines commented out since they were used to prevent duplicate operation/procedure codes (401 & 601)
 ;from being entered. If duplicate checking is ever implemented for operation/procedure data, a replacement
 ;multi-field xref will need to be created. (Ref: DG*5.3*884)
 ;S:$G(DGIT)=5 DGCR="AP6",DGSB="P"
 ;S:$G(DGIT)=8 DGCR="AO",DGSB="S"
 ;
 D EFFDATE^DGPTIC10(DA(1))
 ;S DGICD0=$$ICDDATA^ICDXCODE("PROC",+Y,EFFDATE)
 N DGPRDT S DGPRDT=$S(+$G(DGPROCD):+DGPROCD,1:+$G(DGPROCI))
 S:'+$G(DGPRDT) DGICD0=$$ICDDATA^ICDXCODE("PROC",+Y,EFFDATE)
 I +$G(DGPRDT) D
 . ;if procedure before ICD-10 era but the effective date (discharge date) is after then use the eff date and quit
 . I DGPRDT<IMPDATE,EFFDATE'<IMPDATE S DGICD0=$$ICDDATA^ICDXCODE("PROC",+Y,EFFDATE) Q
 . ;otherwise use the procedure date
 . S DGICD0=$$ICDDATA^ICDXCODE("PROC",+Y,DGPRDT)
 ;
 I +DGICD0,0!('$P(DGICD0,U,10)) S DGER=1 Q
 ;
 ;Allow sex-unique ICD codes to be assigned to the opposite sex for
 ;401 Surgeries and 601 Procedures, output warning only (Ref: DG*5.3*884)
 I $P(DGICD0,U,11)]""&($P(DGICD0,U,11)'=$S($D(^DPT(+^DGPT(DA(1),0),0)):$P(^(0),U,2),1:"M")) D
 . D:K<24 MSG($P(DGICD0,U,2)_" should only be used with "_$S($P(DGICD0,U,11)="F":"FEMALES",1:"MALES")) S K=K+1 Q
 ;
 ;Next 2 lines commented out since user may enter duplicate operation/procedure codes (401 & 601) as sometimes
 ;they must code left and right when there aren't specific codes, they enter the code twice. (Ref: DG*5.3*884)
 ;S %=$P(^DGPT(DA(1),$G(DGSB),DA,0),U,DGI)
 ;I $D(^DGPT(DA(1),$G(DGSB),$G(DGCR),Y,DA)),%'=Y S DGER=1 D MSG("Cannot enter the same code more than once within a "_$S(DGSB="S":"401",1:"601")_" transaction") Q
 ;
 Q
EN2 ; Called from 701 movement procedure codes
 S K=$S($D(K):K,1:1),DGER=0
 N EFFDATE,DGTEMP,IMPDATE,DGPTDAT
 D EFFDATE^DGPTIC10(DA)
 S DGPTTMP=$$ICDDATA^ICDXCODE("PROC",+Y,EFFDATE)
 ; 
 I +DGPTTMP<0!('$P(DGPTTMP,U,10)) S DGER=1 Q
 ;
 ;Allow sex-unique ICD codes to be assigned to the opposite sex for
 ;401P Procedures, output warning only (Ref: DG*5.3*884)
 I $P(DGPTTMP,U,11)]""&($P(DGPTTMP,U,11)'=$S($D(^DPT(+^DGPT(DA,0),0)):$P(^(0),U,2),1:"M")) D
 . D:K<24 MSG($P(DGPTTMP,U,2)_" should only be used with "_$S($P(DGPTTMP,U,11)="F":"FEMALES",1:"MALES")) S K=K+1 Q
 ;
 S L=$P($S($D(^DGPT((DA),"401P")):^("401P"),1:0),U,1,5)
 S %=$P(L,U,DGI)
 S L=$P(L,U,1,DGI-1)_U_$P(L,U,DGI+1,5)
 I L[+Y D MSG("Cannot enter the same code twice.") S DGER=1 Q
 Q
EN3 ;Called from 701 movement diagnosis fields (top level)
 ; - EFFDATE := date of interest e.g. patient discharge date
 ; - IMPDATE := ICD-10 implementation date
 ; - DGTEMP  := temp variable to hold data from $$IMPDATE^DGPTIC10
 ;
 N EFFDATE,DGTEMP,IMPDATE,DGINAC
 ;
 D EFFDATE^DGPTIC10(DA)
 ;
 S K=$S($D(K):K,1:1),DGER=0,DGPTTMP=$$ICDDATA^ICDXCODE("DIAG",+Y,EFFDATE)
 I +DGPTTMP<0 D MSG("Can not use inactive codes.") S DGER=1 Q
 I '$P(DGPTTMP,U,10) S DGINAC=$P(DGPTTMP,U,12) I DGINAC<EFFDATE D MSG("Can not use inactive codes.") S DGER=1 Q
 ; 
 ; - unacceptable as primary DX
 I DGI=1,$P(DGPTTMP,U,5) D MSG("Not acceptable as a primary Diagnosis.") S DGER=1 Q
 ;
 ;Allow sex-unique ICD codes to be assigned to the opposite sex for
 ;Primary and Secondary Dx's, output warning only (Ref: DG*5.3*884)
 I $P(DGPTTMP,U,11)]""&($P(DGPTTMP,U,11)'=$S($D(^DPT(+^DGPT(DA,0),0)):$P(^(0),U,2),1:"M")) D
 . D:K<24 MSG($P(DGPTTMP,U,2)_" should only be used with "_$S($P(DGPTTMP,U,11)="F":"FEMALES",1:"MALES")) S K=K+1 Q
 ;
 ; -- build string of 701 dx codes
 S %=$S($D(^DGPT(DA,70)):^(70),1:""),%=U_$P(%,U,10)_U_$P(%,U,16,24)_U
 S:$G(^DGPT(DA,71))'="" %=%_^(71)_U
 ;
 ; -- can't enter the same entry twice
 S $P(%,U,DGI+1)=U I %[(U_+Y_U) S DGER=1 D MSG("Cannot enter the same code twice.") Q
 ;
 D NOT(+Y,%)
 Q:DGER
 ;
 D REQ(+Y,%)
 Q
EN4 ; called from ??
 S K=$S($D(K):K,1:1),DGER=0,N=$$ICDDATA^ICDXCODE("DIAG",+Y,$$GETDATE^ICDGTDRG(DA)) I N<0!'$P(N,U,10) S DGER=1 Q
 I DGI=1,$P(N,U,5) S DGER=1 Q
 I $P(N,U,11)]""&($P(N,U,11)'=$S($D(^DPT(+^DGPT(DA(2),0),0)):$P(^(0),U,2),1:"M")) D:K<24 MSG($P(N,U,2)_" can only be used with "_$S($P(N,U,11)="F":"FEMALES",1:"MALES")) S K=K+1,DGER=1 Q
 S %=$S($D(^DGPT(DA(2),"C",DA(1),"CPT",DA,0)):^(0),1:""),%=U_$P(%,U,4,7)_U,$P(%,U,DGI+1)=U I %[(U_+Y_U) S DGER=1 Q
 D NOT(+Y,%)
 Q:DGER
 D REQ(DA(2),+Y,%)
 Q
EN5 ; DG*5.3*850
 ; called from the diagnosis input transforms in file 46
 N EFFDATE,DGTEMP,IMPDATE
 I $G(PTF) D EFFDATE^DGPTIC10($G(PTF))
 S K=$S($D(K):K,1:1),DGER=0,DGPTTMP=$$ICDDATA^ICDXCODE("DIAG",+Y,EFFDATE)
 I +DGPTTMP<0!('$P(DGPTTMP,U,10)) D MSG("Must be an active code.") S DGER=1 Q
 ;
 I $P(DGPTTMP,U,11)]""&($P(DGPTTMP,U,11)'=$S($D(^DPT(+^DGPT(PTF,0),0)):$P(^(0),U,2),1:"M")) D
 . D:K<24 MSG($P(DGPTTMP,U,2)_" can only be used with "_$S($P(DGPTTMP,U,11)="F":"FEMALES",1:"MALES")) S K=K+1,DGER=1 Q
 ;
 S K=^DGCPT(46,DA,0) I $P(K,U,4,7)_U_$P(K,U,15,18)[Y D MSG("Cannot enter the same code twice.") S DGER=1 Q
 Q
EN6 ; -- called from file 46; .01 field
 I $P($G(^(0)),U,2)?.N S DGER=1 Q
 S DGER=0,N=$$CPT^ICPTCOD(+Y,$$GETDATE^ICDGTDRG($G(DA))) I N<0!'$P(N,"^",7) S DGER=1 Q
 S L=0 F  S L=$O(^DGCPT(46,L)) Q:L'>0  I +$G(^(L,1))=$G(DGPRD),$P(^(1),U,3)=$G(PTF),+^(0)=Y,'$G(^(9)) S DGER=1 Q
 K L Q
 Q
 ;
REQ(DX,STRING) ; - is another ICD code required with this code
 ; -- input     DX - code being entered
 ;          STRING - string of code iens already entered for movement ("^123^456^789^")
 ; -- output - writes message if another code is required
 ;
 N I,IEN,DGI,DZ
 K ^TMP("DGPTF-R",$J)
 Q:$G(DX)<1
 Q:'$$REQ^ICDEX(DX,"DGPTF-R",1)
 ;
 S DGI=1 S DZ="" F I=0:0 S DZ=$O(^TMP("DGPTF-R",$J,"B",DZ)) Q:DZ=""  D  Q:DG1=1
 . S IEN=$O(^TMP("DGPTF-R",$J,"B",DZ,0)) Q:IEN<1  S DG1=0 I STRING[(U_IEN_U) S DG1=1 Q
 I DG1=0 D MSG($S(+DGPTTMP>0:$P(DGPTTMP,U,2),1:"")_" requires additional code.")
 K ^TMP("DGPTF-R",$J)
 Q
 ;
NOT(DX,STRING) ; - is icd code not to use with existing codes
 ; -- input     DX - code being entered
 ;          STRING - string of code iens already entered for movement ("^123^456^789^")
 ; -- output  DGER :=1 if error
 ;            writes message if not allowed
 ;
 N I,IEN,DGI,DZ
 K ^TMP("DGPTF-N",$J)
 S DGER=0
 Q:$G(DX)<1
 ;
 Q:'$$NOT^ICDEX(DX,"DGPTF-N",1)
 ;
 S DGI=1 S DZ="" F I=0:0 S DZ=$O(^TMP("DGPTF-N",$J,"B",DZ)) Q:DZ=""  D  Q:DGER
 . S IEN=$O(^TMP("DGPTF-N",$J,"B",DZ,0)) Q:IEN<1  I STRING[(U_IEN_U) S DGER=1 D  Q:DGER
 .. D MSG("Cannot use "_$$CODEC^ICDEX(80,DX)_"  with "_$$CODEC^ICDEX(80,IEN)) Q
 K ^TMP("DGPTF-N",$J)
 Q
MSG(TEXT) ;
 D EN^DDIOL(TEXT)
 Q

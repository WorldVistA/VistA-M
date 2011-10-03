DGPTFJC ;ALB/ADL - CLOSED PTF ;7/28/05 1:08pm
 ;;5.3;Registration;**158,510,517,590,636,635,701,729,785**;Aug 13, 1993;Build 7
 ;;ADL;;Update for CSV Project;;Mar 25, 2003
101 W !,"Enter '^N' for Screen N, RETURN for <MAS>,'^' to Abort: <MAS>//"
 D READ G Q^DGPTF:X=U,^DGPTFM:X="",^DGPTFJ:X?1"^".E D H G 101
 ;
H D HELP^DGPTFJ W ! Q
 ;
MAS W !!,"Enter '^N' for Screen N, RETURN for <",DGNUM,">,'^' to Abort: <",DGNUM,">//"
 D READ G Q^DGPTF:X=U,^DGPTFJ:X?1"^".E
 I X="" S (ST,ST1)=J+2 G @($S($D(DGZDIAG):"NDG",$D(DGZSER):"NSR",$D(DGZPRO):"NPR",$D(DGZSUR):"EN",+DGZPRF-1'=$P(DGZPRF,U,3):"NPS",1:"DONE")_"^DGPTFM")
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
EN ; DG*636
 ;;S K=$S($D(K):K,1:1),DGER=0 S DGPTDAT=$$GETDATE^ICDGTDRG(DA(1)),DGPTTMP=$$ICDDX^ICDCODE(+Y,DGPTDAT) I +DGPTTMP=-1!('$P(DGPTTMP,U,10)) S DGER=1 Q
 S K=$S($D(K):K,1:1),DGER=0 S DGPTDAT=$$GETDATE^ICDGTDRG(DA(1))
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
 S DGPTTMP=$$ICDDX^ICDCODE(+Y,DGPTDAT) I +DGPTTMP=-1!('$P(DGPTTMP,U,10)) S DGER=1 Q
 ;end DG*636
 ;===================================================================
 I $P(DGPTTMP,U,11)]""&($P(DGPTTMP,U,11)'=$S($D(^DPT(+^DGPT(DA(1),0),0)):$P(^(0),U,2),1:"M")) W:K<24 !,$P(DGPTTMP,U,2)," can only be used with ",$S($P(DGPTTMP,U,11)="F":"FEMALES",1:"MALES") S K=K+1,DGER=1 Q
 S %=$P(^DGPT(DA(1),"M",DA,0),U,DGI) I $D(^DGPT(DA(1),"M","AC",Y,DA)),%'=Y S DGER=1 Q
 F I=0:0 S I=$O(^ICD9(+Y,"N",I)) Q:I'>0  I $D(^DGPT(DA(1),"M","AC",I,DA)),%'=I W !,"Cannot use ",$S($D(^ICD9(+Y,0)):$P(^(0),U),1:""),"  with ",$S($D(^ICD9(I,0)):$P(^(0),U),1:"") S DGER=1 Q
 Q:DGER  S DG1=1 F I=0:0 S I=$O(^ICD9(+Y,"R",I)) Q:I'>0  S DG1=0 I $D(^DGPT(DA(1),"M","AC",I,DA)),%'=I S DG1=1 Q
 I 'DG1 W !,$S(+DGPTTMP>0&('$P(DGPTTMP,U,10)):$P(DGPTTMP,U,2),1:"")," requires additional code."
 Q
EN1 S K=$S($D(K):K,1:1),DGER=0,DGPTDAT=$$GETDATE^ICDGTDRG(DA(1)),DGICD0=$$ICDOP^ICDCODE(+Y,DGPTDAT) I +DGICD0,0!('$P(DGICD0,U,10)) S DGER=1 Q
 I $P(DGICD0,U,11)]""&($P(DGICD0,U,11)'=$S($D(^DPT(+^DGPT(DA(1),0),0)):$P(^(0),U,2),1:"M")) W:K<24 !,$P(DGICD0,U,2)," can only be used with ",$S($P(DGICD0,U,11)="F":"FEMALES",1:"MALES") S K=K+1,DGER=1 Q
 S %=$P(^DGPT(DA(1),DGSB,DA,0),U,DGI)
 ;I $D(^DGPT(DA(1),DGSB,DGCR,Y,DA)),%'=Y S DGER=1 W !,"Cannot enter the same code more than once within a ",$S(DGSB="S":"401",1:"601")," transaction" Q
 F I=0:0 S I=$O(^ICD0(+Y,"N",I)) Q:I'>0  I $D(^DGPT(DA(1),DGSB,DGCR,I,DA)),%'=I S DGPTTMP2=$$ICDOP^ICDCODE(I,DGPTDAT) W !,"Cannot use ",$P(DGICD0,U,2),"  with ",$S(+DGPTTMP2>0:$P(DGPTTMP2,U,2),1:"") S DGER=1 Q
 Q:DGER  S DG1=1 F I=0:0 S I=$O(^ICD0(+Y,"R",I)) Q:I'>0  S DG1=0 I $D(^DGPT(DA(1),DGSB,DGCR,I,DA)),%'=I S DG1=1 Q
 I 'DG1 W !,$P(DGICD0,U,2)," requires additional code."
 Q
EN2 S K=$S($D(K):K,1:1),DGER=0,DGPTTMP=$$ICDOP^ICDCODE(+Y,$$GETDATE^ICDGTDRG(DA)) I +DGPTTMP<0!('$P(DGPTTMP,U,10)) S DGER=1 Q
 I $P(DGPTTMP,U,11)]""&($P(DGPTTMP,U,11)'=$S($D(^DPT(+^DGPT(DA,0),0)):$P(^(0),U,2),1:"M")) W:K<24 !,$P(DGPTTMP,U,2)," can only be used with ",$S($P(DGPTTMP,U,11)="F":"FEMALES",1:"MALES") S K=K+1,DGER=1 Q
 S L=$P($S($D(^DGPT((DA),"401P")):^("401P"),1:0),U,1,5),%=$P(L,U,DGI),L=$P(L,U,1,DGI-1)_U_$P(L,U,DGI+1,5) I L[Y S DGER=1 Q
 Q
EN3 S K=$S($D(K):K,1:1),DGER=0,DGPTTMP=$$ICDDX^ICDCODE(+Y,$$GETDATE^ICDGTDRG(DA)) I +DGPTTMP<0!('$P(DGPTTMP,U,10)) S DGER=1 Q
 I DGI=1,$P(DGPTTMP,U,5) S DGER=1 Q
 I $P(DGPTTMP,U,11)]""&($P(DGPTTMP,U,11)'=$S($D(^DPT(+^DGPT(DA,0),0)):$P(^(0),U,2),1:"M")) W:K<24 !,$P(DGPTTMP,U,2)," can only be used with ",$S($P(DGPTTMP,U,11)="F":"FEMALES",1:"MALES") S K=K+1,DGER=1 Q
 S %=$S($D(^DGPT(DA,70)):^(70),1:""),%=U_$P(%,U,10)_U_$P(%,U,16,24)_U
 S:$G(^DGPT(DA,71))'="" %=%_^(71)_U S $P(%,U,DGI+1)=U I %[(U_+Y_U) S DGER=1 Q
 F I=0:0 S I=$O(^ICD9(+Y,"N",I)) Q:I'>0  I %[(U_I_U) S DGPTTMP2=$$ICDDX^ICDCODE(I,DGPTDAT) W !,"Cannot use ",$P($G(DGPTTMP),U,2),"  with ",$S(+DGPTTMP2>0:$P(DGPTTMP2,U,2),1:"") S DGER=1 Q
 Q:DGER  S DG1=1 F I=0:0 S I=$O(^ICD9(+Y,"R",I)) Q:I'>0  S DG1=0 I %[(U_I_U) S DG1=1 Q
 I 'DG1 W !,$S(+DGPTTMP>0:$P(DGPTTMP,U,2),1:"")," requires additional code."
 Q
EN4 S K=$S($D(K):K,1:1),DGER=0,N=$$ICDDX^ICDCODE(+Y,$$GETDATE^ICDGTDRG(DA)) I N<0!'$P(N,U,10) S DGER=1 Q
 I DGI=1,$P(N,U,5) S DGER=1 Q
 I $P(N,U,11)]""&($P(N,U,11)'=$S($D(^DPT(+^DGPT(DA(2),0),0)):$P(^(0),U,2),1:"M")) W:K<24 !,$P(N,U,2)," can only be used with ",$S($P(N,U,11)="F":"FEMALES",1:"MALES") S K=K+1,DGER=1 Q
 S %=$S($D(^DGPT(DA(2),"C",DA(1),"CPT",DA,0)):^(0),1:""),%=U_$P(%,U,4,7)_U,$P(%,U,DGI+1)=U I %[(U_+Y_U) S DGER=1 Q
 F I=0:0 S I=$O(^ICD9(+Y,"N",I)) Q:I'>0  I %[(U_I_U) W !,"Cannot use ",$S($D(^ICD9(+Y,0)):$P(^(0),U),1:""),"  with ",$S($D(^ICD9(I,0)):$P(^(0),U),1:"") S DGER=1 Q
 Q:DGER  S DG1=1 F I=0:0 S I=$O(^ICD9(+Y,"R",I)) Q:I'>0  S DG1=0 I %[(U_I_U) S DG1=1 Q
 I 'DG1 W !,$P(N,U,2)," requires additional code."       Q
 Q
EN5 S K=$S($D(K):K,1:1),DGER=0,DGPTTMP=$$ICDDX^ICDCODE(+Y,+DGZPRF(DGZP)) I +DGPTTMP<0!('$P(DGPTTMP,U,10)) S DGER=1 Q
 I $P(DGPTTMP,U,11)]""&($P(DGPTTMP,U,11)'=$S($D(^DPT(+^DGPT(PTF,0),0)):$P(^(0),U,2),1:"M")) W:K<24 !,$P(DGPTTMP,U,2)," can only be used with ",$S($P(DGPTTMP,U,11)="F":"FEMALES",1:"MALES") S K=K+1,DGER=1 Q
 S K=^DGCPT(46,DA,0) I $P(K,U,4,7)_U_$P(K,U,15,18)[Y S DGER=1 Q
 Q
EN6 I $P($G(^(0)),U,2)?.N S DGER=1 Q
 S DGER=0,N=$$CPT^ICPTCOD(+Y,$$GETDATE^ICDGTDRG(DA)) I N<0!'$P(N,"^",7) S DGER=1 Q
 S L=0 F  S L=$O(^DGCPT(46,L)) Q:L'>0  I +$G(^(L,1))=DGPRD,$P(^(1),U,3)=PTF,+^(0)=Y,'$G(^(9)) S DGER=1 Q
 K L Q

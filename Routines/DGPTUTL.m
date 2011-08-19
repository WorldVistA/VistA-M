DGPTUTL ;ALB/AS - PTF UTILITY ROUTINE ; 8/14/03 11:35am
 ;;5.3;Registration;**26,114,234,466,544**;Aug 13, 1993
D I $L(Y)'<7 S %=$E(Y,4,5)*3,Y=$E("JANFEBMARAPRMAYJUNJULAUGSEPOCTNOVDEC",%-2,%)_" "_$S($E(Y,6,7):$J(+$E(Y,6,7),2)_",",1:"")_($E(Y,1,3)+1700)_$S(Y[".":" "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12),1:"") Q
 S Y="" Q
PM ;sets variables from ^DGPM global
 S DGPMCA=$O(^DGPM("APTF",PTF,0)),DGPMAN=$S($D(^DGPM(+DGPMCA,0)):^(0),1:"") Q
MT ;Determine and store Means Test Indicator
 ;S DGZEC=$S($D(^DPT(DFN,.36)):$P(^(.36),U,1),1:""),DGZEC=$S($D(^DIC(8,+DGZEC,0)):^(0),1:"") I $P(DGZEC,U,5)="N" S DGX="N" G DIE
 ;-- get eligibility code
 S DGZEC=$P($G(^DGPT(PTF,101)),U,8),DGZEC=$S($D(^DIC(8,+DGZEC,0)):^(0),1:"") I $P(DGZEC,U,5)="N" S DGX="N" G DIE
 ;-- admit prior to 7/1/86 is an X
 I DGADM<2860701 S DGX="X" G DIE
 ;--
 I $D(^DGPT(PTF,101)),$D(^DIC(45.1,+^(101),0)),$P(^(0),"^",4) S DGX="X" G DIE
 I $P(^DG(43,1,0),U,21),DGADM]"",$D(^DIC(42,+$P(DGPMAN,U,6),0)),$P(^(0),U,3)="D" S DGX="X" G DIE
 S DGT=$P($G(^DGPT(PTF,70)),"."),DGZ1=$$LST^DGMTU(DFN,DGT) G AS:'DGZ1
 ;-- sc < 50 %, %O non comp, movements are sc
 I $P(DGZEC,U,4)=3,$$SC^DGMTR(DFN),$$ANYSC^DGPTSCAN(PTF) S DGX="AS" G DIE
 ;-- sc <50 %, %0 non-comp, no movement sc, mt =a
 I $P(DGZEC,U,4)=3,$$SC^DGMTR(DFN),'$$ANYSC^DGPTSCAN(PTF),$P(DGZ1,U,4)="A" S DGX="AN" G DIE
 ;-- sc, >0%  - DG*5.3*544
 I "^1^3^"[("^"_$P(DGZEC,U,4)_"^"),$P($G(^DPT(DFN,.3)),U,2)>0,$P(DGZ1,U,4)="A" S DGX="AS" G DIE
 ;
 S DGX=$S('$D(DGZ1):"U",1:$P(DGZ1,U,4))
 ; Determine if the Pending Adjudication is for MT(C) GMT(G)
 I DGX="P" D  G DIE
 . I '+$P($G(DGZ1),U) S DGX="U" Q
 . S DGX=$$PA^DGMTUTL($P(DGZ1,U)),DGX=$S('$D(DGX):"U",DGX="MT":"C",DGX="GMT":"G",1:"U")
 S DGX=$S(DGX="A":"AN","BCGN"[DGX:DGX,1:"U") G DIE:DGX'="N"
 ;-- AO or IR
AS S DGZ=$S($D(^DPT(DFN,.321)):^(.321),1:0) I $P(DGZ,U,2)="Y"!($P(DGZ,U,3)="Y") S DGX="AS" G DIE
 ;-- EC
 S DGZ=$S($D(^DPT(DFN,.322)):^(.322),1:0) I $P(DGZ,U,13)="Y" S DGX="AS" G DIE
 ;-- NTR
 N DGNTARR S DGZ=$S($$GETCUR^DGNTAPI(DFN,"DGNTARR")>0:DGNTARR("NTR"),1:"") I $P(DGZ,U)="Y" S DGX="AS" G DIE
 ;-- MST
 S DGZ=$$GETSTAT^DGMSTAPI(DFN) I $P(DGZ,U,2)="Y" S DGX="AS" G DIE
 ;-- if veteran and AA or Housebound
 I $P(DGZEC,U,5)="Y",$P(DGZEC,U,4)<4,"^2^15^"'[(U_$P(DGZEC,U,9)_U) S DGX="AS" G DIE
 ;
 I DGZEC]"" S DGX="AN" G DIE
 ;
 S DGX="U" I '$D(DGLN) W !,"===> this patient has a blank Eligibility Code"
DIE I '$D(DGBGJ) S DA=PTF,DR="10///"_DGX_$S('$P(^DGPT(PTF,0),U,3):";3///`"_$P($$SITE^VASITE,U),1:""),DIE="^DGPT(" D ^DIE K DGZEC,DGZ,DGZ1,DG1,DGX,DR,DGT,DA,DIE Q
 I DGX'=$P(^DGPT(PTF,0),"^",10) S DA=PTF,DR="10///"_DGX,DIE="^DGPT(" D ^DIE
 K DGZEC,DGZ,DGZ1,DG1,DGX,DGT,DR,DA,DIE Q
 ;
RTY ; -- set rec type variables
 ;  input:      Y := rec type #
 ; output:  DGRTY := rec type #
 ;         DGRTY0 := name of type (in future, may expand to 0th node)
 ;
 I Y=1 S DGRTY=1,DGRTY0="PTF"
 I Y=2 S DGRTY=2,DGRTY0="CENSUS"
 Q
 ;
HANG ;
 R DGPTHANG:4 K DGPTHANG Q
 ;
CEN ; -- find current active census ; return ifn and 0th node
 S DGCN=$O(^DG(45.86,"AC",1,0)),DGCN0=$S($D(^DG(45.86,+DGCN,0)):^(0),1:"")
 Q
 ;
FMT ; -- determime PTF record format
 ;
 S Z=$S(Y:Y,1:DT)
 S DGPTFMT=1 D FDT
 I Z>Y S DGPTFMT=2
 K Z
 Q
 ;
FDT ; -- set new format date for testing
 S Y=2901000 Q
 ;
UPDT ; -- update PTF record w/PTF and DFN defined
 I '$D(^DGPT(PTF,0)) W:'$D(ZTQUEUED) !!,*7,">>> PTF record #",PTF," does not exist." G UPDTQ
 S X=^(0)
 I $P(X,U,11)>1 W:'$D(ZTQUEUED) !!,*7,">>> Record #",PTF," is not a PTF record." G UPDTQ
 S DGPTFE=$P(X,U,4),(DGADM,AD)=+$P(X,U,2),DGST=$D(^DGP(45.84,PTF))>0
 I DGST W:'$D(ZTQUEUED) !!,*7,">>> PTF record #",PTF," is closed out. No updating allowed." G UPDTQ
 I DGPTFE W:'$D(ZTQUEUED) !!,*7,">>> PTF record #",PTF," is a fee PTF record. No updating is possible." G UPDTQ
 N DGPMCA,DGPMAN D PM
 I DGPMCA D:'$P(^DGPT(PTF,0),U,5) SUF^DGPTF D LE^DGPTTS,DC^DGPTF
 ;
UPDTQ K AGE,D0,D1,DA,DGADM,DGLAST,DGP,DGTY,DIC,DIE,DR,DIV,DIU,DISYS,DIK,DIKLM,DIG,DIH,DI,DIW,DIWL,DIWR,DIWT,DN,DOB,DQ,DG,DRG,SEX,TY,L,P1,DIS2,DGPTFE,DGST,DGX,DFN1,DFN2,PR,I1,TDD,AD
 Q
 ;
EXPL ; -- explode string A(input) to DGA(output)
 N J,L S DGA=$E(A,2,999)
 I DGA["-" S X=DGA,DGA="" F J=1:1 S L=$P(X,",",J) Q:'L  D EXPL1:L["-" S:L]"" DGA=DGA_L_"," Q:$P(X,",",J+1,999)=""
 Q
 ;
EXPL1 ; -- explode string 'L' of form "1-12" ; input and output is 'L'
 N I,X
 I $P(L,"-")'?1N.N!($P(L,"-",2,999)'?1N.N) S L="" G EXPL1Q
 I +L>$P(L,"-",2) S L="" G EXPL1Q
 I +L=+$P(L,"-",2) S L=+L G EXPL1Q
 S X="" F I=+L:1:+$P(L,"-",2) Q:($L(X)+$L(I)+1)>240  S X=X_I_","
 S L=$E(X,1,$L(X)-1)
EXPL1Q Q
 ;
CKPOS(ADEL,DEFAULT) ;-- This function will check the admitting eligibility
 ; and the POS to make sure for Non-Vet eligibilities that a
 ; 9 - Other or None POS is present.
 ;
 ;  INPUT - ADEL : Admitting Eligibility (Pointer to file 8)
 ;       DEFAULT : Default POS (optional) (Pointer to file 21)
 ;  OUTPUT- POS : POS Code. 0 - Error
 ;
 N RESULT,X,Y
 ;If DFN is not needed here, kill DFN to avoid VADPT error out.
 I $G(DFN)="" N DFN S DFN=$G(DGSDFN) I $G(DFN)="" K DFN
 D ELIG^VADPT
 I $D(VAEL(1))=1 S RESULT=$G(DEFAULT) G CKPOSQ
 S RESULT=0,Y=$G(DEFAULT)
 I '$D(^DIC(8,+ADEL,0)) G CKPOSQ
 S X=$G(^DIC(8.1,$P($G(^DIC(8,+ADEL,0)),U,9),0))
 ;-- if non vet set POS to Other
 I $P(X,U,5)="N" S RESULT=9
 ;-- if vet then use default
 I $P(X,U,5)="Y",Y'="" S RESULT=Y
CKPOSQ ;
 Q RESULT
 ;

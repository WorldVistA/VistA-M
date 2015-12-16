DGPTF5 ;ALB/MTC/PLT - PTF ENTRY/EDIT-4 ;07 JUN 91 
 ;;5.3;Registration;**669,701,744,868,850,884**;Aug 13, 1993;Build 31
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
Z I 'DGN S Z=$S(IOST="C-QUME"&($L(DGVI)'=2):Z,1:"["_Z_"]") W @DGVI,Z,@DGVO
 E  W "   "
 Q
 ;
Z1 F I=1:1:(Z1-$L(Z)) S Z=Z_" "
 W Z
 Q
 ;
CEN ;
 W !!,*7,"Record #",PTF," MUST be closed for CENSUS first.",!
ASK W !,"Would you like to close this record for CENSUS" S %=2 D YN^DICN
 I '% W !?5,"Answer 'YES' to close record for CENSUS also",!?5,"  or   'NO'  to not close this record at all." G ASK
 I %=1 S Y=2 D RTY^DGPTUTL D CLS^DGPTC1
 K DGRTY,DGRTY0 Q
ICDEN ;enter icd codes
 I $G(X)["?" Q
 N DIC,Y I $G(X)="?BAD" S X="" Q
 ; DG*5.3*701 (movement)
 I DA'=$G(DGPTF),DA<25,$G(DA(1))>0 D CONFIG^LEXSET("ICD","ICD",$E($$GETDATE^ICDGTDRG(DA(1)),1,7)) ;868 patch,$E($$getdate...),1,7)
 ; DG*5.3*744 (801 screen)
 E  I DA'=$G(PTF),$D(^DGPT(PTF)) D CONFIG^LEXSET("ICD","ICD",$E($$GETDATE^ICDGTDRG($G(PTF)),1,7)) ;868 patch
 E  D CONFIG^LEXSET("ICD",,$E($$GETDATE^ICDGTDRG(DA)),1,7) ;patch 868
 S DIC="^LEX(757.01,",DIC(0)=$S('$L($G(X)):"",1:"")_"EQM"
 S DIC("A")="Enter ICD: "
 D ^DIC
 I Y=-1 S X="" Q
 S X=$G(Y(1))
 Q
ICDEN1 ;enter icd codes for DRG
 ; called from DGPTFIC and DGPTDRG
 ; removed kills to X and Y and set for DIC("A")to suppress prompts DG*5.3*850
 N DIC,EFFDATE,IMPDATE,TERM,DGTEMP,LEXVDT
 I '$G(DGDAT) S DGDAT=DT
 S EFFDATE=DGDAT
 S DGTEMP=$$IMPDATE^DGPTIC10("10D")
 S IMPDATE=$P(DGTEMP,U,1)
 ;
 ; What terminology to use, ICD9 or ICD10
 I DGDAT<IMPDATE S TERM="ICD"
 I DGDAT'<IMPDATE S TERM="10D"
 ;
 ; I Testing, set effective date to one stored in file 43
 ;piece 2 of dgtemp has no 7n value and code below removed
 ;I EFFDATE'<IMPDATE,+$P(DGTEMP,U,2)?7N S EFFDATE=+$P(DGTEMP,U,2)
 ;
 I $G(PROMPT)'="" S DIC("A")=PROMPT
 D CONFIG^LEXSET(TERM,TERM,EFFDATE)
 S DIC="^LEX(757.01,",DIC(0)=$S('$L($G(X)):"",1:"")_"EQM"
 D ^DIC
 I Y=-1 S X="" Q
 S:TERM="ICD" X=$G(Y(1))
 S:TERM="10D" X=$G(Y(30))
 S Y=$$ICDDATA^ICDXCODE("DIAG",X,EFFDATE)
 K LEXVDT
 Q
GETICD9(EFFDATE) ;enter icd codes
 N DGXT,DIC,Y,LEXVDT,CUR,ICDV,LEXQ,DO,DISYS,DGY
 I $G(X)="?BAD" S X="" G GET9Q
 D CONFIG^LEXSET("ICD",EFFDATE)
 S DIC="^LEX(757.01,",DIC(0)=$S('$L($G(X)):"",1:"")_"EQM"
 S DIC("A")="Enter ICD: "
 S LEXVDT=EFFDATE
 D ^DIC
 I Y=-1 S X="" G GET9Q
 S DGXT=$G(Y(1))
 S X=+$$CODEN^ICDEX(DGXT,80)
GET9Q ; exit point
 Q X

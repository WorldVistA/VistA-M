DGPTF5 ;ALB/MTC - PTF ENTRY/EDIT-4 ; 07 JUN 91 
 ;;5.3;Registration;**669,701,744**;Aug 13, 1993;Build 5
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
 I DA'=$G(DGPTF),DA<25,$G(DA(1))>0 D CONFIG^LEXSET("ICD",,$$GETDATE^ICDGTDRG(DA(1)))
 ; DG*5.3*744 (801 screen)
 E  I DA'=$G(PTF),$D(^DGPT(PTF)) D CONFIG^LEXSET("ICD",,$$GETDATE^ICDGTDRG($G(PTF)))
 E  D CONFIG^LEXSET("ICD",,$$GETDATE^ICDGTDRG(DA))
 S DIC="^LEX(757.01,",DIC(0)=$S('$L($G(X)):"",1:"")_"EQM"
 S DIC("A")="Enter ICD: "
 D ^DIC
 I Y=-1 S X="" Q
 S X=$G(Y(1))
 Q
ICDEN1 ;enter icd codes for DRG
 N DIC K X,Y
 D CONFIG^LEXSET("ICD",,$G(DGDAT))
 S DIC="^LEX(757.01,",DIC(0)=$S('$L($G(X)):"",1:"")_"EQM"
 S DIC("A")=PROMPT
 D ^DIC
 I Y=-1 S X="" Q
 S X=$G(Y(1))
 S Y=$$ICDDX^ICDCODE(X,$G(DGDAT))
 Q

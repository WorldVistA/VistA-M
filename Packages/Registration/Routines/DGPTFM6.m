DGPTFM6 ;ALB/BOK/ADL - 601 SCREEN: PROCEDURE ENTER/EDIT ;21 JUL 88 @ 0900
 ;;5.3;Registration;**164,510,729,850,898**;Aug 13, 1993;Build 3
 ;;ADL;Update for CSV Project;;Mar 26, 2003
EN ; Entry point - begin date checks
 I $D(^DGPTF(PTF,70)),+^(70)<2871000 W !!,"Data cannot be entered into these fields until after 10/1/1987" H 5 G ^DGPTFM
 I DT<2871000 W !!,"Data can not be entered into these fields until after 10/1/1987" H 5 G ^DGPTFM
 G @($S(X=6:"E",1:X))
T ;ADD PROCEDURE RECORD
 S DGZP=0 S:'$D(^DGPT(PTF,"P",0)) ^(0)="^45.05DA^^"
 S DIC="^DGPT("_PTF_",""P"",",DIC(0)="AEQLMZ",DA(1)=PTF D ^DIC G ^DGPTFM:Y'>0!('$D(^DGPT(PTF,"P",+Y))) S DGPROCM=+Y,DGPROCD=$P(Y,U,2) D MOB I DGPC F I=1:1:DGPC S:P(I,1)=DGPROCM DGZP=I
 G:'DGZP ^DGPTFM S DGPROC(DGZP)=DGPROCM,X="1,2"
EDIT ;
 G HELP:X<1!(X>2) S DIE="^DGPT(",(DA,DGPTF)=PTF,DR="[DG601]",DGJUMP=X
 S DIE="^DGPT(",DGJUMP=X D ^DIE,CHK601^DGPTSCAN K DR,DIE,DIC,DA,DGADD,DGJUMP D MOB
SET D MOB:'$D(P) S:'$D(DGZP) DGZP=1 S P(DGZP,1)=$S($D(P(DGZP,1)):P(DGZP,1),1:"") I P(DGZP,1)="" K P(DGZP) G NEXP
 S (P1,P(DGZP))=$S($D(^DGPT(PTF,"P",P(DGZP,1),0)):^(0),1:"")
WRT ;
 N EFFDATE,IMPDATE
 D EFFDATE^DGPTIC10(PTF)
 G:'$D(^DGPT(PTF,"P",P(DGZP,1),0)) ^DGPTFM S DGPROCI=^(0) W @IOF,HEAD,?68 S Z="<601-"_DGZP_">" W @DGVI,Z,@DGVO,!! S (Y,L)=+P(DGZP),Z=1 D D^DGPTUTL,Z^DGPTFM5 W $J("Date of Proc:  ",32),Y,!,$J("Specialty:  ",35)
 W $S($D(^DIC(42.4,+$P(P(DGZP),U,2),0)):$P(^(0),U),1:""),! I $P(P(DGZP),U,4) W "   Number of Dialysis Treatments:  ",$P(P(DGZP),U,4),!
 W !! S Z=2 D Z^DGPTFM5 W "  Procedures: ",$$GETLABEL^DGPTIC10(EFFDATE,"P")
 F I=1:1:5 S L=$P(P(DGZP),U,4+I) I L D
 . S DGPTTMP=$$ICDDATA^ICDXCODE("PROC",+L,EFFDATE)
 . D WRITECOD^DGPTIC10("PROC",+L,EFFDATE,2,1,7) W $S(+DGPTTMP<1!('$P(DGPTTMP,U,10)):"*",1:"") ;W !?7
 F I=1:1:(IOSL-$Y-5) W !
 S DGNUM=$S($D(P(DGZP+1)):601_"-"_(DGZP+1),1:"MAS") G 601^DGPTFJC:DGST
 W "Enter <RET> to continue, 1-2 to edit,",!,"'T' to add a Procedure Segment, '^N' for screen N, or '^' to abort: <",DGNUM,">//"
 R X:DTIME S:'$T X="^",DGPTOUT=""
 K DGNUM G Q^DGPTF:X="^"
 I X?1"^".E S DGPTSCRN=601 G ^DGPTFJ
 G T:X="T"!(X="t"),HELP:X["?"
 I X[1!(X[2) S DA=+P(DGZP) G EDIT
 I X'="" G HELP
NEXP ;S DGZP=DGZP+1 G ^DGPTFM:'$D(P(DGZP)),SET
 S DGZP=DGZP+1 I '$D(P(DGZP)) S DGZP=1 G ^DGPTFM
 G SET
HELP W !,"Enter '^' to stop display and edit of data",!,"'^N' to jump to screen #N (appears in upper right of screen as <N>)",!,"<RET> to continue on to next screen or 1-2 to edit:"
 W !?10,"1-Procedure information",!,?10,"2-Procedure codes",!,"You may also enter any combination of the above, separated by commas (ex:1,2)",!
 R !!,"Enter <RET>: ",X:DTIME G WRT
MOB K P,P1,P2 S (I,P2)=0 F I1=1:1 S I=$O(^DGPT(PTF,"P",I)) Q:I'>0  S P(I1)=^(I,0),P(I1,1)=I I P(I1)']"" K P(I1) S I1=I1-1
 S DGPC=I1-1 Q
BS ;CALLED FROM [DG601]
 S I=$O(^DGPT(PTF,"M","AM",^DGPT(PTF,"P",DA,0)-.0000001)),I=$O(^(+I,0))
 S DGMOVM=$S($D(^DGPT(PTF,"M",$S(I:I,1:1),0)):$P(^(0),U,2),1:"")
 Q
R ;DELETE PROCEDURE RECORD
 G R^DGPTFM4
E ;EDIT PROCEDURE RECORD
 G E^DGPTFM1
P I $D(^DGPT(PTF,70)),+^(70)<2871000 G FY86
 I DT<2871000 G FY86
 S L="" F I=1:1:DGPC S L2=1 F J=5:1:9 I L2,$P(P(I),U,J)="" S L=L_I_",",L2=0
 I L="" W !!,"There are no procedure records that can be added to.",*7 H 2 G ^DGPTFM
 S L=$E(L,1,$L(L)-1) I L=+L S DGRC=+L G P2
P1 I 'Z W !!,"Add to procedure record <",L,"> : " R DGRC:DTIME G ^DGPTFM:DGRC[U!(DGRC="")
 E  S DGRC=+$E(A,2,99)
P2 I +DGRC'=DGRC!(","_L_","'[(","_DGRC_",")) W !!,"Enter the procedure record number to add ICD operation codes to: ",L G P1:'Z S Z="" G P1
 S DP=45.05,DIE="^DGPT("_PTF_",""P"",",DA(1)=PTF,DR="" F I=5:1:9 I $P(P(DGRC),U,I)="" S DR=DR_(I-1)_";"
 S DR=$E(DR,1,$L(DR)-1),DA=+P(DGRC,1),DA(1)=PTF D ^DIE K DR,DIE G ^DGPTFM
FY86 S DR="" F J=1:1:5 I $P(PROC,U,J)="" S DR=DR_(J/100+45)_";"
 I DR="" W !!,"No more procedures can be added.",*7 H 2 G ^DGPTFM
 S DR=$E(DR,1,$L(DR)-1),DP=45,DIE="^DGPT(",DA=PTF D ^DIE K DR,DIE G ^DGPTFM
GETVAR ;CALLED FROM GET+1^DGPTFM
 S PM=I1-1,I=0 F I1=1:1 S I=$O(^DGPT(PTF,"S",I)) Q:I'>0  S S(I1)=^(I,0),S(I1,1)=I
 K P2 S SU=I1-1 S PROC=$S($D(^DGPT(PTF,"401P")):^("401P"),1:""),P2=0 F J1=1:1:5 S:$P(PROC,U,J1) P2=P2+1,P2(P2)=J1
 K P S I=0 F I1=1:1 S I=$O(^DGPT(PTF,"P",I)) Q:I'>0  S P(I1)=^(I,0),P(I1,1)=I
 Q
 ;
BADDT(DGPROCD) ; Check patients admit date and entered date against census DATE
 ; If admit date is after census date then we're done
 ; checks to see if Patient has been discharged or has a closed census and returns false 
 ; If not discharged or closed and the admit and procedure date is within census date range then return false
 ; If admit date and procedure date is past the date range then return true
 S:$G(DGADM)="" DGADM=$P(^DGPT(DA(1),0),U,2) ; DGADM gets killed at end of option
 I $G(DGPROCD,0)<DGADM D EN^DDIOL("Not Before Admission ") Q 1
 I $G(DGPROCD,0)>($S($D(^DGPT(DA(1),70)):$S(+^(70):+^(70),1:9999999),1:9999999)) D EN^DDIOL("Not After discharge") Q 1
 I (DGADM>DGPTDAT) Q 0 ; Admit date is after census date
 I ($G(DGADM,$P(^DGPT(PTF,0),U,2))>DGPTDAT) Q 0 ; Admit date is after census date
 K DGI N DG601DT
 F DGI=0:0 S DGI=$O(^DGPT("ACENSUS",PTF,DGI)) Q:'DGI  I $D(^DGPT(DGI,0)),$P(^(0),U,12)=PTF,$D(^DG(45.86,+$P(^(0),U,13),0)) S Y=+^(0) X ^DD("DD") S DGI(DGI)=Y
 Q:($D(DGI)>1) 0 ;Closed Census
 I $D(^DGPT(PTF,70)),$P($G(^(70)),U)'="" Q 0 ; Patient has been discharged
 S DG601DT=$S($G(DGPROCD):DGPROCD,1:$G(EFFDATE))
 Q:(DGADM<(DGPTDAT+.09))&(DG601DT<(DGPTDAT+.09)) 0 ;Admit and procedure Date in Census Range
 D EN^DDIOL("Not After Census Date") Q 1 ; Reject date

DGPTFM0 ;ALB/MAC/ADL - ROUTINE TO DISPLAY PROCEDURE CODES ON THE MAS SCREEN IN PTF LOAD/EDIT ;AUG 1 1989@1200
 ;;5.3;Registration;**510,517,850**;Aug 13, 1993;Build 171
 ;;ADL;;Update for CSV Project;;Mar 25, 2003
EN ;
 N EFFDATE,IMPDATE
 D EFFDATE^DGPTIC10(PTF)
 S I=0 K P F I1=1:1 S I=$O(^DGPT(PTF,"P",I)) Q:I'>0  S P(I1)=^(I,0),P(I1,1)=I
 S P2=0,(L6,P)=0 F J=ST:1:(I1-1) S NL=1,L5=0,L6=J D PD2 D PD G PRO1^DGPTFM:$Y>12 W !
 G PRO^DGPTFM
PD ;
 F J1=1:1:5 S L=$P($G(P(J)),U,J1+4),L1=0,L3=1 D:+L PD1
 Q
PD1 ;
 N J2
 S J2=$$ICDDATA^ICDXCODE("PROC",+L,EFFDATE)
 S P2=P2+1
 W !,?L1,$J(P2,3)," " D WRITECOD^DGPTIC10("PROC",+L,EFFDATE,1,0,0) W $S(+J2<1!('$P(J2,U,10)):"*",1:"")
 K P2(P2) S P2(P2)=J+L1_U_J1
 Q
PD2 ;
 S Y=+$G(P(L6)) D D^DGPTUTL W !,L6,"-Procedure date: ",Y,$$GETLABEL^DGPTIC10(EFFDATE,"P")
 Q
PRC ;
 K DGZSER,DGZDIAG,DGZPRO S DGZSUR=1,J=0
 G:$G(DGMMORE) PRO1^DGPTFM:$Y>12
 K P1,P2 S ST=1,P2=0
 S ST=1 G EN
 ;
C ; -- help for surgery
 W !!,"Enter the item #'s of the operation codes, 1-",S2,", that you wish to delete:"
 F L=1:1:S2 Q:'$D(S2(L))  I $D(S(+S2(L),1)),$D(^DGPT(PTF,"S",+S(+S2(L),1),0)) D
 . W !?5,$J(L,2),": " D WRITECOD^DGPTIC10("PROC",+$P(^(0),"^",7+$P(S2(L),"^",2)),EFFDATE,1,0,0)
 . W !,"here",*7
 Q
 ;
DX ; -- help for dx's
 W !!,"Enter the item #'s of the diagnoses, 1-",M2,", that you wish to delete:"
 S UTL="^UTILITY($J,""M2"")"
 F L=1:1:M2 Q:'$D(@UTL@(L))  I $D(^DGPT(PTF,"M",+@UTL@(L),0)) D
 . W !?5,$J(L,2),": " D WRITECOD^DGPTIC10("DIAG",+$P(^(0),"^",4+$P(@UTL@(L),"^",2)),EFFDATE,1,0,0)
 K UTL,L Q
 ;
Q ; -- help for procedure
 W !!,"Type the number of the procedure - not the procedure code -"
 W !,"for the procedure you wish to delete.",!
 W !,"However, this deletion function is not applicable"
 W !,"for procedures listed under 'Procedure date:' displays."
 W !,"Delete these codes using the 601 screen functionality."
 Q
 ;
D G DEL:Z
 I $D(M2),'M2 W !,"No codes to delete",! H 2 G ^DGPTFM
D1 R !!,"Enter the item #'s of the ICD Diagnosis codes to delete: ",A1:DTIME
 I A1'?1N.NP G ^DGPTFM:"^"[A1 W:A1'["?" "  ???",*7 D DX G D1
 S A=A_A1
DEL D EXPL^DGPTUTL
 K X,A1 S DIE="^DGPT("_PTF_",""M"",",DA(1)=PTF W !!
 F J=1:1 S DP=45.02,L=+$P(DGA,",",J) Q:'L  S L1=$S($D(^UTILITY($J,"M2",L)):^(L),1:"Undefined, ") W:'L1 " ",L,"-",L1 I L1 S DA=+L1,DR=4+$P(L1,U,2)_"///@",DA(1)=PTF D ^DIE K DR W " ",L,"-Deleted, " W:$X>70 !
 S DGPTF=PTF,DGMOV=+L1 D CHK501^DGPTSCAN
 H 2 G ^DGPTFM
 Q
 ;

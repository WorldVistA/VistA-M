DGPTFMO1 ;ALB/AS - DGPTF PRINT TEMPLATE (cont) ; 5 FEB 90 14:00
 ;;5.3;Registration;**54**;Aug 13, 1993
 ;
PTF ; -- PTF inquiry
 S FLDS="[DGPTF]"
 S DIC("S")="I $P(^(0),U,11)=1,DG1'[(U_+Y_U)"
 D INQ Q
 ;
CEN ; -- census inquiry
 S FLDS="[DGPT CENSUS INQUIRY]"
 S DIC("S")="N DGPTIFN S DGPTIFN=Y D SCR^DGPTFMO1"
 D INQ Q
INQ ;
 K ^TMP("DGPT INQ",$J)
 S DG1=U,(DIC,DI)="^DGPT(",DIC(0)="AEMQ",L=+$P(^DGPT(0),U,2)
 F DGZZ=1:1 D ^DIC Q:Y'>0  S ^TMP("DGPT INQ",$J,DGZZ,+Y)="",DG1=DG1_+Y_U,DIC("A")="ANOTHER ONE: " Q:$L(DG1)>230
 K DGZZ I '$D(^TMP("DGPT INQ",$J))!(X=U) G Q
 S ZTSAVE("^TMP(""DGPT INQ"",$J,")="",DIOEND="K ^TMP(""DGPT INQ"",$J)"
 S BY="#PATIENT",(FR,TO)="",BY(0)="^TMP(""DGPT INQ"",$J,",L=0,L(0)=2 D EN1^DIP
 K ZTSAVE("^TMP(""DGPT INQ"",$J,")
Q K DGPMCA,DGPMAN,DIC,DI,X,DFN,DG1,DGAD,DGADM,FLDS,L,Y,^TMP("DGPT INQ",$J) Q
 ;
SCR ; -- screen to find census recs or ptf needing census
 ;  input: DGPTIFN ifn of 45
 ; output: $T
 ;
 N DGTEST,I,DGCUR,PTF,DGCI,D0,Y
 I $P(^DGPT(DGPTIFN,0),U,11)=2 S DGTEST=1 G SCRQ
 S DGTEST=0,DGCUR=$O(^DG(45.86,"AC",1,0))
 I DGCUR F I=0:0 S I=$O(^DG(45.85,"PTF",DGPTIFN,I)) Q:'I  I $D(^DG(45.85,I,0)),$P(^(0),"^",4)=DGCUR S DGTEST=1,D0=I D CREC^DGPTCO1 S:X DGTEST=0 Q
SCRQ I DGTEST
 Q
 ;
OPT ; -- screen for comp rpt ; NEW command doesn't pass DIM
 Q:'$D(^DGPT(D0,0))  N DGPTIFN S DGPTIFN=D0 D SCR
 Q

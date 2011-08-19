DGPZ07P ;BAJ - HL7 Z07 CONSISTENCY CHECKER -- PRINT ROUTINE ; 06/30/06
 ;;5.3;Registration;**653**;Aug 13,1993;Build 2
 ;
 ; This routine prints the inconsistency report for the Z07 Consistency Check option
 ; This routine is copied from DGRPCP1 and modified for a single DFN
 ; 
ST N DGSTOP,ZTSTOP,CRT,%,DGCLK1,I,J,X,Y,Z,DGCT,DGPG,DGDATA,DGDFN,DGER,DGHDR,DGINC,DGOFF,DGSSN,DGSTORE,DGZ,I1,I2,X1
 S CRT=$S($E(IOST,1,2)="C-":1,1:0)
 S DGDATA=^DGIN(38.5,DFN,0) I $D(^DPT(DFN,0)) D SET I $$FIRST^DGUTL G Q
 S DGPG=0,DGHDR="INCONSISTENT ELEMENTS FOR "_$P(^DPT(DFN,0),"^",1)_"     "_$P(^DPT(DFN,0),"^",9) D HDR
 S I=0 F I1=0:0 S I=$O(^UTILITY($J,"DGINC",I)) Q:I=""  F I2=0:0 S I2=$O(^UTILITY($J,"DGINC",I,I2)) Q:'I2  G:$G(DGSTOP) Q  S X=^(I2) D W
 D TRA
Q K %,%DT,DGVAR,DGER,DFN,DGPGM,^UTILITY($J,"DGINC")
 D ENDREP^DGUTL,CLOSE^DGUTQ
 Q
W W !,$P(X,"^",1),?31,$P(X,"^",2),?$S($E($P(X,"^",3))="*":43,1:45),$P(X,"^",3) I $S(CRT:$Y>20,1:$Y>45) D
 . D:'CRT TRA S DGSTOP=$$SUBSEQ^DGUTL
 . D HDR
 Q
HDR Q:$G(DGSTOP)  S DGPG=DGPG+1 W !,DGHDR
 W:DGPG>1 ?73,"Page "_DGPG W !,"Patient Name",?31,"Soc Sec #",?45,"Inconsistent/Missing Data Elements"
 S X1="",$P(X1,"=",80)="" W !,X1,!
 Q
TRA S DGCT=0,X1="",$P(X1,"*",80)="" X "F DGZ=$Y:1:$S($D(IOSL):(IOSL-10),1:41) W !"
 W !!,X1,!,"An inconsistent Data element preceded by '**' prevents a Z07"
 W !,"record from being sent to the HEC.",!,X1
 Q
SET S DGDFN=^DPT(DFN,0),DGSSN=$P(DGDFN,"^",9),DGSTORE=$S($P(DGDFN,"^",1)]"":$P(DGDFN,"^",1),1:"UNIDENTIFIED PATIENT #"_DFN)_" "_$E(DGSSN,8,9)_$E(DGSSN,6,7)_$E(DGSSN,4,5)_$E(DGSSN,1,3),DGINC="",DGLOOP=0
 F J=0:0 S J=$O(^DGIN(38.5,DFN,"I",J)) Q:'J  D
 . Q:'$D(^DGIN(38.6,J))
 . S DG6=$P(^DGIN(38.6,J,0),"^",6) I DG6'=1 S DG6=0
 . S DGTEXT=$P(^DGIN(38.6,J,0),"^",1) I DG6 S DGTEXT="**"_DGTEXT
 . ; set up variables
 . S DGLOOP=DGLOOP+1
 . ; print full first record, abbreviated subsequent records
 . I DGLOOP=1 S ^UTILITY($J,"DGINC",DGSTORE,DGLOOP)=$S($P(DGDFN,"^",1)]"":$P(DGDFN,"^",1),1:"UNIDENTIFIED PATIENT #"_DFN)_U_$P(DGDFN,"^",9)_U_DGTEXT Q
 . S ^UTILITY($J,"DGINC",DGSTORE,DGLOOP)="^^"_DGTEXT
 K J,DGINC,DGSSN,DGDFN,DGLOOP,DGSTORE,DG6,DGCHK,DGTEXT
 Q
 ;

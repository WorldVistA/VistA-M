DGRPCP1 ;ALB/MRL/BAJ - CONSISTENCY PRINT, CONTINUED ; 10/18/2005
 ;;5.3;Registration;**108,161,653**;Aug 13, 1993;Build 2
 ;
 ; DG*5.3*653 BAJ 10/18/2005
 ; enhanced for Z07 Consistency check project
 ; 1. Allow filtering on Reg/Z07 Inconsistency (see ^DGRPCP)
 ; 2. Print Short description instead of Inconsistency Number
 ; 3. Fix report to end if user enters "^" at prompt
 ; 4. Fix report to display message if no records match.
 ; 
 ; 
ST N DGSTOP,ZTSTOP
 G I:$E(DGHOW)="I",A:($E(DGHOW)="A")
 F I=DGFRD:0 S I=$O(^DPT("ADIS",I)) Q:'I!(I>DGTOD)  F DFN=0:0 S DFN=$O(^DPT("ADIS",I,DFN)) Q:('DFN)!($G(ZTSTOP))  I $D(^DGIN(38.5,DFN,0)) S DGDATA=^(0) I $D(^DPT(DFN,0)) D SET
 G PR
A F I=DGFRD:0 S I=$O(^DGPM("ATT1",I)) Q:'I!(I>DGTOD)  F I1=0:0 S I1=$O(^DGPM("ATT1",I,I1)) Q:('I1)!($G(ZTSTOP))  I $D(^DGPM(+I1,0)) S DFN=$P(^(0),"^",3) I $D(^DGIN(38.5,DFN,0)) S DGDATA=^(0) I $D(^DPT(DFN,0)) D SET
 G PR
I S DGTOD1=9999999-DGTOD,DGFRD1=9999999-DGFRD,I=DGTOD1
 F I1=0:0 S I=$O(^DGIN(38.5,"AC",I)) Q:'I!(I>DGFRD1)  F DFN=0:0 S DFN=$O(^DGIN(38.5,"AC",I,DFN)) Q:('DFN)!($G(ZTSTOP))  I $D(^DGIN(38.5,DFN,0)) S DGDATA=^(0) I $D(^DPT(DFN,0)) D SET
PR I $$FIRST^DGUTL G Q
 S DGPG=0,DGHDR="INCONSISTENT ELEMENTS FOR PATIENTS WITH A",Y=DGFRD X ^DD("DD") S DGFRD1="'"_Y_"'" I $P(DGTOD,".",1)'=DGFRD S Y=$P(DGTOD,".",1) X ^DD("DD") S DGFRD1=" BETWEEN "_DGFRD1_" AND '"_Y_"'"
 E  S DGFRD1=" OF "_DGFRD1
 S DGHDR=DGHDR_$S($E(DGHOW)="R":"",1:"N")_" "_$P(DGHOW,"^",2)_DGFRD1 G Q:$G(DGSTOP) D HDR S I=0
 I '$D(^UTILITY($J,"DGINC")) W !!,"** NO RECORDS MATCH SELECTION CRITERIA **",!! G Q
 F I1=0:0 S I=$O(^UTILITY($J,"DGINC",I)) Q:I=""  F I2=0:0 S I2=$O(^UTILITY($J,"DGINC",I,I2)) Q:'I2  G:$G(DGSTOP) Q  S X=^(I2) D W
 D TRA G Q
W S DGCLK=$S(I2=1:$E($S($D(^VA(200,+$P(X,U,5),0)):$S($P(^(0),U,2)]"":$P(^(0),U,2),1:$P(X,U,5)),$P(X,U,5)="":"Missing",1:$P(X,U,5)),1,9),1:"")
 W !,$P(X,"^",1),?33,$P(X,"^",2),?56,$P(X,"^",3),?67,$TR($$FMTE^XLFDT($P(X,"^",4),"5DZ"),"/","-"),?78,DGCLK,?$S($E($P(X,"^",6))="*":87,1:89),$P(X,"^",6) I $Y>40 D TRA I $$SUBSEQ^DGUTL S DGSTOP=1 D HDR
 Q
HDR Q:$G(DGSTOP)  S DGPG=DGPG+1,X=$S($D(IOM):(IOM-13),1:119) W !,DGHDR,", PAGE ",DGPG,?X,Y,!?67,"Last Day",?78,"Last",!,"Patient Name",?33,"Home Phone #",?56,"Soc Sec #",?67,"ID'ed",?78,"Edited by",?89,"Inconsistent/Missing Data Elements"
 S X1="",$P(X1,"=",131)="" W !,X1,! Q
TRA S DGCT=0,X1="",$P(X1,"*",131)="" X "F DGZ=$Y:1:$S($D(IOSL):(IOSL-25),1:41) W !"
 W !,X1,!,"An inconsistent Data element preceded by '**' prevents a Z07 record from being sent to the HEC.",!
 Q
SET S DGDFN=^DPT(DFN,0),DGSSN=$P(DGDFN,"^",9),DGSTORE=$S(DGHOW1="N":$S($P(DGDFN,"^",1)]"":$P(DGDFN,"^",1),1:"UNIDENTIFIED PATIENT #"_DFN),1:" "_$E(DGSSN,8,9)_$E(DGSSN,6,7)_$E(DGSSN,4,5)_$E(DGSSN,1,3)),DGINC="",DGLOOP=0
 F J=0:0 S J=$O(^DGIN(38.5,DFN,"I",J)) Q:'J  D
 . Q:'$D(^DGIN(38.6,J))
 . ; only print the records requested by the user
 . S DG6=$P(^DGIN(38.6,J,0),"^",6) I DG6'=1 S DG6=0
 . S DGFILT=$G(DGFILT),DGCHK=$S(DGFILT="R":0,DGFILT="Z":1,1:DG6)
 . Q:DGCHK'=DG6
 . ;S DGTEXT=$J(J,3)_" "_$P(^DGIN(38.6,J,0),"^",1) I DG6 S DGTEXT="**"_DGTEXT
 . S DGTEXT=$P(^DGIN(38.6,J,0),"^",1) I DG6 S DGTEXT="**"_DGTEXT
 . ; set up variables
 . S DGLOOP=DGLOOP+1
 . S DGCLK1=$S($P(DGDATA,U,5):$P(DGDATA,U,5),1:$P(DGDATA,U,3))
 . S DGPHONE=$P($G(^DPT(DFN,.13)),U,1)
 . ; print full first record, abbreviated subsequent records
 . I DGLOOP=1 S ^UTILITY($J,"DGINC",DGSTORE,DGLOOP)=$S($P(DGDFN,"^",1)]"":$P(DGDFN,"^",1),1:"UNIDENTIFIED PATIENT #"_DFN)_"^"_DGPHONE_"^"_$P(DGDFN,"^",9)_"^"_$P(DGDATA,"^",4)_"^"_DGCLK1_U_DGTEXT Q
 . S ^UTILITY($J,"DGINC",DGSTORE,DGLOOP)=""_"^"_""_"^"_""_"^"_""_"^"_""_U_DGTEXT
 K J,DGINC,DGSSN,DGDFN,DGLOOP,DGSTORE,DG6,DGCHK,DGTEXT
 Q
 ;
Q K %,%DT,DGCLK,DGCLK1,DGFRD,DGHOW,DGHOW1,DGTOD,DGVAR,I,J,X,Y,Z,DGCT,DGCONRUN,DGDATA,DGDFN,DGEDCN,DGER,DGFRD1,DGHDR,DGINC,DGOFF,DGPG,DGPGM,DGSSN,DGSTORE,DGTOD1,DGZ,I1,I2,X1,^UTILITY($J,"DGINC"),DGSTOP,ZTSTOP,DGPHONE
 D ENDREP^DGUTL,CLOSE^DGUTQ Q

SROAPAS ;BIR/MAM - PRINT A COMPLETE ASSESSMENT ;05/28/10
 ;;3.0; Surgery ;**38,47,81,88,111,112,100,125,153,166,174**;24 Jun 93;Build 8
 S SRSOUT=0,SRPG=0,SR("RA")=$G(^SRF(SRTN,"RA")),SRATYPE=$P(SR("RA"),"^",2) F I=200:1:208,200.1 S SRA(I)=$G(^SRF(SRTN,I))
 S SRA("OP")=^SRF(SRTN,"OP"),SRA("CON")=$G(^SRF(SRTN,"CON"))
 S SR(0)=^SRF(SRTN,0),DFN=$P(SR(0),"^"),SRSDATE=$P(SR(0),"^",9) D DEM^VADPT S SRANM=VADM(1)_"  "_VA("PID"),Z=$P(VADM(3),"^"),Y=$E(SRSDATE,1,7),AGE=$E(Y,1,3)-$E(Z,1,3)-($E(Y,4,7)<$E(Z,4,7))
 I $P(SR("RA"),"^",2)="C" D ^SROAPCA G END
 W:$E(IOST)'="P" @IOF D HDR G:SRSOUT END
 W !,"Medical Center: "_SRSITE("SITE")
 W !,"Age: ",?16,AGE S Y=SRSDATE D D^DIQ W ?40,"Operation Date: ",?59,$P(Y,"@")
 S Y=$P($G(^SRF(SRTN,208)),"^",10),C=$P(^DD(130,417,0),"^",2) D Y^DIQ S X=$S(Y'="":Y,1:"NOT ENTERED")
 ;
 D DEM^VADPT
 ;Find patient's ethnicity
 S SROETH=""
 I $G(VADM(11)) S SROETH=$P(VADM(11,1),U,2)
 I '$G(VADM(11)) S SROETH="UNANSWERED"
 ;
 ;Find all race entries and place into a string with commas inbetween
 S SRORC=0,C=1,SRORACE="",SROLINE="",N=1,SROL=""
 F  S SRORC=$O(VADM(12,SRORC)) Q:SRORC=""  Q:C=11  D
 .I $G(VADM(12,SRORC)) S SRORACE(C)=$P(VADM(12,SRORC),U,2)
 .I SROLINE'="" S SROLINE=SROLINE_", "_SRORACE(C)
 .I SROLINE="" S SROLINE=SRORACE(C)
 .S C=C+1
 ;
 ;Find total length of 'race' string and wrap the text if necessary
 I $L(SROLINE)=29!$L(SROLINE)<29 S SROL(N)=SROLINE,SRNUM1=2
 I $L(SROLINE)>29 D WRAP
 ;
 W !,"Sex: ",?16,$P(VADM(5),"^",2),?40,"Ethnicity:",?51,SROETH
 W !,?40,"Race:"
 I $G(VADM(12)) F D=1:1:SRNUM1-1 D
 .W:D=1 ?51,SROL(D)
 .W:D'=1 !,?51,SROL(D)
 I '$G(VADM(12)) W ?51,"UNANSWERED"
 ;
 K SROL,SROLINE,SRORC,SRORACE,SROLN,SROLN1,SROWRAP,SRNUM1
 ;
 S Y=$P($G(^SRF(SRTN,208)),"^",11),C=$P(^DD(130,413,0),"^",2) D Y^DIQ S X=$S(Y'="":Y,1:"NOT ENTERED") W !,"Transfer Status: ",X
 F J=1,2,3 S Y=$P($G(^SRF(SRTN,208.1)),"^",J) D
 .I J'=3 X:Y ^DD("DD") S Z=$P(Y,"@")_"  "_$E($P(Y,"@",2),1,5)
 .I J=3 S C=$P(^DD(130,454,0),"^",2) D Y^DIQ S Z=Y
 .W !,"Observation "_$S(J=1:"Admission Date:",J=2:"Discharge Date:",1:"Treating Specialty:"),?47,Z
 F J=14:1:17 S Y=$P($G(^SRF(SRTN,208)),"^",J) X ^DD("DD") S SRPTMODT(J)=Y
 S (X,Z)=SRPTMODT(14) S:X'="" Z=$P(X,"@")_"  "_$E($P(X,"@",2),1,5) W !,"Hospital Admission Date:",?47,Z
 S (X,Z)=SRPTMODT(15) S:X'="" Z=$P(X,"@")_"  "_$E($P(X,"@",2),1,5) W !,"Hospital Discharge Date:",?47,Z
 S (X,Z)=SRPTMODT(16) S:X'="" Z=$P(X,"@")_"  "_$E($P(X,"@",2),1,5) W !,"Admitted/Transferred to Surgical Service:",?47,Z
 S (X,Z)=SRPTMODT(17) S:X'="" Z=$P(X,"@")_"  "_$E($P(X,"@",2),1,5) W !,"Discharged/Transferred to Chronic Care:",?47,Z
 W !,"In/Out-Patient Status:",?47,$S($P($G(^SRF(SRTN,0)),"^",12)="I":"INPATIENT",$P($G(^SRF(SRTN,0)),"^",12)="O":"OUTPATIENT",1:"")
 I $E(IOST)="P" W ! F MOE=1:1:80 W "-"
 I $E(IOST)'="P" D PAGE I SRSOUT G END
 D ^SROAPRT1 G:SRSOUT END I $Y+20>IOSL D PAGE I SRSOUT G END
 D ^SROAPRT2 G:SRSOUT END I $Y+20>IOSL D PAGE I SRSOUT G END
 D OPTIMES^SROAPRT3 G:SRSOUT END I $Y+20>IOSL D PAGE I SRSOUT G END
 D ^SROAPRT3 G:SRSOUT END I $Y+24>IOSL D PAGE I SRSOUT G END
 D ^SROAPRT4 G:SRSOUT END I $Y+20>IOSL D PAGE I SRSOUT G END
 D ^SROAPRT5 G:SRSOUT END I $Y+20>IOSL D PAGE I SRSOUT G END
 D ^SROAPRT6
END Q:$D(SRABATCH)  I 'SRSOUT,$E(IOST)'="P" W !!,"Press <RET> to continue  " R X:DTIME
 W:$E(IOST)="P" @IOF I $D(ZTQUEUED) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 D ^%ZISC K SROETH,SRTN W @IOF D ^SRSKILL
 Q
 ;
WRAP ;Wrap multiple race entries so that wrapped line
 ;does not break in the middle of a word
 ;
 S SROLNGTH=$L(SROLINE),E=29,SROWRAP="",SROLN="",SROLN1="",SROL=""
 F I=1:29:SROLNGTH S SROLN(I)=SROWRAP_$E(SROLINE,I,E) D
 .F K=29:-1:1 I $E(SROLN(I),K)[" " D  Q    ;Break lines at space
 ..S SROLN1(I)=$E(SROLN(I),1,K-1)
 ..S SROWRAP=$E(SROLN(I),K+1,E)
 .S E=E+29
 ;
 S:'$D(SROLN1(I)) SROLN1(I)=SROLN(I),SROWRAP=""
 I $L(SROLN1(I))+$L(SROWRAP)>28 S SROLN1(I+1)=SROWRAP   ;Last line
 I $L(SROLN1(I))+$L(SROWRAP)'>28 S SROLN1(I)=SROLN1(I)_" "_SROWRAP
 ;
 ;Renumber the SROLN1 array to be in numeric order
 S SRNUM=0,SRNUM1=1
 F  S SRNUM=$O(SROLN1(SRNUM)) Q:SRNUM=""  D
 .S SROL(SRNUM1)=SROLN1(SRNUM)
 .S SRNUM1=SRNUM1+1
 Q
 ;
LOOP ; break procedures
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<55  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
PAGE I $E(IOST)'="P" W !!,"Press <RET> to continue, or '^' to quit  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 I X["?" W !!,"Enter <RET> to continue printing the remaining pages of this assessment, or",!,"'^' to exit this option." G PAGE
 W @IOF
HDR ; print heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRSOUT=1 Q
 S SRPG=SRPG+1
 I $Y'=0 W @IOF
 I SRATYPE="C" W !,"VA CARDIAC RISK ASSESSMENT",?70,"PAGE "_SRPG
 I SRATYPE="N" W !,"VA NON-CARDIAC RISK ASSESSMENT             Assessment: "_SRTN,?69,"PAGE "_SRPG
 W !,"FOR "_SRANM S X=$P(SR("RA"),"^") W " ("_$S(X="I":"INCOMPLETE",X="C":"COMPLETED",X="T":"TRANSMITTED",1:"NO ASSESSMENT") I X="T" S Y=$P(SR("RA"),"^",4) W " "_$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)
 W ")",! F LINE=1:1:80 W "="
 W !
 Q
CODE ; print CPT Code
 S X=$P(^SRF(SRTN,13,SR,0),"^",2) I X W "  ("_$P($$CPT^ICPTCOD(X),"^",2)_")"
 Q

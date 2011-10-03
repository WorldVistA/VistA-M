SRTPPAS ;BIR/SJA - PRINT A COMPLETE ASSESSMENT ;04/21/08
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
 N AGE,C,D,E,I,II,JJ,K,LINE,MOE,N,SR,SRA,SRACE,SRANM,SRATYPE
 N SRDR,SRHALT,SRNOVA,SRVACO,SRNUM,SROLNGTH,SRPG,SRQ,SRSDATE,X,Y,Z
 S SRSOUT=0,SRPG=0,SR("RA")=$G(^SRT(SRTPP,"RA")),SRATYPE=$P(SR("RA"),"^",2),SRNOVA=$S($P(SR("RA"),"^",5)="N":1,1:0)
 F I=.01,.02,.1,.11,.5,.55,1,3,10,11 S SRA(I)=$G(^SRT(SRTPP,I))
 S SR(0)=^SRT(SRTPP,0),DFN=$P(SR(0),"^"),SRSDATE=$P(SR(0),"^",2),SRVACO=$P(SRA(.01),"^",11)
 D DEM^VADPT S SRANM=VADM(1)_"  "_VA("PID"),Z=$P(VADM(3),"^"),Y=$E(SRSDATE,1,7),AGE=$E(Y,1,3)-$E(Z,1,3)-($E(Y,4,7)<$E(Z,4,7))
 W:$E(IOST)'="P" @IOF D HDR G:SRSOUT END
 W !,?28,"RECIPIENT INFORMATION",!
 W !,"Age: ",?22,AGE S Y=SRSDATE D D^DIQ W ?40,"Transplant Date: ",?59,$P(Y,"@")
 ;Find patient's ethnicity
 S SROETH=""
 I $G(VADM(11)) S SROETH=$P(VADM(11,1),U,2)
 I '$G(VADM(11)) S SROETH="UNANSWERED"
 ;Find all race entries and place into a string with commas inbetween
 S SRORC=0,C=1,SRORACE="",SROLINE="",N=1,SROL=""
 F  S SRORC=$O(VADM(12,SRORC)) Q:SRORC=""  Q:C=11  D
 .I $G(VADM(12,SRORC)) S SRORACE(C)=$P(VADM(12,SRORC),U,2)
 .I SROLINE'="" S SROLINE=SROLINE_", "_SRORACE(C)
 .I SROLINE="" S SROLINE=SRORACE(C)
 .S C=C+1
 ;Find total length of 'race' string and wrap the text if necessary
 I $L(SROLINE)=29!$L(SROLINE)<29 S SROL(N)=SROLINE,SRNUM1=2
 I $L(SROLINE)>29 D WRAP
 W !,"Gender: ",?22,$P(VADM(5),"^",2),?40,"Ethnicity:",?51,SROETH
 W !,"VACO ID: ",?22,SRVACO,?40,"Race:"
 I $G(VADM(12)) F D=1:1:SRNUM1-1 D
 .W:D=1 ?51,SROL(D)
 .W:D'=1 !,?51,SROL(D)
 I '$G(VADM(12)) W ?51,"UNANSWERED"
 K SROL,SROLINE,SRORC,SRORACE,SROLN,SROLN1,SROWRAP,SRNUM1
 G @($S(SRATYPE="K":"^SRTPRK",SRATYPE="LI":"^SRTPRLI",SRATYPE="LU":"^SRTPRLU",SRATYPE="H":"^SRTPRH",1:""))
END I '$D(SRABATCH) I 'SRSOUT,$E(IOST)'="P" W !!,"Press <RET> to continue  " R X:DTIME
 Q:$E(IOST)'="P"
 W:$E(IOST)="P" @IOF I $D(ZTQUEUED) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 D ^%ZISC K SROETH,SRTPP W @IOF D ^SRSKILL
 Q
WRAP ;Wrap multiple race entries so that wrapped line
 ;does not break in the middle of a word
 S SROLNGTH=$L(SROLINE),E=29,SROWRAP="",SROLN="",SROLN1="",SROL=""
 F I=1:29:SROLNGTH S SROLN(I)=SROWRAP_$E(SROLINE,I,E) D
 .F K=29:-1:1 I $E(SROLN(I),K)[" " D  Q    ;Break lines at space
 ..S SROLN1(I)=$E(SROLN(I),1,K-1)
 ..S SROWRAP=$E(SROLN(I),K+1,E)
 .S E=E+29
 S:'$D(SROLN1(I)) SROLN1(I)=SROLN(I),SROWRAP=""
 I $L(SROLN1(I))+$L(SROWRAP)>28 S SROLN1(I+1)=SROWRAP   ;Last line
 I $L(SROLN1(I))+$L(SROWRAP)'>28 S SROLN1(I)=SROLN1(I)_" "_SROWRAP
 ;Renumber the SROLN1 array to be in numeric order
 S SRNUM=0,SRNUM1=1
 F  S SRNUM=$O(SROLN1(SRNUM)) Q:SRNUM=""  D
 .S SROL(SRNUM1)=SROLN1(SRNUM)
 .S SRNUM1=SRNUM1+1
 Q
PAGE I $E(IOST)'="P" W !!,"Press <RET> to continue, or '^' to quit  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 I $E(IOST)'="P",X["?" W !!,"Enter <RET> to continue printing the remaining pages of this assessment, or",!,"'^' to exit this option." G PAGE
 W @IOF
HDR ; print heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRSOUT=1 Q
 S SRPG=SRPG+1
 I $Y'=0 W @IOF
 W !,$$TR^SRTPUTL($P(SR("RA"),"^",2))_" TRANSPLANT ASSESSMENT   "_$S($P(SR("RA"),"^",5)="V":"VA",1:"NON-VA")_$S($P(SR(0),"^",3):" SURGERY CASE #"_$P(SR(0),"^",3),1:" TRANSPLANT"),?70,"PAGE "_SRPG
 W !,"FOR "_SRANM S X=$P(SR("RA"),"^") W " ("_$S(X="I":"INCOMPLETE",X="C":"COMPLETED",X="T":"TRANSMITTED",1:"NO ASSESSMENT") I X="T" S Y=$P(SR("RA"),"^",4) W " "_$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)
 W ")",!,"Medical Center: "_SRSITE("SITE"),! F LINE=1:1:80 W "="
 W !
 Q

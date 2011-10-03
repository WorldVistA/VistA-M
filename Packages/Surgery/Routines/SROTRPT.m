SROTRPT ;B'HAM ISC/MAM - TISSUE EXAM REPORT ; 16 JULY 1990  10:00
 ;;3.0; Surgery ;**31,111,145**;24 Jun 93
 S SRSOUT=0
 I '$D(SRSITE) D ^SROVAR S SRSITE("KILL")=1
 I '$D(SRTN) K SRNEWOP D ^SROPS I '$D(SRTN) S SRSOUT=1 G END
 K %ZIS,IOP,POP,IO("Q") S %ZIS="Q" D ^%ZIS I POP S SRSOUT=1 G END
 I $D(IO("Q")) K IO("Q") S ZTDESC="TISSUE EXAM REPORT",ZTRTN="RPT^SROTRPT",(ZTSAVE("SRSITE*"),ZTSAVE("SRTN"))="",ZTSAVE("SRT")="UL" D ^%ZTLOAD S SRSOUT=1 G END
RPT ; entry when queued
 S SRSOUT=0 I '$D(ZTQUEUED) S SRT=$S($E(IOST)="P":"UL",1:"Q")
 D ^SROTRPT0,FOOT
END I $E(IOST)'="P",'SRSOUT W !!,"Press RETURN to continue  " R X:DTIME
 W:$E(IOST)="P" @IOF I $D(ZTQUEUED) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 D ^%ZISC W @IOF D ^SRSKILL
 Q
FOOT ; print footer
 ;
 ;Find ethnicity entry
 S SROETH=""
 I $G(VADM(11,1)) S SROETH=$P(VADM(11,1),U,2)
 I '$G(VADM(11,1)) S SROETH="UNANSWERED"
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
 I $L(SROLINE)=72!$L(SROLINE)<72 S SROL(N)=SROLINE,SRNUM1=2
 I $L(SROLINE)>72 D WRAP
 ;
 Q:SRSOUT  F X=1:1 Q:$Y>(IOSL-13)  W !
 W !,?30,"(Continue on reverse side)",! F SRLINE=1:1:80 W "-"
 W !,"PATHOLOGIST'S SIGNATURE",?58,"DATE: ",! F SRLINE=1:1:80 W "-"
 W !,VADM(1),?30,"AGE: "_VADM(4),?40,"SEX: "_$P(VADM(5),"^",2),?58,"ID # "_VA("PID"),!,"ETHNICITY: "_SROETH
 W ?58,"REGISTER NO. "
 W !,"RACE: "
 I $G(VADM(12)) F D=1:1:SRNUM1-1 D
 .W:D=1 ?7,SROL(D)
 .W:D'=1 !,?7,SROL(D)
 I '$G(VADM(12)) W ?7,"UNANSWERED"
 ;
 K SROL,SROLINE,SRORC,SRORACE,SROLN,SROLN1,SROWRAP,SRNUM1
 ;
 W !,"WARD: "_SRWARD,?30,"ROOM-BED: "_SROOM
 W ! F SRLINE=1:1:80 W "-"
 W !,SRINST,?58,"REPLACEMENT FORM 515"
 Q
 ;
WRAP ;Wrap multiple race entries so that wrapped line
 ;does not break in the middle of a word
 ;
 S SROLNGTH=$L(SROLINE),E=72,SROWRAP="",SROLN="",SROLN1="",SROL=""
 F I=1:72:SROLNGTH+1 S SROLN(I)=SROWRAP_$E(SROLINE,I,E) D
 .F K=72:-1:1 I $E(SROLN(I),K)[" " D  Q    ;Break lines at space
 ..S SROLN1(I)=$E(SROLN(I),1,K-1)
 ..S SROWRAP=$E(SROLN(I),K+1,E)
 .S E=E+72
 ;I $L(SROLN1(I))+$L(SROWRAP)>71 S SROLN1(I+1)=SROWRAP   ;Last line
 ;I $L(SROLN1(I))+$L(SROWRAP)'>71 S SROLN1(I)=SROLN1(I)_" "_SROWRAP
 I $L(SROLN(I))+$L(SROWRAP)>71 S SROLN1(I+1)=SROWRAP   ;Last line
 I $L(SROLN(I))+$L(SROWRAP)'>71 S SROLN1(I)=SROLN(I)
 ;
 ;Renumber the SROLN1 array to be in numeric order
 S SRNUM=0,SRNUM1=1
 F  S SRNUM=$O(SROLN1(SRNUM)) Q:SRNUM=""  D
 .S SROL(SRNUM1)=SROLN1(SRNUM)
 .S SRNUM1=SRNUM1+1
 Q

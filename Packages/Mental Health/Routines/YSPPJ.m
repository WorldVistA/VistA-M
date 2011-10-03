YSPPJ ;ALB/ASF-JUMP BETWEEN INQUIRY SCREENS ;4/14/93  17:31 ;07/07/93 14:10
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;
FIND ; Called from MENU option YSPATPROF
 F  D ONE Q:YSDFN<1
 K YSDFN D QUIT
 Q
 ;
ONE ;
 W @IOF D ^YSLRP Q:YSDFN<1  S (DA,DFN)=YSDFN D DEM^VADPT,PID^VADPT,HOME^%ZIS
 D:$D(XRTL) T0^%ZOSV ; START Response check measure
 S X="IORVON;IORVOFF" D ENDR^%ZISS
 F I=0,.11,.111,.13,.21,.211,.24,.15,.3,.311,.31,.321,.32,.33,.331,.34,.362,.36,.52,1010.15 S A(I)="" S:$D(^DPT(DA,I))#10 A(I)=^(I)
MENU ;
 W @IOF,"NAME: ",VADM(1),?40,"SSN: ",YSSSN,?60,"DOB: ",$P(VADM(3),U,2) S PROFILE=1,HOLDA=A(0)
 W !!?5 W IORVON," P A T I E N T   P R O F I L E ",IORVOFF W !
 F YSI=1:1 S G=$T(PROG+YSI) Q:G=""  S G3=$P(G,";",4),G4=$P(G,";",5),G5=$P(G,";",6) W !,$J(YSI,2),".",?5,G3 I G4]"" X G4 I '$T W ?45,IORVON," no ",G5,?78,IORVOFF
 S:$D(XRT0) XRTN=$T(+0) D:$D(XRT0) T1^%ZOSV ; STOP Response check measure
M ;
 K DIR
 S A8=0 W !!
 S DIR(0)="FO^1:24",DIR("A")="Enter section number(s) or 'P' to print or 'Q' for quick look ",DIR("?")="Enter a numeric string ex. 2,4,7-9"
 S DIR("?",1)="'P' or 'p' for print 'Q' or 'q' for quick look" D ^DIR K DIR S A1=Y
 I $D(DIRUT) D QUIT S YSDFN=-1 Q
 I $E(A1,1)="-" W:A1'["?" " ?",$C(7) D MSG1^YSEMSG G MENU
 I A1["-"!(A1[11) D LIST S A1=YSEXT
 S A1=$TR(A1,"pq","PQ")
 G MENU2:A1,MENU1:"P"[A1 I "Q"'[A1 W:A1'["?" " ?",$C(7) D MSG1^YSEMSG G MENU
 D EN^YSDGDEM Q
LIST ;
 K YSRY S CT=0,ANS=A1
 ;
 ;  Did user enter a range, or selection including 11 + more'n 11?
 I $G(ANS)[11&(+ANS'=11) D
 .  S ANS="1-10"
 .  W !!,"Including all sections...",!!
 ;
 F YSI=1:1:$L(ANS,",") S X=$P(ANS,",",YSI) I +X>0 S CT=CT+1,YSRY(CT)=$P(ANS,",",YSI)
 ;
 S YSEXT="",OK=1
 S YSLN=0 F  S YSLN=$O(YSRY(YSLN)) QUIT:YSLN'>0   D  QUIT:OK=0
 .  S SUB=$G(YSRY(YSLN)) QUIT:SUB']""  ;->
 .  I +SUB=SUB S YSEXT=YSEXT_+SUB_"," QUIT
 .  I SUB?1.2N1"-"1.2N D  S YSRY(YSLN)=YSEXT
 .  .  S X=+SUB,Y=+$P(SUB,"-",2)
 .  .  I X>Y!(Y>10) S OK=0 QUIT
 .  .  F YSAI=X:1:Y S YSEXT=YSEXT_YSAI_","
 I OK=0 W:A1'["?" " ?",$C(7) D MSG1^YSEMSG G MENU
 I $E(YSEXT,$L(YSEXT))="," S YSEXT=$E(YSEXT,1,$L(YSEXT)-1)
 Q
 ;
MENU1 ;
 S DIR(0)="LO^1:11" D ^DIR K DIR I $D(DIRUT)!('Y) Q
 S A8=Y
 I A8[11 S A8="1,2,3,4,5,6,7,8,9,10" W !!,"Including all sections...",!!
MENU2 ;
 I 'A8 S A8=$S(A1=11:"1,2,3,4,5,6,7,8,9,10",A1?1N.1",".E:A1,1:"") I 'A8 D QUIT Q
 I A8<1!(A8>10) W:A1'["?" " ?",$C(7) D MSG1^YSEMSG G MENU
AD ;
 I IOST?1"C-".E,A8?1N.N I $L(A1)>1!(A1=10) F I=A8+1:1:10 S A8=A8_","_I
 S YSA8=A8 K IOP S %ZIS="Q" D ^%ZIS I POP D QUIT S YSDFN=-1 Q
 I $D(IO("Q")),IOST?1"C-".E W " - You can't queue to a CRT!",$C(7) K IO("Q") G AD
 I $D(IO("Q")) S ZTRTN="ENP^YSPPJ",(ZTSAVE("YS*"),ZTSAVE("DFN"),ZTSAVE("A("),ZTSAVE("DA"))="",ZTSAVE("PROFILE")="",ZTSAVE("HOLDA")="",ZTDESC="YS PROFILE PRT" D ^%ZTLOAD,HOME^%ZIS,QUIT Q
 ;
ENP ; Called by routine YSCEN39
 S YST=$S(IOST?1"C-".E:0,1:1),YSLFT=0 U IO
 F YSI=1:1 S A1=$P(YSA8,",",YSI) Q:A1=""!(YSLFT)  I A1>0,A1<11 S A2=$P($T(PROG+A1),";",3) D @A2
 G:$D(YSCENN) QUIT
 ;K YSA8 I YSLFT,A1 K A1,A8 D MENU ;Commented 7/7/93 LJA
FIN ;
 D ^%ZISC,HOME^%ZIS S A(0)=HOLDA I $G(ZTSK) S ZTREQ="@"
QUIT ;
 K %,%ZIS,A,ANS,A1,A2,A6,A7,A8,C,CT,D,DA,DIC,YSDT(0),YSDT(1),G,G3,G4,G5,I0,IO("Q"),I1,I2,I3,L,L1,L2,L3,L4,N3,R1,R2,S,SUB,S2,S5,X,X1,X2
 K Y,YSA8,YSADMDT,YSAGE,YSAI,YSCON,YSCOV,YSDISP,YSDOB,YSEXT,YSFA,YSFTR,YSFHDR,YSI,YSIA,YSLFT,YSLN,YSNM,YSPNH,YSRY,YSSEX,YSSKIP,YSSSN,YST,YSTB,YSTRNDT,ZTSK
 D KILL^%ZISS,KVAR^VADPT
 K AI,DX1,DX2,DX3,G11,J,K,L10,L11,L5,L6,L8,L9,N1,RDT,ST,ST1,STDT,YSDXNN,YSCLI,YSOC,PROFILE,HOLDA Q:$D(YSCENN)
 Q
PROG ;
1 ;;^YSPP;Identifying data
2 ;;^YSPP1;Next of kin, employment, claim number
3 ;;^YSPP1A;Disability, financial
4 ;;^YSPP2;Military
5 ;;^YSPP4;Inpatient data/Application for care;I $D(^DGPM("ATID1",YSDFN));inpatient admissions
6 ;;^YSPP5;Outpatient data;I $D(^DPT(YSDFN,"DE"))>0!($D(^DPT(YSDFN,"S"))>0);appointment data
7 ;;^YSPP6;DSM/ICD9 Diagnosis list;I $D(^YSD(627.8,"AF",YSDFN))>0;diagnosis
8 ;;^YSPP7;Last physical exam;IF $D(^MR(YSDFN,"PE"))>0;physical
9 ;;^YSPP8;Problem list, MH tests & interviews;I $D(^YTD(601.2,"B",YSDFN))>0;tests/interviews
10 ;;^YSPP9;Short problem list;IF $D(^YS(615,YSDFN,"PL"))>0;problem list
11 ;;;All Sections;;

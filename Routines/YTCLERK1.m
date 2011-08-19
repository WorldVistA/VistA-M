YTCLERK1 ;SLC/DJP-CONTINUATION OF ^YTCLERK; ;5/30/02  15:06
 ;;5.01;MENTAL HEALTH;**10,19,76**;Dec 30, 1994
A31 ;
 S YSQ=0,YSOK=1 R !!?3,"Queue to print when test(s)/interview(s) completed? Y// ",A:DTIME S YSTOUT='$T,YSUOUT=A["^" I YSTOUT!YSUOUT S YSOK=-1 Q
 S A=$TR($E(A_"Y"),"yn","YN") I A="Y" S YSQ=1 G QUE
 Q:A="N"  W !!?3,"Queing will send tests results to the selected printer as soon as it",!?3,"is available." G A31
QUE ;
 W ! K ION S IOP="Q" D ^%ZIS I POP S YSOK=-1 Q
 I '$D(ION) W !,"IMPROPERLY DEFINED DEVICE!",$C(7) G QUE
 I IO=IO(0),IOST'?1"P".E W !,"YOU MUST QUEUE TO A PRINTER!",$C(7) G QUE
 Q
ZAP ;
 W !!,"Do you want to delete ",YSTESTN," now" S %=2 D YN^DICN G:%=0 ZAP1 G:%'=1 KAR^YTS D ENKIL^YTFILE W !!,YSTESTN," DELETED!" D 1^YTCLERK Q
ZAP1 W !!,"By entering ""Y"", the test will be deleted from the patient's file.",! G ZAP
 Q
REMMPR ;
 R !,"SHORT FORM" S %=1 D YN^DICN
 ;
 ;  Yes... Administer the MMRP-Short.
 I %=1 K % Q
 ;
 ;  No... Administer the MMPR-Long.
 I %=2 D  G REN ;->
 .  W !! F YSI=0:1:5 W !,$P($T(YSM+YSI),";;",2,99)
 .  W !!
 .  H 2
 ;
 ;  Must've up-arrowed out...
 I %=-1 S YSTIN=1 K % Q
 ;
 ;  User asked for help...
 I %=0 W !!,"If the short form (MMPR) is not used, the long form (MMPI) will be substituted.",! K % G REMMPR
 ;
 ;
YSM ;clerk entered long form message
 ;;Please clerk-enter all items in MMPR order.  After the
 ;;test has been completely clerk entered, the computer will
 ;;re-order the items and save them in MMPI order.  On the
 ;;test results printout, the items will appear in MMPI order.
 ;
REN ;
 ;  Administering the MMPI...  ien#60
 S YSTEST=60,YSNQ=566,YSTF=1 Q
RESTART ;
 ;  Called from RESTART and from YTCLERK
 ; 3/11/94 LJA
 S YSTESTN=$P(^YTT(601,YSTEST,0),U)
 I +YSTEST=60 D  ;MMPI OR MMPR-LONG?
 .  I $G(^YTD(601.4,+YSDFN,1,14,99))="MMPIR" S YSTESTN="MMPIR"
 W !,"Restart ",YSTESTN," now" S %=1 D YN^DICN G GOT:%=1,KAR^YTS:%<0
 I %=0 W !,"Test will restart at question interrupted." G RESTART
 W !!,YSTESTN," must be completed or deleted prior to administering another test." G ZAP
GOT ;
 D A31 G KAR^YTS:YSOK<1
 S YSXTP=1,YSXT=YSTEST,J=+$P(^YTD(601.4,YSDFN,1,YSENT,0),U,4),C=$P(^(0),U,5),YSDTA=$P(^(0),U,3),YSORD=$P(^(0),U,7) S:J<1 J=1
 S B=$G(^YTD(601.4,YSDFN,1,YSENT,"B")),YSRP=$S(J#200=1:"",1:^(J+199\200)),B1=$S(B?1"W ".PN1"ANSWER".E:0,1:1)
 I YSTESTN?1"MCMI"1N S YSNQ=$P(^YTT(601,YSTEST,"Q",0),U,3) ;ASF 5/30/02
 E  S YSNQ=$P(^YTT(601,YSTEST,0),U,11)
 S YSCL=YSTEST,YSCLN=YSTESTN,R1=1 W !! G ENX^YTCLERK

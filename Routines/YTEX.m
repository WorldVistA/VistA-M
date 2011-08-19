YTEX ;SLC/TGA-EXEMPT TESTS ;9/14/89  14:41 ;
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;
 ; Called from the top by MENU option YSEXTESTS
 ;
 W @IOF,!!!?22,"EXEMPT PSYCHOLOGY TEST UTILITY"
 W !!?3,"Tests listed as Psychological Tests in the Mental Health Package"
 W !?3,"but which do not meet APA guidelines for training can be exempt"
 W !?3,"by using this utility.  All Mental Health professionals have"
 W !?3,"access to exempt tests."
OP ;
 R !!!?3,"(E)xempt a test, (R)emove exemption, (P)rint list or (Q)uit? Q// ",A:DTIME S YSTOUT='$T,YSUOUT=A["^" S A=$TR($E(A_"Q"),"erpq","ERPQ") G END:"Q"[A!YSTOUT!YSUOUT,RE:"R"[A,PR:"P"[A,EX:"E"[A W:A'["?" " ?",$C(7) G OP
EX ;
 S C=0 R !!?3,"Exempt TEST: ",A:DTIME S YSTOUT='$T,YSUOUT=A["^" G END:YSTOUT!YSUOUT,OP:A="" I A["?" S YSXT="CLERK^" D ENTB^YTLIST G EX
 S A=$E(A,1,5),YSTEST=$O(^YTT(601,"B",A,0)) I 'YSTEST W " - NO SUCH TEST!",$C(7) G EX
 I $P(^YTT(601,YSTEST,0),U,10)["Y" W !!?3,A," is already EXEMPT",! G EX
 L +^YTT(601,YSTEST) S $P(^YTT(601,YSTEST,0),U,10)="Y",$P(^(0),U,15)=DUZ,^YTT(601,"AE","Y",YSTEST)="" L -^YTT(601,YSTEST) W !!?3,A," is now EXEMPT" G EX
RE ;
 R !!?3,"Remove exemption from TEST: ",A:DTIME S YSTOUT='$T,YSUOUT=A["^" G END:YSTOUT!YSUOUT,OP:A="" I A["?" D L G RE
 S A=$E(A,1,5),YSTEST=$O(^YTT(601,"B",A,0)) I 'YSTEST W " - NO SUCH TEST!",$C(7) G RE
 I $P(^YTT(601,YSTEST,0),U,10)'["Y" W !!?3,A," was NOT exempt" G RE
 L +^YTT(601,YSTEST,0) S $P(^YTT(601,YSTEST,0),U,10)="",$P(^(0),U,15)="" K ^YTT(601,"AE","Y",YSTEST) W !!?3,A," is NOT EXEMPT now!" L -^YTT(601,YSTEST,0) G RE
PR ;
 W ! K IOP S %ZIS="Q",YSLFT=0 D ^%ZIS G:POP END I $D(IO("Q")) S ZTRTN="ENP^YTEX",ZTDESC="YS EXEMPT TEST",ZTSAVE("Y*")="" D ^%ZTLOAD G END
ENP ;
 U IO W @IOF,!!!?25,"EXEMPT TESTS",!!?3,"CODE",?11,"TEST NAME",?50,"EXEMPT BY",! S N=0
N S N=$O(^YTT(601,"AE","Y",N)) G:N="" E G:'$D(^YTT(601,N,0)) N S X=^(0),I=$P(X,U),T=$P(X,U,9),B=+$P(X,U,15)
 D:IOST?1"C-".E WAIT^YSUTL:$Y+4>IOSL G:YSLFT END W !?3,I,?10,$S(T'="B":$P($P(^YTT(601,N,"P"),U),"---",2),1:"TEST BATTERY") W:$X>48 ! W ?49,$S($D(^VA(200,B,0)):$P(^(0),U),1:"UNKNOWN") G N
E ;
 W ! D KILL^%ZTLOAD,^%ZISC D:IOST?1"C-".E WAIT^YSUTL G:'$G(ZTSK) OP
END ;
 K A,B,C,I,I0,N,S,T,X,YSLFT,YSTEST,Z,ZTSK Q
L ;
 W !!?15,"EXEMPT TESTS",! S Z=59,T=0
L1 ;
 S T=$O(^YTT(601,"AE","Y",T)) Q:'T  G:'$D(^YTT(601,T,0)) L1
 S Z=Z+8#64 W:Z=3 ! W ?Z,$P(^YTT(601,T,0),U) G L1

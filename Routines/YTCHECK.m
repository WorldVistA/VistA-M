YTCHECK ;SLC/TGA-CHECK PSYCH TEST/INTERVIEW DATA BASE ; 7/10/89  11:21 ;03/11/94 12:13
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;
 ; Called from the top by  MENU option YSMCHK
 ;
S ;
 W @IOF,?22,"Check Psych Test/Interview Data Base"
 W !!,"You may use this option for individual patients or all patients."
 W !,"If you use it for individual patients, you may elect to delete any unknown"
 W !,"tests/interviews and any tests/interviews with erroneous response sets."
 W !,"If you use it for all patients, you may elect to print a list of errors or"
 W !,"automatically delete all unknown patients, unknown instruments, and all"
 W !,"instruments with erroneous response sets."
 W !!,"THIS OPTION SHOULD NOT BE RUN WHILE TESTS/INTERVIEWS ARE UNDERWAY!",$C(7)
1 ;
 W !!,"Check (I)ndividual patient or (A)ll patients:  I// " R A:DTIME S YSTOUT='$T,YSUOUT=A["^" G:YSTOUT!YSUOUT KIL S A=$TR($E(A),"ia","IA")
 I "AI"'[A W:A'["?" " ?",$C(7) W !,"Type 'I' to check an individial patient's data or 'A' to check all patients." G 1
 S YSN=$S("I"[A:0,1:1),YSD=0,YSE=0 G:'YSN 2
 R !!,"(L)ist or (D)elete errors: ",A:DTIME S YSTOUT='$T,YSUOUT=A["^" G:YSTOUT!YSUOUT KIL S A=$TR($E(A),"ld","LD") I "LD"'[A W:A'["?" " ?",$C(7) G S
 S YSD=$S("D"[A:1,1:0)
2 ;
 R !!,"Shall I list discontinued session(s)" S %=0 D YN^DICN G:"^"[%Y KIL I %Y["?" W !?4,"Answer 'YES' or 'NO'." G 2
 S YSL=$S(%=1:1,1:0) I 'YSN D ^YSLRP G:YSDFN<1 KIL S P=YSDFN D P1 G:YSDFN<1 KIL D INC:YSL,T G END
 S %ZIS="Q" D ^%ZIS G:POP KIL I $D(IO("Q")) S ZTRTN="ENP^YTCHECK",ZTSAVE("YS*")="",ZTDESC="YS DB CHECK" D ^%ZTLOAD G KIL
ENP ;
 U IO D HD S (P,P(0))=0,P1="" F  S P=$O(^YTD(601.2,P)) Q:'P  D P,T
 I YSL S P=0 F  S P=$O(^YTD(601.4,P)) Q:'P  S YSNM=$S($D(^DPT(P,0)):$P(^(0),U),1:"UNKNOWN PATIENT") D INC
 G END
CK ;
 ;G:'$D(^YTT(601,T,0)) CK1 S L=$P(^(0),U,11),L1=0 S:$G(^YTD(601.2,P,1,T,1,D,99))="MMPIR" L=1132 L +^YTD(601.2,P) S I=0 F  S I=$O(^YTD(601.2,P,1,T,1,D,I)) Q:'I!(I>50)  S L1=L1+$L(^(I))
 G:'$D(^YTT(601,T,0)) CK1
 S L=$P(^(0),U,11),L1=0
 L +^YTD(601.2,P) S I=0
 F  S I=$O(^YTD(601.2,P,1,T,1,D,I)) Q:'I!(I>50)  S L1=L1+$L(^(I))
 ;
 ; 3/10/94 LJA  Changes made to display MMPR correctly, when it is...
 L -^YTD(601.2,P)
 I L'=L1,$$MMPIRCK(L,L1) D
 .  S YSE=YSE+1 D:IOST?1"P".E HD:$Y+9>IOSL W ! W:YSN YSNM
 .  W ?31,"Response set length error on " S X=$P(^YTT(601,T,0),U)
 .  ;  Following line commented on 4/29/94.  LJA.
 .  ;I L'=L1,T=60,$G(^YTD(601.2,+P,1,+T,1,+D,99))="MMPIR" S X="MMPIR"
 .  ;
 .  W X,!?31,"expected ",L," got ",L1
 .  D DEL:'YSN
 .  I YSD K ^YTD(601.2,+P,1,+T,1,+D) W " - DELETED" QUIT
CK1 ;
 S D(0)=D(0)+1,C=D
 QUIT
 ;
MMPIRCK(L,L1) ;  If MMPIR and EXP=566 and GOT=1132... OK
 ;  This code "compensates" for MMPR longs (MMPIs) entered before
 ;  YS*5*17.  These entries still have 1132 (2 x 566) responses...
 ;
 ;  Report 1 (ok) if anything other than an MMPIR
 I $G(^YTD(601.2,+P,1,+T,1,+D,99))'="MMPIR" QUIT 1 ;->
 ;
 ;  This is an MMPIR...
 QUIT '(L=566&(L1=1132))
 ;
D ;
 S D(0)=0 I '$D(^YTT(601,T,0)) S YSE=YSE+1 D:IOST?1"P".E HD:$Y+8>IOSL W ! W:YSN YSNM W ?31,"Unknown Instrument" S X="instrument" D DEL:'YSN I YSD K ^YTD(601.2,P,1,T),^YTD(601.2,P,1,"B",T) W " - DELETED" Q
 S D=0 F  S D=$O(^YTD(601.2,P,1,T,1,D)) Q:'D  D CK
 I D(0)>0 L +^YTD(601.2,P,1,T,1,0) S ^YTD(601.2,P,1,T,1,0)="^601.22DA^"_C_"^"_D(0) L -^YTD(601.2,P,1,T,1,0) S:'$D(^YTD(601.2,P,1,"B",T,T)) ^(T)="" Q
 K ^YTD(601.2,P,1,T) Q
T ;
 S (T(0),T)=0 F  S T=$O(^YTD(601.2,P,1,T)) Q:'T  D D I D(0)>0 S T(0)=T(0)+1,H=T S:'$D(^YTD(601.2,P,1,"B",T,T)) ^(T)=""
 I T(0)>0 L +^YTD(601.2,P,1,0) S ^YTD(601.2,P,1,0)="^601.21PA^"_H_"^"_T(0) L -^YTD(601.2,P,1,0) S:YSN P(0)=P(0)+1,P1=P
 I T(0)>0 S I=0 F  S I=$O(^YTD(601.2,P,1,"B",I)) Q:'I  K:'$D(^YTD(601.2,P,1,I,0)) ^YTD(601.2,P,1,"B",I)
 Q:T(0)  K ^YTD(601.2,P),^YTD(601.2,"B",P) Q:YSN  L +^YTD(601.2,0) S X=$P(^YTD(601.2,0),U,4),X=X-1 S:X<1 X=0 S $P(^(0),U,4)=X L -^YTD(601.2,0) Q
P ;
 S YSDFN=P,YSNM=$S($D(^DPT(P,0)):$P(^(0),U),1:"Unknown Patient") I '$D(^DPT(P,0)) S YSE=YSE+1 D:IOST?1"P".E HD:$Y+8>IOSL W !,"Unknown patient found" I YSD K ^YTD(601.2,P),^YTD(601.2,"B",P,P) W " - DELETED" Q
P1 I 'YSN,'$D(^YTD(601.2,P)),'$D(^YTD(601.4,P)) W !,"No data on this patient." S YSDFN=-1 Q
 S:'$D(^YTD(601.2,"B",P,P)) ^(P)="" Q
 Q
INC ;
 I $O(^YTD(601.4,P,1,0))>0 D:IOST?1"P".E HD:$Y+8>IOSL W ! W:YSN YSNM W ?31,"Incomplete Session(s) found"
 Q
DEL ;
 S YSD=0 W !!,"DELETE this ",X,"? " R A:DTIME S YSTOUT='$T,YSUOUT=A["^" Q:YSTOUT!YSUOUT  S A=$E(A) I "YyNn"'[A W:A'["?" " ?",$C(7) G DEL
 S:"Yy"[A YSD=1 Q
END ;
 I YSN L +^YTD(601.2,0) S $P(^YTD(601.2,0),U,3)=P1,$P(^(0),U,4)=P(0) L -^YTD(601.2,0) D KILL^%ZTLOAD
 W:'YSE !!,"NO ERRORS FOUND" W ! D:YSN ^%ZISC
KIL ;
 K %,%ZIS,%Y,A,C,D,H,I,IO("Q"),L,L1,P,P1,T,X,Y,YSAGE,YSD,YSDFN,YSDOB,YSL,YSN,YSNM,YSSEX,YSSSN,ZTSK Q
HD ;
 W @IOF,!,"Test/Interview Database Report on " S Y=DT D DT^YTAUDIT W !! Q

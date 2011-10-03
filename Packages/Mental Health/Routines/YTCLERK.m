YTCLERK ;SLC/DKG,SLC/BB-FAST CLERICAL ENTRY; ;5/30/02  15:04
 ;;5.01;MENTAL HEALTH;**19,76**;Dec 30, 1994
 ;
 S YSCL=1 I $D(^YTD(601.4,YSDFN,1,"AC")) S YSTEST=$O(^("AC",0)),YSENT=$O(^(YSTEST,0)) W !!,"Discontinued CLERK test found:" G RESTART^YTCLERK1
1 ;
 D A11 I YSOK<1 G KAR^YTS
2 ;
 R !!?3,"Clerk Test: ",YSTESTN:DTIME S YSTOUT='$T,YSUOUT=YSTESTN["^" I YSTOUT!YSUOUT G KAR^YTS
 S:YSTESTN["?" YSXT="CLERK^" S:YSTESTN'="?" YSXT=YSTESTN G KAR^YTS:"^"[YSTESTN
 I YSTESTN["?" D ^YTLIST W !!,"Enter one of the above listed instruments.",!,"Questions will NOT be asked.  Responses only are required.",! K YSXT,YSTESTN G 2
 I YSTESTN?.PC D ^YTLIST K YSXT,YSTESTN G 2
RE ;
 I '$D(^YTT(601,"B",YSTESTN)) W "  [Not Found]" G 2
 S YSTEST=$O(^YTT(601,"B",YSTESTN,0)) S YSCLERK=14
 S X=^YTT(601,YSTEST,0) I $P(X,U,9)="I" W $C(7),"  [INTERVIEWS may not be CLERK entered!]" G 2
 I $P(X,U,2)="I"!'(+$P(X,U,11)) W "  [Not a CLERK Test]",$C(7) G 2
 I $P(X,U,13)="N" W $C(7),"  [Not Available]" G 2
 I YSTESTN?1"MCMI"1N S YSNQ=$P(^YTT(601,YSTEST,"Q",0),U,3) ;ASF 5/30/02
 E  S YSNQ=$P(X,U,11)
 S (J,YSXTP)=1,(B,C,YSRP)=""
 I YSTESTN="MMPR" D REMMPR^YTCLERK1 I $D(YSTIN) G KAR^YTS
REY ;
 S YSQ=0 D:$D(^XUSEC("YSZ",DUZ))!$D(^XUSEC("YSP",DUZ)) A31^YTCLERK1 G KAR^YTS:YSOK<1
REY1 ;
 W ! S %DT("A")="   Date test was administered to patient: ",%DT="AEXQ",%DT(0)="-NOW" D ^%DT G:Y<1 KAR^YTS
 S YSDTA=Y K %DT
 I $D(^YTD(601.4,YSDFN,1,"B",YSCLERK)) W !,"There is a clerk test underway on this patient now",!,"Try again later." G KAR^YTS
 D EN40^YTFILE S ^YTD(601.4,YSDFN,1,YSENT,0)=YSENT,^YTD(601.4,YSDFN,1,"B",YSENT,YSENT)="" L  S YSCL=YSTEST,YSCLN=YSTESTN
ENX ;
 I $D(^YTT(601,YSTEST,"C")) X ^("C") G:J<1 ^YTAR2
 W ! D Q1
NX ;
 I $D(^YTT(601,YSTEST,"Q",J,0)) S X1=^(0) S:$P(X1,U,2)]"" C=$P(X1,U,2) S:$P(X1,U,3)]"" C=$P(X1,U,3)
 I $D(^YTT(601,YSTEST,"Q",J,"B")) S B=^("B") S B1=$S(B?1"W ".PN1"ANSWER".E:0,1:1)
D1 ;
 W:$X>68 ! W $J(J,5),": "
D14 ;
 D RD G D14X:C[X,BK:X="^",CONT:X="*" W:X'="?" " ? " D:$D(X1) Q G D1
D14X ;
 S YSRP=YSRP_X D:J#200=0 WD S J=J+1 I J'>YSNQ G NX
 S J=J+199 I $P(^YTT(601,YSTEST,0),U)?1"MCMI"1N,$D(YSMCMI2P),$D(YSMCMI2L) S YSRP=YSRP_YSMCMI2P_YSMCMI2L ;ASF 5/30/02
 D WD,^YTFILE S XMB(6)=YSTEST,YSXT=YSTEST G DONE^YTAR
RD ;
 R *X:120 S X=$S('$T:"*",X>31&(X<97):$C(X),1:" ") Q
WD ;
 L +^YTD(601.4,YSDFN) S ^YTD(601.4,YSDFN,1,YSENT,J\200)=YSRP I $P(^YTT(601,YSTEST,0),U)="MMPI",$D(YSTF) S X(J\200)=YSRP I J\200=3 D WD1,^YTMMP7 F H=2,3 S ^YTD(601.4,YSDFN,1,YSENT,H)=X(H)
 L -^YTD(601.4,YSDFN) S YSRP="" Q
WD1 ;
 ; 3/10/94 LJA Commented...  F H=1:1:3 S ^YTD(601.4,YSDFN,1,YSENT,H+3)=X(H)
 S ^YTD(601.4,YSDFN,1,YSENT,99)="MMPIR" Q
BK ;
 G D1:J=1,BK1:$L(YSRP)>1,BK2:$L(YSRP)=1,BK3
BK1 ;
 S YSRP=$E(YSRP,1,$L(YSRP)-1),J=J-1 G NX
BK2 ;
 S YSRP="",J=J-1 G NX
BK3 ;
 S J=J-1,YSRP=$E(^YTD(601.4,YSDFN,1,YSCLERK,J\200),1,199) G NX
CONT ;
 S YSTEST=YSCLERK G ^YTAR2
A11 ;
 S YSOK=1 W !! S DIC="^VA(200,",DIC(0)="AEQM",DIC("A")="Professional requesting instrument: ",DIC("B")=DUZ D ^DIC K DIC I Y<1 S YSOK=-1 Q
 I DUZ'=+Y W !!?2,"A message will be sent to ",$P(^VA(200,+Y,0),U) R " OK? Y// ",A:DTIME S YSTOUT='$T,YSUOUT=A["^" I YSTOUT!YSUOUT S YSOK=-1 Q
 I DUZ'=+Y,"Yy"'[$E(A) W !!?2,"The requesting professional must be informed!" G A11
 S YSORD=+Y,YSORDP=$S($D(^XUSEC("YSP",YSORD)):0,1:2) W !!?2,$P(^VA(200,YSORD,0),U)," may order ",$P($T(ORD+YSORDP),";",3) S:YSORDP=2 YSOK=0
 Q
ORD ;;all instruments
 ;;interviews and vocational tests
 ;;only interviews
Q I $P(X1,U,3)]""!('B1) W !!,"Valid responses are: " F I=1:1:$L(C)-1 W $E(C,I),", "
 I  W "and X (missing response)" G Q1
 E  D Q1 X B W !! Q
Q1 ;
 W !!,"Press * to stop, press ^ to back up.",!!
 Q
 ;
TFYN(YSC) ;
 I YSC["T"!(YSC["Y") S C="12X"
 QUIT ""

YTAR ;SLC/DKG,SLC/TGA-ADMINISTER & RESUME TESTS ;5/30/02  14:54
 ;;5.01;MENTAL HEALTH;**37,54,76**;Dec 30, 1994
 ;
 W:YSNT>0 !!?10,"--- Previous Instruments ---",! S B=$S(YSNT<11:YSNT,1:YSNT+1\2)
 F K=1:1:B S YSDT=$P(A1(K),U,2) D DAT W !?15,$P(A1(K),U),?22,YSDT I B'=YSNT,$D(A1(B+K)) W ?50,$P(A1(B+K),U) S YSDT=$P(A1(B+K),U,2) D DAT W ?57,YSDT
 I $D(YSCLERK) G ^YTCLERK
 S:'$D(T1) T1=0 I $D(^YTD(601.4,YSDFN,1,"B")) G ^YTAR1
A10 ;
 W !!!?2,"Do you want DEMO program administered" S %=2 D YN^DICN G:%<0 KAR^YTS
 I '% W !?4,"The DEMO program teaches the patient to use the terminal." G A10
 S YSDEMO=$S(%=1:"Y",1:"N")
A11 ;
 W !! S DIC="^VA(200,",DIC(0)="AEQM",DIC("A")="Professional requesting instrument: ",DIC("B")=DUZ D ^DIC K DIC I Y'>0 G KAR^YTS
 I DUZ'=+Y W !!?2,"A message will be sent to ",$P(^VA(200,+Y,0),U) R " OK? Y// ",A:DTIME S YSTOUT='$T,YSUOUT=A["^" G:YSTOUT!YSUOUT!(A["N")!(A["n") KAR^YTS S:A="" A="Y" I "Yy"'[$E(A) W:A'["?" " ?",$C(7) D MSG1 G A11
 S YSORD=+Y,YSORD(0)=$P(Y,U,2),YSORDP=$S($D(^XUSEC("YSP",YSORD)):0,1:2) I YSORDP>0 S YSORDD=$S($D(^XUSEC("YSP",DUZ)):0,1:2)
 G:T1 A3 ;->
 W $C(7),!!,$P(^VA(200,YSORD,0),U)," may order ",$P($T(ORD+YSORDP),";",3)
 W ", exempt tests, and vocational tests."
A12 ;
 S YSXT="" W !!?2,"Administer the following instruments:",!
A2 ;
 R !?5,"Instrument: ",YSTESTN:DTIME S YSTOUT='$T,YSUOUT=YSTESTN["^" G KAR^YTS:YSTOUT!YSUOUT,A3:YSTESTN=""
 I YSTESTN="CLERK" W !!,"Not a valid instrument, you may want to use the CLERK entry option!",!! G A2
 I YSTESTN["?" D ^YTLIST G A2
 I $L(YSTESTN)>5!(YSTESTN'?.UNP) W " ?" G A2
 I YSTESTN="BECK" D BECK^YTS
 I YSTESTN="MMPI" D MMPI^YTS
 S YSTEST=$O(^YTT(601,"B",YSTESTN,0)) I 'YSTEST W "  [Not Found]" G A2
 S X=^YTT(601,YSTEST,0),YSNX(0)=X I YSORDP>0,$P(X,U,8)'="V",$P(X,U,9)="T",$P(X,U,10)'="Y",YSORDD>0 W !!,YSORD(0)_" is NOT AUTHORIZED to order",!,"Instrument "_$P(YSNX(0),U)_".",!! G A2
 I YSORDP=2,$P(X,U,8)="V",$P(X,U,10)'="Y",YSORDD>1 W !!,YSORD(0)_" is NOT AUTHORIZED to order",!,"Instrument "_$P(YSNX(0),U)_".",!! G A2
 ;I $P(X,U,13)="N" W !!,YSORD(0)_" is NOT AUTHORIZED to order",!,"Instrument "_$P(YSNX(0),U)_".",!! G A2
 I $P(X,U,13)="N" W !!,"You have selected an instrument that is NOT OPERATIONAL.",! G A2
 I $P(X,U,14)="N" D CR G A2
 F Z=1:1 S YSNX=$P(YSXT,U,Z) Q:YSNX=""  I YSNX=YSTEST W "  [Duplicate Ignored]",!! G A2
MCMI2 ;
 I $P(^YTT(601,YSTEST,0),U)?1"MCMI"1N X ^YTT(601,YSTEST,"C") ;ASF 5/30/02
 I $P(X,U,9)="B",YSORDP>0 S YSTEST=$$SCRN(YSTEST) I YSTEST']"" G A2
 S YSXT=YSXT_YSTEST_"^" G:$L(YSXT,U)<11 A2
A3 ;
 G:YSXT="" KAR^YTS S YSQ=0 I $D(^XUSEC("YSP",DUZ))!$D(^XUSEC("YSZ",DUZ)) D A31^YTCLERK1 G:YSOK<1 KAR^YTS
 I YSQ S ZTIO=ION D HOME^%ZIS
 D:"Y"[YSDEMO ^YTDEMO S YSXTP=1
A4 ;
 S YSTEST=$P(YSXT,U,YSXTP) I YSTEST="" G DONE
 D:'$D(YSRESTRT) KT S YS4D=0,YSTESTN=$P(^YTT(601,YSTEST,0),U)
 I $D(^YTT(601,YSTEST,"C")),$P(^YTT(601,YSTEST,0),U)'?1"MCMI"1N X ^("C") I $D(J),J<1 G KAR^YTS ;ASF 5/30/02
 X ^YTT(601,YSTEST,"A") G:$D(YSTIN) KAR^YTS D KT K YSRESTRT S XMB(YSXTP+5)=$P(YSXT,U,YSXTP),YSXTP=YSXTP+1 G A4
DONE ;
 W:'$D(YSCL) @IOF,!!!?10,"*** Thank you for completing the test! ***",!!! H 5 S XMB(5)="" I YSQ S YSXT="" F K=6:1 Q:'$D(XMB(K))  S YSXT=YSXT_YSHD_","_XMB(K)_"^"
 I YSQ S YSXTP=1,ZTRTN="RP1^YTDP",ZTSAVE("YS*")="",ZTDTH=$H,ZTDESC="YS MH INST PRINT" D ^%ZTLOAD W:$D(ZTSK) !!,"Your Task Number is "_ZTSK
 I DUZ'=YSORD,$D(YSCLERK) S XMB(6)="CLERK-"_YSCLN
 E  I DUZ'=YSORD F K=6:1 Q:'$D(XMB(K))  S XMB(K)=$P(^YTT(601,+XMB(K),0),U)
 I DUZ'=YSORD D ENBUL^YSUTL
 G H^XUS:'$D(YSCL)&('$D(YSM)),KAR^YTS
DAT ;
 S YSDT=$$FMTE^XLFDT(YSDT,"5ZD") Q
KT ;
 K J I $D(^YTD(601.4,YSDFN,1,YSTEST)) S YSENT=YSTEST D ENKIL^YTFILE
 Q
CR ;
 W "  [VACO currently does not have a license to use this test]" Q
MSG1 ;
 W !!!?2,"Enter (Y) or <cr> for (YES) to send a message to the person requesting",!,"this test/interview and to CONTINUE this test/interview process."
 W !!?2,"Enter (N) for (NO) to NOT send message and to DISCONTINUE this test/",!,"interview process."
 Q
SCRN(X) ; when a battery is ordered then each test is screened to
 ; see if the person requesting the battery has access to the tests
 ; contained in the battery
 N Y,YSNX,YSXT,Z
 I 'X Q ""
 S X(0)=$G(^YTT(601,X,0)),(YSXT,Y)="" I '$D(^YTT(601,X,"A")) Q ""
 X ^YTT(601,X,"A")
 F Z=1:1 S YSNX=$P(YSXT,U,Z) Q:YSNX=""  D
 .S YSNX(0)=^YTT(601,YSNX,0) I YSORDP>0,$P(YSNX(0),U,8)'="V",$P(YSNX(0),U,9)="T",$P(YSNX(0),U,10)'="Y",YSORDD>0 W !,YSORD(0)_" is NOT AUTHORIZED to order",!,"the "_$P(YSNX(0),U)_" test from the Battery: '"_$P(X(0),U)_"'.",! Q
 .I YSORDP=2,$P(YSNX(0),U,8)="V",$P(YSNX(0),U,10)'="Y",YSORDD>1 W !,YSORD(0)_" is NOT AUTHORIZED to order",!,"the "_$P(YSNX(0),U)_" test from the Battery: '"_$P(X(0),U)_"'.",! Q
 .I $P(YSNX(0),U,13)="N" W !,YSORD(0)_" is NOT AUTHORIZED to order",!,"the "_$P(YSNX(0),U)_" test, from the Battery: '"_$P(X(0),U)_"'.",! Q
 .I $P(X,U,14)="N" W !,"  [VACO currently does not have a license to use this test]" Q
 .S Y=Y_YSNX_U
 Q Y
 ;
ORD ;;all instruments
 ;;interviews and vocational tests
 ;;interviews

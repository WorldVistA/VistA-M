YTONLY ;ASF/ALB,HIOFO/FT - Restricted Psych Testing Option ;8/7/12 3:41pm
 ;;5.01;MENTAL HEALTH;**19,37,60,187**;Dec 30, 1994;Build 73
 ;
 ;Reference to VADPT APIs supported by DBIA #10061
 ;Reference to ^%ZIS supported by IA #10086
 ;Reference to ^XLFDT APIs supported by DBIA #10103
 ;Reference to ^VA(200 supported by IA #10060
 ;Reference to ^XLFSTR supported by DBIA #10104
 ;
MAIN ; main loop
 S (YSXT,YSENTRY)=$O(^YTT(601,"B",YSCODE,0))
 S YSXTP=1,T1=1,T1(0)=$P(^YTT(601,YSXT,"P"),U,4)
 S YSPREV=0
 I YSENTRY=""!($P(^YTT(601,YSENTRY,0),U,13)="N") W !,"Instrument "_YSCODE_" not available" H 3 Q
 S YSTITLE=$P($G(^YTT(601,YSENTRY,"P")),U)
 W @IOF,!,$$CJ^XLFSTR(YSTITLE,79," "),!
 D PT G END:$G(YSDFN)<1
 D NX,PREV
 D OPT1 Q:$D(DIRUT)
 D ADMIN:YSOPT="A",PRINT:YSOPT="P",CLERK:YSOPT="C"
 ;
 G MAIN
ADMIN ;
 K J
 I $D(^YTD(601.4,YSDFN,1,YSENTRY)) G RESTART
 S YSOK=1 W !! S DIC="^VA(200,",DIC(0)="AEQM",DIC("A")="Professional requesting instrument: ",DIC("B")=DUZ D ^DIC K DIC I Y<1 S YSOK=-1 Q
 S YSORD=+Y
 S YSQ=0 D A31^YTCLERK1 I YSOK<1 D KAR^YTS Q
 I YSQ S ZTIO=ION D HOME^%ZIS
 S YSTEST=YSENTRY,YSXT=YSENTRY,YSXTP=1
 D A4^YTAR
 Q
RESTART ;
 K DIR S DIR(0)="S^R:Restart "_YSCODE_";D:Delete previous incomplete and administer;Q:Quit"
 D ^DIR K DIR
 Q:$D(DIRUT)!(Y="Q")
 I Y="D" S YSTEST=YSENTRY D KT,ADMIN Q
 S YSTEST=YSENTRY
 S YTLM=3
 I $P($G(^YTT(601,YSTEST,0)),U,16) S YTLM=$P(^(0),U,16)
 S X2=$S($P(^YTD(601.4,YSDFN,1,YSTEST,0),U,8):$P(^(0),U,8),1:$P(^(0),U,2))
 S X=$$FMDIFF^XLFDT(DT,X2,1)
 I X>YTLM W !,"Administration discontinued more than "_YTLM_" days ago -- not restartable" H 2 Q
 S YSTEST=YSENTRY
 S (B,C)="",J=+$P(^YTD(601.4,YSDFN,1,YSENTRY,0),U,4),C=$P(^(0),U,5),YSORD=$P(^(0),U,7) S:$P(^(0),U,8) YSBEGIN=$P(^(0),U,8)
 I $D(^YTD(601.4,YSDFN,1,YSENTRY,"B"))#2 S B=^("B")
 S YSRP=$S(J#200=1:"",1:^YTD(601.4,YSDFN,1,YSENTRY,J+198\200)) S:'J J=1
 S YSXT=YSTEST_"^" S:$D(^YTD(601.4,YSDFN,1,YSENTRY,"R")) YSXT=YSXT_^("R") S YSXTP=1,YSDEMO="N",YSRESTRT=1
 S YSQ=0 D A31^YTCLERK1 I YSOK<1 D KAR^YTS Q
 I YSQ S ZTIO=ION D HOME^%ZIS
 D A4^YTAR
 Q
PRINT ;
 S YSXT=""
 W !
 D DU^YTDP
 Q
CLERK ;
 S YSCL=1,(YTESTN,YSTESTN)=YSCODE,YSCLERK=14,YSENT=14,YSTEST=YSENTRY,YSNQ=$P(^YTT(601,YSENTRY,0),U,11)
 I $D(^YTD(601.4,YSDFN,1,"AC",YSENTRY)) W !!,"Discontinued CLERK test found:" G RESTART^YTCLERK1
 I $D(^YTD(601.4,YSDFN)) S DIK="^YTD(601.4,",DA=YSDFN D ^DIK K DIK
 S YSOK=1 W !! S DIC="^VA(200,",DIC(0)="AEQM",DIC("A")="Professional requesting instrument: ",DIC("B")=DUZ D ^DIC K DIC I Y<1 S YSOK=-1 Q
 S YSORD=+Y
 S YSQ=0 D A31^YTCLERK1 I YSOK<1 D KAR^YTS Q
 S (J,YSXTP)=1,(B,C,YSRP)=""
 D REY1^YTCLERK
 Q
PT ;
 D ^YSLRP G:YSDFN<1 END D ENPT^YSUTL
 I YSSEX="" W !,"Gender not properly specified. Call IRM" H 3 G MAIN
 Q
OPT1 ;admin, clerk, print
 W !
 K DIR
 S DIR(0)="S^A:Administer on-line;C:Clerk entry"
 S:YSPREV DIR(0)=DIR(0)_";P:Print"
 S DIR("A")=$S(YSPREV:"Administer on-line, Clerk entry or Print",1:"Administer on-line or Clerk entry")
 D ^DIR
 S YSOPT=Y
 K DIR
 G MAIN:$D(DIRUT)
 Q
NX ;
 K A,A1
 S %=$H>21549+$H-.1,%Y=%\365.25+141,%=%#365.25\1,YSPTD=%+306#(%Y#4=0+365)#153#61#31+1,YSPTM=%-YSPTD\29+1,Y=%Y_"00"+YSPTM_"00"+YSPTD,YSDT(0)=$$FMTE^XLFDT(Y,"5ZD")
 S YSSX=YSSEX,YSBL="           ",YSHDR=$$MASKSSN(YSSSN)_"  "_YSNM_YSBL_YSBL_YSBL,YSHDR=$E(YSHDR,1,44)_YSSX_" AGE "_YSAGE,YSHD=DT
 S YSHDT=""
 I '$D(^YTD(601.2,YSDFN,1,YSENTRY)) K A,A1 Q
 S YSNT=0,N2=0 F  S N2=$O(^YTD(601.2,YSDFN,1,YSENTRY,1,N2)) Q:'N2  S A(YSCODE,N2)=YSENTRY,YSNT=YSNT+1,A1(YSNT)=YSCODE_U_N2_U_YSENTRY
 Q
MASKSSN(YSSSN) ; return only last 4 of SSN
 Q "xxx-xx-"_$E(YSSSN,$L(YSSSN)-3,$L(YSSSN))
 ;
PREV ;
 W @IOF,YSHDR
 I '$D(A1(1)),'$D(^YTD(601.4,YSDFN,1,YSENTRY,0)),'$D(^YTD(601.4,YSDFN,1,"AC",YSENTRY)) W !!,?10,"No Previous Administrations on File" S YSPREV=0 Q
 I $D(^YTD(601.4,YSDFN,1,YSENTRY,0)) W !!,"Incomplete "_YSCODE_" on-line administration found on " S Y=$P(^(0),U,2) X ^DD("DD") W Y Q
 I $D(^YTD(601.4,YSDFN,1,"AC",YSENTRY)) W !!,"Incomplete "_YSCODE_" clerk entry found on " S Y=$P(^YTD(601.4,YSDFN,1,14,0),U,2) X ^DD("DD") W Y Q
 ;
 W !!,"Previous Administrations of the",$S(YSTITLE["*":$TR(YSTITLE,"*",""),YSTITLE["-":$TR(YSTITLE,"-",""),1:" "_YSTITLE),!!
 F I=1:1 Q:'$D(A1(I))  D
 . S YSPREV=I
 . S Y=$P(A1(I),U,2)
 . X ^DD("DD")
 . W:$X>60 !
 . W $J(I,3)_" "_Y_"   "
 Q
KT ;
 K J I $D(^YTD(601.4,YSDFN,1,YSTEST)) S YSENTRY=YSTEST D ENKIL^YTFILE
 Q
END ;
 D KVAR^VADPT
 K %,%Y,A,A1,B,C,I,J,N2,T1,X,X2,Y,YSAGE,YSBEGIN,YSBL,YSCL,YSCLERK
 K YSCODE,YSDEMO,YSDFN,YSDT,YSENT,YSENTRY,YSHD,YSHDR,YSHDT,YSNM,YSNQ
 K YSNT,YSOK,YSOPT,YSORD,YSPREV,YSPTD,YSPTM,YSQ,YSRESTRT,YSRP,YSSEX
 K YSSSN,YSSX,YSTEST,YSTESTN,YSTITLE,YSXT,YSXTP,YTESTN,YTLM
 Q

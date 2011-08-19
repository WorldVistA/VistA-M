YSASCSB ;692/DCL-ASI MISSING COMPOSITE SCORES ;1/23/97  11:39
 ;;5.01;MENTAL HEALTH;**24**;Dec 30, 1994
 Q
 ;
IF(YSASIEN,YSASFLD,YSASFLG) ;pass ien and field - return content
 Q:$G(YSASIEN)'>0 ""
 Q:$G(YSASFLD)'>0 ""
 N DIERR
 Q $$GET1^DIQ(604,YSASIEN_",",YSASFLD,$G(YSASFLG))
 ;
C(X,Y,Z) ;return score/msg - pass data in X, Item # in Y and optional comment in Z.
 I $G(X)="" Q "  Item "_Y_$J("",(4-$L(Y)))_"      <missing data>  "_$G(Z)
 Q "  Item "_Y_$J("",(4-$L(Y)))_$J(X,6)_" ..ok  "_$G(Z)
 ;
EM(X) ;Error Message
 Q:$G(X)="" ""
 Q "No Composite Score"
 ;
SM(X) ;Score Message
 Q:$G(X)="" ""
 Q "Composite Score: "
 ;
EN(YSASDA) ;Entry point 
 N YSASQUIT,%ZIS,POP
 S %ZIS="QM"
 D ^%ZIS
 Q:$G(POP)
 I $D(IO("Q")) D  Q
 .N ZTRTN,ZTDESC,ZTSAVE
 .S ZTRTN="QTEP^YSASCSB"
 .S ZTDESC="Display Status of Each Composite Score Item"
 .S ZTSAVE("YSASDA")=""
 .D ^%ZTLOAD
 .D HOME^%ZIS
 .Q
 U IO
QTEP ;Queued Task Entry Point
 D CSMS,CSES,CSA,CSD,EN^YSASCSC
 ;I $E(IOST)="P" W:$D(IOF) @IOF
 Q:$$FF
 D ^%ZISC
 Q
CSMS ;Composit Score for Medical Status
 I $E(IOST)="C" W:$D(IOF) @IOF
 D HDR
 W !!,"Fields for Medical Composite Scores"
 W !,"-----------------------------------",!
 N YSASA,YSASB,YSASC,YSASI
 S YSASA=$$IF(YSASDA,8.08)
 W !,$$C(YSASA,"M6")
 S YSASB=$$IF(YSASDA,8.09)
 W !,$$C(YSASB,"M7")
 S YSASC=$$IF(YSASDA,8.11)
 W !,$$C(YSASC,"M8")
 I YSASA=""!(YSASB="")!(YSASC="") W !!,$$EM("Medical") Q
 W !!,$$SM("Medical"),$J((YSASA/90)+(YSASB/12)+(YSASC/12),6,4)
 Q
 ;
CSES ;Composit Score for Employment Status
 W !!!,"Items for Employment Composite Scores"
 W !,"-------------------------------------",!
 N YSASA,YSASB,YSASC,YSASD,YSASI
 S YSASA=$$IF(YSASDA,9.06,"I")
 W !,$$C(YSASA,"E4")
 S YSASB=$$IF(YSASDA,9.09,"I")
 W !,$$C(YSASB,"E5")
 S YSASC=$$IF(YSASDA,9.18)
 W !,$$C(YSASC,"E11")
 S YSASD=$$IF(YSASDA,9.19)
 W !,$$C(YSASD,"E12")
 I YSASA=""!(YSASB="")!(YSASC="")!(YSASD="") W !!,$$EM("Employment") Q
 S:YSASD>0 YSASD=$$LN^XLFMTH(YSASD)
 S YSASA=YSASA/4,YSASB=YSASB/4,YSASC=YSASC/120,YSASD=YSASD/36
 W !!,$$SM("Employment"),$J(1.000-(YSASA+YSASB+YSASC+YSASD),6,4)
 Q
 ;
CSA ;Composit Score for Alcohol
 Q:$$FF
 D:$E(IOST)="C" HDR
 W !!!,"Items for Alcohol Composite Scores"
 W !,"----------------------------------",!
 N YSASA,YSASB,YSASC,YSASD,YSASE,YSASF
 S YSASA=$$IF(YSASDA,10.01)
 W !,$$C(YSASA,"D1")
 S YSASB=$$IF(YSASDA,10.04)
 W !,$$C(YSASB,"D2")
 S YSASC=$$IF(YSASDA,11.14)
 W !,$$C(YSASC,"D26")
 S YSASD=$$IF(YSASDA,11.16)
 W !,$$C(YSASD,"D28")
 S YSASE=$$IF(YSASDA,11.165)
 W !,$$C(YSASE,"D30")
 S YSASF=$$IF(YSASDA,11.09)
 W !,$$C(YSASF,"D23")
 I YSASA=""!(YSASB="")!(YSASC="")!(YSASD="")!(YSASE="")!(YSASF="") W !!,$$EM("Alcohol") Q
 S:YSASF>0 YSASF=$$LN^XLFMTH(YSASF)
 S YSASA=YSASA/180,YSASB=YSASB/180,YSASC=YSASC/180,YSASD=YSASD/24
 S YSASE=YSASE/24,YSASF=YSASF/44
 W !!,$$SM("Alcohol"),$J(YSASA+YSASB+YSASC+YSASD+YSASE+YSASF,6,4)
 Q
 ;
CSD ;Composit Score for Drug
 Q:$$FF
 D:$E(IOST)="C" HDR
 W !!!,"Items for Drug Composite Scores"
 W !,"-------------------------------",!
 N YSASA,YSASB,YSASC,YSASD,YSASE,YSASF,YSASG,YSASH,YSASI,YSASJ,YSASK,YSASL,YSASM
 S YSASA=$$IF(YSASDA,10.07)
 W !,$$C(YSASA,"D3")
 S YSASB=$$IF(YSASDA,10.11)
 W !,$$C(YSASB,"D4")
 S YSASC=$$IF(YSASDA,10.15)
 W !,$$C(YSASC,"D5")
 S YSASD=$$IF(YSASDA,10.18)
 W !,$$C(YSASD,"D6")
 S YSASE=$$IF(YSASDA,10.22)
 W !,$$C(YSASE,"D7")
 S YSASF=$$IF(YSASDA,10.25)
 W !,$$C(YSASF,"D8")
 S YSASG=$$IF(YSASDA,10.28)
 W !,$$C(YSASG,"D9")
 S YSASH=$$IF(YSASDA,10.32)
 W !,$$C(YSASH,"D10")
 S YSASI=$$IF(YSASDA,10.35)
 W !,$$C(YSASI,"D11")
 S YSASJ=$$IF(YSASDA,10.42)
 W !,$$C(YSASJ,"D13")
 S YSASK=$$IF(YSASDA,11.15)
 W !,$$C(YSASK,"D27")
 S YSASL=$$IF(YSASDA,11.17)
 W !,$$C(YSASL,"D29")
 S YSASM=$$IF(YSASDA,11.175)
 W !,$$C(YSASM,"D31")
 I YSASA=""!(YSASB="")!(YSASC="")!(YSASD="")!(YSASE="")!(YSASF="")!(YSASG="")!(YSASH="")!(YSASI="")!(YSASJ="")!(YSASK="")!(YSASL="")!(YSASM="") W !!,$$EM("Drug") Q
 S YSASA=YSASA/390,YSASB=YSASB/390,YSASC=YSASC/390,YSASD=YSASD/390
 S YSASE=YSASE/390,YSASF=YSASF/390,YSASG=YSASG/390,YSASH=YSASH/390
 S YSASI=YSASI/390,YSASJ=YSASJ/390,YSASK=YSASK/390,YSASL=YSASL/52
 S YSASM=YSASM/52
 W !!,$$SM("Drug"),$J(YSASA+YSASB+YSASC+YSASD+YSASE+YSASF+YSASG+YSASH+YSASI+YSASJ+YSASK+YSASL+YSASM,6,4)
 Q
 ;
 ;
FF() ;Form Feed
 I $E(IOST)'="C" Q 0
 I $G(YSASQUIT) Q 1
 N X
 W !!,"<press <cr> to continue>"
 R X:DTIME
 W:$D(IOF) @IOF
 I $E(X)="^" S YSASQUIT=1 Q 1
 Q 0
 ;
HDR ;Header
 W !,$$IF(YSASDA,.02),"  ASI interview date: ",$$IF(YSASDA,.05)
 Q

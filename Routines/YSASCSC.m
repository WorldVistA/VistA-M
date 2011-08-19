YSASCSC ;692/DCL-ASI MISSING COMPOSITE SCORES ;1/23/97  11:41
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
EN ;Entry point continuation from YSASCSB
 D CSLS,CSFSR,CSPS
 Q
CSLS ;Composite Score for Legal Status
 I $E(IOST)="P" W:$D(IOF) @IOF
 Q:$$FF
 D HDR
 W !!!,"Items for Legal Composite Scores"
 W !,"--------------------------------",!
 N YSASA,YSASB,YSASC,YSASD,YSASE
 S YSASA=$$IF(YSASDA,14.27,"I")
 W !,$$C(YSASA,"L24")
 S YSASB=$$IF(YSASDA,14.31)
 W !,$$C(YSASB,"L27")
 S YSASC=$$IF(YSASDA,14.32)
 W !,$$C(YSASC,"L28")
 S YSASD=$$IF(YSASDA,14.33)
 W !,$$C(YSASD,"L29")
 S YSASE=$$IF(YSASDA,9.25)
 W !,$$C(YSASE,"E17","<Item 17 from Employment Domain>")
 I YSASA=""!(YSASB="")!(YSASC="")!(YSASD="")!(YSASE="") W !!,$$EM("Legal") Q
 S:YSASE>0 YSASE=$$LN^XLFMTH(YSASE)
 S YSASA=YSASA/5,YSASB=YSASB/150,YSASC=YSASC/20,YSASD=YSASD/20
 S YSASE=YSASE/46
 W !!,$$SM("Legal"),$J(YSASA+YSASB+YSASC+YSASD+YSASE,6,4)
 Q
 ;
CSFSR ;Composite Score for Family/Social Relationships
 Q:$$FF
 D:$E(IOST)="C" HDR
 W !!!,"Items for Family/Social Composite Scores"
 W !,"----------------------------------------",!
 N YSASA,YSASB,YSASC,YSASD,YSASR
 S YSASA=$$IF(YSASDA,17.04)
 S:YSASA]"" YSASA=$S(YSASA="YES":0,YSASA="NO":2,1:1)
 W !,$$C(YSASA,"F3")
 S YSASB=$$IF(YSASDA,18.23)
 W !,$$C(YSASB,"F30")
 S YSASC=$$IF(YSASDA,18.25)
 W !,$$C(YSASC,"F32")
 S YSASD=$$IF(YSASDA,18.27)
 W !,$$C(YSASD,"F34")
 D
 .N YSASI,YSASX
 .S YSASR=0
 .S YSASF=".01,.03,.05,.07,.09,.12,.15,.17,.185"
 .S YSASI="10,11,12,13,14,15,16,17,18"
 .F YSASC=1:1:9 D
 ..S YSASX=$$IF(YSASDA,18_$P(YSASF,",",YSASC),"I")
 ..W !,$$C(YSASX,"F"_(YSASC+17))
 ..S:YSASX="" YSASR=""
 ..Q:YSASR=""
 ..S YSASR=YSASR+YSASX
 ..Q
 .Q:YSASR=""
 .S YSASR=YSASR/9
 .Q
 I YSASA=""!(YSASB="")!(YSASC="")!(YSASD="")!(YSASR="") W !!,$$EM("Family/Social") Q
 S YSASA=YSASA/10,YSASB=YSASB/150,YSASC=YSASC/20,YSASD=YSASD/20
 S YSASR=YSASR/5
 W !!,$$SM("Family/Social"),$J(YSASA+YSASB+YSASC+YSASD+YSASR,6,4)
 Q
 ;
CSPS ;Composite Score for Psychiatric Status
 Q:$$FF
 D:$E(IOST)="C" HDR
 W !!!,"Items for Psychiatric Composite Scores"
 W !,"--------------------------------------",!
 N YSASA,YSASB,YSASC,YSASD,YSASE,YSASF,YSASG,YSASH,YSASI,YSASJ,YSASK
 S YSASA=$$IF(YSASDA,19.04,"I")
 W !,$$C(YSASA,"P3")
 S YSASB=$$IF(YSASDA,19.06,"I")
 W !,$$C(YSASB,"P4")
 S YSASC=$$IF(YSASDA,19.08,"I")
 W !,$$C(YSASC,"P5")
 S YSASD=$$IF(YSASDA,19.11,"I")
 W !,$$C(YSASD,"P6")
 S YSASE=$$IF(YSASDA,19.14,"I")
 W !,$$C(YSASE,"P7")
 S YSASF=$$IF(YSASDA,19.16,"I")
 W !,$$C(YSASF,"P8")
 S YSASG=$$IF(YSASDA,19.18,"I")
 W !,$$C(YSASG,"P9")
 S YSASH=$$IF(YSASDA,19.21,"I")
 W !,$$C(YSASH,"P10")
 S YSASI=$$IF(YSASDA,19.23)
 W !,$$C(YSASI,"P11")
 S YSASJ=$$IF(YSASDA,19.24)
 W !,$$C(YSASJ,"P12")
 S YSASK=$$IF(YSASDA,19.25)
 W !,$$C(YSASK,"P13")
 I YSASA=""!(YSASB="")!(YSASC="")!(YSASD="")!(YSASE="")!(YSASF="")!(YSASG="")!(YSASH="")!(YSASI="")!(YSASJ="")!(YSASK="") W !!,$$EM("Paychiatric") Q
 S YSASA=YSASA/11,YSASB=YSASB/11,YSASC=YSASC/11,YSASD=YSASD/11
 S YSASE=YSASE/11,YSASF=YSASF/11,YSASG=YSASG/11,YSASH=YSASH/11
 S YSASI=YSASI/330,YSASJ=YSASJ/44,YSASK=YSASK/44
 W !!,$$SM("Psychiatric"),$J(YSASA+YSASB+YSASC+YSASD+YSASE+YSASF+YSASG+YSASH+YSASI+YSASJ+YSASK,6,4)
 Q
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
 W !,$$IF(YSASDA,.02),"  ASI date of interview: ",$$IF(YSASDA,.05)
 Q

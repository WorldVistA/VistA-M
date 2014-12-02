LEXXGI2 ;ISL/KER - Global Import (Protocol/Checksum/Misc) ;04/21/2014
 ;;2.0;LEXICON UTILITY;**25,26,28,29,46,49,50,73,80**;Sep 23, 1996;Build 1
 ;             
 ; Global Variables
 ;    ^LEXM               N/A
 ;    ^ORD(101,           ICR    872
 ;    ^UTILITY($J         ICR  10011
 ;               
 ; External References
 ;    ^DIWP               ICR  10011
 ;    $$FMDIFF^XLFDT      ICR  10103
 ;    $$FMTE^XLFDT        ICR  10103
 ;    $$NOW^XLFDT         ICR  10103
 ;    BMES^XPDUTL         ICR  10141
 ;    MES^XPDUTL          ICR  10141
 ;    EN^XQOR             ICR  10101
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;     LEXCHG    Post-Install
 ;     LEXNOPRO  Post-Install
 ;     XPDNM     KIDS install
 ;            
 Q
NOTIFY ; Notify by Protocol - LEXICAL SERVICES UPDATE
 ;     Uses LEXSCHG() from the Post-Install
 ;     Sets ^LEXM(0,"PRO")=$$NOW^XLFDT
 Q:$D(LEXNOPRO)  Q:'$D(LEXSCHG("ICD"))&('$D(LEXSCHG("CPT")))&('$D(LEXSCHG("LEX")))
 S:$D(LEXSCHG("ICD")) LEXSCHG("ICD")=0,LEXSCHG("LEX")=0 S:$D(LEXSCHG("CPT")) LEXSCHG("CPT")=0,LEXSCHG("LEX")=0
 S:'$D(LEXSCHG("ICD"))&('$D(LEXSCHG("CPT")))&($D(LEXSCHG("LEX"))) LEXSCHG("ICD")=0,LEXSCHG("CPT")=0
 N X,LEXU,LEXF,LEXI,LEXL,LEX1,LEX2,LEX3,LEXN,LEXP,LEXUP,LEXPC S LEXUP="",LEXPC=0
 S:$D(LEXSCHG("ICD")) LEXUP=$G(LEXUP)_"ICD" S:$D(LEXSCHG("CPT")) LEXUP=$G(LEXUP)_"/CPT"
 S:$E(LEXUP,1)="/" LEXUP=$E(LEXUP,2,$L(LEXUP)) S:$L(LEXUP) LEXUP=LEXUP_" "
 S:$D(LEXSCHG("LEX")) LEXF="Lexicon" S:$D(LEXSCHG("ICD")) LEXF=$G(LEXF)_", ICD" S:$D(LEXSCHG("CPT")) LEXF=$G(LEXF)_", CPT"
 S:$E($G(LEXF),1,2)=", " LEXF=$E($G(LEXF),3,$L($G(LEXF))),LEXF=$$TRIM(LEXF)
 I $L(LEXF) D
 . S:$L(LEXF,", ")>1 LEXF=$P($G(LEXF),", ",1,($L($G(LEXF),", ")-1))_" and "_$P($G(LEXF),", ",$L($G(LEXF),", "))
 . S:$L($P(LEXF,", ",1)) LEXF=$G(LEXF)_" File"_$S(LEXF[", ":"s",LEXF[" and ":"s",1:"")_" Updated"
 S LEXL=78-($L(LEXF)+4),LEXU="Lexical Files Updated"
 Q:'$D(LEXSCHG)  S LEXP=+($O(^ORD(101,"B","LEXICAL SERVICES UPDATE",0))) Q:LEXP=0  S X=LEXP_";ORD(101," D EN^XQOR
 S:$G(LEXSCHG("LEX"))>0!($G(LEXSCHG("ICD"))>0)!($G(LEXSCHG("CPT"))>0) ^LEXM(0,"PRO")=$$NOW^XLFDT
 S:$G(LEXSCHG("ICD"))>0!($G(LEXSCHG("CPT"))>0) LEXU="Lexicon/Code Sets Updated"
 Q:+($G(^LEXM(0,"PRO")))'>0  K LEXPROC D:$L($G(LEXU)) BL,TL($G(LEXU)),BL
 I +($G(LEXSCHG("LEX")))>0 D
 . N X,LEXED S X="  'LEXICAL SERVICES UPDATE' ",X=X_$J(" ",(30-$L(X)))
 . S LEXED=$$EDT($G(LEXSCHG("LEX"))) S:$L(LEXED) X=X_" "_LEXED S LEXPC=+($G(LEXPC))+1 S:$L(LEXED) LEXPROC((LEXPC+1))=X
 I +($G(LEXSCHG("ICD")))>0 D
 . N X,LEXED S X="  'ICD CODE UPDATE EVENT'   ",X=X_$J(" ",(30-$L(X)))
 . S LEXED=$$EDT($G(LEXSCHG("ICD"))) S:$L(LEXED) X=X_" "_LEXED S LEXPC=+($G(LEXPC))+1 S:$L(LEXED) LEXPROC((LEXPC+1))=X
 I +($G(LEXSCHG("CPT")))>0 D
 . N X,LEXED S X="  'CPT CODE UPDATE EVENT'   ",X=X_$J(" ",(30-$L(X)))
 . S LEXED=$$EDT($G(LEXSCHG("CPT"))) S:$L(LEXED) X=X_" "_LEXED S LEXPC=+($G(LEXPC))+1 S:$L(LEXED) LEXPROC((LEXPC+1))=X
 S:$O(LEXPROC(" "),-1)>1 LEXPROC(1)="Protocol invoked:" S:$O(LEXPROC(" "),-1)>2 LEXPROC(1)="Protocols invoked:"
 S LEXPC=0 F  S LEXPC=$O(LEXPROC(LEXPC)) Q:+LEXPC'>0  D
 . S X=$G(LEXPROC(LEXPC)) D TL(X) D:X["Protocol" BL
 S X="Subscribing applications were notified of the "_LEXUP_"update" D BL,TL(X),BL
 Q
UPCHG ;
 Q:+($G(LEXFI))'>0  N LEXID S LEXID=$S($P(LEXFI,".",1)="757":"LEX",$P(LEXFI,".",1)="80":"ICD",$P(LEXFI,".",1)="81":"CPT",1:"") Q:'$L(LEXID)
 S LEXSCHG(LEXID)=+($G(LEXSCHG(LEXID)))
 Q
SCHG ; Change Array LEXSCHG (Some or all, but never nothing)
 N LEXFI,LEXID K LEXSCHG S LEXCHG=0
 N LEXFI S LEXFI=0 F  S LEXFI=$O(^LEXM(LEXFI)) Q:+LEXFI'>0  D
 . S LEXID=$S(LEXFI=80!(LEXFI=80.1):"ICD",LEXFI=81!(LEXFI=81.1)!(LEXFI=81.2)!(LEXFI=81.3):"CPT",$P(LEXFI,".",1)=757:"LEX",1:"UNK")
 . S LEXSCHG(LEXFI,0)=+($G(^LEXM(LEXFI,0))),LEXSCHG("B",LEXFI)="" S LEXSCHG("C",LEXID,LEXFI)=""
 S:$D(LEXSCHG("C","CPT"))!($D(LEXSCHG("C","ICD"))) LEXSCHG("D","PRO")=""
 S:$D(^LEXM(80))!($D(^LEXM(80.1)))!($D(^LEXM(81)))!($D(^LEXM(81.2)))!($D(^LEXM(81.3)))!($D(LEXSCHG("D","PRO"))) LEXCHG=1,LEXSCHG(0)=1
 D:$O(LEXSCHG(0))'>0 SALL S:$D(LEXSCHG("C","CPT"))!($D(LEXSCHG("C","ICD"))) LEXSCHG("D","PRO")=""
 Q
SALL ;   Set All (ICD/CPT/Lexicon)
 D SICD,SCPT,SLEX
 Q
SICD ;   Set ICD
 S (LEXSCHG("80",0),LEXSCHG("B","80"),LEXSCHG("C","ICD","80"))="",(LEXSCHG("80.1",0),LEXSCHG("B","80.1"),LEXSCHG("C","ICD","80.1"))="" D SLEX
 Q
SCPT ;   Set CPT
 S (LEXSCHG("81",0),LEXSCHG("B","81"),LEXSCHG("C","CPT","81"))="",(LEXSCHG("81.1",0),LEXSCHG("B","81.1"),LEXSCHG("C","CPT","81.1"))=""
 S (LEXSCHG("81.2",0),LEXSCHG("B","81.2"),LEXSCHG("C","CPT","81.2"))="",(LEXSCHG("81.3",0),LEXSCHG("B","81.3"),LEXSCHG("C","CPT","81.3"))="" D SLEX
 Q
SLEX ;   Set Lexicon
 S (LEXSCHG("757",0),LEXSCHG("B","757"),LEXSCHG("C","LEX","757"))="",(LEXSCHG("757.001",0),LEXSCHG("B","757.001"),LEXSCHG("C","LEX","757.001"))=""
 S (LEXSCHG("757.01",0),LEXSCHG("B","757.01"),LEXSCHG("C","LEX","757.01"))="",(LEXSCHG("757.02",0),LEXSCHG("B","757.02"),LEXSCHG("C","LEX","757.02"))=""
 S (LEXSCHG("757.1",0),LEXSCHG("B","757.1"),LEXSCHG("C","LEX","757.1"))=""
 Q
CS ;   Checksum for import global
 N LEXCHK,LEXNDS,LEXVER S LEXCHK=+($G(^LEXM(0,"CHECKSUM")))
 W !,"   Running checksum routine on the ^LEXM import global, please wait"
 S LEXNDS=+($G(^LEXM(0,"NODES"))),LEXVER=+($$VC(LEXCHK,LEXNDS)) W !
 W:LEXVER>0 !,"     Checksum is ok",! Q:LEXVER>0
 I LEXVER=0 W !!,"   Import global ^LEXM is missing.  Please obtain a copy of ^LEXM before",!,"   continuing." Q
 I LEXVER<0 D  Q
 . I LEXVER'=-3 W !,"   Unable to verify checksum for import global ^LEXM (possibly corrupt)"
 . I LEXVER=-3 W !,"   Import global ^LEXM failed checksum"
 . W !!,"     Please KILL the existing import global ^LEXM from your system and"
 . W !,"     obtain a new copy of ^LEXM before continuing with the installation."
 Q
VC(X,Y) ;   Verify Checksum for import global
 Q:'$D(^LEXM)!('$D(^LEXM(0)))!($O(^LEXM(0))'>0) 0  N LEXCHK,LEXNDS,LEXCNT,LEXLC,LEXL,LEXS,LEXNC,LEXD,LEXN,LEXC,LEXGCS,LEXP,LEXT
 S LEXCHK=+($G(X)),LEXNDS=+($G(Y)) Q:LEXCHK'>0!(LEXNDS'>0) -2  S LEXL=64,(LEXCNT,LEXLC)=0,LEXS=(+(LEXNDS\LEXL))
 S:LEXS=0 LEXS=1 W:+($O(^LEXM(0)))>0 ! S (LEXC,LEXN)="^LEXM",(LEXNC,LEXGCS)=0 W "   "
 F  S LEXN=$Q(@LEXN) Q:LEXN=""!(LEXN'[LEXC)  D
 . Q:LEXN="^LEXM(0,""CHECKSUM"")"  Q:LEXN="^LEXM(0,""NODES"")"  S LEXCNT=LEXCNT+1
 . I LEXCNT'<LEXS S LEXLC=LEXLC+1 W:LEXLC'>LEXL "." S LEXCNT=0
 . S LEXNC=LEXNC+1,LEXD=@LEXN,LEXT=LEXN_"="_LEXD F LEXP=1:1:$L(LEXT) S LEXGCS=$A(LEXT,LEXP)*LEXP+LEXGCS
 Q:LEXNC'=LEXNDS -3  Q:LEXGCS'=LEXCHK -3
 Q 1
 ; Miscellaneous
NF ;   Import Global Not Found
 D PB(" Import Global ^LEXM not found, consult the installation instructions")
 D TL(" to install this global")
 Q
IG ;   Invalid Import Global
 D PB(" Invalid Import Global ^LEXM, please consult the installation")
 D TL(" instructions to reload this global")
 Q
BL ;   Blank Line
 N X S X="" W:'$D(XPDNM) ! D:$D(XPDNM) MES^XPDUTL(X) Q
PB(X) ;   Preceeding Blank Line
 S X=$G(X) Q:'$L(X)  W:'$D(XPDNM) !!,X D:$D(XPDNM) BMES^XPDUTL(X) Q
TL(X) ;   Text Line
 S X=$G(X) Q:'$L(X)  W:'$D(XPDNM) !,X D:$D(XPDNM) MES^XPDUTL(X) Q
HACK(X) ;   Time
 S X=$$NOW^XLFDT Q X
ELAP(LEX1,LEX2) ;   Elapsed Time
 N X S X=$$FMDIFF^XLFDT(+($G(LEX2)),+($G(LEX1)),3)
 S:X="" X="00:00:00" S X=$TR(X," ","0") S LEX1=X Q LEX1
 Q
KLEXM ;   Subscripted Kill of ^LEXM - files only
 N LEX S LEX=0 F  S LEX=$O(^LEXM(LEX)) Q:+LEX'>0  K ^LEXM(LEX)
 Q
KALL ;   Subscripted Kill of ^LEXM - all
 K LEXPTYPE,LEXLREV,LEXREQP,LEXBUILD,LEXIGHF,LEXFY,LEXQTR,LEXB,LEXCD,LEXSTR,LEXLAST
 K DIC,DICR,DILOCKTM,DIW,XMDUN,XMZ,ZTSK
 N LEX S LEX=0 F  S LEX=$O(^LEXM(LEX)) Q:+LEX'>0  K ^LEXM(LEX)
 K ^LEXM(0)
 Q
 ;   Error Text
ET(X) ;     Save Text
 N LEXI S LEXI=+($G(LEXE(0))),LEXI=LEXI+1,LEXE(LEXI)=$G(X),LEXE(0)=LEXI Q
ED ;     Display Text
 N LEXI S LEXI=0 F  S LEXI=$O(LEXE(LEXI)) Q:+LEXI=0  W !,LEXE(LEXI)
 W ! K LEXE
 Q
 ;   Case
MIX(X) ;     Mixed Case
 S X=$G(X) N LEXT,LEXI S LEXT=""
 F LEXI=1:1:$L(X," ") S LEXT=LEXT_" "_$$UP($E($P(X," ",LEXI),1))_$$LO($E($P(X," ",LEXI),2,$L($P(X," ",LEXI))))
 F  Q:$E(LEXT,1)'=" "  S LEXT=$E(LEXT,2,$L(LEXT))
 S:$E(LEXT,1,3)="Cpt" LEXT="CPT"_$E(LEXT,4,$L(LEXT)) S:$E(LEXT,1,3)="Icd" LEXT="ICD"_$E(LEXT,4,$L(LEXT)) S X=LEXT
 Q X
UP(X) ;     Uppercase
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
LO(X) ;     Lowercase
 Q $TR(X,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
WP(LEX,X) ;   Wrap Text LEX with Length L
 K ^UTILITY($J,"W") N LEXCT,DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,DN,LEXLEN,LEXTI,LEXI
 S LEXTI=0,LEXLEN=+($G(X)) F  S LEXTI=$O(LEX(LEXTI)) Q:+LEXTI'>0  D
 . N X,DIWX,DN,DTOUT,DUOUT S X=$G(LEX(LEXTI)),DIWL=1,DIWF="C78" S:+($G(LEXLEN))>0 DIWF="C"_+($G(LEXLEN)) D ^DIWP
 K LEX S (LEXCT,LEXI)=0 F  S LEXI=$O(^UTILITY($J,"W",1,LEXI)) Q:+LEXI=0  D
 . N X S X=$G(^UTILITY($J,"W",1,LEXI,0)),LEXCT=LEXCT+1,LEX(LEXCT)=$$TRIM(X)
 K ^UTILITY($J,"W")
 Q
CLR ;   Clear
 K DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,DN,DTOUT,DUOUT,LEX
 K LEX1,LEX2,LEX3,LEXC,LEXCHK,LEXCNT,LEXCT,LEXD,LEXE,LEXED
 K LEXF,LEXFI,LEXGCS,LEXI,LEXID,LEXL,LEXLC,LEXLEN,LEXN,LEXNC
 K LEXNDS,LEXP,LEXPC,LEXPROC,LEXS,LEXSCHG,LEXT,LEXTI,LEXU
 K LEXUP,LEXVER,X,Y
 Q
EDT(LEX) ;   External Date
 S LEX=$$FMTE^XLFDT($G(LEX),"1Z") S:LEX["@" LEX=$P(LEX,"@",1)_"  "_$P(LEX,"@",2,299)
 Q LEX
TRIM(X) ;   Trim Spaces
 S X=$G(X) Q:X="" X F  Q:$E(X,1)'=" "  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,($L(X)-1))
 F  Q:X'["  "  S X=$P(X,"  ",1)_" "_$P(X,"  ",2,229)
 Q X

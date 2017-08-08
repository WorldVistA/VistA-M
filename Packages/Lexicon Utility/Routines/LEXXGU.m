LEXXGU ;ISL/KER - Global Uninstall (^LEXU) ;05/23/2017
 ;;2.0;LEXICON UTILITY;**103**;Sep 23, 1996;Build 2
 Q
 ;               
 ; Global Variables
 ;    ^%ZOSF("UCI")       ICR  10096
 ;    ^LEXU               N/A
 ;    ^TMP("LEXXGUM"      SACC 2.3.2.5.1
 ;               
 ; External References
 ;    HOME^%ZIS           ICR  10086
 ;    $$GET1^DIQ          ICR   2056
 ;    ^DIR                ICR  10026
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMDIFF^XLFDT      ICR  10103
 ;    $$FMTE^XLFDT        ICR  10103
 ;    $$NOW^XLFDT         ICR  10103
 ;    $$PATCH^XPDUTL      ICR  10141
 ;    $$VERSION^XPDUTL    ICR  10141
 ;    $$PROD^XUPROD       ICR   4440
 ;               
LEXU ; Uninstall a patch Installed by ^LEXM
 N LEXENV S LEXENV=$$ENV Q:'LEXENV  N LEXBEG,LEXBLD,LEXBOK,LEXCHK,LEXELP,LEXEND,LEXKIL,LEXL,LEXLN,LEXNDS,LEXPIE,LEXSUB,LEXT,LEXTMP,LEXTXT,LEXUNDO
 N LEXUOK,LEXVER,LEXVR K ^TMP("LEXXGUM",$J) W:$L($G(IOF)) @IOF S LEXBEG=$$NOW^XLFDT,LEXVR=$$VERSION^XPDUTL("LEX"),LEXBLD=$G(^LEXU(0,"BUILD"))
 I '$D(^LEXU)!($L(LEXBLD,"*")'=3)!($P(LEXBLD,"*",1)'="LEX")!($P(LEXBLD,"*",2)'=LEXVR)!($P(LEXBLD,"*",3)'?1N.N) D  Q
 . N LEXTXT,LEXLN S LEXTXT="Uninstall a Patch",$P(LEXLN,"=",$L(LEXTXT))="=" W !," ",LEXTXT,!," ",LEXLN
 . W !!,"   Undo-Global ^LEXU is missing or invalid.  Please obtain a copy ",!,"   of ^LEXU before continuing.",! Q
 S LEXTXT="Uninstall a Patch" S:$L(LEXBLD,"*")=3 LEXTXT="Uninstall Patch "_LEXBLD S $P(LEXLN,"=",$L(LEXTXT))="=" W !," ",LEXTXT,!," ",LEXLN
 S LEXBOK=$$BOK(LEXBLD) I +($G(LEXBOK))'>0!($L(LEXBLD,"*")'=3) D  Q
 . W !!,"   Undo-Global ^LEXU is invalid.  Please obtain a valid copy of ^LEXU",!,"   before continuing.",! Q
 S LEXUOK=$$CHK^LEXXGU2 I "^1^"'[("^"_LEXUOK_"^") W !!,"   Uninstall of patch ",LEXBLD," was aborted.  Undo-Global ^LEXU",!,"   was not deleted.",! Q
 S LEXKIL=$$KOK I "^1^0^"'[("^"_LEXKIL_"^") W !!,"   Uninstall of patch ",LEXBLD," was aborted.  Undo-Global ^LEXU",!,"   was not deleted.",! Q
 W !!," Running checksum routine on the Undo-Global ^LEXU, please wait"
 S LEXTXT="Uninstall Patch "_LEXBLD,LEXLN="" S $P(LEXLN,"-",$L(LEXTXT))="-" D MT(" "),MT((" "_LEXTXT)),MT((" "_LEXLN)),MT(" ")
 S LEXCHK=+($G(^LEXU(0,"CHECKSUM"))),LEXNDS=+($G(^LEXU(0,"NODES"))) S LEXVER=$$VC(LEXCHK,LEXNDS) W !
 I LEXVER>0 D
 . W !,"     Checksum is ok",! N LEXTMP,LEXTXT,LEXUNDO S LEXUNDO=0
 . S LEXTMP=$$FMTE^XLFDT($$NOW^XLFDT) S:LEXTMP["@" LEXTMP=$P(LEXTMP,"@",1)_"  "_$P(LEXTMP,"@",2) S LEXTXT="    As of:         "_LEXTMP D MT(LEXTXT)
 . S LEXTMP=$$UCI I $L(LEXTMP) S LEXTXT="    In Account:    "_LEXTMP D MT(LEXTXT)
 . S LEXTMP=$$P I $L(LEXTMP) S LEXTXT="    Maint by:      "_LEXTMP D MT(LEXTXT)
 . S LEXTXT="    Build:         "_$G(LEXBLD) D MT(LEXTXT)
 . S LEXTMP=$$FMTE^XLFDT($P($$INSD^LEXXGU2(LEXBLD),"^",1)) S:LEXTMP["@" LEXTMP=$P(LEXTMP,"@",1)_"  "_$P(LEXTMP,"@",2)
 . S LEXTXT="    Installed on:  "_LEXTMP D MT(LEXTXT)
 . S LEXTMP="Passed",LEXTMP=LEXTMP_$J(" ",(26-$L(LEXTMP)))_" "_LEXCHK
 . S LEXTXT="    Checksum:      "_LEXTMP D MT(LEXTXT)
 . D FILES^LEXXGU2,UNIN^LEXXGU2
 . I $G(LEXUNDO)>0 S LEXTXT="    Uninstall:     Complete" D MT(LEXTXT)
 . I $G(LEXUNDO)'>0 S LEXTXT="    Uninstall:     Incomplete" D MT(LEXTXT)
 . S LEXEND=$$NOW^XLFDT I $P($G(LEXBEG),".",1)?7N,$P($G(LEXEND),".",1)?7N D
 . . I $G(LEXBEG)=$G(LEXEND) H 1 S LEXEND=$$NOW^XLFDT
 . . S LEXELP=$$FMDIFF^XLFDT(LEXEND,LEXBEG,3) N LEXPIE S LEXPIE=$$TM($P(LEXELP,":",1))
 . . S:$L(LEXPIE)<2 LEXPIE="0"_LEXPIE S:$L(LEXPIE)<2 LEXPIE="0"_LEXPIE
 . . S $P(LEXELP,":",1)=LEXPIE
 . . S LEXTXT="    Start:         "_$TR($$FMTE^XLFDT(LEXBEG,"5Z"),"@"," ") D MT(" "),MT(LEXTXT) W !!," ",$$TM(LEXTXT)
 . . S LEXTXT="    Finished:      "_$TR($$FMTE^XLFDT(LEXEND,"5Z"),"@"," ") D MT(LEXTXT) W !," ",$$TM(LEXTXT)
 . . S LEXTXT="    Elapsed:       "_LEXELP D MT(LEXTXT),MT(" ") W !," ",$$TM(LEXTXT)
 . S LEXSUB=LEXBLD_" Uninstall" D MAIL^LEXXGU2
 I LEXVER=0 W !!,"   Undo-Global ^LEXU is missing.  Please obtain a copy of ^LEXU before",!,"   continuing." Q
 I LEXVER<0 D  Q
 . I LEXVER'=-3 W !,"   Unable to verify checksum for Undo-Global ^LEXU (possibly corrupt)"
 . I LEXVER=-3 W !,"   Undo-Global ^LEXU failed checksum"
 . W !!,"     Please KILL the existing Undo-Global ^LEXU from your system and"
 . W !,"     obtain a new copy of ^LEXU before continuing with the installation."
 D KILL
 Q
CHECKSUM ; Checksum for Undo-Global ^LEXU
 N LEXCHK,LEXNDS,LEXVER,LEXBLD,LEXBOK W !,"   Running checksum routine on the Undo-Global ^LEXU, please wait"
 I '$D(^LEXU) H 1 W !,"   Undo-Global ^LEXU is missing.  Please obtain a copy of ^LEXU before",!,"   continuing.",! Q
 S LEXBLD=$G(^LEXU(0,"BUILD")) I '$L(LEXBLD) H 1 W !,"   Undo-Global Build is missing.  Please obtain a copy of ^LEXU before",!,"   continuing.",! Q
 S LEXBOK=0 S:$L(LEXBLD) LEXBOK=$$BOK(LEXBLD) I +($G(LEXBOK))'>0 W "  Please obtain a valid ",!,"   copy of ^LEXU before continuing.",! Q
 S LEXCHK=+($G(^LEXU(0,"CHECKSUM"))),LEXNDS=+($G(^LEXU(0,"NODES"))),LEXVER=+($$VC(LEXCHK,LEXNDS)) W !
 W:LEXVER>0 !,"     Checksum is ok",! Q:LEXVER>0
 I LEXVER=0 H 1 W !,"   Undo-Global ^LEXU is missing.  Please obtain a copy of ^LEXU before",!,"   continuing.",! Q
 I LEXVER<0 D  Q
 . I LEXVER'=-3 W !,"   Unable to verify checksum for Undo-Global ^LEXU (possibly corrupt)",!
 . I LEXVER=-3 W !,"   Undo-Global ^LEXU failed checksum",!
 . W !!,"     Please KILL the existing Undo-Global ^LEXU from your system and"
 . W !,"     obtain a new copy of ^LEXU before continuing with the installation.",!
 Q
VC(X,Y) ; Verify Checksum for import global
 Q:'$D(^LEXU) 0  Q:'$D(^LEXU(0)) 0  Q:$O(^LEXU(0))'>0 0  N LEXCHK,LEXNDS,LEXCNT,LEXLC,LEXL,LEXS,LEXNC,LEXD,LEXN,LEXC,LEXGCS,LEXP,LEXT
 S LEXCHK=+($G(X)),LEXNDS=+($G(Y)) Q:LEXCHK'>0!(LEXNDS'>0) -2  S LEXL=64,(LEXCNT,LEXLC)=0,LEXS=(+(LEXNDS\LEXL))
 S:LEXS=0 LEXS=1 W:+($O(^LEXU(0)))>0 ! S (LEXC,LEXN)="^LEXU",(LEXNC,LEXGCS)=0 W "   "
 F  S LEXN=$Q(@LEXN) Q:LEXN=""!(LEXN'[LEXC)  D
 . Q:LEXN="^LEXU(0,""CHECKSUM"")"  Q:LEXN="^LEXU(0,""NODES"")"  S LEXCNT=LEXCNT+1
 . I LEXCNT'<LEXS S LEXLC=LEXLC+1 W:LEXLC'>LEXL "." S LEXCNT=0
 . S LEXNC=LEXNC+1,LEXD=@LEXN,LEXT=LEXN_"="_LEXD F LEXP=1:1:$L(LEXT) S LEXGCS=$A(LEXT,LEXP)*LEXP+LEXGCS
 Q:LEXNC'=LEXNDS -3  Q:LEXGCS'=LEXCHK -3
 Q 1
 ; 
 ; Miscellaneous
BOK(X) ;   Build is OK
 N LEXB,LEXBLD,LEXFI,LEXI,LEXOUT,LEXPKG,LEXR,LEXREV,LEXVER,LEXVR,LEXVRRV
 S LEXVR=$$VERSION^XPDUTL("LEX"),LEXOUT="" S LEXBLD=$G(X),LEXVER=$P(LEXBLD,"*",2)
 S LEXREV=$P(LEXBLD,"*",3),LEXPKG=$P(LEXBLD,"*",1) I LEXVER'=LEXVR D  Q
 . W !!,"   Invalid Undo-Global ^LEXU (wrong version, """_LEXVER_""")"
 I LEXPKG'="LEX" W !!,"   Invalid Undo-Global ^LEXU (wrong package, """_LEXPKG_""")" Q 0
 F LEXFI=757,757.001,757.01,757.02,757.03,757.1,757.21 D
 . N LEXVRRV,LEXB,LEXR,LEXI S LEXVRRV=$G(@("^DD("_+LEXFI_",0,""VRRV"")")),LEXR=$P(LEXVRRV,"^",1)
 . Q:+LEXR'>0  Q:+LEXR'>LEXOUT  S LEXB="LEX*"_LEXVER_"*"_LEXR,LEXI=$$PATCH^XPDUTL(LEXB)
 . Q:LEXI'>0  S LEXOUT=+LEXR
 I +LEXREV<+LEXOUT W !!,"   Invalid Undo-Global ^LEXU (old revision, """_+LEXREV_""")" Q 0
 I LEXREV'=LEXOUT W !!,"   Invalid Undo-Global ^LEXU (wrong revision, """_+LEXREV_""")" Q 0
 Q 1
UOK(X) ;   Uninstall is Ok for Build X
 N DIR,Y,DTOUT,DUOUT,DIRUT,DIROUT,LEXBLD S LEXBLD=$G(X)
 S:$L(LEXBLD) DIR("A")=" Uninstall patch "_LEXBLD_" (Y/N):  "
 S:'$L(LEXBLD) DIR("A")=" Uninstall patch (Y/N):  "
 S DIR("B")="NO",DIR(0)="YAO" W ! D ^DIR
 S X=+Y S:"^1^0^"'[("^"_Y_"^") X="^"
 Q X
KOK(X) ;   Kill Undo-Global ^LEXU Ok
 N DIR,Y,DTOUT,DUOUT,DIRUT,DIROUT,LEXBLD S LEXBLD=$G(X)
 S DIR("A")=" Kill Undo-Global ^LEXU when uninstall is complete (Y/N):  "
 S DIR("B")="NO",DIR(0)="YAO" W ! D ^DIR
 S X=+Y S:"^1^0^"'[("^"_Y_"^") X="^"
 Q X
MT(X) ;   Message Text
 N LEXI S LEXI=$O(^TMP("LEXXGUM",$J," "),-1)+1,^TMP("LEXXGUM",$J,LEXI)=$G(X)
 Q
KILL ;   Kill Undo-Global ^LEXU
 Q:+($G(LEXKIL))'>0  K ^LEXU(0) N LEXFI S LEXFI=0 F  S LEXFI=$O(^LEXU(LEXFI)) Q:+LEXFI'>0  K ^LEXU(LEXFI)
 Q
P(X) ;   Person
 N LEXDUZ,LEXF,LEXL,LEXNM,LEXP,LEXPH
 S LEXDUZ=+($G(DUZ)),LEXNM=$$GET1^DIQ(200,+($G(LEXDUZ)),.01) Q:'$L(LEXNM) "UNKNOWN^"
 S LEXDUZ=+($G(DUZ)) S LEXPH=$$GET1^DIQ(200,+($G(LEXDUZ)),.132)
 S:LEXPH="" LEXPH=$$GET1^DIQ(200,+($G(LEXDUZ)),.133)
 S:LEXPH="" LEXPH=$$GET1^DIQ(200,+($G(LEXDUZ)),.134)
 S:LEXPH="" LEXPH=$$GET1^DIQ(200,+($G(LEXDUZ)),.135)
 S LEXDUZ=$$PM(LEXNM)
 S X=LEXDUZ,X=X_$J(" ",(26-$L(X)))_" "_LEXPH
 Q X
PM(X) ;   Person, Mixed Case
 N LEXF,LEXL,LEXP S LEXP=$G(X),LEXL=$$MX($P(LEXP,",",1)),LEXF=$P(LEXP,",",2)
 S LEXL(1)=$$MX($P(LEXL,"-",1)),LEXL(2)=$$MX($P(LEXL(1)," ",2,2)),LEXL(1)=$$MX($P(LEXL(1)," ",1))
 S:$L(LEXL(1))&($L(LEXL(2))) LEXL(1)=LEXL(1)_" "_LEXL(2)
 S LEXL(3)=$$MX($P(LEXL,"-",2)),LEXL(4)=$$MX($P(LEXL(3)," ",2,2)),LEXL(3)=$$MX($P(LEXL(3)," ",1))
 S:$L(LEXL(3))&($L(LEXL(4))) LEXL(3)=LEXL(3)_" "_LEXL(4)
 S LEXL=LEXL(1) S:$L(LEXL(1))&($L(LEXL(3))) LEXL=LEXL(1)_"-"_LEXL(3)
 S LEXF=$$MX($P(LEXP,",",1)),LEXF=$P(LEXP,",",2)
 S LEXF(1)=$$MX($P(LEXF,"-",1)),LEXF(2)=$$MX($P(LEXF(1)," ",2,2)),LEXF(1)=$$MX($P(LEXF(1)," ",1))
 S:$L(LEXF(1))&($L(LEXF(2))) LEXF(1)=LEXF(1)_" "_LEXF(2)
 S LEXF(3)=$$MX($P(LEXF,"-",2)),LEXF(4)=$$MX($P(LEXF(3)," ",2,2)),LEXF(3)=$$MX($P(LEXF(3)," ",1))
 S:$L(LEXF(3))&($L(LEXF(4))) LEXF(3)=LEXF(3)_" "_LEXF(4)
 S LEXF=LEXF(1) S:$L(LEXF(1))&($L(LEXF(3))) LEXF=LEXF(1)_"-"_LEXF(3)
 S LEXP=LEXL_", "_LEXF,X=LEXP
 Q X
MX(X) ;   Mix Case
 Q $TR($E(X,1),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")_$TR($E(X,2,$L(X)),"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
UCI(X) ;   UCI where Lexicon is installed
 N LEXP,LEXT,LEXU,Y X ^%ZOSF("UCI") S LEXU=Y,LEXP=""
 S LEXP=$S($$PROD^XUPROD(1):"Production",1:"Test Account")
 S:LEXU[","&($L($P(LEXU,",",1))>3) LEXU=$P(LEXU,",",1)
 S X=LEXU I $L(LEXP) S X=X_$J(" ",(26-$L(X)))_" "_LEXP
 Q X
TM(X,Y) ;   Trim Character Y - Default " "
 S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
SH ;   Show Text
 W ! N LEXNN,LEXNC S LEXNN="^TMP(""LEXXGUM"","_$J_")",LEXNC="^TMP(""LEXXGUM"","_$J_","
 F  S LEXNN=$Q(@LEXNN) Q:'$L(LEXNN)!(LEXNN'[LEXNC)  W !,@LEXNN
 W ! Q
ENV(X) ;   Environment
 D HOME^%ZIS S U="^",DT=$$DT^XLFDT,DTIME=300 K POP
 N LEXNM S LEXNM=$$GET1^DIQ(200,(DUZ_","),.01)
 I '$L($G(LEXNM)) W !!,?5,"Invalid/Missing DUZ" Q 0
 S:$G(DUZ(0))'["@" DUZ(0)=$G(DUZ(0))_"@"
 Q 1

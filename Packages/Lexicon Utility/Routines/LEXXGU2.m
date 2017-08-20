LEXXGU2 ;ISL/KER - Global Uninstall (^LEXU) ;05/23/2017
 ;;2.0;LEXICON UTILITY;**103**;Sep 23, 1996;Build 2
 ;               
 ; Global Variables
 ;    ^LEXU               N/A
 ;    ^TMP("LEXXGUM")     SACC 2.3.2.5.1
 ;               
 ; External References
 ;    $$S^%ZTLOAD         ICR  10063
 ;    ^DIC                ICR  10006
 ;    FIND^DIC            ICR   2051
 ;    ^DIK                ICR  10013
 ;    $$IENS^DILF         ICR   2054
 ;    $$GET1^DIQ          ICR   2056
 ;    ^DIR                ICR  10026
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMTE^XLFDT        ICR  10103
 ;    ^XMD                ICR  10070
 ;    $$PKG^XPDUTL        ICR  10141
 ;    $$VERSION^XPDUTL    ICR  10141
 ;    $$VER^XPDUTL        ICR  10141
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;     LEXUNDO            NEWed in LEXXGU
 ;  
FILES ;   Load Data for all files
 S:'$L($G(LEXB)) LEXB=$G(LEXBLD) S:'$L($G(LEXB)) LEXB=$G(^LEXU(0,"BUILD")) Q:'$L($G(LEXB))
 N LEXHDR,LEXBLD,LEXDAT,LEXFI,LEXFIC,LEXINS,LEXTOTI,LEXTOTN,LEXPER,LEXPRE,LEXOK
 S (LEXFI,LEXFIC,LEXHDR,LEXTOTI,LEXTOTN,LEXPER,LEXPRE)=0,LEXBLD=LEXB,LEXOK=1
 S LEXDAT=$P($G(^LEXU(0,"VRRVDT")),"^",1),LEXINS=1
 S:+LEXDAT'>0 LEXDAT=$$DT^XLFDT I LEXOK D
 . N LEXCRE,LEXL1 S LEXL1="" S LEXCRE=$G(^LEXU(0,"CREATED")) S LEXCRE=$S(+LEXCRE>0:($$MIX($$FMTE^XLFDT(LEXCRE))),1:"")
 . S:$L($P(LEXCRE,"@",2)) LEXCRE=$P(LEXCRE,"@",1)_" at "_$P(LEXCRE,"@",2) S LEXL1=" Uninstalling data "
 . S:$L($G(LEXCRE))&($L($G(LEXL1))) LEXL1=$G(LEXL1)_"using Undo-Global ^LEXU created "_$G(LEXCRE)
 . D PB(LEXL1)
 S LEXFI=0 F  S LEXFI=$O(^LEXU(LEXFI)) Q:+LEXFI=0  S LEXTOTN=+($G(LEXTOTN))+($O(^LEXU(LEXFI," "),-1))
 S LEXFI=0 F  S LEXFI=$O(^LEXU(LEXFI)) Q:+LEXFI=0  D FILE
 Q
FILE ;     Load Data for one file
 N LEXCHG,LEXCNT,LEXFIL,LEXFIR,LEXI,LEXL,LEXLC
 N LEXMUMPS,LEXNM,LEXRT,LEXS,LEXTOT,LEXTXT
 S LEXFIR=$O(^LEXU(($P(LEXFI,".",1)-.000001)))
 S (LEXCNT,LEXLC,LEXI)=0,LEXL=68,LEXFIC=LEXFIC+1 I LEXOK D
 . N LEXB,LEXFID,LEXNM,LEXVR,LEXRV,LEXDT,LEXL1 S LEXL1="",LEXFID=$P(LEXFI,".",1) Q:+LEXFID'>0
 . S:LEXFID=80 LEXNM="ICD Files" S:LEXFID=81 LEXNM="CPT-4/HCPCS" S:LEXFID=757 LEXNM="Lexicon" S LEXB=$G(^LEXU(LEXFI,0,"BUILD"))
 . S LEXVR=$G(^LEXU(LEXFI,0,"VR")),LEXRV=$G(^LEXU(LEXFI,0,"VRRV")),LEXDT=$$MIX($$FMTE^XLFDT($P(LEXRV,"^",2))),LEXRV=$P(LEXRV,"^",1)
 . Q:'$L(LEXNM)  S LEXL1="Uninstalling data for "_LEXNM S LEXL1=" "_LEXL1 D:LEXFI=LEXFIR BL,TL(LEXL1) D:$G(LEXNM)'["ICD F" BL
 S LEXTOT=+($G(^LEXU(LEXFI,0))) G:LEXTOT=0 FILEQ
 S LEXNM=$G(^LEXU(LEXFI,0,"NM"))
 I $L(LEXNM),$$UP(LEXNM)'["FILE" S LEXNM=LEXNM_" FILE"
 S:$L(LEXNM) LEXNM=$$MIX(LEXNM) S LEXCHG=$G(^LEXU(LEXFI,0))
 S LEXTXT="   "_LEXNM,LEXTXT=LEXTXT_$J("",(40-$L(LEXTXT)))_LEXFI
 D:LEXFIC=1 PB(LEXTXT) D:LEXFIC'=1 TL(LEXTXT)
 S LEXS=+(LEXTOT\LEXL) S:LEXS=0 LEXS=1 W:+($O(^LEXU(LEXFI,0)))>0 !,"   "
 F  S LEXI=$O(^LEXU(LEXFI,LEXI)) Q:+LEXI=0  D
 . S LEXCNT=LEXCNT+1,LEXMUMPS=$G(^LEXU(LEXFI,LEXI))
 . I LEXCNT'<LEXS S LEXLC=LEXLC+1 W:LEXLC'>LEXL "." S LEXCNT=0
 . S LEXRT=$P(LEXMUMPS,"^",2),LEXFIL=""
 . S:LEXMUMPS["^LEX("!(LEXMUMPS["^LEXT(")!(LEXMUMPS["^LEXC(") LEXFIL=+($P(LEXRT,"(",2))
 . S:LEXMUMPS["^ICD9(" LEXFIL=80 S:LEXMUMPS["^ICD0(" LEXFIL=80.1 S:LEXMUMPS["^ICPT(" LEXFIL=81
 . S:LEXMUMPS["^DIC(81.1" LEXFIL=81.1 S:LEXMUMPS["^DIC(81.2" LEXFIL=81.2 S:LEXMUMPS["^DIC(81.3" LEXFIL=81.3
 . I $L(LEXMUMPS) D
 . . X LEXMUMPS S LEXUNDO=1,LEXTOTI=+($G(LEXTOTI))+1 I +($G(LEXTOTN))>0,+($G(LEXTOTI))>0,$D(ZTQUEUED),+($G(ZTSK))>0 D
 . . . N LEXT,LEXTSK S (LEXT,LEXPER)=(+($G(LEXTOTI))/+($G(LEXTOTN)))*100 Q:+LEXPER-(+($G(LEXPRE)))'>2  S LEXPRE=+($G(LEXPER))
 . . . S LEXPER=$J(LEXPER,6,2) I +LEXT>0 S LEXPER=LEXPER_"% complete" S LEXTSK=$$S^%ZTLOAD(LEXPER)
 . . . N ZTQUEUED,ZTSK
FILEQ ;     Load Data for one file - QUIT
 Q
 ; 
CHK(X) ; Check Versions
 N DIR,Y,DTOUT,DUOUT,DIRUT,DIROUT,CHK,AFT,PRE,AEF,PEF,REV,BLD K CHK D REVS(.CHK) S BLD=$P($G(CHK("LEXU",1)),"^",1)
 I +($G(CHK("LEXU")))'>0 W !!,"   Undo-Global ^LEXU Build not found",! Q 0
 I +($G(CHK("LEXU")))'=+($G(CHK("LEX"))) W !!,"   Undo-Global ^LEXU Build is invalid",! Q 0
 I '$D(CHK("LEX"))&('$D(CHK("CPT")))&('$D(CHK("ICD"))) W !!,"   Current/Past Builds not found",! Q 0
 S AFT=$P($G(CHK("LEX")),"^",1),PRE=$P($G(CHK("LEX")),"^",3)
 I AFT'>0!(PRE'>0)!(AFT'>PRE) D  Q 0
 . W !!,"   Current/Past Builds are invalid",!
 S REV=$G(CHK("LEX",1)),AFT=$P(REV,"^",1),AEF=$P(REV,"^",2),PRE=$P(REV,"^",3),PEF=$P(REV,"^",4)
 I '$L(REV)!('$L(AFT))!('$L(AEF))!('$L(PRE))!('$L(PEF)) W !!,"   Primary Build not found",! Q 0
 I $D(TEST) W !!," Uninstall" W:$L($G(BLD)) " Patch ",BLD W ":"
 W !!,"   Uninstall Build",?36,"Revert to"
 W !,"   --------------------------",?36,"--------------------------"
 W !,"   ",AFT,?17,AEF,?36,PRE,?50,PEF
 S REV=$G(CHK("ICD",1)),AFT=$P(REV,"^",1),AEF=$P(REV,"^",2),PRE=$P(REV,"^",3),PEF=$P(REV,"^",4)
 I $L(AFT),$L(AEF),$L(PRE),$L(PEF) W !,"   ",AFT,?17,AEF,?36,PRE,?50,PEF
 S REV=$G(CHK("CPT",1)),AFT=$P(REV,"^",1),AEF=$P(REV,"^",2),PRE=$P(REV,"^",3),PEF=$P(REV,"^",4)
 I $L(AFT),$L(AEF),$L(PRE),$L(PEF) W !,"   ",AFT,?17,AEF,?36,PRE,?50,PEF
 S:$L(BLD) DIR("A")=" Uninstall patch "_BLD_" (Y/N):  " S:'$L(BLD) DIR("A")=" Uninstall patch (Y/N):  "
 S DIR("B")="NO",DIR(0)="YAO" W ! D ^DIR S X=+Y S:"^1^0^"'[("^"_Y_"^") X="^" N TEST
 Q X
 ; 
 ; Miscellaneous
MAIL ;   Mail Message
 Q:'$D(^TMP("LEXXGUM",$J))  Q:'$L($G(LEXSUB))  N XCNP,XMSCR,XMDUZ,XMY,XMZ,XMSUB,XMTEXT,XMDUZ,LEXJ,LEXNM
 S XMTEXT="^TMP(""LEXXGUM"","_$J_",",XMSUB=$G(LEXSUB),LEXNM=$$GET1^DIQ(200,+($G(DUZ)),.01) S XMY(("G.LEXINS@"_$$XMA))=""
 S XMY(LEXNM)="",XMDUZ=.5 D ^XMD I '$D(ZTQUEUED),+($G(XMZ))>0 D
 . W !!," ",LEXSUB," Message #",($G(XMZ))," sent"
XMSQ ;   Send Message (Quit)
 K ^TMP("LEXXGUM",$J),LEXNM,LEXSUB
 Q
REVS(ARY) ;  Revisions
 N FI,EFF,AFT,PRE,REV,VER K ARY S REV=$P($G(^LEXU(0,"BUILD")),"*",3)
 I $L(REV) D
 . N EFF S ARY("LEXU")=REV,VER=$$VERSION^XPDUTL("LEX") I $L($G(ARY("LEXU")))&(+VER>0) D
 . S ARY("LEXU","1")="LEX*"_VER_"*"_REV S EFF=$P($G(^LEXU(0,"VRRVDT")),"^",1)
 . S:EFF?7N $P(ARY("LEXU","1"),"^",2)=EFF
  F FI=80,80.1 D
 . Q:'$D(^LEXU(FI))  N IEN,AFT,PRE S AFT=$G(^LEXU(FI,0,"VRRV")),IEN=$O(^LEXU(FI," "),-1)
 . S PRE=$TR($P($G(^LEXU(FI,IEN)),"=",2),"""","")
 . I +AFT>0,+PRE>0,+AFT>++PRE,+($P(AFT,"^",2))?7N D
 . . S ARY("ICD",+($P(AFT,"^",2)),+AFT,+PRE)=AFT_"^"_PRE
 S EFF=$O(ARY("ICD"," "),-1),AFT=$O(ARY("ICD",+EFF," "),-1),PRE=$O(ARY("ICD",+EFF,+AFT," "),-1)
 S REV=$G(ARY("ICD",+EFF,+AFT,+PRE)) K ARY("ICD") I $L(REV) D
 . S ARY("ICD")=REV,VER=$$VERSION^XPDUTL("ICD") I $L($G(ARY("ICD")))&(+VER>0) D
 . . S AFT="ICD*"_VER_"*"_+($P($G(ARY("ICD")),"^",1))_"^"_$S($P($G(ARY("ICD")),"^",2)?7N:$$FMTE^XLFDT($P($G(ARY("ICD")),"^",2)),1:"")
 . . S PRE="ICD*"_VER_"*"_+($P($G(ARY("ICD")),"^",3))_"^"_$S($P($G(ARY("ICD")),"^",4)?7N:$$FMTE^XLFDT($P($G(ARY("ICD")),"^",4)),1:"")
 . . S ARY("ICD","1")=AFT_"^"_PRE
 F FI=81,81.1,81.2,81.3 D
 . Q:'$D(^LEXU(FI))  N IEN,AFT,PRE S AFT=$G(^LEXU(FI,0,"VRRV")),IEN=$O(^LEXU(FI," "),-1)
 . S PRE=$TR($P($G(^LEXU(FI,IEN)),"=",2),"""","")
 . I +AFT>0,+PRE>0,+AFT>++PRE,+($P(AFT,"^",2))?7N D
 . . S ARY("CPT",+($P(AFT,"^",2)),+AFT,+PRE)=AFT_"^"_PRE
 S EFF=$O(ARY("CPT"," "),-1),AFT=$O(ARY("CPT",+EFF," "),-1),PRE=$O(ARY("CPT",+EFF,+AFT," "),-1)
 S REV=$G(ARY("CPT",+EFF,+AFT,+PRE)) K ARY("CPT") I $L(REV) D
 . S ARY("CPT")=REV,VER=$$VERSION^XPDUTL("ICPT") I $L($G(ARY("CPT")))&(+VER>0) D
 . . S AFT="ICPT*"_VER_"*"_+($P($G(ARY("CPT")),"^",1))_"^"_$S($P($G(ARY("CPT")),"^",2)?7N:$$FMTE^XLFDT($P($G(ARY("CPT")),"^",2)),1:"")
 . . S PRE="ICPT*"_VER_"*"_+($P($G(ARY("CPT")),"^",3))_"^"_$S($P($G(ARY("CPT")),"^",4)?7N:$$FMTE^XLFDT($P($G(ARY("CPT")),"^",4)),1:"")
 . . S ARY("CPT","1")=AFT_"^"_PRE
 S FI=756.9999 F  S FI=$O(@("^DIC("_+FI_")")) Q:+FI'>0!($P(FI,".",1)'=757)!(FI>757.41)  D
 . Q:'$D(^LEXU(FI))  N IEN,AFT,PRE S AFT=$G(^LEXU(FI,0,"VRRV")),IEN=$O(^LEXU(FI," "),-1)
 . S PRE=$TR($P($G(^LEXU(FI,IEN)),"=",2),"""","") I +AFT>0,+PRE>0,+AFT>++PRE,+($P(AFT,"^",2))?7N D
 . . S ARY("LEX",+($P(AFT,"^",2)),+AFT,+PRE)=AFT_"^"_PRE
 S EFF=$O(ARY("LEX"," "),-1),AFT=$O(ARY("LEX",+EFF," "),-1),PRE=$O(ARY("LEX",+EFF,+AFT," "),-1)
 S REV=$G(ARY("LEX",+EFF,+AFT,+PRE)) K ARY("LEX") I $L(REV) D
 . S ARY("LEX")=REV,VER=$$VERSION^XPDUTL("LEX") I $L($G(ARY("LEX")))&(+VER>0) D
 . . S AFT="LEX*"_VER_"*"_+($P($G(ARY("LEX")),"^",1))_"^"_$S($P($G(ARY("LEX")),"^",2)?7N:$$FMTE^XLFDT($P($G(ARY("LEX")),"^",2)),1:"")
 . . S PRE="LEX*"_VER_"*"_+($P($G(ARY("LEX")),"^",3))_"^"_$S($P($G(ARY("LEX")),"^",4)?7N:$$FMTE^XLFDT($P($G(ARY("LEX")),"^",4)),1:"")
 . . S ARY("LEX","1")=AFT_"^"_PRE
 Q
 ; 
XMA(LEX) ;   Message Address
 N DIC,DTOUT,DUOUT,X,Y S DIC="^DIC(4.2,",DIC(0)="M",(LEX,X)="DOMAIN.EXT" D ^DIC Q:+Y>0 LEX
 S DIC="^DIC(4.2,",DIC(0)="M",(LEX,X)="ISC-SLC.DOMAIN.EXT" D ^DIC Q:+Y>0 LEX
 Q "ISC-SLC.DOMAIN.EXT"
BL ;   Blank Line
 W !
 Q
PB(X) ;   Preceeding Blank Line
 S X=$G(X) Q:'$L(X)  W !!,X
 Q
TL(X) ;   Text Line
 W !,$G(X)
 Q
UNIN ; Uninstall from Package
 N LEXREVS,LEXSAB K LEXREVS D REVS^LEXXGU2(.LEXREVS) F LEXSAB="ICD","CPT","LEX" D
 . N DA,DIK,LEXBLD,LEXDA,LEXMSG,LEXND,LEXNS,LEXOUT,LEXPI,LEXPN,LEXRI,LEXRV,LEXSCR,LEXVD,LEXVI,LEXVR
 . S LEXBLD=$P($G(LEXREVS(LEXSAB,1)),"^",1),LEXNS=$$PKG^XPDUTL(LEXBLD) Q:$L(LEXNS)<2!($L(LEXNS)>4)
 . S LEXVR=$$VER^XPDUTL(LEXBLD) Q:+LEXVR'>0  S (LEXPN,LEXRV)=$P(LEXBLD,"*",3) Q:LEXPN'>0
 . S LEXSCR="I $G(^DIC(9.4,+($G(Y)),""VERSION""))="""_LEXVR_""""
 . D FIND^DIC(9.4,,.01,"O",LEXNS,10,"C",LEXSCR,,"LEXOUT","LEXMSG")
 . S LEXPI=$G(LEXOUT("DILIST",2,1)) K LEXOUT,LEXMSG Q:+LEXPI'>0  Q:'$D(@("^DIC(9.4,"_LEXPI_",22)"))
 . K DA S DA(1)=LEXPI S LEXDA=$$IENS^DILF(.DA) D FIND^DIC(9.49,LEXDA,".01;1I;2I","O",LEXVR,10,"B",,,"LEXOUT","LEXMSG")
 . S LEXVI=$G(LEXOUT("DILIST",2,1)) K LEXOUT,LEXMSG Q:+LEXVI'>0  Q:'$D(@("^DIC(9.4,"_LEXPI_",22,"_LEXVI_",""PAH"")"))
 . K DA S DA(2)=LEXPI,DA(1)=LEXVI S LEXDA=$$IENS^DILF(.DA) S LEXSCR="I $G(^DIC(9.4,"_LEXPI_",22,"_LEXVI_",""PAH"",+($G(Y)),0))[""SEQ #"""
 . D FIND^DIC(9.4901,LEXDA,".01;.02I",,LEXPN,10,"B",LEXSCR,,"LEXOUT","LEXMSG")
 . S LEXRI=$G(LEXOUT("DILIST",2,1)) I +LEXRI'>0 S LEXSCR="" D
 . . D FIND^DIC(9.4901,LEXDA,".01;.02I",,LEXPN,10,"B",LEXSCR,,"LEXOUT","LEXMSG") S LEXRI=$G(LEXOUT("DILIST",2,1))
 . Q:+LEXRI'>0  S LEXND="^DIC(9.4,"_+LEXPI_",22,"_+LEXVI_",""PAH"","_+LEXRI_",0)"
 . K DA S DIK="^DIC(9.4,"_+LEXPI_",22,"_+LEXVI_",""PAH"",",DA(2)=LEXPI,DA(1)=LEXVI,DA=LEXRI
 . D:$D(@LEXND) ^DIK
 Q
INSD(X)  ;   Installed on
 N DA,LEX,LEXDA,LEXE,LEXI,LEXMSG,LEXNS,LEXOUT,LEXPI,LEXPN,LEXSCR,LEXVI,LEXVD,LEXVI,LEXVR S LEX=$G(X)
 S LEXNS=$$PKG^XPDUTL(LEX),LEXVR=$$VER^XPDUTL(LEX),LEXPN=$P(X,"*",3)
 Q:'$L(LEXNS) ""  S LEXVR=+LEXVR Q:LEXVR'>0 ""  S LEXPN=+LEXPN S:LEXVR'["." LEXVR=LEXVR_".0"
 S LEXSCR="I $G(^DIC(9.4,+($G(Y)),""VERSION""))="""_LEXVR_""""
 D FIND^DIC(9.4,,.01,"O",LEXNS,10,"C",LEXSCR,,"LEXOUT","LEXMSG")
 S LEXPI=$G(LEXOUT("DILIST",2,1)) K LEXOUT,LEXMSG Q:+LEXPI'>0 ""  Q:'$D(@("^DIC(9.4,"_LEXPI_",22)")) ""
 K DA S DA(1)=LEXPI S LEXDA=$$IENS^DILF(.DA)
 D FIND^DIC(9.49,LEXDA,".01;1I;2I","O",LEXVR,10,"B",,,"LEXOUT","LEXMSG")
 S LEXVD=$G(LEXOUT("DILIST","ID",1,2)) I $E(LEXVD,1,7)?7N&(+LEXPN'>0) D  Q X
 . S X=$E(LEXVD,1,7)_"^"_$TR($$FMTE^XLFDT($E(LEXVD,1,7),"5DZ"),"@"," ")
 S:$E(LEXVD,1,7)'?7N LEXVD=$G(LEXOUT("DILIST","ID",1,1)) I $E(LEXVD,1,7)?7N&(+LEXPN'>0) D  Q X
 . S X=$E(LEXVD,1,7)_"^"_$TR($$FMTE^XLFDT($E(LEXVD,1,7),"5DZ"),"@"," ")
 Q:+LEXPN'>0 ""  S LEXVI=$G(LEXOUT("DILIST",2,1)) K LEXOUT,LEXMSG
 Q:+LEXVI'>0 ""  Q:'$D(@("^DIC(9.4,"_LEXPI_",22,"_LEXVI_",""PAH"")")) ""
 K DA S DA(2)=LEXPI,DA(1)=LEXVI S LEXDA=$$IENS^DILF(.DA)
 S LEXSCR="I $G(^DIC(9.4,"_LEXPI_",22,"_LEXVI_",""PAH"",+($G(Y)),0))[""SEQ #"""
 D FIND^DIC(9.4901,LEXDA,".01;.02I",,LEXPN,10,"B",LEXSCR,,"LEXOUT","LEXMSG")
 S LEXI=$G(LEXOUT("DILIST","ID",1,.02)) I '$L(LEXI) D
 . S LEXSCR="" D FIND^DIC(9.4901,LEXDA,".01;.02I",,LEXPN,10,"B",LEXSCR,,"LEXOUT","LEXMSG")
 . S LEXI=$G(LEXOUT("DILIST","ID",1,.02))
 Q:'$L(LEXI) ""  Q:$P(LEXI,".",1)'?7N ""  S LEXE=$TR($$FMTE^XLFDT(LEXI,"5DZ"),"@"," ")
 Q:'$L(LEXE) ""  S X=LEXI_"^"_LEXE
 Q X
MIX(X) ;   Mixed Case
 S X=$G(X) N LEXT,LEXI S LEXT=""
 F LEXI=1:1:$L(X," ") S LEXT=LEXT_" "_$$UP($E($P(X," ",LEXI),1))_$$LO($E($P(X," ",LEXI),2,$L($P(X," ",LEXI))))
 F  Q:$E(LEXT,1)'=" "  S LEXT=$E(LEXT,2,$L(LEXT))
 S:$E(LEXT,1,3)="Cpt" LEXT="CPT"_$E(LEXT,4,$L(LEXT)) S:$E(LEXT,1,3)="Icd" LEXT="ICD"_$E(LEXT,4,$L(LEXT)) S X=LEXT
 Q X
UP(X) ;   Uppercase
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
LO(X) ;   Lowercase
 Q $TR(X,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
TM(X,Y) ;   Trim Character Y - Default " "
 S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X

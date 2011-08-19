LEXXFI8 ; ISL/KER - File Info - Miscellaneous      ; 07/28/2004
 ;;2.0;LEXICON UTILITY;**32**;Sep 23, 1996
 Q
 ;                    
 ; Global Variables
 ;   ^TMP("LEXCS",$J     SACC 2.3.2.5.1
 ;   ^TMP("LEXINS",$J    SACC 2.3.2.5.1
 ;                      
 ; External References
 ;   DBIA 10003  ^%DT
 ;   DBIA 10022  %XY^%RCR
 ;   DBIA 10006  ^DIC (file 4.2 and 9.4)
 ;   DBIA 10006  IX^DIC
 ;   DBIA  2052  FILE^DID
 ;   DBIA  2056  $$GET1^DIQ (file 81.2)
 ;   DBIA 10103  $$FMTE^XLFDT
 ;                          
LEX(X) ; LEX* File
 N LEXN S X=$G(X) Q:+X=0 0  S LEXN=$$GL(X) Q:$E(LEXN,1,4)="^LEX" 1
 Q 0
IC(X) ; IC* File
 S X=$G(X) I "^80^80.1^80.2^80.3^81^81.1^81.3^"[("^"_+X_"^") Q 1
 Q 0
GL(X) ; Global Location
 N DIERR,LEXE,LEXN S X=$G(X) Q:+X=0 ""  D FILE^DID(+X,"N","GLOBAL NAME","LEXN","LEXE")
 S X="" S:'$D(DIERR) X=$G(LEXN("GLOBAL NAME"))
 Q X
FN(X) ; File Name
 N DIERR,LEXE,LEXN S X=$G(X) D FILE^DID(+X,"N","NAME","LEXN","LEXE")
 S X="" S:'$D(DIERR) X=$G(LEXN("NAME"))
 Q X
INS(X) ; Installed
 N %X,%Y,LEXFI,LEXIN,LEXPH,LEXPK,LEXPV,LEXRV,LEXSQ,LEXVR K ^TMP("LEXINS",$J)
 S LEXFI=+($G(X)) Q:+LEXFI'>0 ""
 S LEXVR=$P($$VR(LEXFI),"^",1) Q:'$L(LEXVR) ""  Q:+LEXVR'>0 ""
 S LEXRV=$P($$RV(LEXFI),"^",1) Q:'$L(LEXRV) ""  Q:+LEXRV'>0 ""
 S LEXPK=$$PKG(LEXFI) Q:'$L(LEXPK) ""  Q:+LEXPK'>0 ""
 S LEXPV=$$PH(LEXPK,LEXVR) Q:+LEXPV'>0 ""
 S %X="^DIC(9.4,"_LEXPK_",22,"_LEXPV_",""PAH"",",%Y="^TMP(""LEXINS"","_$J_",""PAH""," D %XY^%RCR
 S LEXPH=$O(^TMP("LEXINS",$J,"PAH","B",LEXRV,0)) I LEXPH'>0 D
 . S LEXPH="",LEXSQ=$O(^TMP("LEXINS",$J,"PAH","B",(LEXRV_" ")))
 . Q:'$L(LEXSQ)  Q:$E(LEXSQ,1,$L(LEXRV))'=LEXRV
 . S LEXPH=$O(^TMP("LEXINS",$J,"PAH","B",LEXSQ,0))
 S LEXIN=$P($P($G(^TMP("LEXINS",$J,"PAH",+LEXPH,0)),"^",2),".",1)
 S X=$S(+LEXIN>0:$$SD(+LEXIN),1:"") S:$L(X)'=10 X=""
 K ^TMP("LEXINS",$J)
 Q X
VR(X) ; File Version
 N DIERR,LEXCDT,LEXE,LEXEX,LEXFI,LEXL,LEXN,LEXRTN,LEXVR,LEXVRD
 S LEXFI=$G(X) N DIERR,LEXN,LEXNM,LEXE,LEXEX,LEXL,LEXRTN
 D FILE^DID(+LEXFI,"N","VERSION","LEXN","LEXE") S LEXVR="" I '$D(DIERR) D
 . S LEXVR=$G(LEXN("VERSION")) S LEXRTN=$S($P(+LEXFI,".",1)=757:"LEXA",$P(+LEXFI,".",1)=80:"ICDCODE",$P(+LEXFI,".",1)=81:"ICPTCOD",1:"")
 . Q:'$L(LEXRTN)  S LEXEX="S LEXL=$T(+2^"_LEXRTN_")" X LEXEX
 . Q:'$L(LEXL)  I $P(LEXL,";",3)=LEXVR,$L($P(LEXL,";",6)) S LEXVRD=$$LTS($P(LEXL,";",6))
 S LEXCDT="" S:LEXFI=81.2 LEXCDT=$$DDT
 S X=$G(LEXVR) S:$L($G(LEXVR))&($L($G(LEXVRD))) X=X_"^"_$G(LEXVRD)
 S:$L($G(LEXVR))&($L($G(LEXVRD)))&($L(LEXCDT)) X=X_"^"_$G(LEXCDT)
 Q X
RV(X) ; File Revision
 N DIERR,LEXE,LEXN S X=$G(X)
 D FILE^DID(+X,"N","PACKAGE REVISION DATA","LEXN","LEXE")
 S X="" S:'$D(DIERR) X=$G(LEXN("PACKAGE REVISION DATA"))
 S:+$P(X,"^",2) $P(X,"^",2)=$$SD($P(X,"^",2))
 Q X
DDT(X) ; CPT Distribution Date
 N LEXDDT S LEXDDT=$$GET1^DIQ(81.2,"1,",.02,"I") Q:'$L(LEXDDT) ""  Q:+LEXDDT'>0 ""  S X=$$SD(LEXDDT)
 Q X
ADR(LEX) ; Mailing Address
 N DIC,DTOUT,DUOUT,X,Y S DIC="^DIC(4.2,",DIC(0)="M",(LEX,X)="FO-SLC.MED.VA.GOV" D ^DIC Q:+Y>0 LEX
 S DIC="^DIC(4.2,",DIC(0)="M",(LEX,X)="ISC-SLC.MED.VA.GOV" D ^DIC Q:+Y>0 LEX
 Q "ISC-SLC.VA.GOV"
MX(X) ; Mix Case
 Q $TR($E(X,1),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")_$TR($E(X,2,$L(X)),"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
LTS(X) ; Long to Short Date
 N %DT,Y S X=$G(X) Q:'$L(X) ""  S %DT="T" D ^%DT S X=$$SD(Y)
 Q X
SD(X) ; Short Date
 S X=$G(X),X=$TR($$FMTE^XLFDT($P(X,".",1),"5DZ"),"@"," ")
 Q X
PKG(X) ; Package
 N D,DIC,DTOUT,DUOUT,LEXFI,LEXN S LEXFI=+($G(X)) Q:+LEXFI'>0 ""
 S LEXN=$S($P(LEXFI,".",1)=757:"LEXICON UTILITY",$P(LEXFI,".",1)=80:"DRG GROUPER",$P(LEXFI,".",1)=81:"CPT/HCPCS CODES",1:"")
 Q:'$L(LEXN)  N X,Y S DIC="^DIC(9.4,",D="B",DIC(0)="X",X=LEXN D IX^DIC
 S X=+($G(Y))
 Q X
PH(X,Y) ; Patch History
 N DA,DIC,DTOUT,DUOUT,LEXPK,LEXVR
 S (DA(1),LEXPK)=+($G(X)) Q:+LEXPK'>0 ""  S LEXVR=$G(Y) Q:'$L(LEXVR) ""  Q:+LEXVR'>0 ""
 S DIC="^DIC(9.4,"_DA(1)_",22,",X=LEXVR,DIC(0)="X"
 D ^DIC S X=+($G(Y)) S:+Y'>0 X=""
 Q X
TIC(X) ; Time
 Q $$NOW^XLFDT
ELAP(X,Y) ; Elapsed Time (start,end)
 Q $TR($$FMDIFF^XLFDT(+($G(Y)),+($G(X)),3)," ","0")
LDR(X) ; Leader
 N LEXFI,LEXMOD S LEXFI=+($G(X)) Q:LEXFI'>0 0  S LEXMOD=$$MOD(LEXFI),X=$S(+LEXMOD>0:" * ",1:"   ")
 Q X
MOD(X) ; Modifier File
 N LEXFI,LEXSRC,LEXE,LEXTAG,LEXRTN,LEXCTR,LEXLDR,LEXMOD
 S LEXSRC=+($G(X)) Q:LEXSRC'>0 0
 S LEXFI="",LEXE=0,LEXTAG="FILES",LEXRTN="LEXXFI",LEXCTR=0,LEXMOD=0
 F  D  Q:LEXFI=""  Q:+LEXE>0
 . S LEXCTR=LEXCTR+1
 . S LEXEX="S LEXLINE=$T("_LEXTAG_"+"_LEXCTR_"^"_LEXRTN_")" X LEXEX
 . S LEXFI=$P(LEXLINE,";;",2,3)
 . S LEXLDR=$P(LEXFI,";;",1),LEXFI=$P(LEXFI,";;",2)
 . Q:'$L(LEXFI)  Q:+LEXFI'=LEXSRC
 . S LEXMOD=$S(+LEXLDR>0:1,1:0) S:LEXMOD>0 LEXE=1
 S X=LEXMOD
 Q X
MF(X) ; Modified Files
 N LEXMOD,LEXT S LEXMOD=+($G(X)) Q:LEXMOD'>0
 S LEXT=" * "_$S(LEXMOD>1:"These ",1:"This ")_"file"
 S LEXT=LEXT_$S(LEXMOD>1:"s ",1:" ")
 S LEXT=LEXT_"contain"_$S(LEXMOD>1:" ",1:"s ")
 S LEXT=LEXT_"fields that may be modified at the site."
 D BL^LEXXFI8,TL^LEXXFI8(LEXT)
 S LEXT="   The Checksum"_$S(LEXMOD>1:"s ",1:" ")
 S LEXT=LEXT_"for "_$S(LEXMOD>1:"these ",1:"this ")
 S LEXT=LEXT_"file"_$S(LEXMOD>1:"s ",1:" ")
 S LEXT=LEXT_"may vary from site to site."
 D TL^LEXXFI8(LEXT)
 Q
BL ; Blank Line
 N LEXI,LEXT S LEXI=+($O(^TMP("LEXCS",$J," "),-1)),LEXT=$G(^TMP("LEXCS",$J,+LEXI))
 Q:(LEXI+1)'>1  D:LEXT'="   " TL("   ")
 Q
TL(X) ; Text Line
 S X=$G(X) W:'$D(ZTQUEUED) !,X
 N LEXI S LEXI=+($O(^TMP("LEXCS",$J," "),-1))+1,^TMP("LEXCS",$J,LEXI)=X,^TMP("LEXCS",$J,0)=LEXI
 Q
TT(X,Y) ; Title Line
 N LEXFI,LEXTT,LEXT,LEXN,LEXNM S LEXFI=$G(X),LEXTT=$G(Y) S:+($$IF(LEXFI))'>0 LEXFI=""
 S:+LEXFI>0 LEXNM=$$FN(LEXFI)_" File (#"_+LEXFI_")" S:+LEXFI'>0 LEXNM="Lexicon/ICD/CPT File"
 S LEXT=" "_LEXNM_" "_$G(LEXTT) S:+($G(LEXMUL))>0&($E(LEXT,$L(LEXT))'="s") LEXT=LEXT_"s"
 D BL,TL(LEXT) S $P(LEXN,"=",$L(LEXT))="",LEXN=" "_LEXN D TL(LEXN)
 Q
IF(X) ; Is File on the List of Files
 N LEXTAG,LEXRTN,LEXCTR,LEXCTL,LEXFI,LEXLINE,LEXOK S LEXCTL=$G(X) Q:'$L(LEXCTL) 0  Q:+LEXCTL'>0 0
 S LEXFI="",LEXTAG="FILES",LEXRTN="LEXXFI",(LEXCTR,LEXOK)=0
 F  D  Q:LEXFI=""  Q:+LEXOK>0
 . S LEXCTR=LEXCTR+1
 . S LEXEX="S LEXLINE=$T("_LEXTAG_"+"_LEXCTR_"^"_LEXRTN_")" X LEXEX
 . S LEXFI=$P(LEXLINE,";;",2,3),LEXFI=$P(LEXFI,";;",2)
 . Q:'$L(LEXFI)  S:+LEXFI=+LEXCTL LEXOK=1
 S X=LEXOK
 Q X

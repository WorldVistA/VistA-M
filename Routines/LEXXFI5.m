LEXXFI5 ; ISL/KER - File Info - Versions/Revisions     ; 07/28/2004
 ;;2.0;LEXICON UTILITY;**32**;Sep 23, 1996
 Q
 ;                    
 ; Global Variables
 ;    None
 ;                        
 ; External References
 ;    None
 ;                    
ONE(X) ; Version/Revision - One File
 N LEXCTL,LEXCTR,LEXEX,LEXFC,LEXFI,LEXLINE,LEXRTN,LEXTAG
 Q:'$L(X)  S LEXCTL=+($G(X)) Q:+LEXCTL'>0
 S LEXFI="",LEXTAG="FILES",LEXRTN="LEXXFI",(LEXCTR,LEXFC)=0
 F  D  Q:LEXFI=""
 . S LEXCTR=LEXCTR+1,LEXEX="S LEXLINE=$T("_LEXTAG_"+"_LEXCTR_"^"_LEXRTN_")"
 . X LEXEX S LEXFI=$P(LEXLINE,";;",3) Q:'$L(LEXFI)  Q:LEXFI'=LEXCTL  D VR(LEXFI)
 Q
ALL ; Version/Revision
 N LEXCTR,LEXEX,LEXFC,LEXFI,LEXLINE,LEXRTN,LEXTAG
 S LEXFI="",LEXTAG="FILES",LEXRTN="LEXXFI",(LEXCTR,LEXFC)=0
 F  D  Q:LEXFI=""
 . S LEXCTR=LEXCTR+1,LEXEX="S LEXLINE=$T("_LEXTAG_"+"_LEXCTR_"^"_LEXRTN_")"
 . X LEXEX S LEXFI=$P(LEXLINE,";;",3) Q:'$L(LEXFI)  D VR(LEXFI)
 Q
VR(X) ; Get Version/Revision
 N LEXDD,LEXFI,LEXFIT,LEXFN,LEXIN,LEXLDR,LEXR,LEXRD,LEXRT,LEXT
 N LEXV,LEXVD,LEXVT S LEXFI=+($G(X)) Q:+LEXFI'>0
 S LEXFIT=$J($P(LEXFI,".",1),3)
 S:LEXFI["."&($L($P(LEXFI,".",2))) LEXFIT=LEXFIT_"."_$P(LEXFI,".",2)
 F  Q:$L(LEXFIT)'<7  S LEXFIT=LEXFIT_" "
 S LEXFN=$E($$FN^LEXXFI8(LEXFI),1,25)
 F  Q:LEXFN'["CATEGORY"  S LEXFN=$P(LEXFN,"CATEGORY",1)_"CAT"_$P(LEXFN,"CATEGORY",2)
 F  Q:LEXFN'["PROCEDURE"  S LEXFN=$P(LEXFN,"PROCEDURE",1)_"PROC"_$P(LEXFN,"PROCEDURE",2)
 F  Q:LEXFN'["NARRATIVES"  S LEXFN=$P(LEXFN,"NARRATIVES",1)_"NARR"_$P(LEXFN,"NARRATIVES",2)
 F  Q:$L(LEXFN)'<20  S LEXFN=LEXFN_" "
 S LEXV=$$VR^LEXXFI8(LEXFI)
 S LEXVD=$P(LEXV,"^",2) S:'$L(LEXVD) LEXVD="--/--/----" F  Q:$L(LEXVD)'<10  S LEXVD=LEXVD_" "
 S LEXDD=$P(LEXV,"^",3)
 S LEXLDR="   "
 S LEXV=$P(LEXV,"^",1)
 S LEXVT=$J($P(LEXV,".",1),3)
 S:LEXV["."&($L($P(LEXV,".",2))) LEXVT=LEXVT_"."_$P(LEXV,".",2)
 F  Q:$L(LEXVT)'<4  S LEXVT=LEXVT_" "
 S LEXR=$$RV^LEXXFI8(LEXFI)
 S LEXRD=$P(LEXR,"^",2)
 S:'$L(LEXRD) LEXRD="--/--/----" F  Q:$L(LEXRD)'<10  S LEXRD=LEXRD_" "
 S LEXR=$P(LEXR,"^",1) S:'$L(LEXR) LEXR="--" S LEXR=$J(LEXR,2)
 S LEXIN=$$INS^LEXXFI8(LEXFI) S:LEXIN="" LEXIN="--/--/----"
 S LEXFC=LEXFC+1 I LEXFC=1 D
 . D:+($G(LEXMUL))>0 TT^LEXXFI8("","Versions/Revisions")
 . D:+($G(LEXMUL))'>0 TT^LEXXFI8(LEXFI,"Version/Revision")
 . D BL^LEXXFI8 S LEXT="                                        Version         Revision    Install"
 . D TL^LEXXFI8(LEXT)
 . S LEXT="   File #  File Name              VR      Date     RV     Date        Date"
 . D TL^LEXXFI8(LEXT)
 . S LEXT="   ------- --------------------  ----  ----------  --  ----------  ----------"
 . D TL^LEXXFI8(LEXT)
 S LEXT=LEXLDR_LEXFIT_" "_LEXFN_" "_LEXVT_"  "_LEXVD_"  "_LEXR_"  "_LEXRD_"  "_LEXIN
 D TL^LEXXFI8(LEXT)
 Q

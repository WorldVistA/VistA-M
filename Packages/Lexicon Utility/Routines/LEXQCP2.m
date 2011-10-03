LEXQCP2 ;ISL/KER - Query - CPT Procedures - Save ;10/30/2008
 ;;2.0;LEXICON UTILITY;**62**;Sep 23, 1996;Build 16
 ;               
 ; Global Variables
 ;    ^DIC(81.3,          ICR   4492
 ;    ^ICPT(              ICR   4489
 ;    ^TMP("LEXQCPO")     SACC 2.3.2.5.1
 ;               
 ; External References
 ;    HIST^ICPTAPIU       ICR   1997
 ;    $$MODA^ICPTMOD      ICR   1996
 ;    $$DT^XLFDT          ICR  10103
 ;    $$UP^XLFSTR         ICR  10104
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;     LEXIEN             CPT Internal Entry Number
 ;     LEXLEN             Offset Length
 ;     LEXGET             Array of Non-Versioned Data
 ;     LEXST              CPT Status and Effective Dates
 ;     LEXSD              Versioned Short Description
 ;     LEXLD              Versioned Long Description
 ;     LEXMD              Versioned Modifiers
 ;     LEXLX              Versioned Lexicon Term
 ;     LEXWN              Warning
 ;     LEXINC             Flag to Display Modifiers
 ;     LEXELDT            External Last Date
 ;               
EN ; Main Entry Point
 K ^TMP("LEXQCPO",$J) Q:'$L($G(LEXELDT))  I +($G(LEXST))<0 D FUT D:$D(^TMP("LEXQCPO",$J)) DSP^LEXQO("LEXQCPO") Q
 D FUL D:$D(^TMP("LEXQCPO",$J)) DSP^LEXQO("LEXQCPO")
 Q
FUT ; Future Activation
 N LEX1,LEX2,LEX3,LEXEFF,LEXI,LEXL,LEXNAM,LEXSO,LEXSTA S LEXI=+($G(LEXIEN)) Q:+LEXI'>0  Q:'$D(^ICPT(+LEXI,0))  S LEXL=+($G(LEXLEN)) Q:+LEXL'>0
 S:LEXL>62 LEXL=62 S LEXSO=$G(LEXGET(81,(+LEXI_","),.01,"E")) Q:'$L(LEXSO)  S LEXNAM=$G(LEXGET(81,(+LEXI_","),"B")) Q:'$L(LEXNAM)
 S LEXSTA=$G(LEXST),LEXEFF=$P(LEXSTA,"^",5),LEXSTA=$P(LEXSTA,"^",4) Q:'$L(LEXSTA)  Q:'$L(LEXEFF)  S (LEX1,LEX2,LEX3)=""
 D BOD(LEXELDT),COD(LEXSO,LEXNAM,+($G(LEXL))),STA(.LEXST,+($G(LEXL)))
 Q
BOD(X) ;   Based on Date
 N LEXBOD,LEXT S LEXBOD=$G(X),LEXT="Display based on date:  "_LEXBOD D BL,TL(LEXT)
 Q
COD(X,Y,LEXLEN) ;   Code Line
 N LEXC,LEXN,LEXT S LEXC=$G(X),LEXN=$G(Y),LEXT="Code:  "_LEXC,LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXN D BL,TL(LEXT)
 Q
STA(X,LEXLEN) ;   Status Line
 N LEX,LEXC,LEXI,LEXN,LEXX,LEXE,LEXS,LEXT,LEXW,LEXEFF,LEXSTA S LEXX=$G(X),LEXEFF=$P(LEXX,"^",5),LEXSTA=$P(LEXX,"^",4),LEXEFF=$TR(LEXEFF,"()","")
 S LEXW=$P(LEXX,"^",6),LEXT="  Status:  ",LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT))),LEXT=LEXT_LEXSTA
 S LEXT=LEXT_$J(" ",(35-$L(LEXT)))_"Effective:  "_$$UP^XLFSTR($E(LEXEFF,1))_$E(LEXEFF,2,$L(LEXEFF)) D BL,TL(LEXT)
 I $L(LEXW) D
 . N LEX,LEXT,LEXC,LEXI,LEXN S LEX(1)=LEXW D PR^LEXQM(.LEX,(+($G(LEXLEN))-7)) Q:+($O(LEX(" "),-1))'>0
 . S LEXT=$J(" ",((79-+($G(LEXLEN)))))
 . S (LEXC,LEXI)=0 F  S LEXI=$O(LEX(LEXI)) Q:+LEXI'>0  D
 . . N LEXN S LEXN=$$TM^LEXQM($G(LEX(LEXI))) S:$L(LEXN) LEXC=LEXC+1 D:LEXC=1 BL D TL((LEXT_LEXN))
 Q
FUL ; Full Display
 N LEXFUL,LEX,LEXL S LEXL=+($G(LEXLEN)) S:LEXL>62 LEXL=62
 S LEXFUL=""  D FUT,CAT(+($G(LEXIEN)),+($G(LEXL))),LIM(+($G(LEXIEN)),+($G(LEXL)))
 D SD(.LEXSD,+($G(LEXL))),LD(.LEXLD,+($G(LEXL))),LX(.LEXLX,+($G(LEXL))),WR(.LEXWN,+($G(LEXL)))
 D:+($G(LEXINC))>0 MD(.LEXMD,+($G(LEXL)))
 Q
CAT(X,LEXLEN) ;   CPT Categories
 N LEXI,LEX1,LEX2,LEXT,LEXH1,LEXH2,LEXV1,LEXV2,LEXT,LEXTC S LEXI=+($G(X)),LEX1=$G(LEXGET(81,(+LEXI_","),3,1)),LEX2=$G(LEXGET(81,(+LEXI_","),3,2)) Q:'$L((LEX1_LEX2))
 S LEXT="  Categories: " S:$L(LEX1)&('$L(LEX2)) LEXT="  Category: " S:'$L(LEX1)&($L(LEX2)) LEXT="  Category: " S LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))
 S:$L(LEX1)&($L(LEX2)) LEXH1="Major Category:   "_LEX1,LEXH2="Sub-Category:     "_LEX2 S LEXH2=$J(" ",(79-+($G(LEXLEN))))_$G(LEXH2) S:$L(LEX1)&('$L(LEX2)) LEXH1=LEX1,LEXH2=""
 S:'$L(LEX1)&('$L(LEX2)) LEXH1="",LEXH2="" S LEX=LEXT_LEXH1_"^"_LEXH2
 D:$L($P(LEX,"^",1))!($L($P(LEX,"^",2))) BL D:$L($P(LEX,"^",1)) TL($P(LEX,"^",1)) D:$L($P(LEX,"^",2)) TL($P(LEX,"^",2))
 Q
LIM(X,LEXLEN) ;   Limitations
 N LEXI,LEXH,LEXL,LEXS,LEXT S LEXI=+($G(X)),LEXL=$G(LEXGET(81,(+LEXI_","),10.01,"E")) S:'$L(LEXL) LEXL="N/A"
 S LEXH=$G(LEXGET(81,(+LEXI_","),10.02,"E")) S:'$L(LEXH) LEXH="N/A" S LEXS=$G(LEXGET(81,(+LEXI_","),10.03,"E")) S:'$L(LEXS) LEXS="N/A"
 Q:(LEXH_LEXL_LEXS)="N/AN/AN/A"  S LEXT="  Limitations: ",LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_"Age Low:  "_LEXL
 S LEXT=LEXT_$J(" ",(35-$L(LEXT)))_"Age High:  "_LEXH,LEXT=LEXT_$J(" ",(56-$L(LEXT)))_"Sex:  "_LEXS D BL,TL(LEXT)
 Q
SD(X,LEXLEN) ;   Short Description
 N LEXI,LEXH,LEXE,LEXN,LEXT Q:'$D(X(1))  S LEXN=$G(X(1)),LEXT="  Short Name: ",LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXN D BL,TL(LEXT)
 S LEXE=$G(X(0)),LEXT="    "_LEXE,LEXN=$G(X(2)),LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXN D TL(LEXT)
 Q
LD(X,LEXLEN) ;   Long Description
 N LEXI,LEXH,LEXE,LEXN,LEXT Q:'$D(X(1))  S LEXN=$G(X(1)),LEXT="  Description: ",LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXN D BL,TL(LEXT)
 S LEXE=$G(X(0)),LEXT="    "_LEXE,LEXN=$G(X(2)),LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXN D TL(LEXT)
 S LEXT=$J(" ",((79-+($G(LEXLEN))))) S LEXI=2 F  S LEXI=$O(X(LEXI)) Q:+LEXI'>0  S LEXN=LEXT_$G(X(LEXI)) D TL(LEXN)
 Q
LX(X,LEXLEN) ;   Lexicon Expression
 N LEXI,LEXH,LEXE,LEXN,LEXT Q:'$D(X(1))  S LEXN=$G(X(1)),LEXT="  Lexicon Term:",LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXN D BL,TL(LEXT)
 S LEXE=$G(X(0)),LEXT="    "_LEXE,LEXN=$G(X(2)),LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXN D TL(LEXT)
 S LEXT=$J(" ",((79-+($G(LEXLEN))))),LEXI=2 F  S LEXI=$O(X(LEXI)) Q:+LEXI'>0  S LEXN=LEXT_$G(X(LEXI)) D TL(LEXN)
 Q
WR(X,LEXLEN) ;   Warning
 N LEXI,LEXH,LEXE,LEXN,LEXT,LEXC Q:'$D(X(1))  S LEXC=0,LEXN=$G(X(1)),LEXT="",LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXN D BL,TL(LEXT)
 S LEXT=$J(" ",((79-+($G(LEXLEN))))),LEXI=1 F  S LEXI=$O(X(LEXI)) Q:+LEXI'>0  S LEXN=LEXT_$G(X(LEXI)) D TL(LEXN)
 Q
MD(X,LEXLEN) ;   CPT Modifiers
 N LEXI,LEXH,LEXE,LEXN,LEXT Q:'$D(X(1))  S LEXE=$G(X(0)),LEXN=$G(X(1)),LEXT="  Modifiers:",LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXN D BL,TL(LEXT)
 S LEXT="    "_LEXE,LEXN=$G(X(2)),LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXN D TL(LEXT)
 S LEXT=$J(" ",((79-+($G(LEXLEN))))),LEXI=2 F  S LEXI=$O(X(LEXI)) Q:+LEXI'>0  D
 . S LEXN=LEXT_$G(X(LEXI)) D TL(LEXN)
 Q
MOD(X,LEXVDT,LEX,LEXLEN,LEXSTA) ;   CPT Modifiers
 ;            
 ; LEX=# of Lines
 ; LEX(0)=External Date
 ; LEX(#)=Modifier List
 ;            
 N LEXA,LEXEVDT,LEXFA,LEXI,LEXIEN,LEXM,LEXS,LEXSO S LEXIEN=$G(X) Q:+LEXIEN'>0  Q:'$D(^ICPT(+LEXIEN,0))  S LEXSTA=+($G(LEXSTA))
 S LEXVDT=+($G(LEXVDT)) S:LEXVDT'?7N LEXVDT=$$DT^XLFDT S LEXEVDT=$$SD^LEXQM(LEXVDT),LEXLEN=+($G(LEXLEN)) S:+LEXLEN'>0 LEXLEN=62  Q:'$L(LEXEVDT)
 S LEXSO=$P($G(^ICPT(+LEXIEN,0)),"^",1) Q:'$L(LEXSO)  S LEXFA=$$FA(+LEXIEN) Q:LEXVDT<LEXFA
 K LEX D MODA^ICPTMOD(LEXSO,LEXVDT,.LEXA) S (LEXS,LEXM)="" F  S LEXM=$O(LEXA("A",LEXM)) Q:'$L(LEXM)  D
 . Q:'$D(^DIC(81.3,"B",LEXM))  I ($L(LEXS)+$L(LEXM)+3)'>62 S LEXS=LEXS_LEXM_"   " Q
 . I ($L(LEXS)+$L(LEXM)+3)>62 S LEXI=$O(LEX(" "),-1)+1,LEX(LEXI)=$$TM^LEXQM(LEXS),LEXS=LEXM_"   " Q
 I $L(LEXS) S LEXI=$O(LEX(" "),-1)+1,LEX(LEXI)=$$TM^LEXQM(LEXS)
 S LEX=$O(LEX(" "),-1) S:$D(LEXTEST)&(+LEXSTA'>0) LEXEVDT="--/--/----" S LEX(0)=LEXEVDT
 Q
WN(X,LEX,LEXLEN) ;   Warning
 ;            
 ; LEX=# of Lines
 ; LEX(0)=External Date
 ; LEX(#)=Warning
 ;            
 N LEXVDT,LEXIA,LEXTMP,LEXREF K LEX S LEXVDT=$G(X) Q:LEXVDT'?7N  S LEXIA=$$IA^LEXQCP(LEXVDT) Q:+LEXIA'>0
 S LEXLEN=+$G(LEXLEN) S:+LEXLEN>62 LEXLEN=62 S LEXREF="Short Name and Description" S:$D(LEXLX) LEXREF="Short Name, Description and Lexicon Term"
 S LEXTMP(1)="Warning:  The 'Based on Date' provided precedes Code Set Versioning.  The "_LEXREF_" may be inaccurate for "_$$SD^LEXQM(LEXVDT)
 D PR^LEXQM(.LEXTMP,LEXLEN) K LEX S LEXI=0 F  S LEXI=$O(LEXTMP(LEXI)) Q:+LEXI'>0  S LEX(LEXI)=$G(LEXTMP(LEXI))
 S LEX=$O(LEX(" "),-1),LEX(0)=$$SD^LEXQM(LEXVDT)
 Q
 ;
 ; Miscellaneous
FA(X) ;   First Activation
 N LEXFA,LEXH,LEXI,LEXIEN,LEXSO
 S LEXIEN=+($G(X)) S X="",LEXSO=$P($G(^ICPT(+LEXIEN,0)),"^",1) D HIST^ICPTAPIU(LEXSO,.LEXH) S LEXFA="",LEXI=0
 F  S LEXI=$O(LEXH(LEXI)) Q:+LEXI'>0!($L(LEXFA))  S:+($G(LEXH(LEXI)))>0&(LEXI?7N) LEXFA=LEXI Q:$L(LEXFA)
 S X=LEXFA
 Q X
BL ;   Blank Line
 D TL(" ") Q
TL(X) ;   Text Line
 I $D(LEXTEST) W !,$G(X) Q
 N LEXI S LEXI=+($O(^TMP("LEXQCPO",$J," "),-1))+1 S ^TMP("LEXQCPO",$J,LEXI)=$G(X),^TMP("LEXQCPO",$J,0)=LEXI
 Q
CLR ;   Clear
 N LEXIEN,LEXLEN,LEXGET,LEXSD,LEXLD,LEXMD,LEXLX,LEXINC,LEXELDT,LEXST,LEXTEST,LEXWN
 Q

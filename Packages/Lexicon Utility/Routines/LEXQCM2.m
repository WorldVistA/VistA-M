LEXQCM2 ;ISL/KER - Query - CPT Modifiers - Save ;10/30/2008
 ;;2.0;LEXICON UTILITY;**62**;Sep 23, 1996;Build 16
 ;               
 ; Global Variables
 ;    ^DIC(81.3,          ICR   4492
 ;    ^TMP("LEXQCM"       SACC 2.3.2.5.1
 ;    ^TMP("LEXQCMO"      SACC 2.3.2.5.1
 ;               
 ; External References
 ;    $$DT^XLFDT          ICR  10103
 ;    $$UP^XLFSTR         ICR  10104
 ;               
 ; Variables NEWed or KILLed Elsewhere
 ;    LEXIEN              Modifier IEN
 ;    LEXELDT             External Last Date
 ;    LEXLEN              Offset Length
 ;    LEXINC              Include Modifier Ranges flag
 ;    LEXINCI             Include Inactive Modifier Ranges flag
 ;    LEXINCF             Include Future Modifier Ranges flag
 ;    LEXGET              Array of Non-Versioned Data
 ;    LEXST               CPT Status and Effective Dates
 ;    LEXSD               Versioned Short Description
 ;    LEXLD               Versioned Long Description
 ;    LEXRAN              Number of Ranges/Comment
 ;    ^TMP("LEXQCM",$J,"RANGES",#)  List of Ranges
 ;               
EN ; Main Entry Point
 ;            
 K ^TMP("LEXQCMO",$J) Q:'$L($G(LEXELDT))
 I +($G(LEXST))<0 D FUT D:$D(^TMP("LEXQCMO",$J)) DSP^LEXQO("LEXQCMO") Q
 D FUL D:$D(^TMP("LEXQCMO",$J)) DSP^LEXQO("LEXQCMO")
 Q
FUT ; Future Activation
 N LEX1,LEX2,LEX3,LEXEFF,LEXI,LEXL,LEXNAM,LEXSO,LEXSTA S LEXI=+($G(LEXIEN)) Q:+LEXI'>0  Q:'$D(^DIC(81.3,+LEXI,0))  S LEXL=+($G(LEXLEN)) Q:+LEXL'>0
 S:LEXL>62 LEXL=62 S LEXSO=$G(LEXGET(81.3,(+LEXI_","),.01,"E")) Q:'$L(LEXSO)  S LEXNAM=$G(LEXGET(81.3,(+LEXI_","),"B")) Q:'$L(LEXNAM)
 S LEXSTA=$G(LEXST),LEXEFF=$P(LEXSTA,"^",5),LEXSTA=$P(LEXSTA,"^",4) Q:'$L(LEXSTA)  Q:'$L(LEXEFF)  S (LEX1,LEX2,LEX3)=""
 D BOD(LEXELDT),COD(LEXSO,LEXNAM,+($G(LEXL))),STA(.LEXST,+($G(LEXL)))
 Q
BOD(X) ;   Based on Date
 N LEXBOD S LEXBOD=$G(X) Q:'$L(LEXBOD)  Q:LEXBOD'["/"  S X="Display based on date:  "_LEXBOD D BL,TL(X)
 Q
COD(X,Y,LEXLEN) ;   Code Line
 N LEXC,LEXN,LEXT S LEXC=$G(X),LEXN=$G(Y) S LEXT="Code:  "_LEXC,LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXN D BL,TL(LEXT)
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
 ;            
FUL ; Full Display
 N LEXFUL,LEX,LEXL S LEXL=+($G(LEXLEN)) S:LEXL>62 LEXL=62
 S LEXFUL=""  D FUT
 D SD(.LEXSD,+($G(LEXL))),LD(.LEXLD,+($G(LEXL))),WN(.LEXWN,+($G(LEXL)))
 D:+($G(LEXRAN))>0&($L($P($G(LEXRAN),"^",2)))&($O(^TMP("LEXQCM",$J,"RANGES",0))>0) RAN(.LEXRAN,+($G(LEXL)))
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
WN(X,LEXLEN) ;   Warning
 N LEXI,LEXH,LEXE,LEXN,LEXT,LEXC Q:'$D(X(1))  S LEXC=0,LEXN=$G(X(1)),LEXT="",LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXN D BL,TL(LEXT)
 S LEXT=$J(" ",((79-+($G(LEXLEN))))),LEXI=1 F  S LEXI=$O(X(LEXI)) Q:+LEXI'>0  S LEXN=LEXT_$G(X(LEXI)) D TL(LEXN)
 Q
RAN(X,LEXLEN) ;   Code Ranges
 N LEXC,LEXH,LEXI,LEXN,LEXS,LEXT S LEXH=$G(X),LEXN=+LEXH,LEXH=$P(LEXH,"^",2) Q:+LEXN'>0  Q:'$L(LEXH)
 S LEXT="  Code Ranges: ",LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXH,LEXN=$J(" ",((79-+($G(LEXLEN))))) D BL,TL(LEXT)
 S (LEXC,LEXI)=0 F  S LEXI=$O(^TMP("LEXQCM",$J,"RANGES",LEXI)) Q:+LEXI'>0  D
 . S LEXC=LEXC+1 D:LEXC=1 BL S LEXT=$G(^TMP("LEXQCM",$J,"RANGES",LEXI)) Q:'$L(LEXT)  D TL((LEXN_LEXT))
 Q
CCR(X,LEXVDT,LEX,LEXLEN,LEXINCI,LEXINCF) ;   CPT Code Ranges
 ;            
 ; LEX=# of Ranges
 ; ^TMP("LEXQCM",$J,"RANGES",#)=Begin_End_Act_Inact
 ;            
 K ^TMP("LEXQCM",$J,"RAN"),^TMP("LEXQCM",$J,"RANGES")
 N LEXC,LEXEVDT,LEXFD,LEXFN,LEXH1,LEXH2,LEXH3,LEXIEN,LEXL,LEXN,LEXP,LEXR0,LEXRA,LEXRA1,LEXRA2,LEXRB,LEXRDA,LEXRDI,LEXRE,LEXRI,LEXRI1,LEXRI2,LEXRN,LEXRT,LEXRX,LEXT
 S LEXIEN=$G(X) Q:+LEXIEN'>0  Q:'$D(^DIC(81.3,+LEXIEN,0))  Q:$O(^DIC(81.3,+LEXIEN,10,0))'>0  S LEXVDT=+($G(LEXVDT)) S:LEXVDT'?7N LEXVDT=$$DT^XLFDT S LEXEVDT=$$SD^LEXQM(LEXVDT),LEXLEN=+($G(LEXLEN))
 S:+LEXLEN'>0 LEXLEN=62 Q:'$L(LEXEVDT)  S LEXINCI=+($G(LEXINCI)),LEXINCF=+($G(LEXINCF)) S (LEXFD,LEXRX)=0 F  S LEXRX=$O(^DIC(81.3,+LEXIEN,10,LEXRX)) Q:+LEXRX'>0  D
 . S LEXR0=$G(^DIC(81.3,+LEXIEN,10,LEXRX,0)),LEXRB=$P(LEXR0,"^",1) Q:$L(LEXRB)'=5  S LEXRE=$P(LEXR0,"^",2) S:$L(LEXRB)&('$L(LEXRE)) LEXRE=LEXRB Q:$L(LEXRE)'=5
 . S LEXRA=$P(LEXR0,"^",3) Q:LEXRA'?7N  S LEXRI=$P(LEXR0,"^",4) Q:+LEXRA>0&(LEXVDT<+($G(LEXRA)))&(+($G(LEXINCF))'>0)  Q:+LEXRI>0&(LEXVDT>+($G(LEXRI)))&(+($G(LEXINCI))'>0)
 . S LEXRN=$$NUM(LEXRB),LEXRT=LEXRB_"^"_LEXRE_"^"_LEXRA_"^"_LEXRI,LEXRA1=$S(LEXVDT<LEXRA:"<",1:" "),LEXRA2=$S(LEXVDT<LEXRA:">",1:" ")
 . S LEXRI1=$S(LEXVDT<LEXRI:"<",1:" "),LEXRI2=$S(LEXVDT<LEXRI:">",1:" ") S:LEXRA1["<"!(LEXRA2[">")!(LEXRI1["<")!(LEXRI2[">") LEXFD=1
 . S LEXRDA=$S($L(LEXRA):(LEXRA1_$$SD^LEXQM(LEXRA)_LEXRA2),1:""),LEXRDI=$S($L(LEXRI):(LEXRI1_$$SD^LEXQM(LEXRI)_LEXRI2),1:"")
 . S ^TMP("LEXQCM",$J,"RAN",LEXRN,LEXRT)=LEXRB_"    "_LEXRE_"   "_LEXRDA_"  "_LEXRDI
 S LEXH1="CPT Code Range         Effective Dates",LEXH2="Begin     End       Active       Inactive",LEXH3="-----    -----    ----------    ----------"
 K LEX S (LEX,LEXL,LEXC,LEXRN)=0 S LEXFN="" S:+($G(LEXFD))>0 LEXFN="   Future dates indicated as  '<mm/dd/yyyy>'"
 S LEXC=0 F  S LEXRN=$O(^TMP("LEXQCM",$J,"RAN",LEXRN)) Q:+LEXRN'>0  S LEXRT="" F  S LEXRT=$O(^TMP("LEXQCM",$J,"RAN",LEXRN,LEXRT)) Q:'$L(LEXRT)  D
 . S LEXT=$G(^TMP("LEXQCM",$J,"RAN",LEXRN,LEXRT)) Q:'$L(LEXT)  S LEXC=LEXC+1 I LEXC=1 D
 . . S LEXN=$O(^TMP("LEXQCM",$J,"RANGES"," "),-1)+1,^TMP("LEXQCM",$J,"RANGES",LEXN)=LEXH1 S LEXN=$O(^TMP("LEXQCM",$J,"RANGES"," "),-1)+1,^TMP("LEXQCM",$J,"RANGES",LEXN)=LEXH2
 . . S LEXN=$O(^TMP("LEXQCM",$J,"RANGES"," "),-1)+1,^TMP("LEXQCM",$J,"RANGES",LEXN)=LEXH3 S ^TMP("LEXQCM",$J,"RANGES",0)=LEXN
 . S LEX=+($G(LEX))+1 S LEXN=$O(^TMP("LEXQCM",$J,"RANGES"," "),-1)+1,^TMP("LEXQCM",$J,"RANGES",LEXN)=LEXT,^TMP("LEXQCM",$J,"RANGES",0)=LEXN
 I $L(LEXFN) D
 . S LEXN=$O(^TMP("LEXQCM",$J,"RANGES"," "),-1)+1,^TMP("LEXQCM",$J,"RANGES",LEXN)="      ",^TMP("LEXQCM",$J,"RANGES",0)=LEXN
 . S LEXN=$O(^TMP("LEXQCM",$J,"RANGES"," "),-1)+1,^TMP("LEXQCM",$J,"RANGES",LEXN)=LEXFN,^TMP("LEXQCM",$J,"RANGES",0)=LEXN
 K ^TMP("LEXQCM",$J,"RAN") S LEXT="" I +LEX>0 D
 . N LEXP,LEXT S LEXP=$S(+LEX>1:"s",1:""),LEXT="" S:+($G(LEXINCI))>0&(+($G(LEXINCF))>0) LEXT=+LEX_" Current and future Active or Inactive range"_LEXP_" found"
 . S:+($G(LEXINCI))>0&(+($G(LEXINCF))'>0) LEXT=+LEX_" Currently Active or Inactive range"_LEXP_" found" S:+($G(LEXINCI))'>0&(+($G(LEXINCF))>0) LEXT=+LEX_" Current and future Active range"_LEXP_" found"
 . S:+($G(LEXINCI))'>0&(+($G(LEXINCF))'>0) LEXT=+LEX_" Currently Active range"_LEXP_" found" S:$L(LEXT) LEX=LEX_"^"_LEXT
 Q
 ;
 ; Miscellaneous
BL ;   Blank Line
 D TL(" ") Q
TL(X) ;   Text Line
 I $D(LEXTEST) W !,$G(X) Q
 N LEXI S LEXI=+($O(^TMP("LEXQCMO",$J," "),-1))+1 S ^TMP("LEXQCMO",$J,LEXI)=$G(X),^TMP("LEXQCMO",$J,0)=LEXI
 Q
NUM(X) ;   Convert Code to Numeric
 Q $S(X?1.N:+X,X?4N1A:$A($E(X,5))*10_$E(X,1,4),1:$A(X)_$E(X,2,5))
CLR ;   Clear
 N LEXELDT,LEXGET,LEXLD,LEXRAN,LEXSD,LEXST,LEXTEST,LEXWN
 Q

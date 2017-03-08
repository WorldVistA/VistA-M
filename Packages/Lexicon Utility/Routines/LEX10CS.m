LEX10CS ;ISL/KER - ICD-10 Code Set ;11/16/2016
 ;;2.0;LEXICON UTILITY;**80,110**;Sep 23, 1996;Build 6
 ;               
 ; Global Variables
 ;    ^LEX(757.033        N/A
 ;    ^TMP("LEXDX")       SACC 2.3.2.5.1
 ;               
 ; External References
 ;    $$DTBR^ICDEX        ICR   5747
 ;    $$ICDOP^ICDEX       ICR   5747
 ;    $$LD^ICDEX          ICR   5747
 ;    $$DT^XLFDT          ICR  10103
 ;               
ICDSRCH(X,LEXDATA,LEXD,LEXL,LEXF) ; ICD Diagnosis Search
 ;
 ; Input
 ;
 ;   X           Search Text (Required)
 ;  .LEXDATA     Local Array (by Ref, Required)
 ;   LEXD        Search Date (Optional,Default TODAY)
 ;   LEXL        List Length (Optional, Default 30)
 ;   LEXF        Filter (Optional, Default 10D)
 ;
 ;   LEXDATA()   Output Array of codes
 ;
 ;       LEXDATA(0)=# found ^ Pruning Indicator
 ;       LEXDATA(1)=CODE ^ date
 ;       LEXDATA(1,"IDL")=ICD-9/10 Description, Long
 ;       LEXDATA(1,"IDL",1)=ICD-9/10 IEN ^ date
 ;       LEXDATA(1,"IDS")=ICD-9/10 Description, Short
 ;       LEXDATA(1,"IDS",1)=ICD-9/10 IEN ^ date
 ;       LEXDATA(1,"LEX")=Lexicon Description
 ;       LEXDATA(1,"LEX",1)=Expression IEN ^ date
 ;       LEXDATA(1,"SYN",1)=Synonym #1
 ;       LEXDATA(1,"SYN",m)=Synonym #m
 ;       LEXDATA(n,0)=
 ;
 ;       Category or Subcategory
 ;       LEXDATA(n,0)=Category Code
 ;       LEXDATA(n,"CAT")=Category Name
 ;       
 ;   $$ICDSRCH
 ;
 ;     A variable defining success/error conditions
 ;
 ;        Positive number for success
 ;
 ;        Negative number for error or condition
 ;
 ;          "-1^No codes found"
 ;          "-2^Too many items found, please refine search"
 ;
 K LEXDATA
 N LEX,LEXX,LEXVDT,LEXCS,LEXFI,LEXFIL,LEXLEN,LEXTMP,LEXOK,LEXOUT,LEXTOT
 N LEXPR,ICD10,LEXINC S LEXX=$$UP^XLFSTR($G(X))
 Q:'$L(LEXX) "-1^No search string passed"
 S ICD10=$$IMPDATE^LEXU("10D") I $L(LEXX)'>2 D  Q X
 . S X="-1^Invalid search string passed, minimum of 3 characters"
 S LEXVDT=$P($G(LEXD),".",1),LEXFIL=$G(LEXF) I LEXVDT'<ICD10 D  Q X
 . S LEXCS=30,X=$$DIAGSRCH($G(LEXX),.LEXDATA,LEXVDT,$G(LEXL),$G(LEXF))
 S LEXLEN=$G(LEXL) S:+LEXLEN'>0 LEXLEN=30
 S:'$L(LEXFIL) LEXFIL="I $$SO^LEXU(Y,""ICD"",+($G(LEXVDT)))"
 K LEXOUT S LEXCS=1 D I9T^LEX10DX(LEXX,.LEXOUT,LEXVDT,LEXLEN,LEXFIL)
 S LEXTOT=$G(LEXOUT(0)),LEXPR=+($P($G(LEXTOT),"^",2)),LEXTOT=+LEXTOT
 S LEXFI=80 D DXARY^LEX10DU K LEX,LEXOUT S:+LEXTOT'>0 LEXOUT="-1^No codes found"
 I +LEXTOT>0&(LEXPR>0) D
 . S LEXOUT="-2^Too many items found, please refine search"
 S:+LEXTOT>0&(LEXPR'>0) LEXOUT=LEXTOT S X=LEXOUT
 Q X
 ;
DIAGSRCH(X,LEXDATA,LEXD,LEXL,LEXF) ; ICD-10 Diagnosis Search
 ;
 ; Input
 ;
 ;   X           Search Text (Required)
 ;  .LEXDATA     Local Array (by Ref, Required)
 ;   LEXD        Search Date (Optional, Default TODAY)
 ;   LEXL        List Length (Optional, Default 30)
 ;   LEXF        Filter (Optional, Default 10D - must be executable M code)
 ;
 ; Output
 ;
 ;   LEXDATA()   Output Array of codes/categories found
 ;
 ;       LEXDATA(0)=# found ^ Pruning Indicator
 ;       
 ;       Code
 ;       LEXDATA(1)=CODE ^ date
 ;       LEXDATA(1,"IDL")=ICD-9/10 Description, Long
 ;       LEXDATA(1,"IDL",1)=ICD-9/10 IEN ^ date
 ;       LEXDATA(1,"IDS")=ICD-9/10 Description, Short
 ;       LEXDATA(1,"IDS",1)=ICD-9/10 IEN ^ date
 ;       LEXDATA(1,"LEX")=Lexicon Description
 ;       LEXDATA(1,"LEX",1)=Expression IEN ^ date
 ;       LEXDATA(1,"SYN",1)=Synonym #1
 ;       LEXDATA(1,"SYN",m)=Synonym #m
 ;       LEXDATA(1,"MENU")=Menu Text
 ;       LEXDATA(1,"MSG")=Message (unversioned only)
 ;       LEXDATA(n,0)=
 ;
 ;       Category or Subcategory
 ;       LEXDATA(n,0)=Category Code
 ;       LEXDATA(n,"CAT")=Category Name
 ;
 ;   $$DIAGSRCH  
 ;
 ;     A variable defining success/error conditions
 ;
 ;        Positive number for success
 ;
 ;        Negative number for error or condition
 ;
 ;          "-1^No codes found"
 ;          "-2^Too many items found, please refine search"
 ;          
 K LEXDATA,^TMP("LEXDX",$J)
 N LEX,LEXX,LEXVDT,LEXFI,LEXFIL,LEXLEN,LEXTMP,LEXOK,LEXOUT
 N LEXTOT,LEXPR,LEXCS,LEXTLX,LEXIS,LEXINC
 N ICDVDT,ICDSYS,ICDFMT
 S X=$G(X) F  Q:$E(X,$L(X))'="+"  S X=$E(X,1,($L(X)-1))
 S LEXX=$$UP^XLFSTR($G(X)),LEXVDT=$P($G(LEXD),".",1),LEXCS=30,LEXFIL=$G(LEXF)
 Q:'$L(LEXX) "-1^No search string passed"
 Q:$L(LEXX)'>1 "-1^Invalid search string passed"
 I $L(LEXX)=2,LEXX?1A.1N D MAJ^LEX10DBR($$UP^XLFSTR(LEXX),.LEXOUT,LEXVDT) G OUT
 S LEXLEN=$G(LEXL) S:+LEXLEN'>0 LEXLEN=30 S:+LEXLEN'>7 LEXLEN=8
 S LEXIS=$$ISCAT^LEX10DU(LEXX)
 ; Input is a category with no categories
 ; and code exceeds max, expand the max
 I +LEXIS>0,+($P(LEXIS,"^",2))'>0,+($P(LEXIS,"^",3))>LEXLEN S LEXLEN=99999
 S:'$L(LEXFIL)&(LEXVDT?7N) LEXFIL="I $$SO^LEXU(Y,""10D"",+($G(LEXVDT)))"
 S:'$L(LEXFIL)&(LEXVDT'?7N) LEXFIL="I $L($$D10^LEX10CS(+Y))"
 S LEXTMP=LEXX S:$L(LEXTMP)=3&(LEXTMP'[".") LEXTMP=LEXTMP_"."
 S LEXOK=0 I $L(LEXTMP)>3,$L(LEXTMP)'>8,LEXTMP["." D
 . N LEXTK S:$D(^LEX(757.02,"ADX",(LEXTMP_" "))) LEXOK=1 Q:LEXOK
 . S:$O(^LEX(757.02,"ADX",(LEXTMP_" ")))[LEXTMP LEXOK=1 Q:LEXOK
 . S LEXTK=$$WDS(LEXTMP) S:$E(LEXTMP,1,4)'?1A2N1"."&(LEXTK'>0) LEXOK=-1
 . S:$E(LEXTMP,1,4)?1A2N1"."&(LEXTK'>0) LEXOK=-1
 K LEXOUT Q:LEXOK<0 "-1^Search string does not appear to be a code or text"
 I LEXOK D I10C^LEX10DBC(LEXTMP,.LEXOUT,LEXVDT,LEXLEN,LEXFIL)
 I 'LEXOK D I10T^LEX10DBT(LEXX,.LEXOUT,LEXVDT,LEXLEN,LEXFIL)
OUT ; Out Array
 K ^TMP("LEXDX",$J) I +($G(LEXOUT(0)))=-1 Q LEXOUT(0)
 I +($G(LEXOUT(0)))=-2 Q -2_U_"final pruned list exceeds specified limit"
 S LEXTOT=$G(LEXOUT(0)),LEXPR=+($P($G(LEXTOT),"^",2)),LEXTOT=+LEXTOT
 S LEXTLX=$G(LEXOUT(0)) S LEXFI=80 D DXARY^LEX10DU
 S LEXOUT=LEXTLX
 S:+LEXTLX>0&(+LEXTLX=+($G(LEXDATA(0)))) LEXDATA(0)=LEXTLX
 S:+LEXTOT'>0 LEXOUT="-1^No codes found"
 S X=LEXOUT
 Q X
WDS(X) ; Words in String
 S X=$G(X) Q:'$L(X) 0  K ^TMP("LEXTKN",$J) D PTX^LEXTOKN
 N LEXI,LEXT,LEXC S (LEXI,LEXC)=0 F  S LEXI=$O(^TMP("LEXTKN",$J,LEXI)) Q:+LEXI'>0  D
 . S LEXT="" F  S LEXT=$O(^TMP("LEXTKN",$J,LEXI,LEXT)) Q:'$L(LEXT)  D
 . . S:$D(^LEX(757.01,"AWRD",LEXT)) LEXC=LEXC+1
 S X=LEXC K ^TMP("LEXTKN",$J)
 Q X
 ;
PCSDIG(X,LEXD) ; Return ICD-10 Codes Expanding On Input
 ;
 ; Input
 ;
 ;   X           Search code (partial, Required)
 ;   LEXD        Search Date (Optional, Default TODAY)
 ;
 ; Output
 ;
 ;   LEXDATA()   Output Array containing the characters found
 ;
 ;       LEXDATA("NEXLEV",<next character>,"DESC")= Description
 ;
 ;       Output based on user input of "00P"
 ;
 ;          LEXPCDAT("NEXLEV",0,"DESC")="Brain"
 ;          LEXPCDAT("NEXLEV",6,"DESC")="Cerebral Ventricle"
 ;          LEXPCDAT("NEXLEV","E","DESC")="Cranial Nerve"
 ;          LEXPCDAT("NEXLEV","U","DESC")="Spinal Canal"
 ;          LEXPCDAT("NEXLEV","V",DESC)="Spinal Cord"
 ;
 ;       Output based on user input of "03120A1"
 ;
 ;          LEXPCDAT("PCSDESC")="BYPASS INNOMINATE ARTERY TO 
 ;             LEFT UPPER ARM ARTERY ITH AUTOLOGOUS ARTERIAL 
 ;             TISSUE, OPEN APPROACH"
 ;          LEXPCDAT("STATUS")="1^Date"
 ;
 ;   $$PCSDIG  "1" - If input code fragment is valid or null
 ;             "0" - If input code fragment is invalid
 ;
 K LEXPCDAT
 N LEX,LEXI,LEXII,LEXCTL,LEXPCS,LEXEXIT,LEXLEN,LEXNXT,LEXCD,LELXI
 S:$L($G(X)) X=$$UP^XLFSTR(X) S:$L($G(LEXD)) LEXD=$P($G(LEXD),".",1)
 I $D(X),X'?."",('$D(^LEX(757.033,"B","10P"_X))) Q 0
 S:'$D(X) LEXLEN=0,X=""
 S:$D(X) LEXLEN=$L(X)
 I LEXLEN>6 G PCSALL
 S (LEXI,LEXEXIT)=0
 F  S LEXI=$O(^LEX(757.033,"AFRAG",LEXI)) Q:'LEXI!LEXEXIT  D
 . S:$D(^LEX(757.03,"ASAB","10P",LEXI)) LEXEXIT=1,LEXII=LEXI
 S LEXCTL=X,LEXPCS=X_" ",LEXEXIT=0
 F  S LEXPCS=$O(^LEX(757.033,"AFRAG",LEXII,LEXPCS)) Q:'$D(LEXPCS)!LEXEXIT  D
 . I X'=$E(LEXPCS,1,LEXLEN)!(LEXPCS="") S LEXEXIT=1 Q
 . N LEXOK S LEXOK=$$PCSOK(LEXPCS,$G(LEXD)) Q:LEXOK'>0
 . S LEXNXT=$E(LEXPCS,LEXLEN+1)
 . I '$D(LEXPCDAT("NEXLEV",LEXNXT,"DESC")) D
 . . N LEXF,LEXFA
 . . S LEXI="",LEXI=$O(^LEX(757.033,"B",("10P"_X_LEXNXT),LEXI))
 . . S LEXF=$$FIN^LEX10PR(LEXI,$G(LEXD),.LEXFA)
 . . S:$L($G(LEXFA(2))) LEXPCDAT("NEXLEV",LEXNXT,"DESC")=$G(LEXFA(2))
 . . S:$L($G(LEXFA(3))) LEXPCDAT("NEXLEV",LEXNXT,"META","Definition")=$G(LEXFA(3))
 . . S:$L($G(LEXFA(4))) LEXPCDAT("NEXLEV",LEXNXT,"META","Explanation")=$G(LEXFA(4))
 . . S LEXF=0 F  S LEXF=$O(LEXFA(5,LEXF)) Q:+LEXF'>0  D
 . . . S:$L($G(LEXFA(5,+LEXF))) LEXPCDAT("NEXLEV",LEXNXT,"META","Includes/Examples",LEXF)=$G(LEXFA(5,+LEXF))
 . S LEXPCS=LEXCTL_LEXNXT_"~ "
 S LEXPCDAT=1
 Q 1
PCSALL ; Return PCS data for full 7 digit code
 N LEXLD,LEXA S LEXD=$P($G(LEXD),".",1) S:LEXD'?7N LEXD=$G(DT)
 S:LEXD'?7N LEXD=$$DT^XLFDT S LEXD=$$DTBR^ICDEX(LEXD,0,31)
 S LEXCD=$$ICDOP^ICDEX(X,LEXD,31,"E")
 I $P(LEXCD,"^",1)="-1" Q 0
 S:$P(LEXCD,"^",10)>0 LEXPCDAT("STATUS")=$P(LEXCD,"^",10)_"^"_$P(LEXCD,"^",13)
 S:$P(LEXCD,"^",10)'>0 LEXPCDAT("STATUS")=$P(LEXCD,"^",10)_"^"_$P(LEXCD,"^",12)
 S LEXLD=$$LD^ICDEX(80.1,+LEXCD,LEXD,.LEXA)
 S LEXPCDAT("PCSDESC")=$G(LEXA(1))
 Q 1
PCSOK(X,LEXD) ; PCS data is OK
 N LEXF,LEXO,LEXC,LEXN,LEXI,LEXS,LEXK S (LEXC,LEXF)=$TR($G(X)," ","") Q:'$L(LEXC) 0
 S X=0,LEXD=$P($G(LEXD),".",1),LEXI=$$IMPDATE^LEXU(31) S:+LEXI>+LEXD LEXD=LEXI
 S LEXO=$E(LEXF,1,($L(LEXF)-1))_$C($A($E(LEXF,$L(LEXF)))-1)_"~ "
 F  S LEXO=$O(^LEX(757.02,"APR",LEXO)) Q:'$L(LEXO)  Q:$E(LEXO,1,$L(LEXC))'=LEXC  D  Q:X>0
 . N LEXEF S LEXEF=$O(^LEX(757.02,"APR",LEXO,(LEXD+.001)),-1) Q:'$L(LEXEF)
 . S:'$D(^LEX(757.02,"APR",LEXO,LEXEF,0)) X=1
 Q X
 ;
CODELIST(X,LEXSPEC,LEXSUB,LEXD,LEXL,LEXF) ;
 ; NOTE:  Routine split due to SACC Limits on size, see LEX10CS2
 Q $$CODELIST^LEX10CS2($G(X),$G(LEXSPEC),$G(LEXSUB),$P($G(LEXD),".",1),$G(LEXL),$G(LEXF))
TAX(X,LEXSRC,LEXDT,LEXSUB,LEXVER) ; Taxonomies
 Q $$TAX^LEX10TAX($G(X),$G(LEXSRC),$P($G(LEXDT),".",1),$G(LEXSUB),$G(LEXVER))
D10(LEX) ; Get One Code (unversioned)
 N LEXA,LEXCD,LEXEF,LEXIEN,LEXSAB,LEXSIEN,LEXVDT
 S LEXVDT="",LEXSAB="10D",LEXIEN=$G(LEX) Q:+($G(LEXIEN))'>0 ""
 Q:$P($G(^LEX(757.01,LEXIEN,1)),"^",5)>0 ""
 S LEXSIEN=0 F  S LEXSIEN=$O(^LEX(757.02,"B",LEXIEN,LEXSIEN)) Q:+LEXSIEN'>0  D
 . N LEXEF,LEXCD Q:'$D(^LEX(757.02,"ASRC",LEXSAB,LEXSIEN))
 . Q:$P($G(^LEX(757.02,LEXSIEN,0)),"^",7)'>0
 . S LEXCD=$P($G(^LEX(757.02,+LEXSIEN,0)),"^",2) Q:'$L(LEXCD)
 . S LEXEF=$O(^LEX(757.02,LEXSIEN,4,"B",(9999999+.001)),-1) Q:'$L(LEXEF)
 . S LEXA(LEXEF,LEXCD)=""
 S LEXEF=$O(LEXA((9999999+.001)),-1) Q:'$L(LEXEF) ""
 S LEX=$O(LEXA(LEXEF,""),-1) Q:'$L(LEX) ""
 Q LEX

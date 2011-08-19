RA97PST1 ;HINES/RVD - Radiology BI-RADS ;10/10/08
 ;;5.0;RADIOLOGY;**97**;March 16, 1998;Build 6
 ;
 ;
BIR(RAX,RALEX,RALEXDT,RALEXSO,RALEXS,RALEXC) ; Example of 'Silent' Lexicon Call
 ; Return List of Categories w/Lexicon Pointers
 ;
 ; Input Variables
 ;
 ;     RAX       Text to Search for (Optional)
 ;     
 ;     RALEX     Array name passed by Reference (Required)
 ;     
 ;     RALEXDT   Version Date (Optional, default TODAY) 
 ;     
 ;     RALEXSO   Coding System (file 757.03)  For the purposes
 ;             of patch LEX*2.0*55, this may be set to "BIR" 
 ;             or <null>  (Optional)
 ;         
 ;     RALEXS    Source of terminology (file 757.14)  For the
 ;             purposes of patch LEX*2.0*55, this may be set 
 ;             to "BI-RADS" or "MQSA"  (Optional)
 ;         
 ;               BI-RADS = Breast Imaging Reporting & Data System 
 ;               MQSA    = Mammography Quality Standards Act
 ;         
 ;     RALEXC    Source Category of the terminology (file 757.13)
 ;             Frequently a terminology is broken down into 
 ;             categories (example, MRI, Ultrasound and/or 
 ;             Mammography)  For the purposes of patch 
 ;             LEX*2.0*55, this is set to "MAMMOGRAPHY 
 ;             ASSESSMENT CATEGORIES"  (Optional)
 ;              
 ; Output Variables
 ;              
 ;     RALEX(0)  Number of entries
 ;     RALEX(#)  Lexicon IEN ^ Text (term) ^ Code
 ;     LEX       ICR 2950
 ;
 ; NOTE:  This API mimics code found in CPRS
 ;              
 ; Global Variables
 ;    ^TMP("LEXFND")      ICR   2950
 ;    ^TMP("LEXHIT")      ICR   2950
 ;    ^TMP("LEXSCH")      ICR   1609
 ;               
 ; External References
 ;    LOOK^LEXA           ICR   2950
 ;    CONFIG^LEXSET       ICR   1609
 ;    $$DT^XLFDT          ICR  10103
 ;    SO^LEXA             ICR   5386
 ;              
 N DIC,RALEXA,RALEXCAT,RALEXCN,RALEXCT,RALEXI,RALEXIEN,RALEXSRC,RALEXSUB,RALEXT,RALEXVDT
 N RALEXX S RALEXSUB="WRD" S:$G(RALEXSO)="BIR" RALEXSUB="BI1"
 S (RAX,RALEXX)=$G(RAX) S:'$L(RALEXX) RALEXX="BIRAD" S RALEXVDT=$E($G(RALEXDT),1,7)
 S:+RALEXVDT'>0!(RALEXVDT'?7N)!(RALEXVDT<3030101) RALEXVDT=$$DT^XLFDT
 S:$L($G(RALEXS)) RALEXSRC=$G(RALEXS) S:$L($G(RALEXC)) RALEXCAT=$G(RALEXC)
 K ^TMP("LEXSCH",$J) D CONFIG^LEXSET(RALEXSUB,"WRD",RALEXVDT)
 S RALEXSUB="WRD" S:$G(RALEXSO)="BIR" RALEXSUB="BI1" S ^TMP("LEXSCH",$J,"DIS",0)="BIR",^TMP("LEXSCH",$J,"LEN",0)=100
 K DIC("S"),^TMP("LEXSCH",$J,"FIL",0)
 S:$L($G(RALEXSO)) (DIC("S"),^TMP("LEXSCH",$J,"FIL",0))="I +($$SO^LEXU(Y,"""_RALEXSO_""",+($G(RALEXVDT))))>0"
 D LOOK^LEXA(RALEXX,RALEXSUB,100,"",RALEXVDT,$G(RALEXSRC),$G(RALEXCAT))
 K ^TMP("LEXSCH",$J),^TMP("LEXFND",$J),^TMP("LEXHIT",$J)
 S RALEXI=0 F  S RALEXI=$O(LEX("LIST",RALEXI)) Q:+RALEXI'>0  D
 . N RALEXIEN,RALEXT,RALEXE,RALEXCT,RALEXCN,RALEXN
 . S RALEXT=$G(LEX("LIST",RALEXI)),RALEXIEN=+RALEXT Q:RALEXIEN'>0
 . S (RALEXE,RALEXT)=$P(RALEXT,"^",2) Q:'$L(RALEXE)
 . S RALEXN=$O(RALEXA(" "),-1)+1,RALEXCN=+($E($P(RALEXT,"Category ",2),1)),RALEXCT="Category "_RALEXCN S:RALEXE["(BI" RALEXE=$P(RALEXE,"(BI",1) S:RALEXE[" *" RALEXE=$P(RALEXE," *",1)
 . S RALEXCN=+RALEXCN+1 S:$G(RALEXSO)="BIR" RALEXA(RALEXCN)=RALEXIEN_"^"_RALEXE_"^"_RALEXCT S:$G(RALEXSO)'="BIR" RALEXA(RALEXN)=RALEXIEN_"^"_RALEXT
 S:+($O(RALEXA(" "),-1))>0 RALEXA(0)=+($O(RALEXA(" "),-1)) K LEX S (RALEXCT,RALEXI)=0 F  S RALEXI=$O(RALEXA(RALEXI)) Q:+RALEXI'>0  D
 . Q:'$L($G(RALEXA(RALEXI)))  S RALEXCT=RALEXCT+1,RALEX(RALEXCT)=$G(RALEXA(RALEXI)),RALEX(0)=RALEXCT
 Q

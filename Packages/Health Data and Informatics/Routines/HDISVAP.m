HDISVAP ;ALB/RMO,BPFO/JRM - Application Programmer API(s); 4/23/15@13:25:00 ; 4/23/15 1:25pm
 ;;1.0;HEALTH DATA & INFORMATICS;**2,14**;Feb 22, 2005;Build 22
 ;
NTRTMSG(HDISARYF,HDISARY) ;New Term Rapid Turnaround (NTRT) Message
 ; Input  -- HDISARYF Return Text in an Array Flag  (Optional- Default 0)
 ;                    1=Yes and 0=No
 ; Output -- HDISARY  If requested, an array containing the NTRT Message is returned otherwise
 ;                    the message is displayed on the screen.  The Output variable is assumed
 ;                    to be Null when the API is invoked.
 ; Notes  -- Use of this supported API is covered by ICR 4638
 N HDISLNE,HDISTXT
 F HDISLNE=1:1 S HDISTXT=$P($T(MSG+HDISLNE),";;",2) Q:HDISTXT="END"  D
 . I $G(HDISARYF) D
 . . S HDISARY(HDISLNE)=HDISTXT
 . ELSE  D
 . . W !?3,HDISTXT
 Q
 ;
LOSVUID(CODE) ;Convert Lab's Organism Screen set of codes to VUID
 ; Input: Code - Code representing organism screen
 ;Output: VUID - VUID for input code
 ;        NULL returned on bad input
 ; Notes: Use of this supported API is covered by ICR 4801
 ;      : This API is only to be used to determine the VUID for the
 ;        Organism Screen fields that a site may add to the Organism
 ;        multiple (subfile #63.3) in the Microbiology multiple
 ;        (subfile #63.05) of the Lab Data file (#63) via the option
 ;        LRWU7 [Add a new internal name for an antibiotic]
 ;
 N RSLT
 S CODE=$G(CODE)
 S RSLT=$S(CODE="A":4500665,CODE="N":4500805,CODE="R":4500877,1:"")
 Q RSLT
 ;
LOSCODE(VUID) ;Convert Lab's Organism Screen VUID to set of codes
 ;Input: VUID - VUID representing organism screen
 ;Output: Code - Code for input VUID
 ;        NULL returned on bad input
 ; Notes: Use of this supported API is covered by ICR 4801
 ;      : This API is only to be used to determine the code for the
 ;        Organism Screen fields that a site may add to the Organism
 ;        multiple (subfile #63.3) in the Microbiology multiple
 ;        (subfile #63.05) of the Lab Data file (#63) via the option
 ;        LRWU7 [Add a new internal name for an antibiotic]
 ;
 N RSLT
 S VUID=$G(VUID)
 S RSLT=$S(VUID=4500665:"A",VUID=4500805:"N",VUID=4500877:"R",1:"")
 Q RSLT
 ;
MFSEXIT ;Invoke code to update file implementation status
 ;from MFS event driver protocol exit action
 ; Input  -- ^TMP("XUMF EVENT",$J
 ; Output -- None
 N HDISERFN,HDISFILN
 ;Check for an error in MFS, if error get file number being
 ;processed at time of error
 I $D(^TMP("XUMF EVENT",$J,"ERROR",1)) S HDISERFN=+$P(^(1),"^",1)
 ;Loop through MFS event array,update status
 S HDISFILN=0
 F  S HDISFILN=$O(^TMP("XUMF EVENT",$J,HDISFILN)) Q:'HDISFILN  D
 . I HDISFILN'=$G(HDISERFN) D MFSUP^HDISVF09(HDISFILN,0)
 ;Check for error file number, update status
 I $G(HDISERFN)>0 D MFSUP^HDISVF09(HDISERFN,1)
 Q
 ;
MSG ;NTRT message text
 ;;
 ;;In support of national standardization of the contents of this file,
 ;;local site addition and modification functions are no longer available.
 ;;If you wish to contact Standards & Terminology Services (STS), request
 ;;a new term, or modify an existing term, please refer to the New
 ;;Term Rapid Turnaround (NTRT) web site located at
 ;;http://vista.domain.ext/ntrt/.
 ;;
 ;;END

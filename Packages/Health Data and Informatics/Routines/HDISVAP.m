HDISVAP ;ALB/RMO,BPFO/JRM - Application Programmer API(s); 2/11/05@9:10:00
 ;;1.0;HEALTH DATA & INFORMATICS;**2**;Feb 22, 2005
 ;
NTRTMSG(HDISARYF,HDISARY) ;New Term Rapid Turnaround (NTRT) Message
 ; Input  -- HDISARYF Return Text in an Array Flag  (Optional- Default 0)
 ;                    1=Yes and 0=No
 ; Output -- HDISARY  If requested, an array containing the NTRT Message is returned otherwise
 ;                    the message is diplayed on the screen.  The Output variable is assumed
 ;                    to be Null when the API is invoked.
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
 ; Notes: This API is only to be used to determine the VUID for the
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
 ; Notes: This API is only to be used to determine the code for the
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
MSG ;NTRT message text
 ;;
 ;;In support of national standardization of the contents of this file,
 ;;local site addition and modification functions are no longer available.
 ;;If you wish to request a new term or modify an existing term, please
 ;;refer to the New Term Rapid Turnaround (NTRT) web site located at
 ;;http://vista.med.va.gov/ntrt/.  If you have any questions regarding this 
 ;;new term request process, please contact the ERT NTRT Coordinator 
 ;;via e-mail at VHA OI SDD HDS NTRT.
 ;;
 ;;END

VAQDBIP2 ;ALB/JRP - PDX EXTRACTION UTILITY;16-MAR-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
XTRCT(INFOLINE,DFN,RXIFN,ARRAY,ENCPTR,KEY1,KEY2) ;EXTRACT INFORMATION
 ;INPUT  : INFOLINE - Line containing information to extract
 ;         DFN - Pointer to patient in PATIENT file
 ;         RXIFN - Pointer to prescription in PRESCRIPTION file
 ;         ARRAY - Extraction array (full global reference)
 ;         ENCPTR - Pointer to VAQ - ENCRYPTION METHOD file (optional)
 ;                  (only used if encryption will be done)
 ;         KEY1 - Primary encryption key
 ;                (only required if ENCPTR passed)
 ;         KEY2 - Secondary encryption key
 ;                (only required if ENCPTR passed)
 ;OUTPUT : 0 - Extraction was successfull
 ;             Information stored in extraction array
 ;        -1^Error_Text - Extraction was not successfull
 ;NOTES  : INFOLINE is in the format
 ;  <TAB>;;File;Field,Field,...,Field;Multiple Limit;Reverse Order Mult
 ;       : 'Multiple Limit' is the number of multiples to extract
 ;         (defaults to all)
 ;       : If 'Reverse Order Mult' contains a value other than 0,
 ;         multiples will be extracted in reverse order (last in
 ;         first out).  If it does not have a value or is 0,
 ;         multiples will be extracted in normal fashion (first in
 ;         first out).
 ;
 ;CHECK INPUT
 Q:($G(INFOLINE)="") "-1^Did not pass info line"
 Q:($G(DFN)="") "-1^Did not pass pointer to PATIENT file"
 S RXIFN=$G(RXIFN)
 S ENCPTR=+$G(ENCPTR)
 S KEY1=$G(KEY1)
 S KEY2=$G(KEY2)
 I (ENCPTR) Q:((KEY1="")!(KEY2="")) "-1^Did not pass both encription keys"
 ;DECLARE VARIABLES
 N TMP,FILE,FIELDS,MAINFILE,MAINFLD,GLOBAL,NODE,STRING
 N WORDPROC,ENTRY,ERROR,MULTLIM,COUNT,MULTREV,ENCRYPT
 N DIC,DR,DA,DIQ,SEQUENCE,ID,RXNUM,PATNAME,FIELD,ENCSTR
 ;SAFE GUARD DELETION OF UTILITY GLOBAL
 K ^UTILITY("DIQ1",$J)
 ;GET ENCRYPTION METHOD
 S TMP="STRING"
 S:(ENCPTR) TMP=$$ENCMTHD^VAQUTL2(ENCPTR,0)
 Q:((ENCPTR)&(TMP="")) "-1^Could not determine encryption method"
 S ENCRYPT="S ENCSTR="_TMP
 ;GET PATIENT'S NAME
 S TMP=$$PATINFO^VAQUTL1(DFN)
 S STRING=$P(TMP,"^",1)
 Q:(STRING="-1") "-1^Could not determine patient's name"
 ;ENCRYPT
 S ENCSTR=STRING
 I $$NCRPFLD^VAQUTL2(2,.01) X ENCRYPT
 S PATNAME=ENCSTR
 ;GET RX #
 I (RXIFN'="") D
 .S DIC="^PSRX("
 .S DR=.01
 .S DA=RXIFN
 .S DIQ(0)="E"
 .D EN^DIQ1
 .S STRING=$G(^UTILITY("DIQ1",$J,52,RXIFN,.01,"E"))
 .;ENCRYPT
 .S ENCSTR=STRING
 .I $$NCRPFLD^VAQUTL2(52,.01) X ENCRYPT
 .S RXNUM=ENCSTR
 .;TESTING OF RESULT DONE IF NEEDED LATER ON
 .K ^UTILITY("DIQ1",$J)
 S ERROR=0
 S FILE=$P(INFOLINE,";",3)
 S FIELDS=$P(INFOLINE,";",4)
 S MULTLIM=$P(INFOLINE,";",5)
 S MULTREV=$P(INFOLINE,";",6)
 ;CHECK FOR MULTIPLE
 S MAINFILE=$G(^DD(FILE,0,"UP"))
 ;CHECK FOR WORD-PROCESSING FIELD
 S WORDPROC=$F($P($G(^DD(FILE,.01,0)),"^",2),"W")
 ;NON-MULTIPLE
 I (MAINFILE="") D  Q ERROR
 .I ((FILE=52)&(RXIFN="")) S ERROR="-1^Pointer to PRESCRIPTION file not passed" Q
 .S DIC=FILE
 .S DR=$TR(FIELDS,",",";")
 .S DA=$S(FILE=52:RXIFN,1:DFN)
 .S DIQ(0)="E"
 .K ^UTILITY("DIQ1",$J)
 .D EN^DIQ1
 .;STORE IN EXTRACTION ARRAY
 .F TMP=1:1:$L(FIELDS,",") D
 ..S FIELD=$P(FIELDS,",",TMP)
 ..S SEQUENCE=$$GETSEQ^VAQDBIP(ARRAY,FILE,FIELD)
 ..;DETERMINE IDENTIFIER
 ..S ID=PATNAME
 ..S:((FILE=52)&(FIELD'=.01)) ID=RXNUM
 ..S STRING=$G(^UTILITY("DIQ1",$J,FILE,DA,FIELD,"E"))
 ..;ENCRYPT
 ..S ENCSTR=STRING
 ..I $$NCRPFLD^VAQUTL2(FILE,FIELD) X ENCRYPT
 ..S @ARRAY@("VALUE",FILE,FIELD,SEQUENCE)=ENCSTR
 ..S @ARRAY@("ID",FILE,FIELD,SEQUENCE)=ID
 .K ^UTILITY("DIQ1",$J)
 ;MULTIPLE
 I ((MAINFILE'="")&('WORDPROC)) D MLTPLE^VAQDBIP5 Q ERROR
 ;WORD-PROCESSING FIELD
 I ((MAINFILE'="")&(WORDPROC)) D WORD^VAQDBIP5 Q ERROR
 Q

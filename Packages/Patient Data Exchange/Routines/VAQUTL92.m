VAQUTL92 ;ALB/JFP,JRP - PDX TRANSACTION Lookup ;01-SEPT-93
 ;;1.5;PATIENT DATA EXCHANGE;**6,36**;NOV 17, 1993
 ;
TRNDATA(TRNPTR) ; -- Returns nodes in transaction file in local array NODE
 ;        INPUT: TRNPTR       = Pointer to VAQ - TRANSACTION FILE
 ;       OUTPUT: 0            = Success
 ;               see variable = 
 ;              -1^Reason   = Bad input
 ;
 ;         NOTE: Do KILLTRN to kill off variables created in this
 ;               function.
 ;
 Q:'(+$G(TRNPTR)) "-^Did not pass pointer to transaction file"
 ; -- Declare variables
 K NODE
 N ND,Y
 ; -- Main
 F ND=0,"QRY","ATHR1","ATHR2","RQST1","RQST2" D
 .S NODE(ND)=$G(^VAT(394.61,+TRNPTR,ND))
 ; -- Define variables
ZERO ; -- ZERO node
 S VAQTRN=$P(NODE(0),U,1)
 S VAQCSTAT=$P(NODE(0),U,2)
 S VAQPTPTR=$P(NODE(0),U,3)
 S VAQSENP=$P(NODE(0),U,4)
 S VAQRSTAT=$P(NODE(0),U,5)
QRY ; -- QRY node
 S VAQPTNM=$P(NODE("QRY"),U,1)
 S VAQISSN=$P(NODE("QRY"),U,2)
 S VAQESSN=$$DASHSSN^VAQUTL99(VAQISSN)
 S VAQIDOB=$P(NODE("QRY"),U,3)
 S VAQEDOB=$$DOBFMT^VAQUTL99(VAQIDOB)
 S VAQPTID=$P(NODE("QRY"),U,4)
RQST1 ; -- RQST1 node
 S Y=$P(NODE("RQST1"),U,1) X ^DD("DD") S VAQRDT=Y
 S VAQRPER=$P(NODE("RQST1"),U,2) ; person requesting
RQST2 ; -- RQST2 node
 S VAQRSITE=$P(NODE("RQST2"),U,1)
 S VAQRDOM=$P(NODE("RQST2"),U,2)
ATHR1 ; -- ATHR1 node
 S Y=$P(NODE("ATHR1"),U,1) X ^DD("DD") S VAQADT=Y
 S VAQAPER=$P(NODE("ATHR1"),U,2) ; person who released
ATHR2 ; -- ATHR2 node
 S VAQASITE=$P(NODE("ATHR2"),U,1)
 S VAQADOM=$P(NODE("ATHR2"),U,2)
 ; -- Clean up
 K NODE
 ; -- Success
 Q 0
 ;
KILLTRN ; -- Kills variables created in TRNDATA
 K VAQTRN,VAQCSTAT,VAQPTPTR,VAQSENP,VAQRSTAT
 K VAQPTNM,VAQISSN,VAQESSN,VAQIDOB,VAQEDOB,VAQPTID
 K VAQRDT,VAQRPER
 K VAQADT,VAQAPER
 K VAQASITE,VAQADOM
 K VAQRSITE,VAQRDOM
 QUIT
 ;
RLSEPAT(TRANPTR) ;GET INFO ON PATIENT RELEASED BY REMOTE FACILITY
 ;INPUT  : TRANPTR - Pointer to VAQ - TRANSACTION file (#394.61)
 ;OUTPUT : name^ssn^dob - Success
 ;           name = Name of patient at remote facility
 ;           ssn = Social security number of patient at remote facility
 ;                   (internal format -> without dashes)
 ;           dob = Date of birth of patient at remote facility
 ;                   (internal format -> FileMan)
 ;         "" - Error (no info found or bad input)
 ;
 ;CHECK INPUT
 Q:('$D(^VAT(394.61,(+$G(TRANPTR)),0))) ""
 ;DECLARE VARIABLES
 N TMP,SEGPTR,FIELD,DATAPTR,NAME,SSN,DOB,FOUND
 ;CHECK CURRENT STATUS - MAKE SURE DATA WAS RELEASED
 S TMP=$P($$STATYPE^VAQCON1(TRANPTR,1),"^",1)
 Q:((TMP'="VAQ-UNSOL")&(TMP'="VAQ-RSLT")) ""
 ;GET POINTER TO PDX*MIN SEGMENT
 S SEGPTR=+$O(^VAT(394.71,"C","PDX*MIN",0))
 Q:('SEGPTR) ""
 ;INITIALIZE OUTPUT VARIABLES
 S (NAME,SSN,DOB)=""
 ;FIND INFO IN DATA FILE
 S (DATAPTR,FOUND)=0
 F  S DATAPTR=+$O(^VAT(394.62,"A-SEGMENT",TRANPTR,SEGPTR,DATAPTR)) Q:('DATAPTR)  D  Q:(FOUND=3)
 .;VERIFY CORRECTNESS OF X-REF
 .Q:((+$G(^VAT(394.62,DATAPTR,"TRNS")))'=TRANPTR)
 .S TMP=$G(^VAT(394.62,DATAPTR,0))
 .Q:((+$P(TMP,"^",2))'=SEGPTR)
 .Q:((+$P(TMP,"^",5)))
 .;SEE IF ENTRY IS FOR NAME OR SSN OR DOB
 .Q:((+$P(TMP,"^",3))='2)
 .S FIELD=+$P(TMP,"^",4)
 .Q:((FIELD'=.01)&(FIELD'=.03)&(FIELD'=.09))
 .;ONLY ACCEPT FOR SEQUENCE NUMBER 0
 .Q:(+$G(^VAT(394.62,DATAPTR,"SQNCE")))
 .;GET VALUE, SET APPROPRIATE VARIABLE, AND INCREMENT FOUND COUNT
 .S TMP=$G(^VAT(394.62,DATAPTR,"VAL"))
 .I (FIELD=.01) S NAME=TMP,FOUND=FOUND+1 Q
 .I (FIELD=.03) S DOB=$$DATE^VAQUTL99(TMP) S:(DOB="-1") DOB="" S FOUND=FOUND+1 Q
 .I (FIELD=.09) S SSN=$TR(TMP,"-",""),FOUND=FOUND+1 Q
 ;RETURN RESULTS
 Q NAME_"^"_SSN_"^"_DOB

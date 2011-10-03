VAQPUR11 ;ALB/JRP - PURGING;15JUL93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
PRGCHK(POINTER,PRGDATE,SETPRGE) ;CHECK TO SEE IF TRANSACTION SHOULD BE PURGE
 ;INPUT  : POINTER - Pointer to transaction to check
 ;         PRGDATE - Date purging will be based on (FileMan format)
 ;         SETPRGE - Flag indicating if purge flag should be set
 ;                   when required data is not present
 ;                 If 0, don't set purge flag (default)
 ;                 If 1, set purge flag
 ;OUTPUT : 0 - Transaction does not require purging
 ;         1 - Transaction does require purging
 ;         2^0 - Required info for transaction was not present and
 ;               purge flag was not set
 ;         2^1 - Required info for transaction was not present and
 ;               purge flag has been set
 ;         2^-1 - Required info for transaction was not present and
 ;               purge flag could not be set
 ;         3 - Transaction was already flaged for purging
 ;        -1 - Error determing if transaction should be purged
 ;
 ;CHECK INPUT
 Q:('(+$G(POINTER))) -1
 Q:('(+$G(PRGDATE))) -1
 Q:('$D(^VAT(394.61,POINTER))) -1
 S SETPRGE=+$G(SETPRGE)
 ;DECLARE VARIABLES
 N NUMBER,CURTYPE,RELTYPE,NAME,SSN,RQSTDATE
 N ATHRDATE,SEGS,X1,X2,X,%Y,TMP,FLAG,RQSTOLD,ATHROLD
 S FLAG=0
 ;CHECK PURGE FLAG
 Q:($D(^VAT(394.61,"PURGE",1,POINTER))) 3
 ;GET REQUIRED INFORMATION
 ;TRANSACTION NUMBER
 S NUMBER=+$G(^VAT(394.61,POINTER,0))
 ;CURRENT TYPE
 S CURTYPE=""
 S TMP=$$STATYPE^VAQCON1(POINTER,1)
 S:($P(TMP,"^",1)'="-1") CURTYPE=$P(TMP,"^",2)
 ;RELEASE TYPE
 S RELTYPE=""
 S TMP=$$STATYPE^VAQCON1(POINTER,0)
 S:($P(TMP,"^",1)'="-1") RELTYPE=$P(TMP,"^",2)
 ;PATIENT NAME & SSN
 S TMP=$G(^VAT(394.61,POINTER,"QRY"))
 S NAME=$P(TMP,"^",1)
 S SSN=$P(TMP,"^",2)
 ;REQUEST DATE
 S RQSTDATE=+$P($G(^VAT(394.61,POINTER,"RQST1")),"^",1)
 ;AUTHORIZE DATE
 S ATHRDATE=+$P($G(^VAT(394.61,POINTER,"ATHR1")),"^",1)
 ;SEGMENTS
 S SEGS=+$O(^VAT(394.61,POINTER,"SEG",0))
 ;CHECK REQUIRED INFO
 S:('NUMBER) FLAG=1
 S:((CURTYPE="")&(RELTYPE="")) FLAG=1
 S:((NAME="")&(SSN="")) FLAG=1
 S:(('ATHRDATE)&('RQSTDATE)) FLAG=1
 I ('RQSTDATE) D
 .S TMP="^REQ^ACK^RES^"
 .S X="^"_CURTYPE_"^"
 .S:(TMP[X) FLAG=1
 I ('ATHRDATE) D
 .S TMP="^UNS^RES^"
 .S X="^"_CURTYPE_"^"
 .S:(TMP[X) FLAG=1
 S:('SEGS) FLAG=1
 ;CHECK REQUEST & AUTHORIZE DATES AGAINST PURGE DATE
 S X1=PRGDATE
 S X2=RQSTDATE
 D ^%DTC
 S X=+$G(X)
 S RQSTOLD=$S(((X=0)!(X>0)):1,1:0)
 S X1=PRGDATE
 S X2=ATHRDATE
 D ^%DTC
 S X=+$G(X)
 S ATHROLD=$S(((X=0)!(X>0)):1,1:0)
 ;CHECK FOR ERROR DURING MESSAGE RECEIPT (CONSIDERD REQUIRED INFO)
 I (CURTYPE="REC") D
 .;NO REQUEST DATE BUT AUTHORIZE DATE OLDER THAN PURGE DATE
 .I (('RQSTDATE)&(ATHROLD)) S FLAG=1 Q
 .;NO AUTHORIZE DATE BUT REQUEST DATE OLDER THAN PURGE DATE
 .I (('ATHRDATE)&(RQSTOLD)) S FLAG=1 Q
 ;REQUIRED INFORMATION WAS NOT ALL PRESENT
 I (FLAG) D  Q TMP
 .;DON'T FLAG FOR PURGING
 .I ('SETPRGE) S TMP="2^0" Q
 .;FLAG FOR PURGING
 .S TMP=+$$FILEINFO^VAQFILE(394.61,POINTER,90,"YES")
 .S TMP="2^"_$S(('TMP):"1",1:"-1")
 ;REQUEST & AUTHORIZE DATES BOTH OLDER THAN PURGE DATE
 Q:((RQSTOLD)&(ATHROLD)) 1
 ;DON'T PURGE
 Q 0

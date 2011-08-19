VAQUTL3 ;ALB/JRP - UTILITY ROUTINES;30-APR-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
TRANENC(TRAN,RET) ;DETERMINE IF ENCRYPTION FOR A TRANSACTION IS TURNED ON
 ;INPUT  : TRAN - Pointer to VAQ - TRANSACTION file
 ;         RET - Flag indicating what to return
 ;               0 = Return 1 if encryption is on   (default flag)
 ;                   Return 0 if encryption is off
 ;               1 = Return pointer to VAQ - ENCRYPTION METHOD file
 ;                   Return 0 if encryption is off
 ;               2 = Return encryption method
 ;                   Return NULL if encryption is off
 ;               3 = Return type of encryption
 ;                   Return NULL if encryption is off
 ;OUTPUT : See definition of RET
 ;NOTES  : Existance of VAQIGNC will be checked.  If it exists and is
 ;         set to 1 encryption will be ignored for this transaction.
 ;       : If encryption is on and the transaction does not include
 ;         an encryption method, the default encryption method will
 ;         be used.
 ;       : Encryption off will be returned on error.
 ;
 ;CHECK INPUT
 S RET=+$G(RET)
 Q:('(+$G(TRAN))) $S((RET>1):"",1:0)
 Q:('$D(^VAT(394.61,TRAN))) $S((RET>1):"",1:0)
 ;CHECK VAQIGNC
 Q:($G(VAQIGNC)) $S((RET>1):"",1:0)
 ;DECLARE VARIABLES
 N TMP,MTHD
 ;CHECK ENCRYPTION FIELD
 S TMP=$G(^VAT(394.61,TRAN,"NCRPT"))
 S MTHD=+$P(TMP,"^",2)
 S TMP=+TMP
 ;ENCRYPTION OFF
 Q:('TMP) $S((RET>1):"",1:0)
 ;RETURN ENCRYPTION ON
 Q:('RET) 1
 ;ENCRYPTION METHOD NOT THERE
 I ('MTHD) D  Q MTHD
 .S TMP=$S((RET=2):0,1:1)
 .S MTHD=$$DEFENC^VAQUTL2(0,TMP)
 .Q:(RET'=3)
 .I ('MTHD) S MTHD="" Q
 .S MTHD=$P($G(^VAT(394.72,MTHD,0)),"^",1)
 ;RETURN POINTER
 Q:(RET=1) MTHD
 ;RETURN METHOD
 Q:(RET=2) $$ENCMTHD^VAQUTL2(MTHD,0)
 ;RETURN TYPE
 Q:(RET=3) $P($G(^VAT(394.72,MTHD,0)),"^",1)
 ;
DUZKEY(USER,PRIME) ;DETERMINE PRIMARY/SECONDARY KEY VALUES
 ;INPUT  : USER - Pointer to NEW PERSON file (defaults to DUZ)
 ;         PRIME - Indicates which key to return
 ;           If 1, returns primary key
 ;           If 0, returns secondary key (default)
 ;OUTPUT : The primary/secondary key value
 ;         NULL - Error
 ;
 ;CHECK INPUT
 S:('(+$G(USER))) USER=+$G(DUZ)
 S PRIME=+$G(PRIME)
 ;DECLARE VARIABLES
 N X,Y
 ;DETERMINE KEYS
 S X=$P($G(^VA(200,USER,0)),"^",1)
 Q:(X="") ""
 S:((USER=.5)!(X="POSTMASTER")) X="PDX Server"
 D:('PRIME) HASH^XUSHSHP
 X ^%ZOSF("LPC")
 Q Y
 ;
NAMEKEY(USER,PRIME) ;DETERMINE PRIMARY/SECONDARY KEY VALUES
 ;INPUT  : USER - Name of user (defaults to current user)
 ;         PRIME - Indicates which key to return
 ;           If 1, returns primary key
 ;           If 0, returns secondary key (default)
 ;OUTPUT : The primary/secondary key value
 ;         NULL - Error
 ;
 ;CHECK INPUT
 I ($G(USER)="") S USER=+$G(DUZ) Q:(USER="")  S USER=$P($G(^VA(200,USER,0)),"^",1)
 Q:(USER="") ""
 S PRIME=+$G(PRIME)
 ;DECLARE VARIABLES
 N X,Y
 ;DETERMINE KEYS
 S X=USER
 S:(X="POSTMASTER") X="PDX Server"
 Q:(X="") ""
 D:('PRIME) HASH^XUSHSHP
 X ^%ZOSF("LPC")
 Q Y

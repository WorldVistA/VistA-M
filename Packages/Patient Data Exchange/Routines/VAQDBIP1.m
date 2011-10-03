VAQDBIP1 ;ALB/JRP - PHARMACY EXTRACTION;16-MAR-93
 ;;1.5;PATIENT DATA EXCHANGE;**31**;NOV 17, 1993
RXXTRCT(TRAN,DFN,ARRAY,CUTOFF) ;EXTRACT PHARMACY INFORMATION
 ;INPUT  : TRAN - Pointer to VAQ - TRANSACTION file
 ;          DFN - Pointer to patient in PATIENT file
 ;         ARRAY - Where to store information (full global reference)
 ;         CUTOFF - Number of days to cut off expired/canceled RXs
 ;                  (defaults to 90)
 ;OUTPUT : 0 - Extraction was successfull
 ;        -1^Error_Text - Extraction was not successfull
 ;NOTE   : If the pharmacy information can not be extracted,
 ;         the "VALUE" and "ID" nodes in ARRAY will be deleted.
 ;       : If TRAN is passed
 ;           The patient pointer of the transaction will be used
 ;           Encryption will be based on the transaction
 ;         If DFN is passed
 ;           Encryption will be based on the site parameter
 ;       : Pointer to transaction takes precedence over DFN ... if
 ;         TRAN>0 the DFN will be based on the transaction
 ;
 ;CHECK INPUT
 S TRAN=+$G(TRAN)
 S DFN=+$G(DFN)
 Q:(('TRAN)&('DFN)) "-1^Did not pass pointer to transaction or patient"
 I (TRAN) Q:('$D(^VAT(394.61,TRAN))) "-1^Did not pass valid pointer to VAQ - TRANSACTION file"
 I (TRAN) S DFN=+$P($G(^VAT(394.61,TRAN,0)),"^",3) Q:('DFN) "-1^Transaction did not contain pointer to PATIENT file"
 Q:('$D(^DPT(DFN))) "-1^Did not pass valid pointer to PATIENT file"
 Q:($G(ARRAY)="") "-1^Did not pass output array"
 S:('$D(CUTOFF)) CUTOFF=90
 S CUTOFF=+$G(CUTOFF)
 ;DECLARE VARIABLES
 N TMP,LOOP,ERROR,X1,X2,X,CUTDATE,RXIFN,SEQ,ENCRYPT,DECRYPT
 N J,RX0,RX2,RX3,ST,ST0,ZII,Y,%DT,GMRAL,GMRA,ENCSTR
 N DECSTR,STRING,ENCPTR,KEY1,KEY2,SENDER
 S ERROR=0
 ;DETERMINE IF ENCRYPTION IS ON - SAVE POINTER TO ENCRYPTION METHOD
 S:('TRAN) ENCPTR=$$NCRYPTON^VAQUTL2(0)
 S:(TRAN) ENCPTR=$$TRANENC^VAQUTL3(TRAN,1)
 ;SET UP EXECUTABLE CALL TO ENCRYPT
 S:(ENCPTR) ENCRYPT=$$ENCMTHD^VAQUTL2(ENCPTR,0)
 S:('ENCPTR) ENCRYPT=""
 S:(ENCRYPT'="") ENCRYPT=("S ENCSTR="_ENCRYPT)
 S:(ENCRYPT="") ENCRYPT="S ENCSTR=STRING"
 ;SET UP EXECUTABLE CALL TO DECRYPT
 S:(ENCPTR) DECRYPT=$$ENCMTHD^VAQUTL2(ENCPTR,1)
 S:('ENCPTR) DECRYPT=""
 S:(DECRYPT'="") DECRYPT=("S DECSTR="_DECRYPT)
 S:(DECRYPT="") DECRYPT="S DECSTR=STRING"
 ;DETERMINE PRIMARY KEY
 I (TRAN) S SENDER=$$SENDER^VAQCON2(TRAN) Q:($P(SENDER,"^",1)="-1") "-1^Could not determine encryption keys"
 S:(TRAN) SENDER=$P(SENDER,"^",1)
 S:(TRAN) KEY1=$$NAMEKEY^VAQUTL3(SENDER,1)
 S:('TRAN) KEY1=$$DUZKEY^VAQUTL3($G(DUZ),1)
 ;DETERMINE SECONDARY KEY
 S:(TRAN) KEY2=$$NAMEKEY^VAQUTL3(SENDER,0)
 S:('TRAN) KEY2=$$DUZKEY^VAQUTL3($G(DUZ),0)
 I (ENCPTR) Q:((KEY1="")!(KEY2="")) "-1^Could not determine encryption keys"
 ;EXTRACT NON-PRESCRIPTION INFO
 F LOOP=1:1 D  Q:(ERROR)
 .S TMP=$T(RXPAT+LOOP^VAQDBII1)
 .I ($P(TMP,";;",2)="") S ERROR=1 Q
 .S ERROR=$$XTRCT^VAQDBIP2(TMP,DFN,"",ARRAY,ENCPTR,KEY1,KEY2)
 .I ERROR D  Q
 ..S TMP=$$KILLARR^VAQUTL1(ARRAY,"VALUE")
 ..S TMP=$$KILLARR^VAQUTL1(ARRAY,"ID")
 Q:(ERROR<0) ERROR
 ;EXTRACT ALLERGIES & ADVERSE REACTIONS
 ;(LOCATION OF INFO IS IN TRANSITION; USE SUPPORTED CALL)
 S GMRA="0^0^111"
 D EN1^GMRADPT
 ;MOVE ALLERGIES & REACTIONS INTO EXTRACTION ARRAY
 S ERROR=0
 I $D(GMRAL) D
 .;PATIENT IS IDENTIFIER
 .S ERROR=$$PATINFO^VAQUTL1(DFN)
 .S STRING=$P(ERROR,"^",1)
 .Q:(STRING="-1")
 .;ENCRYPT PATIENT NAME
 .S ENCSTR=STRING
 .I $$NCRPFLD^VAQUTL2(2,.01) X ENCRYPT
 .S TMP=ENCSTR
 .S ERROR=0
 .; Before GMRA*4*10, if patient had NKA (no known allergies) EN1^GMRADPT
 .; returned GMRAL=0 and GMRAL(<ptr to file 120.8>)=DFN_"^NKA^0^1"
 .; After that patch, it just returned GMRAL=0.  So we must dummy up
 .; the missing array element to make this routine work as it had before.
 .I GMRAL=0,'$O(GMRAL(0)) S GMRAL(1)="^NKA" ; VAQ*1.5*31
 .S GMRA=""
 .F SEQ=0:1 D  Q:(GMRA="")
 ..S GMRA=$O(GMRAL(GMRA))
 ..Q:(GMRA="")
 ..S J=$P(GMRAL(GMRA),"^",2)
 ..Q:(J="")
 ..;ENCRYPT VALUE
 ..S STRING=J
 ..S ENCSTR=STRING
 ..I $$NCRPFLD^VAQUTL2(120.8,.02) X ENCRYPT
 ..;STORE INFORMATION
 ..S @ARRAY@("VALUE",120.8,.02,SEQ)=ENCSTR
 ..S @ARRAY@("ID",120.8,.02,SEQ)=TMP
 I ERROR D  Q ERROR
 .S TMP=$$KILLARR^VAQUTL1(ARRAY,"VALUE")
 .S TMP=$$KILLARR^VAQUTL1(ARRAY,"ID")
 ;EXTRACT PRESCRIPTION INFORMATION
 D SCRIPTS^VAQDBIP8
 I ERROR D  Q ERROR
 .S TMP=$$KILLARR^VAQUTL1(ARRAY,"VALUE")
 .S TMP=$$KILLARR^VAQUTL1(ARRAY,"ID")
 Q 0

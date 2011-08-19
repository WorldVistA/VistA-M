VAQDBIP4 ;ALB/JRP - MAS (REGISTRATION) INFO EXTRACTION;22-MAR-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
MASXTRCT(TRAN,DFN,ARRAY) ;EXTRACT MAS (REGISTRATION) INFO (EXTRACTION ARRAY)
 ;INPUT  : TRAN - Pointer to VAQ - TRANSACTION file
 ;         DFN - Pointer to patient in PATIENT file
 ;         ARRAY - Where to store information (full global reference)
 ;OUTPUT : 0 - Extraction was successful
 ;        -1^Error_Text - Extraction was not successful
 ;NOTES  : If the MAS (Registration) information can not be extracted,
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
 ;DECLARE VARIABLES
 N ERROR,TMP,LOOP,DIC,DA,DR,DIQ,FLDS,SEQ,X,Y,Z,NAME
 N ENCRYPT,ENCSTR,KEY1,KEY2,STRING,PRIME,ENCPTR,SENDER
 S ERROR=0
 ;DETERMINE IF ENCRYPTION IS ON - SAVE POINTER TO ENCRYPTION METHOD
 S:('TRAN) ENCPTR=$$NCRYPTON^VAQUTL2(0)
 S:(TRAN) ENCPTR=$$TRANENC^VAQUTL3(TRAN,1)
 ;SET UP EXECUTABLE CALL TO ENCRYPT
 S:(ENCPTR) ENCRYPT=$$ENCMTHD^VAQUTL2(ENCPTR,0)
 S:('ENCPTR) ENCRYPT=""
 S:(ENCRYPT'="") ENCRYPT=("S ENCSTR="_ENCRYPT)
 S:(ENCRYPT="") ENCRYPT="S ENCSTR=STRING"
 ;DETERMINE PRIMARY KEY
 I (TRAN) S SENDER=$$SENDER^VAQCON2(TRAN) Q:($P(SENDER,"^",1)="-1") "-1^Could not determine encryption keys"
 S:(TRAN) SENDER=$P(SENDER,"^",1)
 S:(TRAN) KEY1=$$NAMEKEY^VAQUTL3(SENDER,1)
 S:('TRAN) KEY1=$$DUZKEY^VAQUTL3($G(DUZ),1)
 ;DETERMINE SECONDARY KEY
 S:(TRAN) KEY2=$$NAMEKEY^VAQUTL3(SENDER,0)
 S:('TRAN) KEY2=$$DUZKEY^VAQUTL3($G(DUZ),0)
 I (ENCPTR) Q:((KEY1="")!(KEY2="")) "-1^Could not determine encryption keys"
 ;EXTRACT INFORMATION
 F LOOP=1:1 D  Q:(ERROR)
 .S TMP=$T(MAS+LOOP^VAQDBII1)
 .I ($P(TMP,";;",2)="") S ERROR=1 Q
 .S ERROR=$$XTRCT^VAQDBIP2(TMP,DFN,"",ARRAY,ENCPTR,KEY1,KEY2)
 .I ERROR D  Q
 ..S TMP=$$KILLARR^VAQUTL1(ARRAY,"VALUE")
 ..S TMP=$$KILLARR^VAQUTL1(ARRAY,"ID")
 Q:(ERROR<0) ERROR
 ;EXTRACT OTHER ELIGIBILITIES
 D ELIG^VAQDBIP6
 ;EXTRACT APPOINTMENTS
 D APPOINT^VAQDBIP6
 ;EXTRACT DENTAL APPOINTMENTS
 D DENTAL^VAQDBIP6
 ;EXTRACT ACTIVE INSURANCES
 D INSURE^VAQDBIP7
 Q 0

VAQHSH ;ALB/JRP - ENCRYPT A DISPLAY ARRAY;29-MAR-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
ENCDSP(TRAN,ROOT,ENCPTR,DSPOFF,DSPCNT) ;ENCRYPT A DISPLAY
 ;INPUT  : TRAN - Pointer to VAQ - TRANSACTION file
 ;         ROOT - Where the Display Array is (full global reference)
 ;         ENCPTR - Pointer to VAQ - ENCRYPTION METHOD file
 ;         DSPOFF - Offset into Display Array to begin at
 ;                  Only used for Display Arrays (defaults to 0)
 ;         DSPCNT - Number of lines in Display Array
 ;                  Only used for Display Arrays (defaults to full array)
 ;OUTPUT : 0 - Success
 ;        -1^Error_Text - Error
 ;NOTES  : If TRAN>0
 ;           Encryption will be based on the transaction
 ;           Keys will come from the transaction
 ;         Else
 ;           Encryption will be based on ENCPTR
 ;           Keys based on current user
 ;       : Existance of TRAN takes precedence over ENCPTR
 ;
 ;CHECK INPUT
 S TRAN=+$G(TRAN)
 S ENCPTR=+$G(ENCPTR)
 Q:(('TRAN)&('ENCPTR)) "-1^Did not pass pointer to transaction or encryption method"
 I (TRAN) Q:('$D(^VAT(394.61,TRAN))) "-1^Did not pass valid pointer to VAQ - TRANSACTION file"
 I (TRAN) S ENCPTR=$$TRANENC^VAQUTL3(TRAN,1) Q:('ENCPTR) "-1^Transaction did not contain pointer to encryption method"
 Q:('ENCPTR) "-1^Did not pass encryption method"
 Q:($G(ROOT)="") "-1^Did not pass location of extracted segment"
 S DSPOFF=+$G(DSPOFF)
 S DSPCNT=+$G(DSPCNT)
 ;DECLARE VARIABLES
 N TMP,ENCMTHD,ENCSTR,STRING,KEY1,KEY2,ERROR,SEQ,SENDER
 S ERROR=0
 ;GET ENCRYPTION METHOD
 S TMP=$$ENCMTHD^VAQUTL2(ENCPTR,0)
 Q:(TMP="") "-1^Could not determine encryption method"
 S ENCMTHD="S ENCSTR="_TMP
 ;DETERMINE PRIMARY KEY
 I (TRAN) S SENDER=$$SENDER^VAQCON2(TRAN) Q:($P(SENDER,"^",1)="-1") "-1^Could not determine encryption keys"
 S:(TRAN) SENDER=$P(SENDER,"^",1)
 S:(TRAN) KEY1=$$NAMEKEY^VAQUTL3(SENDER,1)
 S:('TRAN) KEY1=$$DUZKEY^VAQUTL3($G(DUZ),1)
 ;DETERMINE SECONDARY KEY
 S:(TRAN) KEY2=$$NAMEKEY^VAQUTL3(SENDER,0)
 S:('TRAN) KEY2=$$DUZKEY^VAQUTL3($G(DUZ),0)
 Q:((KEY1="")!(KEY2="")) "-1^Could not determine encryption keys"
 ;LOOP THROUGH EACH LINE IN DISPLAY
 S TMP=DSPOFF-.999999999
 F SEQ=1:1 Q:((DSPCNT)&(SEQ>DSPCNT))  D  Q:((TMP="")!(ERROR))
 .S TMP=$O(@ROOT@("DISPLAY",TMP))
 .Q:(TMP="")
 .;GET LINE
 .S STRING=@ROOT@("DISPLAY",TMP,0)
 .;ENCRYPT LINE (DON'T ENCRYPT A NULL LINE)
 .Q:(STRING="")
 .X ENCMTHD
 .I (ENCSTR="") S ERROR="-1^Error using encryption method" Q
 .;STORE ENCRYPTED LINE
 .S @ROOT@("DISPLAY",TMP,0)=ENCSTR
 Q:(ERROR) ERROR
 Q 0

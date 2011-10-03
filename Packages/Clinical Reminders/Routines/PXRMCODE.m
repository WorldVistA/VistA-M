PXRMCODE ; SLC/PKR - Routines for handling standard coded items. ;06/05/2003
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 ;==================================================
VHICD0(DA,X) ;This is the input transform for ICD0 codes subfile 811.22103
 ;high code to make sure it is greater than the low code.
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q 1
 N VALID
 S VALID=$$VICD0(X)
 I 'VALID Q VALID
 ;Make sure the high code follows the low code.
 N LOW
 S LOW=$P(^PXD(811.2,DA(1),80.1,DA,0),U,1)
 S VALID=$S(X]LOW:1,X=LOW:1,1:0)
 I 'VALID D EN^DDIOL("The high code must be equal to or higher than the low code")
 Q VALID
 ;
 ;==================================================
VHICD9(DA,X) ;This is the input transform for ICD9 codes subfile 811.22102
 ;high code to make sure it is greater than the low code.
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q 1
 N VALID
 S VALID=$$VICD9(X)
 I 'VALID Q VALID
 ;Make sure the high code follows the low code.
 N LOW
 S LOW=$P(^PXD(811.2,DA(1),80,DA,0),U,1)
 S VALID=$S(X]LOW:1,X=LOW:1,1:0)
 I 'VALID D EN^DDIOL("The high code must be equal to or higher than the low code")
 Q VALID
 ;
 ;==================================================
VHICPT(DA,X) ;This is the input transform for ICPT codes subfile 811.22104
 ;high code to make sure it is greater than the low code.
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q 1
 N VALID
 S VALID=$$VICPT(X)
 I 'VALID Q VALID
 ;Make sure the high code follows the low code.
 N LOW
 S LOW=$P(^PXD(811.2,DA(1),81,DA,0),U,1)
 S VALID=$S(X]LOW:1,X=LOW:1,1:0)
 I 'VALID D EN^DDIOL("The high code must be equal to or higher than the low code")
 Q VALID
 ;
 ;==================================================
VICD0(X) ;This is the input transform for ICD0 codes, subfile 811.22102.
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q 1
 N RETVAL,TEMP,TEXT
 S RETVAL=$$CODE^PXRMVAL(X,80.1)
 I '(+RETVAL) D
 . S TEXT=X_"-"_$P(RETVAL,U,4)
 . D EN^DDIOL(TEXT)
 . S TEMP=$P(RETVAL,U,3)
 . S:$P(RETVAL,U,2)=$P(RETVAL,U,3) TEMP=""
 . I TEMP'="" D
 .. S TEXT="(Next code in the file is "_TEMP_")"
 .. D EN^DDIOL(TEXT)
 Q $P(RETVAL,U,1)
 ;
 ;==================================================
VICD9(X) ;This is the input transform for ICD9 codes subfile 811.22103.
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q 1
 N RETVAL,TEMP,TEXT
 S RETVAL=$$CODE^PXRMVAL(X,80)
 I '(+RETVAL) D
 . S TEXT=X_"-"_$P(RETVAL,U,4)
 . D EN^DDIOL(TEXT)
 . S TEMP=$P(RETVAL,U,3)
 . S:$P(RETVAL,U,2)=$P(RETVAL,U,3) TEMP=""
 . I TEMP'="" D
 .. S TEXT="(Next code in the file is "_TEMP_")"
 .. D EN^DDIOL(TEXT)
 Q $P(RETVAL,U,1)
 ;
 ;==================================================
VICPT(X) ;This is the input transform for CPT codes subfile 811.22104.
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q 1
 N RETVAL,TEMP,TEXT
 S RETVAL=$$CODE^PXRMVAL(X,81)
 I '(+RETVAL) D
 . S TEXT=X_"-"_$P(RETVAL,U,4)
 . D EN^DDIOL(TEXT)
 . S TEMP=$P(RETVAL,U,3)
 . S:$P(RETVAL,U,2)=$P(RETVAL,U,3) TEMP=""
 . I TEMP'="" D
 .. S TEXT="(Next code in the file is "_TEMP_")"
 .. D EN^DDIOL(TEXT)
 Q $P(RETVAL,U,1)
 ;

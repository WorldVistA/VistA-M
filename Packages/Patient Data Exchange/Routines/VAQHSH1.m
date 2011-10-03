VAQHSH1 ;ALB/JRP - ENCRYPT/DECRYPT ROUTINES;29-MAR-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
KRNLHASH(STRING,KEY1,KEY2,DCRYPT) ;ENCRYPT/DECRYPT USING KERNEL HASHING
 ;INPUT  : STRING - String to encrypt/decrypt
 ;         KEY1 - Primary key for encryption/decryption (numeric)
 ;                (defaults to the current value in DUZ)
 ;         KEY2 - Secondary key for encryption/decryption (numeric)
 ;                (defaults to 0)
 ;         DCRYPT - Flag indicating whether to encrypt or decrypt
 ;           If 0, encrypt STRING (default)
 ;           If 1, decrypt STRING
 ;OUTPUT : S - STRING encrypted/decrypted using KERNEL hashing
 ;         Null - Encryption/decryption not possible
 ;
 ;CHECK INPUT
 Q:('$D(STRING)) ""
 S:('$D(KEY1)) KEY1=+$G(DUZ)
 S:(KEY1'?1.N) KEY1=+$G(DUZ)
 S KEY2=+$G(KEY2)
 S DCRYPT=+$G(DCRYPT)
 ;DECLARE VARIABLES
 N X,X1,X2
 S X=STRING
 S X1=KEY1
 S X2=KEY2
 ;ENCRYPT
 I ('DCRYPT) D EN^XUSHSHP Q X
 ;DECRYPT
 D DE^XUSHSHP
 Q X

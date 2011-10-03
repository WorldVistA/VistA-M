VAQUTL2 ;ALB/JRP - UTILITY ROUTINES;30-APR-93
 ;;1.5;PATIENT DATA EXCHANGE;**5**;NOV 17, 1993
NCRYPTON(RETMTHD) ;DETERMINE IF ENCRYPTION HAS BEEN TURNED ON
 ;INPUT  : RETMTHD - Flag indicating what to return
 ;                   0 = Return pointer to default encryption (default)
 ;                       Return 0 if encryption is off
 ;                   1 = Return default encryption method
 ;                       Return NULL if encryption is off
 ;                   2 = Return default encryption type
 ;                       Return NULL if encryption is off
 ;OUTPUT : See definition of RETMTHD
 ;NOTES  : Existance of VAQIGNC will be checked.  If it exists and is
 ;         set to 1 encryption rules will be ignored.
 ;       : Encryption off will be returned on error
 ;
 ;CHECK INPUT
 S RETMTHD=+$G(RETMTHD)
 ;IGNORE FLAG TURNED ON
 I (+$G(VAQIGNC)) Q $S(RETMTHD:"",1:0)
 ;DECLARE VARIABLES
 N X,Y
 ;GET ENTRY IN PARAMETER FILE
 S X=$O(^VAT(394.81,0))
 ;COULDN'T FIND ENTRY IN PARAMETER - ASSUME ENCRYPTION IS OFF
 Q:('X) $S(RETMTHD:"",1:0)
 ;CHECK ENCRYPTION FLAG
 S Y=$G(^VAT(394.81,X,"ECR"))
 ;COULDN'T FIND ENCRYPTION FLAG - ASSUME ENCRYPTION IS OFF
 Q:('Y) $S(RETMTHD:"",1:0)
 ;ENCRYPTION TURNED ON
 S X=+$P(Y,"^",2)
 ;RETURN POINTER
 Q:('RETMTHD) X
 ;RETURN METHOD
 Q:(RETMTHD=1) $$ENCMTHD(X,0)
 ;RETURN TYPE
 Q $P($G(^VAT(394.72,X,0)),"^",1)
 ;
NCRPFLD(FILE,FIELD) ;DETERMINE IF A FILE/FIELD IS MARKED FOR ENCRYPTION
 ;INPUT  : FILE - File number
 ;         FIELD - Field number
 ;         VAQIGNC - Indicates if encryption rules should be ignored
 ;           If 1, ignore encryption rules (never encrypt)
 ;           If 0 or doesn't exist, obey encryption rules (default)
 ;OUTPUT : 1 - File/field is marked for encryption
 ;         0 - File/field not marked for encryption
 ;
 ;CHECK INPUT (ASSUME NOT MARKED ON ERROR)
 S FILE=+$G(FILE)
 S FIELD=+$G(FIELD)
 Q:(('FILE)!('FIELD)) 0
 ;IGNORE FLAG TURNED ON
 Q:(+$G(VAQIGNC)) 0
 ;NOT MARKED FOR ENCRYPTION
 Q:('$D(^VAT(394.73,"A-NCRYPT",FILE,FIELD))) 0
 ;MARKED
 Q 1
 ;
ENCMTHD(ENCPTR,DCRYPT) ;RETURN ENCRYPTION/DECRYPTION METHOD
 ;INPUT  : ENCPTR - Pointer to VAQ - ENCRYPTION METHOD file
 ;         DCRYPT - Indicates which method to return
 ;           If 0, return encryption method (default)
 ;           If 1, return decryption method
 ;OUTPUT : The encryption/decryption method
 ;         NULL - Error
 ;
 ;CHECK INPUT
 S ENCPTR=+$G(ENCPTR)
 Q:('ENCPTR) ""
 S DCRYPT=+$G(DCRYPT)
 ;RETURN DECRYPTION METHOD
 Q:(DCRYPT) $G(^VAT(394.72,ENCPTR,"DCR"))
 ;RETURN ENCRYPTION METHOD
 Q $G(^VAT(394.72,ENCPTR,"ECR"))
 ;
DEFENC(DCRYPT,POINT) ;RETURN DEFAULT ENCRYPTION/DECRYPTION METHOD
 ;INPUT  : DCRYPT - Indicates which method to return
 ;           If 0, return encryption method (default)
 ;           If 1, return decryption method
 ;         POINT - Indicates if a pointer to VAQ - ENCRYPTION METHOD
 ;                 file should be returned
 ;           If 0, return method (default)
 ;           If 1, return pointer to method
 ;OUTPUT : If method is requested
 ;           The default encryption/decryption method
 ;           NULL - Error
 ;         If pointer is requested
 ;           Pointer to VAQ - ENCRYPTION METHOD
 ;           0 - Error
 ;
 ;CHECK INPUT
 S DCRYPT=+$G(DCRYPT)
 S POINT=+$G(POINT)
 ;DECLARE VARIABLES
 N X,Y
 ;GET ENTRY IN PARAMTER FILE
 S X=$O(^VAT(394.81,0))
 ;COULDN'T FIND ENTRY IN PARAMETER
 Q:('X) ""
 ;GET POINTER TO METHOD
 S Y=$G(^VAT(394.81,X,"ECR"))
 S Y=+$P(Y,"^",2)
 ;POINTER TO METHOD DIDN'T EXIST
 Q:('Y) $S(POINT:0,1:"")
 ;RETURN POINTER
 Q:(POINT) Y
 ;RETURN METHOD
 Q $$ENCMTHD(Y,DCRYPT)

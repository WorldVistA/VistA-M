DVBACEM1 ;BEST/JFW - DEMTRAN CONTRACTED EXAM UTILITIES ; 7/17/12 3:13pm
 ;;2.7;AMIE;**178,185**;Apr 10, 1995;Build 18
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;  - RPC: DVBAD CONTRACTED EXAM CRYPTO
 ;  
 ;  Encrypts/Decrypts strings, particulary USERNAME/PASSWORD in the
 ;  2507 EXAM CONTRACTORS File #396.45 for the Disability
 ;  Examination Management Tracking, Referral and Notification
 ;  application (demTRAN).
 ;
 ;Input:
 ;     DVBAOVAL:   Holds single value or '^' delimited encrypted / 
 ;                 decrypted results
 ;     DVBAETYP:   Type of Cryptography to perform (Required)
 ;                   1 : Encryption
 ;                   2 : Decryption
 ;     DVBAIVAL:   Single value or '^' delimited string values
 ;                 to perform Cryptography action on (Required)
 ;Ouput:
 ;     See DVBAOVAL above
 ;
EN(DVBAOVAL,DVBAETYP,DVBAIVAL) ;Cryptography Entry Point
 N DVBAIDNUM
 S DVBAIDNUM=290134528  ;Identification Number for Cryptography
 S:(DVBAETYP=1) DVBAOVAL=$$ENCRYP(DVBAIVAL,DVBAIDNUM)  ;Encryption
 S:(DVBAETYP=2) DVBAOVAL=$$DECRYP(DVBAIVAL,DVBAIDNUM)  ;Decryption
 Q
 ;
 ;Input:
 ;     DVBAIVAL:   Single value or '^' delimited string values
 ;                 to perform Cryptography action on (Required)
 ;     DVBAID:     Identification Number to use in Encryption
 ;Output:
 ;     Returns Single or '^' delimitted encrypted values.
ENCRYP(DVBAIVAL,DVBAID)  ;Encryption Entry Point
 N X,X1,X2,DVBAI,DVBARSLT
 Q:((DVBAIVAL="")!(DVBAID=""))
 ;Encrypt each value in string
 F DVBAI=1:1:$L(DVBAIVAL,"^")  D
 .S X=$P(DVBAIVAL,"^",DVBAI),X1=DVBAID,X2=1
 .D EN^XUSHSHP  ;DBIA 10045 - Supported
 .S $P(DVBARSLT,"^",DVBAI)=X
 Q DVBARSLT
 ;
 ;Input:
 ;     DVBAIVAL:   Single value or '^' delimited string values
 ;                 to perform Cryptography action on (Required)
 ;     DVBAID:     Identification Number to use in Decryption
 ;Output:
 ;     Returns Single or '^' delimitted decrypted values.
DECRYP(DVBAIVAL,DVBAID)  ;Decryption Entry Point
 N X,X1,X2,DVBAI,DVBARSLT
 Q:((DVBAIVAL="")!(DVBAID=""))
 ;Decrypt each value in string
 F DVBAI=1:1:$L(DVBAIVAL,"^")  D
 .S X=$P(DVBAIVAL,"^",DVBAI),X1=DVBAID,X2=1
 .D DE^XUSHSHP  ;DBIA 10045 - Supported
 .S $P(DVBARSLT,"^",DVBAI)=X
 Q DVBARSLT

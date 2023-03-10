PSO679P ;BAYPINES/KML - POST INSTALL TO PATCH PSO,679 ; April 18, 2022
 ;;7.0;OUTPATIENT PHARMACY;**679**;DEC 1997;Build 16
 ;
 Q
POST ;;  field 52.1,94 has been changed from a set of codes to a free text value
 ; need to modify the data that is stored from its coded value to its external representation
 ; the following illustrates what values will be stored:
 ;    '1' will be changed to CPRS; 
 ;    '2' will be changed to OUTPATIENT PHARMACY; 
 ;    '3' will be changed to CONTACT CENTER; 
 ;    '4' will be changed to AUDIOCARE; 
 ;    '5' will be changed to MY HEALTHEVET; 
 ; ^PSRX(PSORXN,1,PSOITF,"RF1")   change set of code values to external representation
 N REFSRC,X1,X2,ENTRIES,COUNT,TEXT
 S ENTRIES=$P(^PSRX(0),"^",4)
 S TEXT(1)="Starting to convert the data at the REFILL SOURCE field (#52.1,94)"
 S TEXT(2)="from a SET OF CODES to its Free Text value."
 S TEXT(3)=""
 S TEXT(4)="There are "_ENTRIES_" prescription entries to process."
 S TEXT(5)=""
 D MES^XPDUTL(.TEXT)
 D CONVERT
 Q
 ;
CONVERT ;
 S (X1,COUNT)=0
 F  S X1=$O(^PSRX(X1)) Q:'X1  D
 . S COUNT=COUNT+1,X2=0
 . I COUNT#500000=0 D MES^XPDUTL("Processed "_COUNT_" entries.")
 . F  S X2=$O(^PSRX(X1,1,X2)) Q:'X2  D
 . . S REFSRC=$P($G(^PSRX(X1,1,X2,"RF1")),"^")
 . . Q:REFSRC=""
 . . L +^PSRX(X1,1,X2):5 Q:'$T
 . . S $P(^PSRX(X1,1,X2,"RF1"),"^")=$S(REFSRC=1:"CPRS",REFSRC=2:"OUTPATIENT PHARMACY",REFSRC=3:"CONTACT CENTER",REFSRC=4:"AUDIOCARE",REFSRC=5:"MY HEALTHEVET",1:REFSRC)
 . . L -^PSRX(X1,1,X2)
 . . D MES^XPDUTL("Entry "_X1_" converted to "_$P(^PSRX(X1,1,X2,"RF1"),"^"))
 D MES^XPDUTL("Conversion completed")
 Q

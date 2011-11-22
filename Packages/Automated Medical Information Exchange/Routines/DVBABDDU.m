DVBABDDU ;ALB/RPM - CAPRI DATA DICTIONARY UTILITIES ; 08/05/10
 ;;2.7;AMIE;**149**;Apr 10, 1995;Build 16
 ;
GETSET(DVBRSLT,DVBFIL,DVBFLD) ;return Set of Codes
 ;This procedure returns the internal and external values
 ;for a given file and SET OF CODES field.
 ;
 ;Supports remote procedure:  DVBAB GET SET
 ;
 ;  Input:
 ;    DVBFIL - (required) file number  (ex. 396.3)
 ;    DVBFLD - (required) field number (ex. 9)
 ;
 ;  Output:
 ;    DVBRSLT - (pass by reference) returns an array of caret-delimited
 ;              internal and external set of codes values on success;
 ;              otherwise, returns nothing
 ;              Ex: DVBRSLT(n)=code internal value^code external value
 ;
 N DVBSET   ;results from FIELD^DID call
 N DVBCNT   ;returned codes count
 N DVBI     ;generic counter
 N DVBSETI  ;internal value
 N DVBSETE  ;external value
 ;
 D FIELD^DID(DVBFIL,DVBFLD,"","POINTER","DVBSET","DVBSET")
 I '$D(DVBSET("DIERR")) D
 . S DVBCNT=$L(DVBSET("POINTER"),";")-1
 . F DVBI=1:1:DVBCNT D
 . . S DVBSETI=$P($P(DVBSET("POINTER"),";",DVBI),":",1)
 . . S DVBSETE=$P($P(DVBSET("POINTER"),";",DVBI),":",2)
 . . S DVBRSLT(DVBI)=DVBSETI_"^"_DVBSETE
 Q

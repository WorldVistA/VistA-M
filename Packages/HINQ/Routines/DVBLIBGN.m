DVBLIBGN ;ALB/NGC - CAPRI Reusable Library - General ; 9/22/25 1:00pm
 ;;2.7;AMIE;**255**;Apr 10, 1995;Build 21
 ;Per VHA Directive 6402 this routine should not be modified
 ; Reference to OWNSKEY^XUSRB in ICR #3277
 ; Reference to ^%DT in ICR #3277
 ; Reference to File 19.2 in ICR #4086
 ; Reference to File 38.1 in ICR #767
 ; Reference to REPLACE^XLFSTR in ICR #10104
 ; Reference to routine XLFDT in ICR #10103
 ; Reference to routine ^XMD in ICR #10070
 ; Reference to FIND1^DIC in ICR #10006
 ; Reference to UPDATE^DIE in ICR #2053
 ;
 Q  ;no direct entry
 ;
 ;
CSV(DVBVALUE) ;CAPRI-12377:NGC - return a CSV formatted version of a data point.  i.e. escape any ( " ) characters
  ;RFC-4180
  N DVBNEWVALUE,DVBSPEC
  S DVBSPEC($C(34))=$C(34,34)
  S DVBNEWVALUE=$$REPLACE^XLFSTR(DVBVALUE,.DVBSPEC)
  S:(DVBNEWVALUE[",")&($A(DVBNEWVALUE)'=34) DVBNEWVALUE=""""_DVBNEWVALUE_""""
  Q DVBNEWVALUE
  ;
  ;
ISSENSITIVE(DVBDFN)  ;CAPRI-12377:NGC - return true/false if patient is 'sensitive'
  Q ($P($G(^DGSL(38.1,DVBDFN,0)),U,2)=1)
  ;
  ;
USERHASKEY(DVBKEYNAME) ;CAPRI-12375:NGC - return boolean 1|0 for if user has a given key
  ;Parameters - DVBKEYNAME : name of the security key
  ;Returns    - boolean 1-user has key, 0-user not has key
  N DVBRET
  D OWNSKEY^XUSRB(.DVBRET,DVBKEYNAME) ;Security key check
  Q $G(DVBRET(0))
  ;

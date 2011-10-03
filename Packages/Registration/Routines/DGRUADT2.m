DGRUADT2 ;ALB/GRR - Logic for editing admit, discharge, or transfer; 7-8-99
 ;;5.3;Registration;**190,328,373,430**;Aug 13, 1993
 ;
EDITADT ; Entry point for generating HL7 ADT messages to the COTS system
 ; whenever an existing patient movement is edited.  Multiple messages
 ; may be created and sent to the vendor.
 ; Input:
 ;      DGPMP   - 0 node of the primary movement BEFORE the ADT action
 ;      DGPMA   - 0 node of the primary movement AFTER the ADT action
 ;      DFN     - Ien of the patient in the PATIENT File (#2)
 ;      DGPMDA  - Ien of the movement
 ;      DGPPMDA - Ien of prior movement
 ;      DGQUIET - Flag to suppress read/writes if set
 ;      DGADT   - Data array for processing ADT events
 ;      DGTRACE - Debugging parameter
 ;      DGPDIV  - Division for prior Ward
 ;      DGCDIV  - Division for current Ward
 ;      DGINTEG - Integration Database flag
 ;                0 - Not Integrated Site
 ;                1 - Integrated, Single Database
 ;                2 - Integrated, Multiple Databases
 ;      DGLMT   - Last Movement flag
 ;                1 - Created multiple HL7 transactions
 ;      DGCTRAN - 1 - Changing Transfer data, must move
 ;                    prior location to current location
 ;
 N DGCTRAN,DGLMT,DGINTEG,DGMOVE
 S (DGCTRAN,DGLMT)=0
 D SETVAR^DGRUADT(DGPMA)
 S DGMOVE=$$MOVETYPE^DGRUADT(DGPMA)
 S DGINTEG=$$GET1^DIQ(43,1,391.705,"I")
 ;
 ; If DGTYPE=6, then this a treating specialty change, check if this isfor
 ; a provider change.
 I (DGTYPE=6) D  Q
 . N VAIN,VAINDT
 . S VAINDT=+DGPMA
 . D INP^VADPT
 . I (+VAIN(2)=+$G(DGPMVI(7)))&(+VAIN(11)=+$G(DGPMVI(18))) Q
 . Q:'$$CHKWARD^DGRUUTL(+$G(DGPMVI(5)))
 . W:$D(DGTRACE) !,2.6
 . D BLDMSG^DGRUADT1(DFN,"A08",DGPMDA,+DGPMA,+DGPMVI(5))
 ;
 ; If DGTYPE=1, then editing an existing admission
 I (DGTYPE=1) S DGEVENT="A08" D  Q
 . W:$D(DGTRACE) !,2.1
 . Q:'$$CHKWARD^DGRUUTL(+$P(DGPMA,"^",6))&('$$CHKWARD^DGRUUTL(+$P(DGPMP,"^",6)))
 . ; Check for ward location change
 . I $P(DGPMP,"^",6)'=$P(DGPMA,"^",6) D  Q
 . . I $$CHKWARD^DGRUUTL($P(DGPMP,"^",6)) D
 . . . D BLDMSG^DGRUADT1(DFN,"A11",DGPMDA,+DGPMP,$P(DGPMP,"^",6))
 . . Q:'$$CHKWARD^DGRUUTL($P(DGPMA,"^",6))
 . . D BLDMSG^DGRUADT1(DFN,"A01",DGPMDA,+DGPMA,$P(DGPMA,"^",6))
 . ; Check for edit to admission date, if edited send A08 with date change
 . I '(+DGPMA=+DGPMP) D  Q
 . . D BLDMSG^DGRUADT1(DFN,"A08",DGPMDA,+DGPMP,+$P(DGPMP,"^",6),+DGPMP,"A")
 . ;If Bed switch, create an A02
 . I ($P(DGPMA,"^",6)=$P(DGPMP,"^",6)),($P(DGPMA,"^",7)'=$P(DGPMP,"^",7)) D  Q
 . . D BLDMSG^DGRUADT1(DFN,"A02",DGPMDA,+DGPMA,+$P(DGPMA,"^",6))
 . ; Just need an regular A08
 . D BLDMSG^DGRUADT1(DFN,"A08",DGPMDA,+DGPMA,+$P(DGPMA,"^",6))
 ;
 ; If DGTYPE=3, then editing an existing discharge
 I (DGTYPE=3) S DGEVENT="A08" D  Q
 . N DGTIEN
 . W:$D(DGTRACE) !,2.3
 . N DGRU,VAROOT
 . S VAIP("D")="LAST",VAROOT="DGRU"
 . D IN5^VADPT
 . K VAROOT
 . I $$CHKWARD^DGRUUTL(+DGRU(17,4))&(DGMOVE'=42) D  Q  ;P-430
 . . N DGASIH S DGASIH=1 ;p-430
 . . D BLDMSG^DGRUADT1(DFN,"A03",$G(DGPMDA),+DGRU(17,4)) ;p-430
 . . N DGIEN S DGIEN=$O(^DGRU(46.14,DFN,1,"B",+$G(DGPM0),0)) Q:DGIEN=""  ;p-430
 . . N DGSTAT S DGSTAT="I" ;p-430
 . . D UPSTAT^DGRUASIH(DFN,DGIEN,DGSTAT) ;p-430
 . I DGMOVE=47 D  Q  ;p-430
 . . N DGTIEN ;p-430
 . . S DGTIEN=$$FLLTCM^DGRUUTL1(DFN) ;p-430
 . . Q:DGTIEN=""  ;p-430  
 . . S DGRU(17,4)=$P(^DGPM(DGTIEN,0),"^",6,7) ;p-430
 . . Q:'$$CHKWARD^DGRUUTL(+DGRU(17,4))  ;p-430
 . . N DGASIH S DGASIH=1 ;p-430
 . . D BLDMSG^DGRUADT1(DFN,"A03",DGTIEN,+DGRU(17,4))
 . . N DGIEN S DGIEN=$O(^DGRU(46.14,DFN,1,"B",+$G(DGPM0),0)) Q:DGIEN=""  ;p-373
 . . N DGSTAT S DGSTAT="I" ;p-373
 . . D UPSTAT^DGRUASIH(DFN,DGIEN,DGSTAT) ;p-373 
 .; Q:'$$CHKWARD^DGRUUTL(+DGRU(17,4))  p-430
 . ; Check for edit to discharge date, if edited send modified a08
 . I '(+DGPMA=+DGPMP) D  Q
 . . I DGMOVE=42 D  Q  ;p-373
 . . . N DGNOW D NOW^%DTC S DGNOW=% ;p-373
 . . . I +$G(DGPMP)<DGNOW D  ;p-373
 . . . . N DGASIH S DGASIH=3 ;p-373
 . . . . N DGTIEN S DGTIEN=$$FLLTCM^DGRUUTL1(DFN) Q:DGTIEN=""  ;p-430
 . . . . D BLDMSG^DGRUADT1(DFN,"A13",DGTIEN,+^DGPM(DGTIEN,0),+$P(^DGPM(DGTIEN,0),"^",6)) ;p-430
 . . . . N DGSTAT,DGIEN S DGSTAT="A" ;p-373
 . . . . S DGIEN=$O(^DGRU(46.14,DFN,1,"B",+$G(DGPM0),0)) Q:DGIEN=""  ;p-373
 . . . . D UPSTAT^DGRUASIH(DFN,DGIEN,DGSTAT) ;p-373
 . . Q:'$$CHKWARD^DGRUUTL(+DGRU(17,4))  ;p-430
 . . D BLDMSG^DGRUADT1(DFN,"A08",DGPMDA,+DGPMA,+DGRU(17,4),+DGPMP,"D")
 . E  D
 . . Q:'$$CHKWARD^DGRUUTL(+DGRU(17,4))  ;p-430
 . . D BLDMSG^DGRUADT1(DFN,"A08",DGPMDA,+DGPMA,+DGRU(17,4))
 ;
 ; If DGTYPE=2, then editng an existing transfer
 I (DGTYPE=2) S DGEVENT="A08" D  Q
 . W:$D(DGTRACE) !,2.2
 . Q:'$$CHKWARD^DGRUUTL(+$P(DGPMA,"^",6))
 . S DGLMT=0
 . I $$CHKWARD^DGRUUTL($P(DGPMP,"^",6)) D
 . . Q:DGINTEG'=1&(DGINTEG'=2)  ;Not an integrated database
 . . Q:'$D(DGPM0)  ;No prior movements
 . . Q:'$$CHKWARD^DGRUUTL($P(DGPM0,"^",6))  ;Not RAI/MDS ward
 . . I +$$GETDIV^DGRUUTL1($P(DGPMP,"^",6))'=+$$GETDIV^DGRUUTL1($P(DGPM0,"^",6)) D  ;Multiple transactions done last time
 . . . S DGLMT=1
 . ;
 . I $P(DGPMP,"^",6)'=$P(DGPMA,"^",6) D  Q  ;Ward changed
 . . I +$$GETDIV^DGRUUTL1($P(DGPMP,"^",6))'=+$$GETDIV^DGRUUTL1($P(DGPMA,"^",6)) D
 . . . I +$$GETDIV^DGRUUTL1($P(DGPMA,"^",6))=+$$GETDIV^DGRUUTL1($P(DGPM0,"^",6)) D  ;now same division as original ward, cancel dc and admit, send A02
 . . . . D BLDMSG^DGRUADT1(DFN,"A11",DGPMDA,+DGPMP,+$P(DGPMP,"^",6))
 . . . . S DGCTRAN=1 D BLDMSG^DGRUADT1(DFN,"A13",DGPMDA,+DGPMP,+$P(DGPMP,"^",6))
 . . . . D BLDMSG^DGRUADT1(DFN,"A02",DGPMDA,+DGPMA,+$P(DGPMA,"^",6))
 . . . E  D
 . . . . D BLDMSG^DGRUADT1(DFN,"A11",DGPMDA,+DGPMP,+$P(DGPMP,"^",6))
 . . . . D BLDMSG^DGRUADT1(DFN,"A01",DGPMDA,+DGPMA,+$P(DGPMA,"^",6))
 . . E  D
 . . . S DGCTRAN=1
 . . . I 'DGLMT D
 . . . . D BLDMSG^DGRUADT1(DFN,"A12",DGPMDA,+DGPMP,+$P(DGPMP,"^",6))
 . . . . D BLDMSG^DGRUADT1(DFN,"A02",DGPMDA,+DGPMA,+$P(DGPMA,"^",6))
 . . . E  D
 . . . . D BLDMSG^DGRUADT1(DFN,"A11",DGPMDA,+DGPMP,+$P(DGPMP,"^",6))
 . . . . D BLDMSG^DGRUADT1(DFN,"A01",DGPMDA,+DGPMA,+$P(DGPMA,"^",6))
 . . . . I +DGPMP'=+DGPMA D BLDMSG^DGRUADT1(DFN,"A08",DGPMDA,+DGPMP,+$P(DGPMP,"^",6),+DGPMP,"D") ;date also changed, update discharge date in other entity
 . ;
 . ; Check for edit to transfer date, if edited send modified A08
 . I '(+DGPMA=+DGPMP) D  Q
 . . I 'DGLMT D  ;Just send one A08 to change transfer date
 . . . D BLDMSG^DGRUADT1(DFN,"A08",DGPMDA,+DGPMP,+$P(DGPMP,"^",6),+DGPMP,"T")
 . . E  D
 . . . D BLDMSG^DGRUADT1(DFN,"A08",DGPMDA,+DGPMP,+$P(DGPMP,"^",6),+DGPMP,"A")
 . . . D BLDMSG^DGRUADT1(DFN,"A08",DGPMDA,+DGPMP,+$P(DGPM0,"^",6),+DGPMP,"D")
 . E  D
 . . ; The following checks for the special case of a bed switch following a transfer
 . . ; in the movement sequence.  Bed switch requires an "A02"
 . . I ($P(DGPMA,"^",6)=$P(DGPMP,"^",6)),($P(DGPMA,"^",7)'=$P(DGPMP,"^",7)) D
 . . . D BLDMSG^DGRUADT1(DFN,"A02",DGPMDA,+DGPMA,+$P(DGPMA,"^",6))
 . . E  D  ; Process straight interward transfer with no special cases
 . . . D BLDMSG^DGRUADT1(DFN,"A08",DGPMDA,+DGPMA,+$P(DGPMA,"^",6))
 ;
EXIT Q

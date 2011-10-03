DGRUADT ;ALB/SCK - MAIN DRIVER FOR RAI/MDS ADT MESSAGING; 7-8-99 ; 29 Aug 2006  9:07 AM
 ;;5.3;Registration;**190,312,328,373,430,464,721**;Aug 13, 1993;Build 3
 ;
EN ; Main entry point for generating an HL7 ADT message to the COTS system
 ; The message builder is tasked off to taskManager to build and transmit
 ; the ADT message to the vendor.
 ; Input:
 ;      DGPMP   - 0 node of the primary movement BEFORE the ADT action
 ;      DGPMA   - 0 node of the primary movement AFTER the ADT action
 ;      DFN     - Ien of the patient in the PATIENT File (#2)
 ;      DGPMDA  - Ien of the movement
 ;      DGQUIET - Flag to suppress read/writes if set
 ;      DGADT   - Data array for processing ADT events
 ;      DGTRACE - Debugging parameter
 ;      DGPDIV  - Division for prior Ward
 ;      DGCDIV  - Division for current Ward
 ;      DGINTEG - Integration Database flag
 ;                0 - Not Integrated Site
 ;                1 - Integrated, Single Database
 ;                2 - Integrated, Multiple Databases
 ;      DGPMVI  - Array where results from call to IN5^VADPT returned
 ;
 N DGTRACE,VAFH
 ;
 ; Test for ADT on/off parameter
 Q:'$P($$SEND^VAFHUTL(),"^",2)
 ;
 M VAFH=^UTILITY("DGPM",$J)
 ;
 I '($G(DGQUIET)) D
 . W !,"Executing HL7 ADT Messaging (RAI/MDS)"
 . I $D(^TMP("DGRUADT1")) S DGTRACE=1
 I $D(DGTRACE) D  G EXIT
 . D INIT
 ;
 N ZTDESC,ZTRTN,ZTSAVE,ZTIO,ZTDTH,X,ZTQUEUED,ZTREQ
 S ZTDESC="HL7 ADT MESSAGE (RAI/MDS)",ZTRTN="EVENT^DGRUADT"
 F X="DGPMP","DGPMA","DGPMDA","DFN","DGPMAN","VAFH(" S ZTSAVE(X)=""
 S ZTIO="",ZTDTH=$H
 D ^%ZTLOAD
EXIT ;
 I $D(ZTQUEUED) S ZTREQ="@"
 D KILL^HLTRANS
 K ^TMP("HLS",$J)
 Q
 ;
INIT ;
 D EVENT,EXIT
 Q
 ;
EVENT ;
 N DGTYPE,DGMOVE,DGADMSN,VAFHDT,DGEVENT,VAIP
 ;
 ; Check for valid movements
 I $G(DGPMP)=""&($G(DGPMA)="") Q
 ;
 ; Determine the event transaction type.  The events are: 
 ;
 ; If DGPMP is null and DGPMA is not, then adding a new ADT event
 I (DGPMP="")&(DGPMA'="") D  G EVENTQ
 . D SETVAR(DGPMA)
 . ;
 . ; If DGTYPE=6, then this a treating specialty change, check if this is for
 . ; a provider change.
 . I (DGTYPE=6) D  Q
 . . N VAIN,VAINDT
 . . S VAINDT=+DGPMA
 . . D INP^VADPT
 . . ; I (+VAIN(2)=+$G(DGPMVI(7)))&(+VAIN(11)=+$G(DGPMVI(18))) Q p-721
 . . Q:'$$CHKWARD^DGRUUTL(+$G(DGPMVI(5)))
 . . W:$D(DGTRACE) !,1.6
 . . D BLDMSG^DGRUADT1(DFN,"A08",DGPMDA,+DGPMA,+DGPMVI(5))
 . ;
 . ; If DGTYPE=1, then it means an admission
 . I (DGTYPE=1) S DGEVENT="A01" D  Q
 . . W:$D(DGTRACE) !,1.1
 . . Q:'$$CHKWARD^DGRUUTL(+$P(DGPMA,"^",6))
 . . D BLDMSG^DGRUADT1(DFN,"A01",DGPMDA,+DGPMA,+$P(DGPMA,"^",6))
 . ;
 . ; If DGTYPE=3, then it means a discharge
 . I (DGTYPE=3) S DGEVENT="A03" D  Q
 . . W:$D(DGTRACE) !,1.3
 . . S DGMOVE=$$MOVETYPE(DGPMA)
 . . ;
 . . ;If Movement type "From ASIH" create A22 and send to COTS
 . . I DGMOVE=41!(DGMOVE=14) D MV41^DGRUADT0(DFN) Q
 . . ;
 . . ; Get ward discharged from, if RAI/MDS, then process message
 . . N VAIP S VAIP("D")="LAST"
 . . D IN5^VADPT
 . . ;If Movement type "Death" must check to see if patient was ASIH
 . . ;If patient was ASIH, create and send A03 to COTS
 . . I $P($G(DGPMAN),"^",21)]"" N DGASIH D MV1238^DGRUADT0(DFN) Q:$G(DGASIH)=1  ;modified p-373
 . . ;
 . . Q:'$$CHKWARD^DGRUUTL(+VAIP(17,4))
 . . D BLDMSG^DGRUADT1(DFN,"A03",DGPMDA,+DGPMA,+VAIP(17,4))
 . ;
 . ; If DGTYPE=2, then it means a transfer
 . I (DGTYPE=2) S DGEVENT="A02" D  Q
 . . W:$D(DGTRACE) !,1.2
 . . S DGMOVE=$$MOVETYPE(DGPMA)
 . . ;
 . . ; If transfer to ASIH
 . . I DGMOVE=13!(DGMOVE=43)!(DGMOVE=40) D MV40^DGRUADT0(DFN) Q
 . . ;
 . . ;If transfer From ASIH
 . . I DGMOVE=14!(DGMOVE=41) D MV41^DGRUADT0(DFN) Q
 . . ; If transfer is to Leave of absence
 . . I DGMOVE=1!(DGMOVE=2)!(DGMOVE=3) D  Q  ;modified p-328
 . . . Q:'$$CHKWARD^DGRUUTL(+$P(DGPMA,"^",6))
 . . . D BLDMSG^DGRUADT1(DFN,"A21",DGPMDA,+DGPMA,+$P(DGPMA,"^",6))
 . . ;
 . . ; If transfer is from Leave of absence
 . . I DGMOVE=23!(DGMOVE=24)!(DGMOVE=22) D  Q
 . . . Q:'$$CHKWARD^DGRUUTL(+$P(DGPMA,"^",6))
 . . . D BLDMSG^DGRUADT1(DFN,"A22",DGPMDA,+DGPMA,+$P(DGPMA,"^",6))
 . . ;
 . . I DGMOVE=4 D MV4^DGRUADT0(DFN,DGPMA)
 . ;
 ;
 ; If DGPMP and DGPMA are both NOT null, then editing an ADT event
 I (DGPMP'="")&(DGPMA'="") D EDITADT^DGRUADT2 G EVENTQ
 ;
 ; If DGPMP is not null and DGPMA is, then deleting an ADT event
 I (DGPMP'="")&(DGPMA="") D  G EVENTQ
 . D SETVAR(DGPMP)
 . S DGMOVE=$$MOVETYPE(DGPMP)
 . ;
 . ; If DGTYPE=1, then deleting an admission
 . I (DGTYPE=1) S DGEVENT="A11" D  Q
 . . W:$D(DGTRACE) !,3.1
 . . ;Check if deleting an admission for an ASIH event
 . . I DGMOVE=13!(DGMOVE=43)!(DGMOVE=40) D CN40^DGRUADT0(DFN) Q
 . . Q:'$$CHKWARD^DGRUUTL(+$P(DGPMP,"^",6))  ;Quit if not RAI/MDS ward
 . . ;
 . . D BLDMSG^DGRUADT1(DFN,"A11",DGPMDA,+DGPMP,+$P(DGPMP,"^",6))
 . ;
 . ; If DGTYPE=3, then deleting a discharge
 . I (DGTYPE=3) S DGEVENT="A13" D  Q
 . . W:$D(DGTRACE) !,3.3
 . . S VAIP("D")="LAST",VAIP("M")=1
 . . D IN5^VADPT
 . . ; Get ward. Use last movement if it exists, if not use the current movement.
 . . N DGWARD S DGWARD=(+VAIP(14,4))
 . . I $P($G(DGPMAN),"^",21)]"" N DGASIH D  Q:$G(DGASIH)=3  ;Deleting discharge which relates to ASIH (312), modified p-373
 . . . N DGOMDT,DGOWARD,DGOIEN
 . . . S DGOMDT=+$G(DGPMAN) Q:DGOMDT'>0
 . . . S DGOMDT=$O(^DGPM("APRD",DFN,DGOMDT),-1) Q:DGOMDT'>0  ;Get movement prior to ASIH
 . . . S DGOIEN=$O(^DGPM("APRD",DFN,DGOMDT,0)) ;Get IEN of movement
 . . . S DGOWARD=$$GET1^DIQ(405,DGOIEN,".06","I") Q:DGOWARD=""
 . . . Q:'$$CHKWARD^DGRUUTL(DGOWARD)  ;Quit if not RAI/MDS flag
 . . . N DGLDDAT S DGLDDAT=$O(^DGPM("APTT3",DFN,""),-1) ;p-430
 . . . I $G(DGLDDAT)]"",DGLDDAT>+$P($G(DGPMAN),"^"),DGLDDAT<+$G(DGNOW) Q  ;p-430
 . . . K DGLDDAT ;p-430
 . . . S DGASIH=3 ;Set flag to identify ASIH (used by DGRUGA13)
 . . . D BLDMSG^DGRUADT1(DFN,"A13",DGOIEN,+DGPMP,DGOWARD)
 . . . N DGSTAT,DGIEN S DGSTAT="A" ;p-430
 . . . S DGIEN=$O(^DGRU(46.14,DFN,1,"B",+$G(DGPMAN),0)) Q:DGIEN=""  ;p-430
 . . . D UPSTAT^DGRUASIH(DFN,DGIEN,DGSTAT) ;p-430
 . . S:'DGWARD DGWARD=+VAIP(5)
 . . Q:'$$CHKWARD^DGRUUTL(DGWARD)
 . . D BLDMSG^DGRUADT1(DFN,"A13",DGPMDA,+DGPMP,DGWARD)
 . ;
 . ; If DGTYPE=2, then deleting a transfer
 . I (DGTYPE=2) S DGEVENT="A12" D  Q
 . . W:$D(DGTRACE) !,3.2
 . . N DGWARDP,DGWARDA,VAIP
 . . S DGWARDP=+$P(DGPMP,"^",6)
 . . N VAIP S VAIP("D")="LAST",VAIP("M")=1
 . . D IN5^VADPT
 . . S DGWARDA=+VAIP(5)
 . . I 'DGWARDP!('DGWARDA) D  Q
 . . . W !,"Unable to determine wards for transfer cancellation"
 . . ;
 . . ;Get Division for prior Ward
 . . S DGPDIV=+$$GETDIV^DGRUUTL1(DGWARDP)
 . . ;
 . . ;Get Division for current Ward
 . . S DGCDIV=+$$GETDIV^DGRUUTL1(DGWARDA)
 . . ;
 . . ;Get Integration flag
 . . S DGINTEG=+$$GET1^DIQ(43,1,391.705,"I")
 . . ;
 . . ; If cancel transfer mds to mds ward: A12
 . . I $$CHKWARD^DGRUUTL(DGWARDP)&($$CHKWARD^DGRUUTL(DGWARDA)) D  Q
 . . . I DGINTEG=1!(DGINTEG=2),DGPDIV'=DGCDIV D
 . . . . D BLDMSG^DGRUADT1(DFN,"A11",DGPMDA,+DGPMP,DGWARDP)
 . . . . D BLDMSG^DGRUADT1(DFN,"A13",DGPMDA,+DGPMP,DGWARDA)
 . . . E  D  ;
 . . . . D BLDMSG^DGRUADT1(DFN,"A12",DGPMDA,+DGPMP,DGWARDP)
 . . . . I DGMOVE=43 D DELASIH^DGRUASIH(DFN,VAFHDT) ;p-464
 . . ; If cancel transfer to non-mds ward from an mds ward: A13
 . . I '$$CHKWARD^DGRUUTL(DGWARDP)&($$CHKWARD^DGRUUTL(DGWARDA)) D  Q
 . . . D BLDMSG^DGRUADT1(DFN,"A13",DGPMDA,+DGPMP,DGWARDP)
 . . ; If cancel transfer to mds ward from an non-mds ward: A11
 . . I $$CHKWARD^DGRUUTL(DGWARDP)&('$$CHKWARD^DGRUUTL(DGWARDA)) D  Q
 . . . D BLDMSG^DGRUADT1(DFN,"A11",DGPMDA,+DGPMP,DGWARDP)
 ;
EVENTQ Q
 ;
SETVAR(NODE) ;
 S DGTYPE=$P(NODE,"^",2),VAFHDT=$P(NODE,"^",1),DGADMSN=$P(NODE,"^",14)
 Q
 ;
MOVETYPE(NODE) ;
 N TYPE
 S TYPE=$P(NODE,"^",18)
 Q +$G(TYPE)

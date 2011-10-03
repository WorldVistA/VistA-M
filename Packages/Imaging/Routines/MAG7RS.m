MAG7RS ;WOIFO/PMK,MLH - copy radiology message from HLSDATA to ^MAGDHL7 - add segment data ; 30 Jun 2004  4:32 PM
 ;;3.0;IMAGING;**11,40,30**;16-September-2004
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 ;
PIDADD ; SUBROUTINE - called by ADDDTA^MAGDHL7
 ; Add PID info for DICOM Gateway.
 ; Uses multi-tier array structure MAG7WRK produced by call to MAG7UP.
 ;
 N DIQUIET ; -------------- FileMan verbose/silent variable
 N IXPID ; ---------------- index to PID segment in MAG7WRK array
 N VADM,VAPA ; ------------ VADPT return arrays
 ;
 ; ====================================================
 ; Get patient DFN and retrieve demo data.
 S IXPID=$O(MAG7WRK("B","PID","")) I 'IXPID Q
 S DFN=MAG7WRK(IXPID,3,1,1,1) I 'DFN Q
 ;
 ; ================================================
 ; load demo information into HL7 PID segment
 S DIQUIET=1
 D DEM^VADPT ; demo into VADM()
 I '$G(VAERR),VADM(3)]"" D
 . S MAG7WRK(IXPID,7,1,1,1)=$P(VADM(3),"^")+17000000 ; DOB
 . Q
 ;
 ; ================================================
 ; load address information into HL7 PID segment
 S DIQUIET=1
 D ADD^VADPT ; address & phone into VAPA()
 I '$G(VAERR) D
 . S MAG7WRK(IXPID,10,1,2,1)=$P(VADM(8),"^",2) ; race
 . S MAG7WRK(IXPID,11,1,1,1)=VAPA(1) ; street address 1st line
 . S MAG7WRK(IXPID,11,1,2,1)=VAPA(2)_$S(VAPA(3)="":"",1:", "_VAPA(3)) ; lns 2-3
 . S MAG7WRK(IXPID,11,1,3,1)=VAPA(4) ; city
 . S MAG7WRK(IXPID,11,1,4,1)=VAPA(5) ; 2-letter state
 . S MAG7WRK(IXPID,11,1,5,1)=VAPA(6) ; ZIP
 . ; phone
 . S MAG7WRK(IXPID,13,1,1,1)=VAPA(8)
 . S MAG7WRK(IXPID,13,1,2,1)="PRN" ; phone
 . Q
 Q
 ;
ADDVSDG ; SUBROUTINE - called by ADDDTA^MAGDHL7
 ; Add visit and diagnosis info for DICOM Gateway.
 ;
 N DIQUIET ; ------ FileMan verbose/silent variable
 N I,IX,IX1 ; ----- scratch index vars
 N IXPID,IXPV1 ; -- indices to PID, PV1 segs in MAG7WRK array
 N IXDG1,IXOBR ; -- indices to DG1, OBR segs in MAG7WRK array
 N IXVAEL ; ------- index of entries in VAEL()
 N VAIN,VAEL ; ---- VADPT return arrays
 N MAGPHYNM ; ----- physician name
 N ELCODE ; ------- eligibility code
 ;
 ; ====================================================
 ; Get patient DFN and retrieve inpatient data.
 S IXPID=$O(MAG7WRK("B","PID","")) I 'IXPID Q
 S DFN=MAG7WRK(IXPID,3,1,1,1) I 'DFN Q
 S DIQUIET=1
 D INP^VADPT Q:VAERR  ; inpatient data in VAIN()
 D ELIG^VADPT Q:VAERR  ; eligibility data in VAEL()
 D PV1ADD($S($G(VAIN(1))]"":"IN",1:"OUT"))
 ; add pregnancy status and modalities if not already part of order
 ; message
 I $G(MAG7WRK(1,9,1,1,1))="ORM" D
 . S IXOBR=$O(MAG7WRK("B","OBR",""))
 . I IXOBR D PV1RAD ; pregnancy status & modality info from Radiology
 . Q
 Q
 ;
PV1ADD(XPTSTA) ; SUBROUTINE - called by ADDVSDG
 ; Get the index of the PV1 segment - create one for the order message
 ; if we need to.
 ; 
 ; input:  XPTSTA        patient status { IN | OUT }
 ; 
 ; Expects:  VAEL()      eligibility array from ELIG^VADPT
 ;           VAIN()      inpatient data array from INP^VADPT
 ;
 N FSTAT ; -- status flag returned by MAG7UDR
 N IXSEG ; -- segment index in message
 N IXPRED ; -- index to predecessor segment
 N IXSUCC ; -- index to successor segment
 ;
 S IXPV1=$O(MAG7WRK("B","PV1",""))
 I 'IXPV1 Q:MAG7WRK(1,9,1,1,1)'="ORM"  D
 . S (IXSEG,IXPRED)=$O(MAG7WRK("B","PID","")) Q:'IXSEG
 . F  S IXSEG=$O(MAG7WRK(IXSEG)) Q:"^PD1^NTE^"'[("^"_$G(MAG7WRK(IXSEG,0))_"^")  S IXPRED=IXSEG
 . S IXSUCC=$O(MAG7WRK(IXPRED)),IXPV1=$S(IXSUCC:IXPRED+IXSUCC/2,1:IXPRED+1)
 . S MAG7WRK(IXPV1,0)="PV1"
 . Q
 ;
 ; pt status
 I XPTSTA="OUT" D  ; if op, just status for now
 . S MAG7WRK(IXPV1,2,1,1,1)="O"
 . Q
 E  I XPTSTA'="IN" D  ; not applicable 
 . S MAG7WRK(IXPV1,2,1,1,1)="N"
 . Q
 E  D  ; get visit information too
 . S MAG7WRK(IXPV1,2,1,1,1)="I" ; -- class - always inpatient
 . ; location
 . ;    point of care <--- ward -- needs to be a triplet for Pete's DICOM msg
 . S MAG7WRK(IXPV1,3,1,1,1)=$P(VAIN(4),U)
 . S MAG7WRK(IXPV1,3,1,1,2)=$P(VAIN(4),U,2)
 . S MAG7WRK(IXPV1,3,1,1,3)="VISTA42"
 . S MAG7WRK(IXPV1,3,1,2,1)=$P(VAIN(5),"-") ; -------- room
 . S MAG7WRK(IXPV1,3,1,3,1)=$P(VAIN(5),"-",2) ; ------ bed
 . ; add segment for admitting dx to ADT and ORM messages
 . I $G(VAIN(9))]"" D DG1DGADM^MAG7RSD
 . Q
 ;
 ; add PV1 fields and ROL segments for the attending and referring DRs
 S FSTAT=$$PRCTADD^MAG7UDR($NA(MAG7WRK(IXPV1,7)),"ATT") ; attending DR
 I $G(MAG7WRK(IXPV1,7,1,1,1)),$G(MAG7WRK(1,9,1,1,1))="ADT" D
 . D ROLADD^MAG7RSR($NA(MAG7WRK(IXPV1,7,1)),"AT")
 . Q
 S FSTAT=$$PRCTADD^MAG7UDR($NA(MAG7WRK(IXPV1,8)),"REF") ; referring DR
 I $G(MAG7WRK(IXPV1,8,1,1,1)),$G(MAG7WRK(1,9,1,1,1))="ADT" D
 . D ROLADD^MAG7RSR($NA(MAG7WRK(IXPV1,8,1)),"RP")
 . Q
 I $D(VAEL) D  ; add VIP flag if applicable and not yet present
 . S VAEL(1,0)=VAEL(1) ; for easy array navigation
 . S IXVAEL=""
 . F  Q:$D(IXPV1(16))  S IXVAEL=$O(VAEL(1,IXVAEL)) Q:IXVAEL=""  D
 . . S ELCODE=$P($G(VAEL(1,IXVAEL)),"^")
 . . I "^6^15^"[("^"_ELCODE_"^") S IXPV1(16,1,1,1,1)=ELCODE
 . . Q
 . Q
 Q
 ;
PV1RAD ; SUBROUTINE - called by ADDVSDG
 ; Add "pregnant" to Ambulatory Status if patient is pregnant.
 ; Add modalities to Diagnostic Service Section ID.
 ; 
 ; Expects:  MAG7WRK()     HL7 message array
 ;           IXOBR         Index of OBR segment on MAG7WRK()
 ;           IXPV1         Index of PV1 segment on MAG7WRK()
 ;           
 N RADPT2 ; ------- FileMan date of rad order
 N RADPT3 ; ------- index of order under date on Rad/NM pt file
 N RADPT0 ; ------- data for order on Rad/NM pt file
 N RAOIEN ; ------- index of order on Rad/NM order file
 N RAO0 ; --------- data for order on Rad/NM order file
 N PROCIEN ; ------ ien of procedure on Rad/NM procedure file
 N PROCMOD ; ------ ien of modality on Rad/NM procedure file
 N MODIEN ; ------- ien of modality on modality defined terms file
 N MODTERM ; ------ term for the modality
 N PREGSTAT ; ----- pregnancy status on order
 N REPIX ; -------- repetition index
 N EDTA ; --------- element data
 N AAMBMSG ; ------ ambulatory status array (from message data)
 N AMODMSG ; ------ modality array (from message data)
 ;
 ; get data from Rad/NM pt and order files
 S RADPT2=$P(MAG7WRK(IXOBR,3,1,1,1),"-")
 S RADPT3=$P(MAG7WRK(IXOBR,3,1,1,1),"-",2)
 S RADPT0=$G(^RADPT(DFN,"DT",RADPT2,"P",RADPT3,0))
 S RAOIEN=$P(RADPT0,"^",11) ; IEN for ^RAO(75.1)
 S RAO0="" I RAOIEN S RAO0=$G(^RAO(75.1,RAOIEN,0))
 ;
 ; add "pregnant" to ambulatory status if needed
 ;   get data from message
 S REPIX=""
 F  S REPIX=$O(MAG7WRK(IXPV1,15,REPIX)) Q:'REPIX  D
 . S EDTA=$G(MAG7WRK(IXPV1,15,REPIX,1,1)) I EDTA]"" S AAMBMSG(EDTA)=""
 . Q
 ;   get data from Radiology and add to message if needed and not present
 S PREGSTAT=$P(RAO0,"^",13) I PREGSTAT="" S PREGSTAT="u"
 I '$D(AAMBMSG("B6")),PREGSTAT="y" D
 . S MAG7WRK(IXPV1,15,$O(MAG7WRK(IXPV1,15," "),-1)+1,1,1)="B6"
 . Q
 ;
 ; add modalities to Diagnostic Service Section ID
 ;   get data from message
 F  S REPIX=$O(MAG7WRK(IXOBR,24,REPIX)) Q:'REPIX  D
 . S EDTA=$G(MAG7WRK(IXOBR,24,REPIX,1,1)) I EDTA]"" S AMODMSG(EDTA)=""
 . Q
 ;   get data from Radiology and add to message if needed and not present
 S PROCIEN=$P(RADPT0,U,2)
 I PROCIEN D
 . S PROCMOD=0
 . F  S PROCMOD=$O(^RAMIS(71,PROCIEN,"MDL",PROCMOD)) Q:'PROCMOD  D
 . . S MODIEN=$P($G(^RAMIS(71,PROCIEN,"MDL",PROCMOD,0)),U)
 . . I MODIEN,$D(^RAMIS(73.1,MODIEN,0)) D
 . . . S MODTERM=$P($G(^RAMIS(73.1,MODIEN,0)),U)
 . . . I MODTERM]"",'$D(AMODMSG(MODTERM)) D
 . . . . S MAG7WRK(IXOBR,24,$O(MAG7WRK(IXOBR,24," "),-1)+1,1,1)=MODTERM
 . . . . Q
 . . . Q
 . . Q
 . Q
 Q

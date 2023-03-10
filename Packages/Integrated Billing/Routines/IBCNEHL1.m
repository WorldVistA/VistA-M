IBCNEHL1 ;DAOU/ALA - HL7 Process Incoming RPI Messages ; 26-JUN-2002
 ;;2.0;INTEGRATED BILLING;**300,345,416,444,438,497,506,549,593,601,595,621,631,668,687,702,732**;21-MAR-94;Build 13
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;**Program Description**
 ;  This program will process incoming IIV response messages.
 ;  Including updating the record in the #365 File, updating
 ;  the #355.33 record (if there is one or creating a new one)
 ;  with the appropriate Buffer Symbol & data.
 ;
 ;  Variables
 ;    ACK      - Acknowledgment (AA=Accepted, AE=Error)
 ;    ERACT    - Error Action
 ;    ERCON    - Error Condition
 ;    ERFLG    - Error quit flag
 ;    ERTXT    - Error Message Text
 ;    HL       - Array of HL7 variables
 ;    IBSEG    - Optional, array of fields in segment
 ;    IIVSTAT  - EC generated flag interpreting status of response
 ;                1 = + (auto-update requirement)
 ;                6 = -
 ;                V = #
 ;                MBI% = %  ;will not receive from FSC, derived in FIL^IBCNEHL6
 ;                MBI# = #  ;will not receive from FSC, derived in FIL^IBCNEHL6
 ;    MAP      - Array that maps EC's IIV status flag to IIV STATUS TABLE (#365.15) IEN
 ;    MSGID    - Original Message Control ID
 ;    RIEN     - Response Record IEN
 ;    SEG      - HL7 Segment Name
 ;
 ; IB*2*621/TAZ - Added EVENTYP to control type of event processing.
 ;
 ; *** With IB*702, the code in the tag AUTOFIL was moved to another routine.
 ; *** Therefore, modifications from IB*631 and IB*687 are no longer found in this routine.
 ;
 ; IB*2*621/TAZ - Added to insure the routine is called via entry point EN with the event type.
 Q  ;No direct entry to routine. Call label EN with parameter
 ;
EN(EVENTYP) ;Entry Point
 ;EVENTYP=1 > EICD Identification Response (RPI^IO4)
 ;EVENTYP=2 > Normal 271 Response (RPI^IO1) 
 N ACK,AUTO,EBDA,ERACT,ERCON,ERFLG,ERROR,ERTXT,G2OFLG,HCT,HLCMP,HLREP,HLSCMP,IBTRACK
 N IIVSTAT,IRIEN,MAP,MGRP,RIEN,RSUPDT,SEG,SUBID,TRACE,TRKIEN,UP
 S (ERFLG,G2OFLG)=0,MGRP=$$MGRP^IBCNEUT5(),HCT=1,SUBID="",IIVSTAT=""
 ;
 S HLCMP=$E(HL("ECH")) ;HL7 component separator
 S HLSCMP=$E(HL("ECH"),4) ;HL7 subcomponent separator
 S HLREP=$E(HL("ECH"),2) ;HL7 repetition separator
 ; Create map from EC to VistA
 S MAP(1)=8,MAP(6)=9,MAP("V")=21   ;These are X12 codes mapped from EC to VistA
 S MAP("MBI%")=26,MAP("MBI#")=27   ;These are NOT X12 codes from FSC - we derive them only for MBI responses
 ;
 ; Loop through the message & find each segment for processing
 F  S HCT=$O(^TMP($J,"IBCNEHLI",HCT)) Q:HCT=""  D  Q:ERFLG
 .D SPAR^IBCNEHLU
 .S SEG=$G(IBSEG(1))
 .; check if we are inside G2O group of segments
 .I SEG="ZTY" S G2OFLG=1
 .I G2OFLG,SEG'="ZTY",SEG'="CTD" S G2OFLG=0
 .; If we are outside of Z_Benefit_group, kill EB multiple ien
 .; I +$G(EBDA),".MSH.MSA.PRD.PID.GT1.IN1.IN3."[("."_SEG_".")!('G2OFLG&(SEG="CTD")) K EBDA
 .;
 .Q:SEG="PRD"  ;IB*2*497 PRD segment is not processed
 .;
 .;IB*2*621 - The ZMS is an exact copy of MSA segment. It was added for the PIN^I07 message 
 .I SEG="MSA" D MSA^IBCNEHL2(.ERACT,.ERCON,.ERROR,.ERTXT,.IBSEG,MGRP,.RIEN,.TRACE,EVENTYP) Q
 .I SEG="ZMS" D MSA^IBCNEHL2(.ERACT,.ERCON,.ERROR,.ERTXT,.IBSEG,MGRP,.RIEN,.TRACE,EVENTYP) Q
 .;
 .;Contact Seg
 .I SEG="CTD",'G2OFLG D CTD^IBCNEHL2(.ERROR,.IBSEG,RIEN) Q
 .;
 .;Patient Seg
 .I SEG="PID" D PID^IBCNEHL2(.ERFLG,.ERROR,.IBSEG,RIEN) Q
 .;
 .;Guarantor Seg
 .;IB*2*621/TAZ Pass EVENTYP along
 .I SEG="GT1" D GT1^IBCNEHL2(.ERROR,.IBSEG,RIEN,.SUBID,EVENTYP) Q
 .;
 .;Insurance Seg
 .;IB*2*621/TAZ Pass EVENTYP along
 .I SEG="IN1" D IN1^IBCNEHL2(.ERROR,.IBSEG,RIEN,SUBID,EVENTYP) Q
 .;
 .;Addt'l Insurance Seg
 .;I SEG="IN2" ; for future expansion, add IN2 tag to IBCNEHL2
 .;
 .;Addt'l Insurance - Cert Seg
 .I SEG="IN3" D IN3^IBCNEHL2(.ERROR,.IBSEG,RIEN) Q 
 .;
 .;IB*2*497 GROUP LEVEL REFERENCE ID segment (x12 loops 2100C & 2100D)
 . I SEG="ZRF",'$D(EBDA) D GZRF^IBCNEHL5(.ERROR,.IBSEG,RIEN) Q
 .;
 .;Eligibility/Benefit Seg
 .I SEG="ZEB" D ZEB^IBCNEHL2(.EBDA,.ERROR,.IBSEG,RIEN) Q
 .;
 .;Healthcare Delivery Seg
 .I SEG="ZHS" D ZHS^IBCNEHL4(EBDA,.ERROR,.IBSEG,RIEN) Q
 .;
 .;Benefit level Reference ID Seg (X12 loops 2110C & 2110D)
 .I SEG="ZRF",+$G(EBDA) D ZRF^IBCNEHL4(EBDA,.ERROR,.IBSEG,RIEN) Q  ;IB*2*497 add check to make sure z benefit group
 .;
 .;Subscriber Date Seg
 .I SEG="ZSD" D ZSD^IBCNEHL4(EBDA,.ERROR,.IBSEG,RIEN) Q
 .;
 .;Subscriber Additional Info Seg
 .I SEG="ZII" D ZII^IBCNEHL4(EBDA,.ERROR,.IBSEG,RIEN) Q
 .;
 .;Benefit Related Entity Seg
 .I SEG="ZTY" D ZTY^IBCNEHL4(EBDA,.ERROR,.IBSEG,RIEN) Q
 .;
 .;Benefit Related Entity Contact Seg
 .I SEG="CTD",G2OFLG D G2OCTD^IBCNEHL4(EBDA,.ERROR,.IBSEG,RIEN) Q
 .;
 .;Benefit Related Entity Notes Seg
 .I SEG="NTE",+$G(EBDA) D EBNTE^IBCNEHL2(EBDA,.IBSEG,RIEN) Q
 .;
 .;Reject Reasons Seg
 .I SEG="ERR" K ERDA D ERR^IBCNEHL4(.ERDA,.ERROR,.IBSEG,RIEN) Q
 .;
 .;Notes Seg
 .I SEG="NTE",'$D(EBDA),+$G(ERDA) D NTE^IBCNEHL4(ERDA,.ERROR,.IBSEG,RIEN) Q
 .;
 .;Subscriber date seg (subscriber level)
 .I SEG="ZTP" D ZTP^IBCNEHL4(.ERROR,.IBSEG,RIEN) Q
 . ;ib*2*497 - add processing for ROL, DG1, & ZMP segments
 . ;Provider Code seg
 . I SEG="ROL" D ROL^IBCNEHL5(.ERROR,.IBSEG,RIEN) Q
 . ;
 . ;Health Care Diagnosis Code seg
 . I SEG="DG1" D DG1^IBCNEHL5(.ERROR,.IBSEG,RIEN) Q
 . ;
 . ;Military Personnel Information seg
 . I SEG="ZMP" D ZMP^IBCNEHL5(.ERROR,.IBSEG,RIEN)
 ;
 ;IB*2*621/TAZ - File EICD Identification Response
 I EVENTYP=1 S TRKIEN=$$SVEICD^IBCNEHL7()
 ;IB*2*621/TAZ - Update EIV EICD TRACKING FILE for EICD verification Response 
 I EVENTYP=2 D
 . N D0,D1,FDA,IENS,TQN,EXT
 . S TQN=$$GET1^DIQ(365,RIEN_",",.05,"I")
 . S EXT=$$GET1^DIQ(365.1,TQN_",",.1,"I")
 . I EXT'=4 Q
 . S D0=$O(^IBCN(365.18,"C",TQN,"")) Q:'D0  S D1=$O(^IBCN(365.18,"C",TQN,D0,"")) Q:'D1
 . S IENS=D1_","_D0_","
 . S FDA(365.185,IENS,1.03)=RIEN
 . I ERACT'=""!(ERTXT'="") S FDA(365.185,IENS,1.04)=0  ;Error response
 . I IIVSTAT=1 S FDA(365.185,IENS,1.04)=1  ;Active
 . I IIVSTAT=6 S FDA(365.185,IENS,1.04)=2  ;Inactive
 . I IIVSTAT="V" S FDA(365.185,IENS,1.04)=3  ;Ambiguous
 . D FILE^DIE("","FDA"),CLEAN^DILF
 ;
 ; IB*702/DTG start set auto eiv user name
 N IBEIVUSR
 S IBEIVUSR="AUTOUPDATE,IBEIV"
 ; IB*702/DTG end set auto eiv user name
 S AUTO=$$AUTOUPD(RIEN)
 I $G(ACK)'="AE",$G(ERACT)="",$G(ERTXT)="",'$D(ERROR),+AUTO D  Q
 .D:$P(AUTO,U,3)'="" AUTOFIL($P(AUTO,U,2),$P(AUTO,U,3),$P(AUTO,U,6))
 .D:$P(AUTO,U,4)'="" AUTOFIL($P(AUTO,U,2),$P(AUTO,U,4),$P(AUTO,U,6))
 .Q
 D FIL
 ;
ENX ;
 Q
 ;
 ;=================================================================
 ; IB*702/DTG start move body of AUTOFIL to IBCNEHL5 for SAC space size.
AUTOFIL(DFN,IEN312,ISSUB) ;Finish processing the response message - file directly into patient insurance
 ;
 ; IB*702/DTG moved autofil to IBCNEHL5 due to routine file size
 ;IB*732/CKB&TAZ - Loop through each insurance type IEN and file
 N INSIEN,PCE
 I $G(RIEN)="" G AUTOFILX
 F PCE=1:1 S INSIEN=$P(IEN312,"~",PCE) Q:INSIEN=""  D
 . D AUTOFIL^IBCNEHL5(DFN,INSIEN,ISSUB)
 ;
AUTOFILX ;
 Q
 ; IB*702/DTG end move body of AUTOFIL to IBCNEHL5 for SAC space size.
 ;
GRPFILE(DFN,IEN312,RIEN,AFLG) ;ib*2*497 file data at node 12 & at subfiles 2.312,9, 10 & 11
 ;DFN - file 2 ien
 ;IEN312 - file 2.312 ien
 ;RIEN = file 365 ien
 ;AFLG - 1 if called from autoupdate, 0 if called from ins. buffer process entry
 ;output - returns 0 or 1
 ;     0 - entry update received an error when attempting to file
 ;     1 - successful update
 N DA,DATA12,DIAG,DIAG3121,ERFLG,ERROR,IENS,IENS365,IENS312,NODE,PROV,PROV332,REF,REF3129,Z,Z2
 ;retrieve external values of data located at node 12 of 365
 S IENS=IEN312_","_DFN_","
 D GETS^DIQ(365,RIEN,"12.01:12.07",,"MIL")
 M DATA12(2.312,IENS)=MIL(365,RIEN_",")
 D FILE^DIE("ET","DATA12","ERROR")
 I $D(ERROR) D:AFLG WARN^IBCNEHL3 K ERROR
 ;remove existing sub-file entries at nodes 9, 10, & 11 before update of new data
 F NODE="9","10","11" D
 . S DIK="^DPT("_DFN_",.312,"_IEN312_","_NODE_",",DA(2)=DFN,DA(1)=IEN312
 . S DA=0 F  S DA=$O(^DPT(DFN,.312,IEN312,NODE,DA)) Q:DA=""!(DA?1.A)  D ^DIK
 S IENS312="+1,"_IEN312_","_DFN_","
 ;update node 9 data
 S Z="" F  S Z=$O(^IBCN(365,RIEN,9,"B",Z)) Q:'Z  D
 . S IENS365=$O(^IBCN(365,RIEN,9,"B",Z,""))_","_RIEN_","
 . D GETS^DIQ(365.09,IENS365,"*",,"REF")
 S Z2="" F  S Z2=$O(REF(365.09,Z2)) Q:Z2=""  M REF3129(2.3129,IENS312)=REF(365.09,Z2) D UPDATE^DIE("E","REF3129",,"ERROR") K REF3129 I $D(ERROR) D:AFLG WARN^IBCNEHL3 K ERROR
 ;update node 10 data
 S Z="" F  S Z=$O(^IBCN(365,RIEN,10,"B",Z)) Q:'Z  D
 . S IENS365=$O(^IBCN(365,RIEN,10,"B",Z,""))_","_RIEN_","
 . D GETS^DIQ(365.04,IENS365,"*",,"PROV")
 S Z2="" F  S Z2=$O(PROV(365.04,Z2)) Q:Z2=""  M PROV332(2.332,IENS312)=PROV(365.04,Z2) D UPDATE^DIE("E","PROV332",,"ERROR") K PROV332 I $D(ERROR) D:AFLG WARN^IBCNEHL3 K ERROR
 ;update node 11 data
 S Z="" F  S Z=$O(^IBCN(365,RIEN,11,"B",Z)) Q:'Z  D
 . S IENS365=$O(^IBCN(365,RIEN,11,"B",Z,""))_","_RIEN_","
 . D GETS^DIQ(365.01,IENS365,"*",,"DIAG")
 S Z2="" F  S Z2=$O(DIAG(365.01,Z2)) Q:Z2=""  M DIAG3121(2.31211,IENS312)=DIAG(365.01,Z2) D UPDATE^DIE("E","DIAG3121",,"ERROR") K DIAG3121 I $D(ERROR) D:AFLG WARN^IBCNEHL3 K ERROR
GRPFILEX ;
 Q $G(ERFLG)
 ;
FIL ;Finish processing the response message - file into insurance buffer
 ;IB*2*601/DM FIL()routine moved to IBCNEHL6 to meet SAC guidelines due to size
 D FIL^IBCNEHL6
 Q
 ;
AUTOUPD(RIEN) ;
 ;Returns "1^file 2 ien^file 2.312 ien^2nd file 2.312 ien^Medicare flag^subscriber flag", if entry
 ;in file 365 is eligible for auto-update, returns 0 otherwise.
 ;
 ;Medicare flag: 1 for Medicare, 0 otherwise
 ;Subscriber flag: 1 if patient is the subscriber, 0 otherwise
 ;
 ;For non-Medicare response: 1st file 2.312 ien is set, 2nd file 2.312 ien is empty, pieces 5-7 are empty
 ;For Medicare response: 1st file 2.312 ien contains ien for Medicare Part A, 2nd file 2.312 ien contains ien for Medicare Part B,
 ;                       either one may be empty, but at least one of them is set if entry is eligible.
 ;
 ;RIEN - ien in file 365
 ;
 ;IB*732/CKB&TAZ - New ISBLUE
 N APPIEN,GDATA,GIEN,GNAME,GNUM,GNUM1,GOK,IEN2,IEN312,IEN36,IDATA0,IDATA3,ISSUB,MWNRA,MWNRB,MWNRIEN,MWNRTYP
 N ONEPOL,PIEN,RDATA0,RDATA1,RES,TQIEN,IDATA7,RDATA13,RDATA14,ISBLUE
 N IBGETTQ,IBGETWE,IBGETSTC,IBGETDEF,IBGETNOK
 S RES=0
 I +$G(RIEN)'>0 Q RES          ;Invalid ien for file 365
 ;IB*2*595/DM if entry is missing from #200, file in buffer
 I '$$FIND1^DIC(200,,"M",IBEIVUSR) Q RES  ; IB*702/DTG change user name ("AUTOUPDATE,IBEIV") to use var.
 ;
 ;IB*2*549 - Moved up the next 5 lines. Originally, these lines were
 ;             directly after line 'I $G(IIVSTAT)'=1 Q RES'
 S RDATA0=$G(^IBCN(365,RIEN,0)),RDATA1=$G(^IBCN(365,RIEN,1))
 ;
 ;IB*2*497 - longer fields for GROUP NAME, GROUP NUMBER, NAME OF INSURED, & SUBSCRIBER ID
 S RDATA13=$G(^IBCN(365,RIEN,13)),RDATA14=$G(^IBCN(365,RIEN,14))
 S PIEN=$P(RDATA0,U,3)
 S ISBLUE=$$GET1^DIQ(365.12,PIEN_",",.09,"I") ;IB*732/CKB&TAZ
 ;
 ;IB*2*549 - Moved up the next 2 lines.  Originally, these lines were
 ;             directly after 'S IEN2=$P(RDATA0,U,2) I +IEN2'>0 Q RES'
 S MWNRIEN=$P($G(^IBE(350.9,1,51)),U,25),MWNRTYP=0,(MWNRA,MWNRB)=""
 I PIEN=MWNRIEN S MWNRTYP=$$ISMCR^IBCNEHLU(RIEN)
 ;
 ;IB*2*549 - Added ',MWNRTYP' below to only quit for non-medicare policies
 I $G(IIVSTAT)'=1,'MWNRTYP Q RES     ;Only auto-update 'active policy' responses
 ;IB*2*668/TAZ - Changed app to EIV from IIV
 I +PIEN>0 S APPIEN=$$PYRAPP^IBCNEUT5("EIV",PIEN)
 I +$G(APPIEN)'>0 Q RES  ;couldn't find eIV application entry
 ;
 ;IB*2*601/HN Don't allow any entry with HMS SOI to auto-update
 ;IB*2*595/HN Don't allow any entry with Contract Services SOI to auto-update
 I $P(RDATA0,U,5)'="" I "^HMS^CONTRACT SERVICES^"[("^"_$$GET1^DIQ(365.1,$P(RDATA0,U,5)_",","SOURCE OF INFORMATION","E")_"^") Q RES  ; HAN IB*2*621
 ;
 ;IB*732/DTG start, allow auto update for some "Request Electronic Insurance Inquiry" requests
 ;
 ;Check dictionary 365.1 MANUAL REQUEST DATE/TIME Flag, Quit if Set.
 ;I $P(RDATA0,U,5)'="",$P($G(^IBCN(365.1,$P(RDATA0,U,5),3)),U,1)'="" Q RES
 ;
 ; get values
 S (IBGETTQ,IBGETDEF,IBGETWE,IBGETSTC)=""
 ; Get 365.1 transmission queue number
 S IBGETTQ=$$GET1^DIQ(365,RIEN_",",.05,"I") I IBGETTQ="" Q RES
 ; Get 365.1 which extract
 S IBGETNOK=0
 S IBGETWE=$$GET1^DIQ(365.1,IBGETTQ_",",.1,"I") I IBGETWE=5 D  I IBGETNOK Q RES
 . ; Get 350.9 default service type code
 . S IBGETDEF=$$GET1^DIQ(350.9,1_",",60.01,"I") I IBGETDEF="" S IBGETNOK=1 Q
 . ; Get 365 requested service type code
 . S IBGETSTC=$$GET1^DIQ(365,RIEN_",",.15,"I") I IBGETSTC'=IBGETDEF S IBGETNOK=1 Q
 ;
 ;IB*732/DTG end, allow auto update for some "Request Electronic Insurance Inquiry" requests
 ;
 ;IB*2*668/TAZ - Changed to new field location
 I '$$GET1^DIQ(365.121,APPIEN_","_PIEN_",",4.01,"I") Q RES  ; auto-accept is OFF
 S IEN2=$P(RDATA0,U,2) I +IEN2'>0 Q RES  ; couldn't find patient
 S ONEPOL=$$ONEPOL^IBCNEHLU(PIEN,IEN2)
 ;try to find a matching pat. insurance
 ;IB*732/CKB&TAZ - Modify next two lines to check for ISBLUE
 S IEN36="" F  S IEN36=$O(^DIC(36,"AC",PIEN,IEN36)) Q:IEN36=""  D  I 'ISBLUE&(RES>0) Q
 .S IEN312="" F  S IEN312=$O(^DPT(IEN2,.312,"B",IEN36,IEN312)) Q:IEN312=""  D  I ('ISBLUE)&(RES>0&('+MWNRTYP)) Q
 ..S IDATA0=$G(^DPT(IEN2,.312,IEN312,0)),IDATA3=$G(^DPT(IEN2,.312,IEN312,3))
 ..S IDATA7=$G(^DPT(IEN2,.312,IEN312,7))   ;IB*2*497 (vd)
 ..I $$EXPIRED^IBCNEDE2($P(IDATA0,U,4)) Q  ;Insurance policy has expired
 ..S ISSUB=$$PATISSUB^IBCNEHLU(IDATA0)
 ..;Patient is the subscriber
 ..I ISSUB,'$$CHK1^IBCNEHL3 Q
 ..;Patient is the dependent
 ..I 'ISSUB,'$$CHK2^IBCNEHL3(MWNRTYP) Q
 ..;check group #
 ..S GNUM=$P(RDATA14,U,2),GIEN=+$P(IDATA0,U,18),GOK=1  ;IB*2*497 - group # needs to be retrieved from new field
 ..;check non-Medicare group #
 ..I '+MWNRTYP D  Q:'GOK  ;Group # doesn't match
 ...I 'ONEPOL D
 ....I GIEN'>0 S GOK=0 Q
 ....S GNUM1=$P($G(^IBA(355.3,GIEN,2)),U,2)   ;IB*2*497 (vd)
 ....I GNUM=""!(GNUM1="")!(GNUM'=GNUM1) S GOK=0
 ....Q
 ...I ONEPOL D
 ....I GNUM'="",GIEN'="" S GNUM1=$P($G(^IBA(355.3,GIEN,2)),U,2) I GNUM1'="",GNUM'=GNUM1 S GOK=0  ;IB*2*497 (vd)
 ....Q
 ...Q
 ..;check for Medicare part A/B
 ..I +MWNRTYP D  Q:'GOK  ;Group # doesn't match
 ...I GIEN'>0 S GOK=0 Q
 ...S GDATA=$G(^IBA(355.3,GIEN,0))
 ...I $P(GDATA,U,14)="A" D
 ....;IB*2*549 Change $P(MWNRTYP,U,2)="MA"!($P(MWNRTYP,U,2)="B")
 ....;           To     $P(MWNRTYP,U,5)="MA"!($P(MWNRTYP,U,5)="B")
 ....I $P(MWNRTYP,U,5)="MA"!($P(MWNRTYP,U,5)="B") S MWNRA=IEN312 Q
 ....S GOK=0
 ....Q
 ...I $P(GDATA,U,14)="B" D
 ....;IB*2*549 Change $P(MWNRTYP,U,2)="MB"!($P(MWNRTYP,U,2)="B")
 ....;           To     $P(MWNRTYP,U,5)="MB"!($P(MWNRTYP,U,5)="B")
 ....I $P(MWNRTYP,U,5)="MB"!($P(MWNRTYP,U,5)="B") S MWNRB=IEN312 Q
 ....S GOK=0
 ....Q
 ...Q
 ..;IB*732/CKB&TAZ - Restructured building RES string
 ..I +MWNRTYP S RES=1_U_IEN2_U_MWNRA_U_MWNRB_U_1_U_ISSUB Q   ;Process MWNR
 ..I ISBLUE S P3=$P(RES,U,3),P3=P3_$S($L(P3):"~",1:"")_IEN312,RES=1_U_IEN2_U_P3_U_U_0_U_ISSUB Q  ;Process Blues
 ..S RES=1_U_IEN2_U_IEN312_U_U_0_U_ISSUB  ;Process non-MWNR and Non-Blue
 .Q
 Q RES
 ;
EBFILE(DFN,IEN312,RIEN,AFLG) ;File eligibility/benefit data from file 365 into file 2.312
 ;Input:   DFN    - Internal Patient IEN
 ;         IEN312 - Insurance multiple #
 ;         RIEN   - file 365 ien
 ;         AFLG   - 1 if called from autoupdate
 ;                  0 if called from ins. buffer process entry
 ;Returns: "" on success, ERFLG on failure. Also called from ACCEPT^IBCNBAR
 ;         for manual processing of ins. buffer entry.
 ;
 Q $$EBFILE^IBCNEHL5(DFN,IEN312,RIEN,AFLG)  ;IB*2*549 moved because of routine size
 ;

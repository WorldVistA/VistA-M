IBCNEHL1 ;DAOU/ALA - HL7 Process Incoming RPI Messages ; 26-JUN-2002
 ;;2.0;INTEGRATED BILLING;**300,345,416,444,438,497,506,549,593,601,595,621,631,668,687,702,732,743,771,806**;21-MAR-94;Build 19
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
 ; IB*806/DJW & CKB - Moved tag AUTOUPD to ^IBCNEHL1A ; therefore this dropped comments
 ;                 related to the following patches: IB*497,549,595,601,668,702,732,771,702.
 ;
 ; IB*621/TAZ - Added EVENTYP to control type of event processing.
 ;
 ; *** With IB*702, the code in the tag AUTOFIL was moved to another routine.
 ; *** Therefore, modifications from IB*631 and IB*687 are no longer found in this routine.
 ;
 ; IB*621/TAZ - Added to insure the routine is called via entry point EN with the event type.
 Q  ;No direct entry to routine. Call label EN with parameter
 ;
EN(EVENTYP) ;Entry Point
 ;EVENTYP=1 > EICD Identification Response (RPI^IO4)
 ;EVENTYP=2 > Normal 271 Response (RPI^IO1) 
 N ACK,AUTO,EBDA,ERACT,ERCON,ERFLG,ERROR,ERTXT,G2OFLG,HCT,HLCMP,HLREP,HLSCMP,IBTRACK
 N IIVSTAT,IRIEN,MAP,MGRP,RIEN,RSUPDT,SEG,SUBID,TRACE,TRKIEN,UP
 S (ERFLG,G2OFLG)=0,MGRP=$$MGRP^IBCNEUT5(),HCT=1,SUBID="",IIVSTAT=""
 ;
 S HLCMP=$E(HL("ECH"))    ;HL7 component separator
 S HLSCMP=$E(HL("ECH"),4) ;HL7 subcomponent separator
 S HLREP=$E(HL("ECH"),2)  ;HL7 repetition separator
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
 .Q:SEG="PRD"  ;IB*497 PRD segment is not processed
 .;
 .;IB*621 - The ZMS is an exact copy of MSA segment. It was added for the PIN^I07 message
 .; MSA logic closes out the file #365.1 & #365 - marks the status as "Response Received", (ien code=3)
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
 .;IB*621/TAZ Pass EVENTYP along
 .I SEG="GT1" D GT1^IBCNEHL2(.ERROR,.IBSEG,RIEN,.SUBID,EVENTYP) Q
 .;
 .;Insurance Seg
 .;IB*621/TAZ Pass EVENTYP along
 .I SEG="IN1" D IN1^IBCNEHL2(.ERROR,.IBSEG,RIEN,SUBID,EVENTYP) Q
 .;
 .;Addt'l Insurance Seg
 .;I SEG="IN2" ; for future expansion, add IN2 tag to IBCNEHL2
 .;
 .;Addt'l Insurance - Cert Seg
 .I SEG="IN3" D IN3^IBCNEHL2(.ERROR,.IBSEG,RIEN) Q 
 .;
 .;IB*497 GROUP LEVEL REFERENCE ID segment (x12 loops 2100C & 2100D)
 . I SEG="ZRF",'$D(EBDA) D GZRF^IBCNEHL5(.ERROR,.IBSEG,RIEN) Q
 .;
 .;Eligibility/Benefit Seg
 .I SEG="ZEB" D ZEB^IBCNEHL2(.EBDA,.ERROR,.IBSEG,RIEN) Q
 .;
 .;Healthcare Delivery Seg
 .I SEG="ZHS" D ZHS^IBCNEHL4(EBDA,.ERROR,.IBSEG,RIEN) Q
 .;
 .;Benefit level Reference ID Seg (X12 loops 2110C & 2110D)
 .I SEG="ZRF",+$G(EBDA) D ZRF^IBCNEHL4(EBDA,.ERROR,.IBSEG,RIEN) Q  ;IB*497 add check to make sure z benefit group
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
 .;
 .;Provider Code seg
 .I SEG="ROL" D ROL^IBCNEHL5(.ERROR,.IBSEG,RIEN) Q  ;IB*497 - added
 .;
 .;Health Care Diagnosis Code seg
 .I SEG="DG1" D DG1^IBCNEHL5(.ERROR,.IBSEG,RIEN) Q  ;IB*497 - added
 .;
 .;Military Personnel Information seg
 .I SEG="ZMP" D ZMP^IBCNEHL5(.ERROR,.IBSEG,RIEN)    ;IB*497 - added
 ;
 ;
 ;IB*621/TAZ - File EICD Identification Response
 I EVENTYP=1 S TRKIEN=$$SVEICD^IBCNEHL7()
 ;
 ;IB*621/TAZ - Update EIV EICD TRACKING FILE for EICD verification Response 
 I EVENTYP=2 D
 . N D0,D1,FDA,IENS,TQN,EXT
 . S TQN=$$GET1^DIQ(365,RIEN_",",.05,"I")
 . S EXT=$$GET1^DIQ(365.1,TQN_",",.1,"I")
 . I EXT'=4 Q
 . S D0=$O(^IBCN(365.18,"C",TQN,"")) Q:'D0  S D1=$O(^IBCN(365.18,"C",TQN,D0,"")) Q:'D1
 . S IENS=D1_","_D0_","
 . S FDA(365.185,IENS,1.03)=RIEN
 . I ERACT'=""!(ERTXT'="") S FDA(365.185,IENS,1.04)=0  ;Error response
 . I IIVSTAT=1 S FDA(365.185,IENS,1.04)=1     ;Active
 . I IIVSTAT=6 S FDA(365.185,IENS,1.04)=2     ;Inactive
 . I IIVSTAT="V" S FDA(365.185,IENS,1.04)=3   ;Ambiguous
 . D FILE^DIE("","FDA"),CLEAN^DILF
 ;
 ;
 ;  *** Can we auto update ?  (It checks for Auto load for Medicare as well
 ;
 ;IB*702/DTG - Add variable IBEIVUSR for the auto eiv user (proxy in file #200) and added P3
 ;IB*806/DJW - Add variable LOAD (logic for Medicare policies loading in file #2 automatically)
 N IBEIVUSR,LOAD,P3
 S IBEIVUSR="AUTOUPDATE,IBEIV",LOAD=0
 ;  $$AUTOUPD can set LOAD when policy is Medicare (WNR)
 S AUTO=$$AUTOUPD^IBCNEHL1A(RIEN)  ; 1=AUTO-UPDATE response  0=Save response to the buffer
 ;
 ;
 ;
 ;IB*771/DW ***Temporary fix required by VA eInsurance eBusiness team 'ERROR'
 ;             is set when there is a problem filing part of the eIV payer
 ;             response. (i.e. payer sends code that is not in file #353.1)
 ;             Per eBiz, (Dec. 2023) do not let the existence of ERROR stop a
 ;             eIV response from Auto-Updating.
 ;   
 ;
 I $G(ACK)'="AE",$G(ERACT)="",$G(ERTXT)="",+AUTO D  G ENX              ; Updates patient record & files #365, #365.1 etc.
 . ;IB*743/TAZ - Updated code to lock the Buffer entries.
 . N AUBUFF,AUOK,AULOCK
 . S (AUOK,AULOCK)=0
 . S AUBUFF=$$GET1^DIQ(365,RIEN,.04,"I")
 . ;If Buffer Entry attempt to Lock, otherwise fall through to attempt to AUTOFIL.
 . I AUBUFF D  I 'AUOK Q
 .. N BUFFSTAT
 .. ;Check for Buffer Status.  Quit if not ENTERED.
 .. S BUFFSTAT=$$GET1^DIQ(355.33,AUBUFF,.04,"I") I BUFFSTAT'="E" Q
 .. ;Get Lock
 .. S AULOCK=$$BUFLOCK^IBCNEHL6(AUBUFF,1)
 .. ;Re-Check Status.  Quit if not ENTERED.
 .. S BUFFSTAT=$$GET1^DIQ(355.33,AUBUFF,.04,"I") I BUFFSTAT'="E" Q
 .. S AUOK=1 ; regardless if locked we are going to update buffer
 . D:$P(AUTO,U,3)'="" AUTOFIL($P(AUTO,U,2),$P(AUTO,U,3),$P(AUTO,U,6))  ;AUTO-UPDATE
 . D:$P(AUTO,U,4)'="" AUTOFIL($P(AUTO,U,2),$P(AUTO,U,4),$P(AUTO,U,6))
 . ;Unlock global if locked.
 . I AULOCK,$$BUFLOCK^IBCNEHL6(AUBUFF,0)
 ;
 ;                    ; IB*806/DJW If already loaded as a new policy don't do FIL
 I '$G(LOAD) D FIL    ; file response to buffer & wrap up files #365 & #365.1
ENX ;
 Q
 ;
 ;=================================================================
AUTOFIL(DFN,IEN312,ISSUB) ;Finish processing the response message 
 ;                         file directly into patient insurance
 ;
 ;IB*702/DTG - moved AUTOFIL to IBCNEHL5 due to routine file size
 ;IB*732/CKB&TAZ - Loop through each insurance type IEN and file
 N INSIEN,PCE
 I $G(RIEN)="" G AUTOFILX
 F PCE=1:1 S INSIEN=$P(IEN312,"~",PCE) Q:INSIEN=""  D
 . D AUTOFIL^IBCNEHL5(DFN,INSIEN,ISSUB)
 ;
AUTOFILX ;
 Q
 ;
 ; ---------------------------------------
GRPFILE(DFN,IEN312,RIEN,AFLG) ;IB*497 file data at node 12 & at subfiles 2.312, 9, 10 & 11
 ;    DFN - file 2 ien
 ; IEN312 - file 2.312 ien
 ;   RIEN - file 365 ien
 ;   AFLG - 1 if called from autoupdate, 0 if called from ins. buffer process entry
 ;
 ;output: 
 ;     0 - entry update received an error when attempting to file
 ;     1 - successful update
 N DA,DATA12,DIAG,DIAG3121,ERFLG,ERROR,IENS,IENS365,IENS312,NODE,PROV,PROV332,REF,REF3129,Z,Z2
 ;
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
 ; ---------------------------------------
FIL ;Finish processing the response message - file into insurance buffer
 ;IB*601/DM - FIL moved to IBCNEHL6 due to routine size
 D FIL^IBCNEHL6
 Q
 ;
 ; ------------------------------
EBFILE(DFN,IEN312,RIEN,AFLG) ;File eligibility/benefit data from file 365 into file 2.312
 ;Input:   DFN    - Internal Patient IEN
 ;         IEN312 - Insurance multiple #
 ;         RIEN   - file 365 ien
 ;         AFLG   - 1 if called from autoupdate
 ;                  0 if called from ins. buffer process entry
 ;Returns: "" on success, ERFLG on failure. Also called from ACCEPT^IBCNBAR
 ;         for manual processing of ins. buffer entry.
 ;
 Q $$EBFILE^IBCNEHL5(DFN,IEN312,RIEN,AFLG)  ;IB*549 moved because of routine size
 ; 
 ; -------------------------
EXPIRED(EXPDT) ; check if insurance policy has already expired
 ; EXPDT - expiration date (2.312/3)
 ; returns 1 if expiration date is in the past, 0 otherwise
 ;
 ; IB*771/DTG brought this tag for expired check into routine from IBCNEDE2
 N X1,X2
 S X1=+$G(DT),X2=+$G(EXPDT)
 I X1,X2 Q $S($$FMDIFF^XLFDT(DT,EXPDT,1)>0:1,1:0)
 Q 0

IBTRHLI1 ;ALB/JWS - Receive and store 278 Response message ;05-JUN-2014
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;**Program Description**
 ;  This program will process incoming HCS REVIEW TRANSMISSION FILE (356.22) ^IBT(356.22).
 ;  This includes updating the record in the HCSR IIV Response File
 ;
 ;  Variables
 ;    SEG = HL7 Segment Name
 ;    RESIEN = Response Record IEN
 ;    ERROR = processing error condition flag
 ;    IBSEG = array of segment field data values
EN ; Entry Point
 N ERROR,HLCMP,HLREP,HLSCMP,RESIEN,SEG,SLIEN,PEIEN,SLPIEN,REQIEN,HCT,IBSEG,BADERROR,STATUS
 K ^TMP($J,"IBTRHLI2")
 S HCT=0
 S HLCMP=$E(HL("ECH")) ; HL7 component separator
 S HLSCMP=$E(HL("ECH"),4) ; HL7 subcomponent separator
 S HLREP=$E(HL("ECH"),2) ; HL7 repetition separator
 ;  Loop through the message and find each segment for processing
 F  S HCT=$O(^TMP($J,"IBTRHLI",HCT)) Q:HCT=""  D  Q:$D(BADERROR)
 . D SPAR^IBTRHLU  ; returns all segment fields in IBSEG(field#) array
 . S SEG=$G(IBSEG(0))
 . I SEG="MSH" D MSH^IBTRHLI2(.IBSEG,.RESIEN,.ERROR) Q
 . I SEG="EVN" Q
 . I SEG="MSA" D MSA^IBTRHLI2(.IBSEG,.RESIEN,.ERROR) Q
 . I SEG="IN1" D IN1^IBTRHLI2(.IBSEG,.RESIEN,.ERROR) Q
 . I SEG="PV1" D PV1^IBTRHLI2(.IBSEG,.RESIEN,.ERROR) Q
 . I SEG="PRD" D  Q
 .. I $P($G(IBSEG(1)),HLCMP,4)="NM1 2010B" Q
 .. I $P($G(IBSEG(1)),HLCMP,4)="PRV 2010B" Q
 .. I $P($G(IBSEG(1)),HLCMP,4)="NM1 2010EA" D PRD^IBTRHLI2(.IBSEG,.RESIEN,.ERROR,.PEIEN,.SLIEN,.SLPIEN) Q
 .. I $P($G(IBSEG(1)),HLCMP,4)="PRV 2010EA" Q
 .. I $P($G(IBSEG(1)),HLCMP,4)="NM1 2010EC" D PRD^IBTRHLI2(.IBSEG,.RESIEN,.ERROR,.PEIEN,.SLIEN,.SLPIEN) Q
 .. I $P($G(IBSEG(1)),HLCMP,4)="NM1 2010FA" D PRD^IBTRHLI2(.IBSEG,.RESIEN,.ERROR,.PEIEN,.SLIEN,.SLPIEN) Q
 .. I $P($G(IBSEG(1)),HLCMP,4)="PRV 2010FA" Q
 . I SEG="CTD",$G(IBSEG(1))="PER 2010EB" D CTD^IBTRHLI3(.IBSEG,.RESIEN,.ERROR,.PEIEN,.SLIEN,.SLPIEN) Q
 . I SEG="GT1" Q
 . I SEG="PID" Q
 . I SEG="PRB" D PRB^IBTRHLI2(.IBSEG,.RESIEN,.ERROR,.SLIEN) Q
 . I SEG="AUT" D AUT^IBTRHLI2(.IBSEG,.RESIEN,.ERROR,.SLIEN) Q
 . I SEG="ZTP" D ZTP^IBTRHLI3(.IBSEG,.RESIEN,.ERROR,.SLIEN) Q
 . I SEG="DG1" D DG1^IBTRHLI3(.IBSEG,.RESIEN,.ERROR,.SLIEN) Q
 . I SEG="ZHS" D ZHS^IBTRHLI3(.IBSEG,.RESIEN,.ERROR,.SLIEN) Q
 . I SEG="OBR" D OBR^IBTRHLI2(.IBSEG,.RESIEN,.ERROR) Q
 . I SEG="RXA" D RXA^IBTRHLI3(.IBSEG,.RESIEN,.ERROR) Q
 . I SEG="RXE" D RXE^IBTRHLI3(.IBSEG,.RESIEN,.ERROR) Q
 . I SEG="PSL" D PSL^IBTRHLI3(.IBSEG,.RESIEN,.ERROR,.SLIEN) Q
 . I SEG="NTE" D NTE^IBTRHLI3(.IBSEG,.RESIEN,.ERROR) Q
 . I SEG="NK1" D NK1^IBTRHLI3(.IBSEG,.RESIEN,.ERROR,.PEIEN) Q
 ; set final status of message
 I $G(RESIEN) S IBFDA(356.22,RESIEN_",",.08)=$G(STATUS) K ERROR D FILE^DIE("","IBFDA","ERROR")
 I $G(REQIEN) S IBFDA(356.22,REQIEN_",",.08)=$G(STATUS) K ERROR D FILE^DIE("","IBFDA","ERROR")
 Q
 ;
SLCHECK ; check what service line is being processed
 I '$G(SLIEN) G SLCHECK1
 I $P($G(^IBT(356.22,RESIEN,16,SLIEN,1)),"^")="",$P($G(^(1)),"^",2)="" S LEV1=$G(SLIEN)_","_RESIEN_"," Q
SLCHECK1 ; if not already defined, set new service line entry
 S CT=$O(^IBT(356.22,RESIEN,16,"A"),-1)+1
 S LEV1="+2,"_RESIEN_","
 S IBFDA(356.2216,LEV1,.01)=CT ;SEQ
 D UP^IBTRHLI2("SL","2000F") S SLIEN=$G(RIEN(2)) ;SERVICE LINE IEN
 S LEV1=SLIEN_","_RESIEN_","
 Q
 ; =================================================================

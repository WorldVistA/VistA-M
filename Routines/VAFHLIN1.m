VAFHLIN1 ;ALB/KCL/SCK/PHH,TDM - CREATE HL7 INSURANCE (IN1) SEGMENT ; 1/21/09 4:05pm
 ;;5.3;Registration;**122,190,670,740,754**;Aug 13, 1993;Build 46
 ;
 ;
 ;  This generic function was designed to return the HL7 IN1 (Insurance)
 ;  segment.  This segment contains VA-specific patient insurance
 ;  information. (All active insurance data for a patient including
 ;  those insurance carriers that do not reimburse the VA i.e Medicare)
 ;
 ;  SCK - modified for Insurance Encapsulation API
 ;  1. The Insurance API does not currently support the Pre-Certification flag
 ;  in the IN1 segment, Field 28.  No value will be returned for field 28.
 ;  2.  The Insurance API does not support Line 2 or Line 3 of the address.
 ;  The API returns a single address line.
 ;
EN(DFN,VAFSTR,VAFHLQ,VAFHLFS,VAFARRY,VAFHLECH) ; --
 ; Entry point to return HL7 IN1 segments.
 ;
 ;  Input:
 ;       DFN - internal entry number of the PATIENT (#2) file.
 ;    VAFSTR - (optional) string of fields requested seperated
 ;             by commas.  If not passed, return all data fields.
 ;    VAFHLQ - (optional) HL7 null variable.
 ;   VAFHLFS - (optional) HL7 field separator.
 ;   VAFARRY - (optional) user-supplied array name which will hold
 ;             HL7 IN1 segments.  Otherwise, ^TMP("VAFIN1",$J) will
 ;             be used.
 ;  VAFHLECH - (optional) HL7 encoding characters.
 ;
 ; Output:
 ;      Array of HL7 IN1 segments
 ;
 N VAFGRP,VAFI,VAFIDX,VAFINS,VAFNODE,VAFPHN,VAFY,VAF36,X,VAFX,VAFTMP
 S VAFARRY=$G(VAFARRY),VAFIDX=0
 ;
 ; if VAFARRY not defined, use ^TMP("VAFIN1",$J)
 S:(VAFARRY="") VAFARRY="^TMP(""VAFIN1"",$J)"
 ;
 ; if VAFHLQ or VAFHLFS not passed, use default HL7 variables
 S VAFHLQ=$S($D(VAFHLQ):VAFHLQ,1:$G(HLQ)),VAFHLFS=$S($D(VAFHLFS):VAFHLFS,1:$G(HLFS))
 S VAFHLECH=$S($D(VAFHLECH):VAFHLECH,1:$G(HLECH))
 ;
 ; if DFN not passed, exit
 I '$G(DFN) S @VAFARRY@(1,0)="IN1"_VAFHLFS_1 G ENQ
 ;
 ; find all insurance data for a patient (IB SUPPORTED CALL)
 ; This uses the Encapsulated Insurance API to retrieve data into an array
 ; See IB*2*267 Release Notes v1.0 for flags and array ID's
 S VAFX=$$INSUR^IBBAPI(DFN,,"R",.VAFTMP,"*")
 ;
 ; if no active insurance on file for patient, build IN1
 I VAFX'=1 D
 .; Build a null array if no insurance data returned
 . F VAFI=1:1:24 S VAFINS(1,VAFI)=""
 .; Merge array to remove first two nodes to simplify handling
 E  M VAFINS=VAFTMP("IBBAPI","INSUR")
 ;
ALL ; get all active insurance for patient
 F VAFI=0:0 S VAFI=$O(VAFINS(VAFI)) Q:'VAFI  D
 .D BUILD
 ;
ENQ Q
 ;
 ;
BUILD ; Build array of HL7 (IN1) segments
 S $P(VAFY,VAFHLFS,36)="",VAFIDX=VAFIDX+1
 ;
 ; if VAFSTR not passed, return all data fields
 I $G(VAFSTR)']"" S VAFSTR="4,5,7,8,9,12,13,15,16,17,28,36"
 S VAFSTR=","_VAFSTR_","
 ;
 ; sequential number (required field)
 S $P(VAFY,VAFHLFS,1)=VAFIDX
 ;
 ; build HL7 (IN1) segment fields
 I VAFSTR[",3," S $P(VAFY,VAFHLFS,3)=+$P(VAFINS(VAFI,1),U) ;Insurance company IEN (P-190)
 I VAFSTR[",4," S $P(VAFY,VAFHLFS,4)=$S($P(VAFINS(VAFI,1),U,2)]"":$P(VAFINS(VAFI,1),U,2),1:VAFHLQ) ; Insurance Carrier Name
 I VAFSTR[",5," S X=$$ADDR1(VAFI) S $P(VAFY,VAFHLFS,5)=$S(+X>0:X,1:VAFHLQ)
 I VAFSTR[",7," S X=$$HLPHONE^HLFNC(VAFINS(VAFI,6)) S $P(VAFY,VAFHLFS,7)=$S(X]"":X,1:VAFHLQ) ; Insurance Co. Phone Number
 I VAFSTR[",8," S $P(VAFY,VAFHLFS,8)=$S(VAFINS(VAFI,18)]"":VAFINS(VAFI,18),1:VAFHLQ) ; Group Number
 I VAFSTR[",9," S $P(VAFY,VAFHLFS,9)=$S($P(VAFINS(VAFI,8),U,2)]"":$P(VAFINS(VAFI,8),U,2),1:VAFHLQ) ; Group Name ** The Insurance Encapsulation API doesnot return a "Group" Name, this field will display the Policy Name returned by the API
 I VAFSTR[",12," S X=$$HLDATE^HLFNC(VAFINS(VAFI,10)) S $P(VAFY,VAFHLFS,12)=$S(X]"":X,1:VAFHLQ) ; Policy Effective Date
 I VAFSTR[",13," S X=$$HLDATE^HLFNC(VAFINS(VAFI,11)) S $P(VAFY,VAFHLFS,13)=$S(X]"":X,1:VAFHLQ) ; Policy Expiration Date
 I VAFSTR[",15," S $P(VAFY,VAFHLFS,15)=$S(+$P($G(VAFINS(VAFI,21)),"^")>0:+$P(VAFINS(VAFI,21),"^"),1:VAFHLQ) ; Plan Type (ptr. to Type of Plan (#355.1) file)
 I VAFSTR[",16," S $P(VAFY,VAFHLFS,16)=$S(VAFINS(VAFI,13)]"":VAFINS(VAFI,13),1:VAFHLQ) ; Name of Insured
 I VAFSTR[",17," S X=$$WHOSE($P(VAFINS(VAFI,12),U)) S $P(VAFY,VAFHLFS,17)=$S(X]"":X,1:VAFHLQ) ; Whose Insurance
 ;I VAFSTR[",28," S $P(VAFY,VAFHLFS,28)=VAFHLQ ; $S($P(VAFGRP,"^",6)]"":$P(VAFGRP,"^",6),1:VAFHLQ) ; Is Pre-Certification Required?
 I VAFSTR[",36," S $P(VAFY,VAFHLFS,36)=$S(VAFINS(VAFI,14)]"":VAFINS(VAFI,14),1:VAFHLQ) ; Subscriber ID
 ;
 ; set all active insurance policies into array
 S @VAFARRY@(VAFIDX,0)="IN1"_VAFHLFS_$G(VAFY)
 Q
 ;
WHOSE(VAFWHO) ; Format Subscriber relationship for HL7 conversion
 ;
 ;  Input:  Subscriber relationship from Insurance API, ID=12
 ;    P - Patient
 ;    S - Spouse
 ;    O - Other
 ;
 ;  Output:
 ;    v - Veteran
 ;    s - Spouse
 ;    o - Other
 ;
 S:VAFWHO["P" VAFWHO="V"
 Q $$LOW^XLFSTR(VAFWHO)
 ;
ADDR1(VAFI) ; Format insurance company address from Insurance API for HL7 conversion.
 ;
 ; Input:
 ;   Index number for Insurance API array
 ;
 ; Output:
 ;   String in the form of the HL7 address field
 ;
 N VAFAD,VAFGL,RETVAL
 S VAFAD=VAFINS(VAFI,2)_"^"_VAFINS(VAFI,23)  ;Ins Addr Line 1 & 2
 S VAFGL=VAFINS(VAFI,3)_"^"_$P(VAFINS(VAFI,4),U)_"^"_VAFINS(VAFI,5)
 ;
 ; convert DHCP address to HL7 format using HL7 utility
 S RETVAL=$$HLADDR^HLFNC(VAFAD,VAFGL)
 S $P(RETVAL,$E(VAFHLECH),8)=VAFINS(VAFI,24)   ;Ins Addr Line 3
 Q RETVAL
 ;
ADDR(VAFPTR) ; Format insurance company address for HL7 conversion
 ; Retained for backword compatibility
 ;
 ;  Input:  
 ;    VAFPTR - pointer to Insurance Co. (#36) file 
 ;
 ; Output:
 ;    String in the form of the HL7 address field
 ;
 N VAFAD,VAFADDR,VAFGL,VAFST
 S VAFAD=""
 ;
 ; get (.11) node of Insurance Co. (#36) file
 S VAFADDR=$G(^DIC(36,+VAFPTR,.11))
 ;
 ; 1st & 2nd street address lines
 F VAFST=1,2 S VAFAD=VAFAD_"^"_$P(VAFADDR,"^",VAFST)
 S VAFAD=$P(VAFAD,"^",2,99)
 S VAFGL=$P(VAFADDR,"^",4) ; city
 S VAFGL=VAFGL_"^"_$P(VAFADDR,"^",5) ; state
 S VAFGL=VAFGL_"^"_$P(VAFADDR,"^",6) ; zip
 ;
 ; convert DHCP address to HL7 format using HL7 utility
 Q $$HLADDR^HLFNC(VAFAD,VAFGL)

VAFHLZBT ;ALB/KCL,CKN - CREATE HL7 BENEFICIARY TRAVEL (ZBT) SEGMENT ; 12/6/06 3:25pm
 ;;5.3;Registration;**122,688**;Aug 13, 1993;Build 29
 ;
 ;
 ; This generic extrinsic function is designed to return the HL7
 ; Beneficiary Travel (ZBT) segment.  This segment contains VA-
 ; specific Beneficiary Travel data for a selected patient.
 ;
 ;
EN(VAFDATE,VAFSTR,VAFHLQ,VAFHLFS) ; --
 ; Entry point for creating HL7 ZBT segment
 ;
 ; Input(s): 
 ;    VAFDATE - internal entry number of Bene Travel Claim (#392) file
 ;     VAFSTR - (optional) string of fields requested, separated by
 ;              commas.  If not passed, return all data fields.
 ;     VAFHLQ - (optional) HL7 null variable.
 ;    VAFHLFS - (optional) HL7 field separator.
 ;
 ;   Output:
 ;    String containing the desired components of the HL7 ZBT segment
 ;
 ;
 N VAFANOD,VAFCERT,VAFCLM,VAFMTS,VAFY,X,Y
 ;
 ; if VAFHLQ or VAFHLFS not passed, use default HL7 variables
 S VAFHLQ=$S($D(VAFHLQ):VAFHLQ,1:$G(HLQ)),VAFHLFS=$S($D(VAFHLFS):VAFHLFS,1:$G(HLFS))
 ;
 ;If VAFDATE not passed, populate all valid seq. with ""(dbl quotes)
 I '$G(VAFDATE) D  G ENQ
 . S VAFY=1
 . I $G(VAFSTR) F I=2:1:$L(VAFSTR,",") S $P(VAFY,VAFHLFS,$P(VAFSTR,",",I))=VAFHLQ
 . E  F I=2:1:7 S $P(VAFY,VAFHLFS,I)=VAFHLQ
 ;
 ; zero node from BENE TRAVEL CLAIM (#392) file
 S VAFCLM=$G(^DGBT(392,VAFDATE,0))
 ; convert 5th piece to pointer value
 S Y=0,X=$P(VAFCLM,"^",5) I X'="" D ^%DT S X=9999999-Y
 ;
 ; zero & 'A' node from BENE TRAVEL CERT. (#392.2) file
 S VAFCERT=$G(^DGBT(392.2,+$O(^DGBT(392.2,"C",+$P(VAFCLM,"^",2),+X)),0)),VAFANOD=$G(^("A"))
 I VAFCERT="" S VAFCERT=$G(^DGBT(392.2,+$O(^DGBT(392.2,"C",+$P(VAFCLM,"^",2),0)),0)),VAFANOD=$G(^("A"))
 ;
 ;If no certificate, populate all valid seq. with ""(dbl quotes)
 I VAFCERT="" D  G ENQ
 . S VAFY=1
 . I $G(VAFSTR) F I=2:1:$L(VAFSTR,",") S $P(VAFY,VAFHLFS,$P(VAFSTR,",",I))=VAFHLQ
 . E  F I=2:1:7 S $P(VAFY,VAFHLFS,I)=VAFHLQ
 ;
 ; if VAFSTR not passed, return all data fields
 I $G(VAFSTR)']"" S VAFSTR="2,3,4,5,6,7"
 S $P(VAFY,VAFHLFS,8)="",VAFSTR=","_VAFSTR_","
 ;
 S $P(VAFY,VAFHLFS,1)=1 ; Set Id - always 1
 I VAFSTR[",2," S $P(VAFY,VAFHLFS,2)=$S($P(VAFCERT,"^",1)]"":$$HLDATE^HLFNC($P(VAFCERT,"^",1)),1:VAFHLQ) ; Date Certified
 I VAFSTR[",3," S X=$$YN^VAFHLFNC($P(VAFCERT,"^",3)),$P(VAFY,VAFHLFS,3)=$S(X]"":X,1:VAFHLQ) ; Eligible
 I VAFSTR[",4," S $P(VAFY,VAFHLFS,4)=$S($P(VAFCERT,"^",4)]"":$P(VAFCERT,"^",4),1:VAFHLQ) ; Amount Certified (amount of income reported)
 ;
 I VAFSTR[",5," D
 .I $P(VAFANOD,"^",8)]"" D
 ..S VAFMTS=$P(VAFANOD,"^",8)
 ..I $L(VAFMTS)>1 S VAFMTS=$TR(VAFMTS," ","")
 ..I $L(VAFMTS)<1 S VAFMTST="" Q
 ..S VAFMTST=+$O(^DG(408.32,"C",VAFMTS,0)),VAFMTST=$G(^DG(408.32,+VAFMTST,0)),VAFMTST=$P(VAFMTST,"^",2)
 .S $P(VAFY,VAFHLFS,5)=$S($G(VAFMTST)]"":VAFMTST,1:VAFHLQ) ; Means Test Status 
 ;
 I VAFSTR[",6," D
 .I $P(VAFANOD,"^",9)]"" D
 ..S VAFELIG=+$O(^DIC(8,"B",$P(VAFANOD,"^",9),0)),VAFELIG=$P($G(^DIC(8,VAFELIG,0)),"^",9)
 .S $P(VAFY,VAFHLFS,6)=$S(+$G(VAFELIG)>0:VAFELIG,1:VAFHLQ) ; Primary Eligibility Code
 ;
 I VAFSTR[",7," S $P(VAFY,VAFHLFS,7)=$S($P(VAFCLM,"^",1)]"":$$HLDATE^HLFNC($P(VAFCLM,"^",1)),1:VAFHLQ) ; Claim Date
 ;
ENQ Q "ZBT"_VAFHLFS_$G(VAFY)

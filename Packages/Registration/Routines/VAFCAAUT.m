VAFCAAUT ;BIR/CML-VAFC ASSIGNING AUTHORITY FILE (#391.92) Utilities ; 7/13/10
 ;;5.3;Registration;**825**;Aug 13, 1993;Build 1
 Q
 ;
GETIEN(ASSIGNAU) ;
 ; for MPIC_2006
 ; Get IEN of record in the VAFC ASSIGNING AUTHORITY FILE (#391.92).
 ;
 ; Input:
 ;   ASSIGNAU: Assigning Authority
 ;          example of ASSIGNAU="1.3.6.1.4.1.26580" for HL7 v3.
 ;          example of ASSIGNAU="USDOD" for HL7 v2.4.
 ;
 ; Return: 1) ien of MPI Assigning Authority (#985.55) file
 ;         2) -1^<comment> if the input is bad or there is an ambiguity
 ;
 ;         Example:<ien>
 ;         Example:"-1^Not found"
 ;         Example:"-1^Invalid input"
 ;         Example:"-1^More than one ien found^<ien #1>^<ien #2>..."
 ;
 N AA,IEN,INDEX,LIST,RESULT
 ;
 ; Check input parameter
 S AA=$G(ASSIGNAU)
 Q:AA="" "-1^Invalid input"
 ;
 ; Build a list of IENs found in the v2.4 and v3.0 indexes
 ; making sure each IEN is added only once.
 F INDEX="HL24","HL3" D
 .S IEN=0 F  S IEN=$O(^DGCN(391.92,INDEX,AA,IEN)) Q:'IEN  D
 ..Q:$G(LIST)[("^"_IEN_"^")
 ..S LIST=$S($G(LIST)="":"^",1:LIST)_IEN_"^"
 ;
 ; Remove leading and trailing "^"
 S:$G(LIST)["^" LIST=$E(LIST,2,$L(LIST)-1)
 ;
 ; Set the result
 I $G(LIST)="" S RESULT="-1^Not found" Q RESULT
 I $G(LIST)["^" S RESULT="-1^More than one ien found^"_LIST Q RESULT
 S RESULT=LIST
 ;
 Q RESULT
 ;
ADD(ARRAY,ERROR) ;API to add an entry to the VAFC ASSIGNING AUTHORITY FILE (#391.92)  ;**825, MPIC_2007
 ;
 ;Acceptable input scenarios:
 ;HL7V2_4 only and no SOURCEID,
 ;HL7V2_4 and HL7V3_0 and no SOURCEID, or
 ;HL7V3_0 only and SOURCEID
 ;
 ;Input ARRAY:
 ;  ARRAY("HL7V2_4")= value for HL7V2_4 (#.02) field AND/OR
 ;  ARRAY("HL7V3_0")= value for HL7V3_0 (#.03) field
 ;  ARRAY("SOURCEID")= value for DEFAULT SOURCE ID TYPE (#.04) field
 ;
 ;Output:
 ;  -1^error text - record add failed
 ;  or
 ;  IEN of the entry (new or previously existing)
 ;
 ;   Example: S ARRAY("HL7V3_0")="1234.5678.9876"
 ;            S ARRAY("SOURCEID")="NI"
 ;            S VAL=$$ADD^VAFCAAUT(.ARRAY,.ERR)
 ;            VAL=6
 ;
 ;Check incoming data for invalid input
 N FLD02,FLD03,FOUND,IEN,JJ,PC,RESULT,SRC,SRCID,SRCVAL
 S RESULT="-1^Invalid input parameter.  ",SRCID=""
 I '$D(ARRAY) Q RESULT ;No input data
 ;Don't accept null input values
 I $D(ARRAY("HL7V2_4")) I ARRAY("HL7V2_4")="" Q RESULT
 I $D(ARRAY("HL7V3_0")) I ARRAY("HL7V3_0")="" Q RESULT
 I $D(ARRAY("SOURCEID")) I ARRAY("SOURCEID")="" Q RESULT
 ;
 ;Must have either HL7_2.4 OR HL7_3.0 value input
 I '$D(ARRAY("HL7V2_4"))&('$D(ARRAY("HL7V3_0"))) S RESULT=RESULT_"Assigning Authority value missing." Q RESULT
 ;If both HL7_2.4 and HL7_3.0 values input, there must be NO SOURCEID
 I $D(ARRAY("HL7V2_4"))&($D(ARRAY("HL7V3_0"))) D SOURCE I SRCID S RESULT=RESULT_"SOURCEID value must not be passed in." Q RESULT
 ;If HL7V2_4 value input but not HL7V3_0, there must be NO SOURCEID
 I $D(ARRAY("HL7V2_4"))&('$D(ARRAY("HL7V3_0"))) D SOURCE I SRCID S RESULT=RESULT_"SOURCEID value must not be passed in." Q RESULT
 ;If HL7V3_0 value input but not HL7V2_4, then SOURCEID must be present
 I '$D(ARRAY("HL7V2_4"))&($D(ARRAY("HL7V3_0"))) D SOURCE I 'SRCID S RESULT=RESULT_"SOURCEID value missing." Q RESULT
 ;
 ;If SOURCEID passed in, must have valid value
 I $D(ARRAY("SOURCEID")) S FOUND=0 D  I 'FOUND S RESULT=RESULT_"Invalid SOURCEID value passed in." Q RESULT
 .S SRCVAL=$$GET1^DID(391.92,.04,"","POINTER","","MSG") ;valid values
 .F PC=1:1:($L(SRCVAL,";")-1) S SRC=$P($P(SRCVAL,";",PC),":") I ARRAY("SOURCEID")=SRC S FOUND=1
 ;
 ;If HL7V2_4 value passed in, must have valid value
 I $D(ARRAY("HL7V2_4")) D  I $L(ARRAY("HL7V2_4"))>FLD02("FIELD LENGTH") S RESULT=RESULT_"Assigning Authority value too long." Q RESULT
 .D FIELD^DID(391.92,.02,"","FIELD LENGTH","FLD02")
 ;Ensure that HL7V2_4 value passed in is upper case.
 I $D(ARRAY("HL7V2_4")) S ARRAY("HL7V2_4")=$$UP^XLFSTR(ARRAY("HL7V2_4"))
 ;If HL7V3_0 value passed in, must have valid value
 I $D(ARRAY("HL7V3_0")) D  I $L(ARRAY("HL7V3_0"))>FLD03("FIELD LENGTH") S RESULT=RESULT_"Assigning Authority value too long." Q RESULT
 .D FIELD^DID(391.92,.03,"","FIELD LENGTH","FLD03")
 I $D(ARRAY("HL7V3_0"))  I ARRAY("HL7V3_0")'?1N.NP S RESULT=RESULT_"HL73_0 value must contain only numerics/punctuation." Q RESULT
 ;
 ;Is entry already in the file? If so, quit with that IEN
 S FOUND=0 F JJ="HL7V2_4","HL7V3_0" I $D(ARRAY(JJ)) S IEN=$$GETIEN^VAFCAAUT(ARRAY(JJ)) D  I FOUND Q
 .I $P(IEN,"^")>0 S RESULT=IEN S FOUND=1 Q
 .;Remote possibility that the GETIEN API will return an anomaly
 .I $P(IEN,"^",2)="More than one ien found" S RESULT=IEN S FOUND=1 Q  ;Anomaly - should not happen
 .;otherwise ien="-1^Not found", code will fall into module below
 I FOUND Q RESULT
 ;
 ;Good input data, and entry does not already exist
 ;Add entry to VAFC ASSIGNING AUTHORITY FILE (#391.92)
 N DIC,DINUM,DR,LAST,X,Y
 L +^DGCN(391.92,0):600
 S (LAST,X)=0
 S LAST=+$O(^DGCN(391.92,"@"),-1) ;Last entry # in file
 S (X,DINUM)=LAST+1 ;Next available #
 S DIC="^DGCN(391.92,",DIC(0)="FZ"
 ;Set up DR string
 I $D(ARRAY("HL7V2_4")) S DIC("DR")=".02///^S X=ARRAY(""HL7V2_4"")"_";"
 I $D(ARRAY("HL7V3_0")) S DIC("DR")=$G(DIC("DR"))_".03///^S X=ARRAY(""HL7V3_0"")"_";"
 I $D(ARRAY("SOURCEID")) S DIC("DR")=$G(DIC("DR"))_".04///^S X=ARRAY(""SOURCEID"")"_";"
 ;
 K DO D FILE^DICN K DO
 L -^DGCN(391.92,0)
 I +Y=-1 S RESULT="-1^Unable to create new entry in the VAFC ASSIGNING AUTHORITY FILE (#391.92)." Q RESULT
 S RESULT=+Y
 Q RESULT
 ;
SOURCE ;Is SOURCEID defined?
 S SRCID=$S($D(ARRAY("SOURCEID")):1,1:0)
 Q

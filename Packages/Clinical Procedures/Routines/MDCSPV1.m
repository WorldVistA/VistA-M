MDCSPV1 ;HINES OIFO/DP/BJ - Build Segment PV1 Routine;17 Aug 2007
 ;;1.0;CLINICAL PROCEDURES;**16**;Apr 01, 2004;Build 280
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; - This sub-routine is the Segment Builder proper for the HL7 Patient
 ;     Visit 1 (PV1) Segment.
 ; This routine uses the following IAs:
 ;  #10039       - access ^DIC(42                   Registration                   (supported)
 ;
 Q
BUILD(VAFSTR,VAFNUM,PMOOV,PSEG,TRUBL) ;
 ;
 ; - INPUT
 ;     VAFSTR    = field selection string; field number in string, field into segment
 ;     VAFNUM    = segment number; pass "0001", else routine sets.
 ;     PMOOV     = CP_MOVEMENT_AUDIT file record !!Passed by reference!!
 ;     PSEG      = segment buffer.  !!Passed by reference!!
 ;     TRUBL     = error return string.  !! Passed by reference !!
 ;
 ;
 ; - PREDEFINED LOCALS
 ;     HLECH     = Subfield seperation character defined in MDCPV1
 ;     
 ;     
 ; - OUTPUT
 ;    If no errors detected, PSEG contains the message segment.  If the character count
 ;    exceeds HLMAXLEN, SUBScripted extension segments are allocated, one for each time HLMAXLEN
 ;    is exceeded. Below is a possible example.
 ;         PSEG    = up to HLMAXLEN characters of segment
 ;         PSEG(1) = up to HLMAXLEN characters of segment
 ;         PSEG(2) = remaining characters of segment
 ;    If an error is detected, TRUBL contains an error message string. PSEG is killed.
 ;
 ;    Fields are not broken across segment boundaries.  If the number of characters in a field
 ;    plus the separator character (HLFS) that precedes the field will push a segment's character
 ;    count beyond HLMAXLEN, a new overflow segment is established.  The field and its
 ;    preceding separator are placed there.
 ;
 ;
 N PV1,FLD,RUMBE,PRAW,WRDLO
 ;
 ;
 ; - The segment is required.  Right now, our data comes from just an entry in the
 ;   704.005 file.  If it is absent or empty,
 ;   exit now with no error.  There is one required field.  If any data present in PV1 node,
 ;   the required field (in PV1) must be present. Otherwise error. Checked for below.
 I $TR($G(PMOOV(0)),U)="" Q
 S PV1=PMOOV(0)
 ;
 ;
 ; - segment number
 I VAFNUM="0001" S PRAW(1)=VAFNUM
 I VAFNUM'="0001" S PRAW(1)="0001"
 ;
 ;
 ; - patient class. I for Inpatient, O for Outpatient
 ;     but all is Inpatient
 ;
 I (VAFSTR[",2,") S PRAW(2)="I"
 ;
 ; - Assigned Patient Location/Point of Care.  There are 3 components: Point of Care,
 ;    which is the Medical Center Division ID; the Room, which is the Ward Location
 ;    ID; and Bed, which is the ROOM-BED ID.  Since the Patient Location field is Required, its
 ;    two Required components, Point of Care and Room, must both be present.
 S (FLD,WRDLO,RUMBE)=""
 I (VAFSTR[",3,") D
 .; - look for characters to escape
 .I ($TR(FLD,HL7RC)'=FLD) S FLD=$$ESC^MDCUTL(FLD)
 .; employ the pointer to the Ward Location file
 .I ($P(PV1,U,4)'="") S WRDLO=$P($G(^DIC(42,($P(PV1,U,4)),0)),U)
 .; - look for characters to escape
 .I ($TR(WRDLO,HL7RC)'=WRDLO) S WRDLO=$$ESC^MDCUTL(WRDLO)
 .; - employ the pointer to the ROOM-BED file
 .I ($P(PV1,U,5)'="") S MDF4054=405.4,RUMBE=$$GET1^DIQ(MDF4054,($P(PV1,U,5))_",","NAME") K MDF4054
 .; - there are 3 parts: Room ID, Bed ID, and (sometimes) Building ID
 .; - get room and bed IDs, dropping building ID if present
 .S RUMBE=$P(RUMBE,"-",1,2)
 .; - check for characters to escape
 .I ($TR(RUMBE,HL7RC)'=RUMBE) S RUMBE=$$ESC^MDCUTL(RUMBE)
 .; Room and bed are supposed to be in different fields.
 .; Note: According to our conformance profile, subfield separators are always '^'.  Ideally, we'll
 .; want to change this to something out of the environment, but I'm not sure what the original
 .; developers did with the variable that was supposed to hold the subfield separator.
 .S RUMBE=$TR(RUMBE,"-","^")
 .; - assemble field from components; no separators for absent trailing components
 .I RUMBE'="" S WRDLO=WRDLO_HLRP_RUMBE
 .I WRDLO'="" S FLD=WRDLO
 ;
 S PRAW(3)=FLD
 ;
 ; - Attending Doc field. approximately XCN format. not required, but
 ;    pointer should be good if present and can be checked for later.
 ;I ($P(PV1,U,19)'=""),(VAFSTR[",7,") S PRAW(7)=$$DOCINF^MDCPV1($P(PV1,U,19))
 ;
 D MAKESEG^MDCUTL(.PRAW,.PSEG,0,"PV1")
 Q
 ;

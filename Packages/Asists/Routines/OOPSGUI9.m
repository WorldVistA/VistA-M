OOPSGUI9 ;WIOFO/LLH-RPC routines ;10/24/01
 ;;2.0;ASISTS;**6,7**;Jun 03, 2002
 ;;
VALIDATE(IEN,FORM,CALLER,VALID) ;
 ; Input: IEN    = Internal Entry Number of entry in file 2260
 ;        FORM   = 2162,CA1, or CA2
 ;        CALLER = "E" employee
 ;               = "S" supervisor
 ;               = "O" safety officer
 ;               = "W" worker's comp personnel
 ;        WCEMP  = from menu if 1 - need to execute emp validation
 ;        VALID  = RESERVED FOR OUTPUT DATA
 ; Output:VALID  = 1 ALL REQUIRED DATA FOR FORM IS COMPLETE
 ;               = 0 DATA IS MISSING
 N LIST,FLD,CN,CNT,CHK
 S (FLD,LIST)=""
 S VALID=1,CHK=0
 S CN=2   ; start CN in RESULTS array after index 1
 ; removed code in line below that would also do set if the variable
 ; WCEMP set.  WCEMP was an indicator that WC was completing CA1 for
 ; employee.  May need to do something else.  10/24/01 llh
 I CALLER="E" D EMP
 I CALLER="S" D SUP
 I CALLER="O" D SOF
 I CALLER="W" D WCP
 F CNT=1:1 S FLD=$P(LIST,",",CNT) Q:FLD=""  D
 .N LOC,NODE,PCE,BADFLD,TEXT,WP
 .S BADFLD=1,WP=0
 .S LOC=$$GET1^DID(2260,FLD,"","GLOBAL SUBSCRIPT LOCATION")
 .S NODE=$P(LOC,";")
 .S PCE=$P(LOC,";",2)
 .I PCE=0 D  ;Work processing field
 ..I '$D(^OOPS(2260,IEN,NODE,1,0)) S (BADFLD,VALID)=0
 ..S WP=1
 ..Q
 .I PCE'=0  I $P($G(^OOPS(2260,IEN,NODE)),U,PCE)="" S (BADFLD,VALID)=0
 .I 'BADFLD D  ; Display error messaged about fields not filled.
 ..I 'CHK S RESULTS(1)="The following fields must be completed before the  "_FORM_" can be signed." S CHK=1
 ..I WP D  ;Is this a wp field and where to get title
 ...N NODE
 ...S NODE=2260_".0"_FLD
 ...; patch 11 - fix bug on fld 40, node '= 2260.040, it's 2260.01
 ...I FLD=40 S NODE="2260.01"
 ...S TEXT=$$GET1^DID(NODE,".01","","LABEL")
 ...Q
 ..I 'WP S TEXT=$$GET1^DID(2260,FLD,"","LABEL")
 ..; patch 2.7 if it's body part most affected, indicate the source form
 ..I FLD=30 S TEXT=$G(TEXT)_" (FORM 2162)"
 ..S RESULTS(CN)=TEXT,CN=CN+1
 ..Q
 .Q
 ; removed !($G(WCEMP)) which indicates validation coming from WC 
 ; completing the employee portion of the CA1.  May need to figure
 ; something else out. 10/24/01 llh
 I FORM="CA1"&(CALLER="E") D   ; fld 110 check on Emp CA1 only
 . I $$GET1^DIQ(2260,IEN,110,"I")<($$GET1^DIQ(2260,IEN,4,"I")\1) S VALID=0 D
 .. S RESULTS(CN)=$$GET1^DID(2260,110,"","LABEL")_" must be on or after the "_$$GET1^DID(2260,4,"","LABEL"),CN=CN+1
DTCHK ; Date error checking that may be missed w/input transform
 ; patch 11 - Additional error checking has been added for CA2 field 214
 ; removed $G(WCEMP) from line below. same concern as above 10/24/01 llh
 I FORM=2162!(CALLER="O") Q
 K CNT,FLD,LIST
 N DATE,DATE1,DATE2,TITLE,EMPDOB
 ; patch 11 - need to make sure 215 not before 214 on employee part
 I CALLER="E",FORM="CA2" D  Q
 . S DATE1=$$GET1^DIQ(2260,IEN,215,"I")
 . S DATE2=$$GET1^DIQ(2260,IEN,214,"I")
 . S EMPDOB=$$GET1^DIQ(2260,IEN,6,"I")
 . I $$FMDIFF^XLFDT(DATE2,EMPDOB,2)<0 S VALID=0 D
 .. S RESULTS(CN)=$$GET1^DID(2260,214,"","LABEL")_" must be on or after the "_$$GET1^DID(2260,6,"","LABEL"),CN=CN+1
 . I $$FMDIFF^XLFDT(DATE1,DATE2,2)<0 S VALID=0 D
 .. S RESULTS(CN)=$$GET1^DID(2260,215,"","LABEL")_" must be on or after the "_$$GET1^DID(2260,214,"","LABEL"),CN=CN+1
 ; End of checks from Employee CA2
 I FORM="CA1" D
 . S LIST="142,161,175"
 . S (DATE,DATE1)=$$GET1^DIQ(2260,IEN,4,"I")
 . S TITLE=$$GET1^DID(2260,4,"","LABEL")
 I FORM="CA2" D
 . S LIST="215,250,252,253,255"
 . S (DATE,DATE1)=$$GET1^DIQ(2260,IEN,214,"I")
 . S TITLE=$$GET1^DID(2260,214,"","LABEL")
 F CNT=1:1 S FLD=$P(LIST,",",CNT) Q:FLD=""  D
 . S DATE2=$$GET1^DIQ(2260,IEN,FLD,"I") I FLD'=142 S DATE2=DATE2\1,DATE1=DATE\1
 . I $G(DATE2),DATE2<DATE1 D  S VALID=0
 .. S RESULTS(CN)=$$GET1^DID(2260,FLD,"","LABEL")_" must be on or after the "_TITLE,CN=CN+1
 ; Need specific check on DATE/TIME STOPPED WORK
 I FORM="CA1" D
 . S LIST="143,144,145",DATE=$$GET1^DIQ(2260,IEN,142,"I")
 . S TITLE=$$GET1^DID(2260,142,"","LABEL")
 I FORM="CA2" D
 . S LIST="254,256",DATE=$$GET1^DIQ(2260,IEN,253,"I")
 . S TITLE=$$GET1^DID(2260,253,"","LABEL")
 F CNT=1:1 S FLD=$P(LIST,",",CNT) Q:FLD=""  D
 . S DATE2=$$GET1^DIQ(2260,IEN,FLD,"I"),DATE1=DATE D
 .. I FLD=143!(FLD=144) S DATE1=DATE\1,DATE2=DATE2\1
 .. I (DATE1>DATE2),$G(DATE2) D  S VALID=0
 ... S RESULTS(CN)=$$GET1^DID(2260,FLD,"","LABEL")_" must be on or after the "_TITLE,CN=CN+1
 .. I '$G(DATE1),$G(DATE2) D  S VALID=0
 ... S RESULTS(CN)=TITLE_" cannot be blank if date in "_$$GET1^DID(2260,FLD,"","LABEL"),CN=CN+1
 Q
EMP ; Address fields are now all pulled from the 2162A node
 ; added fields 126 & 181,183-185 to lists below - patch 8
 I FORM="CA1" S LIST="8,9,10,11,12,108,109,110,111,112,113,114,126,181,183,184,185"
 ; added field 213 -  ASISTS V2.0
 I FORM="CA2" S LIST="8,9,10,11,12,126,208,209,213,214,215,216,217"
 Q
SUP ;
 N F165
 I FORM="2162" D F2162 Q
 S LIST="30,"
 I FORM="CA1" D
 . S LIST=LIST_"4,60,130,131,132,133,134,138,139,140,146,148,150,"
 . S LIST=LIST_"162,163,172,173,174,175,176,177,178,179,"
 . S LIST=LIST_"180,181,183,184,185,"
 . I $$GET1^DIQ(2260,IEN,150,"I")="Y" S LIST=LIST_"151,152,153,154,155,"
 . ; V2.0 added required fields missed in patch 8
 . I $$GET1^DIQ(2260,IEN,146)="No" S LIST=LIST_"147,"
 . I $$GET1^DIQ(2260,IEN,148)="Yes" S LIST=LIST_"149,"
 . I $$GET1^DIQ(2260,IEN,163)="No" S LIST=LIST_"164,"
 . S F165=$G(^OOPS(2260,IEN,"CA1K",0))
 . I $G(F165)'="",($P(F165,U,4)'=0) S LIST=LIST_"165,"
 I FORM="CA2" D
 . S LIST=LIST_"230,231,232,233,234,237,238,239,240,241,"
 . S LIST=LIST_"242,243,244,251,252,255,258,60,268,269,"
 . ; below for ASISTS V2.0, needed for roll and scroll also
 . ; added next line, need to get 3rd party if 258 = y
 . I $$GET1^DIQ(2260,IEN,258,"I")="Y" S LIST=LIST_"259,260,261,262,263,"
 ; V2.0 if field 60="other" (3)  then 61 required for both CA1 & CA2
 I $$GET1^DIQ(2260,IEN,60,"I")=3 S LIST=LIST_"61,"
 ; need to check Physician information for both CA1 and CA2
 D PHYCHK
 Q
PHYCHK ; checks physician fields for appropriate form.  If Phy Name not
 ; blank address fields required.  If Phy Name blank and data in any
 ; address field then all fields required.
 N CTR,FLD,PHY,PLIST,NBLK
 S NBLK="",PHY=$S(FORM="CA1":156,FORM="CA2":245,1:"")
 I 'PHY Q
 S PLIST=$S(PHY=156:"157,158,159,160,182",PHY=245:"246,247,248,249,270",1:"")
 I PLIST="" Q
 I PHY=156 D  Q
 . I $$GET1^DIQ(2260,IEN,156)'="" D  Q
 .. F CTR=1:1 S FLD=$P(PLIST,",",CTR) Q:FLD=""  I $$GET1^DIQ(2260,IEN,FLD)="" S LIST=LIST_FLD_","
 . I $$GET1^DIQ(2260,IEN,156)="" D  Q
 .. F CTR=1:1 S FLD=$P(PLIST,",",CTR) Q:FLD=""  I $$GET1^DIQ(2260,IEN,FLD)'="" S NBLK=NBLK_FLD_","
 .. I $G(NBLK)'="" S LIST=LIST_"156," F CTR=1:1 S FLD=$P(PLIST,",",CTR) Q:FLD=""  I '$F(NBLK,FLD) S LIST=LIST_FLD_","
 I PHY=245 D  Q
 . I $$GET1^DIQ(2260,IEN,245)'="" D  Q
 .. F CTR=1:1 S FLD=$P(PLIST,",",CTR) Q:FLD=""  I $$GET1^DIQ(2260,IEN,FLD)="" S LIST=LIST_FLD_","
 . I $$GET1^DIQ(2260,IEN,245)="" D
 .. F CTR=1:1 S FLD=$P(PLIST,",",CTR) Q:FLD=""  I $$GET1^DIQ(2260,IEN,FLD)'="" S NBLK=NBLK_FLD_","
 .. I $G(NBLK)'="" S LIST=LIST_"245," F CTR=1:1 S FLD=$P(PLIST,",",CTR) Q:FLD=""  I '$F(NBLK,FLD) S LIST=LIST_FLD_","
 Q
SOF ; the call to F2162 here is overkill.  All these fields should
 ; already be completed, but just in case...
 ; removed field 89 from required list for patch 7
 I FORM="2162" D F2162 S LIST=LIST_",55,88"
 ; code below obsolete with patch 7
 ;I $$ISEMP^OOPSUTL4(IEN) D
 ;.S LIST=LIST_",33"
 ;.I $$GET1^DIQ(2260,IEN,33)="N" S LIST=LIST_",32"
 Q
WCP ; Get required fields for Workers Comp
 I FORM="2162" D F2162 Q
 S LIST="5,6,7,15,62,70,73,"
 I FORM="CA1" D
 . S LIST=LIST_"123,124,"
 . ; flds 166 & 167 only required if personnel status = 1
 . I $$GET1^DIQ(2260,IEN,2,"I")=1 S LIST=LIST_"166,167,"
 I FORM="CA2" D
 . S LIST=LIST_"226,227,"
 D SUP
 Q
F2162 ; Set required fields for form 2162
 N TYP,SAF,INCID
 I FORM'="2162" Q
 S LIST="26,27,28,29,30,31"
 S TYP=$$GET1^DIQ(2260,IEN,"3:.01","E")
 I "^Sharps Exposure^Hollow Bore Needlestick^Suture Needlestick^"[TYP D
 . S LIST=LIST_",34,35,36,37,38,82"
 I $$GET1^DIQ(2260,IEN,"38:2","I")="N" S LIST=LIST_",83"
 I "^Exposure to Body Fluids/Splash^"[TYP D
 . S LIST=LIST_",34,39,40,41"
 S INCID=$$GET1^DIQ(2260,IEN,3,"I")
 I (INCID<11)!(INCID>14) Q
 I $$GET1^DIQ(2260,IEN,42.5,"I")="Y" S LIST=LIST_",42"
 S SAF=$$GET1^DIQ(2260,IEN,43,"I")
 S LIST=$S(SAF="Y":LIST_",84,87",SAF="N":LIST_",85",1:LIST)
 S LIST=LIST_",47"
 Q

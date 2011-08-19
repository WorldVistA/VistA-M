OOPSUTL4 ;HINES/WAA-Utilities Routines ;3/24/98
 ;;2.0;ASISTS;**7,15**;Jun 03, 2002;Build 9
DTVAL(DATE,FLD1,FLD2) ;
 ; this subroutine called from ^DD so date error checking on fields
 ; 143, 144, 145 (if CA1) and 254, 255 (if CA2).  returns a valid date 
 ; (one passed in) if a date in FLD2 and is > than date passed in (DATE).
 ;  Inputs:   DATE - date entered in prompt
 ;            FLD1 - field of prompt date entered in
 ;            FLD2 - field of date to be checked against
 ; Outputs:   VAL  - contains valid date passed in if true & "" if false
 N DTE2,VAL
 S VAL=DATE,DTE2=""
 I '$G(IEN) S IEN=$G(DA)
 I IEN S DTE2=$$GET1^DIQ(2260,IEN,FLD2,"I")
 I %DT'["R" S DTE2=DTE2\1
 I DTE2>DATE!'$G(DTE2) S VAL=""
 I 'VAL D
 .;V2_P15 changed direct writes with call to EN^DDIOL
 .I '$G(DTE2) D EN^DDIOL($$GET1^DID(2260,FLD2,"","LABEL")_" cannot be blank if date entered in "_$$GET1^DID(2260,FLD1,"","LABEL"),"","!!!?5")
 .D EN^DDIOL($$GET1^DID(2260,FLD1,"","LABEL")_" must be on or after the "_$$GET1^DID(2260,FLD2,"","LABEL"),"","!!!?5")
 Q VAL
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
 N LIST,FLD,CNT,CHK
 S (FLD,LIST)=""
 S VALID=1,CHK=0,WCEMP=$G(WCEMP,0)
 W !,"Validating data on form ",FORM,"."
 I CALLER="E"!$G(WCEMP) D EMP
 I CALLER="S" D SUP
 I CALLER="O" D SOF
 I CALLER="W" D WCP
 F CNT=1:1 S FLD=$P(LIST,",",CNT) Q:FLD=""  D
 .N LOC,NODE,PCE,BADFLD,TEXT,WP
 .S BADFLD=1,WP=0
 .S LOC=$$GET1^DID(2260,FLD,"","GLOBAL SUBSCRIPT LOCATION")
 .S NODE=$P(LOC,";"),PCE=$P(LOC,";",2)
 .I PCE=0 D  ;Work processing field
 ..I '$D(^OOPS(2260,IEN,NODE,1,0)) S (BADFLD,VALID)=0
 ..S WP=1
 ..Q
 .I PCE'=0  I $P($G(^OOPS(2260,IEN,NODE)),U,PCE)="" S (BADFLD,VALID)=0
 .I 'BADFLD D  ; Display error messaged about fields not filled.
 ..I 'CHK W !!,"The following fields must be completed before the "_FORM_" can be signed.",! S CHK=1
 ..I WP D  ;Is this a wp field and where to get title
 ...N NODE
 ...S NODE=2260_".0"_FLD
 ...; patch 11 - fix bug on fld 40, node '= 2260.040, it's 2260.01
 ...I FLD=40 S NODE="2260.01"
 ...S TEXT=$$GET1^DID(NODE,".01","","TITLE")
 ..I 'WP S TEXT=$$GET1^DID(2260,FLD,"","TITLE") I $G(TEXT)="" S TEXT=$$GET1^DID(2260,FLD,"","LABEL")
 ..; patch 2.7 - if body part affected - indicate the form
 ..I FLD=30,(TEXT'="") S TEXT=TEXT_" (FORM 2162)"
 ..W !,TEXT
 I FORM="CA1"&(CALLER="E"!$G(WCEMP)) D   ; fld 110 check on Emp CA1 only
 .I $$GET1^DIQ(2260,IEN,110,"I")<($$GET1^DIQ(2260,IEN,4,"I")\1) S VALID=0 D
 ..W !?5,$$GET1^DID(2260,110,"","LABEL")_" must be on or after the "_$$GET1^DID(2260,4,"","LABEL")
DTCHK ; Date error checking that may be missed w/input transform
 ; patch 11 - Additional error checking has been added for CA2 field 214
 I FORM=2162!(CALLER="O")!$G(WCEMP) Q
 K CNT,FLD,LIST
 N DATE,DTE1,DTE2,TITLE,EMPDOB
 ; patch 11 - need to make sure 215 not before 214 on employee part
 I CALLER="E",FORM="CA2" D  Q
 .S DTE1=$$GET1^DIQ(2260,IEN,215,"I")
 .S DTE2=$$GET1^DIQ(2260,IEN,214,"I")
 .S EMPDOB=$$GET1^DIQ(2260,IEN,6,"I")
 .I $$FMDIFF^XLFDT(DTE2,EMPDOB,2)<0 S VALID=0 D
 ..W !?5,$$GET1^DID(2260,214,"","LABEL")_" must be on or after the "_$$GET1^DID(2260,6,"","LABEL")
 .I $$FMDIFF^XLFDT(DTE1,DTE2,2)<0 S VALID=0 D
 ..W !?5,$$GET1^DID(2260,215,"","LABEL")_" must be on or after the "_$$GET1^DID(2260,214,"","LABEL")
 ; End of checks from Employee CA2
 I FORM="CA1" D
 .S LIST="142,161,175"
 .S (DATE,DTE1)=$$GET1^DIQ(2260,IEN,4,"I")
 .S TITLE=$$GET1^DID(2260,4,"","LABEL")
 I FORM="CA2" D
 .S LIST="215,250,252,253,255"
 .S (DATE,DTE1)=$$GET1^DIQ(2260,IEN,214,"I")
 .S TITLE=$$GET1^DID(2260,214,"","LABEL")
 F CNT=1:1 S FLD=$P(LIST,",",CNT) Q:FLD=""  D
 .S DTE2=$$GET1^DIQ(2260,IEN,FLD,"I") I FLD'=142 S DTE2=DTE2\1,DTE1=DATE\1
 .I $G(DTE2),DTE2<DTE1 D  S VALID=0
 ..W !?5,$$GET1^DID(2260,FLD,"","LABEL")_" must be on or after the "_TITLE
 ; Need specific check on DATE/TIME STOPPED WORK
 I FORM="CA1" D
 .S LIST="143,144,145",DATE=$$GET1^DIQ(2260,IEN,142,"I")
 .S TITLE=$$GET1^DID(2260,142,"","LABEL")
 I FORM="CA2" D
 .S LIST="254,256",DATE=$$GET1^DIQ(2260,IEN,253,"I")
 .S TITLE=$$GET1^DID(2260,253,"","LABEL")
 F CNT=1:1 S FLD=$P(LIST,",",CNT) Q:FLD=""  D
 .S DTE2=$$GET1^DIQ(2260,IEN,FLD,"I"),DTE1=DATE D
 ..I FLD=143!(FLD=144) S DTE1=DATE\1,DTE2=DTE2\1
 ..I (DTE1>DTE2),$G(DTE2) D  S VALID=0
 ...W !?5,$$GET1^DID(2260,FLD,"","LABEL")_" must be on or after the "_TITLE
 ..I '$G(DTE1),$G(DTE2) D  S VALID=0
 ...W !?5,TITLE_" cannot be blank if date in "_$$GET1^DID(2260,FLD,"","LABEL")
 Q
EMP ; Address fields are now all pulled from the 2162A node
 ; added fields 126 & 181,183-185 to lists below - patch 8
 I FORM="CA1" S LIST="8,9,10,11,12,108,109,110,111,112,113,114,126,181,183,184,185"
 ; added field 213 - ASISTS V2.0
 I FORM="CA2" S LIST="8,9,10,11,12,126,208,213,209,214,215,216,217"
 Q
SUP ;
 N F165
 I FORM="2162" D F2162 I $$ISEMP^OOPSUTL4(IEN) S LIST=LIST_",33" Q
 S LIST="30,"
 I FORM="CA1" D
 .S LIST=LIST_"4,60,130,131,132,133,134,138,139,140,146,148,150,"
 .S LIST=LIST_"162,163,172,173,174,175,176,177,178,179,"
 .S LIST=LIST_"180,181,183,184,185,"
 .I $$GET1^DIQ(2260,IEN,150,"I")="Y" S LIST=LIST_"151,152,153,154,155,"
 .; V2.0 added required fields missed in patch 8
 .I $$GET1^DIQ(2260,IEN,146)="No" S LIST=LIST_"147,"
 .I $$GET1^DIQ(2260,IEN,148)="Yes" S LIST=LIST_"149,"
 .I $$GET1^DIQ(2260,IEN,163)="No" S LIST=LIST_"164,"
 .S F165=$G(^OOPS(2260,IEN,"CA1K",0))
 .I $G(F165)'="",($P(F165,U,4)'=0) S LIST=LIST_"165,"
 I FORM="CA2" D
 .S LIST=LIST_"230,231,232,233,234,237,238,239,240,241,"
 .S LIST=LIST_"242,243,244,251,252,255,258,60,268,269,"
 .; below for ASISTS V2.0, needed for roll and scroll also
 .; added next line, need to get 3rd party if 258 = y
 .I $$GET1^DIQ(2260,IEN,258,"I")="Y" S LIST=LIST_"259,260,261,262,263,"
 ; V2.0 if field 60="other" (3)  then 61 required for both CA1 & CA2
 I $$GET1^DIQ(2260,IEN,60,"I")=3 S LIST=LIST_"61,"
 ; need to check physician information
 D PHYCHK^OOPSGUI9
 Q
SOF ;
 I FORM="2162" D F2162 S LIST=LIST_",55,47"
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
F2162 ; Set required fields for form 2162 - doesn't matter which menu
 ; coming from, Supervisor, Safety, WC (for EDIT REPORT OF INCIDENT)
 N TYP,SAF
 I FORM'="2162" Q
 S LIST="26,27,28,29,30,31"
 S TYP=$$GET1^DIQ(2260,IEN,"3:.01","E")
 I "^Sharps Exposure^Hollow Bore Needlestick^Suture Needlestick^"[TYP D
 . S LIST=LIST_",34,35,36,37,38,82"
 I $$GET1^DIQ(2260,IEN,"38:2","I")="N" S LIST=LIST_",83"
 I "^Exposure to Body Fluids/Splash^"[TYP D
 . S LIST=LIST_",34,39,40,41"
 I $$GET1^DIQ(2260,IEN,3,"I")<11 Q
 I $$GET1^DIQ(2260,IEN,42.5,"I")="Y" S LIST=LIST_",42"
 S SAF=$$GET1^DIQ(2260,IEN,43,"I")
 S LIST=$S(SAF="Y":LIST_",84,87",SAF="N":LIST_",85",1:LIST)
 S LIST=LIST_",47"
 Q
UP(IN) ; Translate all lower to upper
 N OUT
 S OUT=$TR(IN,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 Q OUT
VCHAR(IN) ; Check to make sure no invalid characters have been used
 ;   input  - IN, data entered by user
 ;  output  - VALID, if invalid characters used, = 0
 N VALID
 S VALID=1
 I IN'=$TR(IN,"~`@#$%*_|\}{[]><","") S VALID=0
 Q VALID
ISEMP(IEN) ; Determine if PERSONNEL STATUS = employee
 ;  Input -  IEN     = internal Entry Number of case in File 2260
 ;           CAT     = Personnel Status of Case in File 2260
 ;           TST     = valid Personnel status categories for employee
 ;  Output - EMP     = 1 Personnel status indicates employee
 ;                     0 Personnel status indicates non-employee
 NEW CAT,TST,EMP
 S EMP=0
 S CAT=$$GET1^DIQ(2260,IEN,2,"I")
 ; 12/16/01 V2.0 removed personnel types 7,8,9,10
 S TST=",1,2,6,"
 I TST[(","_CAT_",") S EMP=1
 Q EMP
FUT(DATE) ; Check for dates prior to Date of Inj/Ill
 N DAT,VIEW,FORM
 S VIEW=1
 S FORM=$$GET1^DIQ(2260,IEN,52,"I")
 S DAT=$$GET1^DIQ(2260,IEN,4,"I")
 I (DATE<$P(DAT,".")),FORM=1 D
 . W !!?6,"This date cannot be prior to DATE/TIME INJURY OCCURRED entered on 2162.",! S VIEW=0
 Q VIEW
WP(OPFLD) ; Patch 8 - determine number of characters in WP fields that are
 ;         limited to 532 characters & if invalid characters are present
 ;  Input    IEN - Internal Record ID of Case
 ;         OPFLD - Field number of WP field to be calculated
 ; Output    OPT - Total number of characters in all lines of WP field
 ;                 concatenated to VALID. ex: 165^1 or 180^0
 ;         VALID - indicates whether invalid characters were detected
 N DATA,DIWL,DIWR,DIWF,OPGLB,OPI,OPNODE,OPT,OPC,VALID
 S VALID=1
 K ^UTILITY($J,"W")
 S DIWL=1,DIWR="",DIWF="|C264",OPT=0
 S OPNODE=$P($$GET1^DID(2260,OPFLD,"","GLOBAL SUBSCRIPT LOCATION"),";")
 S OPI=0 F  S OPI=$O(^OOPS(2260,IEN,OPNODE,OPI)) Q:'OPI  S X=$G(^OOPS(2260,IEN,OPNODE,OPI,0)) D:X]"" ^DIWP
 I $G(^UTILITY($J,"W",1))+0 D
 . S OPI=0 F OPC=1:1 S OPI=$O(^UTILITY($J,"W",1,OPI)) Q:'OPI  D
 .. S DATA=^UTILITY($J,"W",1,OPI,0)
 .. I DATA'=$TR(DATA,"~`@#$%^*_|\}{[]><","") S VALID=0
 .. S OPT=OPT+$L(DATA)
 K ^UTILITY($J,"W"),X
 Q OPT_U_VALID

ETSRXNTX ;O-OIFO/FM23 - RxNorm Taxonomy Search ;03/17/2017
 ;;1.0;Enterprise Terminology Service;**1**;Mar 20, 2017;Build 7
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
TAX(ETSVUID,ETSSUB,ETSCLASS) ; Get Taxonomy Information
 ;
 ; Input:
 ; 
 ;  ETSVUID VA Unique ID (VUID) Search Term (Required)
 ;    
 ;  ETSSUB  Name of a subscript to use in the ^TMP global (optional)
 ;            
 ;          ^TMP(ETSSUB,$J,
 ;          ^TMP("ETSCLA",$J,    Default for $$VUICLASS
 ;          ^TMP("ETSTAX",$J,    Default for $$TAX
 ;    
 ;  ETSCLASS Call Flag (optional, default = 0)
 ;     
 ;           0  This function was called from the $$TAX API - Get all VUIDs with the same value set as the VUID passed in
 ;           1  This function was called from the $$VUICLASS API - Get all VUIDs with the same drug class as the VUID passed in
 ;     
 ; Output: 
 ; 
 ;  $$TAX   The number of codes found or -1 ^ error message
 ;    
 ;  ^TMP(ETSSUB,$J,ETSVUID,"VUID"),#,0)
 ;    
 ;          6-piece "^"-delimited string
 ;                             
 ;          1   File #129.2 IEN
 ;          2   RXCUI (Field #.01)
 ;          3   Source (SAB) (Field #.02)
 ;          4   Term_Type (TTY) (Field #.03)
 ;          5   Code (VUID) (Field #.04)
 ;          6   Suppression_Flag (SUPPRESS) (Field #.05)
 ; 
 ;  ^TMP(ETSSUB,$J,ETSVUID,"VUID"),#,1) = Text (STR) (Field #1)
 ;
 ;      For $$TAX:
 ;  ^TMP(ETSSUB,$J,ETSVUID,"VUID"),#,2) = Activation Date (Field #91)
 ;
 N ETSC,ETSCNT,ETSCODE,ETSCODE5,ETSCTR,ETSDATA,ETSERR,ETSIEN,ETSNODE,ETSRELA,ETSRES,ETSRXCUI,ETSRXCU1,ETSRXCU2,ETSSAB
 N ETSSUPP,ETSTTY,ETSTTYS
 ;
 ;Check for Parameter errors
 I $G(ETSVUID)="" Q "-1^VUID missing"
 ;
 ;Set Default values for optional parameters
 S:$G(ETSCLASS)'=1 ETSCLASS=0
 S:$G(ETSSUB)="" ETSSUB=$S(ETSCLASS=1:"ETSCLA",1:"ETSTAX")
 ;
 ;Clear the temporary arrays in case there is older data in existence
 K ^TMP(ETSSUB,$J)
 D CLEANUP
 ;
 ;Set other defaults
 S ETSTTYS=$S(ETSCLASS=1:",AB,CD,",1:",IN,PIN,")  ;Term Types to search
 S ^TMP(ETSSUB,$J,ETSVUID,"VUID")=0  ;Number of records found
 ;
 ;
 ;Step A -- Get initial RXCUI list from VUID
 S ETSCNT=$$VUI2RXN^ETSRXN(ETSVUID,"","ETSSTEP A") I ETSCNT<1 Q ETSCNT
 ;
 ;Weed out suppressed records
 S ETSCTR="" F  S ETSCTR=$O(^TMP("ETSSTEP A",$J,ETSCTR)) Q:'ETSCTR  D
 .S ETSSUPP=$P($G(^TMP("ETSSTEP A",$J,ETSCTR,0)),U,6)
 .I ETSSUPP=""!(ETSSUPP="N") Q
 .S ETSCNT=ETSCNT-1 K ^TMP("ETSSTEP A",$J,ETSCTR)
 .Q
 ;
 I ETSCNT=0 Q ETSCNT
 ;
 ;Step B -- Find "inverse_isa" relationships
 ;S ETSRXCUI="",ETSCNT=0 F  S ETSRXCUI=$O(^TMP("ETSSTEP A",$J,ETSRXCUI)) Q:ETSRXCUI=""  D
 S ETSCNT=0,ETSCTR="" F  S ETSCTR=$O(^TMP("ETSSTEP A",$J,ETSCTR)) Q:'ETSCTR  D
 .S ETSNODE=^TMP("ETSSTEP A",$J,ETSCTR,0),ETSRXCUI=$P(ETSNODE,U,2)  Q:ETSRXCUI=""
 .S ETSIEN="" F  S ETSIEN=$O(^ETSRXN(129.22,"B",ETSRXCUI,ETSIEN)) Q:'ETSIEN  D
 ..K ETSDATA D GETS^DIQ(129.22,ETSIEN_",",".03;.04;.05;.06","","ETSDATA")
 ..S ETSDATA="ETSDATA(129.22,"""_ETSIEN_","")"
 ..S ETSRXCU2=@ETSDATA@(.03) Q:ETSRXCU2=""
 ..S ETSRELA=@ETSDATA@(.04)
 ..S ETSSAB=@ETSDATA@(.05)
 ..S ETSSUPP=@ETSDATA@(.06)
 ..I ETSRELA'="inverse_isa" Q
 ..I ETSSAB'="RXNORM" Q
 ..I ETSSUPP'="",ETSSUPP'="N" Q
 ..S ETSCNT=ETSCNT+1
 ..S ^TMP("ETSSTEP B",$J,ETSRXCU2)=""
 .Q
 ;
 I ETSCNT=0 D CLEANUP Q ETSCNT
 ;
 ;Step C -- Find "ingredient_of" relationships, using RXCUI2 from the last list as RXCUI1 lookup for this one
 S ETSRXCU1="",ETSCNT=0 F  S ETSRXCU1=$O(^TMP("ETSSTEP B",$J,ETSRXCU1)) Q:ETSRXCU1=""  D
 .S ETSIEN="" F  S ETSIEN=$O(^ETSRXN(129.22,"B",ETSRXCU1,ETSIEN)) Q:'ETSIEN  D
 ..K ETSDATA D GETS^DIQ(129.22,ETSIEN_",",".03;.04;.05;.06","","ETSDATA")
 ..S ETSDATA="ETSDATA(129.22,"""_ETSIEN_","")"
 ..S ETSRXCU2=@ETSDATA@(.03) Q:ETSRXCU2=""
 ..S ETSRELA=@ETSDATA@(.04)
 ..S ETSSAB=@ETSDATA@(.05)
 ..S ETSSUPP=@ETSDATA@(.06)
 ..I ETSRELA'="ingredient_of" Q
 ..I ETSSAB'="RXNORM" Q
 ..I ETSSUPP'="",ETSSUPP'="N" Q
 ..S ETSCNT=ETSCNT+1
 ..S ^TMP("ETSSTEP C",$J,ETSRXCU2)=""
 .Q
 ;
 I ETSCNT=0 D CLEANUP Q ETSCNT
 ;
 ;Step D -- Get simple concept/atom attributes with SAB="ATC", using RXCUI2 from the last list as RXCUI lookup for this one
 S ETSRXCUI="",ETSCNT=0 F  S ETSRXCUI=$O(^TMP("ETSSTEP C",$J,ETSRXCUI)) Q:ETSRXCUI=""  D
 .S ETSIEN="" F  S ETSIEN=$O(^ETSRXN(129.21,"B",ETSRXCUI,ETSIEN)) Q:'ETSIEN  D
 ..K ETSDATA D GETS^DIQ(129.21,ETSIEN_",",".02;.03;.05","","ETSDATA")
 ..S ETSDATA="ETSDATA(129.21,"""_ETSIEN_","")"
 ..S ETSSAB=@ETSDATA@(.02)
 ..S ETSSUPP=@ETSDATA@(.03)
 ..S ETSCODE=@ETSDATA@(.05) Q:ETSCODE=""
 ..I ETSSAB'="ATC" Q
 ..I ETSSUPP'="",ETSSUPP'="N" Q
 ..S ETSCNT=ETSCNT+1
 ..S ^TMP("ETSSTEP D",$J,$E(ETSCODE,1,5))=""
 .Q
 ;
 I ETSCNT=0 D CLEANUP Q ETSCNT
 ;
 ;Step E -- Get drug classes with CODE from the last list's 5-character abbreviation
 S ETSCODE5="",ETSCNT=0 F  S ETSCODE5=$O(^TMP("ETSSTEP D",$J,ETSCODE5)) Q:ETSCODE5=""  D
 .S ETSC="^ETSRXN(129.21,""C"",""IS_DRUG_CLASS"")" F  S ETSC=$Q(@ETSC) Q:$QS(ETSC,3)'="IS_DRUG_CLASS"  D
 ..S ETSIEN=$QS(ETSC,5)
 ..K ETSDATA D GETS^DIQ(129.21,ETSIEN_",",".01;.03;.05","","ETSDATA")
 ..S ETSDATA="ETSDATA(129.21,"""_ETSIEN_","")"
 ..S ETSRXCUI=@ETSDATA@(.01) Q:ETSRXCUI=""
 ..S ETSSUPP=@ETSDATA@(.03)
 ..S ETSCODE=@ETSDATA@(.05)
 ..I ETSCODE'=ETSCODE5 Q
 ..I ETSSUPP'="",ETSSUPP'="N" Q
 ..S ETSCNT=ETSCNT+1
 ..S ^TMP("ETSSTEP E",$J,ETSRXCUI)=""
 .Q
 ;
 I ETSCNT=0 D CLEANUP Q ETSCNT
 ;
 ;Step F -- Retrieve CODEs for these drug classes from concept names/sources file
 S ETSCNT=0,ETSRXCUI="" F  S ETSRXCUI=$O(^TMP("ETSSTEP E",$J,ETSRXCUI)) Q:'ETSRXCUI  D
 .S ETSIEN="" F  S ETSIEN=$O(^ETSRXN(129.2,"B",ETSRXCUI,ETSIEN)) Q:'ETSIEN  D
 ..K ETSDATA D GETS^DIQ(129.2,ETSIEN_",",".04;.05","","ETSDATA")
 ..S ETSDATA="ETSDATA(129.2,"""_ETSIEN_","")"
 ..S ETSCODE=@ETSDATA@(.04) Q:ETSCODE=""
 ..S ETSSUPP=@ETSDATA@(.05)
 ..I ETSSUPP'="",ETSSUPP'="N" Q
 ..S ETSCNT=ETSCNT+1
 ..S ^TMP("ETSSTEP F",$J,$E(ETSCODE,1,5))=""
 .Q
 ;
 I ETSCNT=0 D CLEANUP Q ETSCNT
 ;
 ;Step G -- Get simple concept/atom attributes with ATN="ATC_LEVEL" and CODEs beginning with the last list's 5-character abbreviation
 S ETSCODE5="",ETSCNT=0 F  S ETSCODE5=$O(^TMP("ETSSTEP F",$J,ETSCODE5)) Q:ETSCODE5=""  D
 .S ETSC="^ETSRXN(129.21,""C"",""ATC_LEVEL"")" F  S ETSC=$Q(@ETSC) Q:$QS(ETSC,3)'="ATC_LEVEL"  D
 ..S ETSIEN=$QS(ETSC,5)
 ..K ETSDATA D GETS^DIQ(129.21,ETSIEN_",",".01;.03;.05","","ETSDATA")
 ..S ETSDATA="ETSDATA(129.21,"""_ETSIEN_","")"
 ..S ETSRXCUI=@ETSDATA@(.01) Q:ETSRXCUI=""
 ..S ETSSUPP=@ETSDATA@(.03)
 ..S ETSCODE=@ETSDATA@(.05)
 ..I $E(ETSCODE,1,5)'=ETSCODE5 Q
 ..I ETSSUPP'="",ETSSUPP'="N" Q
 ..S ETSCNT=ETSCNT+1
 ..S ^TMP("ETSSTEP G",$J,ETSRXCUI)=""
 .Q
 ;
 I ETSCNT=0 D CLEANUP Q ETSCNT
 ;
 ;Step H -- Retrieve concept names/sources for these drugs with SAB="RXNORM"
 S ETSCNT=0,ETSRXCUI="" F  S ETSRXCUI=$O(^TMP("ETSSTEP G",$J,ETSRXCUI)) Q:'ETSRXCUI  D
 .S ETSIEN="" F  S ETSIEN=$O(^ETSRXN(129.2,"B",ETSRXCUI,ETSIEN)) Q:'ETSIEN  D
 ..K ETSDATA D GETS^DIQ(129.2,ETSIEN_",",".02;.05","","ETSDATA")
 ..S ETSDATA="ETSDATA(129.2,"""_ETSIEN_","")"
 ..S ETSSAB=@ETSDATA@(.02)
 ..S ETSSUPP=@ETSDATA@(.05)
 ..I ETSSAB'="RXNORM" Q
 ..I ETSSUPP'="",ETSSUPP'="N" Q
 ..S ETSCNT=ETSCNT+1
 ..S ^TMP("ETSSTEP H",$J,ETSRXCUI)=""
 .Q
 ;
 I ETSCNT=0 D CLEANUP Q ETSCNT
 ;
 ;Step I -- Find "has_ingredient" relationships
 S ETSRXCUI="",ETSCNT=0 F  S ETSRXCUI=$O(^TMP("ETSSTEP H",$J,ETSRXCUI)) Q:ETSRXCUI=""  D
 .S ETSIEN="" F  S ETSIEN=$O(^ETSRXN(129.22,"B",ETSRXCUI,ETSIEN)) Q:'ETSIEN  D
 ..K ETSDATA D GETS^DIQ(129.22,ETSIEN_",",".03;.04;.05;.06","","ETSDATA")
 ..S ETSDATA="ETSDATA(129.22,"""_ETSIEN_","")"
 ..S ETSRXCU2=@ETSDATA@(.03) Q:ETSRXCU2=""
 ..S ETSRELA=@ETSDATA@(.04)
 ..S ETSSAB=@ETSDATA@(.05)
 ..S ETSSUPP=@ETSDATA@(.06)
 ..I ETSRELA'="has_ingredient" Q
 ..I ETSSAB'="RXNORM" Q
 ..I ETSSUPP'="",ETSSUPP'="N" Q
 ..S ETSCNT=ETSCNT+1
 ..S ^TMP("ETSSTEP I",$J,ETSRXCU2)=""
 .Q
 ;
 I ETSCNT=0 D CLEANUP Q ETSCNT
 ;
 ;Step J -- Find "isa" relationships, using RXCUI2 from the last list as RXCUI1 lookup for this one
 S ETSRXCU1="",ETSCNT=0 F  S ETSRXCU1=$O(^TMP("ETSSTEP I",$J,ETSRXCU1)) Q:ETSRXCU1=""  D
 .S ETSIEN="" F  S ETSIEN=$O(^ETSRXN(129.22,"B",ETSRXCU1,ETSIEN)) Q:'ETSIEN  D
 ..K ETSDATA D GETS^DIQ(129.22,ETSIEN_",",".03;.04;.05;.06","","ETSDATA")
 ..S ETSDATA="ETSDATA(129.22,"""_ETSIEN_","")"
 ..S ETSRXCU2=@ETSDATA@(.03) Q:ETSRXCU2=""
 ..S ETSRELA=@ETSDATA@(.04)
 ..S ETSSAB=@ETSDATA@(.05)
 ..S ETSSUPP=@ETSDATA@(.06)
 ..I ETSRELA'="isa" Q
 ..I ETSSAB'="RXNORM" Q
 ..I ETSSUPP'="",ETSSUPP'="N" Q
 ..S ETSCNT=ETSCNT+1
 ..S ^TMP("ETSSTEP J",$J,ETSRXCU2)=""
 .Q
 ;
 I ETSCNT=0 D CLEANUP Q ETSCNT
 ;
 ;Step K -- Retrieve concept names/sources for these RXCUIs with SAB="VANDF", using RXCUI2 from the last list as RXCUI lookup for this one
 S ETSRES=0,ETSRXCUI="",ETSERR=0 F  S ETSRXCUI=$O(^TMP("ETSSTEP J",$J,ETSRXCUI)) Q:ETSRXCUI=""!ETSERR  D
 .S ETSCNT=$$RXN2OUT^ETSRXN(ETSRXCUI,"ETSSTEP K") I ETSCNT<0 S ETSERR=1 Q
 .I +ETSCNT=0 Q
 .D FILTER
 .Q
 ;
 S ^TMP(ETSSUB,$J,ETSVUID,"VUID")=ETSRES
 ;
 I ETSERR K ^TMP(ETSSUB,$J)
 ;
 D CLEANUP Q ETSRES
 ;
 ;
FILTER ;Weed out suppressed records and filter by TTY
 S ETSCTR="" F  S ETSCTR=$O(^TMP("ETSSTEP K",$J,ETSRXCUI,"VUID",ETSCTR)) Q:'ETSCTR  D
 .S ETSNODE=^TMP("ETSSTEP K",$J,ETSRXCUI,"VUID",ETSCTR,0)
 .S ETSTTY=$P(ETSNODE,U,4)
 .S ETSSUPP=$P(ETSNODE,U,6)
 .I ETSTTYS'[(","_ETSTTY_",") Q
 .I ETSSUPP'="",ETSSUPP'="N" Q
 .S ETSRES=ETSRES+1
 .S ^TMP(ETSSUB,$J,ETSVUID,"VUID",ETSRES,0)=ETSNODE
 .S ^TMP(ETSSUB,$J,ETSVUID,"VUID",ETSRES,1)=^TMP("ETSSTEP K",$J,ETSRXCUI,"VUID",ETSCTR,1)
 .I 'ETSCLASS S ^TMP(ETSSUB,$J,ETSVUID,"VUID",ETSRES,2)=$$GET1^DIQ(129.2,$P(ETSNODE,U)_",",91)
 .Q
 Q
 ;
CLEANUP ;Kill intermediate globals
 F ETSCTR="ETSSTEP A","ETSSTEP B","ETSSTEP C","ETSSTEP D","ETSSTEP E","ETSSTEP F","ETSSTEP G","ETSSTEP H","ETSSTEP I","ETSSTEP J","ETSSTEP K" K ^TMP(ETSCTR,$J)
 Q

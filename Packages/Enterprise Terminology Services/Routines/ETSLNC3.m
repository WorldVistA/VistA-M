ETSLNC3 ;O-OIFO/FM23 - LOINC APIs 4 ;01/31/2017
 ;;1.0;Enterprise Terminology Service;**1**;Mar 20, 2017;Build 7
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;               
GETREC(ETSINPT,ETSINTY,ETSSUB)  ;Get LOINC Information by Code or IEN
 ; Input  -- ETSINPT   LOINC Code (with check digit) or IEN
 ;           ETSINTY   Input Type  (Optional- Default "C")
 ;                     "C"=LOINC Code
 ;                     "I"=LOINC IEN
 ;           ETSSUB    (Optional) Subscript for ^TMP array storing the
 ;                     results (default = ETSREC)
 ; Output -- 
 ;   $$GETREC - 1 (record found), 0 - no record found, -1^<error message>
 ; 
 ;   ^TMP(ETSSUB,$J,"RECORD",     Results in the following subscripts:
 ;                         "ACTIVATION HISTORY") =  Activation History Multiple (#95)  [Not Returned]
 ;                         "ACTIVATION HISTORY",#,"ACTIVATION EFFECTIVE DATE") = FM Date ^ External Date (#129.103, #.01)
 ;                         "ACTIVATION HISTORY",#,"ACTIVATION STATUS") = Status ^ External Status (#129.103, #1)
 ;                         "ADJUSTMENT")=Adjustment field (#1.6)
 ;                         "CHALLENGE")=Challenge Field (#1.5)
 ;                         "CHANGE REASON")=Challenge Field (#24)
 ;                         "CHANGE TYPE")=Change Type field (#23)
 ;                         "CHECK DIGIT")=Check Digit Field (#15)
 ;                         "CLASS")=Class field(#7)
 ;                         "CLASSTYPE")=Internal^External Class Type field(#41)
 ;                         "CODE")=Code Field (#.01)_Check Digit (#15)
 ;                         "COMMENTS")= # lines in the comment multiple
 ;                         "COMMENTS",#)=Comments Multiple field (#99)
 ;                         "COMPONENT")=Component field (#1)
 ;                         "DATE LAST CHANGED")=Internal^Date Last Changed field (#22)
 ;                         "EXAMPLE UCUM UNITS")=Units field (#85)
 ;                         "EXTERNAL COPYRIGHT NOTICE")= # lines in word processing field
 ;                         "EXTERNAL COPYRIGHT NOTICE",#)= Line of data in the word processing field
 ;                         "FULLY SPECIFIED NAME")=Fully Specified Name field (#80)
 ;                         "IEN")= IEN of entry
 ;                         "LONG COMMON NAME")=Long Common Name field (#82)
 ;                         "MASTER ENTRY FOR VUID")=Master Entry for VUID (#99.98)
 ;                         "METHOD TYPE")=Method Type field (#6)
 ;                         "NON-PATIENT SPECIMEN")=Non-Patient Specimen field (#1.7)
 ;                         "PROPERTY")=Property field (#2)
 ;                         "REPEAT OBSERVATION")=Repeat Observation field (#86)
 ;                         "SCALE TYPE")=Scale Type field (#5)
 ;                         "SHORTNAME")=Short Name field (#81)
 ;                         "SNOMED CODE")=Short Name field (#33)
 ;                         "SOURCE")=Source field (#8)
 ;                         "STATUS")=Internal^External Status field (#20)
 ;                         "SYSTEM")=System field (#4)
 ;                         "TIME ASPECT")=Time Aspect field (#3)
 ;                         "TIME MODIFIER")=Time Aspect field (#3.1)
 ;                         "UNITS")=Time Aspect field (#10)
 ;                         "VA COMMON DISPLAY NAME")=VA Common Display Name field (#82)
 ;                         "VERSION NUMBER")=Version Number field (#25)
 ;                         "VUID")=VUID (#99.99)
 ;                         "VUID EFFECTIVE DATE") =  VUID Effective Date Multiple (#99.991)  [Not Returned]
 ;                         "VUID EFFECTIVE DATE",#,"EFFECTIVE DATE/TIME") = FM Date ^ External Date (#129.104, #.01)
 ;                         "VUID EFFECTIVE DATE",#,"STATUS") = Status ^ External Status (#129.104, #1)
 ;
 ;
 N ETSCIEN,ETSCODE,ETSARY,ETSLIEN,I,CT
 ;
 ;Set the default for the subscript if not sent
 S:$G(ETSSUB)="" ETSSUB="ETSREC"
 ;
 ;Clear previous search to prevent result contamination
 K ^TMP(ETSSUB,$J)
 ;
 ;Check for existence of an IEN/Code
 Q:$G(ETSINPT)="" "-1^Missing Code or IEN"
 ;
 ;Set Input Type to default of "C", if not defined
 S:$G(ETSINTY)="" ETSINTY="C"
 S ETSINTY=$$UP^XLFSTR(ETSINTY)
 I (ETSINTY'="C"),(ETSINTY'="I") Q "-1^Invalid Input Type"
 ; 
 ;Check input for LOINC Code or IEN
 ;Assume the input type is an IEN,find the code.
 I ETSINTY="I" S ETSCIEN=ETSINPT,ETSCODE=$$GETCODE^ETSLNC1(ETSCIEN) I +ETSCODE=-1 Q "-1^LOINC IEN not found"
 ;if the input type was a code, retrieve the IEN. 
 S:ETSINTY="C" ETSCIEN=$$CHKCODE^ETSLNC1(ETSINPT),ETSCODE=ETSINPT
 ; 
 ;Exit if the IEN was either not passed in or not found.
 Q:+ETSCIEN=-1 ETSCIEN
 ;
 ;Set-up LOINC Record array to return
 ;
 ;Start with the code and the IEN
 S ^TMP(ETSSUB,$J,"RECORD","IEN")=ETSCIEN
 ;
 ;Query data
 D GETS^DIQ(129.1,ETSCIEN_",","**","IE","ETSARY")
 ;
 ;If results returned, store into Structure
 I $D(ETSARY(129.1)) D
 . ;retrieve fields needing external values only
 . S ^TMP(ETSSUB,$J,"RECORD","ADJUSTMENT")=$G(ETSARY(129.1,ETSCIEN_",",1.6,"E"))
 . S ^TMP(ETSSUB,$J,"RECORD","CHALLENGE")=$G(ETSARY(129.1,ETSCIEN_",",1.5,"E"))
 . S ^TMP(ETSSUB,$J,"RECORD","CHANGE REASON")=$G(ETSARY(129.1,ETSCIEN_",",24,"E"))
 . S ^TMP(ETSSUB,$J,"RECORD","CHANGE TYPE")=$G(ETSARY(129.1,ETSCIEN_",",23,"E"))
 . S ^TMP(ETSSUB,$J,"RECORD","CHECK DIGIT")=$G(ETSARY(129.1,ETSCIEN_",",15,"E"))
 . S ^TMP(ETSSUB,$J,"RECORD","CLASS")=$G(ETSARY(129.1,ETSCIEN_",",7,"E"))
 . S ^TMP(ETSSUB,$J,"RECORD","CODE")=$G(ETSARY(129.1,ETSCIEN_",",.01,"E"))
 . S ^TMP(ETSSUB,$J,"RECORD","COMPONENT")=$G(ETSARY(129.1,ETSCIEN_",",1,"E"))
 . S ^TMP(ETSSUB,$J,"RECORD","EXAMPLE UCUM UNITS")=$G(ETSARY(129.1,ETSCIEN_",",85,"E"))
 . S ^TMP(ETSSUB,$J,"RECORD","FULLY SPECIFIED NAME")=$G(ETSARY(129.1,ETSCIEN_",",80,"E"))
 . S ^TMP(ETSSUB,$J,"RECORD","LONG COMMON NAME")=$G(ETSARY(129.1,ETSCIEN_",",83,"E"))
 . S ^TMP(ETSSUB,$J,"RECORD","MASTER ENTRY FOR VUID")=$G(ETSARY(129.1,ETSCIEN_",",99.98,"E"))
 . S ^TMP(ETSSUB,$J,"RECORD","METHOD TYPE")=$G(ETSARY(129.1,ETSCIEN_",",6,"E"))
 . S ^TMP(ETSSUB,$J,"RECORD","NON-PATIENT SPECIMEN")=$G(ETSARY(129.1,ETSCIEN_",",1.7,"E"))
 . S ^TMP(ETSSUB,$J,"RECORD","PROPERTY")=$G(ETSARY(129.1,ETSCIEN_",",2,"E"))
 . S ^TMP(ETSSUB,$J,"RECORD","REPEAT OBSERVATION")=$G(ETSARY(129.1,ETSCIEN_",",86,"E"))
 . S ^TMP(ETSSUB,$J,"RECORD","SCALE TYPE")=$G(ETSARY(129.1,ETSCIEN_",",5,"E"))
 . S ^TMP(ETSSUB,$J,"RECORD","SHORTNAME")=$G(ETSARY(129.1,ETSCIEN_",",81,"E"))
 . S ^TMP(ETSSUB,$J,"RECORD","SNOMED CODE")=$G(ETSARY(129.1,ETSCIEN_",",33,"E"))
 . S ^TMP(ETSSUB,$J,"RECORD","SOURCE")=$G(ETSARY(129.1,ETSCIEN_",",8,"E"))
 . S ^TMP(ETSSUB,$J,"RECORD","SYSTEM")=$G(ETSARY(129.1,ETSCIEN_",",4,"E"))
 . S ^TMP(ETSSUB,$J,"RECORD","TIME ASPECT")=$G(ETSARY(129.1,ETSCIEN_",",3,"E"))
 . S ^TMP(ETSSUB,$J,"RECORD","TIME MODIFIER")=$G(ETSARY(129.1,ETSCIEN_",",3.1,"E"))
 . S ^TMP(ETSSUB,$J,"RECORD","UNITS")=$G(ETSARY(129.1,ETSCIEN_",",10,"E"))
 . S ^TMP(ETSSUB,$J,"RECORD","VA COMMON DISPLAY NAME")=$G(ETSARY(129.1,ETSCIEN_",",82,"E"))
 . S ^TMP(ETSSUB,$J,"RECORD","VERSION NUMBER")=$G(ETSARY(129.1,ETSCIEN_",",25,"E"))
 . S ^TMP(ETSSUB,$J,"RECORD","VUID")=$G(ETSARY(129.1,ETSCIEN_",",99.99,"E"))
 . ;
 . ;Retrieve the comments multiple, if present
 . S ^TMP(ETSSUB,$J,"RECORD","COMMENTS")=""
 . I $G(ETSARY(129.1,ETSCIEN_",",99,"I"))'="" D
 .. ;Add the multiple lines
 .. S I=0,CT=0
 .. F  S I=$O(ETSARY(129.1,ETSCIEN_",",99,I)) Q:'I  D
 ... S ^TMP(ETSSUB,$J,"RECORD","COMMENTS",I)=$G(ETSARY(129.1,ETSCIEN_",",99,I)),CT=CT+1
 .. ;Change the top node to equal the # lines in the comment
 .. S ^TMP(ETSSUB,$J,"RECORD","COMMENTS")=CT
 . ;
 . ;Retrieve the External Copyright Notice word processing field multiple, if present
 . S ^TMP(ETSSUB,$J,"RECORD","EXTERNAL COPYRIGHT NOTICE")=""
 . I $G(ETSARY(129.1,ETSCIEN_",",84,"I"))'="" D
 .. ;Add the multiple lines
 .. S I=0,CT=0
 .. F  S I=$O(ETSARY(129.1,ETSCIEN_",",84,I)) Q:'I  D
 ... S ^TMP(ETSSUB,$J,"RECORD","EXTERNAL COPYRIGHT NOTICE",I)=$G(ETSARY(129.1,ETSCIEN_",",84,I)),CT=CT+1
 .. ;Change the top node to equal the # lines in the comment
 .. S ^TMP(ETSSUB,$J,"RECORD","EXTERNAL COPYRIGHT NOTICE")=CT
 . ;
 . ;Convert Date Last Changed to FM format + External, if present
 . I $G(ETSARY(129.1,ETSCIEN_",",22,"I"))'="" D
 .. S ^TMP(ETSSUB,$J,"RECORD","DATE LAST CHANGED")=$G(ETSARY(129.1,ETSCIEN_",",22,"I"))_"^"_$G(ETSARY(129.1,ETSCIEN_",",22,"E"))
 . ;
 . ;Convert Class Type to Internal and External, if present
 . I $G(ETSARY(129.1,ETSCIEN_",",41,"I"))'="" D
 .. S ^TMP(ETSSUB,$J,"RECORD","CLASSTYPE")=$G(ETSARY(129.1,ETSCIEN_",",41,"I"))_"^"_$G(ETSARY(129.1,ETSCIEN_",",41,"E"))
 . ;
 . ;Convert Status to Internal and External, if present
 . I $G(ETSARY(129.1,ETSCIEN_",",20,"I"))'="" D
 .. S ^TMP(ETSSUB,$J,"RECORD","STATUS")=$G(ETSARY(129.1,ETSCIEN_",",20,"I"))_"^"_$G(ETSARY(129.1,ETSCIEN_",",20,"E"))
 . ;
 . ;Extract Activation dates from the multiple
 . S ETSLIEN=""
 . F  S ETSLIEN=$O(ETSARY(129.103,ETSLIEN)) Q:ETSLIEN=""  D
 .. S ^TMP(ETSSUB,$J,"RECORD","ACTIVATION HISTORY",$P(ETSLIEN,","),"ACTIVATION EFFECTIVE DATE")=$G(ETSARY(129.103,ETSLIEN,.01,"I"))_"^"_$G(ETSARY(129.103,ETSLIEN,.01,"E"))
 .. S ^TMP(ETSSUB,$J,"RECORD","ACTIVATION HISTORY",$P(ETSLIEN,","),"ACTIVATION STATUS")=$G(ETSARY(129.103,ETSLIEN,1,"I"))_"^"_$G(ETSARY(129.103,ETSLIEN,1,"E"))
 . ;
 . ;Extract VUID Effective dates from the multiple
 . S ETSLIEN=""
 . F  S ETSLIEN=$O(ETSARY(129.104,ETSLIEN)) Q:ETSLIEN=""  D
 .. S ^TMP(ETSSUB,$J,"RECORD","VUID EFFECTIVE DATE",$P(ETSLIEN,","),"EFFECTIVE DATE/TIME")=$G(ETSARY(129.104,ETSLIEN,.01,"I"))_"^"_$G(ETSARY(129.104,ETSLIEN,.01,"E"))
 .. S ^TMP(ETSSUB,$J,"RECORD","VUID EFFECTIVE DATE",$P(ETSLIEN,","),"STATUS")=$G(ETSARY(129.104,ETSLIEN,.02,"I"))_"^"_$G(ETSARY(129.104,ETSLIEN,.02,"E"))
 ;
 ;Exit - Requested entry found
 Q:$D(^TMP(ETSSUB,$J,"RECORD")) 1
 ;Exit - Requested entry not found
 Q 0

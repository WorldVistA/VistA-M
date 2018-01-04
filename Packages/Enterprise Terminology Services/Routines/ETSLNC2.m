ETSLNC2 ;O-OIFO/FM23 - LOINC APIs 3 ;01/31/2017
 ;;1.0;Enterprise Terminology Service;**1**;Mar 20, 2017;Build 7
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
VERSION() ;Get LOINC Version
 ; The LOINC Version is stored in the PACKAGE REVISION DATA
 ; node of the definition of the LOINC file (#129.1).
 ;
 ; Input  -- None
 ; Output -- $$VERSION - LOINC Version, Null, or
 ;                       -1^File Definition Error
 ;
 N ETSANS,ETSARY,ETSERR
 ;
 ; Query data
 D FILE^DID(129.1,"","PACKAGE REVISION DATA","ETSARY","ETSERR")
 ;
 ; Quit if error occurred during query
 Q:$D(ETSERR) "-1^File Definition Error"
 ;
 ;Set-up LOINC version to return
 ; Initialize
 S ETSANS=""
 I $D(ETSARY("PACKAGE REVISION DATA")) D
 . S ETSANS=$P($G(ETSARY("PACKAGE REVISION DATA")),U)
 Q ETSANS
 ;
COMLST(ETSCOM,ETSTYP,ETSSUB) ;Get List by Component
 ; Input  --
 ;    ETSCOM    Component to look up.  Either IEN (File 129.1, field 1)
 ;              or Name (129.11, field .01)
 ;    ETSTYP    Type of Component, either (I)EN or (N)ame (default is N)
 ;    ETSSUB    Subscript used to store the data in
 ;              Default is "ETSCOMP"
 ;
 ; Output -- 
 ;    ^TMP(ETSSUB,$J,"COMP",ETSCODE) Fully Specified Name field (#80)
 ;           
 ;           Note: ETSARR is not initialized (ie KILLed) on input
 ;                 The calling application is responsible for
 ;                 initializing the array.
 ;
 ;    COMLST = 1 - Success
 ;             -1^<message> - Error
 ;             0 - Component not used
 ;
 N ETSCIEN,ETSCODE,ETSFSN,ETSCMIEN
 ;
 ;Set default array Subscript
 S:$G(ETSSUB)="" ETSSUB="ETSCOMP"
 ;
 ;Clean up temp array.
 K ^TMP(ETSSUB,$J)
 ;
 S ETSCOM=$$TRIM^XLFSTR(ETSCOM)
 ;
 ;Quit if no component sent
 Q:$G(ETSCOM)="" "-1^Component is missing"
 ;
 S ETSCOM=$$UP^XLFSTR(ETSCOM)
 ;Set Input Type to default of "N", if not defined
 S:$G(ETSTYP)="" ETSTYP="N"
 I (ETSTYP'="N"),(ETSTYP'="I") Q "-1^Invalid Input Type"
 ;
 ;If the component is an IEN, do setup.
 S:ETSTYP="I" ETSCMIEN=ETSCOM
 ;If the component is a name, find its IEN and do setup
 ; Quit with error message if name not found in Component index, (File 129.11, Index "B"
 I ETSTYP="N" Q:'$D(^ETSLNC(129.11,"B",$E(ETSCOM,1,240))) "-1^Component Not Found"  D
 . S ETSCMIEN=$O(^ETSLNC(129.11,"B",$E(ETSCOM,1,240),""))
 ;
 ;Set-up LOINC List to return
 S ETSCIEN=0
 ;
 F  S ETSCIEN=$O(^ETSLNC(129.1,"C",ETSCMIEN,ETSCIEN)) Q:'ETSCIEN  D
 . I $D(^ETSLNC(129.1,ETSCIEN,0)) D
 .. S ETSCODE=$P(^ETSLNC(129.1,ETSCIEN,0),"^")
 .. ;get the fully specified name (fsn)
 .. S ETSFSN=$G(^ETSLNC(129.1,ETSCIEN,80))
 .. ;Save the fully specified name to the array.
 .. S ^TMP(ETSSUB,$J,"COMP",ETSCODE)=ETSFSN
 ;
 ;If the component was found in a LOINC Code,
 ; return 1
 Q:$D(^TMP(ETSSUB,$J)) 1
 ;otherwise, return 0
 Q 0
 ;
DEPLST(ETSSUB) ;Get Deprecated List
 ; Input  -- (Optional) ETSSUB Subscript for the 
 ;               Temporary Deprecated List Array
 ;               (Default is "ETSDEP")
 ; 
 ; Output -- Temporary Global Deprecated List Array
 ;           ^TMP(ETSSUB,$J,"DEPRECATED",<ETSCODE>)=Fully Specified Name field (#80)
 ;           $$DEPLST  - 1 Deprecated items found
 ;                       0 No Deprecated items found
 ;
 ;Set default subscript if necessary.
 S:$G(ETSSUB)="" ETSSUB="ETSDEP"
 ;
 ;Clear array
 K ^TMP(ETSSUB,$J)
 ;
 N ETSCIEN,ETSCODE
 ;
 ;Create List to return
 S ETSCIEN=0
 F  S ETSCIEN=$O(^ETSLNC(129.1,"AD",1,ETSCIEN)) Q:'ETSCIEN  D
 . I $D(^ETSLNC(129.1,ETSCIEN,0)) D
 .. S ETSCODE=$P(^ETSLNC(129.1,ETSCIEN,0),"^",1)
 .. S ^TMP(ETSSUB,$J,"DEPRECATED",ETSCODE)=$G(^ETSLNC(129.1,ETSCIEN,80))
 ;
 ;Exiting:
 ; If deprecated items found
 Q:$D(^TMP(ETSSUB,$J)) 1
 ;Otherwise, send 0 - no results
 Q 0

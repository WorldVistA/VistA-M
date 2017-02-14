HMPORRPC ;ASMR/MBS -- Orders RPCs ;01/06/2015  16:42
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2**;Dec 22, 2015;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 ; External References          DBIA#
 ; -------------------          -----
 ; ^OR(100                       5771
 ; DIQ                           2056
 Q
RELATED(RET,IEN) ;
 N RESULT,I,HMPSIBS,HMPKIDS,PARENT
 S RESULT=$NA(^TMP($J,"HMPORRPC")) K @RESULT
 I '+$G(IEN) S @RESULT@("error")="No order selected" G JSONIFY
 I '+$$GET1^DIQ(100,IEN_",",".01","I") S @RESULT@("error")="Nonexisting order" G JSONIFY
 ;See if we have a parent
 S PARENT=$$GET1^DIQ(100,IEN_",",36,"I")
 I +PARENT D
 . S @RESULT@("parent")=PARENT
 . ;Check for siblings
 . D LIST^DIC(100.002,","_PARENT_",","@;.01","I",,,,,,,"HMPSIBS")
 . F I=1:1:+$G(HMPSIBS("DILIST",0)) D
 . . Q:$G(HMPSIBS("DILIST",2,I))=IEN
 . . S @RESULT@("siblings",I)=$G(HMPSIBS("DILIST",2,I))
 ;Get children
 D LIST^DIC(100.002,","_IEN_",","@;.01","I",,,,,,,"HMPKIDS")
 F I=1:1:+$G(HMPKIDS("DILIST",0)) D
 . S @RESULT@("children",I)=$G(HMPKIDS("DILIST",2,I))
 ;US11945 - If we're calling this from HMPDJ01, don't convert to JSON yet
 I $G(HMPNOJS)=1 S RET=RESULT Q
JSONIFY ;
 D ENCODE^HMPJSON(RESULT,"RET")
 Q

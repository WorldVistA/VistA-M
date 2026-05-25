SDES2GETLINKS ;ALB/TJB,LAB - VISTA SCHEDULING GET LINKS from file 409.98 ;JUN 9,2025
 ;;5.3;Scheduling;**861,909**;Aug 13, 1993;Build 12
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ; Reference to DUZ^XUP is supported by IA #7487
 ;
 Q
 ;
 ; VSE-5546 - SDES2 GET HELP LINKS
GETLINKS(SDRETURN,SDCONTEXT) ;
 ;
 N COUNT,NAME,NAMET,HLIEN,ERRORS,HELPLNK
 ; validate context array, quit if errors
 D VALCONTEXT^SDES2VALCONTEXT(.ERRORS,.SDCONTEXT)
 I $D(ERRORS) S ERRORS("HelpLinks",1)="" D BUILDJSON^SDES2JSON(.SDRETURN,.ERRORS) Q
 I $G(SDCONTEXT("USER DUZ"))'="" N DUZ D DUZ^XUP(SDCONTEXT("USER DUZ"))
 ;
 D BUILDLINKS(.HELPLNK)
 I '$D(HELPLNK) S HELPLNK("HelpLinks",1)=""
 ;
 D BUILDJSON^SDES2JSON(.SDRETURN,.HELPLNK)
 Q
BUILDLINKS(HELPLNK) ;
 N COUNT,NAME,NAMET,HLIEN
 S COUNT=0,NAME=""
 ; NAME = Item name from "B" cross reference 
 ; NAMET = Title format of NAME above with spaces stripped to be used in JSON output
 F  S NAME=$O(^SDEC(409.98,"B",NAME)) Q:NAME=""  S COUNT=COUNT+1,NAMET=$TR($$TITLE^XLFSTR(NAME)," ","") D
 . S HLIEN="" F  S HLIEN=$O(^SDEC(409.98,"B",NAME,HLIEN)) Q:HLIEN=""  D
 .. N ARRAY,NCOUNT,J,FLDNM,FLDNMT
 .. ; FLDNM = the field name returned from the GETS^DIQ call
 .. ; FLDNMT = Title format of the field name with spaces stripped to be used in JSON output
 .. S NCOUNT=0
 .. ; the "R" parameter returns the field names in the array returned by the GETS^DIQ
 .. D GETS^DIQ(409.98,HLIEN_",","1*","R","ARRAY")
 .. S J="" F  S J=$O(ARRAY(409.981,J)) Q:J=""  S NCOUNT=NCOUNT+1 D
 ... S FLDNM="" F  S FLDNM=$O(ARRAY(409.981,J,FLDNM)) Q:FLDNM=""  D
 .... S FLDNMT=$TR($$TITLE^XLFSTR(FLDNM)," ","")
 .... S HELPLNK("HelpLinks",COUNT,NAMET,NCOUNT,FLDNMT)=$G(ARRAY(409.981,J,FLDNM))
 .... Q
 ;
 Q

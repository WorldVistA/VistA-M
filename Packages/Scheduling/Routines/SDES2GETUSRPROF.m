SDES2GETUSRPROF ;ALB/JAS,JDJ - VISTA SCHEDULING SDES2 RPCS GET USER KEYS AND OPTIONS ; JUNE 24, 2025
 ;;5.3;Scheduling;**890,909**;Aug 13, 1993;Build 12
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ;External References
 ;-------------------
 ; Reference to $$GETS^DIQ,$$GETS1^DIQ in ICR #2056
 ; Reference to $$FIND1^DIC in ICR #2051
 ; Reference to NEW PERSON in ICR #10060
 ; Reference to $$ACTIVE^XUSER in ICR #2343
 ; Reference to DUZ^XUP is supported by IA #7487
 ;
 Q
 ;
GETUSRPROBYSECID(JSONRETURN,SDCONTEXT,SDINPUT) ;Called from RPC: SDES2 GET USER PROFILE BY SECID
 ; The SDCONTEXT array is controlled by the Acheron application and its fields are
 ; needed for the storage of the required auditing information.
 ;
 ; SDCONTEXT("ACHERON AUDIT ID") = Up to 40 Character unique ID number. Ex: 11d9dcc6-c6a2-4785-8031-8261576fca37
 ; SDCONTEXT("PATIENT DFN") = The DFN/IEN of the target patient from the calling application.
 ; SDCONTEXT("PATIENT ICN") = The ICN of the target patient from the calling application.
 ; SDCONTEXT("USER DUZ") = The DUZ of the user taking action in the calling application.
 ; SDCONTEXT("USER SECID") = The SECID of the user taking action in the calling application.
 ;
 ; SDINPUT("USER SECID") = The SECID of the user being queried.
 ;
 ; OUTPUT - SDRETURN
 ;   List of a user's details from the NEW PERSON (#200) file that meets the search criteria.
 ;
 N SDERRORS,SDRETURN,SDUSRIEN
 ;
 ; Validate SDCONTEXT
 D VALCONTEXT^SDES2VALCONTEXT(.SDERRORS,.SDCONTEXT)
 I $D(SDERRORS) M SDRETURN=SDERRORS S SDRETURN("User",1)="" D BUILDJSON^SDES2JSON(.JSONRETURN,.SDRETURN) Q
 ; Visitor Pattern
 I $G(SDCONTEXT("USER DUZ"))'="" N DUZ D DUZ^XUP(SDCONTEXT("USER DUZ"))
 ;
 ; Validate USER SECID
 I $G(SDINPUT("USER SECID"))="" D  Q
 . D ERRLOG^SDES2JSON(.SDERRORS,130) M SDRETURN=SDERRORS
 . S SDRETURN("User",1)="" D BUILDJSON^SDES2JSON(.JSONRETURN,.SDRETURN)
 D VALSECID^SDES2VAL200(.SDERRORS,SDINPUT("USER SECID"))
 I $D(SDERRORS) M SDRETURN=SDERRORS S SDRETURN("User",1)="" D BUILDJSON^SDES2JSON(.JSONRETURN,.SDRETURN) Q
 ;
 ; Get and Validate DUZ
 D GETUSRIEN(.SDERRORS,SDINPUT("USER SECID"),.SDUSRIEN)
 I $D(SDERRORS) M SDRETURN=SDERRORS S SDRETURN("User",1)="" D BUILDJSON^SDES2JSON(.JSONRETURN,.SDRETURN) Q
 D VALUSERDUZ^SDES2VAL200(.SDERRORS,SDUSRIEN)
 I $D(SDERRORS) M SDRETURN=SDERRORS S SDRETURN("User",1)="" D BUILDJSON^SDES2JSON(.JSONRETURN,.SDRETURN) Q
 ;
 D GETUSRINFO(.SDRETURN,SDUSRIEN)
 D BUILDJSON^SDES2JSON(.JSONRETURN,.SDRETURN)
 Q
 ;
GETUSRPROBYDUZ(JSONRETURN,SDCONTEXT,SDINPUT) ;Called from RPC: SDES2 GET USER PROFILE BY DUZ
 ; The SDCONTEXT array is controlled by the Acheron application and its fields are
 ; needed for the storage of the required auditing information.
 ;
 ; SDCONTEXT("ACHERON AUDIT ID") = Up to 40 Character unique ID number. Ex: 11d9dcc6-c6a2-4785-8031-8261576fca37
 ; SDCONTEXT("PATIENT DFN") = The DFN/IEN of the target patient from the calling application.
 ; SDCONTEXT("PATIENT ICN") = The ICN of the target patient from the calling application.
 ; SDCONTEXT("USER DUZ") = The DUZ of the user taking action in the calling application.
 ; SDCONTEXT("USER SECID") = The SECID of the user taking action in the calling application.
 ;
 ; SDINPUT("USER DUZ") = The DUZ of the user being queried.
 ;
 ; OUTPUT - SDRETURN
 ;   List of a user's details from the NEW PERSON (#200) file that meets the search criteria.
 ;
 N SDERRORS,SDRETURN,SDUSRIEN
 ;
 ; Validate SDCONTEXT
 D VALCONTEXT^SDES2VALCONTEXT(.SDERRORS,.SDCONTEXT)
 I $D(SDERRORS) M SDRETURN=SDERRORS S SDRETURN("User",1)="" D BUILDJSON^SDES2JSON(.JSONRETURN,.SDRETURN) Q
 ; Visitor Pattern
 I $G(SDCONTEXT("USER DUZ"))'="" N DUZ D DUZ^XUP(SDCONTEXT("USER DUZ"))
 ;
 ; Validate USER DUZ
 D VALUSERDUZ^SDES2VAL200(.SDERRORS,SDINPUT("USER DUZ"),1)
 I '$D(SDERRORS),'$$ACTIVE^XUSER(SDINPUT("USER DUZ")) D ERRLOG^SDES2JSON(.SDERRORS,458)
 I $D(SDERRORS) M SDRETURN=SDERRORS S SDRETURN("User",1)="" D BUILDJSON^SDES2JSON(.JSONRETURN,.SDRETURN) Q
 ;
 D GETUSRINFO(.SDRETURN,SDINPUT("USER DUZ"))
 D BUILDJSON^SDES2JSON(.JSONRETURN,.SDRETURN)
 Q
 ;
GETUSRIEN(SDERRORS,SDSECID,SDUSRIEN) ;
 N SCERR
 S SDUSRIEN=$$FIND1^DIC(200,,"X",SDSECID,"ASECID",,"SCERR")
 I $D(SCERR) D ERRLOG^SDES2JSON(.SDERRORS,156) Q
 I '$$ACTIVE^XUSER(SDUSRIEN) D ERRLOG^SDES2JSON(.SDERRORS,458)
 Q
 ;
GETUSRINFO(SDRETURN,SDUSRIEN) ; Get User Keys and Scheduling Options
 N SDFIELDS,SDDATA,SDMSG,SDIEN,SDCNT,SDOPTION,SDKEY,SDDIV,SDDIVIEN,SDSTATNUM,SDDEFAULT
 S SDFIELDS=".01;201;203*;51*;16*"
 D GETS^DIQ(200,SDUSRIEN_",",SDFIELDS,"IE","SDDATA","SDMSG")
 S SDRETURN("User","Name")=$G(SDDATA(200,SDUSRIEN_",",.01,"E")) ;User Name
 S SDRETURN("User","IEN")=SDUSRIEN
 S SDRETURN("User","StationID")=$$DEFAULTSTATION^SDECDUZ()
 S SDOPTION=$G(SDDATA(200,SDUSRIEN_",",201,"E"))
 S SDRETURN("User","PrimaryMenuOption")=SDOPTION ;Primary Menu Option
 ;
 ; Secondary Options Multiple
 S SDIEN="",SDCNT=0
 F  S SDIEN=$O(SDDATA(200.03,SDIEN)) Q:SDIEN=""  D
 . S SDOPTION=$G(SDDATA(200.03,SDIEN,.01,"E"))
 . S SDCNT=SDCNT+1 S SDRETURN("User","SecondaryMenu",SDCNT,"Option")=SDOPTION
 ;
 ; Security Keys Multiple
 S SDIEN="",SDCNT=0
 F  S SDIEN=$O(SDDATA(200.051,SDIEN)) Q:SDIEN=""  D
 . S SDKEY=$G(SDDATA(200.051,SDIEN,.01,"E"))
 . S SDCNT=SDCNT+1 S SDRETURN("User","SecurityKey",SDCNT,"Name")=SDKEY
 ;
 ; Divisions Multiple
 S (SDIEN,SDSTATNUM,SDDEFAULT)="",SDCNT=0
 F  S SDIEN=$O(SDDATA(200.02,SDIEN)) Q:SDIEN=""  D
 . S SDDIVIEN=$G(SDDATA(200.02,SDIEN,.01,"I"))
 . S SDSTATNUM=$$GET1^DIQ(4,SDDIVIEN,99,"I")
 . S SDDIV=$G(SDDATA(200.02,SDIEN,.01,"E"))
 . S SDDEFAULT=$G(SDDATA(200.02,SDIEN,1,"I"))
 . S SDDEFAULT=$S(SDDEFAULT=1:"YES",1:"")
 . S SDCNT=SDCNT+1
 . S SDRETURN("User","Division",SDCNT,"Name")=SDDIV
 . S SDRETURN("User","Division",SDCNT,"IEN")=SDDIVIEN
 . S SDRETURN("User","Division",SDCNT,"Division")=SDSTATNUM
 . S SDRETURN("User","Division",SDCNT,"Default")=SDDEFAULT
 ;
 I SDCNT=0 D
 . I $G(DUZ(2))'="" D
 . . S SDCNT=SDCNT+1
 . . S SDRETURN("User","Division",SDCNT,"Division")=$G(DUZ(2))
 . . S SDRETURN("User","Division",SDCNT,"IEN")=$G(DUZ(2))
 . . S SDRETURN("User","Division",SDCNT,"Name")=$$GET1^DIQ(4,$G(DUZ(2)),.01,"E")
 . . S SDRETURN("User","Division",SDCNT,"Default")=""
 ;
 I '$D(SDRETURN("User")) S SDRETURN("User",1)=""
 Q

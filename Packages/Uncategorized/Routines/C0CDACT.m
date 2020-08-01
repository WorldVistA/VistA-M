C0CDACT ; GPL - Patient Portal - CCDA Routines ;09/23/13  17:05
 ;;0.1;JJOHPP;nopatch;noreleasedate;Build 1
 ;
 ; License AGPL v3.0
 ; 
 ; This software was funded in part by Oroville Hospital, and was
 ; created with help from Oroville's doctors and staff.
 ;
 Q
 ;
DOCS(BLIST,DFN,CCDAWRK,CCDARPT,CCDACTRL) ;
 ;
 N CCDAV,CCDAV1,PARMS,HAVDTS,NTCNT
 S NTCNT=0
 I $D(@CCDACTRL@("PARMS")) M PARMS=@CCDACTRL@("PARMS")
 S HAVDTS=0
 I $D(PARMS("startDateTime")) S HAVDTS=1
 N STRT,STOP
 S STRT=$G(PARMS("startDateTime"))
 S STOP=$G(PARMS("endDateTime"))
 S @CCDARPT@("STATUS")="EXTRACTING"
 S @CCDARPT@("EXTRACT-BEGIN")=$$NOW^XLFDT
 D GETPAT^C0CDACE(.CCDAV1,DFN,"documents",STRT,STOP)
 N DOINGALL S DOINGALL=0
 I +$G(CCDAV1("results","documents@total"))=0 D  ;
 . S DOINGALL=1
 . D GETPAT^C0CDACE(.CCDAV1,DFN,"documents") ; retrieve all documents
 I '$D(CCDAV1) Q  ;
 I CCDAV1("results","documents@total")=0 Q  ;
 I CCDAV1("results","documents@total")=1 D  ;
 . M CCDAV(1)=CCDAV1("results","documents")
 E  M CCDAV=CCDAV1("results","documents")
 S @CCDARPT@("EXTRACT-ENDS")=$$NOW^XLFDT
 ;
 ; deterimine if there are documents in the date range
 ;
 N HAVEDOCS S HAVEDOCS=1
 I HAVDTS=1 D  ; we have requested dates
 . Q:DOINGALL
 . S HAVEDOCS=0 ; assume no docs in date range
 . N C0I S C0I=0
 . F  S C0I=$O(CCDAV(C0I)) Q:HAVEDOCS  Q:+C0I=0  D  ;
 . . N C0DATE S C0DATE=$G(CCDAV(C0I,"document","referenceDateTime@value"))
 . . I $$SKIP^C0CDACV(C0DATE,.PARMS)=0 S HAVEDOCS=1
 I $D(C0DEBUG) I 'HAVEDOCS W !,"NO DOCUMENTS"
 Q:'HAVEDOCS
 N ADVCNT,DISCNT,POCCNT,FUNCNT ; counts for Discharge, Plan of Care, Func Stat
 S ADVCNT=0,DISCNT=0,POCCNT=0,FUNCNT=0
 N DOCTBL S DOCTBL=$NA(@CCDACTRL@("DOCUMENTS"))
 D PROCESS ; process this group of extracted documents
 D PROCTEAM ; process care team members
 Q
 ; code below has been cut out because it was causing duplicates in CCD mode
 I ((ADVCNT=0)!(FUNCNT=0)) D  ; look for required document types 
 . ;outside the data range
 . Q:DOINGALL
 . S DOINGALL=1 ; doing all this time for entire record
 . ;I $G(PARMS("NOTES"))="ALL" Q  ; don't do all twice 
 . D GETPAT^C0CDACE(.CCDAV1,DFN,"documents") ; get all documents
 . I '$D(CCDAV1) Q  ;
 . I CCDAV1("results","documents@total")=0 Q  ;
 . I CCDAV1("results","documents@total")=1 D  ;
 . . M CCDAV(1)=CCDAV1("results","documents")
 . E  M CCDAV=CCDAV1("results","documents")
 . S @CCDARPT@("EXTRACT-ENDS")=$$NOW^XLFDT
 . D PROCESS ; process all of the documents
 Q
 ;
PROCESS ;
 N C0I S C0I=0
 F  S C0I=$O(CCDAV(C0I)) Q:+C0I=0  D  ;
 . N C0DATE S C0DATE=$G(CCDAV(C0I,"document","referenceDateTime@value"))
 . ;I $$SKIP^C0CDACV(C0DATE,.PARMS)=0 Q  ;
 . N URI S URI="uri_note_"_$G(CCDAV(C0I,"document","id@value"))
 . S C0ARY(C0I,"URI")=URI
 . Q:$$REDACT^C0CDACV(URI,.PARMS)
 . N NATTYPE,NATTIT,NATSUB,LOCTIT,DOCCLASS
 . S DOCCLASS=$G(CCDAV(C0I,"document","documentClass@value"))
 . S LOCTIT=$G(CCDAV(C0I,"document","localTitle@value"))
 . S NATTIT=$G(CCDAV(C0I,"document","nationalTitle@name"))
 . S NATTYPE=$G(CCDAV(C0I,"document","nationalTitleSubject@name"))
 . S NATSUB=$G(CCDAV(C0I,"document","nationalTitleType@name"))
 . M @DOCTBL@(C0I)=CCDAV(C0I,"document")
 . S:DOCCLASS'="" @DOCTBL@("TITLES",DOCCLASS,C0I)=""
 . S:LOCTIT'="" @DOCTBL@("TITLES",LOCTIT,C0I)=""
 . S:NATTIT'="" @DOCTBL@("TITLES",NATTIT,C0I)=""
 . S:NATTYPE'="" @DOCTBL@("TITLES",NATTYPE,C0I)=""
 . S:NATSUB'="" @DOCTBL@("TITLES",NATSUB,C0I)=""
 . N ZTXT,ZIEN,C0ARY
 . S ZIEN=$G(CCDAV(C0I,"document","id@value"))
 . Q:ZIEN=""
 . N UTIT,TITYPE,UTEMP
 . S UTEMP="TNOTESEC^C0CDACT"
 . S TITYPE="Note" ; prefix for the note title
 . ;S TITYPE="" ; prefix for the note title
 . D  ; convert local title to uppercase and store in UTIT
 . . N X,Y
 . . S X=LOCTIT
 . . X ^%ZOSF("UPPERCASE")
 . . S UTIT=Y
 . I $G(PARMS("NOTES"))="" S PARMS("NOTES")="CCD"
 . I UTIT["CCD" D  ; this is a CCD template
 . . S UTEMP="TNOTESEC^C0CDAC9" ; 
 . . S UTIT=$P(UTIT,"-CCD",1)
 . . S TITYPE="CCD"
 . I UTIT["DISCHARGE" D  ; this is a discharge component
 . . I TITYPE="CCD" Q  ;
 . . I $G(PARMS("NOTES"))'="ALL" I DISCNT>0 Q  ; only one allowed
 . . I DOINGALL&DISCNT>0 Q  ; 
 . . S TITYPE="Discharge-"
 . . S UTEMP="TDISSEC^C0CDAC9" ; discharge template
 . . S DISCNT=DISCNT+1
 . I ((UTIT["PLAN OF CARE")!(UTIT["CARE PLAN")) D  ; 
 . . I TITYPE="CCD" Q  ;
 . . I $G(PARMS("NOTES"))'="ALL" I POCCNT>0 Q  ; only one allowed
 . . I DOINGALL&POCCNT>0 Q  ; 
 . . S TITYPE="Plan of Care-"
 . . S UTEMP="TPLOCSEC^C0CDAC9" ; 
 . . S POCCNT=POCCNT+1
 . I ((UTIT["FUNCTION")!(UTIT["FUNCTION")) D  ; 
 . . I TITYPE="CCD" Q  ;
 . . I $G(PARMS("NOTES"))'="ALL" I FUNCNT>0 Q  ; only one allowed
 . . I DOINGALL&FUNCNT>0 Q  ; 
 . . S TITYPE="Functional Status - "
 . . S UTEMP="TFUNCSEC^C0CDAC9" ; 
 . . S FUNCNT=FUNCNT+1
 . I UTIT["ADVANCE DIRECTIVE" D  ; 
 . . I TITYPE="CCD" Q  ;
 . . I $G(PARMS("NOTES"))'="ALL" I ADVCNT>0 Q  ; only one allowed
 . . I DOINGALL&ADVCNT>0 Q  ; 
 . . S TITYPE="Advance Directives-"
 . . S UTEMP="TADVDSEC^C0CDAC9" ; 
 . . S ADVCNT=ADVCNT+1
 . I UTIT["CLINICAL SUMMARY" D  ; 
 . . I TITYPE="CCD" Q  ;
 . . Q:DOINGALL  ; don't generate if out of date range
 . . S TITYPE="Clinical Summary-"
 . . S UTEMP="TNOTESEC^C0CDAC9" ; 
 . Q:((DOINGALL)&(TITYPE="Note"))  ; means we are scanning for 
 . ; special titles only (handled above)
 . I $G(PARMS("NOTES"))'="ALL" I TITYPE="Note" Q  ; skip if not notes=all
 . I $G(PARMS("NOTES"))="CCD" I TITYPE'="CCD" Q  ; skip if not a CCD and we are in CCD mode
 . I TITYPE="CCD" S TITYPE=""
 . I LOCTIT["CCD" S LOCTIT=$P(LOCTIT,"-CCD",1)
 . S C0ARY("text",1)="<title>"_TITYPE_" "_$$CHARCHK^MXMLBLD(LOCTIT)_"</title>"
 . S C0ARY("text",2)="<text ID="""_URI_""">"
 . D GETNOTE("ZTXT",ZIEN)
 . N ZJ S ZJ=0
 . S C0ARY("text",3)="<list>"
 . S C0ARY("text",4)="<item>"_$$FMTE^XLFDT(C0DATE)_"</item>"
 . B:$G(C0DEBUG)
 . N ZTXT2,%ZT S %ZT=0
 . F  S %ZT=$O(ZTXT(%ZT)) Q:+%ZT=0  S ZTXT2(%ZT,0)=ZTXT(%ZT) ; convert to WP format
 . D HTML2TXT^TMGHTM1(.ZTXT2)
 . K ZTXT F  S %ZT=$O(ZTXT2(%ZT)) Q:+%ZT=0  S ZTXT(%ZT)=ZTXT2(%ZT,0) ; convert from WP format 
 . F  S ZJ=$O(ZTXT(ZJ)) Q:+ZJ=0  D  ;
 . . ;I ((ZIEN=1169180)&(ZJ=31)) Q  ; there is garbage on this node
 . . N OK,%C0 S %C0=ZTXT(ZJ)
 . . ;S OK=$$UNHTML(.%C0) ; remove html markup
 . . S ZTXT(ZJ)=%C0
 . . S C0ARY("text",ZJ+4)="<item>"_$$CLEAN2^C0CDACE($$CHARCHK^MXMLBLD(ZTXT(ZJ)))_"</item>"
 . N ZEND S ZEND=$O(ZTXT(" "),-1)+4
 . S C0ARY("text",ZEND+1)="</list>"
 . S C0ARY("text",ZEND+2)="</text>"
 . S NTCNT=NTCNT+1
 . N SSECT S SSECT=$NA(@CCDAWRK@("DOCSECT"_NTCNT))
 . D GNMAPWP^C0CDACU(SSECT,UTEMP,"C0ARY")
 . D QUEUE^MXMLTMPL(BLIST,SSECT,1,@SSECT@(0))
 ;B
 Q
 ;
PROCTEAM ; process list of team members
 ;
 N NAMES,NAME,CDUZ,CVARS,CADDR
 N C0I S C0I=0
 F  S C0I=$O(CCDAV(C0I)) Q:+C0I=0  D  ;
 . N GN S GN=$NA(CCDAV(C0I,"document","clinicians"))
 . N C0J S C0J=0
 . F  S C0J=$O(@GN@(C0J)) Q:+C0J=0  D  ;
 . . S NAME=$G(@GN@(C0J,"clinician@name"))
 . . Q:NAME=""
 . . S NAMES(NAME)=""
 . . S NAMES(NAME,"DUZ")=$G(@GN@(C0J,"clinician@code"))
 S C0ARY("text",1)="<title>CARE TEAM MEMBERS</title>"
 S C0ARY("text",2)="<text ID=""CARE-TEAM-1"">"
 S C0ARY("text",3)="<list>"
 N C0N S C0N=3
 N C0K S C0K=""
 F  S C0K=$O(NAMES(C0K)) Q:C0K=""  D  ;
 . S C0N=C0N+1
 . S CDUZ=$G(NAMES(C0K,"DUZ"))
 . I CDUZ'="" D  ;
 . . K CADDR,CVARS
 . . S CADDR=$$CLINADDR(CDUZ,"CVARS")
 . S C0ARY("text",C0N)="<item>"_C0K_" "_CADDR_"</item>"
 S C0ARY("text",C0N+1)="</list>"
 S C0ARY("text",C0N+2)="</text>"
 ;ZWR NAMES
 S UTEMP="TNOTESEC^C0CDAC9" ;
 S UTIT="CARE TEAM MEMBERS"
 S TITYPE="TEAM"
 S NTCNT=NTCNT+1
 N SSECT S SSECT=$NA(@CCDAWRK@("DOCSECT"_NTCNT))
 D GNMAPWP^C0CDACU(SSECT,UTEMP,"C0ARY")
 D QUEUE^MXMLTMPL(BLIST,SSECT,1,@SSECT@(0))
 Q
 ;
CLINADDR(CDUZ,ZVARS) ; extrinsic returns the address and phone number of a clinician as a string
 ; ZVARS is passed by name and contains the new person record for the DUZ
 Q:$G(CDUZ)=""
 D FMX^C0CDACU(ZVARS,200,CDUZ)
 N TRTN S TRTN=""
 S TRTN=TRTN_$G(@ZVARS@("NEW_PERSON","STREET_ADDRESS_1"))
 S TRTN=TRTN_", "_$G(@ZVARS@("NEW_PERSON","CITY"))
 S TRTN=TRTN_","_$G(@ZVARS@("NEW_PERSON","STATE"))
 S TRTN=TRTN_" "_$G(@ZVARS@("NEW_PERSON","ZIP_CODE"))
 S TRTN=TRTN_" Phone: "_$G(@ZVARS@("NEW_PERSON","OFFICE_PHONE"))
 ;
 q TRTN
 ;
UNHTML(LN) ; line passed by reference - removes HTML markup 
 ; use HTML2TXT^TMGHTM1 if available instead of this
 ; extrinsic return 0 if no markup
 ; recursive to remove all the markup in the line
 N C0LOC1,C0LOC2,C0TMP,OK,BEFORE,AFTER
 I LN'["<" Q 0  ; exit condition - no markup on the line
 S C0LOC1=$F(LN,"<")
 S C0LOC2=$F(LN,">")
 S C0TMP=LN
 I C0LOC1=2 D  ;
 . S BEFORE=""
 E  S BEFORE=$E(C0TMP,1,C0LOC1-2)
 I C0LOC2=$L(C0TMP) S AFTER=""
 E  S AFTER=$E(C0TMP,C0LOC2,$L(C0TMP))
 S LN=BEFORE_AFTER
 S OK=$$UNHTML(.LN)
 Q 1
 ;
GETNOTE(RTN,ZIEN) ; retrieve the text of a note by ien
 ; RTN is passed by name
 N OK
 S OK=$$GET1^DIQ(8925,ZIEN_",",2,,RTN)
 Q
 ;
GETIENS(RTN,ZARY) ; RTN is passed by reference, ZARY by name
 ;
 N ZI S ZI=""
 F  S ZI=$O(@ZARY@(ZI)) Q:+ZI=0  D  ;
 . S RTN(ZI)=$G(@ZARY@(ZI,"id@value"))
 ;ZWR RTN
 Q 
 ;
GETALL(RTN,ZIENS) ; RTN passed by name ZIENS passed by reference
 N ZI S ZI=""
 F  S ZI=$O(ZIENS(ZI)) Q:+ZI=0  D  ;
 . D GETNOTE($NA(@RTN@(ZI)),ZIENS(ZI))
 ZWR @RTN
 Q
 ;
TNOTESEC ;
 ;;<component>
 ;;<section>
 ;;<templateId root="2.16.840.1.113883.10.20.22.2.45"></templateId>
 ;;<id root="184fdbe3-f480-4199-976d-e0bb0dd02551"></id>
 ;;<code code="69730-0" codeSystem="2.16.840.1.113883.6.1" codeSystemVersion="LOINC" displayName="Instructions"></code>
 ;;@@text@@
 ;;</section>
 ;;</component>
 Q
 ;
ANALYZE ; find test patients with necessary note titles
 ;
 Q
 ;

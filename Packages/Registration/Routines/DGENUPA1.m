DGENUPA1 ;ALB/CJM - UPLOAD AUDIT ; 04-APR-94
 ;;5.3;REGISTRATION;**147,222,232**;Aug 13,1993
 ;
AUDIT(ERROR,MSGID,OLDPAT,NEWPAT,OLDELG,NEWELG,OLDCDIS,NEWCDIS,NEWSEC,OLDSEC) ;
 ;Description: creates an audit trail for an upload.
 ;
 ;Input:
 ;Output:
 ;  Function Value: 1 on sucess, 0 on failure
 ;  ERROR - error message (optional, pass by reference)
 N AUDIT
 D CREATE^DGENUPA(OLDPAT("DFN"),,MSGID,.AUDIT)
 D PAT
 D ELIG
 D ELGCODES
 D RDISB
 D CDIS
 D SEC
 Q +$$STORE^DGENUPA(.AUDIT,.ERROR)
 ;
ELIG ;
 ;Description: Changes for Eligibility object (other than multiples)
 N FIELD,LINE,IEN,HDR
 S HDR=0
 I OLDELG("ELIG","CODE")'=NEWELG("ELIG","CODE") D
 .;
 .S LINE=$$LJ^XLFSTR("PRIMRY ELIG:   ",15)_$$LJ^XLFSTR($$EXT^DGENELA3("CODE",OLDELG("ELIG","CODE")),33)_"   "_$$EXT^DGENELA3("CODE",NEWELG("ELIG","CODE"))
 .I 'HDR D ELGHDR
 .D ADDCHNG^DGENUPA(.AUDIT,LINE)
 ;
 S FIELD=""
 F  S FIELD=$O(OLDELG(FIELD)) Q:(FIELD="")  D
 .Q:((FIELD="ELIG")!(FIELD="RATEDIS")!(FIELD="MTSTA")!(FIELD="DFN"))  ;MT Status not uploaded
 .I OLDELG(FIELD)'=NEWELG(FIELD) D
 ..;
 ..S LINE=$$LJ^XLFSTR(FIELD_":   ",15)_$$LJ^XLFSTR($$EXT^DGENELA3(FIELD,OLDELG(FIELD)),33)_"   "_$$EXT^DGENELA3(FIELD,NEWELG(FIELD))
 ..I 'HDR D ELGHDR
 ..D ADDCHNG^DGENUPA(.AUDIT,LINE)
 Q
 ;
ELGHDR ;
 ;Description: Header for changes in ELIGIBILITY object
 ;
 D ADDCHNG^DGENUPA(.AUDIT," ")
 D ADDCHNG^DGENUPA(.AUDIT,"                       Patient Eligibility")
 D ADDCHNG^DGENUPA(.AUDIT,"Field          Before                              After")
 D ADDCHNG^DGENUPA(.AUDIT,"=============================================================================")
 S HDR=1
 Q
 ;
ELGCODES ;
 ;Description: Changes in Patient Eligibilities
 ;
 N FIELD,LINE,IEN,HDR
 S HDR=0
 S IEN=0
 F  S IEN=$O(NEWELG("ELIG","CODE",IEN)) Q:'IEN  I '$G(OLDELG("ELIG","CODE",IEN)) D
 .D:'HDR AELGHDR
 .D ADDCHNG^DGENUPA(.AUDIT,"    "_$$EXT^DGENELA3("CODE",IEN))
 ;
 S HDR=0
 S IEN=0
 F  S IEN=$O(OLDELG("ELIG","CODE",IEN)) Q:'IEN  I '$G(NEWELG("ELIG","CODE",IEN)) D
 .;
 .;the new primary eligibility code will be placed in the eligibilities multiple via the x-ref
 .Q:(OLDELG("ELIG","CODE",IEN)=NEWELG("ELIG","CODE"))
 .;
 .D:'HDR DELGHDR
 .D ADDCHNG^DGENUPA(.AUDIT,"    "_$$EXT^DGENELA3("CODE",IEN))
 ;
 Q
 ;
AELGHDR ;
 ;Description: Header for eligibility codes added
 ;
 D ADDCHNG^DGENUPA(.AUDIT," ")
 D ADDCHNG^DGENUPA(.AUDIT,"Patient Eligibilities Added:")
 S HDR=1
 Q
 ;
DELGHDR ;
 ;Description: Header for eligibility codes deleted
 ;
 D ADDCHNG^DGENUPA(.AUDIT," ")
 D ADDCHNG^DGENUPA(.AUDIT,"Patient Eligibilities Deleted:")
 S HDR=1
 Q
 ;
RDISB ;
 ;Description: Changes in Rated Disabilities
 ;
 N COUNT,NEWDIBS,OLDDIBS,IEN,PER,SC,HDR
 ;set up the rated disabilities in a more useful format to detect changes
 S COUNT=0
 F  S COUNT=$O(NEWELG("RATEDIS",COUNT)) Q:'COUNT  S NEWDIBS(+NEWELG("RATEDIS",COUNT,"RD"),+NEWELG("RATEDIS",COUNT,"PER"),$J(NEWELG("RATEDIS",COUNT,"RDSC"),1))=""
 S COUNT=0
 F  S COUNT=$O(OLDELG("RATEDIS",COUNT)) Q:'COUNT  S OLDDIBS(+OLDELG("RATEDIS",COUNT,"RD"),+OLDELG("RATEDIS",COUNT,"PER"),$J(OLDELG("RATEDIS",COUNT,"RDSC"),1))=""
 ;
 ;find disabilty taht have been added
 S HDR=0
 S IEN=0
 F  S IEN=$O(NEWDIBS(IEN)) Q:'IEN  D
 .S PER=""
 .F  S PER=$O(NEWDIBS(IEN,PER)) Q:(PER="")  D
 ..S SC=""
 ..F  S SC=$O(NEWDIBS(IEN,PER,SC)) Q:(SC="")  D
 ...I '$D(OLDDIBS(IEN,PER,SC)) D
 ....D:'HDR ARDISHDR
 ....D ADDCHNG^DGENUPA(.AUDIT,"   "_$$LJ^XLFSTR($$EXT^DGENELA3("RD",IEN),45)_"       Percent: "_PER_"  SC: "_$$EXT^DGENELA3("RDSC",SC))
 ;
 ;find disabilities that have been deleted
 S HDR=0
 S IEN=0
 F  S IEN=$O(OLDDIBS(IEN)) Q:'IEN  D
 .S PER=""
 .F  S PER=$O(OLDDIBS(IEN,PER)) Q:(PER="")  D
 ..S SC=""
 ..F  S SC=$O(OLDDIBS(IEN,PER,SC)) Q:(SC="")  D
 ...I '$D(NEWDIBS(IEN,PER,SC)) D
 ....D:'HDR DRDISHDR
 ....D ADDCHNG^DGENUPA(.AUDIT,"   "_$$LJ^XLFSTR($$EXT^DGENELA3("RD",IEN),45)_"       Percent: "_PER_"  SC: "_$$EXT^DGENELA3("RDSC",SC))
 Q
 ;
DRDISHDR ;
 ;Description: Header for deleted disabilities
 ;
 D ADDCHNG^DGENUPA(.AUDIT," ")
 D ADDCHNG^DGENUPA(.AUDIT,"Rated Disabilities Deleted:")
 S HDR=1
 Q
 ;
ARDISHDR ;
 ;Description: Header for added disabilities
 ;
 D ADDCHNG^DGENUPA(.AUDIT," ")
 D ADDCHNG^DGENUPA(.AUDIT,"Rated Disabilities Added:")
 S HDR=1
 Q
 ;
PAT ;
 ;Description: Changes in PATIENT object
 ;
 N FIELD,LINE,IEN,HDR
 S HDR=0
 S FIELD=""
 F  S FIELD=$O(OLDPAT(FIELD)) Q:(FIELD="")  D
 .Q:((FIELD="DFN"))  ;
 .I OLDPAT(FIELD)'=NEWPAT(FIELD) D
 ..;
 ..I 'HDR D PATHDR
 ..I FIELD="DEATH" S LINE="** ALERT ONLY: Changes to Date of Death are NOT automatically updated **" D ADDCHNG^DGENUPA(.AUDIT,LINE)
 ..S LINE=$$LJ^XLFSTR(FIELD_":   ",15)_$$LJ^XLFSTR($$EXT^DGENPTA(FIELD,OLDPAT(FIELD)),33)_"   "_$$EXT^DGENPTA(FIELD,NEWPAT(FIELD))
 ..D ADDCHNG^DGENUPA(.AUDIT,LINE)
 Q
 ;
PATHDR ;
 ;Descripition: Header for changes in PATIENT object
 ;
 D ADDCHNG^DGENUPA(.AUDIT,"                       Patient Demographics")
 D ADDCHNG^DGENUPA(.AUDIT,"Field          Before                              After")
 D ADDCHNG^DGENUPA(.AUDIT,"=============================================================================")
 S HDR=1
 Q
 ;
CDIS ;
 ;Description: Changes in CATASTROPHIC DISABILTY object
 ;
 N SUBFIELD,FIELD,LINE,IEN,HDR
 S HDR=0
 S FIELD=""
 F  S FIELD=$O(OLDCDIS(FIELD)) Q:(FIELD="")  D
 .I $D(OLDCDIS(FIELD))'=1 Q
 .I OLDCDIS(FIELD)'=NEWCDIS(FIELD) D
 ..S LINE=$$LJ^XLFSTR(FIELD_":   ",15)_$$LJ^XLFSTR($$EXT^DGENCDU(FIELD,OLDCDIS(FIELD)),33)_"   "_$$EXT^DGENCDU(FIELD,NEWCDIS(FIELD))
 ..I 'HDR D CDISHDR
 ..D ADDCHNG^DGENUPA(.AUDIT,LINE)
 F FIELD="SCORE","PROC","PERM","EXT","DIAG","COND"  D
 .F SUBFIELD=1:1 Q:('$D(OLDCDIS(FIELD,SUBFIELD)))&('$D(NEWCDIS(FIELD,SUBFIELD)))  D
 ..I $G(OLDCDIS(FIELD,SUBFIELD))'=$G(NEWCDIS(FIELD,SUBFIELD)) D
 ...S LINE=$$LJ^XLFSTR(FIELD_":   ",15)
 ...S LINE=LINE_$$LJ^XLFSTR($S($G(OLDCDIS(FIELD,SUBFIELD))'="":$$EXT^DGENCDU(FIELD,OLDCDIS(FIELD,SUBFIELD)),1:""),33)
 ...S LINE=LINE_"   "_$S($G(NEWCDIS(FIELD,SUBFIELD))'="":$$EXT^DGENCDU(FIELD,NEWCDIS(FIELD,SUBFIELD)),1:"")
 ...I 'HDR D CDISHDR
 ...D ADDCHNG^DGENUPA(.AUDIT,LINE)
 Q
 ;
CDISHDR ;
 ;Descripition: Header for changes in CATASTROPHIC DISABILTY object
 ;
 D ADDCHNG^DGENUPA(.AUDIT," ")
 D ADDCHNG^DGENUPA(.AUDIT,"                       Catastrophic Disability")
 D ADDCHNG^DGENUPA(.AUDIT,"Field          Before                              After")
 D ADDCHNG^DGENUPA(.AUDIT,"=============================================================================")
 S HDR=1
 Q
 ;
SEC ;
 ; Description: Changes in PATIENT SECURITY object
 ;
 N FIELD,LINE,IEN,HDR
 S HDR=0
 S FIELD=""
 F  S FIELD=$O(OLDSEC(FIELD)) Q:(FIELD="")  D
 .;
 .Q:((FIELD="DFN"))  ; do not need to audit this field
 .I OLDSEC(FIELD)'=NEWSEC(FIELD) D
 ..;
 ..S LINE=$$LJ^XLFSTR(FIELD_":   ",15)_$$LJ^XLFSTR($$EXT^DGENSEC(FIELD,OLDSEC(FIELD)),33)_"   "_$$EXT^DGENSEC(FIELD,NEWSEC(FIELD))
 ..I 'HDR D SECHDR
 ..D ADDCHNG^DGENUPA(.AUDIT,LINE)
 ;
 Q
 ;
SECHDR ;
 ; Description: Header for changes in PATIENT SECURITY object
 ;
 D ADDCHNG^DGENUPA(.AUDIT," ")
 D ADDCHNG^DGENUPA(.AUDIT,"                       Patient Security")
 D ADDCHNG^DGENUPA(.AUDIT,"Field          Before                              After")
 D ADDCHNG^DGENUPA(.AUDIT,"=============================================================================")
 S HDR=1
 Q

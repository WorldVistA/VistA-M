GMRCXR ; ALB/SAT - GMR DD UTILITY ;AUG 25, 2016
 ;;3.0;CONSULT/REQUEST TRACKING;**83,86**;Dec 27, 1997;Build 18
 ;DD support for VISTA SCHEDULING ENHANCEMENT SD*5.3*627
 ;Reference is made to ICR #6184
 ;
 Q
AG123S1(GMRCDA1,GMRCDR) ;build AG xref ;called by 'Set Logic' and 'Kill Logic' of the New Style AG cross reference #336 in file 123
 ;GMRCDA1  = DA(1) IEN pointer to REQUEST/CONSULTATION file 123
 ;GMRCDR        = DATE OF REQUEST in FM format from field 3 of top level of file 123
 N CHK
 S GMRCDA1=$G(GMRCDA1) Q:'+GMRCDA1
 S GMRCDR=$G(GMRCDR,0) S:'GMRCDR GMRCDR=$P($G(^GMR(123,GMRCDA1,0)),U,7)   ;alb/sat 86 setup GMRCDR if not passed in
 Q:GMRCDR=""   ;alb/sat 86 do not include if DATE OF REQUEST is not defined
 S CHK=$$REQCHK(GMRCDA1)
 S:(CHK=0)&(GMRCDR'="") ^GMR(123,"AG",GMRCDR,GMRCDA1)=""
 K:(+CHK)&(GMRCDR'="") ^GMR(123,"AG",GMRCDR,GMRCDA1)
 Q
 ;
REQCHK(GMRCID) ;check activities to determine if the REQUEST/CONSULTATION entry is still active and not scheduled
 N GMRCCAN,GMRCCANF,GMRCDC,GMRCDONE,GMRCES,GMRCESF,GMRCNOD,GMRCPDC,GMRC40,GMRCACT,GMRCRPA,GMRCSCH,GMRCSCHF,GMRCSER,GMRCST,GMRCSTF
 N GMRCCS,GMRCFD,GMRCPA
 N GMRCNOS,X,X1,X2   ;alb/sat 86
 S GMRCPA=$O(^ORD(100.01,"B","ACTIVE",0))
 S GMRCPDC=$O(^ORD(100.01,"B","DISCONTINUED",0))
 S GMRCCS=$$GET1^DIQ(123,GMRCID_",",8,"I")
 Q:GMRCCS=GMRCPDC 1   ;don't return this entry if CPRS STATUS is DISCONTINUED
 ;Q:$$GET1^DIQ(123,GMRCID_",",8,"I")=GMRCPDC 1   ;don't include this entry if CPRS STATUS is DISCONTINUED  ;alb/sat 86 removed redundant check
 S GMRCFD=$P($$GET1^DIQ(123,GMRCID_",",.01,"I"),".",1)   ;alb/sat 86 - get FILE ENTRY DATE
 Q:$$FMADD^XLFDT(DT,-365)>GMRCFD 1  ;alb/sat 86 - do not include records with FILE ENTRY DATE older than 1 year
 S GMRCSCH=$$GETIEN("SCHEDULED")
 S GMRCST=$$GETIEN("STATUS CHANGE")
 S GMRCCAN=$$GETIEN("CANCELLED")
 S GMRCDONE=$$GETIEN("COMPLETE/UPDATE")
 S GMRCDC=$$GETIEN("DISCONTINUED")
 S GMRCES=$$GETIEN("EDIT/RESUBMITTED")
 S GMRCNOD=$G(^GMR(123,GMRCID,0))
 S GMRCSER=$P(GMRCNOD,U,5)
 S DFN=$P(GMRCNOD,U,2)
 S (GMRCCANF,GMRCESF,GMRCSCHF,GMRCSTF)=0
 ;alb/sat 86 - start modification
 I GMRCCS=13 D  G REQCHKX     ;cancel/no-show  ;13 is cancel - see A+7^SDCNSLT SD*5.3*627
 .S GMRCCANF=1
 .S GMRCNOS=$O(^GMR(123,GMRCID,40,":"),-1) Q:'+GMRCNOS       ;ICR 6185
 .S GMRCNOS=$O(^GMR(123,GMRCID,40,GMRCNOS),-1) Q:'+GMRCNOS
 .S X2=$P($G(^GMR(123,GMRCID,40,GMRCNOS,0)),U),X1=DT D ^%DTC Q:X'=""&(X>180)   ;ICR 6185
 .I $$FINDTXT(GMRCID,GMRCNOS) D
 ..S GMRCCANF=0
 ;alb/sat 86 - end modification
 ;GMRCESF - if 1 we have determined this request should be returned (return 0)
 S GMRCRPA=9999999 F  S GMRCRPA=$O(^GMR(123,GMRCID,40,GMRCRPA),-1) Q:GMRCRPA'>0  D  Q:GMRCCANF=1  Q:GMRCSCHF=1  Q:GMRCESF=1
 .S GMRC40=$G(^GMR(123,GMRCID,40,GMRCRPA,0))
 .S GMRCACT=$P(GMRC40,U,2)   ;ACTIVITY field 1
 .I GMRCACT'=GMRCSCH,GMRCACT'=GMRCST,GMRCACT'=GMRCCAN,GMRCACT'=GMRCDONE,GMRCACT'=GMRCDC,GMRCACT'=GMRCES Q  ;only watch the ones we need
 .I GMRCACT=GMRCCAN!(GMRCACT=GMRCDONE)!(GMRCACT=GMRCDC) S GMRCCANF=1 Q    ;skip completed consults/mgh
 .I GMRCACT=GMRCES S GMRCESF=1 Q
 .I GMRCACT=GMRCSCH,GMRCSTF=1 S GMRCESF=1 Q
 .I GMRCACT=GMRCSCH,GMRCSTF'=1,$$SCHED(DFN,$P(GMRC40,U,3),GMRCSER) S GMRCSCHF=1 Q
 .;I GMRCACT=GMRCST,$$FINDTXT(GMRCID,GMRCRPA) S GMRCSTF=1
 .I GMRCACT=GMRCST,GMRCCS=GMRCPA S GMRCSTF=1
REQCHKX ; exit  ;alb/sat 86 - add REQCHKX tag
 Q:GMRCSCHF GMRCSCHF
 Q:GMRCCANF GMRCCANF
 Q:GMRCESF 0
 Q 0
 ;
GETIEN(GMRCNM) ;get ID from REQUEST ACTION TYPES file 123.1
 N Y
 S Y=$O(^GMR(123.1,"B",GMRCNM,0))
 Q Y
 ;
SCHED(DFN,GMRCDT,GMRCSVC) ;look for appointment with stop code matching one in REQUEST SERVICES
 ;INPUT:
 ; DFN     - patient ID pointer to PATIENT file
 ; GMRCDT - actual activity date in FM format
 ; GMRCSVC  - request services ID pointer to REQUEST SERVICES file 123.5
 ;RETURN:
 ; 0 = no appointment found with matching stop code
 ; 1 = appointment found with matching stop code
 ;Q 1   ;do not check for match for now
 N GMRCAPI,GMRCARR,GMRCI,GMRCJ,GMRCRET,GMRCSTP,GMRCSTPL
 S GMRCRET=0
 S GMRCSVC=$G(GMRCSVC)
 Q:GMRCSVC="" 0
 S GMRCDT=$P($G(GMRCDT),".",1)
 I GMRCDT'?7N S GMRCDT=1000103
 S GMRCI=0 F  S GMRCI=$O(^GMR(123.5,GMRCSVC,688,GMRCI)) Q:GMRCI'>0  D
 .S GMRCSTPL(+$P($G(^GMR(123.5,GMRCSVC,688,GMRCI,0)),U,1))=""
 K ^TMP($J,"SDAMA301"),GMRCARR
 S GMRCARR(1)=$P($$FMADD^XLFDT(GMRCDT,-1),".",1)_";"   ;go back 1 day and look forward for appt with matching stop code
 S GMRCARR(4)=DFN
 S GMRCARR("FLDS")="2;13"
 S GMRCAPI=$$SDAPI^SDAMA301(.GMRCARR)
 ;GMRCI - pointer to file 44; GMRCJ - appt date/time
 S GMRCI=0 F  S GMRCI=$O(^TMP($J,"SDAMA301",DFN,GMRCI)) Q:GMRCI'>0  D  Q:+GMRCRET
 .S GMRCJ=0 F  S GMRCJ=$O(^TMP($J,"SDAMA301",DFN,GMRCI,GMRCJ)) Q:GMRCJ'>0  D  Q:+GMRCRET
 ..S GMRCSTP=+$P($G(^TMP($J,"SDAMA301",DFN,GMRCI,GMRCJ)),U,13)
 ..I $P($G(^TMP($J,"SDAMA301",DFN,GMRCI,GMRCJ)),U,25)="",$D(GMRCSTPL(+GMRCSTP)) S GMRCRET=1   ;alb/sat 86
 ..;S:$D(GMRCSTPL(+GMRCSTP)) GMRCRET=1
 K ^TMP($J,"SDAMA301"),GMRCARR
 Q GMRCRET
 ;
FINDTXT(GMRCID,GMRCRPA,GMRCTXT) ;find text in word processing field   ;alb/sat 86 - removed unused 3rd parameter
 ;INPUT:
 ; GMRCID - Pointer to REQUEST/CONSULTATION file
 ; GMRCRPA - Pointer to REQUEST PROCESSING ACTIVITY in REQUEST/CONSULTATION file
 ;RETURN:
 ; 1=Text Fount; 0=Not Found
 ;alb/sat 86 begin modification
 N GMRCI,GMRCJ,GMRCLINE,GMRCMSG,GMRCPREV,GMRCRET,GMRCTHIS,GMRCWP,X
 S (GMRCTHIS,GMRCPREV)=""
 S GMRCRET=0
 S GMRCTXT=$G(GMRCTXT) S:GMRCTXT'="" GMRCTXT=$$UP^XLFSTR(GMRCTXT)  ;alb/sat 86
 K GMRCWP S X=$$GET1^DIQ(123.02,GMRCRPA_","_GMRCID_",",5,"","GMRCWP","GMRCMSG")   ;ICR 6185
 S GMRCI=0 F  S GMRCI=$O(GMRCWP(GMRCI)) Q:GMRCI=""  D  Q:GMRCRET=1
 .S GMRCTHIS=GMRCWP(GMRCI)
 .S GMRCLINE=$$UP^XLFSTR(GMRCPREV_GMRCTHIS)
 .I GMRCTXT'="" S:GMRCLINE[GMRCTXT GMRCRET=1 Q
 .F GMRCJ=1:1 S GMRCTXT=$P($T(GMRCTXT+GMRCJ),";;",2) Q:GMRCTXT=""  D  Q:GMRCRET=1
 ..S:GMRCLINE[GMRCTXT GMRCRET=1
 .;alb/sat 86 end modification
 .S GMRCPREV=GMRCTHIS  ;keep 'this' line for next iteration in case the phrase wraps around onto 2 lines
 Q GMRCRET
 ;
 ;alb/sat 86
GMRCTXT  ;
 ;;CANCEL
 ;;NOSHOW
 ;;NO-SHOW
 ;;NO SHOW
 ;
 ;
POST ;post install for GMRC*3*86
 D XREF
 Q
XREF  ;create and build NEW style AG for all REQUEST/CONSULTATION entries in file 123
 N GMRCXR,GMRCRES,GMRCOUT
 S GMRCXR("FILE")=123
 S GMRCXR("NAME")="AG"
 S GMRCXR("SHORT DESCR")="Index of active REQUEST/CONSULTs with no appointment scheduled."
 S GMRCXR("TYPE")="M"
 S GMRCXR("EXECUTION")="F"
 S GMRCXR("ACTIVITY")="IR"
 S GMRCXR("ROOT TYPE")="W"
 S GMRCXR("ROOT FILE")=123.02
 S GMRCXR("USE")="S"
 S GMRCXR("DESCR",1)="This cross reference contains entries of the REQUEST/CONSULTATION file"
 S GMRCXR("DESCR",2)="that do not have an appointment scheduled."
 S GMRCXR("DESCR",3)="This is determined based on the content and order of the entries in"
 S GMRCXR("DESCR",4)="the REQUEST PROCESSING ACTIVITY multiple field 40.  This cross"
 S GMRCXR("DESCR",5)="reference will be updated with any update to the ACTIVITY field under"
 S GMRCXR("DESCR",6)="the REQUEST PROCESSING ACTIVITY multiple and that update will be"
 S GMRCXR("DESCR",7)="determined based on all REQUEST PROCESSING ACTIVITY entries."
 S GMRCXR("DESCR",8)="This cross reference was added in GMRC*3.0*83."
 S GMRCXR("SET")="D AG123S1^GMRCXR(DA(1),X)"
 S GMRCXR("KILL")="D AG123S1^GMRCXR(DA(1),X)"
 S GMRCXR("WHOLE KILL")="K ^GMR(123,""AG"")"
 S GMRCXR("VAL",1)="S X=+$P($G(^GMR(123,DA(1),0)),U,7)"
 S GMRCXR("VAL",1,"TYP")="C"
 S GMRCXR("VAL",1,"SUBSCRIPT")=1
 S GMRCXR("VAL",1,"COLLATION")="F"
 D CREIXN^DDMOD(.GMRCXR,"S",.GMRCRES,"GMRCOUT")
 Q

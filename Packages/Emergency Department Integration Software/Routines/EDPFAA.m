EDPFAA ;SLC/KCM - RPC Calls to Facility ;5/2/12 3:36pm
 ;;2.0;EMERGENCY DEPARTMENT;**6,2**;Feb 24, 2012;Build 23
 ;
BOOT(APP) ; bootstrap appliction
 D USER
 D APP(APP)
 Q
USER ; set bootstrap USER node
 N X,TSIEN,ROLEIEN,ROLE,ROLENM,DFLTBRD,DFLTWSHT
 S X("duz")=DUZ
 S X("userNm")=$P($G(^VA(200,DUZ,0)),U)
 S X("timeOut")=$$GET^XPAR("USR^DIV^SYS","ORWOR TIMEOUT CHART",1,"I")
 S:'X("timeOut") X("timeOut")=$$DTIME^XUP(DUZ)
 S:'X("timeOut") X("timeOut")=300
 S X("timeOut")=X("timeOut")*1000        ; milliseconds
 S X("countDown")=$$GET^XPAR("USR^SYS^PKG","ORWOR TIMEOUT COUNTDOWN",1,"I")
 S:'X("countDown") X("countDown")=10
 S X("countDown")=X("countDown")*1000    ; milliseconds
 S TSIEN=$O(^EDPB(231.7,"B",DUZ,""))
 I TSIEN S ROLEIEN=$O(^EDPB(231.7,"AC",EDPSITE,AREA,TSIEN,""))
 I $G(ROLEIEN) D
 .S X("roleID")=ROLEIEN
 .S ROLENM=$$GET1^DIQ(232.5,ROLEIEN,.01,"E"),X("roleName")=ROLENM
 .S ROLE=$$GET1^DIQ(232.5,ROLEIEN,.02,"E"),X("roleAbbr")=ROLE
 .S DFLTWSHT=$$GET1^DIQ(232.5,ROLEIEN,.04,"E"),X("defaultWorksheet")=DFLTWSHT
 .S DFLTBRD=$$GET1^DIQ(232.5,ROLEIEN,.05,"I"),X("defaultBoard")=DFLTBRD
 .; Gather all available worksheets for this role
 .D LDWSLIST^EDPBWS(EDPSITE,AREA,ROLEIEN)
 D XML^EDPX($$XMLA^EDPX("user",.X,""))
 I $D(^XUSEC("XUPROGMODE",DUZ))>0 D XML^EDPX("<auth name=""debug"" />")
 D XML^EDPX("</user>")
 Q
APP(APP) ; set bootstrap APP node
 N X,AREA
 S X("name")=APP
 S X("site")=DUZ(2)
 S X("siteNm")=$$NAME^XUAF4(X("site"))
 S X("station")=$$STA^XUAF4(DUZ(2))
 S X("time")=$$NOW^XLFDT
 S X("version")=$$VERSRV^EDPQAR
 S X("vistaSession")=$$SESSID
 D XML^EDPX($$XMLA^EDPX("app",.X,""))
 D AREA
 I APP="cpe-ui-reports" D RPTS
 I APP="cpe-ui-care" D ROLES
 D XML^EDPX("</app>")
 Q
AREA ; set default area node
 N X
 S X("area")=$$DFLTAREA^EDPQAR(""),AREA=X("area")
 I X("area") S X("areaNm")=$P(^EDPB(231.9,X("area"),0),U)
 D XML^EDPX($$XMLA^EDPX("defaultArea",.X))
 Q
RPTS ; set auth nodes for reports
 I $D(^XUSEC("EDPR EXPORT",DUZ))>0 D XML^EDPX("<auth name=""rptExport"" />")
 I $D(^XUSEC("EDPR PROVIDER",DUZ))>0 D XML^EDPX("<auth name=""rptProvider"" />")
 I $D(^XUSEC("EDPR XREF",DUZ))>0 D XML^EDPX("<auth name=""rptXRef"" />")
 I $D(^XUSEC("EDPR ADHOC",DUZ))>0 D XML^EDPX("<auth name=""rptAdhoc"" />")
 Q
ROLES ; set up roles
 N ROLE S ROLE=0         ; TEMPORARY!!
 I DUZ=20011 S ROLE=573
 I DUZ=20014 S ROLE=272
 I DUZ=20013 S ROLE=426
 I DUZ=20028 S ROLE=623
 I 'ROLE S ROLE=459
 S X("id")=ROLE
 S X("displayName")=$$CLNAME^USRLM(ROLE)
 D XML^EDPX($$XMLA^EDPX("role",.X))
 S IEN=$O(^EDPB(232.5,"C",EDPSITE,AREA,ROLE,0)) Q:'IEN
 S BRD=$P(^EDPB(232.5,IEN,0),U,5)
 D XML^EDPX("<board defaultName='"_BRD_"' />")
 Q
 ; TODO: provide a mechanism to rebuild role list if AREA changes
 N X,ROLE,IEN,BRD,DONE,ERR
 S ROLE=0,DONE=0
 F  S ROLE=$O(^EDPB(232.5,"C",EDPSITE,AREA,ROLE)) Q:'ROLE  D  Q:DONE
 . Q:'$$ISA^USRLM(DUZ,ROLE,.ERR,DT)
 . S DONE=1
 . S X("id")=ROLE
 . S X("displayName")=$$CLNAME^USRLM(ROLE)
 . D XML^EDPX($$XMLA^EDPX("role",.X))
 . S IEN=$O(^EDPB(232.5,"C",EDPSITE,AREA,ROLE,0)) Q:'IEN
 . S BRD=$P(^EDPB(232.5,IEN,0),U,5)
 . D XML^EDPX("<board defaultName='"_BRD_"' />")
 Q
SESS ; set up session -- (OLD from version 1?)
 N X,TSIEN,ROLEIEN,ROLENM,ROLE,DFLTWSHT,DFLTBRD,DFLTROOM
 S X("duz")=DUZ
 S X("userNm")=$P($G(^VA(200,DUZ,0)),U)
 S X("site")=DUZ(2)
 S X("siteNm")=$$NAME^XUAF4(X("site"))
 S X("station")=$$STA^XUAF4(DUZ(2))
 S X("time")=$$NOW^XLFDT
 S X("worksheets")=($D(^XUSEC("EDPF WORKSHEETS",DUZ))>0)
 S X("rptExport")=($D(^XUSEC("EDPR EXPORT",DUZ))>0)
 S X("rptProvider")=($D(^XUSEC("EDPR PROVIDER",DUZ))>0)
 S X("rptXRef")=($D(^XUSEC("EDPR XREF",DUZ))>0)
 S X("rptAdhoc")=($D(^XUSEC("EDPR ADHOC",DUZ))>0)
 S X("progMode")=($D(^XUSEC("XUPROGMODE",DUZ))>0)
 S X("version")=$$VERSRV^EDPQAR
 ;
 ;DRP Begin EDP*2.0*2 changes
 ; added line below
 S X("icd10ActDate")=$$IMPDATE^EDPLEX("10D")
 ;End EDP*2.0*2 changes
 ;
 ; PATCH 6 - BWF - Adding 'defaultRoom' = true/false to identify wheteher or not a default room has been set.
 S DFLTROOM=$$GET1^DIQ(231.9,AREA,1.12,"I")
 S X("defaultRoom")=$S(DFLTROOM:"true",1:"false")
 ;
 ; This code to enable VEHU training.
 ;N AREA
 ;S AREA=$$GET^XPAR(DUZ_";VA(200,","EDPF USER AREA",1,"Q")
 ;I AREA S X("area")=AREA,X("areaNm")=$P($G(^EDPB(231.9,AREA,0)),U)
 ;
 ;TDP - Patch 2 change to use new EDIS timeout parameter
 ;S X("timeOut")=$$GET^XPAR("USR^DIV^SYS","ORWOR TIMEOUT CHART",1,"I")
 S X("timeOut")=$$GET^XPAR("USR^DIV^SYS","EDP APP TIMEOUT",1,"I")
 S:'X("timeOut") X("timeOut")=$$DTIME^XUP(DUZ)
 S:'X("timeOut") X("timeOut")=300
 S X("timeOut")=X("timeOut")*1000        ; milliseconds
 ;
 ;TDP - Patch 2 change to use new EDIS timeout countdown parameter
 ;S X("countDown")=$$GET^XPAR("USR^SYS^PKG","ORWOR TIMEOUT COUNTDOWN",1,"I")
 S X("countDown")=$$GET^XPAR("USR^SYS^PKG","EDP APP COUNTDOWN",1,"I")
 S:'X("countDown") X("countDown")=10
 S X("countDown")=X("countDown")*1000    ; milliseconds
 S TSIEN=$O(^EDPB(231.7,"B",DUZ,""))
 I TSIEN S ROLEIEN=$$GET1^DIQ(231.7,TSIEN,.06,"I")
 I $G(ROLEIEN) D
 .S X("roleID")=ROLEIEN
 .S ROLENM=$$GET1^DIQ(232.5,ROLEIEN,.01,"E"),X("roleName")=ROLENM
 .S ROLE=$$GET1^DIQ(232.5,ROLEIEN,.02,"E"),X("roleAbbr")=ROLE
 .S DFLTWSHT=$$GET1^DIQ(232.5,ROLEIEN,.04,"E"),X("defaultWorksheet")=DFLTWSHT
 .S DFLTBRD=$$GET1^DIQ(232.5,ROLEIEN,.05,"I"),X("defaultBoard")=DFLTBRD
 D XML^EDPX($$XMLA^EDPX("user",.X))
 Q
SESSID() ; Return the next session identifier
 ; May lock any string, does not have to be actual global node
 ; Use ^XTMP("EDP... to assure uniqueness to this package
 ;
 L +^XTMP("EDP-LOCK-SESSION-ID"):10  E  Q 0
 N X S X=$$GET^XPAR("PKG","EDPW SESSION ID",1,"I")+1
 I X>4294967295 S X=1  ; wrap around if bigger than 32-bit uint
 D EN^XPAR("PKG","EDPW SESSION ID",1,X)
 L -^XTMP("EDP-LOCK-SESSION-ID")
 Q X
 ;
VIEWS ; Return views allowed for this user
 N I,X,ID
 F I=1:1 S X=$P($T(OPTIONS+I),";",3,99) Q:X="zzzzz"  D
 . I $$ACCESS^XQCHK(DUZ,$$LKOPT^XPDMENU($P(X,U)))>0 D
 . . D XML^EDPX($$XMLS^EDPX("view",$P(X,U,3),$P(X,U,2)))
 Q
OPTIONS ;; options visible in Tracking System
 ;;EDPF TRACKING VIEW SIGNIN^Sign In^1
 ;;EDPF TRACKING VIEW TRIAGE^Triage^2
 ;;EDPF TRACKING VIEW UPDATE^Update^3
 ;;EDPF TRACKING VIEW DISPOSITION^Disposition^4
 ;;EDPF TRACKING VIEW EDIT CLOSED^Edit Closed^5
 ;;EDPF TRACKING VIEW BOARD^Display Board^6
 ;;EDPF TRACKING VIEW STAFF^Assign Staff^7
 ;;EDPF TRACKING VIEW REPORTS^Reports^8
 ;;EDPF TRACKING VIEW CONFIGURE^Configure^9
 ;;zzzzz

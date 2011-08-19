EDPFAA ;SLC/KCM - RPC Calls to Facility
 ;;1.0;EMERGENCY DEPARTMENT;;Sep 30, 2009;Build 74
 ;
SESS ; set up session
 N X
 S X("duz")=DUZ
 S X("userNm")=$P($G(^VA(200,DUZ,0)),U)
 S X("site")=DUZ(2)
 S X("siteNm")=$$NAME^XUAF4(X("site"))
 S X("station")=$$STA^XUAF4(DUZ(2))
 S X("time")=$$NOW^XLFDT
 S X("rptExport")=($D(^XUSEC("EDPR EXPORT",DUZ))>0)
 S X("rptProvider")=($D(^XUSEC("EDPR PROVIDER",DUZ))>0)
 S X("rptXRef")=($D(^XUSEC("EDPR XREF",DUZ))>0)
 S X("progMode")=($D(^XUSEC("XUPROGMODE",DUZ))>0)
 S X("version")=$$VERSRV^EDPQAR
 ;
 ; This code to enable VEHU training.
 ;N AREA
 ;S AREA=$$GET^XPAR(DUZ_";VA(200,","EDPF USER AREA",1,"Q")
 ;I AREA S X("area")=AREA,X("areaNm")=$P($G(^EDPB(231.9,AREA,0)),U)
 ;
 S X("timeOut")=$$GET^XPAR("USR^DIV^SYS","ORWOR TIMEOUT CHART",1,"I")
 S:'X("timeOut") X("timeOut")=$$DTIME^XUP(DUZ)
 S:'X("timeOut") X("timeOut")=300
 S X("timeOut")=X("timeOut")*1000        ; milliseconds
 S X("countDown")=$$GET^XPAR("USR^SYS^PKG","ORWOR TIMEOUT COUNTDOWN",1,"I")
 S:'X("countDown") X("countDown")=10
 S X("countDown")=X("countDown")*1000    ; milliseconds
 D XML^EDPX($$XMLA^EDPX("user",.X))
 Q
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

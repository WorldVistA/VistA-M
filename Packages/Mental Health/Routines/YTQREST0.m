YTQREST0 ;SLC/KCM - RESTful API front controller v0 ; 1/25/2017
 ;;5.01;MENTAL HEALTH;**130**;Dec 30, 1994;Build 62
 ;
 ; .HTTPREQ: HTTP-formatted request and JSON body (if present)
 ; .HTTPRSP: HTTP-formatted response and JSON body (if present)
 ;
QSTAFF(HTTPRSP,HTTPREQ) ; questionnaire administration resources
 ;;POST /api/mha/assignment NEWASMT^YTQRQAD1
 ;;
 D HANDLE^YTQRUTL("QSTAFF^YTQREST0",.HTTPREQ,.HTTPRSP)
 Q
 ;
 ; -- for use when using embedded browser
 ;
 ;;GET /api/mha/patient/:dfn/identifiers PID^YTQRQAD
 ;;GET /api/mha/persons/:match PERSONS^YTQRQAD
 ;;GET /api/mha/users/:match USERS^YTQRQAD
 ;;GET /api/mha/instruments/active LSTALL^YTQRQAD
 ;;GET /api/mha/instruments/cprs LSTCPRS^YTQRQAD
 ;;GET /api/mha/instrument/:instrumentName GETSPEC^YTQRQAD
 ;;GET /api/mha/assignment/:assignmentId?1.N ASMTBYID^YTQRQAD1
 ;;GET /api/mha/assignment/:assignmentId?1.N/:division ASMTBYID^YTQRQAD1
 ;;DELETE /api/mha/assignment/:assignmentId DELASMT^YTQRQAD1
 ;;DELETE /api/mha/assignment/:assignmentId/:instrument DELTEST^YTQRQAD1
 ;;POST /api/mha/instrument/admin SAVEADM^YTQRQAD2
 ;;GET /api/mha/instrument/admin/:adminId?1.N GETADM^YTQRQAD2
 ;;GET /api/mha/instrument/report/:adminId?1.N REPORT^YTQRQAD3
 ;;GET /api/mha/instrument/note/:adminId?1.N GETNOTE^YTQRQAD3
 ;;POST /api/mha/instrument/note SETNOTE^YTQRQAD3
 ;;GET /api/mha/permission/cosign/:adminId/:userId ALWCSGN^YTQRQAD3
 ;;GET /api/mha/division/current/ TMPDIV^YTQRQAD
 ;;POST /api/wrapper/close WRCLOSE^YTQRQAD
 ;;
QENTRY(HTTPRSP,HTTPREQ) ; questionnaire entry for patient
 ;;GET /api/mha/patient/:dfn/identifiers PID^YTQRQAD
 ;;GET /api/mha/instrument/:instrumentName GETSPEC^YTQRQAD
 ;;GET /api/mha/assignment/:assignmentId?1.N ASMTBYID^YTQRQAD1
 ;;GET /api/mha/checks/:instrumentName GETCHKS^YTQRQAD2
 ;;GET /api/mha/instrument/admin/:adminId?1.N GETADM^YTQRQAD2
 ;;POST /api/mha/instrument/admin SAVEADM^YTQRQAD2
 ;;
 D HANDLE^YTQRUTL("QENTRY^YTQREST0",.HTTPREQ,.HTTPRSP)
 Q

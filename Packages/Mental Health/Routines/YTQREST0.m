YTQREST0 ;SLC/KCM - RESTful API front controller v0 ; 1/25/2017
 ;;5.01;MENTAL HEALTH;**130,178,182,187,223,239,224,236**;Dec 30, 1994;Build 25
 ;
 ; .HTTPREQ: HTTP-formatted request and JSON body (if present)
 ; .HTTPRSP: HTTP-formatted response and JSON body (if present)
 ;
QSTAFF(HTTPRSP,HTTPREQ) ; questionnaire administration resources
 ;;POST /api/mha/assignment NEWASMT^YTQRQAD1
 ;;
 D WINFIX(.HTTPREQ) ; Fix the malformed JSON from Windows MHA
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
 ;;GET /api/mha/getconn/ GETCONN^YTQREST
 ;;GET /api/mha/patient/:dfn/identifiers PID^YTQRQAD
 ;;GET /api/mha/instrument/:instrumentName GETSPEC^YTQRQAD
 ;;GET /api/mha/assignment/:assignmentId?1.N ASMTBYID^YTQRQAD1
 ;;GET /api/mha/assignment/:assignmentId?36ANP ASMTBYID^YTQRQAD1
 ;;GET /api/mha/checks/:instrumentName GETCHKS^YTQRQAD2
 ;;GET /api/mha/instrument/admin/:adminId?1.N GETADM^YTQRQAD2
 ;;GET /api/mha/instrument/admin/:adminId?36ANP1"-".N GETADM^YTQRQAD2
 ;;POST /api/mha/instrument/admin SAVEADM^YTQRQAD2
 ;;GET /api/mha/assignment/cat/:assignmentId?1.N GCATINFO^YTQRCAT
 ;;GET /api/mha/assignment/cat/:assignmentId?36ANP GCATINFO^YTQRCAT
 ;;POST /api/mha/assignment/cat/:assignmentId?1.N PCATINFO^YTQRCAT
 ;;POST /api/mha/assignment/cat/:assignmentId?36ANP PCATINFO^YTQRCAT
 ;;GET /api/mha/cat/interview/:interviewId GETCATI^YTQRCAT
 ;;POST /api/mha/cat/interview/:interviewId SETCATI^YTQRCAT
 ;;DELETE /api/mha/assignment/:assignmentId/:instrument/:delfrmassign DELTEST^YTQRQAD1
 ;;GET /api/mha/cdb/timezone/ TZ^YTQRCDB2
 ;;POST /api/mha/cdb/instrument/admin SAVEADM^YTQRCDB
 ;;POST /api/mha/cdb/instrument/admin/scores SCORADM^YTQRCDB
 ;;POST /api/mha/cdb/instrument/note PENOTE^YTQRCDB3
 ;;
 D HANDLE^YTQRUTL("QENTRY^YTQREST0",.HTTPREQ,.HTTPRSP)
 Q
WINFIX(HTTPREQ) ; Fix the malformed JSON from Windows MHA
 N I,BODY,SWAP
 S BODY=0
 S SWAP(""":,")=""":null,"
 S SWAP(""":}")=""":null}"
 S I=0 F  S I=$O(HTTPREQ(I)) Q:'I  D
 . I BODY S HTTPREQ(I)=$$REPLACE^XLFSTR(HTTPREQ(I),.SWAP)
 . I '$L(HTTPREQ(I)) S BODY=1
 Q

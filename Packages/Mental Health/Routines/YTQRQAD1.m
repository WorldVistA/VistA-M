YTQRQAD1 ;SLC/KCM - RESTful Calls to handle MHA assignments ; 1/25/2017
 ;;5.01;MENTAL HEALTH;**130**;Dec 30, 1994;Build 62
 ;
 ; External Reference    ICR#
 ; ------------------   -----
 ; VADPT                10061
 ; XLFDT                10103
 ; XLFSTR               10104
 ;
ASMTBYID(ARGS,RESULTS) ; get assignment identified by assignmentId
 N ASMT,ADMIN,TEST,I
 S ASMT="YTQASMT-SET-"_$G(ARGS("assignmentId"))
 I '$D(^XTMP(ASMT)) D SETERROR^YTQRUTL(404,"Not Found: "_ARGS("assignmentId")) QUIT
 S I=0 F  S I=$O(^XTMP(ASMT,1,"instruments",I)) Q:'I  D  ; calc progress
 . S ADMIN=+$G(^XTMP(ASMT,1,"instruments",I,"adminId"))
 . S TEST=+$G(^XTMP(ASMT,1,"instruments",I,"id"))
 . S ^XTMP(ASMT,1,"instruments",I,"progress")=$$PROGRESS(ADMIN,TEST)
 M RESULTS=^XTMP(ASMT,1)                                 ; load assignment
 Q
ASMTBYNM(ARGS,RESULTS) ; get assignment identified by lastName and last4
 N ASMT,PID,PTNAME,LAST
 S PID=ARGS("last4")
 S PTNAME=$$UP^XLFSTR(ARGS("lastName"))
 I 'PID!'$L(PTNAME) D SETERROR^YTQRUTL(400,"Missing Identifiers") QUIT
 S LAST=$O(^XTMP("YTQASMT-INDEX","AC",PID,PTNAME,0))
 S ASMT=$G(^XTMP("YTQASMT-INDEX","AC",PID,PTNAME,LAST))
 I 'ASMT D SETERROR^YTQRUTL(404,"Not Found: Assignment for Patient") QUIT
 S ARGS("assignmentId")=ASMT
 D ASMTBYID(.ARGS,.RESULTS)
 Q
PROGRESS(ADMIN,TEST) ; return the progress for an administration
 Q:'ADMIN 0
 N I,QANS,QTOT
 S QANS=$P(^YTT(601.84,ADMIN,0),U,10)
 S (I,QTOT)=0 F  S I=$O(^YTT(601.76,"AC",TEST,I)) Q:'I  S QTOT=QTOT+1
 Q $S(QTOT>0:$P(((QANS/QTOT)*100)+.5,"."),1:0)
 ;
NEWASMT(ARGS,DATA) ; save assignment, return /api/mha/assignment/{assignmentId}
 N I,DFN,ORDBY,VA,VADM,VAERR,I,PREFIX,SETID,FOUND,PID,PTNAME,EXPIRE
 S DFN=+$G(DATA("patient","dfn"))
 S ORDBY=+$G(DATA("orderedBy"))
 I 'DFN!'ORDBY D SETERROR^YTQRUTL(400,"Missing Reqd Fields") QUIT ""
 D DEM^VADPT I $G(VAERR) D SETERROR^YTQRUTL(400,"Missing Pt Info") QUIT ""
 S PID=VA("BID"),PTNAME=VADM(1)
 ; set these "patient" nodes up in case called with just DFN
 S DATA("patient","name")=PTNAME
 S DATA("patient","pid")="xxx-xx-"_PID
 S DATA("patient","ssn")=DATA("patient","pid")
 ; look up IEN for each instrument in the assignment
 S I=0 F  S I=$O(DATA("instruments",I)) Q:'I  D
 . N TSTNM,TSTID,TSTFN
 . S TSTNM=$G(DATA("instruments",I,"name")) Q:'$L(TSTNM)
 . S TSTID=$O(^YTT(601.71,"B",TSTNM,0)) Q:'TSTID
 . S TSTFN=$P(^YTT(601.71,TSTID,0),U,3)
 . S DATA("instruments",I,"id")=TSTID
 . S DATA("instruments",I,"printTitle")=TSTFN
 . I +$G(DATA("instruments",I,"replace")) D    ; creating from old asmt
 . . D RMVTEST(DATA("instruments",I,"replace"),DATA("instruments",I,"name"))
 . . K DATA("instruments",I,"replace")
 ; randomly generate an instrument-set id and check for already used
 S PREFIX="YTQASMT-SET-",FOUND=0,EXPIRE=$$FMADD^XLFDT(DT,7)
 F I=1:1:500 S SETID=$R(100000) D  Q:FOUND     ; give up after 500 tries
 . I $D(^XTMP(PREFIX_SETID)) QUIT              ; already occupied
 . L +^XTMP(PREFIX_SETID,0):DILOCKTM E  QUIT   ; didn't get lock in time
 . S ^XTMP(PREFIX_SETID,0)=EXPIRE_U_DT_U_"MH Assignment"
 . S ^XTMP("YTQASMT-INDEX",0)=^XTMP(PREFIX_SETID,0)_" Index"
 . L -^XTMP(PREFIX_SETID,0)
 . M ^XTMP(PREFIX_SETID,1)=DATA                ; save assignment object
 . S ^XTMP(PREFIX_SETID,1,"id")=SETID
 . S ^XTMP("YTQASMT-INDEX","AC",PID,$P(PTNAME,","),9999999-$$NOW^XLFDT)=SETID
 . S ^XTMP("YTQASMT-INDEX","AD",DFN,ORDBY,SETID)=EXPIRE
 . S FOUND=1
 I 'FOUND D SETERROR^YTQRUTL(500,"Assignment not found") Q ""
 Q "/api/mha/assignment/"_SETID
 ;
DELASMT(ARGS) ; delete the assignment identified in ARGS("assignmentId")
 D DELASMT1(ARGS("assignmentId"))
 Q
DELASMT1(ASMT) ; delete the assignment given the assignment number
 N DATA,DFN,ORDBY
 M DATA=^XTMP("YTQASMT-SET-"_ASMT,1)
 I $D(DATA)<10 D SETERROR^YTQRUTL(404,"Assignment not found") QUIT
 S DFN=+$G(DATA("patient","dfn"))
 S ORDBY=+$G(DATA("orderedBy"))
 I '$$DELIDX(ASMT,DFN,ORDBY) QUIT  ; missing pt info
 K ^XTMP("YTQASMT-SET-"_ASMT)
 Q
DELIDX(ASMT,DFN,ORDBY) ; return true if able to remove "AC", "AD" indexes
 N VA,VADM,VAERR,PID,LNAME,INVDT
 D DEM^VADPT I $G(VAERR) D SETERROR^YTQRUTL(400,"Missing Pt Info") QUIT 0
 S PID=VA("BID"),LNAME=$P(VADM(1),",")
 K ^XTMP("YTQASMT-INDEX","AD",DFN,ORDBY,ASMT)
 S INVDT=0 F  S INVDT=$O(^XTMP("YTQASMT-INDEX","AC",PID,LNAME,INVDT)) Q:'INVDT  D
 . I ^XTMP("YTQASMT-INDEX","AC",PID,LNAME,INVDT)=ASMT D
 . . K ^XTMP("YTQASMT-INDEX","AC",PID,LNAME,INVDT)
 Q 1
 ;
DELTEST(ARGS) ; remove an instrument from an assignment
 N ASMT,TEST
 S TEST=$G(ARGS("instrument")),ASMT=$G(ARGS("assignmentId"))
 I +TEST=TEST S TEST=$P($G(^YTT(601.71,TEST,0)),U) ; use instrument name
 I '$L(TEST) D SETERROR^YTQRUTL(404,"Instrument not found") QUIT
 I $D(^XTMP("YTQASMT-SET-"_ASMT))<10 D SETERROR^YTQRUTL("Assignment not found") QUIT
 D RMVTEST(ASMT,TEST)
 Q
RMVTEST(ASMT,TEST) ; remove test from assignment, delete assignment if empty
 N I,NODE
 S NODE="YTQASMT-SET-"_ASMT
 S I=0 F  S I=$O(^XTMP(NODE,1,"instruments",I)) Q:'I  D
 . I ^XTMP(NODE,1,"instruments",I,"name")=TEST D
 . . K ^XTMP(NODE,1,"instruments",I)
 I $D(^XTMP(NODE,1,"instruments"))<10 D DELASMT1(ASMT)
 Q
 ;
UPDIDX ; Update AC and AD indexes to synch with expired assignments
 N PID,LNAME,INVDT,ASMT,DFN,ORDBY,CURTM,ORIGTM
 S CURTM=$$NOW^XLFDT
 S PID="" F  S PID=$O(^XTMP("YTQASMT-INDEX","AC",PID)) Q:'$L(PID)  D
 . S LNAME="" F  S LNAME=$O(^XTMP("YTQASMT-INDEX","AC",PID,LNAME)) Q:'$L(LNAME)  D
 . . S INVDT=0 F  S INVDT=$O(^XTMP("YTQASMT-INDEX","AC",PID,LNAME,INVDT)) Q:'INVDT  D
 . . . S ASMT=^XTMP("YTQASMT-INDEX","AC",PID,LNAME,INVDT)
 . . . I '$D(^XTMP("YTQASMT-SET-"_ASMT,0)) D
 . . . . K ^XTMP("YTQASMT-INDEX","AC",PID,LNAME,INVDT)
 . . . . S ORIGTM=9999999-INVDT
 . . . . W !,"removed AC:  "_ASMT,?20,PID_"  "_LNAME,?40,$$FMDIFF^XLFDT(CURTM,ORIGTM,1)_" days"
 S DFN=0 F  S DFN=$O(^XTMP("YTQASMT-INDEX","AD",DFN)) Q:'DFN  D
 . S ORDBY=0 F  S ORDBY=$O(^XTMP("YTQASMT-INDEX","AD",DFN,ORDBY)) Q:'ORDBY  D
 . . S ASMT=0 F  S ASMT=$O(^XTMP("YTQASMT-INDEX","AD",DFN,ORDBY,ASMT)) Q:'ASMT  D
 . . . I '$D(^XTMP("YTQASMT-SET-"_ASMT,0)) D
 . . . . S ORIGTM=^XTMP("YTQASMT-INDEX","AD",DFN,ORDBY,ASMT)
 . . . . K ^XTMP("YTQASMT-INDEX","AD",DFN,ORDBY,ASMT)
 . . . . W !,"removed AD:  "_ASMT,?20,DFN_"  "_ORDBY,?40,$$FMDIFF^XLFDT(CURTM,ORIGTM,1)_" days"
 Q
CHKIDX ; Check assignments to make sure the indexes are present
 N SET,ASMT,DFN,ORDBY,VA,VADM,VAERR,PID,LNAME,INVDT,FOUND
 S SET="YTQASMT-SET-" F  S SET=$O(^XTMP(SET)) Q:$E(SET,1,12)'="YTQASMT-SET-"  D
 . S ASMT=$P(SET,"-",3)
 . S DFN=^XTMP(SET,1,"patient","dfn")
 . S ORDBY=^XTMP(SET,1,"orderedBy")
 . I '$D(^XTMP("YTQASMT-INDEX","AD",DFN,ORDBY,ASMT)) D
 . . W !,"Assignment "_ASMT_" missing AD index."
 . D DEM^VADPT I $G(VAERR) Q
 . S PID=VA("BID"),LNAME=$P(VADM(1),","),FOUND=0
 . S INVDT=0 F  S INVDT=$O(^XTMP("YTQASMT-INDEX","AC",PID,LNAME,INVDT)) Q:'INVDT  D  Q:FOUND
 . . I ^XTMP("YTQASMT-INDEX","AC",PID,LNAME,INVDT)=ASMT S FOUND=1
 . I 'FOUND W !,"Assignment "_ASMT_" missing AC index."
 Q

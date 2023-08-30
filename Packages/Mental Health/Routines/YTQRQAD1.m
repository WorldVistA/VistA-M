YTQRQAD1 ;SLC/KCM - RESTful Calls to handle MHA assignments ; 1/25/2017
 ;;5.01;MENTAL HEALTH;**130,141,178,182,181,187,199,207,204**;Dec 30, 1994;Build 18
 ;
 ; Reference to VADPT in ICR #10061
 ; Reference to XLFDT in ICR #10103
 ; Reference to XLFSTR in ICR #10104
 ; Reference to XPDMENU in ICR #1157
 ; Reference to XQCHK in ICR #10078
 ;
ASMTBYID(ARGS,RESULTS) ; get assignment identified by assignmentId
 N ASMT,ADMIN,TEST,I
 S ASMT="YTQASMT-SET-"_$G(ARGS("assignmentId"))
 I '$D(^XTMP(ASMT)) D SETERROR^YTQRUTL(404,"Not Found: "_ARGS("assignmentId")) QUIT
 S I=0 F  S I=$O(^XTMP(ASMT,1,"instruments",I)) Q:'I  D  ; calc progress
 . S ADMIN=+$G(^XTMP(ASMT,1,"instruments",I,"adminId"))
 . S TEST=+$G(^XTMP(ASMT,1,"instruments",I,"id"))
 . I $$ADMEXPD(ADMIN,TEST) D  ; start over if this admin has expired
 . . S ^XTMP(ASMT,1,"instruments",I,"adminId")="null"
 . . I ^XTMP(ASMT,1,"patient","dfn")=$P(^YTT(601.84,ADMIN,0),U,2) D
 . . . D DELADMIN(ADMIN) ; double check DFN match just to make sure
 . . S ADMIN=0
 . S ^XTMP(ASMT,1,"instruments",I,"progress")=$$PROGRESS(ADMIN,TEST,$G(ARGS("assignmentId")))
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
PROGRESS(ADMIN,TEST,ASMTID) ; return the progress for an administration
 ; progress in 100% if administration is complete
 I ADMIN,$P($G(^YTT(601.84,ADMIN,0)),U,9)="Y" Q 100
 ; check to see if this is a CAT that has been started
 N CATPROG S CATPROG=-1
 I $G(ASMTID,0) D  I CATPROG>-1 Q CATPROG
 . I $G(^XTMP("YTQASMT-SET-"_ASMTID,1,"catInfo","credentials","interviewID")) S CATPROG=10
 ;
 Q:'ADMIN 0
 N I,QANS,QTOT
 S QANS=$P(^YTT(601.84,ADMIN,0),U,10)
 S (I,QTOT)=0 F  S I=$O(^YTT(601.76,"AC",TEST,I)) Q:'I  S QTOT=QTOT+1
 Q $S(QTOT>0:$P(((QANS/QTOT)*100)+.5,"."),1:0)
 ;
NEWASMT(ARGS,DATA) ; save assignment, return /api/mha/assignment/{assignmentId}
 N I,DFN,ORDBY,VA,VADM,VAERR,SETID,FOUND,PID,PTNAME,EXPIRE,CONS,COSIGN
 N RETSTAT,REPLACE
 S DFN=+$G(DATA("patient","dfn"))
 S ORDBY=+$G(DATA("orderedBy"))
 S CONS=+$G(DATA("consult"))
 S COSIGN=+$G(DATA("cosigner"))
 I 'DFN!'ORDBY D SETERROR^YTQRUTL(400,"Missing Reqd Fields") QUIT ""
 D DEM^VADPT I $G(VAERR) D SETERROR^YTQRUTL(400,"Missing Pt Info") QUIT ""
 S PID=VA("BID"),PTNAME=VADM(1)
 ; set these "patient" nodes up in case called with just DFN
 S DATA("patient","name")=PTNAME
 S DATA("patient","pid")="xxx-xx-"_PID
 S DATA("patient","ssn")=DATA("patient","pid")
 ; get instrument Admin Date
 S DATA("adminDate")=$G(DATA("adminDate"))  ;Ensure adminDate is set
 I $G(DATA("consult"))=""!($G(DATA("consult"))="null") K DATA("consult")
 S DATA("appSrc")=$G(DATA("appSrc"))
 S FOUND=""
 S I=0 F  S I=$O(DATA("instruments",I)) Q:I=""!FOUND  D
 . I $G(DATA("instruments",I,"replace"))]"" D
 .. S REPLACE=DATA("instruments",I,"replace") M DATA(2)=^XTMP("YTQASMT-SET-"_REPLACE,2) S FOUND=1
 ; look up IEN for each instrument in the assignment
 S RETSTAT=$$FILASGN(.ARGS,.DATA,"","NEW")
 Q RETSTAT
FILASGN(ARGS,DATA,SETID,TYPE) ;File the Assignment Data
 ; ARGS = incoming arguments
 ; DATA = incoming data
 ; SETID = Assignment number if existing assignment(EDIT)
 ; TYPE = NEW or EDIT
 N I,PREFIX,FOUND,EXPIRE,OLDSET,YSTAT
 I $G(TYPE)="" S TYPE="NEW"  ;default
 S SETID=$G(SETID)
 S I=0 F  S I=$O(DATA("instruments",I)) Q:'I  D
 . N TSTNM,TSTID,TSTFN,TSTRSTRT
 . S TSTNM=$G(DATA("instruments",I,"name")) Q:'$L(TSTNM)
 . S TSTID=$O(^YTT(601.71,"B",TSTNM,0)) Q:'TSTID
 . S TSTFN=$P(^YTT(601.71,TSTID,0),U,3)
 . S TSTRSTRT=$P($G(^YTT(601.71,TSTID,8)),U,7) S:TSTRSTRT="" TSTRSTRT=-1
 . S DATA("instruments",I,"id")=TSTID
 . S DATA("instruments",I,"printTitle")=TSTFN
 . S DATA("instruments",I,"restartDays")=TSTRSTRT
 . I +$G(DATA("instruments",I,"replace")) D    ; creating from old asmt
 . . D RMVTEST(DATA("instruments",I,"replace"),DATA("instruments",I,"name"),,,1)
 . . I $E(DATA("instruments",I,"name"),1,4)="CAT-" D
 . . . S OLDSET=DATA("instruments",I,"replace")
 . . K DATA("instruments",I,"replace")
 ; randomly generate an instrument-set id and check for already used
 S YSTAT="",PREFIX="YTQASMT-SET-"
 I TYPE="NEW"!(SETID="") D
 . S FOUND=0,EXPIRE=$$FMADD^XLFDT(DT,7)
 . F I=1:1:500 S SETID=$R(100000) D  Q:FOUND     ; give up after 500 tries
 . . I $D(^XTMP(PREFIX_SETID)) QUIT              ; already occupied
 . . L +^XTMP(PREFIX_SETID,0):DILOCKTM E  S YSTAT="500^Cannot get Lock for Assignment" QUIT   ; didn't get lock in time
 . . S ^XTMP(PREFIX_SETID,0)=EXPIRE_U_DT_U_"MH Assignment"
 . . S ^XTMP("YTQASMT-INDEX",0)=^XTMP(PREFIX_SETID,0)_" Index"
 . . L -^XTMP(PREFIX_SETID,0)
 . . ;M ^XTMP(PREFIX_SETID,1)=DATA                ; save assignment object
 . . S ^XTMP(PREFIX_SETID,1,"id")=SETID
 . . S ^XTMP("YTQASMT-INDEX","AC",PID,$P(PTNAME,","),9999999-$$NOW^XLFDT)=SETID
 . . S ^XTMP("YTQASMT-INDEX","AD",DFN,ORDBY,SETID)=EXPIRE
 . . I +$G(OLDSET) D MVAUTOSV^YTQRCAT(OLDSET,SETID)
 . . S FOUND=1
 . I 'FOUND S YSTAT="500^Could not create Assignment"
 I TYPE="EDIT" D
 . I SETID="" S YSTAT="500^Assignment not provided" Q
 . K ^XTMP("YTQASMT-SET-"_SETID,1,"instruments")
 . ;S I=0 F  S I=$O(^XTMP("YTQASMT-SET-"_SETID,1,"instruments",I)) Q:I=""  K ^XTMP("YTQASMT-SET-"_SETID,1,"instruments",I)
 . ;Re-file new instrument info into ^XTMP
 . I '$D(DATA("instruments")) D DELASMT1^YTQRQAD1(SETID) Q  ;Assignment has no instruments
 . M ^XTMP(PREFIX_SETID,1,"instruments")=DATA("instruments") ; save assignment object
 . I $D(DATA("catInfo")) M ^XTMP(PREFIX_SETID,1,"catInfo")=DATA("catInfo")
 . ;Kill any changes of omission before merging
 . I '$D(DATA("consult")) K ^XTMP(PREFIX_SETID,1,"consult")  ;Removed Consult
 . I '$D(DATA("adminDate")) K ^XTMP(PREFIX_SETID,1,"adminDate")  ;Removed admin date
 . I '$D(DATA("cosigner")) K ^XTMP(PREFIX_SETID,1,"cosigner")  ;Removed Cosigner
 . I '$D(^XTMP(PREFIX_SETID,1,"instruments")) S YSTAT="500^ERROR"
 I $D(DATA(2,"PNOTE")) M ^XTMP(PREFIX_SETID,2)=DATA(2) K DATA(2)
 I YSTAT'="" D  Q ""
 . I $P(YSTAT,U)'>300 Q
 . D SETERROR^YTQRUTL($P(YSTAT,U),$P(YSTAT,U,2))
 M ^XTMP(PREFIX_SETID,1)=DATA
 Q "/api/mha/assignment/"_SETID
 ;
DELASMT(ARGS) ; delete the assignment identified in ARGS("assignmentId")
 D DELASMT1(ARGS("assignmentId"))
 Q
TRSASMT(ARGS) ; Delete an assignment from Staff Entry by Trash icon
 ; Allows deletion of any incomplete assignment (ie no instruments complete)
 ; *Deletes any incomplete MH ADMINISTRATIONS
 D DELASMT1(ARGS("assignmentId"),1)
 Q
DELASMT1(ASMT,TRS,REPLACE) ; delete the assignment given the assignment number
 ;ASMT=Assignment number
 ;TRS=Called from Trash Assignment - allow deletion of incomplete MH ADMINISTRATION
 ;REPLACE=1 if called from FILASGN for moving one AssignmentID to a new AssignmentID
 N DATA,DFN,ORDBY,IARR,INST,TRSERR,VAERR,VA,VADM
 N AGPROG,PNOT
 S TRS=$G(TRS),TRSERR=""
 S REPLACE=$G(REPLACE)
 M DATA=^XTMP("YTQASMT-SET-"_ASMT,1)
 I $D(DATA)<10 D SETERROR^YTQRUTL(404,"Assignment not found") QUIT
 S DFN=+$G(DATA("patient","dfn"))
 S ORDBY=+$G(DATA("orderedBy"))
 S AGPROG=$D(^XTMP("YTQASMT-SET-"_ASMT,2))
 ; Moved Patient check here before deleting XREF otherwise XREF killed before Assignment killed/TRSERR=1
 D DEM^VADPT I $G(VAERR) D SETERROR^YTQRUTL(404,"Assignment missing pt info") QUIT  ; missing pt info
 ;I '$$DELIDX^YTQRQAD1(ASMT,DFN,ORDBY) D SETERROR^YTQRUTL(404,"Assignment missing pt info") QUIT  ; missing pt info
 I TRS=1 D
 . D AINSTS^YTQRQAD7(ASMT,.IARR)
 . I $G(IARR("STAT"))="NOTALLOWED" D SETERROR^YTQRUTL(405,"Delete assignment not allowed") S TRSERR=1 QUIT
 . I $G(IARR("STAT"))="NOTOK" D SETERROR^YTQRUTL(405,"One or more instruments complete") S TRSERR=1 QUIT
 . I '$$DELIDX^YTQRQAD1(ASMT,DFN,ORDBY) QUIT  ; missing pt info
 . S INST=0 F  S INST=$O(IARR(INST)) QUIT:+INST=0  D
 .. Q:IARR(INST)=0  ;Safety net
 .. Q:'$D(IARR(INST,"ADMINID"))
 .. D DELADMIN(IARR(INST,"ADMINID"))
 I TRSERR=1 QUIT
 I AGPROG>0,(REPLACE'=1) S PNOT=$$FILPNOT^YTQRQAD8(ASMT,,,,,1)  ;File any completed instrument Progress Note before deleting an Assignment if NOT from a moved assignment
 N OK S OK=$$DELIDX^YTQRQAD1(ASMT,DFN,ORDBY)
 K ^XTMP("YTQASMT-SET-"_ASMT)
 Q
DELIDX(ASMT,DFN,ORDBY) ; return true if able to remove "AC", "AD" indexes
 N VA,VADM,VAERR,PID,LNAME,INVDT
 D DEM^VADPT I $G(VAERR) D SETERROR^YTQRUTL(400,"Missing Pt Info") QUIT 0
 S PID=VA("BID"),LNAME=$P(VADM(1),",")  ;VA("BID")=last 4 SSN
 K ^XTMP("YTQASMT-INDEX","AD",DFN,ORDBY,ASMT)
 S INVDT=0 F  S INVDT=$O(^XTMP("YTQASMT-INDEX","AC",PID,LNAME,INVDT)) Q:'INVDT  D
 . I ^XTMP("YTQASMT-INDEX","AC",PID,LNAME,INVDT)=ASMT D
 . . K ^XTMP("YTQASMT-INDEX","AC",PID,LNAME,INVDT)
 Q 1
 ;
DELTEST(ARGS) ; remove an instrument from an assignment
 N ASMT,TEST,TSLIST,II,DELFASGN
 S ASMT=$G(ARGS("assignmentId"))
 S DELFASGN=$G(ARGS("delfrmassign"))  ;Flag to Delete Instrument from Assignment
 S:DELFASGN'="NO" DELFASGN="YES"  ;Default is Delete from Assignment
 I $D(^XTMP("YTQASMT-SET-"_ASMT))<10 D SETERROR^YTQRUTL(404,"Assignment not found") QUIT
 S TSLIST=$G(ARGS("instrument")) I '$L(TSLIST) D SETERROR^YTQRUTL(404,"Instrument for deletion not sent") QUIT
 F II=1:1:$L(TSLIST,",") D
 . S TEST=$P(TSLIST,",",II)
 . Q:TEST=""
 . I +TEST=TEST S TEST=$P($G(^YTT(601.71,TEST,0)),U) ; use instrument name
 . I '$L(TEST) D SETERROR^YTQRUTL(404,"Instrument not found") QUIT
 . D RMVTEST(ASMT,TEST,1,DELFASGN)
 Q "/api/mha/assignment/"_ASMT_"/"_TSLIST_"/OK"
RMVTEST(ASMT,TEST,DELADMIN,DELFASGN,REPLACE) ; remove test from assignment, delete assignment if empty
 ;Delete MH ADMINISTRATION if DELADMIN=1.
 ;Do Not Delete Instrument from Assignment if DELFASGN="NO". Used for 0 days restart instruments that need to be restarted same day.
 ;REPLACE=1 if called from FILASGN for moving one AssignmentID to a new AssignmentID
 N I,NODE,IARR
 S DELFASGN=$G(DELFASGN) S:DELFASGN'="NO" DELFASGN="YES"  ;Default is to delete from Assignment
 S DELADMIN=$G(DELADMIN)
 S REPLACE=$G(REPLACE)
 D AINSTS^YTQRQAD7(ASMT,.IARR)  ;Get Delete status of instruments for an Assignment
 S NODE="YTQASMT-SET-"_ASMT
 S I=0 F  S I=$O(^XTMP(NODE,1,"instruments",I)) Q:'I  D
 . I ^XTMP(NODE,1,"instruments",I,"name")=TEST D
 . . ;I DELADMIN=1,(IARR(I)'=0),($D(IARR(I,"ADMINID"))) D
 . . I DELADMIN=1,($D(IARR(I,"ADMINID"))) D  ;Not Interview, Not Ordering OK
 . . . D DELADMIN(IARR(I,"ADMINID"))
 . . I DELFASGN="YES" K ^XTMP(NODE,1,"instruments",I)
 . . I DELFASGN="NO" D
 . . . S ^XTMP(NODE,1,"instruments",I,"adminId")="null"
 . . . S ^XTMP(NODE,1,"instruments",I,"complete")="false"
 . . . S ^XTMP(NODE,1,"instruments",I,"progress")=0
 I $D(^XTMP(NODE,1,"instruments"))<10 D DELASMT1(ASMT,,REPLACE)
 Q
 ;
DELMHAD(ARGS,DATA) ;Delete Completed MH Admin
 N MGR,ADMINID,X0
 S MGR=$$ISMGR
 S ADMINID=$G(ARGS("adminId"))
 I ADMINID="" D SETERROR^YTQRUTL(404,"Admin ID Missing") Q "/api/mha/instrument/mhadmin/ERROR"
 I '$D(^YTT(601.84,ADMINID)) D SETERROR^YTQRUTL(404,"Admin ID not found") Q "/api/mha/instrument/mhadmin/ERROR"
 S X0=^YTT(601.84,ADMINID,0)
 ;I MGR!(DUZ=$P(X0,U,6))!(DUZ=$P(X0,U,7)) D DELADMIN(ADMINID) I 1
 I MGR D DELADMIN(ADMINID) I 1
 E  D SETERROR^YTQRUTL(404,"Deletion not allowed:  insufficient privilege") Q "/api/mha/instrument/mhadmin/ERROR"
 Q "/api/mha/instrument/mhadmin/OK"
ISMGR() ; return 1 if admin access to admins
 N YSMENU,YSPRIV
 S YSMENU=$$LKOPT^XPDMENU("YSMANAGER") Q:'YSMENU 0
 S YSPRIV=$$ACCESS^XQCHK(DUZ,YSMENU)
 Q +YSPRIV>0
 ;
ADMEXPD(ADMIN,TEST) ; return 1 if incomplete admin has expired
 QUIT:'ADMIN 0
 N X0,YSNOW,YSDOW,OFFSET,SAVED,RESTRT
 S X0=$G(^YTT(601.84,ADMIN,0))
 QUIT:$P(X0,U,9)="Y" 0                     ; admin is complete
 QUIT:$P(X0,U,3)'=TEST 0                   ; test mismatch, something wrong
 S YSNOW=$$NOW^XLFDT,YSDOW=$$DOW^XLFDT(YSNOW)
 S OFFSET=$S(YSDOW=5:2,YSDOW=6:1,1:0)      ; account for weekends
 S SAVED=$P(X0,U,5)                        ; DATE SAVED (#4)
 S RESTRT=$P($G(^YTT(601.71,TEST,8)),U,7)  ; DAYS TO RESTART (#27)
 QUIT:RESTRT=-1 0                          ; -1 is always restartable
 S:'RESTRT RESTRT=2                        ; default restart is 2
 I $$FMDIFF^XLFDT(YSNOW,SAVED,2)>((RESTRT+OFFSET)*86400) QUIT 1
 Q 0
 ;
DELADMIN(YSADM) ; delete an admin & associated records
 N DIK,DA,YSANS,YSRSLT
 ; delete the admin record
 S DIK="^YTT(601.84,",DA=YSADM D ^DIK
 ; delete the answer records
 S YSANS=0 F  S YSANS=$O(^YTT(601.85,"AD",YSADM,YSANS)) Q:YSANS'>0  D
 . I $P(^YTT(601.85,YSANS,0),U,2)'=YSADM Q  ; admin doesn't match
 . S DIK="^YTT(601.85,",DA=YSANS D ^DIK
 ; delete the result records
 S YSRSLT=0 F  S YSRSLT=$O(^YTT(601.92,"AC",YSADM,YSRSLT)) Q:YSRSLT'>0  D
 . I $P(^YTT(601.92,YSRSLT,0),U,2)'=YSADM Q  ; result doesn't match
 . S DIK="^YTT(601.92,",DA=YSRSLT D ^DIK
 Q

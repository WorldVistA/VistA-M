YTQRIS ;SLC/KCM - Instrument Selection RPC's ; 1/25/2017
 ;;5.01;MENTAL HEALTH;**130**;Dec 30, 1994;Build 62
 ;
 ; External Reference    ICR#
 ; ------------------   -----
 ; ^VA(200)              1234
 ; ^XUSEC               10076
 ; DIK                  10013
 ; DIQ                   2056
 ; VADPT                10061
 ; XLFDT                10103
 ; XPDKEY                1367
 ; XPDMENU               1157
 ; XQCHK                10078
 ; XUAF4                 2171
 ; XUSER                 2343
 ;
NXT() ; return next RSP index
 S YSIDX=$G(YSIDX)+1
 Q YSIDX
 ;
AVAIL(RSP,DFN,ORDBY) ; return list available instruments/assignments/etc.
 ; return type^displayText^identifier^instrumentList...
 ;         1        2           3         4..n
 N YSIDX
 D INCPLT(DFN,ORDBY)  ; add incomplete instruments
 D ASSIGN(DFN,ORDBY)  ; get active assignments
 D BATTERY            ; add batteries
 D REGULAR            ; add regular instruments
 Q
ACTIVE(RSP,DFN,ORDBY) ; return list of active assignments
 ; return displayText^pin^name|adminId^name|adminId^...
 ;              1      2        3            4       n...
 N PTADMIN
 D ASSIGN2(DFN,ORDBY) ; this has to be first to build PTADMIN
 D INCPLT2(DFN,ORDBY)
 Q
INCPLT(DFN,ORDBY) ; add list of incomplete instruments for DFN and ORDBY
 ; expects RSP,YSIDX
 Q:'ORDBY  Q:'DFN
 N I,X,YS,YSDATA,YSNOW,YSDOW,OFFSET,YSDTSAV,YSRSTRT
 S YSNOW=$$NOW^XLFDT
 S YSDOW=$$DOW^XLFDT(YSNOW)
 S OFFSET=$S(YSDOW=5:2,YSDOW=6:1,1:0)
 S YS("DFN")=DFN,YS("COMPLETE")="N"
 D ADMINS^YTQAPI5(.YSDATA,.YS)
 S I=2 F  S I=$O(YSDATA(I)) Q:'I  D
 . I $P(YSDATA(I),U,5)'=ORDBY QUIT                    ; not same orderedBy
 . S YSDTSAV=$P(YSDATA(I),U,4) I 'YSDTSAV QUIT        ; no date, bad entry
 . S YSRSTRT=$P(YSDATA(I),U,15) S:'YSRSTRT YSRSTRT=2  ; account for weekends
 . ; always restartable is -1, comparing full 24 hour periods so use seconds
 . I (YSRSTRT'=-1),$$FMDIFF^XLFDT(YSNOW,YSDTSAV,2)>((YSRSTRT+OFFSET)*86400) Q
 . S X="I"                                            ; incomplete
 . S $P(X,U,2)=$P(YSDATA(I),U,2)_" ("_$$FMTE^XLFDT(YSDTSAV,"2Z")_")"
 . S $P(X,U,3)=$P(YSDATA(I),U)                        ; adminId
 . S $P(X,U,4)=$P(YSDATA(I),U,2)                      ; instrumentName
 . S RSP($$NXT)=X
 Q
INCPLT2(DFN,ORDBY) ; add list of incomplete instruments for DFN and ORDBY
 ; expects RSP,YSIDX,PTADMIN
 Q:'ORDBY  Q:'DFN
 N I,X,YS,YSDATA,YSNOW,YSDOW,OFFSET,YSDTSAV,YSRSTRT
 S YSNOW=$$NOW^XLFDT
 S YSDOW=$$DOW^XLFDT(YSNOW)
 S OFFSET=$S(YSDOW=5:2,YSDOW=6:1,1:0)
 S YS("DFN")=DFN,YS("COMPLETE")="N"
 D ADMINS^YTQAPI5(.YSDATA,.YS)
 S I=2 F  S I=$O(YSDATA(I)) Q:'I  D
 . I $D(PTADMIN(+YSDATA(I))) QUIT                     ; skip pt assigned
 . I $P(YSDATA(I),U,5)'=ORDBY QUIT                    ; not same orderedBy
 . S YSDTSAV=$P(YSDATA(I),U,4) I 'YSDTSAV QUIT        ; no date, bad entry
 . S YSRSTRT=$P(YSDATA(I),U,15) S:'YSRSTRT YSRSTRT=2  ; account for weekends
 . ; always restartable is -1, comparing full 24 hour periods so use seconds
 . I (YSRSTRT'=-1),$$FMDIFF^XLFDT(YSNOW,YSDTSAV,2)>((YSRSTRT+OFFSET)*86400) Q
 . S X=$P(YSDATA(I),U,2)_" ("_$$FMTE^XLFDT(YSDTSAV,"2Z")_")" ; test (date)
 . S $P(X,U,2)=0                                      ; staff entry -- no PIN
 . S $P(X,U,3)=$P(YSDATA(I),U,2)_"|"_$P(YSDATA(I),U)  ; instrumentName|adminId
 . S RSP($$NXT)=X
 Q
BATTERY ; add batteries
 ; expects RSP,YSIDX
 N I,X,YSDATA,LIST,NM
 D BATTC^YTQAPI3(.YSDATA)
 S I=1 F  S I=$O(YSDATA(I)) Q:'I  D
 . S LIST($P(YSDATA(I),U,2),$P(YSDATA(I),U,3))=$P(YSDATA(I),U,5)
 S NM="" F  S NM=$O(LIST(NM)) Q:'$L(NM)  D
 . S X="B^"_NM
 . S I=0 F  S I=$O(LIST(NM,I)) Q:'I  S $P(X,U,I+3)=LIST(NM,I)
 . S RSP($$NXT)=X
 Q
REGULAR ; add list of regular instruments
 ; expects RSP,YSIDX
 N I,X,NM
 S X="" F  S X=$O(^YTT(601.71,"B",X)) Q:'$L(X)  D
 . S I=$O(^YTT(601.71,"B",X,0))
 . I $P($G(^YTT(601.71,I,2)),U,2)'="Y" QUIT
 . S NM=$P(^YTT(601.71,I,0),U)
 . S RSP($$NXT)="R"_U_NM_U_I_U_NM
 Q
ASSIGN(DFN,ORDBY) ; return available list of instruments
 ; expects RSP,YSIDX
 Q:'ORDBY  Q:'DFN
 N ASMT
 S ASMT=0 F  S ASMT=$O(^XTMP("YTQASMT-INDEX","AD",DFN,ORDBY,ASMT)) Q:'ASMT  D
 . N DATA,NAMES,X,I,J
 . I '$D(^XTMP("YTQASMT-SET-"_ASMT,0)) D  Q  ; assignment must have expired
 . . N OK S OK=$$DELIDX^YTQRQAD1(ASMT,DFN,ORDBY)
 . M DATA=^XTMP("YTQASMT-SET-"_ASMT,1)
 . I DATA("entryMode")="staff" Q  ; only show patient entered
 . S NAMES="",X="A^",J=3 ; J is piece offset for test name
 . S I=0 F  S I=$O(DATA("instruments",I)) Q:'I  D
 . . I $L(NAMES) S NAMES=NAMES_","
 . . S NAMES=NAMES_DATA("instruments",I,"name")
 . . S J=J+1,$P(X,U,J)=DATA("instruments",I,"name")
 . S $P(X,U,2)=NAMES
 . S $P(X,U,3)=ASMT
 . S RSP($$NXT)=X
 Q
ASSIGN2(DFN,ORDBY) ; return available list of instruments
 ; expects RSP,YSIDX,PTADMIN
 Q:'DFN  ;Q:'ORDBY
 N ASMT,PRV
 S PRV=0 F  S PRV=$O(^XTMP("YTQASMT-INDEX","AD",DFN,PRV)) Q:'PRV  D
 . S ASMT=0 F  S ASMT=$O(^XTMP("YTQASMT-INDEX","AD",DFN,PRV,ASMT)) Q:'ASMT  D
 . . N DATA,NAMES,TEST,ADMIN,X,I,J
 . . I '$D(^XTMP("YTQASMT-SET-"_ASMT,0)) D  Q  ; assignment must have expired
 . . . N OK S OK=$$DELIDX^YTQRQAD1(ASMT,DFN,PRV)
 . . M DATA=^XTMP("YTQASMT-SET-"_ASMT,1)
 . . I DATA("entryMode")="staff" Q             ; only show patient entered
 . . S (X,NAMES)="",J=2                        ; J is piece offset for test name
 . . S I=0 F  S I=$O(DATA("instruments",I)) Q:'I  D
 . . . I $L(NAMES) S NAMES=NAMES_","
 . . . S NAMES=NAMES_DATA("instruments",I,"name")
 . . . S TEST=DATA("instruments",I,"name")
 . . . S ADMIN=+$G(DATA("instruments",I,"adminId"))
 . . . S TEST=TEST_"|"_ADMIN
 . . . I ADMIN S PTADMIN(ADMIN)=""             ; avoid including with staff
 . . . S J=J+1,$P(X,U,J)=TEST
 . . S $P(X,U,1)=NAMES
 . . S $P(X,U,2)=ASMT
 . . S RSP($$NXT)=X
 Q
PTINFO(RSP,DFN) ; return display info for patient
 N VA,VADM,VAERR
 D DEM^VADPT
 I VAERR S RSP(1)="Error Encountered" QUIT
 S RSP(1)=VADM(1)_U_"xxx-xx-"_VA("BID")
 Q
USERINFO(RSP) ; return user info
 S RSP(1)=DUZ_U_$$NAME^XUSER(DUZ,"F")_U_$$STA^XUAF4(DUZ(2))
 Q
DESCRIBE(RSP,PIN,ADMINS) ; describe an assignment
 ; expects RSP,YSIDX
 S RSP(1)="descriptive text will go here"
 N YSIDX,DATA,EXPDT,I,IEN,X0
 S YSIDX=0
 I +PIN D
 . M DATA=^XTMP("YTQASMT-SET-"_PIN,1)
 . S EXPDT=$P($G(^XTMP("YTQASMT-SET-"_PIN,0)),U)
 . S:EXPDT EXPDT=$$FMTE^XLFDT(EXPDT,"2Z")
 . S RSP($$NXT)="PIN: "_PIN_"  (expires "_EXPDT_")"
 . S RSP($$NXT)="Ordered By: "_$$GET1^DIQ(200,+$G(DATA("orderedBy"))_",",.01)
 I YSIDX>0 S RSP($$NXT)=" "
 F I=1:1:$L(ADMINS,",") D
 . S IEN=+$P(ADMINS,",",I) Q:'IEN  Q:'$D(^YTT(601.84,IEN,0))
 . S X0=^YTT(601.84,IEN,0)
 . S RSP($$NXT)=$P($G(^YTT(601.71,+$P(X0,U,3),0)),U)
 . I 'PIN S RSP($$NXT)="  Ordered By: "_$$GET1^DIQ(200,+$P(X0,U,6)_",",.01)
 . S RSP($$NXT)="  Date/Time Begun: "_$$FMTE^XLFDT($P(X0,U,4),"2PZ")
 . S RSP($$NXT)="  Date/Time Last Saved: "_$$FMTE^XLFDT($P(X0,U,5),"2PZ")
 . S RSP($$NXT)="  Number of Questions Answered: "_$P(X0,U,10)
 . I +PIN S RSP($$NXT)="  Completed: "_$S($P(X0,U,9)="Y":"Yes",1:"No")
 Q
VALTSTS(RSP,MODE,ORDBY,TESTS) ; validate a set of instruments
 N MSG,I,IEN,TEST,APRV
 S MSG=""
 F I=1:1:$L(TESTS,",") S TEST=$P(TESTS,",",I) I $L(TEST) D  Q:$L(MSG)
 . S IEN=$O(^YTT(601.71,"B",TEST,0)) I 'IEN D  Q
 . . S MSG=TEST_" is not found on the server."
 . S APRV=$P($G(^YTT(601.71,IEN,1)),U,6) S:+APRV APRV=$$LKUP^XPDKEY(APRV)
 . I $L(APRV),'$D(^XUSEC(APRV,ORDBY)) D  Q
 . . S MSG="Insufficient privilege to administer "_TEST
 . I MODE="patient",$P($G(^YTT(601.71,IEN,9)),U,4)="Y" D  Q
 . . S MSG=TEST_"is identified as 'staff-entry only'"
 S RSP(0)=$S($L(MSG):MSG,1:"OK")
 Q
DELASMT(RSP,ATYP,ANID) ; delete an assignment or incomplete admin
 I ATYP="A" D  QUIT
 . N YTQRERRS
 . K ^TMP("YTQRERRS",$J)
 . D DELASMT1^YTQRQAD1(ANID)
 . S RSP(1)="ok" I $G(YTQRERRS) S RSP(1)=$$ERRTXT^YTQRUTL
 . K ^TMP("YTQRERRS",$J)
 I ATYP="I" D  QUIT
 . S RSP(1)="Deletion of instruments that have been started is not allowed."
 S RSP(1)="Unrecognized Item Type"
 Q
DELASMT2(RSP,PIN,ADMINS) ; delete an assignment or incomplete admin
 N I,X0,IEN,MGR,ERRMSG
 S MGR=$$ISMGR,ERRMSG=""
 ;
 ; delete the individual admin entries first
 F I=1:1:$L(ADMINS,",") D  Q:$L(ERRMSG)
 . S IEN=+$P(ADMINS,",",I) Q:'IEN  Q:'$D(^YTT(601.84,IEN,0))
 . S X0=^YTT(601.84,IEN,0)
 . I $P(X0,U,8)="Y" D  Q
 . . S ERRMSG="Deletion not allowed:  status is 'completed'"
 . I MGR!(DUZ=$P(X0,U,6))!(DUZ=$P(X0,U,7)) D DELADMIN(IEN) I 1
 . E  S ERRMSG="Deletion not allowed:  insufficient privilege"
 I $L(ERRMSG) S RSP(1)=ERRMSG Q
 S RSP(1)="ok"
 ;
 ; now delete the assignment
 I 'PIN QUIT
 N YTQRERRS
 K ^TMP("YTQRERRS",$J)
 D DELASMT1^YTQRQAD1(PIN)
 I $G(YTQRERRS) S RSP(1)=$$ERRTXT^YTQRUTL
 K ^TMP("YTQRERRS",$J)
 Q
ISMGR() ; return 1 if admin access to admins
 N YSMENU,YSPRIV
 S YSMENU=$$LKOPT^XPDMENU("YSMANAGER") Q:'YSMENU 0
 S YSPRIV=$$ACCESS^XQCHK(DUZ,YSMENU)
 Q +YSPRIV>0
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
ACTCAT(RSP) ; return a list of active categories
 N TEST,CAT,X0,NM,SORTED
 S TEST=0 F  S TEST=$O(^YTT(601.71,TEST)) Q:'TEST  D
 . I $P($G(^YTT(601.71,TEST,2)),U,2)'="Y" QUIT  ; not active
 . S CAT=0 F  S CAT=$O(^YTT(601.71,TEST,10,CAT)) Q:'CAT  D
 . . S X0=^YTT(601.71,TEST,10,CAT,0)
 . . S NM=^YTT(601.97,+X0,0)
 . . S SORTED(NM)=""
 S NM="" F  S NM=$O(SORTED(NM)) Q:'$L(NM)  S RSP($$NXT)=NM
 Q
INBYCAT(RSP,NM) ; return a list of instruments by category
 N TEST,CAT,SORTED
 S CAT=$O(^YTT(601.97,"B",NM,0)) Q:'CAT
 S TEST=0 F  S TEST=$O(^YTT(601.71,TEST)) Q:'TEST  D
 . I $P($G(^YTT(601.71,TEST,2)),U,2)'="Y" QUIT  ; not active
 . I '$D(^YTT(601.71,TEST,10,"B",CAT)) QUIT     ; not in category
 . S SORTED($P(^YTT(601.71,TEST,0),U))=""
 S RSP(1)="Root="
 S NM="" F  S NM=$O(SORTED(NM)) Q:'$L(NM)  S RSP(1)=RSP(1)_NM_U
 Q

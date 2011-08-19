ORWLRR ;SLC/STAFF- rpc routing for lab results ;4/9/10  12:54
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,280**;Dec 17, 1997;Build 85
 ;
 ; this routine simply routes CPRS rpc calls to the appropriate lab routine
 ;
ALLTESTS(ORY,FROM,DIR) ; from Remote Procedure file
 D ALLTESTS^LR7OGO(.ORY,FROM,DIR)
 Q
 ;
ATESTS(ORY,TEST) ; from Remote Procedure file
 D ATESTS^LR7OGO(.ORY,TEST)
 Q
 ;
ATG(ORY,TESTGP,USER) ; from Remote Procedure file
 D ATG^LR7OGO(.ORY,TESTGP,USER)
 Q
 ;
ATOMICS(ORY,FROM,DIR) ; from Remote Procedure file
 D ATOMICS^LR7OGO(.ORY,FROM,DIR)
 Q
 ;
CHART(ORY,DFN,DATE1,DATE2,SPEC,TEST) ; from Remote Procedure file
 D CHART^LR7OGC(.ORY,DFN,DATE1,DATE2,SPEC,TEST)
 Q
 ;
CHEMTEST(ORY,FROM,DIR) ; from Remote Procedure file
 D CHEMTEST^LR7OGO(.ORY,FROM,DIR)
 Q
 ;
GRID(ORY,DFN,DATE1,DATE2,SPEC,TESTS) ; from Remote Procedure file
 D GRID^ORWLRRG(.ORY,DFN,DATE1,DATE2,SPEC,.TESTS)
 Q
 ;
INTERIM(ORY,DFN,DATE1,DATE2) ; Interim Report RPC (All Tests by Date)
 N ROOT
 S ROOT=$$SET()
 I $$REMOTE(.DFN,.ROOT) D INTERIM^LR7OGM(.ORY,DFN,DATE1,DATE2)
 D CLEAN(.ORY,.ROOT)
 Q
 ;
INTERIMG(ORY,DFN,DATE1,DIR,FORMAT) ; from Remote Procedure file
 D INTERIMG^LR7OGM(.ORY,DFN,DATE1,DIR,$G(FORMAT,1))
 Q
 ;
INTERIMS(ORY,DFN,DATE1,DATE2,ORTESTS) ; from Remote Procedure file
 D INTERIMS^LR7OGM(.ORY,DFN,DATE1,DATE2,.ORTESTS)
 Q
 ;
MICRO(ORY,DFN,DATE1,DATE2) ; Micro Report RPC
 N ROOT
 S ROOT=$$SET()
 I $$REMOTE(.DFN,.ROOT) D MICRO^LR7OGM(.ORY,DFN,DATE1,DATE2)
 D CLEAN(.ORY,.ROOT)
 Q
 ;
NEWOLD(ORY,DFN) ; from Remote Procedure file
 D NEWOLD^LR7OGMU(.ORY,DFN)
 Q
 ;
PARAM(ORY) ; from Remote Procedure file
 D PARAM^LR7OGO(.ORY)
 Q
 ;
SPEC(ORY,FROM,DIR) ; from Remote Procedure file
 D SPEC^LR7OGO(.ORY,FROM,DIR)
 Q
 ;
TG(ORY,USER) ; from Remote Procedure file
 D TG^LR7OGO(.ORY,USER)
 Q
 ;
USERS(ORY,FROM,DIR) ; from Remote Procedure file
 D USERS^LR7OGO(.ORY,FROM,DIR)
 Q
 ;
UTGA(ORY,ORTESTS) ; from Remote Procedure file
 D UTGA^LR7OGO(.ORY,.ORTESTS)
 Q
 ;
UTGD(ORY,TGRP) ; from Remote Procedure file
 D UTGD^LR7OGO(.ORY,TGRP)
 Q
 ;
UTGR(ORY,ORTESTS,TGRP) ; from Remote Procedure file
 D UTGR^LR7OGO(.ORY,.ORTESTS,TGRP)
 Q
 ;
INFO(ORY,ORTEST) ; Get Lab test description info
 I '$L($T(ONE^LR7OR4)) S ORY(1)="Missing lab API (part of patch LR*5.2*256)" Q
 D ONE^LR7OR4(.ORY,.ORTEST)
 Q
REMOTE(DFN,ROOT) ;Setup for remote data
 N REMOTE,ORGO
 S REMOTE=+$P(DFN,";",2),ORGO=1
 I 'REMOTE S DFN=+DFN Q ORGO ;DFN = DFN;ICN for remote calls
 I REMOTE D
 . I '$L($T(GETDFN^MPIF001)) D SETITEM^ORWRP(.ROOT,"MPI routines missing on remote system") S ORGO=0 Q
 . S ICN=+$P(DFN,";",2),DFN=+$$GETDFN^MPIF001(ICN)
 . I DFN<0 D SETITEM^ORWRP(.ROOT,"Patient not found on remote system") S ORGO=0 Q
 . S:'$D(DUZ("AG")) DUZ("AG")="" ;Broker not currently setting agency for remote sites
 Q ORGO
SET() ;Shared setup of ROOT node
 K ^TMP("ORDATA",$J,"OUTPUT")
 S ROOT=$NA(^TMP("ORDATA",$J,"OUTPUT"))
 Q ROOT
CLEAN(ORY,ROOT) ;Shared Clean-up
 I '$O(@ROOT@(0)) S @ROOT@(1)="",@ROOT@(2)="No Data Found"
 I $S($D(ORY):$S('$O(@ORY@(0)):1,1:0),1:$O(@ROOT@(0))) M @ORY=@ROOT
 K ^TMP("ORDATA",$J,"OUTPUT")
 Q

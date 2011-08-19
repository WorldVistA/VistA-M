XTID1 ;OAKCIOFO/JLG - Implementation of API set in XTID ;12/12/2008 15:12
 ;;7.3;TOOLKIT;**93,108**;Apr 25, 1995;Build 3
 ;Per VHA Directive 2004-038, this routine should not be modified
 ; Reference to $$SCREEN^HDISVF01 supported by IA #4640
 Q
GETVUID ;
 ; called from GETVUID^XTID(TFILE,TFIELD,TIREF)
 N CTX,TERM,VUID
 S TFILE=+$G(TFILE),TFIELD=+$G(TFIELD),TIREF=$G(TIREF)
 S:'TFIELD TFIELD=.01
 D CONTEXT^XTIDCTX(TFILE,TFIELD,.CTX)
 Q:'$D(CTX) "0^invalid combination of FILE/FIELD"
 D FINDTERM^XTIDCTX(.CTX,TIREF,.TERM)
 Q:'$D(TERM) "0^TERM IREF doesn't exist in this FILE/FIELD context"
 S VUID=$$GETVUID^XTIDTERM(.TERM)
 Q:'$G(VUID) "0^TERM index did not contain VUID value"
 Q VUID
 ;
GETSTAT ;
 ; called from GETSTAT^XTID(TFILE,TFIELD,TIREF,TDATE)
 N CTX,STATUS,TERM
 S TFILE=+$G(TFILE),TFIELD=+$G(TFIELD),TIREF=$G(TIREF)
 S:'$G(TDATE) TDATE=$$NOW^XLFDT
 S:'TFIELD TFIELD=.01
 D CONTEXT^XTIDCTX(TFILE,TFIELD,.CTX)
 Q:'$D(CTX) "^invalid combination of FILE/FIELD"
 D FINDTERM^XTIDCTX(.CTX,TIREF,.TERM)
 Q:'$D(TERM) "^TERM IREF doesn't exist in this FILE/FIELD context"
 S STATUS=""
 S STATUS=$$GETSTAT^XTIDTERM(.TERM,TDATE)
 Q:STATUS']"" ""
 Q STATUS
 ;
GETMASTR ;
 ; called from GETMASTR^XTID(TFILE,TFIELD,TIREF)
 N CTX,TERM,MASTR
 S TFILE=+$G(TFILE),TFIELD=+$G(TFIELD),TIREF=$G(TIREF)
 S:'TFIELD TFIELD=.01
 D CONTEXT^XTIDCTX(TFILE,TFIELD,.CTX)
 Q:'$D(CTX) "0^invalid combination of FILE/FIELD"
 D FINDTERM^XTIDCTX(.CTX,TIREF,.TERM)
 Q:'$D(TERM) "0^TERM IREF doesn't exist in this FILE/FIELD context"
 S MASTR=""
 S MASTR=$$GETMASTR^XTIDTERM(.TERM)
 Q:MASTR']"" ""
 Q MASTR
 ;
SETVUID ;
 ; called from SETVUID^XTID(TFILE,TFIELD,TIREF,TVUID)
 N CTX,TERM,SUCCESS,OLDVUID
 S TFILE=+$G(TFILE),TFIELD=+$G(TFIELD),TIREF=$G(TIREF),TVUID=$G(TVUID)
 S:'TFIELD TFIELD=.01
 S SUCCESS=0
 D CONTEXT^XTIDCTX(TFILE,TFIELD,.CTX)
 Q:'$D(CTX) "0^invalid combination of FILE/FIELD"
 Q:'$$VALIDREF^XTIDCTX(.CTX,TIREF) "0^TERM IREF doesn't exist in this FILE/FIELD context"
 D FINDTERM^XTIDCTX(.CTX,TIREF,.TERM)
 ;
 ; create new term index entry in "set of codes" not in "tables"
 I '$D(TERM) S SUCCESS=$$NEWTERM^XTIDCTX(.CTX,TIREF,TVUID) Q SUCCESS
 ;
 ; TERM exists
 ; existing entries with empty VUID-related data
 ; determine existing value of VUID
 S OLDVUID=$$GETVUID^XTIDTERM(.TERM)
 I OLDVUID S SUCCESS=$$RPLVUID(OLDVUID,TVUID) Q SUCCESS
 ; 'OLDVUID
 ; set VUID for the first time for existing entry
 S SUCCESS=$$NEWVUID()
 Q SUCCESS
 ;
SETSTAT ;
 ; called from SETSTAT^XTID(TFILE,TFIELD,TIREF,TSTAT,TDATE)
 N CTX,TERM
 S TFILE=+$G(TFILE),TFIELD=+$G(TFIELD),TIREF=$G(TIREF),TSTAT=+$G(TSTAT)
 S:'$G(TDATE) TDATE=$$NOW^XLFDT
 S:'TFIELD TFIELD=.01
 D CONTEXT^XTIDCTX(TFILE,TFIELD,.CTX)
 Q:'$D(CTX) "0^invalid combination of FILE/FIELD"
 D FINDTERM^XTIDCTX(.CTX,TIREF,.TERM)
 Q:'$D(TERM) "0^TERM IREF doesn't exist in this FILE/FIELD context"
 Q:'$$GETVUID^XTIDTERM(.TERM) "0^VUID value must exist before setting STATUS info"
 Q:'$$SETSTAT^XTIDTERM(.TERM,TSTAT,TDATE) "0^unable to set status for the term index"
 Q 1
 ;
SETMASTR ;
 ; called from SETMASTR^XTID(TFILE,TFIELD,TIREF,TMASTER)
 ; constraint: only one entry could be master for given
 ; reference term, must check success after setting master
 N CTX,TERM,NEWMASTR
 S TFILE=+$G(TFILE),TFIELD=+$G(TFIELD),TIREF=$G(TIREF)
 S TMASTER=+$G(TMASTER)
 S:'TFIELD TFIELD=.01
 D CONTEXT^XTIDCTX(TFILE,TFIELD,.CTX)
 Q:'$D(CTX) "0^invalid combination of FILE/FIELD"
 D FINDTERM^XTIDCTX(.CTX,TIREF,.TERM)
 Q:'$D(TERM) "0^TERM IREF doesn't exist in this FILE/FIELD context"
 Q:'$$GETVUID^XTIDTERM(.TERM) "0^VUID value must exist before setting master flag"
 Q:'$$SETMASTR^XTIDTERM(.TERM,TMASTER) "0^unable to set master flag for the term index"
 ; check success based on constraint
 S NEWMASTR=$$GETMASTR^XTID(TFILE,TFIELD,TIREF)
 Q:NEWMASTR'=TMASTER "0^pre-existing master entry"
 Q 1
 ;
GETIREF ; 
 ; called from GETIREF^XTID(TFILE,TFIELD,TVUID,TARRAY,TMASTER)
 N CTX,TERM
 S TFILE=+$G(TFILE),TFIELD=$G(TFIELD),TVUID=$G(TVUID)
 S TMASTER=+$G(TMASTER)
 Q:$G(TARRAY)']""
 D CONTEXT^XTIDCTX(TFILE,TFIELD,.CTX)
 I '$D(CTX) S @TARRAY@("ERROR")="invalid FILE/FIELD combination" Q
 S @TARRAY=0
 D SRCHTRMS^XTIDCTX(.CTX,TVUID,TARRAY,TMASTER)
 Q
 ;
SCREEN ;
 ; called from SCREEN^XTID(TFILE,TFIELD,TIREF,TDATE,TCACHE)
 N ACTIVE,CACHED,SCREEN,STATUS
 S:'$G(TDATE) TDATE=$$NOW^XLFDT
 S TFILE=+$G(TFILE),CACHED=$D(TCACHE(TFILE)) ; cache at file level
 ; screen based on HDI API, use cached value on subsequent calls for same file
 I 'CACHED  D
 . S SCREEN=$$SCREEN^HDISVF01(TFILE,+$G(TFIELD),TDATE)
 . S TCACHE(TFILE)=SCREEN
 E  S SCREEN=TCACHE(TFILE)
 Q:'SCREEN SCREEN
 ; screen based on status in XTID API
 S STATUS=$$GETSTAT^XTID(TFILE,+$G(TFIELD),$G(TIREF),TDATE)
 S ACTIVE=$P(STATUS,"^",1)
 S SCREEN=$SELECT(ACTIVE:0,1:1)
 Q SCREEN
 ;
RPLVUID(OLDV,NEWV) ;
 ; called from SETVUID(TFILE,TFIELD,TIREF,TVUID)
 ; existing TERM index entry with VUID value
 N SUCCESS S SUCCESS=1
 I OLDV=NEWV Q SUCCESS
 ; replace existing VUID value
 I '$$SETVUID^XTIDTERM(.TERM,NEWV) D  Q SUCCESS
 . S SUCCESS="0^unable to replace VUID value to existing term entry" Q
 ;
 Q SUCCESS
 ;
NEWVUID() ;
 ; called from SETVUID(TFILE,TFIELD,TIREF,TVUID)
 ; set VUID value to existing TERM entry
 ; for the first time
 N MASTER,SUCCESS
 S SUCCESS=1,MASTER=1
 I '$$SETVUID^XTIDTERM(.TERM,TVUID) D  Q SUCCESS
 . S SUCCESS="0^unable to add VUID value to existing term entry"
 ;
 ; set master=1 default, will be overridden if duplicate master
 I '$$SETMASTR^XTIDTERM(.TERM,MASTER) D  Q SUCCESS
 . S SUCCESS="0^unable to add MASTER VUID value to existing term entry"
 ;
 Q SUCCESS
 ;

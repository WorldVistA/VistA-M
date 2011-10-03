MAGQBTM ;WOIFO/RMP/JL - REMOTE Task SERVER Program ; 18 Jan 2011 5:07 PM
 ;;3.0;IMAGING;**1,7,8,20,81,39**;Mar 19, 2002;Build 2010;Mar 08, 2011
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
ENTRY(RESULT,WSTAT,PROCESS) ; RPC[MAGQ ABP]
 N X,SYSIEN,SYSNAME,NODE,INDX,CNT,PROC,%,QPTR,QCNT,VERS,EXEDATE,WSOS,PLACE,VOK,EXDATE
 S X="ERR^MAGQBTM",@^%ZOSF("TRAP")
 S (SYSIEN,CNT)=0,SYSNAME="",PLACE=$$PLACE^MAGBAPI(+$G(DUZ(2))),VOK=""
 S $P(RESULT(0),U,6)=$D(^XUSEC("MAG SYSTEM",DUZ))
 Q:'$P(RESULT(0),U,6)
 S VERS=$P(WSTAT,U,2)
 S WSTAT=$P(WSTAT,U)
 S SYSIEN=$O(^MAG(2006.8,"C",PLACE,WSTAT,""))
 I 'SYSIEN S SYSIEN=$O(^MAG(2006.8,"C",PLACE,$$UPPER^MAGQE4(WSTAT),""))
 I 'SYSIEN D
 . N TRY
 . F TRY=1:1:$L(WSTAT,".") D  Q:SYSIEN?1.N
 . . S SYSIEN=$O(^MAG(2006.8,"C",PLACE,$P(WSTAT,".",TRY),""))
 . . I 'SYSIEN S SYSIEN=$O(^MAG(2006.8,"C",PLACE,$$UPPER^MAGQE4($P(WSTAT,".",TRY)),""))
 Q:SYSIEN=""
 S VERS=$P(VERS,".",1,2)_"P"_$P(VERS,".",3)
 D VOKR^MAGQBUT4(.VOK,VERS)
 Q:'$P(VOK,U)
 S NODE=^MAG(2006.8,SYSIEN,0)
 S SYSNAME=$P(NODE,U)
 I SYSNAME="" D  Q
 . S $P(RESULT(0),U,1,2)="-1^No Background Processor parameters on system"
 I $P(NODE,U,12)'=1 D  Q
 . S $P(RESULT(0),U,1,2)="-1^Not assigned as a Background Processor"
 F PROC="ABSTRACT;13","JUKEBOX;14","JBTOHD;15","DELETE;23","PREFET;16","GCC;18","IMPORT;17" D  Q:$P(RESULT(0),U,1)="-1"
 . N PIECE,NAME
 . I $$UBPW^MAGQBUT1(SYSNAME,PROC) D  Q
 . . S $P(RESULT(0),U,1,2)="-1^This BP: "_SYSNAME_" has a co-assigned queue: "_$P(PROC,";")
 . S NAME=$P(PROC,";")
 . S PIECE=$P(PROC,";",2)
 . I $P(NODE,U,PIECE)="1" D
 . . N QCNT,QPTR
 . . D ADD^MAGBAPI(0,NAME,PLACE)
 . . S QPTR=$O(^MAGQUEUE(2006.031,"C",PLACE,NAME,""))
 . . S QCNT=$P($G(^MAGQUEUE(2006.031,+QPTR,0)),U,3)
 . . S CNT=CNT+1
 . . S RESULT(CNT)=NAME_U_QCNT_U_(+$P($G(^MAGQUEUE(2006.031,+QPTR,0)),U,5)-QCNT)
 . . Q
 . Q
 Q:$P(RESULT(0),U,1)="-1"
 S $P(RESULT(0),U,1,5)="0^BP List^PID: "_$$BASE^XLFUTL($J,10,16)_"^"_SYSNAME_U_WSTAT
 Q
GETQUE(RESULT,ACTION) ; RPC[MAGQ GET]
 S X="ERR^MAGQBTM",@^%ZOSF("TRAP")
 N PLACE
 D @(ACTION_"(.RESULT)")
 I +RESULT<0 D  ; Update queue status and increment the Queue pointer if the queue cannot be processed
 . N PLACE S PLACE=$$PLACE^MAGBAPI(+$G(DUZ(2)))
 . D QSTAT($P(RESULT,U,2),$P(RESULT,U,3),ACTION,.PLACE)
 . D QPTER(ACTION,$P(RESULT,U,2),.PLACE)
 Q
ABSTRACT(RESULT) ;
 D DEQUEUE("ABSTRACT",.RESULT) Q
JUKEBOX(RESULT) ;
 D DEQUEUE("JUKEBOX",.RESULT) Q
JBTOHD(RESULT) ;
 D DEQUEUE("JBTOHD",.RESULT) Q
GCC(RESULT) ;
 D DEQUEUE("GCC",.RESULT) Q
DELETE(RESULT) ;
 D DEQUEUE("DELETE",.RESULT) Q
PREFET(RESULT) ;
 D DEQUEUE("PREFET",.RESULT) Q
IMPORT(RESULT) ;
 D DEQUEUE("IMPORT",.RESULT) Q
DEQUEUE(QUE,RESULT) ;
 S X="ERR^MAGQBTM",@^%ZOSF("TRAP")
 N QPTR,QPTR2,ROU,MAGIEN,ZNODE,MSG,IMQUE,PLACE
 S PLACE=$$PLACE^MAGBAPI(+$G(DUZ(2)))
 S QPTR2=$O(^MAGQUEUE(2006.031,"C",PLACE,QUE,""))
 S QPTR=$S(QPTR2:$P(^MAGQUEUE(2006.031,QPTR2,0),U,2),1:"")
 S QPTR=$O(^MAGQUEUE(2006.03,"C",PLACE,QUE,QPTR))
 I QPTR="" D  Q
 . S RESULT="0"_U_QPTR2_U_"No "_QUE_" "_QPTR2_" to process."
 D QSTAT(QPTR,QUE_" in progress.",QUE,.PLACE)
 S ZNODE=$G(^MAGQUEUE(2006.03,QPTR,0))
 I ZNODE="" S RESULT=-101_U_QPTR_U_"Queue Record does not exist" Q
 I QUE="IMPORT" D ENTRY^MAGQBIM(QPTR,QUE,QPTR2,ZNODE,.RESULT) Q
 S MAGIEN=$P(ZNODE,"^",7)
 I ("^DELETE^JUKEBOX^")'[(U_QUE_U),(('(+MAGIEN))!('$D(^MAG(2005,+MAGIEN,0)))!($P(ZNODE,U)'=QUE)) D  Q
 . I $D(^MAG(2005.1,+MAGIEN,0)) D
 . . S MSG="Image Record Deleted and in archive file."
 . E  S MSG="No valid image file number to process."
 . S RESULT=-101_U_QPTR_U_MSG
 S ROU=$$RESET(QUE)
 I ROU="" S RESULT="-1"_U_QPTR_U_QUE_" Is an inactive process" Q
 D @("ENTRY^"_ROU_"(.RESULT,QPTR)")
 Q
QSTAT(QPTR,MESSAGE,ACTION,PLACE) ;Update the Queue status
 N ZNODE,MAGTIME
 Q:QPTR=""
 S MESSAGE=$TR(MESSAGE,":;<>.?/\'()*^%$#@!0123456789","")
 Q:'$D(^MAGQUEUE(2006.03,QPTR,0))
 S ZNODE=$G(^MAGQUEUE(2006.03,QPTR,0))
 S MAGTIME=$$NOW^XLFDT
 S:'$G(PLACE) PLACE=$$QPLACE(ZNODE,QPTR)
 Q:'PLACE
 I $P(ZNODE,U,5)]"" D
 . K ^MAGQUEUE(2006.03,"D",PLACE,$P(ZNODE,U),$E($P(ZNODE,U,5),1,30),QPTR) Q
 S ^MAGQUEUE(2006.03,"D",PLACE,$P(ZNODE,U),$E(MESSAGE,1,30),QPTR)=""
 S $P(^MAGQUEUE(2006.03,QPTR,0),U,5,6)=$P(MESSAGE,U)_U_MAGTIME
 I ACTION["IMPORT" D STAT^MAGQBIM($S($P(ZNODE,U,11)?1N.N:$P(ZNODE,U,11),1:QPTR),MAGTIME,MESSAGE)
 Q
QPLACE(QNODE,PTR) ; Seek alternate PLACE values and update the Queue
 N IEN,VALUE,ACQ
 S VALUE=""
 I +$P(QNODE,U,12) D  Q VALUE
 . S VALUE=+$P(QNODE,U,12) Q
 S IEN=$P(QNODE,U,7) ; try the Image acquisition site
 I IEN?1N.N D
 . S ACQ=+$P($G(^MAG(2005,IEN,100)),U,3)
 . S:'ACQ ACQ=+$P($G(^MAG(2005.1,IEN,100)),U,3)
 . S:ACQ VALUE=$$PLACE^MAGBAPI(ACQ) Q
 S:'VALUE VALUE=$$PLACE^MAGBAPI(+$G(DUZ(2))) ; else the BP User
 S:VALUE $P(^MAGQUEUE(2006.03,PTR,0),U,12)=VALUE
 Q VALUE
QPTER(QUEUE,QPTR,PLACE) ; Conditionally advance the queue pointer & decrement the active queue count
 N QREC,PREV,PNODE
 I 'PLACE D  Q:'PLACE
 . S PLACE=$P($G(^MAGQUEUE(2006.03,QPTR,0)),U,12)
 . S PLACE=$S(PLACE:PLACE,1:$$PLACE^MAGBAPI(+$G(DUZ(2))))
 . Q
 S QREC=$O(^MAGQUEUE(2006.031,"C",PLACE,QUEUE,""))
 S PREV=$S(QREC:$P(^MAGQUEUE(2006.031,QREC,0),U,2),1:"")
 I PREV'=QPTR D  Q
 . D ADD^MAGBAPI(-1,QUEUE,PLACE)
 . L +^MAGQUEUE(2006.031,QREC,0):1E9
 . S $P(^MAGQUEUE(2006.031,QREC,0),U,2)=QPTR,$P(^MAGQUEUE(2006.031,QREC,0),U,6)=$$NOW^XLFDT
 . L -^MAGQUEUE(2006.031,QREC,0)
 . Q
 D ADD^MAGBAPI(0,QUEUE,PLACE)  ; Else reset the active queue count
 Q
RESET(QUEUE) ; Set Routine parameter
 Q:QUEUE="ABSTRACT" "MAGQBAB"
 Q:QUEUE="JUKEBOX" "MAGQBJB"
 Q:QUEUE="JBTOHD" "MAGQBJH"
 Q:QUEUE="DELETE" "MAGQBD"
 Q:QUEUE="PREFET" "MAGQBJH"
 Q:QUEUE="IMPORT" "MAGQBIM"
 Q:QUEUE="GCC" "MAGQBGCC"
 Q ""
QUPDTE(RESULT,QPTR,UPDATE) ;RPC[MAGQ QUD]
 S X="ERR^MAGQBTM",@^%ZOSF("TRAP")
 N NODE,STAT,TYPE,VPTR,MPTR,IEN,IDFN,MSG,PLACE,DA
 S NODE=$G(^MAGQUEUE(2006.03,QPTR,0))
 S PLACE=$P(NODE,U,12)
 S RESULT="1^QUEUE UPDATE COMPLETE"
 S STAT=$P(UPDATE,U)
 S TYPE=$P(NODE,U)
 S MSG=$S($P(UPDATE,U,2)="":TYPE_" Process Error",1:$P(UPDATE,U,2))
 D QSTAT(QPTR,MSG,TYPE,.PLACE)
 D QPTER(TYPE,QPTR,PLACE)
 I STAT<0 Q
 I "^DELETE^"[("^"_TYPE_"^") D DQUE^MAGQBUT2(QPTR) Q
 I "^IMPORT^"[("^"_TYPE_"^") D DQUE^MAGQBUT2(QPTR) Q
 S VPTR=$P(UPDATE,U,3)
 I VPTR?1.N D
 . S MPTR=$P(NODE,U,7)
 . I "^ABSTRACT^"[("^"_TYPE_"^") D  Q
 . . S $P(^MAG(2005,MPTR,0),U,4)=VPTR
 . . S X=$$JUKEBOX^MAGBAPI(MPTR,PLACE)
 . . D DQUE^MAGQBUT2(QPTR) Q
 . I ("^JBTOHD^"[("^"_TYPE_"^"))!("^PREFET^"[("^"_TYPE_"^")) D  Q
 . . I "^FULL^"[$P(NODE,U,8) S $P(^MAG(2005,MPTR,0),U,3)=VPTR
 . . I "^ABSTRACT^"[$P(NODE,U,8) S $P(^MAG(2005,MPTR,0),U,4)=VPTR
 . . I "^BIG^"[$P(NODE,U,8) S $P(^MAG(2005,MPTR,"FBIG"),U)=VPTR
 . . D DQUE^MAGQBUT2(QPTR) Q
 . I "^JUKEBOX^"[("^"_TYPE_"^") D  Q 
 . . I $P(UPDATE,U,2)["BIG" D  Q
 . . . S:$D(^MAG(2005,MPTR)) $P(^MAG(2005,MPTR,"FBIG"),U,2)=VPTR
 . . . S:$D(^MAG(2005.1,MPTR)) $P(^MAG(2005.1,MPTR,"FBIG"),U,2)=VPTR
 . . . D DQUE^MAGQBUT2(QPTR) Q
 . . E  D
 . . . S:$D(^MAG(2005,MPTR)) $P(^MAG(2005,MPTR,0),U,5)=VPTR
 . . . S:$D(^MAG(2005.1,MPTR)) $P(^MAG(2005.1,MPTR,0),U,5)=VPTR
 . . . D DQUE^MAGQBUT2(QPTR) Q
 . . Q
 . I "^GCC^"[("^"_TYPE_"^") D  Q
 . . S FDA(2005.01,"+1,"_MPTR_",",.01)=VPTR
 . . S FDA(2005.01,"+1,"_MPTR_",",1)=$$NOW^XLFDT
 . . S FDA(2005.01,"+1,"_MPTR_",",2)=$P($$TRIM^MAGQBUT4($P(UPDATE,U,2))," ")
 . . D UPDATE^DIE("U","FDA","","MAGIMP")
 . . K FDA
 . . S IDFN=$P(^MAG(2005,MPTR,0),U,7)
 . . D ENTRY^MAGLOG("EXPORT->"_$P($G(^MAG(2005.2,VPTR,0)),U,2),$P(NODE,U,2),MPTR,"Document Imaging",IDFN,0)
 . . D DQUE^MAGQBUT2(QPTR) Q
 . Q
 Q
REQUE(RESULT,QPTR) ;
 ; RPC[MAGQ REQ]
 N PROC,NODE,INDX,PARAM,OPDUZ,STATUS,TRACKID,PLACE,X
 S X="ERR^MAGQBTM",@^%ZOSF("TRAP")
 S INDX=$$TRIM^MAGQBUT4(QPTR),TRACKID=0
 S NODE=$G(^MAGQUEUE(2006.03,INDX,0))
 Q:NODE']""
 S PLACE=$P(NODE,U,12)
 Q:'PLACE
 S PROC=$P(NODE,U),STATUS=$P(NODE,U,5)
 I PROC'="IMPORT" D
 . D RQP(PROC,NODE,.PARAM)
 . S @("RESULT=$$"_PROC_"^MAGBAPI(PARAM,PLACE)")
 . Q
 E  D  Q  ;IMPORT - Doesn't De-queue Import and Session file
 . S $P(PARAM,U,3)=+$P(NODE,U,9)+1
 . S $P(PARAM,U,4)=$S($P(NODE,U,11)?1N.N:$P(NODE,U,11),1:QPTR)
 . D TIDL^MAGQBIM($S($P(NODE,U,11)?1N.N:$P(NODE,U,11),1:QPTR),PROC,.TRACKID)
 . Q:TRACKID=0
 . S @("RESULT=$$"_PROC_"^MAGBAPI(PARAM,$P(NODE,U,10),TRACKID,PLACE)")
 . D DQUE^MAGQBUT2(INDX,"1")
 . Q
 D DQUE^MAGQBUT2(INDX)
 Q
RQP(P,N,PAR) ;
 N P1,P2,P3,P4
 I ("^JBTOHD^PREFET^")[P S P1=$P(N,U,7),P2=$P(N,U,8),P3=+$P(N,U,9)+1,PAR=P1_U_P2_U_P3 Q
 I P["DELETE" S P1=$P(N,U,10),P2=+$P(N,U,9)+1,PAR=P2_U_P1 Q
 I P["GCC" D  Q
 . S P1=$P(N,U,7),P2=$P(N,U,10),P3=$P(N,U,11),P4=$P(N,U,9)+1,PAR=P1_U_P2_U_P3_U_P4 Q
 S P1=$P(N,U,7)_"^^",P2=+$P(N,U,9)+1,PAR=P1_P2 ;JUKEBOX + ABSTRACT
 Q
ERR ;
 N ERRXX
 S ERRXX=$$EC^%ZOSV
 D ^%ZTER
 D ^XUSCLEAN
 Q

MAGBAPI ;WOIFO/PMK,RMP,SEB,MLH - Background Processor API to build queues ; 27 Aug 2014 5:12 PM
 ;;3.0;IMAGING;**1,7,8,20,39,154**;Mar 19, 2002;Build 9;Mar 08, 2011
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
 ; The API returns the entry's queue pointer
 ;
ABSTRACT(INPUT,PLACE) ; Entry point to create an image abstract
 ; input = image pointer
 Q:$$IMOFFLN^MAGFILEB($P($G(^MAG(2005,INPUT,0)),U,2)) 0
 S PLACE=$$GETPLACE($G(PLACE)) Q:'PLACE 0 ; DBI - SEB Patch 4
 Q $$QUEUE("ABSTRACT",INPUT,PLACE)
 ;
GCC(INPUT,PLACE) ; Entry point to create an Document Imaging Export Copy
 ; input = image pointer(^Second Piece Optional Location specified^3rd optional extension(s) specifier
 ; plus "~" separated alternate source file types
 S PLACE=$$GETPLACE($G(PLACE)) Q:'PLACE 0 ; DBI - SEB Patch 4
 Q $$QUEUE("GCC",$P(INPUT,"^")_"^^"_$P(INPUT,"^",4)_"^"_$P(INPUT,"^",2,3),PLACE)
JUKEBOX(INPUT,PLACE) ; Entry point to copy an image file and abstract to the Jukebox / input = image pointer
 N NEXT,CONS,GB
 S GB=$G(^MAG(2005,+$P(INPUT,U),0))
 S:GB="" GB=$G(^MAG(2005.1,+$P(INPUT,U),0))
 Q:GB="" 0
 Q:$$IMOFFLN^MAGFILEB($P(GB,U,2)) 0
 S PLACE=$$GETPLACE($G(PLACE)) Q:'PLACE 0 ; DBI - SEB Patch 4
 S CONS=$$CONSOLID()
 S NEXT=$O(^MAGQUEUE(2006.03,"E",PLACE,$P(INPUT,"^"),$$NEXTQ("JUKEBOX",PLACE)))
 Q:NEXT?1N.N NEXT
 S NEXT=$$QUEUE("JUKEBOX",INPUT,PLACE)
 Q:'NEXT NEXT
 S ^MAGQUEUE(2006.03,"E",PLACE,$P(INPUT,"^"),NEXT)=""
 Q NEXT
DELETE(INPUT,PLACE) ; Entry point to delete a file (literally from anywhere) / input = full path of file to delete
 N IMOD
 S IMOD=$S(INPUT[U:"^^"_INPUT,1:"^^^"_INPUT)
 S PLACE=$$GETPLACE($G(PLACE)) Q:'PLACE 0 ; DBI - SEB Patch 4
 Q $$QUEUE("DELETE",IMOD,PLACE) ;SETS 9TH & 10TH PIECE
IMPORT(INPUT,CALLBACK,TRACKID,PLACE) ; Entry point to import a file
 ; input = Image Parameter Array
 N QUEIEN,INDX,FDA,DINUM,MS1,CT,REQUE,TMP
 S PLACE=$$GETPLACE($G(PLACE)) Q:'PLACE "0^Missing PLACE parameter" ; DBI - SEB Patch 4
 S REQUE=$S($P($G(INPUT),"^",3)'?1N.N:0,1:1)
 I REQUE=0 Q:($O(^MAG(2006.041,"C",TRACKID,""))?1N.N) "0^Duplicate Tracking ID"
 S QUEIEN=$$QUEUE("IMPORT","^^"_$P($G(INPUT),"^",3)_U_$TR(CALLBACK,"^","|")_U_$P($G(INPUT),"^",4),PLACE)
 I REQUE=0 D
 . S $P(^MAGQUEUE(2006.03,QUEIEN,0),"^",11)=QUEIEN
 . S (DINUM,X)=QUEIEN,DIC="^MAG(2006.034,",DLAYGO="2006.034",DIC(0)="L"
 . K D0
 . D FILE^DICN
 . K DIC,D0,DLAYGO
 . S CT=0
 . D CONV^MAGQBUT4(.INPUT,.CT)
 . D MRGMULT^MAGQBUT4(.INPUT,"^MAG(2006.034,"_QUEIEN_",1,","2006.341A",CT)
 . Q
 K DIE,FDA
 S FDA(2006.041,"+1,",.01)=$S(REQUE=0:QUEIEN,1:$P($G(INPUT),"^",4))
 S FDA(2006.041,"+1,",.02)=TRACKID
 S FDA(2006.041,"+1,",1)=$S(REQUE=0:"QUEUING",1:"REQUEUING")
 S FDA(2006.041,"+1,",2)=$$NOW^XLFDT
 D UPDATE^DIE("U","FDA","","MAGIMP")
 I $D(DIERR) S TMP=MAGIMP("DIERR",1,"TEXT",1) K DIERR,MAGIMP
 Q $S($D(TMP):"0^"_TMP,1:QUEIEN)
 ;
JBTOHD(INPUT,PLACE) ; Entry point to copy an image from the Jukebox to the Hard Disk
 ; input = image pointer ^ FULL or ABSTRACT or BIG
 N NEXT,IEN,JDTYPE,CONS
 S IEN=$P(INPUT,"^"),JDTYPE=$P(INPUT,"^",2)
 Q:$$IMOFFLN^MAGFILEB($P($G(^MAG(2005,IEN,0)),U,2)) 0
 I 'PLACE S PLACE=$$DA2PLC^MAGBAPIP(IEN,$S(JDTYPE["ABSTRACT":"A",JDTYPE["BIG":"B",1:"F"))
 E  S PLACE=$$GETPLACE($G(PLACE)) Q:'PLACE 0 ; DBI - SEB Patch 4
 S NEXT=$O(^MAGQUEUE(2006.03,"F",PLACE,IEN,JDTYPE,$$NEXTQ("JBTOHD",PLACE)))
 Q:NEXT?1N.N NEXT
 S NEXT=$$QUEUE("JBTOHD",INPUT,PLACE)
 Q:'NEXT NEXT
 S ^MAGQUEUE(2006.03,"F",PLACE,$P(INPUT,"^"),$P(INPUT,"^",2),NEXT)=""
 Q NEXT
 ;
PREFET(INPUT,PLACE) ;
 ; input = image pointer ^ FULL or ABSTRACT or BIG
 N NEXT,IEN,JDTYPE,CONS
 S IEN=$P(INPUT,"^"),JDTYPE=$P(INPUT,"^",2)
 Q:$$IMOFFLN^MAGFILEB($P($G(^MAG(2005,IEN,0)),U,2)) 0
 I 'PLACE S PLACE=$$DA2PLC^MAGBAPIP(IEN,$S(JDTYPE["ABSTRACT":"A",JDTYPE["BIG":"B",1:"F"))
 E  S PLACE=$$GETPLACE($G(PLACE)) Q:'PLACE 0 ; DBI - SEB Patch 4
 S IEN=$P(INPUT,"^"),JDTYPE=$P(INPUT,"^",2)
 S NEXT=$O(^MAGQUEUE(2006.03,"F",PLACE,IEN,JDTYPE,$$NEXTQ("PREFET",PLACE)))
 Q:NEXT?1N.N NEXT
 S NEXT=$$QUEUE("PREFET",INPUT,PLACE)
 Q:'NEXT NEXT
 S ^MAGQUEUE(2006.03,"F",PLACE,$P(INPUT,"^"),$P(INPUT,"^",2),NEXT)=""
 Q NEXT
 ;
EVAL(IMAGE,PLACE) ; Entry point for before rules are evaluated
 S PLACE=$$GETPLACE($G(PLACE)) Q:'PLACE 0 ; DBI - SEB Patch 4
 Q $$QUEUE("EVAL",IMAGE,PLACE)
 ;
NEXTQ(TYPE,PLACE) ;
 N X
 S PLACE=$$GETPLACE($G(PLACE)) Q:'PLACE 0 ; DBI - SEB Patch 4
 S X=$O(^MAGQUEUE(2006.031,"C",PLACE,TYPE,""))
 Q $S('X:X,1:$P(^MAGQUEUE(2006.031,X,0),"^",2))
 ;
QUEUE(Q,INPUT,PLACE) ; Stuff the entry (header + INPUT) into the appropriate queue (Q)
 N MAGTIME,QPTR,QTR,X,Y,STATUS,AQSQ
 S U="^",STATUS="NOT_PROCESSED"
 S PLACE=$$GETPLACE($G(PLACE)) Q:'PLACE 0 ; DBI - SEB Patch 4
 Q:(((Q'["DELETE")&(Q'["IMPORT"))&($P(INPUT,U,1)'?1N.N)) 0
 ; increment the QPTR
 L +^MAGQUEUE(2006.03,0):1E9
 S X=^MAGQUEUE(2006.03,0)
 S QPTR=$O(^MAGQUEUE(2006.03," "),-1)+1
 S QPTR=$S(QPTR'>+$P(X,U,3):$P(X,U,3)+1,1:QPTR)  ;p154
 S AQSQ=$O(^MAG(2006.041,"B"," "),-1)+1          ;p154
 I AQSQ>QPTR S QPTR=AQSQ                         ;p154
 S $P(X,"^",3)=QPTR,$P(X,"^",4)=$P(X,"^",4)+1
 S ^MAGQUEUE(2006.03,0)=X
 S MAGTIME=$$NOW^XLFDT
 S ^MAGQUEUE(2006.03,QPTR,0)=Q_"^"_$G(DUZ)_"^"_^%ZOSF("VOL")_"^"_MAGTIME_"^"_STATUS_"^"_MAGTIME_"^"_INPUT
 S ^MAGQUEUE(2006.03,"C",PLACE,Q,QPTR)="",$P(^MAGQUEUE(2006.03,QPTR,0),"^",12)=PLACE
 S ^MAGQUEUE(2006.03,"D",PLACE,Q,STATUS,QPTR)=""
 L -^MAGQUEUE(2006.03,0)
 D ADD(1,Q,PLACE)
 Q QPTR
ADD(N,QUEUE,PLACE) ;
 ;
 N CNT,D0,I,X,CONS,PREV,QTOT
 S PLACE=$$GETPLACE($G(PLACE)) Q:'PLACE 0
 S D0=$O(^MAGQUEUE(2006.031,"C",PLACE,QUEUE,""))
 D:'D0
 . L +^MAGQUEUE(2006.031):1E9
 . S D0=$O(^MAGQUEUE(2006.031," "),-1)+1
 . S ^MAGQUEUE(2006.031,D0,0)=QUEUE_"^0^0^"_PLACE_U
 . S ^MAGQUEUE(2006.031,"C",PLACE,QUEUE,D0)=""
 . S X="IMAGE BACKGROUND QUEUE POINTER^2006.031^"_D0_"^"_D0
 . S ^MAGQUEUE(2006.031,0)=X
 . L -^MAGQUEUE(2006.031)
 . Q
 L +^MAGQUEUE(2006.031,D0):1E9
 S X=^MAGQUEUE(2006.031,D0,0),CNT=$P(X,U,3),PREV=$P(X,U,2),QTOT=$P(X,U,5)
 I CNT?1.N S CNT=CNT+N
 E  D
 . S I=$P(X,"^",2),CNT=0
 . F  S I=$O(^MAGQUEUE(2006.03,"C",PLACE,QUEUE,I)) Q:I'?1N.N  S CNT=CNT+1
 . Q
 S $P(X,U,4)=PLACE
 S:N>0 QTOT=QTOT+N
 ; In order to avoid the new queue from being skipped...
 I QUEUE'["IMPORT",$D(QPTR),QPTR<(PREV+1) S $P(X,"^",2)=QPTR-1,$P(X,"^",6)=$$NOW^XLFDT
 S $P(X,U,3)=CNT,$P(X,U,5)=QTOT,^MAGQUEUE(2006.031,D0,0)=X
 L -^MAGQUEUE(2006.031,D0)
 Q
CWL(PLACE) ;Current Write Location
 S PLACE=$$GETPLACE($G(PLACE)) Q:'PLACE 0 ; DBI - SEB Patch 4
 Q $P($G(^MAG(2006.1,PLACE,0)),"^",3)
PLACE(IEN) ;
 Q $$GETPLACE(+$O(^MAG(2006.1,"B",IEN,"")))
JBPTR(PLACE) ;Current JukeBox Pointer
 S PLACE=$$GETPLACE($G(PLACE)) Q:'PLACE 0 ; DBI - SEB Patch 4
 Q $P($G(^MAG(2006.1,PLACE,1)),"^",6)
GETPLACE(PLACE) ; Validate place
 N SP
 S SP=$G(PLACE)
 S PLACE=+$S($$CONSOLID():+$G(PLACE),1:$O(^MAG(2006.1," "),-1))
 I PLACE,$P($G(^MAG(2006.1,PLACE,0)),"^",1)="" S PLACE=0
 I 'PLACE,$$MAXREP(10) D
 . N I,MSG,S,T,J,PS
 . S PS=$O(^MAG(2006.1,"B",$$KSP^XUPARAM("INST"),"")) ; PLACE of the VistA host system
 . S MSG="Application process failure"
 . S I=1,MSG(I)="Cannot determine 'place' (location, division, institution) for image."
 . S I=1,MSG(I)=" Production Account: "_$$PROD^XUPROD("1")
 . S T=$J("At",11) F S=$ST-1:-1:0 D
 . . S I=I+1,MSG(I)=T_": "_$ST(S,"PLACE")_" = "_$ST(S,"MCODE"),T="Called From"
 . . Q
 . I $D(MAGARRAY) D
 . . S J="",I=I+1,MSG(I)="MAGARRAY"
 . . F  S J=$O(MAGARRAY(J)) Q:J=""  D
 . . . S I=I+1,MSG(I)="MAGARRAY("_J_")"_MAGARRAY(J)
 . . Q
 . I $D(XWBTBUF) S I=I+1,MSG(I)="XWBTBUF: "_XWBTBUF
 . I $D(MAGDA) S I=I+1,MSG(I)="MAGDA: "_MAGDA
 . I $D(MAGGDA) S I=I+1,MSG(I)="MAGGDA: "_MAGGDA
 . I $D(MAGGIEN("1")) S I=I+1,MSG(I)="MAGGIEN(""1""): "_MAGGIEN("1")
 . S:$G(DUZ) I=I+1,MSG(I)="The USER was: "_$$GET1^DIQ(200,DUZ,".01","E")_" DUZ: "_DUZ
 . S:$G(DUZ(2)) I=I+1,MSG(I)="The USER had a DUZ(2) setting of: "_DUZ(2)
 . S I=I+1,MSG(I)="The original value of the INPUT Parameter 'PLACE' was: "_SP
 . S I=I+1,MSG(I)="This fault may result in the failure to archive or process images."
 . S I=I+1,MSG(I)="The users site of origin needs to have an Associated Institution value"
 . S I=I+1,MSG(I)="setup on the Site Parameters window."
 . S I=I+1,MSG(I)="refer to the BP User manual for instructions."
 . S I="" F  S I=$O(MSG(I)) Q:I=""  D DFNIQ^MAGQBPG1("",MSG(I),0,PS,"$$GETPLACE_MAGBAPI")
 . D DFNIQ^MAGQBPG1("",MSG,1,PS,"$$GETPLACE_MAGBAPI")
 . Q
 Q PLACE
MAXREP(MAX) ;
 N REP,CNT
 I $P($G(^MAG(2006.1,"WARNING","MAGBAPI")),U,1)=$$DT^XLFDT D
 . S CNT=+$P($G(^MAG(2006.1,"WARNING","MAGBAPI")),U,2)+1
 . S REP=$S(CNT<MAX:1,1:0)
 . S $P(^MAG(2006.1,"WARNING","MAGBAPI"),U,2)=CNT
 . Q
 E  D
 . I $D(^MAG(2006.1,"WARNING","MAGBAPI")) D
 . . N I,MSG,PS
 . . S PS=$O(^MAG(2006.1,"B",$$KSP^XUPARAM("INST"),""))
 . . S MSG="Application process failure Count"
 . . S I=1,MSG(I)="On the following date: "_$P(^MAG(2006.1,"WARNING","MAGBAPI"),U,1)
 . . S I=I+1,MSG(I)=$P(^MAG(2006.1,"WARNING","MAGBAPI"),U,2)_" were logged on the host system"
 . . S I=I+1,MSG(I)="The Vista Imaging Development and support team is being notified."
 . . S I="" F  S I=$O(MSG(I)) Q:I=""  D DFNIQ^MAGQBPG1("",MSG(I),0,PS,"$$GETPLACE_MAGBAPI")
 . . D DFNIQ^MAGQBPG1("",MSG,1,PS,"$$GETPLACE_MAGBAPI")
 . . Q
 . S REP=1,$P(^MAG(2006.1,"WARNING","MAGBAPI"),U,1,2)=$$DT^XLFDT_U_1
 . Q
 Q REP
CWG(PL) ;Returns the Current RAID Group
 Q $P($G(^MAG(2006.1,PL,0)),U,10)
CONSOLID() ;
 Q $GET(^MAG(2006.1,"CONSOLIDATED"))="YES"
CONRPC(RESULT) ;[MAGG CONS]
 S RESULT=$$CONSOLID^MAGBAPI()
 Q
PLACER(RESULT) ;[MAGG PLACE]
 S RESULT=$$PLACE^MAGBAPI(+$G(DUZ(2)))
 Q
 ;

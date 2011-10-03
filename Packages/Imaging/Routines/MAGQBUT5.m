MAGQBUT5 ;WOIFO/RMP - BP Utilities ; 18 Jan 2011 5:19 PM
 ;;3.0;IMAGING;**20,81,39**;Mar 19, 2002;Build 2010;Mar 08, 2011
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
AI(RESULT) ; List of Associated Institution candidates;
 N INDEX,INST,J,K,L,OUT
 S K=0
 S RESULT(K)=""
 S K=K+1
 D LIST^DIC(40.8,,".01;.07I",,,,,,,,"OUT")
 S RESULT(K)="The following Medical Center Divisions have Imaging Site Parameters defined on ",K=K+1
 S RESULT(K)="your system:" D
 . S INDEX=0,K=K+1 F  S INDEX=INDEX+1 Q:'$D(OUT("DILIST","ID",INDEX))  D
 . . S INST=OUT("DILIST","ID",INDEX,.07),J=0 F  S J=$O(^MAG(2006.1,J)) Q:'J  I $P(^MAG(2006.1,J,0),U)=INST D  Q
 . . . S RESULT(K)=OUT("DILIST","ID",INDEX,.01)_" "_INST,K=K+1 Q
 . . Q
 . Q
 I INDEX=1 S RESULT(K)="None",K=K+1
 S RESULT(K)="The following Medical Center Divisions have 'Associated Institutions' defined on ",K=K+1
 S RESULT(K)="your system:" D
 . S INDEX="",K=K+1,L=K  F  S INDEX=$O(^MAG(2006.1,"B",INDEX)) Q:'INDEX  D
 . . Q:$P($G(^MAG(2006.1,$O(^MAG(2006.1,"B",INDEX,"")),0)),U)=INDEX
 . . S RESULT(K)=$P($G(^DIC(4,INDEX,0)),U)_" "_INDEX,K=K+1 Q
 . Q
 I K=L S RESULT(K)="None",K=K+1
 S RESULT(K)="The following Medical Center Divisions have NO Imaging parameter affiliations ",K=K+1
 S RESULT(K)="defined on your system:" D
 . S INDEX=0,K=K+1,L=K F  S INDEX=INDEX+1 Q:'$D(OUT("DILIST","ID",INDEX))  D
 . . S INST=OUT("DILIST","ID",INDEX,.07) Q:$D(^MAG(2006.1,"B",INST))  D
 . . . S RESULT(K)=OUT("DILIST","ID",INDEX,.01)_" "_INST,K=K+1 Q
 . . Q
 . Q
 I K=L S RESULT(K)="None",K=K+1
 K OUT
 D CLEAN^DILF
 Q
PLNM(PLACE) ;  Returns the Institution name of the Place
 N INST
 Q:'PLACE " "
 S INST=$P($G(^MAG(2006.1,PLACE,0)),U)
 Q $P($G(^DIC(4,INST,0)),U)
TPMESS(PLACE) ;Trigger a purge message
 N Y,LOC,CNT,XMSUB
 S Y=$$FMTE^XLFDT($$NOW^XLFDT)
 S LOC=$$KSP^XUPARAM("WHERE")
 S CNT=1,^TMP($J,"MAGQ",CNT)="SITE: "_LOC
 S CNT=CNT+1,^TMP($J,"MAGQ",CNT)="DATE: "_Y_" "_$G(^XMB("TIMEZONE"))
 S CNT=CNT+1,^TMP($J,"MAGQ",CNT)="SENDER: "_$$PLNM^MAGQBUT5(PLACE)_" Imaging Background Processor"
 S CNT=CNT+1,^TMP($J,"MAGQ",CNT)="An automatic purge event has been initiated"
 S CNT=CNT+1,^TMP($J,"MAGQ",CNT)="in order to maintain adequate image storage"
 S CNT=CNT+1,^TMP($J,"MAGQ",CNT)="no operator intervention is required."
 S XMSUB="VistA Imaging BP Queue processor - Autopurge"
 D MAILSHR^MAGQBUT1(PLACE,"AUTOPURGE",XMSUB)
 D UDMI^MAGQBUT5("VistA Imaging BP Queue processor - Autopurge",PLACE)
 Q
ADDMG(SUB,XMY,PLACE) ; Provide an array of Message Recipients for Message Subject
 N INDEX,IEN,GROUP,NAME,J,K,L,KEY
 S SUB=$TR(SUB," ","_")
 S XMY("G.MAG SERVER")=""
 S INDEX="" F  S INDEX=$O(^MAG(2006.1,PLACE,6,"B",INDEX)) Q:INDEX=""  D
 . Q:SUB'[INDEX
 . S J=$O(^MAG(2006.1,PLACE,6,"B",INDEX,"")) ; first add Mail Groups
 . S K=0 F  S K=$O(^MAG(2006.1,PLACE,6,J,1,"B",K)) Q:'K  D
 . . Q:'$$GOTLOCAL^XMXAPIG(K,"")
 . . S NAME="G."_$$GET1^DIQ(3.8,K,.01,"E")
 . . S XMY(NAME)=""
 . . Q
 . I +$P($G(^MAG(2006.1,PLACE,6,J,3,0)),U,4) D  ; next add Mail Message members
 . . S K=0 F  S K=$O(^MAG(2006.1,PLACE,6,J,3,"B",K)) Q:'K  D
 . . . Q:'+$$ACTIVE^XUSER(K)
 . . . S XMY(K)=""
 . . . Q
 . . Q
 . I +$P($G(^MAG(2006.1,PLACE,6,J,4,0)),U,4) D  ; next add designated Security Key holders
 . . S K=0 F  S K=$O(^MAG(2006.1,PLACE,6,J,4,"B",K)) Q:'K  D
 . . . S KEY=$P($G(^DIC(19.1,K,0)),U,1) Q:KEY=""
 . . . S L="" F  S L=$O(^XUSEC(KEY,L)) Q:'L  D
 . . . . Q:'+$$ACTIVE^XUSER(L)
 . . . . S XMY(L)=""
 . . . . Q
 . . . Q
 . . Q
 . Q
 Q
GETMI(SUB,PLACE) ; Provide the message interval assigned to this message type
 N INDEX,RETURN,IEN,IENS
 S RETURN=0
 S SUB=$TR(SUB," ","_")
 S INDEX="" F  S INDEX=$O(^MAG(2006.1,PLACE,6,"B",INDEX)) Q:INDEX=""  D
 . Q:SUB'[INDEX
 . S IEN=$O(^MAG(2006.1,PLACE,6,"B",INDEX,""))
 . S IENS=IEN_","_PLACE_","
 . S RETURN=$$GET1^DIQ(2006.166,IENS,1)_U_$$GET1^DIQ(2006.166,IENS,3,"I")
 Q $S('RETURN:0,1:RETURN)
 ;
UDMI(SUB,PLACE) ; Update DATE OF LAST MESSAGE
 N INDEX,RETURN,IEN
 S RETURN=0
 S SUB=$TR(SUB," ","_")
 S INDEX="" F  S INDEX=$O(^MAG(2006.1,PLACE,6,"B",INDEX)) Q:INDEX=""  D  Q:RETURN
 . Q:SUB'[INDEX
 . S IEN=$O(^MAG(2006.1,PLACE,6,"B",INDEX,""))
 . S $P(^MAG(2006.1,PLACE,6,IEN,2),U,1)=$$NOW^XLFDT
 . S RETURN="1"
 . Q
 Q RETURN
 ;
RMRPC(NAME) ; Removing an RPC in order to revise
 N MW,RPC,MWE,DIERR,DA,DIK
 S MW=$$FIND1^DIC(19,"","X","MAG WINDOWS","","","")
 D CLEAN^DILF
 S RPC=$$FIND1^DIC(8994,"","X",NAME,"","","")
 D CLEAN^DILF
 Q:'RPC
 I MW D
 . S MWE=$$FIND1^DIC(19.05,","_MW_",","X",NAME,"","","")
 . D CLEAN^DILF
 . Q:'MWE
 . S DA=MWE,DA(1)=MW,DIK="^DIC(19,"_DA(1)_",""RPC"","
 . D ^DIK
 . K DA,DIK
 . Q
 S DA=RPC,DIK="^XWB(8994,"
 D ^DIK
 K DA,DIK
 Q
MOVE(RESULT,FNAM) ;[MAGQ MOVE]
 N IEN,FTYPE,NMSPC,SITEID,EXT,ALT,J,X
 S X="ERR^MAGQBTM",@^%ZOSF("TRAP")
 S NMSPC=$TR($P(FNAM,"."),"0123456789","")
 S SITEID=$$INIS^MAGQBPG2($$PLACE^MAGBAPI(+DUZ(2)))
 I SITEID'[(","_NMSPC_",") D  Q
 . S RESULT="0^Invalid Imaging Namespace"
 S IEN=$O(^MAG(2005,"F",$P(FNAM,"."),""))
 I IEN'?1N.N!('$D(^MAG(2005,IEN,0))) D  Q
 . S RESULT="0^No matching 2005 entry"
 S EXT=$P(FNAM,".",2)
 I $P($G(^MAG(2005,IEN,0)),U,2)[FNAM S RESULT=IEN_U_"FULL"
 E  D
 . S FTYPE=$$FTYPE^MAGQBPRG(EXT,IEN)
 . I FTYPE="FULL" D  Q
 . . D FTYPE(.ALT)
 . . S J=""
 . . F  S J=$O(ALT(J)) Q:J'?1N.N  S:ALT(J)[EXT FTYPE="ALT"
 . . I FTYPE["ALT" S RESULT=IEN_U_FTYPE
 . . E  S RESULT="0^Invalid File Extension"
 . E  S RESULT=IEN_U_FTYPE
 Q
QRNGE(RESULT,QUEUE,PROC,START,STOP,PLACE) ;
 ;[MAGQ QRNGE] Requeue/Dequeue a Range of Queues
 N XX,CNT,TMP,QP,X,PART
 S X="ERR^MAGQBTM",@^%ZOSF("TRAP")
 S CNT=0,TMP=""
 S PLACE=$P($G(^MAGQUEUE(2006.03,START,0)),U,12)
 Q:'PLACE
 S XX=+$O(^MAGQUEUE(2006.03,"C",PLACE,QUEUE,START),-1)
 F  S XX=$O(^MAGQUEUE(2006.03,"C",PLACE,QUEUE,XX)) Q:'XX  Q:XX>(STOP)  D
 . S CNT=CNT+1
 . D:PROC="DEL"
 . . S QP=$O(^MAGQUEUE(2006.031,"C",PLACE,QUEUE,""))
 . . S PART=$S(QP:$P(^MAGQUEUE(2006.031,QP,0),U,2),1:"")
 . . I XX>PART D ADD^MAGBAPI(-1,QUEUE,PLACE)
 . . D DQUE^MAGQBUT2(XX)
 . . Q
 . D:PROC="REQ" REQUE^MAGQBTM(.TMP,XX)
 . Q
 S RESULT=CNT
 Q
UAT(RESULT,PLACE) ; to support and maintain a dummy BP workstation with unassigned workstation tasks - future RPC
 ;AUTO PURGE(3), AUTO VERIFY(4), ABSTRACT(12), JUKEBOX(13), JBTOHD(14), PREFET(15), IMPORT(16), GCC(17), DELETE(20)
 N WSIEN,TASKS,WS,UAT,NODE,PIECE,FIELD,ASSIGNED,I
 ; Remove and re-build unassigned task entry
 S I=0 F  S I=$O(^MAG(2006.8,I)) Q:'I  S NODE=$G(^MAG(2006.8,I,0)) D
 . Q:$P(NODE,U)'="UAT"
 . Q:$P(NODE,U,2)'=PLACE
 . S DIK="^MAG(2006.8,",DA=I
 . D ^DIK
 . K DIK
 . Q 
 S RESULT="1"
 D:'$D(^MAG(2006.8,"C",PLACE,"Unassigned Tasks")) CUAT(PLACE)
 S UAT=$O(^MAG(2006.8,"C",PLACE,"Unassigned Tasks",""))
 F FIELD=3,4,12,13,14,15,16,17,20 D
 . S (ASSIGNED,WS)=""
 . F  S WS=$O(^MAG(2006.8,"C",PLACE,WS)) Q:WS=""  D  Q:ASSIGNED
 . . S WSIEN=$O(^MAG(2006.8,"C",PLACE,WS,""))
 . . S ASSIGNED=+$$GET1^DIQ(2006.8,WSIEN_",",FIELD,"I","","")
 . . Q
 . I 'ASSIGNED S FDA(2006.8,UAT_",",FIELD)="1"
 . Q
 I $D(FDA) D FILE^DIE("","FDA","FDAIEN")
 K FDA,FDAIEN
 Q RESULT
CUAT(PLACE) ;
 N CUATFDA
 S CUATFDA(10,2006.8,"+1,",.01)="UAT"
 S CUATFDA(10,2006.8,"+1,",.04)=PLACE
 S CUATFDA(10,2006.8,"+1,",50)="Unassigned Tasks"
 D UPDATE^DIE("","CUATFDA(10)","FDAIEN")
 K CUATFDA
 Q
FINDC(RESULT,FNUM,IENS,FLAG,FNDVALUE,XREF,SCREEN) ; [MAGQ FINDC] Find with Compound Index - uses key field lookup
 ;    function Find1(FNum,IENS,Flag,FndValue,XREF,Screen:string;silent:boolean): string;
 N VALUE,INDEX
 F INDEX=1:1:$L(FNDVALUE,U) S VALUE(INDEX)=$P(FNDVALUE,U,INDEX)
 S RESULT=$$FIND1^DIC(FNUM,IENS,FLAG,.VALUE,XREF,SCREEN,"FNDERR")
 K FNDERR
 Q RESULT
CRG(PL,RG) ; Count RAID groups by place
 N CNT,I,J,NODE,NV
 S I=RG,CNT=0,NV=""
 F  S I=$O(^MAG(2005.2,"B",I)) Q:I=""  Q:($E(I,1,$L(RG))'[RG)  D
 . S J=$O(^MAG(2005.2,"B",I,"")) Q:'J  S NODE=$G(^MAG(2005.2,J,0)) D  Q:NV'=""
 . . Q:$P(NODE,"^",10)'=PL  ; Screen on Place
 . . S CNT=CNT+1
 . . S:'$D(^MAG(2005.2,"B",(RG_CNT))) NV=(RG_CNT)
 . . Q
 . Q
 S:NV="" NV=RG_(CNT+1)
 Q NV
ADDRG(RESULT,CNT,PLACE) ; Add Raid Groups to the Network Location file
 ; [MAGQ ADD RAID GROUP]
 N PL,I,VALUE,NMSP,LRG,X
 S X="ERR^MAGQBTM",@^%ZOSF("TRAP")
 S PL=$G(PLACE)
 S:PL="" PL=$$PLACE^MAGBAPI(+$G(DUZ(2))) Q:'PL  D
 . S NMSP=$P($G(^MAG(2006.1,PL,0)),U,2)
 . F I=1:1:CNT  D
 . . S VALUE=$$CRG(PL,"RG-"_NMSP)
 . . Q:$D(^MAG(2005.2,"D",PL,VALUE))  ; Do not create duplicates
 . . S MAGFDA(2005.2,"+1,",.01)=VALUE
 . . S MAGFDA(2005.2,"+1,",.04)=PL ;Place
 . . S MAGFDA(2005.2,"+1,",5)="0" ;READ-only
 . . S MAGFDA(2005.2,"+1,",6)="GRP" ;"RAID-GROUP"
 . . D UPDATE^DIE("U","MAGFDA","MAGIEN","MAGERR")
 . . I $D(DIERR) W !,"Error updating the Network Location file: "_MAGERR("DIERR",1,"TEXT",1)
 . . K MAGFDA,DIERR,MAGIEN,MAGFDA,MAGERR
 . . Q
 . Q
 S RESULT="1"
 Q
 ;
CAS ; Remove Acquisition Session file entries
 ; Remove entries in 2006.041 - ACQUISITION SESSION FILE
 ; Find COMPLETE import series and reduce to final outcome entry, keep for unique TrackingID ?
 ; Next remove IMPORT QUEUE entry if Complete
 ;Remove old queue entries from 2006.034 with no 2006.041 complement
 N DA,DIK,IEN,TRKID,IMPORTQ,ZNODE,STATUS,SIEN
 S IEN="A"
 F  S IEN=$O(^MAG(2006.041,IEN),-1) Q:'IEN  D
 . S ZNODE=$G(^MAG(2006.041,IEN,0))
 . S IMPORTQ=$P(ZNODE,U,1),TRKID=$P(ZNODE,U,2),STATUS=$P(ZNODE,U,5)
 . I TRKID="" S DIK="^MAG(2006.041,",DA=IEN D ^DIK K DIK,DA Q
 . I $D(^MAG(2006.041,"C",TRKID)) D
 . . ; skip latest entry, remove preliminary status entries
 . . S SIEN="A",SIEN=$O(^MAG(2006.041,"C",TRKID,SIEN),-1)
 . . I $$UPPER^MAGQE4($G(^MAG(2006.041,IEN,0)))["COMPLETE" D
 . . . ; Remove IMPORT QUEUE entry if Complete
 . . . I $D(^MAG(2006.034,IMPORTQ,0)) D
 . . . . S DIK="^MAG(2006.034,",DA=IMPORTQ
 . . . . D ^DIK K DIK,DA
 . . . . ; Remove Queue Record, if it exists to eliminate dangling pointer
 . . . . I $D(^MAGQUEUE(2006.03,IMPORTQ,0)) D DQUE^MAGQBUT2(IMPORTQ)
 . . . . Q
 . . . ; Remove log activity if Complete
 . . . F  S SIEN=$O(^MAG(2006.041,"C",TRKID,SIEN),-1) Q:'SIEN  D
 . . . . S DIK="^MAG(2006.041,",DA=SIEN
 . . . . D ^DIK K DIK,DA
 . . . . Q
 . Q
 ; Remove old queue entries from 2006.034 with no 2006.041 complement
 S IEN="" F  S IEN=$O(^MAG(2006.034,IEN)) Q:'IEN  D:'$D(^MAG(2006.041,"B",IEN))
 . S DIK="^MAG(2006.034,",DA=IEN
 . D ^DIK
 . K DIK,DA
 . ; Remove Queue Record, if it exists to eliminate dangling pointer
 . I $D(^MAGQUEUE(2006.03,IMPORTQ,0)) D DQUE^MAGQBUT2(IMPORTQ)
 . Q
 Q
 ;
FTYPE(RESULT) ;
 ; RPC[MAGQ FTYPE]
 N MAX,INDX,PLACE,X
 S X="ERR^MAGQBTM",@^%ZOSF("TRAP")
 S PLACE=$$PLACE^MAGBAPI(+$G(DUZ(2)))
 S U="^",MAX=$P(^MAG(2006.1,PLACE,2,0),U,4),INDX=0
 Q:+MAX<1
 F  S INDX=$O(^MAG(2006.1,PLACE,2,INDX)) Q:INDX'?1N.N  D  Q:INDX=MAX
 . S RESULT(INDX-1)=$G(^MAG(2006.1,PLACE,2,INDX,0))
 . Q
 Q

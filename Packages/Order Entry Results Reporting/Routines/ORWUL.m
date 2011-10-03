ORWUL ; SLC/KCM/JLI - Listview Selection ;1/25/02  14:09 [2/4/02 12:23pm] 2/27/06
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**85,117,131,132,164,215,245**;Dec 17, 1997;Build 2
 ;
QV4DG(VAL,DGRP) ; return the quick order list, given a display group name
 N NM
 S VAL="0^0"
 I 'DGRP S DGRP=+$O(^ORD(100.98,"B",DGRP,0))
 S NM=$$GET^XPAR("ALL","ORWDQ QUICK VIEW",DGRP,"I")
 Q:'$L(NM)
 D QV4NM(.VAL,NM)
 Q
QV4NM(VAL,QVNAM)       ; return the current quick list and item count
 ; VAL: ListIEN^ItemCount
 N J,CNT ;117
 S VAL=+$O(^ORD(101.44,"B",QVNAM,0))
 S (J,CNT)=0 F  S J=$O(^ORD(101.44,VAL,10,J)) Q:'+J  I '$$QODIS(VAL,J) S CNT=CNT+1 ;117
 S $P(VAL,U,2)=CNT ;117
 Q
QVSUB(LST,IEN,FIRST,LAST)       ; return subset of orders in view
 N I,J,ID ;117
 I $L(FIRST),$L(LAST) D
 . F I=+FIRST:1:+LAST D
 .. I $D(^ORD(101.44,IEN,10,I,0))>0 D
 ... I '$$QODIS(IEN,I) S LST(I)=^ORD(101.44,IEN,10,I,0)
 E  D
 . S (I,J)=0 F  S I=$O(^ORD(101.44,IEN,10,I)) Q:'+I  I '$$QODIS(IEN,I) S J=J+1,LST(J)=^ORD(101.44,IEN,10,I,0) ;117
 Q
QODIS(IEN,SUB) ;Determines if personal quick order is disabled
 ;returns 1 if it is else 0.  This section added with patch 117
 I $P($G(^ORD(101.41,+$P($G(^ORD(101.44,IEN,10,SUB,0)),"^"),0)),"^",3)'="" Q 1
 Q 0
QVIDX(VAL,IEN,FROM)     ; return index of item beginning with FROM
 N I,X
 S VAL=0
 S X=$O(^ORD(101.44,IEN,10,"C",FROM))
 I '$L(X) Q
 S I=$O(^ORD(101.44,IEN,10,"C",X,0))
 Q:'I
 S:'$$QODIS(IEN,I) VAL=+I_U_X
 Q
FV4DG(VAL,DGNM)       ; return the current full list & item count
 S VAL=$O(^ORD(101.44,"B","ORWDSET "_DGNM,0))
 I 'VAL D
 . N UPDTIME,ATTEMPT
 . S UPDTIME=$G(^ORD(101.43,"AH","S."_DGNM)),ATTEMPT=0
 . I UPDTIME="" S UPDTIME=$H,^ORD(101.43,"AH","S."_DGNM)=UPDTIME
 . D FVBLD
 . S VAL=$O(^ORD(101.44,"B","ORWDSET "_DGNM,0))
 I ($P(^ORD(101.44,+VAL,0),U,6)'=$G(^ORD(101.43,"AH","S."_DGNM))) D
 . ; -- see if a task is already queued to rebuild this
 . L +^XTMP("ORWDSET "_DGNM):2 E  Q
 . N ZTSK S ZTSK=+$G(^XTMP("ORWDSET "_DGNM,"TASK"))
 . I ZTSK D ISQED^%ZTLOAD S ZTSK=+ZTSK(0)
 . I ZTSK L -^XTMP("ORWDSET "_DGNM) Q
 . ; -- create a task to rebuild the list
 . D FVBLDQ(DGNM)
 . L -^XTMP("ORWDSET "_DGNM)
 S $P(VAL,U,2)=$P($G(^ORD(101.44,+VAL,20,0)),U,4)
 Q
FVSUB(LST,IEN,FIRST,LAST)       ; return subset of orders in view
 N I
 F I=FIRST:1:LAST D
 .;AGP change returned valued to returned data or @ if record does not
 .;exist. The @ sign is used by the delphi code to identified a
 .;non-existence record
 .S LST(I)=$S($D(^ORD(101.44,IEN,20,$G(I)))>0:^ORD(101.44,IEN,20,I,0),1:"@")
 Q
FVIDX(VAL,IEN,FROM)     ; return index of item beginning with FROM
 N I,X
 S VAL=0
 S X=$O(^ORD(101.44,IEN,20,"C",FROM))
 I '$L(X) Q
 S I=$O(^ORD(101.44,IEN,20,"C",X,0))
 Q:'I
 S VAL=+I_U_X
 Q
FVBLDQ(DGNM,ATTEMPT)    ; queue rebuild of set
 N ZTRTN,ZTIO,ZTDTH,ZTSAVE,ZTDESC,ZTUCI,ZTCPU,ZTPRI,ZTKIL,ZTSYNC,ZTSK
 N UPDTIME S UPDTIME=$G(^ORD(101.43,"AH","S."_DGNM))
 I '$G(UPDTIME) S UPDTIME=$H,^ORD(101.43,"AH","S."_DGNM)=UPDTIME
 S ATTEMPT=$G(ATTEMPT)+1
 S ZTRTN="FVBLD^ORWUL",ZTIO="",ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT,0,0,2)
 S ZTSAVE("ATTEMPT")="",ZTSAVE("UPDTIME")="",ZTSAVE("DGNM")=""
 S ZTDESC="Rebuild quick view for "_DGNM
 D ^%ZTLOAD
 S ^XTMP("ORWDSET "_DGNM,0)=$$FMADD^XLFDT($$NOW^XLFDT,2)_U_$$NOW^XLFDT
 S ^XTMP("ORWDSET "_DGNM,"TASK")=ZTSK
 Q
FVBLD ; rebuild an ORWSET entry
 ; ATTEMPT, UPDTIME, DGNM expected in environment
 I $D(ZTQUEUED) S ZTREQ="@"
 I $D(ZTQUEUED),(ATTEMPT<20),(UPDTIME'=$G(^ORD(101.43,"AH","S."_DGNM))) D FVBLDQ(DGNM,ATTEMPT) Q 
 ; -- create new entry in 101.44 for the set
 N FDA,FDAIEN,LVW,ADDL
 S FDA(101.44,"+1,",.01)="ORWDNEW "_DGNM
 S FDA(101.44,"+1,",6)=UPDTIME
 D UPDATE^DIE("","FDA","FDAIEN")
 S LVW=+FDAIEN(1) I 'LVW G FVBLDX
 ; -- copy all the active items into the list multiple
 N ASET,SEQ,NM,OI,INACT,CURTM,NMLST,X,Y
 S ASET="S."_DGNM,SEQ=0,CURTM=$$NOW^XLFDT
 K ^ORD(101.44,LVW,20)
 S ^ORD(101.44,LVW,20,0)="^101.442PA"
 S NM="" F  S NM=$O(^ORD(101.43,ASET,NM)) Q:NM=""  D
 . K NMLST
 . S OI=0 F  S OI=$O(^ORD(101.43,ASET,NM,OI)) Q:'OI  D
 . . S X=^ORD(101.43,ASET,NM,OI),INACT=$P(X,U,3)
 . . Q:$P(X,U,5)  I INACT,CURTM>INACT Q
 . . I 'X S ADDL=""
 . . E    S ADDL="     <"_$P(X,U,4)_">"
 . . I $P($G(^ORD(101.43,OI,"PS")),U,6) S ADDL=ADDL_"     NF"
 . . S NMLST($P(X,U,2)_ADDL,OI)=""
 . I '$D(NMLST) Q
 . S X="" F  S X=$O(NMLST(X)) Q:X=""  D
 . . S Y=0 F  S Y=$O(NMLST(X,Y)) Q:'Y  D
 . . . S SEQ=SEQ+1
 . . . S ^ORD(101.44,LVW,20,SEQ,0)=Y_U_X
 . . . S ^ORD(101.44,LVW,20,"C",$$UP^XLFSTR(X),SEQ)=""
 S ^ORD(101.44,LVW,20,0)="^101.442PA^"_SEQ_U_SEQ
 ; -- switch the names of the entries (SET->OLD, NEW->SET)
 L +^ORD(101.44,"ORWDSET "_DGNM):60
 S IEN=$O(^ORD(101.44,"B","ORWDSET "_DGNM,0))
 I IEN K FDA S FDA(101.44,IEN_",",.01)="ORWDOLD "_$H
 D FILE^DIE("","FDA")
 K FDA S FDA(101.44,LVW_",",.01)="ORWDSET "_DGNM
 D FILE^DIE("","FDA")
 L -^ORD(101.44,"ORWDSET "_DGNM)
FVBLDX ; -- clean up ^XTMP node
 K ^XTMP("ORWDSET "_DGNM)
 D FVCLN
 Q
FVCLN ; clean up old set-type entries in the 101.44
 N LNM,DIK,DA
 S LNM="ORWDOLD",DIK="^ORD(101.44,"
 F  S LNM=$O(^ORD(101.44,"B",LNM)) Q:$E(LNM,1,7)'="ORWDOLD"  D
 . I ($H-$P(LNM," ",2))<2 Q  ; wait until entry is 2 days old
 . S DA=0 F  S DA=$O(^ORD(101.44,"B",LNM,DA)) Q:'DA  D ^DIK
 Q
QVSAVE(LVW,X,QLST)       ; Save a quick order list
 ;    X:  Name of List
 ; QLST: Ptr101.41^DisplayName
 N DIC,DA,DLAYGO,Y,LVW,SEQ,I
 S DIC="^ORD(101.44,",DIC(0)="L",DLAYGO=101.44,LVW=0
 D ^DIC Q:'Y
 S LVW=+Y,SEQ=0
 I $D(^ORD(101.44,LVW,10)) D  ; KILL "C" XREF
 . N IDX,QOIEN S IDX=0
 . F  S IDX=$O(^ORD(101.44,LVW,10,IDX)) Q:'IDX  D
 . . S QOIEN=$P(^ORD(101.44,LVW,10,IDX,0),U)
 . . K ^ORD(101.44,"C",QOIEN,LVW,IDX)
 K ^ORD(101.44,LVW,10)
 S ^ORD(101.44,LVW,10,0)="^101.441PA"
 S I=0  F  S I=$O(QLST(I)) Q:'I  D
 . S SEQ=SEQ+1,^ORD(101.44,LVW,10,SEQ,0)=QLST(I)
 . S ^ORD(101.44,LVW,10,"C",$$UP^XLFSTR($P(QLST(I),U,2)),SEQ)=""
 . S ^ORD(101.44,"C",+QLST(I),LVW,SEQ)=""
 S ^ORD(101.44,LVW,10,0)="^101.441PA^"_SEQ_U_SEQ
 Q
MVRX ; move pharmacy quick orders into 101.44
 D MVQO("O RX")
 D MVQO("UD RX")
 Q
MVALL ; move all quick order lists into 101.44
 Q:$E($O(^ORD(101.44,"B","ORWDQ")),1,5)="ORWDQ"
 N SNM
 D BMES^XPDUTL("Moving personal quick orders into 101.44")
 F SNM="ANI","CARD","CSLT","CT","DO","IV RX","LAB","MAM","MRI","NM","O RX","PROC","RAD","TF","UD RX","US","VAS","XRAY" D
 . D MES^XPDUTL("-- moving: "_SNM)
 . D MVQO(SNM)
 Q
MVQO(DGNM)      ; move quick orders
 N ENT,PAR,ORTLST,QLST,DLG,X,X0,I,NOP,DNM
 S PAR=$O(^XTV(8989.51,"B","ORWDQ "_DGNM,0))
 S ENT="" F  S ENT=$O(^XTV(8989.5,"AC",PAR,ENT)) Q:'ENT  D
 . K ORTLST,QLST D GETLST^XPAR(.ORTLST,ENT,PAR,"I")
 . S I=0 F  S I=$O(ORTLST(I)) Q:'I  D
 . . S DLG=+ORTLST(I) Q:'DLG
 . . S X0=$G(^ORD(101.41,DLG,0)) Q:'$L(X0)
 . . S DNM=$$GET^XPAR(ENT,"ORWDQ DISPLAY NAME",DLG,"I")
 . . I '$L(DNM) S DNM=$P(^ORD(101.41,DLG,0),U,2)
 . . S QLST(I)=DLG_U_DNM
 . S X=$O(^XTV(8989.51,PAR,30,"AG",$P(ENT,";",2),0))
 . S X=$P(^XTV(8989.51,PAR,30,X,0),U,2)
 . S X=$P(^XTV(8989.518,X,0),U,2)
 . S X="ORWDQ "_X_$P(ENT,";")_" "_DGNM
 . D QVSAVE(.NOP,X,.QLST)
 . D EN^XPAR(ENT,"ORWDQ QUICK VIEW",DGNM,X)
 . ; D NDEL^XPAR(ENT,PAR) ; -- add later, after sure about conversion
 Q
ZCLEAN ; cleanup ORWDQ entries in Quick View file
 N ANAM,ANIEN,DIK,DA
 S ANAM="ORWDQ",DIK="^ORD(101.44,"
 F  S ANAM=$O(^ORD(101.44,"B",ANAM)) Q:$E(ANAM,1,5)'="ORWDQ"  D
 . W !,"deleting "_ANAM
 . S ANIEN=$O(^ORD(101.44,"B",ANAM,0))
 . S DA=ANIEN D ^DIK
 W !,"rebuilding entries"
 D MVALL
 Q

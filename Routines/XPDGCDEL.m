XPDGCDEL ;SFISC.SEA/JLI - Delete specified Objects (if not required) ; 3 Feb 95 09:14
 ;;8.0;KERNEL;;Jul 10, 1995
 ;
EN(XGCROOT) ; Entry is with the root under which IENs for the objects to be
 ; deleted will be found.
 N TMPROOT,DAXGC,TMPEVNT,DA,I,J,K,X,XGCOBJ,XGEVNT,XQUIT,DIE,DR
 S TMPROOT=$NA(^TMP("XPDGCDEL",$J))
 S TMPEVNT=$NA(^TMP("XPDGCEVN",$J))
 K @TMPROOT ; array to save those currently in use
 K @TMPEVNT
 S XGCOBJ=""
 D OBJECTS
 I $D(@TMPROOT) S XGCROOT=TMPROOT D OBJECTS
 D EVENTS
 K @TMPROOT
 K @TMPEVNT
 Q
 ;
OBJECTS ;
 F  S XGCOBJ=$O(@XGCROOT@(XGCOBJ)) Q:XGCOBJ=""  D
 . S DAXGC=XGCOBJ
 . S XQUIT=0
 . F I=0:0 S I=$O(^XTV(8995,I)) Q:I'>0  I $O(^(I,2,0))>0 D  Q:XQUIT
 . . F J=0:0 S J=$O(^XTV(8995,I,2,J)) Q:J'>0  I $P(^(J,0),U,2)=DAXGC D  Q:XQUIT
 . . . I $D(@XGCROOT@($P(^XTV(8995,I,0),U))) S @TMPROOT@(XGCOBJ)=""
 . . . S XQUIT=1 ; Mark as currently used
 . . Q:XQUIT
 . Q:XQUIT
 . D CHKEVNTS
 . D CHKPARNT
 . S DA=DAXGC
 . S DIK="^XTV(8995,"
 . D ^DIK
 . K DIK
 Q
 ;
CHKEVNTS ;
 F I=0:0 S I=$O(^XTV(8995,DAXGC,1,I)) Q:I'>0  S X=^(I,0) D
 . S X=+$P(X,U,2)
 . S X=$P(^XTV(8995.8,X,0),U)
 . S @TMPEVNT@(X)=""
 F I=0:0 S I=$O(^XTV(8995,DAXGC,2,I)) Q:I'>0  D
 . F J=0:0 S J=$O(^XTV(8995,DAXGC,2,I,1,J)) Q:J'>0  S X=^(J,0) D
 . . S X=+$P(X,U,2)
 . . S X=$P(^XTV(8995.8,X,0),U)
 . . S @TMPEVNT@(X)=""
 F I=0:0 S I=$O(^XTV(8995,DAXGC,3,I)) Q:I'>0  S X=^(I,0) D
 . S X=+$P(X,U,4)
 . S X=$P(^XTV(8995.8,X,0),U)
 . S @TMPEVNT@(X)=""
 Q
 ;
CHKPARNT ;
 F I=0:0 S I=$O(^XTV(8995,I)) Q:I'>0  I I'=DAXGC,$P(^(I,0),U,2)=DAXGC D
 . S DR=".02///@;",DIE="^XTV(8995,",DA=DAXGC
 . D ^DIE
 . K DIE,DR
 Q
 ;
EVENTS ;
 S XGEVNT=""
 F  S XGEVNT=$O(@TMPEVNT@(XGEVNT)) Q:XGEVNT=""  D
 . S DAXGC=$O(^XTV(8995.8,"B",XGEVNT)) Q:DAXGC'>0
 . S XQUIT=0
 . F I=0:0 Q:XQUIT  S I=$O(^XTV(8995,I)) Q:I'>0  D
 . . F J=0:0 S J=$O(^XTV(8995,I,1,J)) Q:J'>0  I $P(^(J,0),U,2)=DAXGC S XQUIT=1 Q
 . . F J=0:0 Q:XQUIT  S J=$O(^XTV(8995,I,2,J)) Q:J'>0  D
 . . . F K=0:0 S K=$O(^XTV(8995,I,2,J,1,K)) Q:K'>0  I $P(^(K,0),U,2)=DAXGC S XQUIT=1 Q
 . . F J=0:0 S J=$O(^XTV(8995,I,3,J)) Q:J'>0  I $P(^(J,0),U,4)=DAXGC S XQUIT=1 Q
 . S DA=DAXGC
 . S DIK="^XTV(8995.9,"
 . D ^DIK
 . K DIK
 Q

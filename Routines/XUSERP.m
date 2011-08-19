XUSERP ;ISF/RWF,SFVAMC/JC - file 200 Protocol ;06/24/2003  11:43
 ;;8.0;KERNEL;**313**;Jul 10, 1995
 ;
CALL(XUNP,XUFLG) ;Queue Protocol
 ;Call for Kernel Create, Update, Disuser or Terminate events
 ;Queue Protocol for user trigger events
 ;XUFLG=Action: 1=Add/Create New Entry, 2=Update Existing Entry, 3=Terminate
 ;XUNP=input IEN of New Person File entry
 Q:'+$G(XUNP)
 N ZTSAVE,ZTRTN,ZTDTH,ZTDESC,ZTIO
 S ZTRTN="DEQUE^XUSERP("_XUNP_","_XUFLG_")",ZTDTH=$H,ZTIO=""
 S ZTDESC="User "_$P("add^change^terminate","^",XUFLG)_" event protocol"
 D ^ZTLOAD
 Q
 ;
DEQUE(XUNP,XUFLG) ;Run Protocol
 ;Call for Kernel Create, Update, Disuser or Terminate events
 ;Call Protocol for user trigger events
 ;XUFLG=Action: 1=Add/Create New Entry, 2=Update Existing Entry, 3=Terminate
 ;XUNP=input IEN of New Person File entry
 Q:'+$G(XUNP)
 N XUDA,DIC,DIE,N,X,XUSR,XUIEN,XUIFN,$ES,$ET
 S XUFLG=$G(XUFLG) I XUFLG<1!(XUFLG>3) S XUFLG=2
 S $ETRAP="D ^%ZTER,UNWIND^%ZTER"
 S N=$P("XU USER ADD^XU USER CHANGE^XU USER TERMINATE","^",XUFLG)
 S X=+$O(^DIC(19,"B",N,0))_";DIC(19,"
 ;XUIFN is used in the Terminate protocol.
 I XUFLG=3 S XUIFN=XUNP
 ;XUIEN and XUSR are user in the protocol.
 S XUIEN=XUNP D EN^XQOR
 Q
 ;
GET(IEN,USR) ;Return file 200 data 
 ;Protocol XU USER ADD, XU USER CHANGE, XU USER TERMINATE
 I '$L($G(IEN)) S USR="0-ERROR"
 N XUSR0,XUSR1
 I $D(^VA(200,IEN)) D
 . S XUSR0=$G(^VA(200,IEN,0))
 . S XUSR1=$G(^VA(200,IEN,.1))
 . S USR("NAME")=$P(XUSR0,U)
 . S USR("INITIAL")=$P(XUSR0,U,2)
 . S USR("ACCESS CODE")=$P(XUSR0,U,3)
 . S USR("FILE MANAGER ACCESS CODE")=$P(XUSR0,U,4)
 . S USR("DISUSER")=$P(XUSR0,U,7)
 . S USR("TERMINATION DATE")=$P(XUSR0,U,11)
 . S USR("DATE VERIFY CODE LAST CHANGED")=$P(XUSR1,U)
 . S USR("VERIFY CODE")=$P(XUSR1,U,2)
 . S USR("NICKNAME")=$P(XUSR1,U,4)
 . S USR("SSN")=$P(^VA(200,IEN,1),U,9)
 . S USR("EML")=$P($G(^VA(200,IEN,.15)),U)
 . S USR("HL7NAME")=$$HL7^XUSER(IEN)
 . I $D(^VA(200,IEN,2)) S I=0 F  S I=$O(^VA(200,IEN,2,I)) Q:I<1  D
 . . S USR("DIV",I)=$P($G(^VA(200,IEN,2,I,0)),U) ;Pointer to file 4
 Q

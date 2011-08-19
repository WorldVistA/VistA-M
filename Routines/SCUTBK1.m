SCUTBK1 ;ALB/MJK - Scheduling Broker Utilities ;[ 03/08/95  3:41 PM ]
 ;;5.3;Scheduling;**41,297,498**;AUG 13, 1993;Build 23
 ;
 Q
 ;
DIKC(SCOK,SC) ; -- broker callback to kill a file entry
 ;
 N DIK,DA
 D CHK^SCUTBK
 ;
 ; -- array parsing
 S DIK=$G(SC("ROOT"))
 S DA=+$G(SC("IEN"))
 ;
 IF DIK]"",$D(@(DIK_DA_",0)")) D
 . D ^DIK
 . S SCOK=1
 ELSE  D
 . S SCOK=0
 Q
 ;
LOCKC(SCOK,SC) ; -- broker callback to lock/unlock a node
 ;
 N SCNODE
 D CHK^SCUTBK
 ;
 ; -- array parsing
 S SCNODE=$G(SC("NODE"))
 I SCNODE[",)" S SCOK=1 Q
 ;
 IF SCNODE]"" D
 . IF $G(SC("LOCKMODE")) D
 . . L @("+"_SCNODE_":"_$G(SC("TIMEOUT"),5))
 . . S SCOK=$T
 . ELSE  D
 . . L @("-"_SCNODE)
 . . S SCOK=1
 ELSE  D 
 . S SCOK=0
 Q
 ;
FILENOC(SCFLNO,SCNAME) ; -- broker callback to get File #
 ;
 D CHK^SCUTBK
 S SCFLNO=+$O(^DIC("B",SCNAME,""))
 Q
 ;
NODEC(SCNODE,SCROOT) ; -- broker callback to get global node value
 ;
 D CHK^SCUTBK
 ;S SCNODE=$G(@SCROOT)
 IF $D(@SCROOT)=0!($D(@SCROOT)=10) D
 . S SCNODE="{{"_$D(@SCROOT)_"}}"
 IF $D(@SCROOT)=1!($D(@SCROOT)=11) D
 . S SCNODE=$G(@SCROOT)
 Q
 ;
GLCNT(SCOK,SC) ; -- extrinsic call to invoke broker to return number of
 ;       global nodes found at cross reference
 N SCNODE,SCTEAM,SCXREF,SCFRST
 D CHK^SCUTBK
 ;
 S (SCFRST,SCOK)=""
 S SCNODE=$G(SC("ROOT"))
 S SCXREF=$G(SC("XREF"))
 S SCVAL=$G(SC("VALUE"))
 ;
 S:SCXREF="" SCXREF="B"
 S I="",X=0
 F  S I=$O(@SCNODE@(SCXREF,SCVAL,I)) Q:I=""  D
 . S X=X+1
 S SCOK=$G(X)
 Q
 ;
IFNODE(SCNODE,SCROOT) ; -- extrinsic call to check if node exists.
 ; passes in full node reference.
 N X
 D CHK^SCUTBK
 ;
 IF $D(@SCROOT)=0!($D(@SCROOT)=10) D
 . S SCNODE="{{"_$D(@SCROOT)_"}}"
 IF $D(@SCROOT)=1!($D(@SCROOT)=11) D
 . S SCNODE=$G(@SCROOT)
 Q
 ;
PRTP(SCACTV,SC) ;
 ;
 N SCRTN,SCERRX,SCOK,SCIEN,SCKDT
 D TMP^SCUTBK
 D CHK^SCUTBK
 ;
 I $G(SC("IEN"))=0 D  G PRTPQ
 . S SCACTV=0
 S SCIEN=SC("IEN")
 ;
 S SCKDT=""
 S SCKDT("BEGIN")=$G(SC("BEGIN"),DT)
 S SCKDT("END")=$G(SC("END"),DT)
 S SCKDT("INCL")=$G(SC("INCL"),0)
 ;
 S SCOK=$$PRTP^SCAPMC8(SCIEN,"SCKDT","SCRTN","SCERRX")
 S SCACTV=$S(SCOK:$G(SCRTN(1),"0"),1:"0")
PRTPQ Q

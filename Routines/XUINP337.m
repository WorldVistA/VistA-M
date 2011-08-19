XUINP337 ;ISF/RWF - PATCH XU*8*337 POST INIT. ;08/08/2005  09:04
 ;;8.0;KERNEL;**337**;Jul 10, 1995
POST ;Post Install
 D PST1,PST2
 Q
 ;
TEST ;Test the get part
 N T1,T2 S (APP1,APP2)=""
 D HOME^%ZIS S T1=$H
 D GET,CLOSE^%ZISTCP
 S T2=$H
 W !,"Return data was "_$S(($L(APP1)+$L(APP2))=256:"OK",1:"Missing")
 W !,"Call took ",$P(T2,",",2)-$P(T1,",",2)," seconds"
 Q
 ;
PST1 ;Get the app-code
 N APP1,APP2,CCOW,RET,X,XWBTIME
 D GETAPC
 I $L($G(RET(0))),$L($G(RET(1))) Q  ;Already have APC
 D BMES^XPDUTL("Get CCOW parameter.")
 S CCOW="XUS CCOW VAULT PARAM",(APP1,APP2)=""
 D GET,CLOSE^%ZISTCP
 D FILE
 D GETAPC
 I '$D(RET(0))!'$D(RET(1)) D FAIL
 E  D BMES^XPDUTL("Set CCOW parameter.")
 Q
 ;
GET ;Get the codes
 N SITE,XWBTDEV,XWBRBUF,XWBDEBUG,$ES,$ET
 S $ETRAP="D ERR^XUINP337"
 S XWBTIME=30,XWBTIME(1)=3
 S SITE=$$KSP^XUPARAM("WHERE")
 ;Get the data from the FO-oakland ISC account.
 D CALL^%ZISTCP("10.6.21.15",33865) G:POP FAIL
 U IO S XWBTDEV=IO,XWBRBUF="",XWBDEBUG=0
 W "[SSO]3-"_$E(1000+$L(SITE),2,4)_SITE,@IOF
 S X=+$$BREAD^XWBRW(3) I X'>0 Q
 S APP1=$$BREAD^XWBRW(X)
 S X=+$$BREAD^XWBRW(3) I X'>0 Q
 S APP2=$$BREAD^XWBRW(X)
 S X=$$BREAD^XWBRW(1)
 Q
 ;
FAIL ;Tell user APPCODE failed
 D BMES^XPDUTL("Failed to set CCOW parameter.")
 Q
 ;
ERR ;
 D ^%ZTER,UNWIND^%ZTER
 ;
FILE ;
 I '$L($G(APP1))!'$L($G(APP2)) D ^%ZTER Q
 D ADD^XPAR("SYS",CCOW,0,APP1,.ERR)
 D ADD^XPAR("SYS",CCOW,1,APP2,.ERR)
 Q
 ;
GETAPC ;Test the appcode
 K RET
 S RET(0)=$$GET^XPAR("SYS","XUS CCOW VAULT PARAM",0,"Q")
 S RET(1)=$$GET^XPAR("SYS","XUS CCOW VAULT PARAM",1,"Q")
 Q
PST2 ;Set default CCOW token timeout
 N DIE,DIC,DR,DA
 S DIE="^XTV(8989.3,",DA=1,DR="30.1////5400" D ^DIE
 Q

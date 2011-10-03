XUSRA ;ISCSF/RWF - Remote access control ;08/27/2003  10:11
 ;;8.0;KERNEL;**70,115,208,265**;Jul 10, 1995
 Q  ;No entry from top
 ;
 ;OUTSIDE app user cheking, The supported entry-points are:
 ;VALIDAV, INTRO, USERSET
 ;First parameter is always call-by-reference
VALIDAV(RESULT,AVCODE) ;Check a users access
 ;Return DUZ^problem message^verify needs changing
 ;This entry point is subscription only.
 N X,XUSER,XUF,XRA1,XRA2,XUMSG
 K ^UTILITY($J),^TMP($J),^XUTL("XQ",$J)
 D SET1^XUS(0) S XRA1=$$INHIBIT^XUSRB,XRA2=0,XUF=0,DUZ=0,XUMSG=0
 I 'XRA1 S DUZ=$$CHECKAV^XUS(AVCODE) S:DUZ XRA2=$$VCVALID S:XRA2 DUZ=0,XRA1=12
 S XUMSG=$S(XRA1:XRA1,'DUZ:4,1:0),XUMSG=$S(XUMSG:$$TXT^XUS3(XUMSG),1:"")
 S RESULT=DUZ_U_XUMSG_U_XRA2
 Q
 ;
INTRO(RESULT) ;Return INTRO TEXT.
 D INTRO^XUS1A("RESULT")
 Q
VCVALID() ;Check if the Verify code needs changing.
 Q:'$G(DUZ) 1
 Q $G(^VA(200,DUZ,.1))+$P(^XTV(8989.3,1,"XUS"),"^",15)'>(+$H)
 ;
CVC(RESULT,XU1) ;change VC
 S RESULT=0 Q:$G(DUZ)'>0  N XU2 S U="^",XU2=$P(XU1,U,2),XU1=$P(XU1,U)
 Q $$BRCVC^XUS2(XU1,XU2)
 ;
USERSET(AV) ;sr. If a valid A/V setup DUZ for user.
 ;input: AV = accesscode_;_verifycode
 ;output: 0 = not OK ^ msg
 ;        1 = OK
 N NZ,X,XUSER,XUF,XUNOW,XUDEV,XUM,XUMSG,%1,VCOK K DUZ
 S DUZ=0,DUZ(0)="",VCOK=0,U="^",XUF=0,XUM=0,XUMSG=0 D NOW^XUSRB
 D SET1^XUS(0)
 S XUM=$$INHIBIT^XUSRB() I XUM G USX ;Logon inhibited
 S DUZ=$$CHECKAV^XUS(AV),XUM=$$UVALID^XUS() G:XUM USX
 S VCOK=$$VCVALID^XUSRB()
USX I XUM S DUZ=0,XUMSG=$$TXT^XUS3(XUM)
 I 'XUM S XQXFLG("ZEBRA")=-1 D LOG^XUS1 ;Record the sign-on.
 Q $S(XUM:"0^"_XUMSG,1:1)
 ;

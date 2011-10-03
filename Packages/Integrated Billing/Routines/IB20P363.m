IB20P363 ;ALB/SS - POST INIT ACTION ;22-FEB-2007
 ;;2.0;INTEGRATED BILLING;**363**;21-MAR-94;Build 35
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
EN ;
 I $$PATCH^XPDUTL("IB*2.0*363") D  Q
 . D MESSAGE("The post-install process has been skipped since")
 . D MESSAGE("the patch was previously installed.")
 . D SNDMAIL("IB*2.0*363 installation has been completed","The post-install process has been skipped since","the patch was previously installed.","")
 D MESSAGE("Queuing IB*2.0*363 POST-INSTALL process")
 N X,Y,%DT,ZTDESC,ZTSAVE,ZTIO,ZTDTH,ZTRTN
 S X="N",%DT="ST"
 D ^%DT
 S ZTDTH=Y
 S ZTIO=""
 S ZTDESC="IB*2.0*363 POST INSTALL PROCESS"
 S ZTSAVE("*")=""
 S ZTRTN="EN1^IB20P363"
 D ^%ZTLOAD
 Q
 ;
EN1 ; post-install process itself
 ;D MESSAGE(">>> Populating the field #.09 E-PHARMACY DIVISION in the file #366.14")
 ;D MESSAGE("    Please wait...")
 N IBIEN,IBEVIEN,IBZ,IBEPHARM,IBCNT,IBRXIEN,IBCNTOT,IBMSG0,IBMSG1,IBMSG2
 S IBIEN=0,IBCNT=0,IBCNTOT=0
 F  S IBIEN=$O(^IBCNR(366.14,IBIEN)) Q:+IBIEN=0  D
 . S IBEVIEN=0
 . F  S IBEVIEN=$O(^IBCNR(366.14,IBIEN,1,IBEVIEN)) Q:+IBEVIEN=0  D
 . . S IBCNTOT=IBCNTOT+1
 . . I $P($G(^IBCNR(366.14,IBIEN,1,IBEVIEN,0)),U,9)>0 Q
 . . S IBZ=$G(^IBCNR(366.14,IBIEN,1,IBEVIEN,2))
 . . S IBRXIEN=+IBZ
 . . I 'IBRXIEN S IBRXIEN=+$P(IBZ,U,12)
 . . S IBEPHARM=$$GETEPHRM^BPS01P5C($G(^IBCNR(366.14,IBIEN,0)),IBRXIEN,+$P(IBZ,U,3))
 . . I IBEPHARM S $P(^IBCNR(366.14,IBIEN,1,IBEVIEN,0),U,9)=IBEPHARM,IBCNT=IBCNT+1
 S IBMSG0=">>> Populating the field #.09 E-PHARMACY DIVISION in the file #366.14"
 S IBMSG1=$S(IBCNT=1:">>> 1 record has been populated",1:">>> "_IBCNT_" records have been populated.")
 S IBMSG2=$S(IBCNTOT=1:">>> 1 record has been examined",1:">>> "_IBCNTOT_" records have been examined.")
 ;D MESSAGE(IBMSG1)
 ;D MESSAGE(IBMSG2)
 D SNDMAIL("IB*2.0*363 installation has been completed",IBMSG0,IBMSG1,IBMSG2)
 Q
 ;display message 
 ;IBMSG - message text
MESSAGE(IBMSG) ;
 D BMES^XPDUTL(IBMSG)
 Q
 ;send mail to the user
SNDMAIL(IBSUBJ,IBMESS1,IBMESS2,IBMESS3) ;
 N DIFROM ;IMPORTANT - if you send e-mail from post-install process (queued or not) !!!
 N IBTMPARR,XMDUZ,XMSUB,XMTEXT,XMY
 S IBTMPARR(1)=""
 S IBTMPARR(2)=IBMESS1
 S IBTMPARR(3)=IBMESS2
 S IBTMPARR(4)=IBMESS3
 S IBTMPARR(5)=""
 S XMSUB=IBSUBJ
 S XMDUZ="INTEGRATED BILLING PACKAGE"
 S XMTEXT="IBTMPARR("
 S XMY(DUZ)=""
 D ^XMD
 Q
 ;

XU8P497A ;BP/BT - UPDATE PERSON CLASS FILE; 4/7/2008
 ;;8.0;KERNEL;**497**;July 10, 1995;Build 5
 ;;"Per VHA Directive 2004-038, this routine should not be modified."
 ;
EN ;
 N XU1,XU2,XUPCIEN,XUDATA
 F XU1=1:1:1 S XUDATA=$P($T(INAC+XU1),";",3,99) D
 . F XU2=1:1 S XUPCIEN=$P(XUDATA,";",XU2) Q:XUPCIEN="$END$"  D CHCK
 Q
INAC ;;
 ;;187;247;353;515;517;519;522;$END$
 ;;$END$;;
 ;;
 ;;
LOOP N XUIEN,XUIEN2,XUEXDA,XUDIUSR,XUACTIVE,XUACONLY,%
 W !,"This report will run immediately (no device asked)."
 W !,"Users may turn 'screen capture' for this report."
 R !,"Do you want to list active users only? NO// ",%:20 Q:'$T
 S %=$TR($E(%),"YyNn","1100") I %="^" Q
 W !
 K ^TMP("XU8P497")
 S XUIEN=0 F  S XUIEN=$O(^VA(200,XUIEN)) Q:XUIEN'>0  D
 . I %=1,'(+$$ACTIVE^XUSER(XUIEN)) Q
 . S XUACTIVE=$P($$ACTIVE^XUSER(XUIEN),"^",2)
 . S XUDIUSR=XUACTIVE
 . D EN
 D PRNT
 Q
CHCK ;
 I '$D(^VA(200,XUIEN,"USC1","B",XUPCIEN)) Q
 S XUIEN2=$O(^VA(200,XUIEN,"USC1","B",XUPCIEN,"A"),-1)
 S XUEXDA=$P($G(^VA(200,XUIEN,"USC1",XUIEN2,0)),"^",3)
 I ('XUEXDA)!(XUEXDA>DT) D
 . S ^TMP("XU8P497",$J,XUPCIEN,XUIEN)=$P($G(^VA(200,XUIEN,0)),"^",1)_"^"_XUDIUSR
 Q
PRNT ;
 N XUI,XUY,XUV,XUCOUNT,XUC S XUC=0
 S XUI=0 F  S XUI=$O(^TMP("XU8P497",$J,XUI)) Q:XUI'>0  D
 . S XUV=$G(^USC(8932.1,XUI,0))
 . W !,"PERSON CLASS ID: ",XUI,?28,"    NAME: ",$E($P(XUV,"^",1),1,40)
 . W !,"        VA CODE: ",$P(XUV,"^",6),?28,"X12 CODE: ",$P(XUV,"^",7)
 . S XUCOUNT=0
 . W !!,"User Name",?34,"Status"
 . S XUY=0 F  S XUY=$O(^TMP("XU8P497",$J,XUI,XUY)) Q:XUY'>0  D
 . . W !,?2,$P($G(^TMP("XU8P497",$J,XUI,XUY)),"^"),?36,$P($G(^TMP("XU8P497",$J,XUI,XUY)),"^",2)
 . . S XUCOUNT=XUCOUNT+1
 . W !!,?10,"Number of users: ",XUCOUNT
 . W !,"------------------------------"
 . S XUC=XUC+1
 I XUC=0 W !,"No users found. You are done!"
 I XUC>0 W !!," Please check and assign replacement Person Classes",!," for users listed on this report."
 D ^%ZISC
 Q
 ;
PRINT ;
 N XUI,XUY,XUC S (XUI,XUC)=0
 W !,"This report will run immediately (no device asked)."
 W !,"Users may turn 'screen capture' for this report."
 R !,"Enter any key to continue ",XUY:10 Q:'$T
 F  S XUI=$O(^TMP("XU8P497",$J,XUI)) Q:XUI'>0  D
 . W !,$G(^TMP("XU8P497",$J,XUI)) S XUC=XUC+1
 I XUC=0 W !!,"No replacement Person Class is assigned for users."
 Q

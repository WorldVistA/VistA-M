EAS1P53 ;ALB/jap - POST-INSTALLATION FOR EAS*1*53 ;05/17/2004
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**53**;Mar 15, 2001
 ;
POST ;entry point for installation
 N XTIME,X1,X2,ZTRTN,ZTDESC,ZTDTH,ZTSAVE,ZTSK
 S X1=DT,X2=1 D C^%DTC
 S (ZTDTH,XTIME)=X_".030000"
 S ZTIO="",ZTDESC="POST_INSTALLATION CLEANUP FOR EAS*1*53"
 S ZTRTN="QUE^EAS1P53"
 D ^%ZTLOAD
 I $G(ZTSK) D
 .S Y=XTIME D DD^%DT S XTIME=Y
 .W !,"Post-installation file #712 x-ref clean-up queued for"
 .W !,XTIME_" as Task #"_ZTSK_"."
 .H 3
 Q
 ;
QUE ;entry point for TaskManager
 N A,NETNAME,NOW,R712,TOT,XMSUB,XMDUZ,XMTEXT,XMY,XMZ,Y
 ;delete existing x-refs for status
 F A="NEW","REV","PRT","SIG","FIL","CLS" K ^EAS(712,A)
 ;
 ;reset all x-refs for status
 S TOT=0
 S R712=0 F  S R712=$O(^EAS(712,R712)) Q:'R712  D APPINDEX^EASEZU2(R712) S TOT=TOT+1
 ;
 ;send completion msg
 S Y=$$NOW^XLFDT() D DD^%DT S NOW=Y
 S NETNAME=^XMB("NETNAME")
 S ^TMP("1010EZ",$J,1)="Post-installation cross-reference clean-up of file #712"
 S ^TMP("1010EZ",$J,2)="for EAS*1*53 completed successfully at "_NOW
 S ^TMP("1010EZ",$J,3)="by Task #"_$G(ZTSK)_"."
 S ^TMP("1010EZ",$J,4)=" "
 S ^TMP("1010EZ",$J,5)="Total entries in file #712 re-indexed: "_TOT
 S XMSUB="EAS*1*53 POST-INSTALL COMPLETE",XMDUZ=.5
 S XMY(DUZ)=""
 S XMY("G.VA1010EZ@"_NETNAME)=""
 S XMTEXT="^TMP(""1010EZ"",$J,"
 D ^XMD
 K ^TMP("1010EZ",$J)
 Q

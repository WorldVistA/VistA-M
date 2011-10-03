XUTMKA ;ISF/RWF - Send alerts for Taskman ;11/23/99  07:57
 ;;8.0;KERNEL;**127**
EN1 N CNT K ^TMP($J)
 W !,"List of Devices that haven't been successfully opened.",!
 D DEVTRY(3600)
 D SHOW,CLEAR
 Q
 ;
CLEAR ;Clear the DEVTRY nodes.
 K ^%ZTSCH("DEVTRY")
 Q
TASK ;Queued task entry point
 N CNT,XMB,XMTEXT K ^TMP($J)
 D LOG("From "_$$KSP^XUPARAM("WHERE")_" on "_$$HTE^XLFDT($H))
 D DEVTRY(3600)
 I CNT>1 S XMB="XUTM PROBLEM DEVICES",XMTEXT="^TMP($J," D ^XMB
 D CLEAR
 Q
DEVTRY(OFFSET) ;Look at the ^%ZTSCH("DEVTRY" nodes to see about problem devices
 N DEV,TIME,DTIME
 S TIME=$$H3^%ZTM($H),DEV=""
 F  S DEV=$O(^%ZTSCH("DEVTRY",DEV)) Q:DEV=""  D
 . S DTIME=$G(^%ZTSCH("DEVTRY",DEV)) Q:DTIME=""
 . I (DTIME+OFFSET)<TIME D LOG("Device "_DEV_" has not been successfully opened since "_$$HTE^XLFDT($$H0^%ZTM(DTIME)))
 . Q
 Q
LOG(MSG) ;Add text to report
 S CNT=$G(CNT)+1,^TMP($J,CNT,0)=MSG
 Q
 ;
SHOW ;Show text
 N %
 F %=1:1 Q:'$D(^TMP($J,%,0))  W !,^(0)
 Q

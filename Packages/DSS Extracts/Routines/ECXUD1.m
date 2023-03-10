ECXUD1 ;ALB/JAP,BIR/DMA-Store Data from Unit Dose Package into 728.904 ; 26 Sep 95 / 12:44 PM
 ;;3.0;DSS EXTRACTS;**8,181**;Dec 22, 1997;Build 71
 ;
 ;Reference to ^XMD supported by ICR #10113
 ;Reference to ^XMB("NETNAME") supported by ICR #1131
 ;Reference to ^TMP($J supported by SACC 2.3.2.5.1
 ; 
 ;called from 2 unit dose routines - PSGPLF and PSGAMSA
 ;load UD data into an EC file for later extract to vendor
 N DA,DIK
 ;S X="ECXYUD1" X ^%ZOSF("TEST") I $T D ^ECXYUD1 ;181 - Commented out since routine did not exist
 I '$D(^ECX(728.904)) Q
 L +^ECX(728.904,0):1 Q:'$T
 S EC=$O(^ECX(728.904,999999999),-1),EC=EC+1
 S ^ECX(728.904,EC,0)=EC_U_ECUD L -^ECX(728.904,0)
 S DA=EC,DIK="^ECX(728.904," D IX^DIK
 K EC
 Q
SENDMSG ;181 - Called from ECXUD
 N ECMSG,ECX,XMSUB,XMDUZ,XMY,XMTEXT
 ;Send missing stop  code message
 S ECX=$O(^TMP($J,"ECXUDM","ECXNOSC",0))
 I ECX D
 .S XMSUB="CLINICS WITH MISSING STOP CODE in File #44",XMDUZ="DSS SYSTEM"
 .K XMY S XMY("G.DSS-"_ECGRP_"@"_^XMB("NETNAME"))=""
 .S ECMSG(1,0)="The DSS-"_ECPACK_" extract (#"_$P(EC23,U,2)_") for "_ECSDN_" through "_ECEDN
 .S ECMSG(2,0)="contains the following clinics which have not been assigned a stop code in the"
 .S ECMSG(3,0)="HOSPITAL LOCATION file (#44).  The DSS-"_ECPACK_" extract records associated"
 .S ECMSG(4,0)="with these clinics have been given a default Stop Code of ""PHA""."
 .S ECMSG(5,0)=""
 .S ECMSG(6,0)="CLIN IEN  CLINIC NAME"
 .S ECMSG(7,0)="-----------------------------------------"
 .S ECMSG(8,0)=""
 .S ECX=0
 .F  S ECX=$O(^TMP($J,"ECXUDM","ECXNOSC",ECX)) Q:ECX=""  S ECMSG(8+ECX,0)=^TMP($J,"ECXUDM","ECXNOSC",ECX,0)
 .S XMTEXT="ECMSG(" D ^XMD
 ;Send Inactive Stop Code message
 S ECX=$O(^TMP($J,"ECXUDM","ECXINVSC",0))
 I ECX D
 .S XMSUB="CLINICS WITH INACTIVE STOP CODE",XMDUZ="DSS SYSTEM"
 .K XMY S XMY("G.DSS-"_ECGRP_"@"_^XMB("NETNAME"))=""
 .S ECMSG(1,0)="The DSS-"_ECPACK_" extract (#"_$P(EC23,U,2)_") for "_ECSDN_" through "_ECEDN
 .S ECMSG(2,0)="contains the following clinics which have been assigned an inactive stop code"
 .S ECMSG(3,0)="in the HOSPITAL LOCATION file (#44).  The DSS-"_ECPACK_" extract records"
 .S ECMSG(4,0)="associated with these clinics have been given a default Stop Code of ""PHA""."
 .S ECMSG(5,0)=""
 .S ECMSG(6,0)="CLINIC IEN/NAME                         STOP CODE NUMBER/NAME "
 .S ECMSG(7,0)="--------------------------------------------------------------------"
 .S ECMSG(8,0)=""
 .S ECX=0
 .F  S ECX=$O(^TMP($J,"ECXUDM","ECXINVSC",ECX)) Q:ECX=""  S ECMSG(8+ECX,0)=^TMP($J,"ECXUDM","ECXINVSC",ECX,0)
 .S XMTEXT="ECMSG(" D ^XMD
 K ^TMP($J,"ECXUDM")
 Q

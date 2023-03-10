ECXEC1 ;ALB/CMD - Event Capture Extract Message ;May 12, 2021@21:12:10
 ;;3.0;DSS EXTRACTS;**181**;Dec 22, 1997;Build 71
 ;
 ;Reference to ^XMD supported by ICR #10113
 ;Reference to ^XMB("NETNAME") supported by ICR #1131
 ;Reference to ^TMP($J  supported by SACC 2.3.2.5.1
 ;
EN ;entry point from ECXEC
 N ECMSG,ECX,XMSUB,XMDUZ,XMY,XMTEXT
 ;send missing DSS Unit message
 S ECX=$O(^TMP($J,"ECXECM","NODSS",0))
 I ECX="" Q
 S XMSUB="PATIENTS WITH MISSING DSS UNIT in File #721",XMDUZ="DSS SYSTEM"
 K XMY S XMY("G.DSS-"_ECGRP_"@"_^XMB("NETNAME"))=""
 S ECMSG(1,0)="The DSS-"_ECPACK_" extract (#"_$P(EC23,U,2)_") for "_ECSDN_" through "_ECEDN
 S ECMSG(2,0)="contains the following records which do not have DSS UNITS in EVENT CAPTURE"
 S ECMSG(3,0)="PATIENT File #721.  Please use the option Event Capture - Enter/Edit Patient"
 S ECMSG(4,0)="Procedures to edit the records."
 S ECMSG(5,0)=""
 S ECMSG(6,0)="Patient (SSN)                              Procedure   Date/Time"
 S ECMSG(7,0)="------------------------------------------------------------------------------"
 S ECMSG(8,0)=""
 S ECX=0
 F  S ECX=$O(^TMP($J,"ECXECM","NODSS",ECX)) Q:ECX=""  S ECMSG(8+ECX,0)=^TMP($J,"ECXECM","NODSS",ECX,0)
 S XMTEXT="ECMSG(" D ^XMD
 Q

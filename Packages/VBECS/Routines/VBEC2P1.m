VBEC2P1 ;RLM/VBEC - VBECS PATCH PREINSTALL ROUTINE ; Jan 04, 2018@15:33
 ;;2.0;VBEC;**1**;Jun 05, 2015;Build 13
 ; Use of ^XPDUTL is supported by Integration Agreement: 10141
 ; Use of ^XMXAPI is supported by Integration Agreement: 2729
 ; Use of ^XPDIP is supported by Integration Agreement: 2067
ENV ;Environment Check
 K XPDQUIT,MSG
 I '(+$O(^LAB(60,"B","VBEC PATIENT REFLEX TEST",0))) D
  . S MSG(1)="The ""VBEC PATIENT REFLEX TEST"" test has not been created."
  . S MSG(2)="Please create the test with the following information"
  . S MSG(3)="and continue with the patch installation."
  . S MSG(4)=""
  . S MSG(5)=" NAME: VBEC PATIENT REFLEX TEST          TYPE: NEITHER"
  . S MSG(6)="  SUBSCRIPT: WORKLOAD                   HIGHEST URGENCY ALLOWED: ROUTINE"
  . S MSG(7)="  PRINT NAME: VBEC PATIENT REFLEX       CREATION DATE:"
  . S MSG(8)=""
  . S MSG(9)=""
  . S XPDQUIT=2 D MES^XPDUTL(.MSG)
 Q
PRE ;Pre Init
 ;Update version field
 N DIC,X,Y,Z
 S DIC(0)="BX",DIC="^DIC(9.4,",X="VBECS" D ^DIC Q:Y<0
 S Z=$$PKGVER^XPDIP(+Y,"2.0")
 Q
POST ;Post Init
 ;Send a message showing successful installation.
 K ^TMP("VBEC",$J)
 s ^TMP("VBEC",$J,1,0)="Patch VBEC*2*1 has been installed by "_$$GET1^DIQ(200,DUZ_",",".01","E","VBECN","ERR")_" at "_$P($$SITE^VASITE,"^",2)
 s ^TMP("VBEC",$J,2,0)=" "
 S VBECLAB=+$O(^LAB(60,"B","VBEC PATIENT REFLEX TEST",0)) I VBECLAB S VBECLAB1=$P($G(^LAB(60,VBECLAB,0)),"^")
 s ^TMP("VBEC",$J,3,0)=" NOTE! Reflex test has not been created!"
 I $G(VBECLAB1)]"" s ^TMP("VBEC",$J,3,0)=VBECLAB1_" has been created with IEN "_VBECLAB
 s ^TMP("VBEC",$J,4,0)=" "
 s ^TMP("VBEC",$J,5,0)="Current version is: "_$$VERSION^XPDUTL("VBEC")
 s XMSUB="VBEC*2*1 Patch Installation verification",XMTEXT="^TMP(""VBEC"",$J)",XMDUN="VBECS Patch Monitor"
 s XMY("G.VBEC@FORUM.DOMAIN.EXT")=""
 d SENDMSG^XMXAPI(DUZ,XMSUB,XMTEXT,.XMY)
 k ^TMP("VBEC",$J),XMY,XMSUB,VBECLAB,VBECLAB1
 q

VBEC2P3 ;RLM/VBEC - VBECS PATCH PREINSTALL ROUTINE ; Jan 04, 2018@15:33
 ;;2.0;VBEC;**3**;Jan 14 2019;Build 3
 ; Use of ^XPDUTL is supported by Integration Agreement: 10141
 ; Use of ^XMXAPI is supported by Integration Agreement: 2729
ENV ;Environment Check
 Q
PRE ;Pre Init
 Q
POST ;Post Init
 ;Send a message showing successful installation.
 K ^TMP("VBEC",$J)
 s ^TMP("VBEC",$J,1,0)="Patch VBEC*2*3 has been installed by "_$$GET1^DIQ(200,DUZ_",",".01","E","VBECN","ERR")_" at "_$P($$SITE^VASITE,"^",2)
 s ^TMP("VBEC",$J,2,0)=" "
 s ^TMP("VBEC",$J,3,0)="Current version is: "_$$VERSION^XPDUTL("VBEC")
 s XMSUB="VBEC*2*1 Patch Installation verification",XMTEXT="^TMP(""VBEC"",$J)",XMDUN="VBECS Patch Monitor"
 s XMY("G.VBEC@FORUM.DOMAIN.EXT")=""
 d SENDMSG^XMXAPI(DUZ,XMSUB,XMTEXT,.XMY)
 k ^TMP("VBEC",$J),XMY,XMSUB,VBECLAB,VBECLAB1
 q

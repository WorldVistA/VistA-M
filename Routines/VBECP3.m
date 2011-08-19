VBECP3 ;HIOFO;RLM VBECS PATCH 3 Post Install Routine ; 04/30/09 14:40
 ;;1.0;VBECS;**3**;Apr 14, 2005;Build 21
 ;
 ; Note: This routine supports data exchange with an FDA registered
 ; medical device. As such, it may not be changed in any way without
 ; prior written approval from the medical device manufacturer.
 ; 
 ; Integration Agreements:
 ; Reference to FILESEC^DDMOD supported by DBIA #2916
 ; Reference to ^XMD supported by DBIA #10113
 ; Reference to ^XPDUTL supported by DBIA #10141
 ; Reference to $$GET1^DIQ supported by DBIA #2056
 ; Reference to $$SITE^VASITE supported by DBIA #10112
ENV ; Environment Check
 ;Don't install the patch if 6002.03 hasn't been installed.
 q:$d(^VBEC(6002.03))
 s XPDQUIT=1
 ;Send a message showing unsuccessful installation.
 s ^TMP("VBEC",$J,1,0)="Patch VBEC*1.0*3 installation failed at "_$P($$SITE^VASITE,"^",2)
 s XMSUB="VBEC*1.0*3 Patch Installation Failure",XMTEXT="^TMP(""VBEC"",$J,",XMDUN="VBECS Patch Monitor"
 s ^TMP("VBEC",$J,2,0)="VBECS does not appear to be installed"
 d PATCH
 d ^XMD k ^TMP("VBEC",$J)
 q
POST ;Post Install entry point
 k DISEC
 s DISEC("DD")=""
 s DISEC("RD")=""
 s DISEC("WR")=""
 s DISEC("DEL")=""
 s DISEC("LAYGO")=""
 s DISEC("AUDIT")=""
 s DIFIL=6002.03
 ;Update the security in file 6002.03
 d FILESEC^DDMOD(DIFIL,.DISEC,"DIMSGA")
 ;Send a message showing successful installation.
 K ^TMP("VBEC",$J)
 s ^TMP("VBEC",$J,1,0)="Patch VBEC*1.0*3 has been installed by "_$$GET1^DIQ(200,DUZ_",",".01","E","VBECN","ERR")_" at "_$P($$SITE^VASITE,"^",2)
 s XMSUB="VBEC*1.0*3 Patch Installation verification",XMTEXT="^TMP(""VBEC"",$J)",XMDUN="VBECS Patch Monitor"
 s ^TMP("VBEC",$J,2,0)=$s($D(DIMSGA):"",1:"No ")_"errors encountered updating 6002.03"
 d PATCH
 s XMY("G.VBEC@FORUM.VA.GOV")=""
 d SENDMSG^XMXAPI(DUZ,XMSUB,XMTEXT,.XMY)
 ;d ^XMD
 k ^TMP("VBEC",$J)
 q
PATCH ;
 s ^TMP("VBEC",$J,3,0)=" ",^TMP("VBEC",$J,4,0)=" ",^TMP("VBEC",$J,5,0)="Previous Patches:"
 ;Update the loop in this line to reflect all released patches
 f VBECI=0:1:2 s VBECA=$$PATCH^XPDUTL("VBEC*1.0*"_VBECI),^TMP("VBEC",$J,(VBECI+6),0)="Patch VBEC*1.0*"_VBECI_" "_$S(VBECA=1:"has",1:"hasn't")_" been installed."
 q
EOR ;VBECP3

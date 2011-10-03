VBECP10 ;HIOFO;RLM VBECS PATCH 3 Post Install Routine ; 04/30/09 14:40
 ;;1.0;VBECS;**10**;Apr 14, 2005;Build 15
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
 ;Send a message showing successful installation.
 K ^TMP("VBEC",$J)
 s ^TMP("VBEC",$J,1,0)="Patch VBEC*1.0*10 has been installed by "_$$GET1^DIQ(200,DUZ_",",".01","E","VBECN","ERR")_" at "_$P($$SITE^VASITE,"^",2)
 s XMSUB="VBEC*1.0*10 Patch Installation verification",XMTEXT="^TMP(""VBEC"",$J)",XMDUN="VBECS Patch Monitor"
 d PATCH
 s XMY("G.VBEC@FORUM.VA.GOV")=""
 d SENDMSG^XMXAPI(DUZ,XMSUB,XMTEXT,.XMY)
 k ^TMP("VBEC",$J)
 q
PATCH ;
 s ^TMP("VBEC",$J,3,0)=" ",^TMP("VBEC",$J,4,0)=" ",^TMP("VBEC",$J,5,0)="Previous Patches:"
 ;Update the loop in this line to reflect all released patches
 f VBECI=1:1:9999 s VBECA=$$PATCH^XPDUTL("VBEC*1.0*"_VBECI) i VBECA s ^TMP("VBEC",$J,(VBECI+6),0)="Patch VBEC*1.0*"_VBECI_" has been installed."
 q
EOR ;VBECP10

HLOP158 ;ALB/CJM-Pre & Post install ;07/12/2012
 ;;1.6;HEALTH LEVEL SEVEN;**158**;Oct 13, 1995;Build 14
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
PRE ;
 I $P($G(^DD(779.1,.07,0)),"^")["(HOURS)" S ^TMP("HL*1.6*158")=1
 Q
POST ;
 I $G(^TMP("HL*1.6*158")) K ^TMP("HL*1.6*158") D
 .N PURGE
 .S PURGE=$P($G(^HLD(779.1,1,0)),"^",7)
 .I PURGE S PURGE=(PURGE\24)
 .I PURGE<3 S PURGE=3
 .S $P(^HLD(779.1,1,0),"^",7)=PURGE
NOPING N IEN
 S IEN=0
 F  S IEN=$O(^HLCS(870,IEN)) Q:'IEN  D
 .N LINK
 .S LINK=$P($G(^HLCS(870,IEN,0)),"^")
 .I $E(LINK,1)="V",LINK["VIE" S $P(^HLCS(870,IEN,0),"^",24)=1
 Q

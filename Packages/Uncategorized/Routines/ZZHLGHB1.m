ZZHLGHB1 ; HOIFO/WAA - Routine to get HL7 Data from HL logical links ;6/27/08
 ; version 1.4
 ;;;;;Jun 27, 2008;Build 88
EN1 ; [Procedure] Entry Point for Message Array
 S CNT=0
 K ARRAY
 D LINK
 D HEAD
 D BODY
 D TAIL
 S FILE="AXPINT$DISK:[AXPINT]HL7LINK.REP"
 O FILE:"NWS":1
 Q:'$T
 S CNT=-1 F  S CNT=$O(ARRAY(CNT)) Q:CNT=""  U FILE W ARRAY(CNT),!
 C FILE
 Q
LINK ;Loop through INPUT for all the links.
 N CCNT,NAME
 S CCNT=0,NAME=""
 F  S NAME=$O(^HLCS(870,"B",NAME)) Q:NAME=""  S INPUT(CCNT)=NAME,CCNT=CCNT+1
 Q
BLD(LINK) ; This subroutine will gather all the logical links and place them into input
 N NAME,IP,PORT,STAT,IEN,SUNODE
 S NAME=LINK
 S IEN=$O(^HLCS(870,"B",NAME,0))
 I $G(^HLCS(870,IEN,0))="" D  Q
 S IP=$$GET1^DIQ(870,IEN,400.01,"E")
 I IP="" S IP=$$GET1^DIQ(870,IEN,400.08,"E")
 S PORT=$$GET1^DIQ(870,IEN,400.02,"E")
 S SUNODE=$$GET1^DIQ(870,IEN,400.06,"E")
 S STAT=$$GET1^DIQ(870,IEN,4,"E")
 Q:($P($G(LinkFilter),"=",1)="FILTER")&'(NAME[$P($G(LinkFilter),"=",2))
 Q:($P($G(IPFilter),"=",1)="FILTER")&'(IP[$P($G(IPFilter),"=",2))
 Q:($P($G(PortFilter),"=",1)="FILTER")&'(PORT[$P($G(PortFilter),"=",2))
 Q:($P($G(StatusFilter),"=",1)="FILTER")&'(STAT[$P($G(StatusFilter),"=",2))
 S ARRAY(CNT)="<tr>",CNT=CNT+1
 S ARRAY(CNT)="<td>"
 I ($P($G(LinkFilter),"=",1)="HIGHLIGHT")&(NAME[$P($G(LinkFilter),"=",2)) S ARRAY(CNT)="<td bgcolor=""#0099FF"">"
 S ARRAY(CNT)=ARRAY(CNT)_NAME_"</td>",CNT=CNT+1
 S ARRAY(CNT)="<td>"
 I ($P($G(IPFilter),"=",1)="HIGHLIGHT")&(IP[$P($G(IPFilter),"=",2)) S ARRAY(CNT)="<td bgcolor=""#0099FF"">"
 S ARRAY(CNT)=ARRAY(CNT)_IP_"&nbsp; </td>",CNT=CNT+1
 S ARRAY(CNT)="<td>"
 I ($P($G(PortFilter),"=",1)="HIGHLIGHT")&(PORT[$P($G(PortFilter),"=",2)) S ARRAY(CNT)="<td bgcolor=""#0099FF"">"
 S ARRAY(CNT)=ARRAY(CNT)_PORT_"&nbsp; </td>",CNT=CNT+1
 S ARRAY(CNT)="<td>"
 I ($P($G(StatusFilter),"=",1)="HIGHLIGHT")&(STAT[$P($G(StatusFilter),"=",2)) S ARRAY(CNT)="<td bgcolor=""#0099FF"">"
 S ARRAY(CNT)=ARRAY(CNT)_STAT_"&nbsp; </td>",CNT=CNT+1
 ;S ARRAY(CNT)="<td>"_SUNODE_"</td>",CNT=CNT+1
 S ARRAY(CNT)="</tr>",CNT=CNT+1
 Q
HEAD ; Build head of HTML Table
 S ARRAY(CNT)="<!DOCTYPE html PUBLIC ""-//W3C//DTD HTML 4.01 Transitional//EN"">",CNT=CNT+1
 S ARRAY(CNT)="<HTML>",CNT=CNT+1
 S ARRAY(CNT)="<HEAD>",CNT=CNT+1
 S ARRAY(CNT)="<meta content=""text/html;charset=ISO-8859-1"" http-equiv=""Content-Type"">",CNT=CNT+1
 S ARRAY(CNT)="<title>HL LOGICAL LINK STATUS DISPLAY</title>",CNT=CNT+1
 S ARRAY(CNT)="</HEAD>",CNT=CNT+1
 S ARRAY(CNT)="<BODY>",CNT=CNT+1
 Q
TAIL ; Build Tail of HTML Table
 S ARRAY(CNT)="</BODY>",CNT=CNT+1
 S ARRAY(CNT)="</HTML>",CNT=CNT+1
 Q
BODY ; Build body of report
 N LNK
 S LNK=""
 S ARRAY(CNT)="<BR><TABLE STYLE=""width: 6.5in; text-align: left;"" border=""1"" cellpadding=""3"" cellspacing=""2"">",CNT=CNT+1
 S ARRAY(CNT)="<TBODY>",CNT=CNT+1
 D HDR
 F  S LNK=$O(INPUT(LNK)) Q:LNK=""  D BLD(INPUT(LNK))
 S ARRAY="</TBODY>",CNT=CNT+1
 S ARRAY="</TABLE>",CNT=CNT+1
 Q
HDR ; Build the row with all the col labels
 S ARRAY(CNT)="<tr>",CNT=CNT+1
 S ARRAY(CNT)="<td><b>Node</b></td>",CNT=CNT+1
 S ARRAY(CNT)="<td><b>Configuration</b></td>",CNT=CNT+1
 S ARRAY(CNT)="<td><b>Namespace</b></td></tr>",CNT=CNT+1
 S ARRAY(CNT)="<tr>",CNT=CNT+1
 S ARRAY(CNT)="<td>"_$ZU(110)_"</td>",CNT=CNT+1
 S ARRAY(CNT)="<td>"_$P($ZU(86),"*",2)_"</td>",CNT=CNT+1
 S ARRAY(CNT)="<td>"_$ZU(5)_"</td></tr></table>",CNT=CNT+1
 S ARRAY(CNT)="<BR><TABLE STYLE=""width: 6.5in; text-align: left;"" border=""1"" cellpadding=""3"" cellspacing=""2"">",CNT=CNT+1
 S ARRAY(CNT)="<tr>",CNT=CNT+1
 S ARRAY(CNT)="<td><b>HL Logical Link</b><br></td>",CNT=CNT+1
 S ARRAY(CNT)="<td><b>IP</b><br></td>",CNT=CNT+1
 S ARRAY(CNT)="<td><b>Port</b><br></td>",CNT=CNT+1
 S ARRAY(CNT)="<td><b>Status</b><br></td>",CNT=CNT+1
 ; S ARRAY(CNT)="<td><b>Total Time:</b><br></td>",CNT=CNT+1
 ; S ARRAY(CNT)="<td><b>Notes:</b><br></td>",CNT=CNT+1
 S ARRAY(CNT)="</tr>",CNT=CNT+1
 Q

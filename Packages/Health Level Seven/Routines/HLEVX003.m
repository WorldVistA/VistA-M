HLEVX003 ;O-OIFO/LJA - VistA HL7 Event Monitor Code ;02/04/2004 15:25
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
REPDINUM ; Create event log entry(s) for DINUM problems.  (Use the
 ; condensed report text instead of making one event for every DINUM
 ; problem.)
 ;
 ; {01/16/04 - Added so wouldn't create thousands of events.}
 ;
 N LINK,LN,NO,PROB,QUIT,TAG,TXT,WAY
 ;
 KILL ^TMP($J,"HLEVDINUM")
 ;
 S LN=0,PROB="",QUIT=0,WAY="",LINK=""
 F  S LN=$O(^TMP($J,"HLEVREP",LN)) Q:'LN!(QUIT)  D
 .  S TXT=^TMP($J,"HLEVREP",LN)
 .  I $P(TXT," ")="DINUM" S PROB="DINUM",WAY="",LINK=""
 .  QUIT:PROB'="DINUM"  ;-> No DINUMs, or not to them yet...
 .  ; $$RDT returns LINK and WAY...
 .  S TXT=$$RDT(TXT) QUIT:TXT']""!(LINK']"")!(WAY']"")  ;->
 .  F NO=1:1:$L(TXT,",") D
 .  .  S TXT(1)=$P(TXT,",",NO) QUIT:TXT(1)']""  ;->
 .  .  S ^TMP($J,"HLEVDINUM",LINK,WAY,TXT(1))=""
 ;
 ; No DINUM problems exist...
 S LINK=""
 F  S LINK=$O(^TMP($J,"HLEVDINUM",LINK)) Q:LINK']""  D
 .  S WAY=""
 .  F  S WAY=$O(^TMP($J,"HLEVDINUM",LINK,WAY)) Q:WAY']""  D
 .  .  S MIENS=""
 .  .  F  S MIENS=$O(^TMP($J,"HLEVDINUM",LINK,WAY,MIENS)) Q:MIENS']""  D
 .  .  .  S X=$$LOG^HLEVAPI2("870-DINUM","LINK^WAY^MIENS")
 ;
 KILL ^TMP($J,"HLEVDINUM")
 ;
 Q
 ;
RDT(TXT) ; Strip down TXT to include only DINUM report details...
 ; Returns LINK & WAY...
 ;
 ; {01/16/04 - See REPDINUM}
 ;
 ; First line of DINUM INCOMING or OUTGOING...
 I TXT["  INCOMING  " D  QUIT $P(TXT,"COMING  ",2,99)  ;->
 .  S LINK=$P($E(TXT,16,99),"]")_"]"
 .  S WAY="INCOMING"
 .
 I TXT["  OUTGOING  " D  QUIT $P(TXT,"GOING  ",2,99)  ;->
 .  S LINK=$P($E(TXT,16,99),"]")_"]"
 .  S WAY="OUTGOING"
 ;
 ; Strip spaces and check pattern match...
 S TXT=$TR(TXT," ","") QUIT:TXT']"" "" ;->
 QUIT:TXT'?1.N1":"1.N1"(#"1.N1")".E "" ;->
 ;
 Q TXT
 ;
EOR ;HLEVX003 - VistA HL7 Event Monitor Code ;5/30/03 15:25

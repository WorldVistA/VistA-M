HLOUSRA ;ALB/CJM -ListManager Screen for viewing downed links;12 JUN 1997 10:00 am ;07/23/2008
 ;;1.6;HEALTH LEVEL SEVEN;**130,138**;Oct 13, 1995;Build 34
 ;
HEADER ;
 S VALMSG="Down Client Links"
 S VALMDDF("COL 2")="COL 2^20^20^Pending Messages^H"
 S VALMDDF("COL 3")="COL 3^47^20^Date/Time Down^H"
 K VALMDDF("COL 4"),VALMDDF("COL 5")
 D CHGCAP^VALM("COL 1","Client Link")
 Q
 ;
HELP ;Help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ;Exit code
 D CLEAN^VALM10
 D CLEAR^VALM1
 S VALMBCK="R"
 ;
 Q
 ;
DOWNLINK ;
 D EN^VALM("HLO DOWN LINKS")
 D:$L($G(HLRFRSH)) @HLRFRSH
 Q
 ;
RESTART ;
 ;Allows the user to select a link and restarts HLO messages flowing to that domain.
 N LINKARY
 S VALMBCK="R"
 ;
 S LINK=$$ASKLINK
 Q:LINK=""
 I $$GETLINK^HLOTLNK(LINK,.LINKARY) D
 .I $$SETOPEN^HLOTLNK(LINKARY("IEN")) K ^HLTMP("FAILING LINKS",LINK_":"_LINKARY("PORT")) S VALMSG="HLO messages across "_LINKARY("NAME")_" have been started..."
 .D LISTDOWN
 Q
 ;
LISTDOWN ;
 N LINK
 D CLEAN^VALM10
 S VALMCNT=0
 S LINK=""
 F  S LINK=$O(^HLTMP("FAILING LINKS",LINK)) Q:LINK=""  D
 .N TIME,COUNT,QUE,LINKARY
 .I $$GETLINK^HLOTLNK($P(LINK,":"),.LINKARY)
 .S TIME=$G(^HLTMP("FAILING LINKS",LINK))
 .I '$G(LINKARY("SHUTDOWN")),TIME="" Q
 .I '$G(LINKARY("SHUTDOWN")),($$HDIFF^XLFDT($H,TIME,2)<300) Q
 .S TIME=$$HTE^XLFDT(TIME)
 .S COUNT=0
 .S QUE=""
 .F  S QUE=$O(^HLC("QUEUECOUNT","OUT",LINK,QUE)) Q:QUE=""  S COUNT=COUNT+$G(^HLC("QUEUECOUNT","OUT",LINK,QUE))
 .S VALMCNT=VALMCNT+1
 .S @VALMAR@(VALMCNT,0)=$$LJ(LINK,15)_$$RJ(COUNT,15)_"    "_$$RJ(TIME,30)_"  "_$S($G(LINKARY("SHUTDOWN")):"SHUTDOWN",1:"")
 Q
 ;
STOPLINK ;
 N LINK,LINKARY
 S VALMBCK="R"
 ;
 S LINK=$$ASKLINK
 Q:LINK=""
 I $$GETLINK^HLOTLNK(LINK,.LINKARY) D
 .S LINK=LINK_":"_LINKARY("PORT")
 .I $$SETSHUT^HLOTLNK(LINKARY("IEN")) S VALMSG="HLO messages across "_LINKARY("NAME")_" have been stopped..."
 .S ^HLTMP("FAILING LINKS",LINK)=$G(^HLTMP("FAILING LINKS",LINK),$H)
 .S ^HLB("QUEUE","OUT",LINK)=$H
 .D LISTDOWN
 Q
 ;
CJ(STRING,LEN) ;
 Q $$CJ^XLFSTR($E(STRING,1,LEN),LEN)
LJ(STRING,LEN) ;
 Q $$LJ^XLFSTR($E(STRING,1,LEN),LEN)
RJ(STRING,LEN) ;
 Q $$RJ^XLFSTR($E(STRING,1,LEN),LEN)
 ;
ASKLINK() ;
 ;returns the name
 N DIC,TCP,X,Y,DTOUT,DUOUT
 S DIC=870
 S DIC(0)="AENQ"
 S TCP=$O(^HLCS(869.1,"B","TCP",0))
 S DIC("A")="Select a TCP Client Link (Outgoing):"
 S DIC("S")="I $P(^(0),U,3)=TCP,$P(^(400),U,3)=""C"""
 D FULL^VALM1
 D ^DIC
 I +Y'=-1,'$D(DTOUT),'$D(DUOUT) Q $P(Y,"^",2)
 Q ""
 ;
ASKPORT(LINKNAME)        ;
 Q:'$L($G(LINKNAME)) 0
 N DIR,X,DTOUT,DUOUT,PORT
 S DIR(0)="N^1:65535:0"
 S DIR("A")="PORT"
 S DIR("B")=$$PORT2^HLOTLNK(LINKNAME)
 S DIR("?",1)="Enter to specify a port other than the one that this link is configured"
 S DIR("?")="to normally use, otherwise just accept the default port."
 D ^DIR
 Q:$D(DTOUT)!$D(DUOUT) 0
 Q X

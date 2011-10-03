XMDIRQST ;(WASH ISC)/CWU-Request Email Directory ;04/18/2002  07:31
 ;;8.0;MailMan;;Jun 28, 2002
 ; Entry points used by MailMan options (not covered by DBIA):
 ; ALL      XMMGR-DIRECTORY-ALL
 ; EDIT     XMMGR-DIRECTORY-EDITGRP
 ; GROUP    XMMGR-DIRECTORY-GROUP
 ; LISTGRP  XMMGR-DIRECTORY-LISTGRP
 ; SINGLE   XMMGR-DIRECTORY-SINGLE
 Q
ALL N DIR,Y,A,DTOUT,DUOUT,NETADDR,XMSUB,XMY,ZTDTH,ZTSAVE
 S DIR(0)="Y"
 S DIR("A")="Request directories from all domains"
 S DIR("B")="NO"
 S DIR("?")="Enter YES to request directories from all domains."
 D ^DIR I $D(DIRUT)!'Y Q
 S I=0 F  S I=$O(^DIC(4.2,I)) Q:I'=+I  D S(I)
 Q
SINGLE ;Send a request to one Domain
 W !!,"Choose Domains to request Email Directories for."
 N DIC,X,Y
 S DIC("A")="Select DOMAIN Name: ",DIC="^DIC(4.2,",DIC(0)="AEQZ"
 D ^DIC Q:Y<0
 D S(+Y)
 Q
S(I) ;Schedule Task to Send Request to Domain
 N %,X,R ; I=IEN
 ;Do not send if No Domain Information, etc.
 S %=$G(^DIC(4.2,+I,0)) I %="" W $C(7),"  ???  No entry in Domain File (4.2) for domain '",I,"'.  [S(I)+2^XMDIRQST]" Q
 S X=$P(%,U),R=$P(%,U,3) I R W $C(7),"  ??? The directory request for ",X," (`",I,") is NOT permitted since it is accessed via relay domain '",$P($G(^DIC(4.2,+R,0)),U)," (`",R,").  [S(I)+3^XMDIRQST]  " Q
 I X["FOC-AUSTIN" W $C(7),"  ???  The request for a directory from ",X," (`",I,") is NOT permitted as it is through FOC-AUSTIN.  [S(I)+4^XMDIRQST]" Q
 I $E(X,1,2)="Q-" W $C(7),"  ???  The request for a directory from ",X," (`",I,") is NOT permitted since it is a relay domain (Q-...).  [S(I)+5^XMDIRQST]" Q
 I X=^XMB("NETNAME") W $C(7),"  ???  You may not request a directory from your own site." Q
TASK ; Set up Task
 N XMTASK,NETADDR
 S XMTASK=$G(ZTSK) N ZTSK
 S NETADDR=X,ZTSAVE("NETADDR")=""
 S ZTRTN="ONE^XMDIRQST",ZTDTH=+$H_",64800"
 S ZTIO="",ZTDESC="Email Directory Request to - "_X
 D ^%ZTLOAD
 I 'XMTASK W !!,$C(7),"TASK #"_ZTSK_" scheduled for "_NETADDR
 Q
ONE ;
 N XMTEXT,XMINSTR
 S XMINSTR("FROM")=.5
 S XMTEXT(1)="Directory request"
 D SENDMSG^XMXSEND(.5,"Request for Email Address Directory","XMTEXT","S.XMMGR-DIRECTORY-SEND@"_NETADDR,.XMINSTR)
 Q
LISTGRP ;
 N LSTBYGRP S LSTBYGRP=1
GROUP ;
 N DIR,Y,DTOUT,DUOUT,NETADDR,XMGROUP,XMSUB,XMY,ZTDTH,ZTSAVE,ZTSK
 S DIC="^DIC(4.2,",DIC(0)="AQZXC"
 K DO S D="AE",DIC("A")="Enter Directory Group Number: "
 S DIC("S")="I $O(^DIC(4.2,""AE"",X,""""))=+Y"
 D IX^DIC
 Q:Y<1  S (X,XMGROUP)=+^DIC(4.2,+Y,50)
 W !!,"Group Number ",X," contains following Domain names : "
 S I=0 F  S I=$O(^DIC(4.2,"AE",X,I)) Q:I=""  W !,$P(^DIC(4.2,I,0),U)
 W !!
 Q:$G(LSTBYGRP)
 S DIR(0)="Y"
 S DIR("A")="Do you wish to schedule Directory Request(s) for group number "_XMGROUP
 S DIR("B")="NO"
 S DIR("?")="Enter YES if you wish to request directories from all domains in the group."
 D ^DIR Q:$D(DIRUT)!'Y
 S I=0 F  S I=$O(^DIC(4.2,"AE",XMGROUP,I)) Q:I=""  D S(I)
 Q
EDIT ;
 W !!,"Enter the Domain name whose Directory Requests Flag you wish to edit."
 K DIC S DIC="^DIC(4.2,",DIC(0)="AEQZ" D ^DIC
 Q:$D(DTOUT)!$D(DUOUT)!(Y<1)
 S DIE="^DIC(4.2,",DA=+Y,DR=50 D ^DIE
 G EDIT

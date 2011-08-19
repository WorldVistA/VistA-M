KMPRSS ;OAK/RAK - Resource Usage Monitor Status ;11/19/04  10:32
 ;;2.0;CAPACITY MANAGEMENT - RUM;**1**;May 28, 2003
 ;
STAT ;--display rum environment
 ;
 D EN^KMPRSSB
 ;
 Q
 ;
START ; Start Resource Usage Monitor collection
 N CHECK,DA,DIE,DIR,DR,X,Y
 ; check environment
 D ENVCHECK^KMPRUTL1(.CHECK,1)
 ; if RUM does not support this operating system then quit.
 I (+CHECK)=100 W !! D ENVOUTPT^KMPRUTL1(CHECK,1,1) H 1 Q
 I +$G(^%ZTSCH("LOGRSRC")) W !!,?10,"The Resource Usage Monitor is already running.",! H 1 Q
 W ! K DIR S DIR(0)="Y",DIR("B")="YES"
 S DIR("?")="Answer YES to start collecting Resource Usage Monitor data"
 S DIR("A")="Do you want to start Resource Usage Monitor collection"
 D ^DIR Q:$D(DTOUT)!$D(DUOUT)
 I Y D
 .S DIE=8989.3,DA=1,DR="300///YES" D ^DIE
 .W !!,?10,"Resource Usage Monitor collection is started.",!
 .D ENVCHECK^KMPRUTL1(.CHECK,1)
 .; if background driver not scheduled to run then start it up
 .D:(+CHECK=200) QUEBKG^KMPRUTL1
 E  W !!,?10,"Resource Usage Monitor collection is NOT started.",!
 H 1
 Q
 ;
STOP ; Stop Resource Usage Monitor collection
 N DA,DIE,DIR,DR,DTOUT,DUOUT,X,Y
 I '+$G(^%ZTSCH("LOGRSRC")) W !!,?10,"The Resource Usage Monitor is already stopped.",! H 1 Q
 W ! K DIR S DIR(0)="Y",DIR("B")="YES"
 S DIR("?")="Answer YES to stop collecting Resource Usage Monitor data"
 S DIR("A")="Do you want to stop Resource Usage Monitor collection"
 D ^DIR Q:$D(DTOUT)!$D(DUOUT)
 I Y D
 .S DIE=8989.3,DA=1,DR="300///NO" D ^DIE
 .W !!,?10,"Resource Usage Monitor collection is stopped.",!
 E  W !!,?10,"Resource Usage Monitor collection is NOT stopped.",!
 H 1
 Q

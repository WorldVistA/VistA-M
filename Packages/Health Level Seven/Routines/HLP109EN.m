HLP109EN ;OIFO-O/RJH - HL*1.6*109 ENVIRONMENTT CHECK ROUTINE ;12/11/2003
 ;;1.6;HEALTH LEVEL SEVEN;**109**;OCT 13, 1995
 ;
EN ; Check environment...
 N ACTION
 ;
 ; If no AC,I xrefs...
 I $O(^HLMA("AC","I",0))'>0 D  QUIT  ;->
 .  W !!,"Environment check OK..."
 .  W !
 ;
 ; AC,I xrefs exist.  So, if loading, just warn.  Otherwise, stop!
 ;
 ; Set ACTION=1 if loading, and ACTION=2 if installing...
 S ACTION=$$UP^XLFSTR($G(XQY0)),ACTION=$S(ACTION["LOAD":1,1:2)
 ;
 S X="IOINHI;IOINORM" D ENDR^%ZISS
 S X=$$REPEAT^XLFSTR("=",35) W !!,X," ",IOINHI,"Warning",IOINORM," ",X
 D @("INFORM"_ACTION)
 ;
 I ACTION=2 S XPDABORT=2 ; Stop, but don't unload...
 ;
 W !
 S X=$$BTE("Press RETURN to "_$S(ACTION=1:"continue",1:"exit")_"...")
 ;
 Q
 ;
BTE(PMT) ; 
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="EA",DIR("A")=PMT
 D ^DIR
 Q $S(+Y=1:1,1:"")
 ;
INFORM1 ; General information when AC,Is exist and LOADing...
 W !,"There are inbound queues with un-processed messages.  Before patch HL*1.6*109"
 W !,"can be installed, the inbound queues must be empty.  You may continue loading"
 W !,"these patches.  But, remember to clear the inbound queues before loading."
 W !!,"(To clear the queues, start one or more incoming filer(s) to process the"
 W !,"messages until there are no messages in the queue.)"
 Q
 ;
INFORM2 ; General information when AC,Is exist and INSTALLing...
 W !,"There are inbound queues with un-processed messages.  Before patch HL*1.6*109"
 W !,"can be installed, the inbound queues must be empty.  Start one or more"
 W !,"incoming filer(s) to process the messages until there are no messages in the"
 W !,"queue.  Then, try to install patch HL*1.6*109 again."
 Q
 ;

KMPDSS ;OAK/RAK,JML - CM Tools Status ;2/14/05
 ;;4.0;CAPACITY MANAGEMENT;;11/15/2017;Build 38
 ;
EN ;-entry point
 ;
 N DIR,OUT,X,Y
 ;
 S OUT=0
 F  D  Q:OUT
 .D HDR^KMPDUTL4(" Check Capacity Planning Environment ")
 .S DIR(0)="SO^H:HL7;S:SAGG;T:Timing"
 .W !! D ^DIR I Y=""!(Y="^") SET OUT=1 Q
 .D DISPLAY^KMPDSS1(Y_"^"_Y(0))
 ;
 Q
 ;
VERDSPL(KMPDPKG) ;--display routine version info
 ;-----------------------------------------------------------------------
 ; KMPDPKG... CM Package:
 ;            "D" - CM Tools
 ;            "R" - RUM - Decommissioned
 ;            "S" - SAGG
 ;-----------------------------------------------------------------------
 Q:$G(KMPDPKG)=""
 Q:KMPDPKG'="D"&(KMPDPKG'="S")
 N I,X
 ; routine check
 D VERPTCH^KMPDUTL1(KMPDPKG,.X)
 W !?5,$S(KMPDPKG="D":"CM TOOLS",1:"SAGG")
 W " routines",$$REPEAT^XLFSTR(".",28-$X),": "
 I '$P($G(X(0)),U,3) W "No Problems"
 E  D 
 .W !?20,"Current Version",?55,"Should be"
 .S I=0 F  S I=$O(X(I)) Q:I=""  I $P(X(I),U) D 
 ..W !?3,I,?20,$P(X(I),U,4)
 ..W:$P(X(I),U,5)]"" " - ",$P(X(I),U,5)
 ..W ?55,$P(X(I),U,2)
 ..W:$P(X(I),U,3)]"" " - ",$P(X(I),U,3)
 Q
 ;
PRM ;-- edit parameters file
 ;
 N DDSFILE,DR,DA
 ;
 S DA=$O(^KMPD(8973,0)) Q:'DA
 S DDSFILE=8973,DR="[KMPD PARAMETERS EDIT]" D ^DDS
 ;
 Q
 ;
SST ;-- start/stop coversheet collection
 ; check for cprs patch
 I '$$PATCH^XPDUTL("OR*3.0*209") D  Q
 .W !! D EN^DDIOL($C(7)_"*** Patch OR*3.0*209 must be installed for CPRS Timing data to be collected ***")
 ;
 N DIR,STAT,X,Y
 S STAT=$G(^KMPTMP("KMPD-CPRS"))
 W !!!,"Timing Collection is currently [ ",$S(STAT:"Running",1:"STOPPED")," ]",!
 S DIR(0)="YO",DIR("B")="N"
 S DIR("A")="Do you want to '"_$S(STAT:"Stop",1:"Start")_"' the collection"
 D ^DIR Q:'Y
 S ^KMPTMP("KMPD-CPRS")=$S(STAT:"",1:1)
 W !!,"Timing Collection has been [ ",$S(STAT:"STOPPED",1:"Started")," ]"
 Q

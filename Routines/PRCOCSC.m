PRCOCSC ;WISC/DJM - Generic Code Sheet Status Change ;4/23/96  9:53 AM
V ;;5.0;IFCAP;**70**;4/21/95
 ;CREATED FROM Tampa/RAK
EN ;-- entry point.
 N %ZIS,CRDT,DIRPOP,PRINT,X,Y,ZTDESC,ZTRTN,ZTSAVE,%
 S %H="56673,0"
 D YMD^%DTC
 S CRDT=X
 ;
 W @IOF,*7,!!
 W !?10,"This routine changes ALL code sheets created before "
 W !?10,"'",$$FMTE^XLFDT(CRDT),"' that have a status of 'TRANSMITTED'"
 W !?10,"and changes the status to 'ACCEPTED BY FMS'."
 ;
 K DIR S DIR(0)="Y",DIR("A")="Do you wish to continue",DIR("B")="NO"
 W !! D ^DIR Q:Y'=1
 ;
 K DIR S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Do you wish to print the Document Identifier of each code"
 S DIR("A")=DIR("A")_"sheet changed"
 W ! D ^DIR Q:Y="^"  S PRINT=+Y
 ;
 ;-- get output device.
 S %ZIS("S")="S AA=$G(^%ZIS(1,Y,""SUBTYPE"")) I AA>0,$E($G(^%ZIS(2,AA,0)),1)[""P"""
 S %ZIS="QM",%ZIS("A")="Device: ",%ZIS("B")=""
 W ! D ^%ZIS I POP W "  no action taken." Q
 I $D(IO("Q")) K IO("Q") D  Q
 .S ZTDESC="Change Generic Code Sheet Status"
 .S ZTRTN="EN1^PRCOCSC",ZTSAVE("CRDT")="",ZTSAVE("PRINT")=""
 .D ^%ZTLOAD W:$G(ZTSK) !,"Task #",ZTSK
 .Q
 ;
EN1 ;-- entry point from taskman.
 N COUNT,DATA,FDA,IEN,MESSAGE,NUMBER,OFFSET,PRTNUM,AA
 S COUNT=0,OFFSET=25,NUMBER=IOM\OFFSET,PRTNUM=1
 S CRDT=$G(CRDT),PRINT=+$G(PRINT)
 I 'CRDT W !,"No Create Date (CRDT).  Program exiting." D EXIT Q
 U IO
 W !,$$FMTE^XLFDT($$NOW^XLFDT)
 W !
 W !,"Changing Generic Code Sheets created before ",$$FMTE^XLFDT(CRDT)
 W !,"                           from a status of 'TRANSMITTED'"
 W !,"                             to a status of 'ACCEPTED BY FMS'."
 W !
 S IEN=0
 ;-- $order through the "AS" x-ref (STATUS).
 F  S IEN=$O(^GECS(2100.1,"AS","T",IEN)) Q:'IEN  D
 .Q:'$D(^GECS(2100.1,IEN,0))  S DATA=^(0)
 .;
 .;-- quit if DATE@TIME CREATED is not less than CRDT.
 .Q:$P(DATA,U,3)'<CRDT
 .;
 .;-- make sure STATUS is 'transmitted'.
 .Q:$P(DATA,U,4)'="T"
 .;
 .;-- if user selected to print document identifier.
 .I PRINT D
 ..W:PRTNUM=1 !
 ..W ?($S(PRTNUM=1:0,1:OFFSET*(PRTNUM-1))),$P(DATA,U)
 ..S PRTNUM=$S(PRTNUM=NUMBER:1,1:PRTNUM+1)
 .;
 .K FDA,MESSAGE
 .;
 .;-- status.
 .S FDA($J,2100.1,IEN_",",3)="A"
 .;
 .;-- change STATUS to'accepted by fms'.
 .D FILE^DIE("","FDA($J)","MESSAGE")
 .;
 .;-- if error.
 .I $D(MESSAGE) D  Q
 ..W !,$P(DATA,U),!
 ..D MSG^DIALOG("W","",60,10,"MESSAGE")
 ..W !
 .;
 .S COUNT=COUNT+1
 .;
 .;-- if not printing document identifier and output is to a terminal
 .;-- then print dots.
 .W:'PRINT&($E(IOST,1,2)="C-")&('(COUNT#100)) "."
 ;
 W !!,COUNT," record",$S(COUNT=1:"",1:"s")," updated."
 ;
EXIT ;
 S:$D(ZTQUEUED) ZTREQ="@"
 D ^%ZISC
 S X="PRCOCSC"
 S AA=^%ZOSF("DEL")
 X AA
 Q

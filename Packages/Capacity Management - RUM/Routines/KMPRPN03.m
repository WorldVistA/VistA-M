KMPRPN03 ;OAK/RAK - Print Package RUM Stats ;11/19/04  09:01
 ;;2.0;CAPACITY MANAGEMENT - RUM;**1**;May 28, 2003
EN ;-- entry point.
 ;
 N %ZIS,CONT,DIR,KMPRDATE,KMPRNAM,MESSAGE,POP
 N X,Y,ZTDESC,ZTRTN,ZTSAVE,ZTSK
 ;
 D HDR^KMPDUTL4(" Package Resource Usage ")
 W !,?2,"This option will display the package Resource Usage Monitor statistics.",!
 W ?2,"The printout summarizes the statistics of the options, protocols and",!
 W ?2,"tasks for a selected namespace as percentages.",!!
 ;
 K DIR S DIR(0)="FO^1:999:0^K:X="" "" X"
 S DIR("A")="Select Package Namespace (case sensitive)"
 D ^DIR Q:Y=""!(Y="^")
 S KMPRNAM=Y
 ;
 ; determine start date from file 8970.1
 D RUMDATES^KMPRUTL(.KMPRDATE)
 Q:'KMPRDATE
 ;
 ; select output device.
 S %ZIS="Q",%ZIS("A")="Device: ",%ZIS("B")="HOME"
 W ! D ^%ZIS I POP W !,"No action taken." Q
 ; if queued.
 I $D(IO("Q")) K IO("Q") D  Q
 .S ZTDESC="RUM Package Resource Usage for '"_KMPRNAM_"'."
 .S ZTRTN="EN1^KMPRPN03"
 .S ZTSAVE("KMPRDATE")="",ZTSAVE("KMPRNAM")=""
 .D ^%ZTLOAD W:$G(ZTSK) !,"Task #",ZTSK
 .D EXIT
 ;
 ; if output to terminal display message.
 W:$E(IOST,1,2)="C-" !?3,"compiling data for: "
 ;
EN1 ;-- entry point from taskman.
 ;
 Q:'$G(KMPRDATE)
 Q:$G(KMPRNAM)=""
 ;
 N DOTS,ELEMENT,KMPRARRY
 ;
 S DOTS=$S($E(IOST,1,2)="C-":0,1:1)
 D ELEARRY^KMPRUTL("ELEMENT") Q:'$D(ELEMENT)
 S KMPRARRY=$NA(^TMP("KMPR PKG %",$J))
 K @KMPRARRY
 D PKGDATA^KMPRUTL2(KMPRNAM,$P(KMPRDATE,U),$P(KMPRDATE,U,2),KMPRARRY,DOTS)
 D PRINT,EXIT
 K @KMPRARRY
 ;
 Q
 ;
EXIT ;
 S:$D(ZTQUEUED) ZTREQ="@"
 D ^%ZISC
 K KMPUDATE,KMPUNAM
 ;
 Q
 ;
PRINT ;-- print data from KMPRARRY.
 ;
 Q:'$D(ELEMENT)
 Q:$G(KMPRARRY)=""
 ;
 U IO
 ;
 I '$D(@KMPRARRY) D HDR W !,"<<<No Data to Report>>>" Q
 ;
 N DATA,I,NODE,PIECE,SITE,TOTALS,TYP
 ;
 ; facility name.
 S SITE=$P($$SITE^VASITE,U,2)
 S NODE="",CONT=1
 F  S NODE=$O(@KMPRARRY@(NODE)) Q:NODE=""  D  Q:'CONT
 .D HDR S I=0
 .F  S I=$O(ELEMENT(I)) Q:'I  D  Q:'CONT
 ..W !,$P(ELEMENT(I),U) S PIECE=$P(ELEMENT(I),U,2)
 ..S TOTALS=$P($G(@KMPRARRY@(NODE,"TOTALS")),U,PIECE)
 ..F TYP=KMPRNAM,"PRTCL","RPC","HL7","TASK","OTH" D 
 ...S DATA=$P($G(@KMPRARRY@(NODE,TYP)),U,PIECE)
 ...W ?($S(TYP=KMPRNAM:20,TYP="PRTCL":30,TYP="RPC":40,TYP="HL7":50,TYP="TASK":60,1:70))
 ...W $J($S('TOTALS:"n/a",1:$FN(DATA/TOTALS*100,"",1)),6)
 .;
 .; back to NODE level.
 .; if no more entries send message  else use default.
 .S MESSAGE=""
 .S:$O(@KMPRARRY@(NODE))="" MESSAGE="Press RETURN to continue"
 .D CONTINUE^KMPDUTL4(MESSAGE,2,.CONT)
 ;
 Q
 ;
HDR ;
 W:$Y @IOF
 W !?29,"Package Resource Usage"
 W !?(80-$L($G(SITE))\2),$G(SITE)
 W !?17,"Node ",$G(NODE)," from ",$P(KMPRDATE,U,3)," to ",$P(KMPRDATE,U,4)
 W !?(80-($L(KMPRNAM)+12)\2),"'",KMPRNAM,"' Namespace"
 W !
 W !?20,"   %   ",?30,"    %    ",?40,"    %    ",?50,"    %    ",?60,"   %  ",?70,"All Other"
 W !?20,"Options",?30,"Protocols",?40,"   RPC",?50,"   HL7",?60," Tasks",?70,"Packages"
 W !
 ;
 Q

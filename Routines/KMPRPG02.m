KMPRPG02 ;OAK/RAK - RUM Data by Date for Single Node ;11/19/04  10:32
 ;;2.0;CAPACITY MANAGEMENT - RUM;**1**;May 28, 2003
 ;
EN ;-- entry point.
 ;
 N DATES,DIR,ELEMENT,I,IORVOFF,IORVON,LHTIME,NODE,OPTIONS,OUT,TMP,X,Y
 ;
 ; temporary global storage for stats.
 S TMP=$NA(^TMP("KMPR HR STATS",$J))
 S OUT=0
 F  D  Q:OUT
 .D HDR^KMPDUTL4(" RUM Data by Date for Single Node ") W !!
 .D GRPHMSG^KMPRUTL
 .; select element for display.
 .D ELEMENT^KMPRUTL(.Y) I 'Y S OUT=1 Q
 .S ELEMENT=Y_"^"_Y(0)
 .; get date range.
 .D RUMDATES^KMPRUTL(.DATES) Q:'DATES
 .; set up set-of-codes with nodes.
 .K DIR S DIR(0)="SO^",DIR("A")="Select Node"
 .S I=0,X=""
 .F  S X=$O(^KMPR(8971.1,"ANODE",X)) Q:X=""  D 
 ..S I=I+1,DIR(0)=DIR(0)_I_":"_X_";"
 .D ^DIR I 'Y S OUT=1 Q
 .K NODE S NODE(Y(0))=""
 .S OPTIONS="DGV"
 .K @TMP
 .W !!?3,"compiling data for: "
 .; get data - display graph - cleanup.
 .D DATA,GRAPH,EXIT
 .K @TMP
 ;
 Q
 ;
DATA ;-- compile rum stats per node for selected element.
 Q:$G(TMP)=""
 Q:'$G(ELEMENT)
 Q:'$G(DATES)
 Q:'$D(NODE)=""
 ;
 N DOTS,I,J,KMPRAR
 ;
 ; determine if dots should be printed to screen while gathering data.
 S DOTS=$S($E(IOST,1,2)="C-":0,1:1)
 ; get RUM data.
 D ELEMDATA^KMPRUTL2(+ELEMENT,$P(DATES,U),$P(DATES,U,2),.NODE,"KMPRAR",DOTS)
 Q:'$D(KMPRAR)
 ;
 ; format data into TMP array.
 S I=""
 F  S I=$O(KMPRAR(I)) Q:I=""  S J=0 D 
 .F  S J=$O(KMPRAR(I,J)) Q:J=""  D 
 ..S $P(@TMP@(J,0),U)=$$FMTE^DILIBF(J,2)
 ..S $P(@TMP@(J,0),U,2)=KMPRAR(I,J)
 ;
 Q
 ;
GRAPH ;-- display data in graph.
 Q:$G(TMP)=""
 Q:'$G(ELEMENT)
 ;
 N NODE1,TITLES
 S NODE1=$O(NODE(""))
 ; graph titles.
 S $P(TITLES,U)="RUM Data by Date for Node '"_NODE1_"'"
 S $P(TITLES,U,2)="From "_$P($G(DATES),U,3)_" to "_$P($G(DATES),U,4)
 S $P(TITLES,U,3)=$P(ELEMENT,U,2)_"/per "_$S(+ELEMENT=1!(+ELEMENT=7):"occurrence",1:"sec")
 S $P(TITLES,U,4)="Date"
 ; call graphics routine.
 D EN^KMPDUG(TMP,TITLES,$G(OPTIONS))
 Q
 ;
EXIT ;
 D ^%ZISC
 Q

KMPRPG01 ;OAK/RAK - RUM Data for All Nodes (Graph) ;11/19/04  08:58
 ;;2.0;CAPACITY MANAGEMENT - RUM;**1**;May 28, 2003
 ;
EN ;-- entry point.
 ;
 N DATES,DIR,ELEMENT,I,LHTIME,OPTIONS,OUT,TMP,X,Y
 ;
 ; temporary global storage for stats.
 S TMP=$NA(^TMP("KMPR HR STATS",$J))
 S OUT=0
 F  D  Q:OUT
 .D HDR^KMPDUTL4(" Data for All Nodes (Graph) ") W !!
 .D GRPHMSG^KMPRUTL
 .; select element for display.
 .D ELEMENT^KMPRUTL(.Y) I 'Y S OUT=1 Q
 .S ELEMENT=Y_"^"_Y(0)
 .; get date range.
 .D RUMDATES^KMPRUTL(.DATES) Q:'DATES
 .; determine number of nodes.
 .S I=0,X=""
 .F  S X=$O(^KMPR(8971.1,"ANODE",X)) Q:X=""  S I=I+1
 .S OPTIONS="G" S:I<8 OPTIONS=OPTIONS_"D"
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
 ;
 N DAYS,DOTS,I,J,KMPRAR,NODES
 ;
 ; determine if dots should be printed to screen while gathering data.
 S DOTS=$S($E(IOST,1,2)="C-":0,1:1)
 ; set nodes into NODES() array.
 D NODEARRY^KMPRUTL("NODES") Q:'$D(NODES)
 ; get RUM data.
 D ELEMDATA^KMPRUTL2(+ELEMENT,$P(DATES,U),$P(DATES,U,2),.NODES,"KMPRAR",DOTS)
 Q:'$D(KMPRAR)
 ;
 ; format data into TMP array.
 S I="",DAYS=$$FMDIFF^XLFDT($P(DATES,U,2),$P(DATES,U))+1
 F  S I=$O(KMPRAR(I)) Q:I=""  S J=0 D 
 .F  S J=$O(KMPRAR(I,J)) Q:J=""  D 
 ..S $P(@TMP@(I,0),U)=I
 ..S $P(@TMP@(I,0),U,2)=$P(@TMP@(I,0),U,2)+KMPRAR(I,J)
 .S $P(@TMP@(I,0),U,2)=$FN($P(@TMP@(I,0),U,2)/DAYS,"",2)
 ;
 Q
 ;
GRAPH ;-- display data in graph.
 Q:$G(TMP)=""
 Q:'$G(ELEMENT)
 ;
 N TITLES
 ; graph titles.
 S $P(TITLES,U)="RUM Data for All Nodes"
 S $P(TITLES,U,2)="From "_$P($G(DATES),U,3)_" to "_$P($G(DATES),U,4)
 S $P(TITLES,U,3)=$P(ELEMENT,U,2)_"/per "_$S(+ELEMENT=1!(+ELEMENT=7):"occurrence",1:"sec")
 S $P(TITLES,U,4)="Node"
 ; call graphics routine.
 D EN^KMPDUG(TMP,TITLES,$G(OPTIONS))
 Q
 ;
EXIT ;
 D ^%ZISC
 Q

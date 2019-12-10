XULMOUT ;IRMFO-ALB/CJM/SWO/RGG - KERNEL LOCK MANAGER ;08/28/2012
 ;;8.0;KERNEL;**608**;JUL 10, 1995;Build 84
 ;;Per VA Directive 6402, this routine should not be modified
 ;
 ;  ******************************************************************
 ;  *                                                                *
 ;  *  The Kernel Lock Manager is based on the VistA Lock Manager    *
 ;  *        developed by Tommy Martin.                              *
 ;  *                                                                *
 ;  ******************************************************************
 ;
OUTPUT1 ; Lock Dictionary
 N LOCK,IEN,DATA,LINE,RLINE
 S IEN=0
 F  S IEN=$O(^XLM(8993,IEN)) Q:'IEN  D
 .N NODE1
 .S LOCK=$NA(^XLM(8993,IEN))
 .S DATA=$G(@LOCK@(0))
 .Q:DATA=""
 .S NODE1=$G(@LOCK@(1))
 .I $P(NODE1,"^",2) S DATA="^"_DATA
 .D W(";;LOCK;"_DATA)
 .S DATA=$P($G(NODE1),"^",1)
 .I DATA S DATA=$P($G(^DIC(9.4,DATA,0)),"^")
 .I $L(DATA) D W(";;PACKAGE;"_DATA)
 .;
 .S DATA=$P($G(NODE1),"^",3)
 .I $L(DATA) D W(";;PARTIAL MATCH OK?;"_DATA)
 .;
 .;description of lock
 .D W(";;USAGE;"_$G(@LOCK@(4,0)))
 .S LINE=0 F  S LINE=$O(@LOCK@(4,LINE)) Q:'LINE  D W(";;;"_$G(@LOCK@(4,LINE,0)))
 .;
 .;subscripts in lock expression
 .S LINE=0 F  S LINE=$O(@LOCK@(2,LINE)) Q:'LINE  D
 ..D W(";;SUBSCRIPT;"_$G(@LOCK@(2,LINE,0))) D:$D(@LOCK@(2,LINE,1)) W(";;CHECK LOGIC;"_$G(@LOCK@(2,LINE,1)))
 .;
 .;file references
 .S LINE=0 F  S LINE=$O(@LOCK@(3,LINE)) Q:'LINE  D
 ..D W(";;FILE REFERENCE;"_$G(@LOCK@(3,LINE,0))),W(";;L;"_$G(@LOCK@(3,LINE,1)))
 ..;
 ..N LINE2
 ..D W(";;REFERENCE DESCRIPTION;"_$G(@LOCK@(3,LINE,2,0)))
 ..S LINE2=0 F  S LINE2=$O(@LOCK@(3,LINE,2,LINE2)) Q:'LINE2  D W(";;;"_$G(@LOCK@(3,LINE,2,LINE2,0)))
 D W(";;EXIT")
 Q
 ;
OUTPUT2 ;system locks for parameter file
 N GLB,TEXT,RLINE
 S GLB=$NA(^XLM(8993.1,"AC"))
 S TEXT=""
 F  S TEXT=$O(@GLB@(TEXT)) Q:TEXT=""  D W(";;"_TEXT)
 Q
 ;
 ;
 ;
 ;
 ;
 ;
W(LINE) ;
 I '$G(RLINE) D
 .K ^TMP($J,"RTN")
 .S RLINE=0
 S RLINE=RLINE+1
 S ^TMP($J,"RTN",RLINE)=" "_LINE
 Q
 ;
 ;
 ;

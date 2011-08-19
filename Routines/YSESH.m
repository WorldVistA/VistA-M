YSESH ;SLC/DCM-ADD/EDIT/DELETE LINKS TO NODES IN DECISION SUPPORT SYSTEM ; 10/18/88  16:52 ;
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;DECISION EXPERT SYSTEM (VERSION 1.0) FOR MENTAL HEALTH PACKAGE - DWIGHT MCDANIEL / REGION 5 ISC, SLC
 ;
NNODE ;  Called by routine YSESL
 W $C(7),!!!!?8,$E(STR,1,66),!?8,"**  No conclusions can be reached with the information given    **",!
 W ?8,"** The branches for this portion of the algorithm do not exist  **",!?8,$E(STR,1,66),!!,$C(7)
 W !!!!!?30,"PRESS ENTER TO CONTINUE" R A5AX:DTIME Q
 ;
NRSP ;  Called by routine YSESL
 W $C(7),!!!!?8,$E(STR,1,66),!?8,"**  No responses have been defined for this node.  Conclusions  **",!?8,"**  cannot be reached with the information as presently defined **",!
 W ?8,$E(STR,1,66),!!!?30,"PRESS ENTER TO CONTINUE",! R A5AX:DTIME Q
 ;
LST ;  Called by routine YSESL
 S ESI="" W !! ;; LIST THE NODES IN THE ALGORITHM
 F ESJ=2:1 S ESI=$O(@(ESDBP1_Q_ESI_Q_")")) Q:ESI=""  W ESI,?40 W:ESJ#2 ! I 'ESJ#40 W !,"Type '^' to quit or press the <RETURN> key to continue  " R Z:DTIME Q:'$T!(Z["^")
 K Z Q
 ;
ERROR ;  Called by routine YSESL
 W $C(7),!!!?6,$E(STR,1,70),!!?6,"******      NO RESPONSES HAVE BEEN DEFINED FOR THIS NODE YOU    ******",!?6,"******      CANNOT LINK NODES UNTIL THEY HAVE BEEN DEFINED      ******"
 W !!?6,$E(STR,1,70),! Q
 ;
HLP ;  Called by routine YSESL
 W !!,"Type in the name of the node that you wish to have linked to other nodes in the",!,"algorithm. This is the node that other nodes will be linked to, and which sits",!,"directly above the other nodes in the algorithm tree.",!!
 W !!?10,"TYPE '^' TO STOP, PRESS <ENTER> TO LIST THE DEFINED NODES  " R Z:DTIME Q:'$T!(Z="^")  D LST Q
HLP1 W !!?10,"These are the nodes that are to be linked to the first node.",!!,"Enter one of the responses that you have defined and that is listed, followed",!,"by a left bracket '[', followed by the name of the node to be linked to when",!
 W "this response is typed, followed by a right bracket ']', followed by a comma",!,"(,), follwed by the other nodes that are to be linked, using the same form.",!,"Examples are:",!!?20,"A[NODE1],B[NODE2],C[NODE3]",!!?20,"Y[NODE1],N[NODE2]",!!
 W "If you wish jump to another algorithm from this node, type in the response",!,"followed by a left angle bracket '<', followed by the new algorithm's name,",!,"followed by a right angle bracket '>',followe by a comma, followed by the other",!
 W "nodes to be linked in the proper form. Examples are:",!!?20,"Y[NODE1],N<ALGORITHM>",!?20,"A<ALGORITHM1>,B<ALGORITHM2>,C[NODE10]",!!
 W !?10,"TYPE '^' TO STOP, PRESS <ENTER> TO LIST THE DEFINED NODES  " R Z:DTIME Q:'$T!(Z="^")  D LST Q
 ;
HLP2 ;  Called by routine YSESL
 W !!,"1. Type in the characters that you wish to have replaced and press return.",!!?25,"<<  ALTERNATIVELY  >>",!!
 W "2. If you wish to replace from a character position to the end of the",!,"line, type in those characters that you wish to replace, and follow this by",!
 W "three dots ( ... ); this will delete everything from the first character typed",!,"to the end of the line.  TYPE IN ENOUGH CHARACTERS SO THAT YOU HAVE DISTINCTLY",!,"IDENTIFIED WHICH CHARACTERS YOU ARE REPLACING.",! Q
 ;
HLP3 ;  Called by routine YSESL
 W !!,"Type in the new characters that you are replacing or substituting.",!!! Q

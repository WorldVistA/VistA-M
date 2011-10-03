SROAMIS1 ;B'HAM ISC/MAM - ANESTHESIA AMIS REPORT ; 05/27/88  10:11
 ;;3.0; Surgery ;**38**;24 Jun 93
TECH ; set variables G, M, S,...
 S:TECH="G" G=^TMP("SROAMIS",$J,"T",TECH) S:TECH="M" M=^(TECH) S:TECH="L" L=^(TECH) S:TECH="O" O=^(TECH) S:TECH="E" E=^(TECH) S:TECH="S" S=^(TECH)
 Q
TECH2 ;
 S TOTDED=$P(G,"^",2)+$P(M,"^",2)+$P(L,"^",2)+$P(O,"^",2)+$P(E,"^",2)+$P(S,"^",2),TOTANES=G+M+L+O+E+S
 Q
PRINT ; print from ^TMP("SROAMIS",$J
 S TECH=0 F I=0:0 S TECH=$O(^TMP("SROAMIS",$J,"T",TECH)) Q:TECH=""  D TECH
 D TECH2 F I="A","N","O" S PRIND(I)=^TMP("SROAMIS",$J,"P","DIAG",I),PRINS(I)=^TMP("SROAMIS",$J,"P","SURG",I)
 W !,?7,TOTANES,?24,"|     "_+G,?38,"|     "_+M,?52,"|     "_+S,?66,"|     "_+E,?80,"|     "_+O,?94,"|     "_+L,! F I=1:1:IOM W "="
 W !!!! F I=1:1:IOM W "="
 W !,?11,"ANESTHETICS FOR PROCEDURES ADMINISTERED BY:",?65,"**     ANESTHETICS FOR DIAG. & THERA. PROCEDURES ADMINISTERED BY:" W ! F I=1:1:IOM W "-"
 W !,"ANESTHESIOLOGIST    |  NURSE ANESTHETIST   |       OTHER",?65,"**   ANESTHESIOLOGIST  |  NURSE ANESTHETIST   |     OTHER",! F I=1:1:IOM W "-"
 W !," NUMBER OF | NO. OF |  NUMBER OF  | NO. OF |  NUMBER OF | NO. OF",?65,"**  NUMBER OF | NO. OF |  NUMBER OF  | NO. OF |  NUMBER OF | NO. OF"
 W !,"ANESTHETICS| DEATHS | ANESTHETICS | DEATHS | ANESTHETICS| DEATHS",?65,"** ANESTHETICS| DEATHS | ANESTHETICS | DEATHS | ANESTHETICS| DEATHS",! F I=1:1:IOM W "-"
 W !,?3,+PRINS("A"),?11,"|  "_+$P(PRINS("A"),"^",2),?20,"|    "_+PRINS("N"),?34,"|  "_+$P(PRINS("N"),"^",2),?43,"|   "_+PRINS("O"),?56,"|  "_+$P(PRINS("O"),"^",2)
 W ?65,"**     "_+PRIND("A"),?80,"| "_+$P(PRIND("A"),"^",2),?88,"|   "_+PRIND("N"),?102,"|  "_+$P(PRIND("N"),"^",2),?111,"|   "_+PRIND("O"),?124,"|  "_+$P(PRIND("O"),"^",2),! F I=1:1:IOM W "="
 W !!! F I=1:1:IOM W "="
 W !,?40,"DEATHS WITHIN 24 HOURS OF INDUCTION OF ANESTHETIC",! F I=1:1:IOM W "-"
 W !,"TOTAL NUMBER",?24,"|             |             |             |             |             |"
 W !,"   OF DEATHS",?24,"|   GENERAL   |   MAC       |   SPINAL    |   EPIDURAL  |   OTHER     |   LOCAL",! F I=1:1:IOM W "-"
 W !,?7,TOTDED,?24,"|     "_+$P(G,"^",2),?38,"|     "_+$P(M,"^",2),?52,"|     "_+$P(S,"^",2),?66,"|     "_+$P(E,"^",2),?80,"|     "_+$P(O,"^",2),?94,"|     "_+$P(L,"^",2),! F I=1:1:IOM W "="
 W ! Q

DGYMBSRX ;ALB/ABR - REPORT OF G&L ORDERS FROM FILE 42
 ;;5.3;Registration;**59**;Aug 13, 1993
 ;
EN ;set up temp global based on G&L ORDER
 W !!,"WARD LOCATION FILE DIAGNOSTIC ROUTINE",!!
 S ZTDESC="Diagnostic List for WARD LOCATION file",ZTRTN="EN1^DGYMBSRX"
 D ZIS^DGUTQ
 I 'POP D EN1^DGYMBSRX
Q K I,POP,X,ZTDESC,ZTIO,ZTRTN,ZTSK
 D CLOSE^DGUTQ
 Q
 ;
EN1 ;
 D KILL
 S DGGDATE=$$HTE^XLFDT($H)
 N PAGE,FLAG,LINE S (PAGE,FLAG)=0
 D HEADER I FLAG Q
 F I=0:0 S I=$O(^DIC(42,I)) Q:'I  S DGGL=+$G(^DIC(42,I,"ORDER")) S ^TMP("DG59",$J,DGGL)=$G(^TMP("DG59",$J,DGGL))+1,^(DGGL,I)="" D LVL
 D NOGLO I FLAG G KILL
 D SAMEGLO I FLAG G KILL
 D LEVEL I FLAG G KILL
 W:$E(IOST,1,2)="C-" !!,">> DONE!"
 ;
KILL K I,J,DGGL,DGGDATE,DGNO,DGLVL,DGOLVL,SAGL,^TMP("DG59",$J)
 Q
 ;
LVL ; check for sequential TOTALS
 N DGLVL,DGOLVL
 F DGLVL=0:0 S DGOLVL=DGLVL,DGLVL=$O(^DIC(42,I,1,DGLVL)) Q:'DGLVL  I DGLVL-DGOLVL'=1 S ^TMP("DG59",$J,"DGLVL",I)=$P(^DIC(42,I,0),"^")
 K DGLVL,DGOLVL
 Q
 ;
NOGLO ;LOCATIONS W/ NO G&L ORDER
 I '$G(^TMP("DG59",$J,0)) Q
 S $P(LINE,"=",31)=""
 W !!,"**The following ward locations have no G&L order, ",!,"and do not appear on the G&L Sheet or Bed Status Report."
 W !!,"IEN",?10,"Ward Location",!,LINE
 F DGNO=0:0 S DGNO=$O(^TMP("DG59",$J,0,DGNO)) Q:'DGNO  D  Q:FLAG
 .I $Y>(IOSL-4) D HEADER I FLAG Q
 .W !,DGNO,?10,$P(^DIC(42,DGNO,0),"^")
 W !
 Q
 ;
SAMEGLO ;shared g&l orders
 N DGCHK S DGCHK=1
 F I=0:0 S I=$O(^TMP("DG59",$J,I)) Q:'I  I ^(I)>1 D
 .I DGCHK,$Y>(IOSL-8) D HEADER I FLAG Q
 .I DGCHK W !!,"*SHARED G&L ORDERS*",!,"===================" S DGCHK=0
 . W !!,"The following locations all have the G&L ORDER = ",I
 . F SAGL=0:0 S SAGL=$O(^TMP("DG59",$J,I,SAGL)) Q:'SAGL  D  Q:FLAG
 ..I $Y>(IOSL-4) D HEADER I FLAG Q
 ..W !,"IEN = ",SAGL,?12,"WARD LOCATION = ",$P(^DIC(42,SAGL,0),"^")
 . W !?15,"*** ONLY THE LAST OF THIS GROUP WILL APPEAR ON THE BSR ***"
 W !
 Q
 ;
LEVEL ; list wards with problem TOTALS
 S $P(LINE,"=",31)=""
 I '$O(^TMP("DG59",$J,"DGLVL",0)) Q
 W !!,"**The following locations are missing lower level TOTALS:",!
 W !,"IEN",?10,"Ward Location",!,LINE
 F DGLVL=0:0 S DGLVL=$O(^TMP("DG59",$J,"DGLVL",DGLVL)) Q:'DGLVL  W !,DGLVL,?10,^(DGLVL)
 Q
 ;
HEADER ; print header for diagnostics report
 N DIR,DIRUT,DTOUT,DUOUT,LINE2,X,Y,I
 S PAGE=PAGE+1,$P(LINE2,"=",80)=""
 I $E(IOST,1,2)="C-",(PAGE>1) S DIR(0)="E" D ^DIR S FLAG='Y I FLAG Q
 W @IOF,!,"WARD LOCATION FILE Diagnostics Report",?70,"PAGE:  ",$J(PAGE,2)
 W !,DGGDATE
 W !,LINE2
 Q

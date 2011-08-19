MCPFTR ;WISC/MLH-RELEASE A PFT REPORT ;8/24/92  10:08
 ;;2.3;Medicine;;09/13/1996
 ;;
 S FINIS=0 ;    done-processing flag
 FOR  D  Q:FINIS
 .  S DIC="^MCAR(700,",DIC(0)="AEMQZ"
 .  D ^DIC ;    select a report to release
 .  K DIC
 .  IF Y=-1 S FINIS=1 ;    we're through processing
 .  ELSE  D  ;    process this entry
 ..    S MCARGDA=+Y,RELSTAT=$P($G(^MCAR(700,MCARGDA,2)),U)
 ..    IF RELSTAT="Y" W !!,"This report has already been released.  Try again.",!!
 ..    ELSE  D  ;    ask for print and confirm release
 ...      S DIR(0)="Y",DIR("A")="Do you want to print this report before releasing it"
 ...      D ^DIR
 ...      K DIR
 ...      I Y D SUM^MCPFTP ;    print the report
 ...      S DIR(0)="Y",DIR("A")="Sure you wish to RELEASE this report",DIR("B")="N"
 ...      D ^DIR
 ...      K DIR
 ...      IF Y D  ;    release the report
 ....        S $P(^MCAR(700,MCARGDA,2),U)="Y" ;    release node on PFT
 ....        W !!,"*** REPORT RELEASED ***",!!
 ....        Q
 ...      ;END IF
 ...      ;
 ...      Q
 ..    ;END IF
 ..    ;
 ..    Q
 .  ;END IF
 .  ;
 .  Q
 ;END FOR
 ;
 K FINIS
 QUIT

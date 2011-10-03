ESP122PM ;ALB/JAP; POST-INSTALL FOR ES*1*22 cont.;3/98
 ;;1.0;POLICE & SECURITY;**22**;Mar 31, 1994
 ;
EN ;entry point to select user option for es*1*22 conversion
 N OPTION,NUM,ESPOUT,DIR,DTOUT,DUOUT,DIRUT,X,Y
 S (ESPOUT,NUM)=0
 S OPTION(1)="Print Conversion Reports;EN^ESP122P1"
 S OPTION(2)="User Conversion of File #912 Records;MANUAL^ESP122P2"
 S OPTION(3)="Patch ES*1*22 Conversion Completion;COMPLETE^ESP122P3"
 W @IOF
 F  D  Q:(NUM>0)!(ESPOUT)
 .W !!?5,"Patch ES*1*22 Conversion Management"
 .W !?5,"===================================",!
 .W !?5,"You may select one of the following options:",!
 .W !!?10,"(1) "_$P(OPTION(1),";",1)
 .W !?10,"(2) "_$P(OPTION(2),";",1)
 .W !?10,"(3) "_$P(OPTION(3),";",1)
 .S DIR(0)="SAO^1:"_$P(OPTION(1),";",1)_";2:"_$P(OPTION(2),";",1)_";3:"_$P(OPTION(3),";",1)
 .S DIR("A")="     Select (1), (2) or (3): "
 .W !?5 D ^DIR K DIR W !
 .I $D(DTOUT)!($D(DUOUT))!($D(DIRUT)) S ESPOUT=1
 .I (X["^")!(Y["^") S ESPOUT=1
 .I Y S NUM=+Y,OPTION=$P(OPTION(NUM),";",2)
 Q:NUM=0
 W !!?5,"You have opted to "_$P(OPTION(NUM),";",1),!
 K X,Y S DIR(0)="E" D ^DIR K DIR W !
 I Y D @OPTION
 G:'ESPOUT EN
 Q

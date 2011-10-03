SD ;SF/GFT,ALB/GRR,TMP - SCHEDULING DRIVER ROUTINE ; 07 SEP 84  4:17 pm
 ;;5.3;Scheduling;**132**;Aug 13, 1993
 D DT^DICRW S DIK="^DOPT(""SD"","
 G O:$D(^DOPT("SD",5)) D ^DIK S ^(0)="Scheduling Option^1N" F I=1:1 S X=$T(@I) Q:X']""  S ^DOPT("SD",I,0)=$P(X,";",3)
 D IXALL^DIK
O W !! S DIC=DIK,DIC(0)="EQAM" D ^DIC I Y>0 D @+Y G SD
 Q
1 ;;Amis Sample Menu
 W !,"OPC MENU NOW USED!" Q
2 ;;Appointment
 W !,"OPTIONS MUST BE INDIVIDUALLY CALLED!" Q
3 ;;Outputs
 G ^SDOUTPUT
4 ;;Special Survey Menu
 W !,"Special Survey functionality is obsolete!" Q
5 ;;Supervisor
 W !,"SUPERVISOR OPTIONS NO LONGER ACCESSIBLE!" Q

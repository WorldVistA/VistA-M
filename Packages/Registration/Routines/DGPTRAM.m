DGPTRAM ;ALB/BOK - ENTER RAM COSTS ; 11 MAR 87
 ;;5.3;Registration;**164**;Aug 13, 1993
ASK N X,Y,DIR
 S DIR("A")="Enter RAM costs for fiscal year: ",DIR(0)="DAO^2800101::E^K:'(X?2N!(X?4N)) X"
 S DIR("?")="^D HELP^DGPTRAM"
 D ^DIR
 I 'Y G QUIT
 S DGFY=Y(0)
 W ! S DIC="^DG(43,",DIC(0)="AEQMZ" D ^DIC Q:Y'>0
 S DA=+Y,DR="300///"_DGFY,DR(2,43.06)="1;2;4",DIE="^DG(43," D ^DIE
QUIT K DGFY,DA,DIC,DIE,DR Q
 Q
HELP D BMES^XPDUTL("Enter Fiscal Year for data entry, 2 or 4 digits (e.g.: 97 or 1997)")
 D MES^XPDUTL("  >> Must not be before 1980 <<")
 Q

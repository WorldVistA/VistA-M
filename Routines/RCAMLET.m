RCAMLET ;WASH-ISC@ALTOONA,PA/RGY-Edit AR Form letters ;2/22/95  4:12 PM
V ;;4.5;Accounts Receivable;;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 NEW DIC,DIE,DLAYGO,DR,DA,Y
 F  W ! S DIC="^RC(343,",DIC(0)="QEAML",DLAYGO=343 D ^DIC Q:Y<0  S DA=+Y,DR=1,DIE="^RC(343," D ^DIE
 Q

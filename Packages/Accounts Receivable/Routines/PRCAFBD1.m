PRCAFBD1 ;WASH-ISC@ALTOONA,PA/CLH-FMS Billing Document Utilities ;8/2/95  3:19 PM
V ;;4.5;Accounts Receivable;**16**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
DTYPE(BD) ;Return related documents for a BD
 ;Input BD type
 ;output =bd type^reserved^CR^WR
 ;ie:  input= 24
 ;    output=24^1^05^01
 N X
 I 'BD Q -1
 I $L(BD)<2 S BD=0_BD
 S X=$O(^PRCA(347.4,"B",BD,0))
 I 'X Q -1
 S X=$G(^PRCA(347.4,X,0))
 Q X
 ;
EDT ;Edit bill type
 N DA,DIC,DR,Y,DIE
 W !,"This option is used to edit the BILL type for converted Bills.",!
EDT1 S DIC="^PRCA(430,",DIC(0)="AEMNQ" D ^DIC Q:+Y<0
 S DA=+Y,DIE=DIC,DR=259 D ^DIE
 G EDT1
 ;

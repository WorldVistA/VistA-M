PRCAI114 ;WISC/RFJ-patch 114 post init ;1 Jun 99
 ;;4.5;Accounts Receivable;**114**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
POST ;  add lockbox type of payment
 I $O(^RC(341.1,"B","LOCKBOX",0)) Q
 N %,D0,DA,DDER,DI,DIC,DIE,DLAYGO,DQ,DR,X,Y
 S DIC="^RC(341.1,",DIC(0)="L",DLAYGO=341.1,X="LOCKBOX"
 S DIC("DR")=".02////"_12_";.06///PAYMENT;"
 D FILE^DICN
 Q

RCMSPOST ;WISC/RFJ-post init tracking and history ;1 Apr 01
 ;;4.5;Accounts Receivable;**169**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
START(PATCH) ;  add a new entry for a post init running
 ;  stores the starting date and time for a post init
 ;  returns entry number added
 I '$D(^RC(342,1,0)) Q 0
 ;
 N DA,DIC,DIE,DLAYGO,X,Y
 ;
 ;  first entry is the site entry
 S DA(1)=1
 S (DIC,DIE)="^RC(342,"_DA(1)_",9.4,",DIC(0)="L",DLAYGO=342.01
 S DIC("DR")=".02///NOW;"
 S X=PATCH
 D FILE^DICN
 Q +Y
 ;
 ;
END(DA) ;  stores the ending date and time for a post init
 N %DT,D,D0,DI,DIC,DIE,DQ,DR,X,Y
 ;
 ;  first entry is the site entry
 S DA(1)=1
 S (DIC,DIE)="^RC(342,"_DA(1)_",9.4,",DIC(0)="L",DLAYGO=342.01
 S DR=".03///NOW;"
 D ^DIE
 Q

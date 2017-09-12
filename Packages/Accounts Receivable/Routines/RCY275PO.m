RCY275PO ;ALB/BI - Post-Installation for PRCA patch 275 ;25-AUG-2011
 ;;4.5;Accounts Receivable;**275**;AUG 25, 2011;Build 72
 D MGAEXT
 Q
 ;
MGAEXT   ; Add external mail address to mail group. 
 N DO,DD,DA,DLAYGO,DIC,X,RCSITE
 S RCSITE=$G(^XMB("NETNAME"))  Q:RCSITE=""   ; SITE DOMAIN NAME
 S X="S.PRCA MDA SERVER@"_RCSITE             ; SERVER NAME WITH SITE DOMAIN NAME
 S DA(1)=$O(^XMB(3.8,"B","MDA",0))           ; MAIL GROUP IEN
 I $D(^XMB(3.8,DA(1),6,"B",$E(X,1,30))) Q    ; MAIL ADDRESS ALREADY EXISTS.
 S DLAYGO=3.812,DIC(0)="L",DIC="^XMB(3.8,"_DA(1)_",6,"
 D FILE^DICN                                 ; FILE THE ADDRESS
 Q

PRCPUTRX ;WISC/RFJ-transaction history file 445.2 sets              ;07 Jul 92
V ;;5.1;IFCAP;**1,126**;Oct 20, 2000;Build 2
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
ADDTRAN(INVPT,ITEMDA,TRANTYPE,ORDERNO,PRCPDATA) ;  add transaction entry
 ;prcpdata nodes:
 ;  date)        = date of transaction (posted or issued, etc)
 ;                 (optional) if not set it uses current date
 ;  qty)         = quantity of transaction
 ;  invval)      = inventory value
 ;  selval)      = sales value
 ;  avgunit)     = average unit cost
 ;  selunit)     = selling unit cost
 ;  pkg)         = unit per issue / units
 ;                 (optional) set to current if not passed
 ;  ref)         = reference number
 ;  2237po)      = 2237 or purchase order number
 ;  issue)       = issue/nonissue
 ;                 (optional) set to I for issuable, N for non
 ;  otherpt)     = other inventory point
 ;  reason)      = n:reason (if n=1 ask reason)
 ;  reasoncode)  = reason code (for whse other adjustments)
 ;  recipient    = who got the supply
 ;  user         = person who took the supply from the cabinet
 ;
 ;  returns variable y = da of entry added
 S Y=0
 ;
 ;  inventory point is not keeping a detailed transaction reg.
 I $P($G(^PRCP(445,+INVPT,0)),"^",6)'="Y" Q
 ;
 N %,%DT,D,D0,DA,DD,DI,DIC,DIE,DLAYGO,DQ,DR,NOW,PRCPDR,PRCPPRIV,PRCPREAS,TRANDA,X
 D NOW^%DTC S NOW=%
 ;
 ;  set up all variables not defined
 I '$G(PRCPDATA("DATE")) S PRCPDATA("DATE")=$E(NOW,1,7)
 I '$D(PRCPDATA("PKG")) S PRCPDATA("PKG")=$$UNIT^PRCPUX1(INVPT,ITEMDA,"/")
 F %="QTY","INVVAL","SELVAL" I '$G(PRCPDATA(%)) S PRCPDATA(%)=0
 S %=$G(^PRCP(445,INVPT,1,ITEMDA,0))
 I '$G(PRCPDATA("AVGUNIT")) D
 . S PRCPDATA("AVGUNIT")=+$P(%,"^",22)
 . I TRANTYPE="P",PRCPDATA("AVGUNIT")=0 S PRCPDATA("AVGUNIT")=+$P(%,"^",15)
 S:'$G(PRCPDATA("SELUNIT")) PRCPDATA("SELUNIT")=+$P(%,"^",15)
 F %="REF","2237PO","ISSUE","OTHERPT","REASON","RECIPIENT","USER" I '$D(PRCPDATA(%)) S PRCPDATA(%)=""
 ;
 ;  add new transaction history entry
 S DIC(0)="L",DLAYGO=445.2,DIC="^PRCP(445.2,",X=INVPT,PRCPPRIV=1
 D FILE^DICN I Y<1 S Y=0 Q
 S (TRANDA,DA)=+Y,DIE="^PRCP(445.2,"
 S DR="1///"_TRANTYPE_ORDERNO_";2///"_PRCPDATA("DATE")_";2.5///"_NOW_";3///"_TRANTYPE_";4////"_ITEMDA_";5////"_PRCPDATA("PKG")_";6////"_PRCPDATA("QTY")_";7////"_(+PRCPDATA("AVGUNIT"))_";8////"_(+PRCPDATA("SELUNIT"))_";"
 S DR=DR_"6.1////"_(+PRCPDATA("INVVAL"))_";6.2////"_(+PRCPDATA("SELVAL"))_";8.5////"_DUZ_";10////"_PRCPDATA("ISSUE")_";13////"_PRCPDATA("REF")_";14////"_PRCPDATA("OTHERPT")_";410////"_PRCPDATA("2237PO")_";"
 S DR=DR_"23////"_PRCPDATA("RECIPIENT")_";"
 S DR=DR_"22////"_PRCPDATA("USER")_";"
 ;  additional reason text (for asking in second call to die)
 S PRCPDR="" I $D(PRCPDATA("REASONCODE")) S PRCPDR="9////"_$E(PRCPDATA("REASONCODE"),1,3)_";"
 S PRCPDR=PRCPDR_"9.5//"_$S($P(PRCPDATA("REASON"),":"):"",1:"/")_"^S X=PRCPREAS",PRCPREAS=$E($P(PRCPDATA("REASON"),":",2,99),1,80)
 L +^PRCP(445.2,TRANDA)
 D ^DIE
 S DR=PRCPDR
 D ^DIE
 L -^PRCP(445.2,TRANDA)
 S Y=DA
 Q
 ;
 ;
ORDERNO(INVPT) ;  get next order number for inventory point
 ;  returns orderno
 S Y=0
 I $P($G(^PRCP(445,+INVPT,0)),"^",6)="Y" L +^PRCP(445.2,"ANXT",INVPT) S Y=$G(^PRCP(445.2,"ANXT",INVPT))+1 S:Y>9999999 Y=1 S ^(INVPT)=Y L -^PRCP(445.2,"ANXT",INVPT)
 Q Y

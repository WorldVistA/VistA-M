PRCAI217 ;ALB/CXW - PRCA*4.5*217 POST-INIT ROUTINE
 ;;4.5;Accounts Receivable;**217**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
EN ;convert the data stored in the global DISV(DUZ,"RCDPRPLM") file to the 
 ;AR USER CUSTOMIZE file (#342.3).
 ;^RC(342.3,da,0)=screen/options
 ;^RC(342.3,da,1,da(1),0)=duz^selection^device
 ;
 N RCDUZ,RCSNOPT,RCREC,RCSEL,RCDEV,U,DA,X,DIC,DIE,DR
 W !
 W "PRCA*4.5*217 Post Install......",!
 W "Converting the data stored in the ^DISV(DUZ,""RCDPRPLM"") global to",!
 W "the AR USER CUSTOMIZE file (#342.3)."
 S RCDUZ=0,U="^"
 F  S RCDUZ=$O(^DISV(RCDUZ)) Q:'RCDUZ  I $D(^DISV(RCDUZ,"RCDPRPLM")) D
 .S RCSNOPT=""
 .L +^DISV(RCDUZ,"RCDPRPLM"):5
 .F  S RCSNOPT=$O(^DISV(RCDUZ,"RCDPRPLM",RCSNOPT)) Q:RCSNOPT=""  D
 ..S RCREC=$G(^DISV(RCDUZ,"RCDPRPLM",RCSNOPT))
 ..I '$D(^RC(342.3,"B",RCSNOPT)) D
 ...K DD,DO,DIC("DR") S DIC="^RC(342.3,",DIC(0)="",X=RCSNOPT
 ...D FILE^DICN
 ..S RCSEL=$S(RCSNOPT="215REPORT":"",1:$P(RCREC,U))
 ..S RCDEV=$S(RCSNOPT="RECEIPT":$P(RCREC,U,2),RCSNOPT="215REPORT":$P(RCREC,U),1:"")
 ..S DA(1)=$O(^RC(342.3,"B",RCSNOPT,0))
 ..;if new then add entry
 ..I '$D(^RC(342.3,DA(1),1,"B",RCDUZ)) D  Q
 ...S DIC(0)="",DIC("P")=$P(^DD(342.3,1,0),U,2)
 ...S DIC="^RC(342.3,"_DA(1)_",1,"
 ...S X=RCDUZ
 ...S DIC("DR")="1////"_RCSEL_";2////"_RCDEV
 ...K DD,DO D FILE^DICN
 ...;
 ..;if existing then edit entry
 ..S DA=$O(^RC(342.3,DA(1),1,"B",RCDUZ,0)),DR=".01////"_RCDUZ_";1////"_RCSEL_";2////"_RCDEV
 ..S DIE="^RC(342.3,"_DA(1)_",1," D ^DIE
 .W "."
 .L -^DISV(RCDUZ,"RCDPRPLM")
 W "Done!"
 Q

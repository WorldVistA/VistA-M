PRCPENE1 ;WISC/RFJ,DGL-enter/edit inv parameters (list manager) ;10.7.99
V ;;5.1;IFCAP;**1**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
ALL ;  edit all fields
 D FULL^VALM1
 S VALMBCK="R"
 I '$D(^PRCP(445,PRCPINPT,0)) Q
 I $P($G(^PRCP(445,PRCPINPT,5)),"^",1)]"" D EDIT("[PRCP INVENTORY POINT (SS)]")
 E  D EDIT("[PRCP INVENTORY POINT (NON SS)]")
 D INIT^PRCPENLM
 Q
 ;
 ;
DESCRIP ;  edit descriptive parameters
 N PRCPNM,VALUE
 D FULL^VALM1
 S VALMBCK="R"
 I '$D(^PRCP(445,PRCPINPT,0)) Q
 I $P($G(^PRCP(445,PRCPINPT,5)),"^",1)]"" D 
 . S PRCPNM=$P(^PRCP(445,PRCPINPT,0),"^",1)
 . D EN^DDIOL("The inventory point name cannot be edited on a supply station secondary.")
 . D EDIT(".01////^S X=PRCPNM")
 . S DIR(0)="445,.8^^",DA=PRCPINPT
 . D ^DIR K DIR
 . S VALUE=Y
 . I $D(DTOUT)!$D(DUOUT) Q
 . S DA=PRCPINPT,DIE="^PRCP(445,",DR=".8///^S X=VALUE",PRCPPRIV=1
 . D ^DIE K PRCPPRIV,DIE
 . W !
 . D EN^DDIOL("WARNING: A 'NO' RESPONSE MAY CAUSE INTEGRITY PROBLEMS")
 . D EN^DDIOL("WITH THE SUPPLY STATION INTERFACE.")
 . S DIR(0)="445,.5^^",DA=PRCPINPT
 . D ^DIR K DIR
 . S VALUE=Y
 . I $D(DTOUT)!$D(DUOUT) Q
 . S DA=PRCPINPT,DIE="^PRCP(445,",DR=".5///^S X=VALUE",PRCPPRIV=1
 . D ^DIE K PRCPPRIV,DIE
 . W !
 . D EN^DDIOL("WARNING: A 'NO' RESPONSE CAUSES GIP TO IGNORE INFORMATION")
 . D EN^DDIOL("FROM THE SUPPLY STATION.")
 . S DIR(0)="445,.6^^",DA=PRCPINPT
 . D ^DIR K DIR
 . S VALUE=Y
 . I $D(DTOUT)!$D(DUOUT) Q
 . S DA=PRCPINPT,DIE="^PRCP(445,",DR=".6///^S X=VALUE",PRCPPRIV=1
 . D ^DIE K PRCPPRIV,DIE
 . W !
 I $P($G(^PRCP(445,PRCPINPT,5)),"^",1)="" D EDIT(".01;.8;.5;.6")
 D INIT^PRCPENLM
 Q
 ;
 ;
SPECIAL ;  edit special parameters
 D FULL^VALM1
 S VALMBCK="R"
 I '$D(^PRCP(445,PRCPINPT,0)) Q
 N DR,ORD,TYPE
 S ORD=0
 S TYPE=$P(^PRCP(445,PRCPINPT,0),"^",3)
 S DR="12;"
 I TYPE="W" S DR=DR_".9;16"
 I TYPE="P" S DR=DR_"14;15;I $P(^PRCP(445,DA,0),U,20)'=""S"" S Y=5;16;5;5.5;9"
 I TYPE="S" D
 .   S ORD=$$SSCHK(PRCPINPT)
 .   I 'ORD S DR=DR_"22"
 D EDIT(DR)
 I ORD[1 D EN^DDIOL("Post or delete all regular orders before editing the supply station provider.")
 I ORD[2 D EN^DDIOL("Change this secondary to be stocked by only 1 primary before adding a "),EN^DDIOL("supply station provider.")
 I ORD[3 D EN^DDIOL("A supply station IP cannot have a name longer than 10 characters."),EN^DDIOL("Edit the name before linking a supply station to this IP.")
 I ORD D P^PRCPUREP ; pause to allow user to read message
 D INIT^PRCPENLM
 Q
 ;
 ;
FCP ;  edit fund control point
 D FULL^VALM1
 N %,FCP,FCPNM,INVPTNM,PRCPFLAG
 S INVPTNM=$$INVNAME^PRCPUX1(PRCPINPT)
 K X S X(1)="Select the FUND CONTROL POINT that may be used when replenishing "_INVPTNM W ! D DISPLAY^PRCPUX2(3,75,.X)
 F  D  Q:$G(PRCPFLAG)
 .   D DISPFCP^PRCPUTIL(PRCPINPT)
 .   S FCP=$$SELECT^PRCPUFCP(PRCPTYPE) I FCP<1 S PRCPFLAG=1 Q
 .   S FCPNM=$P(^PRC(420,PRC("SITE"),1,FCP,0),U)
 .   I $D(^PRC(420,"AE",PRC("SITE"),PRCPINPT,+FCP)) D  Q  ; if defined
 .   .   W ! S XP="   Do you want to unlink inventory point "_INVPTNM
 .   .   S XP(1)="   from control point "_FCPNM
 .   .   I $$YN^PRCPUYN(2)=1 D DEL^PRCPUFCP(FCP,PRCPINPT)
 .   .   I $O(^PRC(420,"AE",PRC("SITE"),PRCPINPT,0)) S PRCPFLAG=1
 .   E  D SET^PRCPUFCP(FCP,PRCPINPT) S PRCPFLAG=1
 .   Q
 D:'$G(PRCP("CONVRT")) INIT^PRCPENLM
 S VALMBCK="R"
 Q
 ;
 ;
MISCOST ;  edit mis costing
 D FULL^VALM1
 S VALMBCK="R"
 I '$D(^PRCP(445,PRCPINPT,0)) Q
 I '$D(^PRCP(445,PRCPINPT,3,0)) S ^(0)="^445.011P^^"
 D EDIT(11)
 D INIT^PRCPENLM
 Q
 ;
 ;
USERS ;  edit authorized users
 D FULL^VALM1
 S VALMBCK="R"
 I '$D(^PRCP(445,PRCPINPT,0)) Q
 I '$D(^PRCP(445,PRCPINPT,4,0)) S ^(0)="^445.04P^^"
 D EDIT(6)
 I $P(^PRCP(445,PRCPINPT,0),"^",3)'="S" D USERS^PRCPENEU(PRCPINPT)
 D INIT^PRCPENLM
 Q
 ;
 ;
FLAGS ;  edit flags: emergency stock level, issue schedule, auto purge
 D FULL^VALM1
 S VALMBCK="R"
 N DR,PRCPX1,PRCPX2,PRCPX3
 ;  emergency stock level text
 S PRCPX1(1)="Set the 'Print Emergency Stock Levels' flag to NO to discontinue the notification that you have items at or below the emergency stock level.  The next time the automatically scheduled program which scans the database"
 S PRCPX1(2)="runs, it will reset the flag and the message will reappear if items are found at or below the emergency stock level."
 S DR="D DISPLAY^PRCPUX2(5,75,.PRCPX1);7PRINT EMERGENCY STOCK LEVELS;"
 ;  automatic purge text
 S PRCPX2(1)="Set the 'Automatic Purge' to YES if you want data older than 13 months automatically purged for this inventory point.  A background scheduled program will run the first day of each month and automatically purge old"
 S PRCPX2(2)="data for those inventory points which have the automatic purge turned on."
 S DR=DR_"D DISPLAY^PRCPUX2(5,75,.PRCPX2);7.9AUTOMATIC PURGE;"
 ;  reg whse issues text
 S PRCPX3(1)="Delete the 'Regular Whse Issues Due Date' to discontinue the message notifying you that your next request for warehouse issues is due; or change it to a later date, if you wish to be reminded later."
 I PRCPTYPE="P" S DR=DR_"D DISPLAY^PRCPUX2(5,75,.PRCPX3);10REGULAR WHSE ISSUES DUE DATE;"
 D EDIT(DR)
 D INIT^PRCPENLM
 Q
 ;
 ;
SSCHK(PRCPINPT) N ORD,PRCPSB
 ;
 ; returns 1 if a secondary inventory point has outstanding orders
 ;         2 if it is stocked by multiple points
 ;         3 if the IP name is too long
 ;       123 if ALL conditions are true
 ;
 ; PRCPINPT is the secondary inventory point's DA
 ;
 S ORD=0
 ; F  S ORD=$O(^PRCP(445.3,"AD",PRCPINPT,ORD)) Q:ORD']""  I $P(^PRCP(445.3,ORD,0),"^",8)="R",$P(^(0),"^",6)'="P" D  Q
 ; .   S ORD=1
 S ORD=$$ORDCHK^PRCPUITM(0,PRCPINPT,"R","") ; any outstanding reg orders?
 I $P($G(^PRCP(445,PRCPINPT,5)),"^",1)']"" D
 .   N PRCPSB S PRCPSB=0
 .   S PRCPSB=$O(^PRCP(445,"AB",PRCPINPT,PRCPSB))
 .   I PRCPSB S PRCPSB=$O(^PRCP(445,"AB",PRCPINPT,PRCPSB)) I PRCPSB D
 .   .   S:'ORD ORD=2 I ORD=1 S ORD=12
 I $L($P($P(^PRCP(445,PRCPINPT,0),"^",1),"-",2))>10 D
 . I ORD S ORD=ORD_3
 . I 'ORD S ORD=3
 QUIT (ORD)
 ;
 ;
EDIT(DR) ;  edit inventory parameters fields in dr string
 I '$D(^PRCP(445,+PRCPINPT,0)) Q
 N %,D,D0,D1,DA,DI,DIC,DIDEL,DIE,DLAYGO,DQ,X,Y
 S DA=PRCPINPT,(DIC,DIE)="^PRCP(445,",DIDEL=445,PRCPPRIV=1
 D ^DIE K PRCPPRIV
 Q

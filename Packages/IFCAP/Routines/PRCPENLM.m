PRCPENLM ;WISC/RFJ-edit inventory parameters (list manager);06 Jan 94 ; 6/23/99 10:52am
V ;;5.1;IFCAP;**1**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
ENTERNEW ;  this entry point bypasses prcpusel
 N CLREND,COLUMN,LINE,PRCPINPT,PRCPDATA,PRCPSU,PRCPTYPE,X
 K X S X(1)="You have the option to edit ALL "_$S(PRCP("DPTYPE")="W":"WAREHOUSE",PRCP("DPTYPE")="P":"PRIMARY",1:"SECONDARY")_" inventory points you have access to." D DISPLAY^PRCPUX2(2,40,.X)
 S PRCPSU=1 ; Screen for auth. users only
 I $G(^VA(200,DUZ,400))+0=4 S PRCPSU=0 ; Supply Manager-no screen
 F  S PRCPINPT=$$INVPT^PRCPUINV(PRC("SITE"),PRCP("DPTYPE"),1,PRCPSU,"") Q:'PRCPINPT  D
 .   S PRCPTYPE=$P($G(^PRCP(445,PRCPINPT,0)),"^",3)
 .   L +^PRCP(445,PRCPINPT,0):1 I '$T D SHOWWHO^PRCPULOC(445,PRCPINPT_"-0",0) Q
 .   I PRCPTYPE="S" L +^PRCP(445,PRCPINPT,5):1 I '$T D  Q
 .   .   D SHOWWHO^PRCPULOC(445,PRCPINPT_"-0",5)
 .   .   L -^PRCP(445,PRCPINPT,0)
 .   D ADD^PRCPULOC(445,PRCPINPT_"-0",0,"Enter/Edit Inventory Parameters")
 .   I PRCPTYPE="S" D ADD^PRCPULOC(445,PRCPINPT_"-5",0,"Enter/Edit Inventory Parameters")
 .   D EN^VALM("PRCP INVENTORY PARAMETERS")
 .   D CLEAR^PRCPULOC(445,PRCPINPT_"-0",0)
 .   L -^PRCP(445,PRCPINPT,0)
 .   I PRCPTYPE="S" D
 .   .   D CLEAR^PRCPULOC(445,PRCPINPT_"-5",0)
 .   .   L -^PRCP(445,PRCPINPT,5)
 Q
 ;
 ;
HDR ;  build header
 S VALMHDR(1)="INVENTORY POINT: "_$$INVNAME^PRCPUX1(PRCPINPT)_"    TOTAL NUMBER OF ITEMS: "_+$P($G(^PRCP(445,PRCPINPT,1,0)),"^",4)
 Q
 ;
 ;
INIT ;  build array
 K PRCPDATA,^TMP($J,"PRCPENLM")
 D DIQ(".01:22")
 D DESCRIP,SPECIAL,FLAGS,USERS
 I PRCPTYPE="W"!(PRCPTYPE="P") D DISTRPTS^PRCPENL1
 I PRCPTYPE="P"!(PRCPTYPE="S") D STOCKED^PRCPENL1
 I PRCPTYPE="W"!(PRCPTYPE="P") D FCP^PRCPENL1
 I PRCPTYPE="S"!(PRCPTYPE="P") D MISCOSTS^PRCPENL1
 D PURGE^PRCPENL1
 S VALMCNT=LINE
 Q
 ;
 ;
DESCRIP ;  build descriptive array
 S LINE=1,COLUMN=1,CLREND=80
 D SET("Description",LINE,COLUMN,CLREND,0,IORVON,IORVOFF)
 D SET("Type of Inventory Point   ",LINE+1,COLUMN,CLREND,.7)
 D SET("Abbreviated Name          ",LINE+2,COLUMN,CLREND,.8)
 D SET("Keep Perpetual Inventory  ",LINE+3,COLUMN,CLREND,.5)
 D SET("Keep Transaction Register ",LINE+4,COLUMN,CLREND,.6)
 D SET("",LINE+5,COLUMN,CLREND)
 Q
 ;
 ;
SPECIAL ;  build special parameters array
 N COUNT,ORD
 S LINE=7,COLUMN=1,CLREND=80,ORD=0
 D SET("Special Parameters",LINE,COLUMN,CLREND,0,IORVON,IORVOFF)
 D SET("Months Inactive Before Item Deletion",LINE+1,COLUMN,CLREND,12)
 I PRCPTYPE="W" D
 .   D SET("Cost Center                         ",LINE+2,COLUMN,CLREND,.9)
 .   D SET("Default Picking Ticket Printer      ",LINE+3,COLUMN,CLREND,16)
 .   S LINE=LINE+3
 I PRCPTYPE="P" D
 .   D SET("Primary Updated By Warehouse        ",LINE+2,COLUMN,CLREND,14)
 .   D SET("Special Inventory Point Type        ",LINE+3,COLUMN,CLREND,15)
 .   D SET("Department Number                   ",LINE+4,COLUMN,CLREND,5)
 .   D SET("Issue Book Sort                     ",LINE+5,COLUMN,CLREND,5.5)
 .   D SET("Regular Whse Issues Schedule        ",LINE+6,COLUMN,CLREND,9)
 .   S LINE=LINE+6
 .   I $G(PRCPDATA(445,PRCPINPT,15,"E"))="SPD" S LINE=LINE+1 D SET("SPD Picking Ticket Printer          ",LINE,COLUMN,CLREND,16)
 I PRCPTYPE="S" D
 .   S ORD=$$SSCHK^PRCPENE1(PRCPINPT)
 .   I 'ORD D SET("Supply Station Provider             ",LINE+2,COLUMN,CLREND,22)
 .   I ORD D SET("(Supply Station Provider)           ",LINE+2,COLUMN,CLREND,22)
 .   S LINE=LINE+2
 S LINE=LINE+1
 D SET("",LINE,COLUMN,CLREND)
 Q
 ;
 ;
FLAGS ;  build flags array
 S LINE=LINE+1,COLUMN=1,CLREND=80
 D SET("Flags",LINE,COLUMN,CLREND,0,IORVON,IORVOFF)
 D SET("Print Emergency Stock Levels ",LINE+1,COLUMN,CLREND,7)
 D SET("Automatic Purge              ",LINE+2,COLUMN,CLREND,7.9)
 S LINE=LINE+2
 I PRCPTYPE="P" S LINE=LINE+1 D SET("Regular Whse Issues Due Date ",LINE,COLUMN,CLREND,10)
 S LINE=LINE+1
 D SET("",LINE,COLUMN,CLREND)
 Q
 ;
 ;
USERS ;  build inventory users array
 N USER
 S LINE=LINE+1,COLUMN=1,CLREND=80
 D SET("Inventory Users",LINE,COLUMN,CLREND,0,IORVON,IORVOFF)
 S USER=0 F LINE=LINE+1:1 S USER=$O(^PRCP(445,PRCPINPT,4,USER)) Q:'USER  D
 .   D SET("     : "_$$USER^PRCPUREP(USER),LINE,COLUMN,CLREND)
 .   I $$KEY^PRCPUREP("PRCP"_$TR(PRCPTYPE,"WSP","W2")_" MGRKEY",USER) D SET("*** MANAGER ***",LINE,65,CLREND)
 D SET("",LINE,COLUMN,CLREND)
 Q
 ;
 ;
EXIT ;  exit and clean up
 K ^TMP($J,"PRCPENLM")
 Q
 ;
 ;
DIQ(DR) ;  diq call to retrieve data for dr fields
 N D0,DA,DIC,DIQ,DIQ2
 S DA=PRCPINPT,DIQ(0)="E",DIC="^PRCP(445,",DIQ="PRCPDATA" D EN^DIQ1
 Q
 ;
 ;
SET(STRING,LINE,COLUMN,CLREND,FIELD,ON,OFF)      ;  set array
 I $G(FIELD) S STRING=STRING_": "_$G(PRCPDATA(445,PRCPINPT,FIELD,"E"))
 I STRING="" D SET^VALM10(LINE,$J("",80)) Q
 I '$D(@VALMAR@(LINE,0)) D SET^VALM10(LINE,$J("",80))
 D SET^VALM10(LINE,$$SETSTR^VALM1(STRING,@VALMAR@(LINE,0),COLUMN,CLREND))
 I $G(ON)]""!($G(OFF)]"") D CNTRL^VALM10(LINE,COLUMN,$L(STRING),ON,OFF)
 Q
 ;
 ;
ADDNEW ;  this entry point is called from the option file from ifcap
 ;  to set up new primary or warehouse inventory points
 I '$G(PRC("SITE")) S PRCF("X")="S" D ^PRCFSITE
 S DIR(0)="SO^W:Warehouse;P:Primary",DIR("A")="Select the type of inventory point to edit" D ^DIR K DIR I Y'="W",Y'="P" Q
 S PRCP("DPTYPE")=Y
 D ENTERNEW
 K PRCP
 G ADDNEW

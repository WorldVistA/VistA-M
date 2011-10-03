PRCPLO3 ;WOIFO/DAP/RLL-manual run option for GIP reports ; 7/28/06 10:39am
V ;;5.1;IFCAP;**83,98**;Oct 20, 2000;Build 37
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
ENT ;This section of the routine executes calls to the separate CLRS GIP
 ;extract routines.
 ;
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,PRCPSSR,ZTSK,ZTREQ,PRCPMSG
 S ZTRTN="ENT^PRCPLO2"
 S ZTDESC="PRCPLO CLO GIP Reports CLRS"
 S ZTDTH=$H
 S ZTREQ="@"
 S ZTIO=""
 D ^%ZTLOAD
 S PRCPSSR=ZTSK
 ; Calls mail group message generation and screen display with success
 ; or exception notification
 I $D(PRCPSSR)[0 S PRCPMSG(1)="A task could not be created for the CLO GIP Reports - please contact IRM." D MAIL W ! D EN^DDIOL(PRCPMSG(1)) Q
 ;
 S PRCPMSG(1)="Task # "_PRCPSSR_" entered for the CLO GIP Reports."
 W !
 D EN^DDIOL(PRCPMSG(1))
 D MAIL
 ;
 Q
 ;
MAIL ; Builds mail messages to a defined mail group to notify users of the 
 ; success or failure of the TaskMan scheduling for the CLO GIP Reports.
 ;
 ;*98 Modified code to work with PRC CLRS OUTLOOK MAILGROUP parameter
 N XMDUZ,XMMG,XMSUB,XMTEXT,XMY,XMZ,PRCPMG,PRCPMG2
 S XMSUB="CLO GIP Report Status for "_$$HTE^XLFDT($H)
 S XMDUZ="Clinical Logistics Report Server"
 S XMTEXT="PRCPMSG("
 S XMY("G.PRCPLO CLRS NOTIFICATIONS")=""
 S PRCPMG=$$GET^XPAR("SYS","PRC CLRS OUTLOOK MAILGROUP",1,"Q")
 S:$G(PRCPMG)'="" PRCPMG2="S XMY("""_PRCPMG_""")=""""" X PRCPMG2
 ;
 D ^XMD
 Q
 ; 
BLDGP2 ; Build the DAYS of stock on hand file
 N FILEDIR,STID,FILG2
 S FILEDIR=$$GET^XPAR("SYS","PRCPLO EXTRACT DIRECTORY",1,"Q")
 S STID=$$GET1^DIQ(4,$$KSP^XUPARAM("INST")_",",99)
 S FILG2="IFCP"_STID_"G2.TXT"
 D OPEN^%ZISH("FILE1",FILEDIR,FILG2,"W")
 ; D OPEN^%ZISH("FILE1",FILEDIR,"CLRSG2.TXT","W")
 D USE^%ZISUTL("FILE1")
 D GTGIPSOH  ; *98 New version
 D GTGIPSOD  ; *98 New version
 D CLOSE^%ZISH("FILE1")
 Q
BLDGP1 ; BUILD THE stock status file
 N FILEDIR,STID,FILG1
 S FILEDIR=$$GET^XPAR("SYS","PRCPLO EXTRACT DIRECTORY",1,"Q")
 S STID=$$GET1^DIQ(4,$$KSP^XUPARAM("INST")_",",99)
 S FILG1="IFCP"_STID_"G1.TXT"
 D OPEN^%ZISH("FILE1",FILEDIR,FILG1,"W")
 ; D OPEN^%ZISH("FILE1",FILEDIR,"CLRSG1.DAT","W")
 D USE^%ZISUTL("FILE1")
 ; D GETGIPH2
 ; D GETGIPSF
 D GTGIPSSH  ; *98, New version
 D GTGIPSSD  ; *98, New version
 D CLOSE^%ZISH("FILE1")
 Q
GETGIPSF ; Get the GIP stock status data from file 446.7 (old format)
 N GT1,GT2,GT3,GT4
 S GT1="",GT2="",GT3=""
 F  S GT1=$O(^PRCP(446.7,GT1)) Q:GT1=""  D
 . S GT2=$G(^PRCP(446.7,GT1,2))
 . I $P(GT2,"*",2)'="" W GT2,!
 . Q
 Q
GTGIPSOD ; *98 Get the GIP Stock on Hand Data new (new format)
 ;
 N GT1,GT2,DT3
 S GT1="",GT2="",DT3=""
 F  S GT1=$O(^PRCP(446.7,GT1)) Q:GT1=""  D
 . S GT2=$G(^PRCP(446.7,GT1,1))_"*"
 . S DT3=$G(^PRCP(446.7,GT1,2))
 . I $P(GT2,"*",2)'="" W !,GT2,DT3
 . Q
 Q
GTGIPSSD ; *98 Get GIP Stock Status data (new format)
 N GT1,GT2,DT3,DT4,DT5,DT6,DT7
 S GT1="",GT2="",DT3="",DT4="",DT5="",DT6="",DT7=""
 F  S GT1=$O(^PRCP(446.7,GT1)) Q:GT1=""  D
 . S GT2=$G(^PRCP(446.7,GT1,3))_"*"
 . S DT4=$G(^PRCP(446.7,GT1,4))_"*"
 . S DT5=$G(^PRCP(446.7,GT1,5))_"*"
 . S DT6=$G(^PRCP(446.7,GT1,6))_"*"
 . S DT7=$G(^PRCP(446.7,GT1,7))
 . I $P(GT2,"*",2)'="" W !,GT2,DT4,DT5,DT6,DT7
 . Q
 Q
GETGIPH1 ; Header for stock on hand report (old format)
 ;
 W "StationNum"_"*"_"DateRange"_"*"_"InvIdNum"_"*"
 W "InventoryPoint"_"*"_"InventoryType"_"*"_"TotalDollars"_"*"
 W "NumOfLineItemsSoh"_"*"_"NumOfLineItemsInv"_"*"_"CostCenter",!
 Q
GTGIPSOH ; *98 Header for stock on hand report (new format)
 ;
 W "StationNum"_"*"_"DateRange"_"*"_"InvIdNum"_"*"
 W "InventoryPoint"_"*"_"InventoryType"_"*"_"TotalDollars"_"*"
 W "NumOfLineItemsSoh"_"*"_"NumOfLineItemsInv"_"*"_"CostCenter"_"*"
 W "StdTotDolVal"_"*"_"OdiTotDolVal"_"*"_"AllTotDolVal"_"*"
 W "StdNumSohItems"_"*"_"OdiNumSohItems"_"*"_"AllNumSohItems"_"*"
 W "StdNumInvItems"_"*"_"OdiNumInvItems"_"*"_"AllNumInvItems"
 Q
GETGIPH2 ; Header for Stock Status Report
 W "StationNum"_"*"_"DateRange"_"*"_"NumDays"_"*"
 W "InvIdNum"_"*"_"InventoryPoint"_"*"_"InventoryType"_"*"_"OpenBalTotal"_"*"_"ReceiptsTot"_"*"
 W "IssuesTotal"_"*"_"AdjTotal"_"*"_"ClosingBalTot"_"*"
 W "ReceiptsTot#"_"*"_"IssuesTotal#"_"*"_"AdjTotal#"_"*"
 W "TurnoverTotal"_"*"_"InactiveItmTotal#"_"*"_"InactiveItemTotal$"
 W "*"_"InactiveItemsPct"_"*"_"LongSupplyTotal#"_"*"_"LongSupplyTotal$"
 W "*"_"LongSupplyPct"_"*"_"NumOfLineItemsInv",!
 Q
GETGIPF ; Get the GIP days of stock on hand data from File 446.7 (old format)
 ;
 N GP1,GP2,GP3
 S GP1=0,GP2=0,GP3=0
 F  S GP1=$O(^PRCP(446.7,GP1)) Q:GP1=""  D
 . S GP2=$G(^PRCP(446.7,GP1,1))
 . I $P(GP2,"*",1)'="" W GP2,!
 . Q
 Q
GTGIPSSH ; *98 NEW Stock Status Report Header
 ; Additional Fields were added to accommodate
 ; Standard Items and On Demand Items
 W "StNum"_"*"_"DtRng"_"*"_"NmDys"_"*"
 W "InvIdNum"_"*"_"InvPnt"_"*"_"InvTyp"_"*"
 W "StdOpnBalTot"_"*"_"OdiOpnBalTot"_"*"_"AllOpnBalTot"_"*"
 W "StdRcptsTot"_"*"_"OdiRcptsTot"_"*"_"AllRcptsTot"_"*"
 W "StdIssTot"_"*"_"OdiIssTot"_"*"_"AllIssTot"_"*"
 W "StdAdjTot"_"*"_"OdiAdjTot"_"*"_"AllAdjTot"_"*"
 W "StdClseBalTot"_"*"_"OdiClseBalTot"_"*"_"AllClseBalTo"_"*"
 W "NumStdRcpts"_"*"_"NumOdiRcpts"_"*"_"NumAllRcpts"_"*"
 W "NumStdIss"_"*"_"NumOdiIss"_"*"_"NumAllIss"_"*"
 W "NumStdAdj"_"*"_"NumOdiAdj"_"*"_"NumAllAdj"_"*"
 W "StdTrnvrTot"_"*"_"OdiTrnvrTot"_"*"_"AllTrnvrTot"_"*"
 W "NumStdInactItms"_"*"_"NumOdiInactItms"_"*"_"NumAllInactItms"_"*"
 W "StdInactTotDol"_"*"_"OdiInactTotDol"_"*"_"AllInactTotDol"_"*"
 W "StdInactPct"_"*"_"OdiInactPct"_"*"_"AllInactPct"_"*"
 ;
 W "StdNumLngSup"_"*"_"OdiNumLngSup"_"*"_"AllNumLngSup"_"*"
 W "StdLngSupTotDol"_"*"_"OdiLngSupTotDol"_"*"_"AllLngSupTotDol"_"*"
 W "StdLngSupPct"_"*"_"OdiLngSupPct"_"*"_"AllLngSupPct"_"*"
 W "NumStdInvLnItms"_"*"_"NumOdiInvLnItms"_"*"_"NumAllInvLnItms"
 ;
 ;
 Q

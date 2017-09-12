MAGIP39 ;PRE init routine to queue site activity at install. ; 14 Oct 2010 4:39 PM
 ;;3.0;IMAGING;**39**;Mar 19, 2002;Build 2010;Mar 08, 2011
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
PRE ;
 ; If not first P39 install then must convert the Jukebox default from 54 to 2.01
 I $$FLDNUM^DILFD(2006.1,"JUKEBOX DEFAULT") D
 . N JBREF,NLREF,PL
 . S PL=0
 . F  S PL=$O(^MAG(2006.1,PL)) Q:'PL  D
 . . S JBREF=$P($G(^MAG(2006.1,PL,1)),U,6) Q:'JBREF
 . . S NLREF=$P($G(^MAGQUEUE(2006.032,JBREF,0)),U,3)
 . . S $P(^MAG(2006.1,PL,1),U,6)=NLREF
 . . Q
 . Q
 ; Move Pre-Patch 39 data to new location and clear retired fields 11.5,11.9
 N PL,LEGACY
 S PL=0
 F  S PL=$O(^MAG(2006.1,PL)) Q:'PL  D
 . S $P(^MAG(2006.1,PL,3),U,7)="" ; CRITICAL LOW MESSAGE INTERVAL - RETIRED
 . S $P(^MAG(2006.1,PL,3),U,11)="" ; DATE OF LAST CRITICAL MESSAGE - RETIRED
 . Q:$D(^MAG(2006.1,PL,"BPPURGE"))  ; Only for initial conversion
 . S $P(^MAG(2006.1,PL,"BPPURGE"),U,1)=$P($G(^MAG(2006.1,PL,5)),U,1) ; New #60 AutoPurge
 . S $P(^MAG(2006.1,PL,"BPPURGE"),U,6)=$P($G(^MAG(2006.1,PL,5)),U,3) ; New #61 Scheduled Purge
 . S $P(^MAG(2006.1,PL,"BPPURGE"),U,7)=$P($G(^MAG(2006.1,PL,5)),U,6) ; New #61.1 Date of Last Scheduled Purge
 . S $P(^MAG(2006.1,PL,"BPPURGE"),U,9)=$P($G(^MAG(2006.1,PL,5)),U,4) ; New #61.2 Scheduled Purge Frequency
 . S $P(^MAG(2006.1,PL,"BPPURGE"),U,11)=$P($G(^MAG(2006.1,PL,5)),U,5) ; New #61.4 Scheduled Purge Time
 . Q
 ; Change the BP Workstation file ( 2006.8) name to BP SERVERS
 D:$$UPPER^MAGQE4($P($G(^DIC(2006.8,0)),U,1))["BP WORKSTATIONS" CFILEN("2006.8","BP SERVERS")
 ; Remove data dictionary definition so that the new definition installs cleanly
 ; Except we are removing fields 9 PACS Purge, 13 Radiology Holds, 14 JBX ALL, 15 JBX ALL PACS, 16 JBX ALL BIG,
 ; 17 JBX BIG NON-PACS,18 NO JB DELETE ENTRY, 19 JBX PACS BIG VER TGA, 21 PURGE-RETEN DAYS PACS BIG,
 ; 22 PURGE-RETENTION DAYS BIG, 24 PURGE-RETENTION DAYS PACS
 ; 
 N DIK,DA,DIU
 S DIK="^DD(2005.2,",DA=.01,DA(1)=2005.2 D ^DIK
 S DIK="^DD(2005.2,",DA=.04,DA(1)=2005.2 D ^DIK
 S DIK="^DD(2005.2,",DA=1,DA(1)=2005.2 D ^DIK
 S DIK="^DD(2005.2,",DA=2,DA(1)=2005.2 D ^DIK
 S DIK="^DD(2005.2,",DA=4,DA(1)=2005.2 D ^DIK
 S DIK="^DD(2005.2,",DA=5.5,DA(1)=2005.2 D ^DIK
 S DIK="^DD(2005.2,",DA=6,DA(1)=2005.2 D ^DIK
 S DIK="^DD(2005.2,",DA=8,DA(1)=2005.2 D ^DIK
 S DIK="^DD(2005.2,",DA=9,DA(1)=2005.2 D ^DIK
 S DIK="^DD(2005.2,",DA=10,DA(1)=2005.2 D ^DIK
 S DIK="^DD(2005.2,",DA=11,DA(1)=2005.2 D ^DIK
 S DIK="^DD(2005.2,",DA=12,DA(1)=2005.2 D ^DIK
 S DIK="^DD(2005.2,",DA=14,DA(1)=2005.2 D ^DIK
 S DIK="^DD(2005.2,",DA=15,DA(1)=2005.2 D ^DIK
 S DIK="^DD(2005.2,",DA=16,DA(1)=2005.2 D ^DIK
 S DIK="^DD(2005.2,",DA=17,DA(1)=2005.2 D ^DIK
 S DIK="^DD(2005.2,",DA=18,DA(1)=2005.2 D ^DIK
 S DIK="^DD(2005.2,",DA=19,DA(1)=2005.2 D ^DIK
 S DIK="^DD(2005.2,",DA=20,DA(1)=2005.2 D ^DIK
 S DIK="^DD(2005.2,",DA=21,DA(1)=2005.2 D ^DIK
 S DIK="^DD(2005.2,",DA=22,DA(1)=2005.2 D ^DIK
 S DIK="^DD(2005.2,",DA=23,DA(1)=2005.2 D ^DIK
 S DIK="^DD(2005.2,",DA=24,DA(1)=2005.2 D ^DIK
 S DIK="^DD(2005.2,",DA=25,DA(1)=2005.2 D ^DIK
 S DIK="^DD(2005.2,",DA=26,DA(1)=2005.2 D ^DIK
 S DIK="^DD(2005.2,",DA=27,DA(1)=2005.2 D ^DIK
 S DIK="^DD(2005.2,",DA=28,DA(1)=2005.2 D ^DIK
 S DIK="^DD(2005.2,",DA=29,DA(1)=2005.2 D ^DIK
 S DIK="^DD(2005.2,",DA=30,DA(1)=2005.2 D ^DIK
 S DIK="^DD(2005.2,",DA=31,DA(1)=2005.2 D ^DIK
 S DIK="^DD(2005.86,",DA=6,DA(1)=2005.86 D ^DIK
 S DIK="^DD(2006.031,",DA=4,DA(1)=2006.031 D ^DIK
 S DIK="^DD(2006.1,",DA=.02,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=.03,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=.031,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=.04,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=.07,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=.08,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=1.02,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=1.03,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=2.01,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=2.02,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=2.03,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=6,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=8,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=9,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=10,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=11,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=11.2,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=11.5,DA(1)=2006.1 D ^DIK ; CRITICAL LOW MESSAGE INTERVAL - RETIRED 
 S DIK="^DD(2006.1,",DA=11.9,DA(1)=2006.1 D ^DIK ; DATE OF LAST CRITICAL MESSAGE - RETIRED
 S DIK="^DD(2006.1,",DA=13,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=14,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=15,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=16,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=17,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=18,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=19,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=21,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=22,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=23,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=24,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=54,DA(1)=2006.1 D ^DIK ; JUKEBOX DEFAULT - RETIRED CHANGED TO 2.01 see above
 S DIK="^DD(2006.1,",DA=60.1,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=60.2,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=60.3,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=60.4,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=60.5,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=60.6,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=61,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=61.1,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=61.2,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=61.3,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=61.4,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=62,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=62.1,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=62.2,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=66.3,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=62.4,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=62.5,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=62.6,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=63,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=63.1,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=63.2,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=63.3,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=63.4,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=63.5,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=64,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=64.5,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=65.5,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=65,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=66,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=67,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=67.1,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=67.2,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=67.3,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=67.4,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=103,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=124,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=125,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.11,",DA=.01,DA(1)=2006.11 D ^DIK
 S DIK="^DD(2006.112,",DA=.01,DA(1)=2006.112 D ^DIK
 S DIK="^DD(2006.8,",DA=.01,DA(1)=2006.8 D ^DIK
 S DIK="^DD(2006.8,",DA=.04,DA(1)=2006.8 D ^DIK
 S DIK="^DD(2006.8,",DA=3,DA(1)=2006.8 D ^DIK
 S DIK="^DD(2006.8,",DA=4,DA(1)=2006.8 D ^DIK
 S DIK="^DD(2006.8,",DA=11,DA(1)=2006.8 D ^DIK
 S DIK="^DD(2006.8,",DA=12,DA(1)=2006.8 D ^DIK
 S DIK="^DD(2006.8,",DA=13,DA(1)=2006.8 D ^DIK
 S DIK="^DD(2006.8,",DA=14,DA(1)=2006.8 D ^DIK
 S DIK="^DD(2006.8,",DA=15,DA(1)=2006.8 D ^DIK
 S DIK="^DD(2006.8,",DA=16,DA(1)=2006.8 D ^DIK
 S DIK="^DD(2006.8,",DA=17,DA(1)=2006.8 D ^DIK
 S DIK="^DD(2006.8,",DA=20,DA(1)=2006.8 D ^DIK
 S DIK="^DD(2006.8,",DA=49,DA(1)=2006.8 D ^DIK
 S DIK="^DD(2006.8,",DA=50,DA(1)=2006.8 D ^DIK
 S DIK="^DD(2006.8,",DA=51,DA(1)=2006.8 D ^DIK
 S DIK="^DD(2006.8,",DA=52,DA(1)=2006.8 D ^DIK
 S DIK="^DD(2006.8,",DA=53,DA(1)=2006.8 D ^DIK
 S DIK="^DD(2006.8,",DA=54,DA(1)=2006.8 D ^DIK
 S DIK="^DD(2006.8,",DA=55,DA(1)=2006.8 D ^DIK
 S DIK="^DD(2006.95,",DA=10,DA(1)=2006.95 D ^DIK
 S DIK="^DD(2006.95,",DA=1,DA(1)=2006.95 D ^DIK
 ; Remove the Jukebox file data dictionary and data
 S DIU="^MAGQUEUE(2006.032,",DIU(0)="D" D EN^DIU2
 ;remove file definitions so that the new file definitions will lay down cleanly
 N DIU
 F DIU=2006.1665,2006.1664,2006.1662,2006.166 D
 . S DIU(0)="S" D EN^DIU2
 . Q
 ; Retire option no longer active
 D RMOPT("MAGQ COQ")
 ; Remove options so new ones install cleanly
 D RMOPT("MAGQ BPMONITOR")
 ; Remove RPC so that it installs cleanly
 D RMRPC("MAGQB QUEDEL")
 D RMRPC("MAGQ JBQUE")
 D RMRPC("MAG FIELD VALIDATE")
 D RMRPC("MAG KEY VALIDATE")
 D RMRPC("MAGQ FTYPE")
 D RMRPC("MAGQ DFNIQ")
 D RMRPC("MAGQ ADD RAID GROUP")
 D RMRPC("MAGQ JBSCN")
 D RMRPC("MAGQBP FREF")
 D RMRPC("MAGQ FS CHNGE")
 D RMRPC("MAGQ QRNGE")
 D RMRPC("MAGQ FINDC")
 D RMRPC("MAGQ QCNT")
 D RMRPC("MAGQ ALL SERVER")
 D RMRPC("MAGQ JBPTR")
 D RMRPC("MAGQB PURNUL")
 D RMRPC("MAGQBP ALL SHARES")
 D RMRPC("MAGQBP CHKN")
 D RMRPC("MAGQ JBP")
 D RMRPC("MAGQ IRP GETNEXT")
 D RMRPC("MAGQ REA")
 D RMRPC("MAGQ REA UPDATE")
 D RMRPC("MAGQ SLAD")
 D RMRPC("MAGQ DEL NLOC")
 D RMRPC("MAGQ BP UAT")
 Q
CFILEN(NUM,NAME) ;
 N DIE,DR,DA
 S DIE="^DIC(",DR=".01///"_NAME,DA=NUM
 D ^DIE
 K DIE,DR,DA
 Q
RMRPC(NAME) ; Removing an RPC in order to revise
 N MW,RPC,MWE,DIERR,DA,DIK
 S MW=$$FIND1^DIC(19,"","X","MAG WINDOWS","","","")
 D CLEAN^DILF
 S RPC=$$FIND1^DIC(8994,"","X",NAME,"","","")
 D CLEAN^DILF
 Q:'RPC
 I MW D
 . S MWE=$$FIND1^DIC(19.05,","_MW_",","X",NAME,"","","")
 . D CLEAN^DILF
 . Q:'MWE
 . S DA=MWE,DA(1)=MW,DIK="^DIC(19,"_DA(1)_",""RPC"","
 . D ^DIK
 . K DA,DIK
 . Q
 S DA=RPC,DIK="^XWB(8994,"
 D ^DIK
 K DA,DIK
 Q
RMOPT(NAME) ; Removing an OPTION from the OPTION File (#19)
 N OPT
 S OPT=$$FIND1^DIC(19,"","X",NAME,"","","")
 D CLEAN^DILF
 Q:'OPT
 I NAME="MAGQ BPMONITOR" D MAGSYS(NAME)
 S DA=OPT,DIK="^DIC(19,"
 D ^DIK
 K DA,DIK
 Q
MAGSYS(NAME) ;
 N MENU,ITEM,DA,DIK
 Q:NAME=""
 S MENU=+$$FIND1^DIC(19,"","X","MAG SYS MENU") Q:'+MENU
 S ITEM=$$FIND1^DIC(19.01,","_MENU_",","B",NAME) Q:'+ITEM
 S DA=ITEM,DA(1)=MENU,DIK="^DIC(19,"_DA(1)_",10," D ^DIK K DA,DIK
 Q

PRCVINIT ;WOIFO/DAP-ITEM/VENDOR FILE INITIALIZATION CALLING; 05/23/05
V ;;5.1;IFCAP;**81**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q
 ;
INIT ;Entry call for the routine, allows users to initialize 
 ;the item and vendor file checksums while offering enhanced feedback
 ;
 ;Verify that site parameter is properly set for use of COTS Inventory Interface
 I $$GET^XPAR("SYS","PRCV COTS INVENTORY",1,"Q")'=1 W !,"The site parameter is not properly set for",!,"use of the COTS Inventory interface!",! Q
 ;
 ;If checksums have already been initialized for the site this routine will quit to avoid errors caused by re-initiating the checksums
 I $D(^PRCV(414.04,1,0)) W !,"Item or Vendor file checksum has already been initialized!",! Q
 ;
 W !,"Item file checksum initialization beginning...",!
 D INIT^PRCVIT
 I $D(^PRCV(414.04,1,0)) W !,"Item file checksum initialization complete!",!
 I '$D(^PRCV(414.04,1,0)) W !,"Item file checksum initialization failed!",! Q
 ;
 W !,"Vendor file checksum initialization beginning...",!
 D INIT^PRCVNDR
 I $D(^PRCV(414.04,2,0)) W !,"Vendor file checksum initialization complete!",!
 I '$D(^PRCV(414.04,2,0)) W !,"Vendor file checksum initialization failed!",! Q
 ;
 Q 

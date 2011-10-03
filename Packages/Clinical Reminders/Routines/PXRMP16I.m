PXRMP16I ; SLC/AGP - Inits for PXRM*2.0*16. ;12/06/2010
 ;;2.0;CLINICAL REMINDERS;**16**;Feb 04, 2005;Build 119
 Q
 ;
PRE ;
 I +$$PATCH^XPDUTL("PXRM*2.0*16")=0 Q
 ;cleanup for test sites only
 N DIU,TEXT
 D EN^DDIOL("Removing old data dictionaries.")
 S DIU(0)=""
 S DIU=801
 S TEXT=" Deleting data dictionary for file # "_DIU
 D EN^DDIOL(TEXT)
 D EN^DIU2
 Q

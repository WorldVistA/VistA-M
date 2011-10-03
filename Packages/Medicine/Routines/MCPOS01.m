MCPOS01 ;HIRMFO/WAA - SEARCH AND DELETE - ;8/6/96  07:25
 ;;2.3;Medicine;;09/13/1996
 ;
 G EN1^MCPOS01A
 ;
 ;====================================================================
 ;
 ; This routine will loop through a file and find all the x-references
 ; for that file and delete them.
 ;
 ; This routine is passed the file number of the file to look through.
 ; 
 ; Input Varables
 ;       MCFN = File number
 ;
EN1(MCFN) ; Main Entry Point
 Q:MCFN<1
 N MCTXT,MCNAME,DIK
 S MCNAME=$$GET1^DID(MCFN,"","","NAME") ; Get Name of File
 S MCTXT(1)=""
 S MCTXT(2)="File: "_MCNAME_" ("_MCFN_")"
 S MCTXT(3)="Cross references for file "_MCNAME_" have been deleted."
 S MCTXT(4)="     Re-indexing file "_MCNAME_"..."
 D MES^XPDUTL(.MCTXT) ; Printing message to output device.
 K MCTXT
 S DIK="^MCAR("_MCFN_","
 D IXALL^DIK
 D BMES^XPDUTL("     Complete...") ; Printing message to output device.
 Q

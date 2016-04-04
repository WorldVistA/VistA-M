DIINI005 ;VEN/TOAD-DI (FILEMAN MENU INIT) ; 05-JAN-2015
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"OPT",1383,20)
 ;;=S DI=2 D EN^DIAX
 ;;^UTILITY(U,$J,"OPT",1383,"U")
 ;;=ADD/DELETE SELECTED ENTRIES
 ;;^UTILITY(U,$J,"OPT",1384,0)
 ;;=DIAX PRINT^Print Selected Entries^^A^^DIEXTRACT^^^^^^^^1^^^
 ;;^UTILITY(U,$J,"OPT",1384,1,0)
 ;;=^^3^3^2921222^
 ;;^UTILITY(U,$J,"OPT",1384,1,1,0)
 ;;= 
 ;;^UTILITY(U,$J,"OPT",1384,1,2,0)
 ;;=Use this option to display the list of entries selected for extract.  This
 ;;^UTILITY(U,$J,"OPT",1384,1,3,0)
 ;;=option uses the standard VA Fileman interface for printing.
 ;;^UTILITY(U,$J,"OPT",1384,20)
 ;;=S DI=3 D EN^DIAX
 ;;^UTILITY(U,$J,"OPT",1384,"U")
 ;;=PRINT SELECTED ENTRIES
 ;;^UTILITY(U,$J,"OPT",1385,0)
 ;;=DIAX MODIFY^Modify Destination File^^A^^DIEXTRACT^^^^^^^^1^^^
 ;;^UTILITY(U,$J,"OPT",1385,1,0)
 ;;=^^3^3^2921222^
 ;;^UTILITY(U,$J,"OPT",1385,1,1,0)
 ;;= 
 ;;^UTILITY(U,$J,"OPT",1385,1,2,0)
 ;;=Use this option to create a destination file that will hold the data
 ;;^UTILITY(U,$J,"OPT",1385,1,3,0)
 ;;=extracted from the source entries.
 ;;^UTILITY(U,$J,"OPT",1385,20)
 ;;=S DI=4 D EN^DIAX
 ;;^UTILITY(U,$J,"OPT",1385,"U")
 ;;=MODIFY DESTINATION FILE
 ;;^UTILITY(U,$J,"OPT",1386,0)
 ;;=DIAX CREATE^Create Extract Template^^A^^DIEXTRACT^^^^^^^^1^^^
 ;;^UTILITY(U,$J,"OPT",1386,1,0)
 ;;=^^4^4^2930104^
 ;;^UTILITY(U,$J,"OPT",1386,1,1,0)
 ;;= 
 ;;^UTILITY(U,$J,"OPT",1386,1,2,0)
 ;;=Use this option to identify the fields to be extracted from the source
 ;;^UTILITY(U,$J,"OPT",1386,1,3,0)
 ;;=file and the fields in the destination file where the extracted data will
 ;;^UTILITY(U,$J,"OPT",1386,1,4,0)
 ;;=be stored.
 ;;^UTILITY(U,$J,"OPT",1386,20)
 ;;=S DI=5 D EN^DIAX
 ;;^UTILITY(U,$J,"OPT",1386,"U")
 ;;=CREATE EXTRACT TEMPLATE
 ;;^UTILITY(U,$J,"OPT",1387,0)
 ;;=DIAX UPDATE^Update Destination File^^A^^DIEXTRACT^^^^^^^^1^^^
 ;;^UTILITY(U,$J,"OPT",1387,1,0)
 ;;=^^3^3^2921222^
 ;;^UTILITY(U,$J,"OPT",1387,1,1,0)
 ;;= 
 ;;^UTILITY(U,$J,"OPT",1387,1,2,0)
 ;;=Use this option to extract data from the source file and move it to the
 ;;^UTILITY(U,$J,"OPT",1387,1,3,0)
 ;;=destination file.
 ;;^UTILITY(U,$J,"OPT",1387,20)
 ;;=S DI=6 D EN^DIAX
 ;;^UTILITY(U,$J,"OPT",1387,"U")
 ;;=UPDATE DESTINATION FILE
 ;;^UTILITY(U,$J,"OPT",1388,0)
 ;;=DIAX PURGE^Purge Extracted Entries^^A^^DIEXTRACT^^^^^^^^1^^^
 ;;^UTILITY(U,$J,"OPT",1388,1,0)
 ;;=^^2^2^2921222^
 ;;^UTILITY(U,$J,"OPT",1388,1,1,0)
 ;;= 
 ;;^UTILITY(U,$J,"OPT",1388,1,2,0)
 ;;=Use this option to delete the extracted data from the primary file.
 ;;^UTILITY(U,$J,"OPT",1388,20)
 ;;=S DI=7 D EN^DIAX
 ;;^UTILITY(U,$J,"OPT",1388,"U")
 ;;=PURGE EXTRACTED ENTRIES
 ;;^UTILITY(U,$J,"OPT",1389,0)
 ;;=DIAX CANCEL^Cancel Extract Selection^^A^^DIEXTRACT^^^^^^^^1^^^
 ;;^UTILITY(U,$J,"OPT",1389,1,0)
 ;;=^^3^3^2921222^
 ;;^UTILITY(U,$J,"OPT",1389,1,1,0)
 ;;= 
 ;;^UTILITY(U,$J,"OPT",1389,1,2,0)
 ;;=Use this option to cancel an extract activity any time before the selected
 ;;^UTILITY(U,$J,"OPT",1389,1,3,0)
 ;;=entries in the primary file are purged.
 ;;^UTILITY(U,$J,"OPT",1389,20)
 ;;=S DI=8 D EN^DIAX
 ;;^UTILITY(U,$J,"OPT",1389,"U")
 ;;=CANCEL EXTRACT SELECTION
 ;;^UTILITY(U,$J,"OPT",1390,0)
 ;;=DIAX VALIDATE^Validate Extract Template^^A^^DIEXTRACT^^^^^^^^1^^^
 ;;^UTILITY(U,$J,"OPT",1390,1,0)
 ;;=^^3^3^2930104^
 ;;^UTILITY(U,$J,"OPT",1390,1,1,0)
 ;;= 
 ;;^UTILITY(U,$J,"OPT",1390,1,2,0)
 ;;=Use this option to verify the compatibility between fields to be extracted
 ;;^UTILITY(U,$J,"OPT",1390,1,3,0)
 ;;=and their corresponding destination fields in the destination file.
 ;;^UTILITY(U,$J,"OPT",1390,20)
 ;;=S DI=9 D EN^DIAX
 ;;^UTILITY(U,$J,"OPT",1390,"U")
 ;;=VALIDATE EXTRACT TEMPLATE
 ;;^UTILITY(U,$J,"OPT",1391,0)
 ;;=DDXP FORMAT DOCUMENTATION^Print Format Documentation^^A^^^^^^^^^^1
 ;;^UTILITY(U,$J,"OPT",1391,1,0)
 ;;=^^2^2^2921207^^
 ;;^UTILITY(U,$J,"OPT",1391,1,1,0)
 ;;=Use this option ot print documentation for existing entries in the Foreign
 ;;^UTILITY(U,$J,"OPT",1391,1,2,0)
 ;;=Format file.
 ;;^UTILITY(U,$J,"OPT",1391,20)
 ;;=D 5^DDXP
 ;;^UTILITY(U,$J,"OPT",1391,"U")
 ;;=PRINT FORMAT DOCUMENTATION
 ;;^UTILITY(U,$J,"OPT",1392,0)
 ;;=DI SORT COMPILE^Sort Template Compile/Uncompile^^R^^^^^^^^
 ;;^UTILITY(U,$J,"OPT",1392,1,0)
 ;;=^^3^3^2930715^^
 ;;^UTILITY(U,$J,"OPT",1392,1,1,0)
 ;;=This option allows the user to mark a Sort Template compiled or uncompiled.
 ;;^UTILITY(U,$J,"OPT",1392,1,2,0)
 ;;=The actual routine compilation occurs when the template is used during
 ;;^UTILITY(U,$J,"OPT",1392,1,3,0)
 ;;=FileMan Sort/Print.
 ;;^UTILITY(U,$J,"OPT",1392,25)
 ;;=EN1^DIOZ
 ;;^UTILITY(U,$J,"OPT",1392,"U")
 ;;=SORT TEMPLATE COMPILE/UNCOMPIL
 ;;^UTILITY(U,$J,"OPT",1393,0)
 ;;=DDBROWSER^Browser^^R^^^^^^^^
 ;;^UTILITY(U,$J,"OPT",1393,1,0)
 ;;=^^3^3^2940519^
 ;;^UTILITY(U,$J,"OPT",1393,1,1,0)
 ;;=Prompts user to select file, word processing field and entry.
 ;;^UTILITY(U,$J,"OPT",1393,1,2,0)
 ;;=The text is then displayed to the screen, allowing the user to
 ;;^UTILITY(U,$J,"OPT",1393,1,3,0)
 ;;=navigate through the document.
 ;;^UTILITY(U,$J,"OPT",1393,25)
 ;;=DDBR
 ;;^UTILITY(U,$J,"OPT",1393,99.1)
 ;;=56123,39787
 ;;^UTILITY(U,$J,"OPT",1393,"U")
 ;;=BROWSER
 ;;^UTILITY(U,$J,"OPT",1394,0)
 ;;=DDS DELETE A FORM^Delete a Form^^R^^^^^^^^
 ;;^UTILITY(U,$J,"OPT",1394,1,0)
 ;;=^^1^1^2940630^^
 ;;^UTILITY(U,$J,"OPT",1394,1,1,0)
 ;;=An option to delete a form.
 ;;^UTILITY(U,$J,"OPT",1394,25)
 ;;=DDSDFRM
 ;;^UTILITY(U,$J,"OPT",1394,99.1)
 ;;=56123,39787
 ;;^UTILITY(U,$J,"OPT",1394,"U")
 ;;=DELETE A FORM
 ;;^UTILITY(U,$J,"OPT",1395,0)
 ;;=DDS PURGE UNUSED BLOCKS^Purge Unused Blocks^^R^^^^^^^^
 ;;^UTILITY(U,$J,"OPT",1395,1,0)
 ;;=^^3^3^2940630^
 ;;^UTILITY(U,$J,"OPT",1395,1,1,0)
 ;;=An option to delete blocks that aren't used on any forms.  This option
 ;;^UTILITY(U,$J,"OPT",1395,1,2,0)
 ;;=prompts for file, and searches the Block File for all blocks that are
 ;;^UTILITY(U,$J,"OPT",1395,1,3,0)
 ;;=associated with that file and that aren't used on any forms.
 ;;^UTILITY(U,$J,"OPT",1395,25)
 ;;=DDSDBLK
 ;;^UTILITY(U,$J,"OPT",1395,99.1)
 ;;=56123,39787
 ;;^UTILITY(U,$J,"OPT",1395,"U")
 ;;=PURGE UNUSED BLOCKS
 ;;^UTILITY(U,$J,"OPT",7716,0)
 ;;=DDMP IMPORT^Import Data^^R^^^^^^^^
 ;;^UTILITY(U,$J,"OPT",7716,1,0)
 ;;=^^2^2^2960724^^^^
 ;;^UTILITY(U,$J,"OPT",7716,1,1,0)
 ;;=This option gathers specification from the user for the import of data from 
 ;;^UTILITY(U,$J,"OPT",7716,1,2,0)
 ;;=a host ascii file.  The import is done and a report generated.
 ;;^UTILITY(U,$J,"OPT",7716,25)
 ;;=EN^DDMPU
 ;;^UTILITY(U,$J,"OPT",7716,"U")
 ;;=IMPORT DATA
 ;;^UTILITY(U,$J,"OPT",8012,0)
 ;;=DMSQ PROJECT^Regenerate SQLI Projection^^R^^XUPROGMODE^^^^^^MSC FILEMAN^^1^1
 ;;^UTILITY(U,$J,"OPT",8012,1,0)
 ;;=^^17^17^2971026^^^^
 ;;^UTILITY(U,$J,"OPT",8012,1,1,0)
 ;;=Regenerates the SQLI projection of VA FileMan data dictionaries. The
 ;;^UTILITY(U,$J,"OPT",8012,1,2,0)
 ;;=regeneration process:
 ;;^UTILITY(U,$J,"OPT",8012,1,3,0)
 ;;= 
 ;;^UTILITY(U,$J,"OPT",8012,1,4,0)
 ;;=  1. Purges existing information in SQLI data files.
 ;;^UTILITY(U,$J,"OPT",8012,1,5,0)
 ;;=  2. Projects the data dictionaries for all VA FileMan files.
 ;;^UTILITY(U,$J,"OPT",8012,1,6,0)
 ;;= 
 ;;^UTILITY(U,$J,"OPT",8012,1,7,0)
 ;;=Before running this option, the SQLI_KEY_WORD file should be populated
 ;;^UTILITY(U,$J,"OPT",8012,1,8,0)
 ;;=with all SQL, ODBC, and vendor-specific keywords that should not be used
 ;;^UTILITY(U,$J,"OPT",8012,1,9,0)
 ;;=in SQLI entity naming.
 ;;^UTILITY(U,$J,"OPT",8012,1,10,0)
 ;;= 
 ;;^UTILITY(U,$J,"OPT",8012,1,11,0)
 ;;=This option requires programmer mode as well as the progmode key.
 ;;^UTILITY(U,$J,"OPT",8012,1,12,0)
 ;;= 
 ;;^UTILITY(U,$J,"OPT",8012,1,13,0)
 ;;=This option may also be used as a skeleton for one that you may want
 ;;^UTILITY(U,$J,"OPT",8012,1,14,0)
 ;;=to create locally.  Your local option could include the vendor's
 ;;^UTILITY(U,$J,"OPT",8012,1,15,0)
 ;;=keyword call in the Entry Action and the vendor's mapping call in the
 ;;^UTILITY(U,$J,"OPT",8012,1,16,0)
 ;;=Exit Action.  A status variable could be used to confirm that the
 ;;^UTILITY(U,$J,"OPT",8012,1,17,0)
 ;;=SQLI projection completes before the vendor mapping is initiated.
 ;;^UTILITY(U,$J,"OPT",8012,15)
 ;;=;vendor's mapper call could go here
 ;;^UTILITY(U,$J,"OPT",8012,20)
 ;;=;vendor's keyword call could go here
 ;;^UTILITY(U,$J,"OPT",8012,25)
 ;;=SETUP^DMSQ
 ;;^UTILITY(U,$J,"OPT",8012,200.9)
 ;;=y
 ;;^UTILITY(U,$J,"OPT",8012,"U")
 ;;=REGENERATE SQLI PROJECTION
 ;;^UTILITY(U,$J,"OPT",8013,0)
 ;;=DMSQ MENU^SQLI (VA FileMan)^^M^^^^^^^^MSC FILEMAN
 ;;^UTILITY(U,$J,"OPT",8013,1,0)
 ;;=^^1^1^2970806^^^^
 ;;^UTILITY(U,$J,"OPT",8013,1,1,0)
 ;;=This is the main menu for all VA FileMan SQLI (SQL Interface) options.
 ;;^UTILITY(U,$J,"OPT",8013,10,0)
 ;;=^19.01IP^8^7
 ;;^UTILITY(U,$J,"OPT",8013,10,1,0)
 ;;=8012^RUN^10
 ;;^UTILITY(U,$J,"OPT",8013,10,1,"^")
 ;;=DMSQ PROJECT
 ;;^UTILITY(U,$J,"OPT",8013,10,2,0)
 ;;=8014^X^30
 ;;^UTILITY(U,$J,"OPT",8013,10,2,"^")
 ;;=DMSQ PURGE
 ;;^UTILITY(U,$J,"OPT",8013,10,4,0)
 ;;=8015^ERR^20
 ;;^UTILITY(U,$J,"OPT",8013,10,4,"^")
 ;;=DMSQ PRINT ERRORS
 ;;^UTILITY(U,$J,"OPT",8013,10,5,0)
 ;;=8016^CNTS^50
 ;;^UTILITY(U,$J,"OPT",8013,10,5,"^")
 ;;=DMSQ PS MENU
 ;;^UTILITY(U,$J,"OPT",8013,10,6,0)
 ;;=8034^DD^40
 ;;^UTILITY(U,$J,"OPT",8013,10,6,"^")
 ;;=DMSQ TS MENU
 ;;^UTILITY(U,$J,"OPT",8013,10,7,0)
 ;;=8035^GRP^60

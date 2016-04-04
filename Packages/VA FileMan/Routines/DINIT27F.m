DINIT27F ;SFISC/DPC-EIGN FORMAT WORD (COMMA) ;11/30/92  3:46 PM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(ENTRY+I) G:X="" ^DINIT27G S Y=$E($T(ENTRY+I+1),5,999),X=$E(X,4,999),@X=Y
 Q
ENTRY ;
 ;;^DIST(.44,.006,0)
 ;;=WORD DATA FILE (COMMA)^,^^^^^1^250^1^1^^0
 ;;^DIST(.44,.006,1)
 ;;=W $$FLDNM^DDXPLIB(DDXPXTNO)
 ;;^DIST(.44,.006,3,0)
 ;;=^^5^5^2921106^
 ;;^DIST(.44,.006,3,1,0)
 ;;=The format creates records with comma delimited fields.  Non-numeric
 ;;^DIST(.44,.006,3,2,0)
 ;;=fields are in quotes.  The user is prompted for field names that are
 ;;^DIST(.44,.006,3,3,0)
 ;;=output as the first line of the exported file.
 ;;^DIST(.44,.006,3,4,0)
 ;;=This format was designed to be used to create a Data File for use with
 ;;^DIST(.44,.006,3,5,0)
 ;;=Microsoft Word's Print Merge utility.
 ;;^DIST(.44,.006,4,0)
 ;;=^^6^6^2921106^
 ;;^DIST(.44,.006,4,1,0)
 ;;=Use the exported file as the Data File for Microsoft Word's Print Merge
 ;;^DIST(.44,.006,4,2,0)
 ;;=utility.  The Merge Field names are contained in the first line of exported
 ;;^DIST(.44,.006,4,3,0)
 ;;=data.  See the Word documentation and Descriptions of Other Names for
 ;;^DIST(.44,.006,4,4,0)
 ;;=instructions for importing into various versions of Word.
 ;;^DIST(.44,.006,4,5,0)
 ;;=(Note: Word does not allow spaces and some other punctuation in the Merge
 ;;^DIST(.44,.006,4,6,0)
 ;;=Field names.)
 ;;^DIST(.44,.006,5,0)
 ;;=^.441^3^3
 ;;^DIST(.44,.006,5,1,0)
 ;;=WORD 5.0 (MACINTOSH)
 ;;^DIST(.44,.006,5,1,1,0)
 ;;=^^7^7^2921106^
 ;;^DIST(.44,.006,5,1,1,1,0)
 ;;=To use the exported file as a Data File:
 ;;^DIST(.44,.006,5,1,1,2,0)
 ;;=1) With Main Document open, select Print Merge Helper on the View menu and
 ;;^DIST(.44,.006,5,1,1,3,0)
 ;;=choose the exported file as the Data File.
 ;;^DIST(.44,.006,5,1,1,4,0)
 ;;=2)From the Insert Field Names box on the Print Merge Helper bar, insert
 ;;^DIST(.44,.006,5,1,1,5,0)
 ;;=the field names into the Main Document.
 ;;^DIST(.44,.006,5,1,1,6,0)
 ;;=3)Select Print Merge from the File menu to merge the exported data into
 ;;^DIST(.44,.006,5,1,1,7,0)
 ;;=the Main Document.
 ;;^DIST(.44,.006,5,2,0)
 ;;=WORD 4.0 (MACINTOSH)
 ;;^DIST(.44,.006,5,2,1,0)
 ;;=^^8^8^2921106^
 ;;^DIST(.44,.006,5,2,1,1,0)
 ;;=To use the exported file as a Data file:
 ;;^DIST(.44,.006,5,2,1,2,0)
 ;;=1)Into the main document enter the Merge Instruction 'DATA' followed by
 ;;^DIST(.44,.006,5,2,1,3,0)
 ;;=the file name of your exported file surrounded by Merge Quotes.
 ;;^DIST(.44,.006,5,2,1,4,0)
 ;;=2)Enter your field names in the Main Document.  The names must match
 ;;^DIST(.44,.006,5,2,1,5,0)
 ;;=exactly those on the first line of the Data (exported) file and be
 ;;^DIST(.44,.006,5,2,1,6,0)
 ;;=surrounded by Merge Quotes (<OPTION-\> AND <OPTION-SHIFT-\>).
 ;;^DIST(.44,.006,5,2,1,7,0)
 ;;=3)Select Print Merge from the File menu to merge the data into the Main
 ;;^DIST(.44,.006,5,2,1,8,0)
 ;;=Document.
 ;;^DIST(.44,.006,5,3,0)
 ;;=WINWORD 2.0
 ;;^DIST(.44,.006,5,3,1,0)
 ;;=^^7^7^2921106^
 ;;^DIST(.44,.006,5,3,1,1,0)
 ;;=To use the exported file as the Data file:
 ;;^DIST(.44,.006,5,3,1,2,0)
 ;;=1) With the Main Document open, select Print Merge from the File menu and
 ;;^DIST(.44,.006,5,3,1,3,0)
 ;;=press Attach Data File button.  Select your exported file as the Data
 ;;^DIST(.44,.006,5,3,1,4,0)
 ;;=file.
 ;;^DIST(.44,.006,5,3,1,5,0)
 ;;=2) Use the Insert Merge Fields box to place Merge Fields in the Main
 ;;^DIST(.44,.006,5,3,1,6,0)
 ;;=Document.
 ;;^DIST(.44,.006,5,3,1,7,0)
 ;;=3) Again select Print Merge from the File menu and press the Merge button.
 ;;^DIST(.44,.006,5,"B","WINWORD 2.0",3)
 ;;=
 ;;^DIST(.44,.006,5,"B","WORD 4.0 (MACINTOSH)",2)
 ;;=
 ;;^DIST(.44,.006,5,"B","WORD 5.0 (MACINTOSH)",1)
 ;;=

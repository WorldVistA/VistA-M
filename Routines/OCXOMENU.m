OCXOMENU ;SLC/RJS,CLA -  Rule Display (Expert System - Report Menu ) ;10/29/98  12:37
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**32**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
 ;
S ;
 ;
 N QUIT S QUIT=0 F  D  Q:QUIT
 .W !!!!
 .N LIST,LINE,TEXT
 .F LINE=1:1:999 S TEXT=$T(MENU+LINE) Q:$P(TEXT,";",2)  D
 ..S LIST(LINE)=$P(TEXT,";",3)
 ..W !,$J(LINE,3),". ",$P(TEXT,";",4)
 .W !!,"Choose 1 - ",(LINE-1),": " S ANS=$$READ,QUIT=(ANS=U) Q
 .S QUIT='ANS
 .I 'QUIT,$D(LIST(+ANS)) D @LIST(+ANS) W !!,"Press enter...  " S ZZZ=$$READ,QUIT=(ZZZ[U) W !
 ;
 Q
 ;
MENU ;
 ;;EN^OCXOCMPR;Function Library Report (Brief);
 ;;REPORT^OCXOCMPR;Function Library Report (Internal - External Function calls);
 ;;EDIT^OCXOCMPR;Function Library Code Edit;
 ;;SCAN^OCXOCMPR;Scan Entire OCX system for a string;
 ;;ERROR^OCXOCMPR;Scan ^%ZTER for Order Check related errors;
 ;;^OCXODSP;Expert System Display;
 ;;^OCXOEDT;Expert System Editor;
 ;1;
 ;
READ() ;
 N OCXX
 R OCXX:DTIME E  Q U
 Q OCXX
 ;

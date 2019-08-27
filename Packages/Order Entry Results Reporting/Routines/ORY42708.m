ORY42708 ;SLC/RJS,CLA - OCX PACKAGE RULE TRANSPORT ROUTINE ;MAR 7,2017 at 15:12
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**427**;Dec 17,1997;Build 105
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
 ; This is a post intall routine and can be deleted after install of patch OR*3*427
S ;
 ;
 D DOT^ORY427ES
 ;
 ;
 K REMOTE,LOCAL,OPCODE,REF
 F LINE=1:1:500 S TEXT=$P($T(DATA+LINE),";",2,999) Q:TEXT  I $L(TEXT) D  Q:QUIT
 .S ^TMP("OCXRULE",$J,$O(^TMP("OCXRULE",$J,"A"),-1)+1)=TEXT
 ;
 ;
 ;
 Q
 ;
DATA ;
 ;
 ;;D^CLOZAPINE ANC W/IN 7 FLAG
 ;;R^"860.3:","860.31:2",2,"E"
 ;;D^LOGICAL TRUE
 ;;EOR^
 ;;KEY^860.3:^CLOZAPINE ANC >= 1.0 & < 1.5
 ;;R^"860.3:",.01,"E"
 ;;D^CLOZAPINE ANC >= 1.0 & < 1.5
 ;;R^"860.3:",.02,"E"
 ;;D^CPRS ORDER PRESCAN
 ;;R^"860.3:","860.31:1",.01,"E"
 ;;D^1
 ;;R^"860.3:","860.31:1",1,"E"
 ;;D^CLOZAPINE ANC W/IN 7 RESULT
 ;;R^"860.3:","860.31:1",2,"E"
 ;;D^GREATER THAN
 ;;R^"860.3:","860.31:1",3,"E"
 ;;D^.999
 ;;R^"860.3:","860.31:2",.01,"E"
 ;;D^2
 ;;R^"860.3:","860.31:2",1,"E"
 ;;D^CLOZAPINE ANC W/IN 7 RESULT
 ;;R^"860.3:","860.31:2",2,"E"
 ;;D^LESS THAN
 ;;R^"860.3:","860.31:2",3,"E"
 ;;D^1.5
 ;;R^"860.3:","860.31:3",.01,"E"
 ;;D^3
 ;;R^"860.3:","860.31:3",1,"E"
 ;;D^CLOZAPINE ANC W/IN 7 FLAG
 ;;R^"860.3:","860.31:3",2,"E"
 ;;D^LOGICAL TRUE
 ;;EOR^
 ;;KEY^860.3:^CLOZAPINE DRUG SELECTED
 ;;R^"860.3:",.01,"E"
 ;;D^CLOZAPINE DRUG SELECTED
 ;;R^"860.3:",.02,"E"
 ;;D^CPRS ORDER PRESCAN
 ;;R^"860.3:","860.31:1",.01,"E"
 ;;D^1
 ;;R^"860.3:","860.31:1",1,"E"
 ;;D^ORDER MODE
 ;;R^"860.3:","860.31:1",2,"E"
 ;;D^EQ FREE TEXT
 ;;R^"860.3:","860.31:1",3,"E"
 ;;D^SELECT
 ;;R^"860.3:","860.31:2",.01,"E"
 ;;D^2
 ;;R^"860.3:","860.31:2",1,"E"
 ;;D^FILLER
 ;;R^"860.3:","860.31:2",2,"E"
 ;;D^STARTS WITH
 ;;R^"860.3:","860.31:2",3,"E"
 ;;D^PS
 ;;R^"860.3:","860.31:5",.01,"E"
 ;;D^5
 ;;R^"860.3:","860.31:5",1,"E"
 ;;D^CLOZAPINE MED
 ;;R^"860.3:","860.31:5",2,"E"
 ;;D^LOGICAL TRUE
 ;;EOR^
 ;;KEY^860.3:^CLOZAPINE NO ANC W/IN 7 DAYS
 ;;R^"860.3:",.01,"E"
 ;;D^CLOZAPINE NO ANC W/IN 7 DAYS
 ;;R^"860.3:",.02,"E"
 ;;D^CPRS ORDER PRESCAN
 ;;R^"860.3:","860.31:6",.01,"E"
 ;;D^6
 ;;R^"860.3:","860.31:6",1,"E"
 ;;D^CLOZAPINE ANC W/IN 7 FLAG
 ;;R^"860.3:","860.31:6",2,"E"
 ;;D^LOGICAL FALSE
 ;;EOR^
 ;;KEY^860.3:^CLOZAPINE NO WBC W/IN 7 DAYS
 ;;R^"860.3:",.01,"E"
 ;;D^CLOZAPINE NO WBC W/IN 7 DAYS
 ;;R^"860.3:",.02,"E"
 ;;D^CPRS ORDER PRESCAN
 ;;R^"860.3:","860.31:4",.01,"E"
 ;;D^4
 ;;R^"860.3:","860.31:4",1,"E"
 ;;D^CLOZAPINE WBC W/IN 7 FLAG
 ;;R^"860.3:","860.31:4",2,"E"
 ;;D^LOGICAL FALSE
 ;;EOR^
 ;;EOF^OCXS(860.3)^1
 ;;SOF^860.2  ORDER CHECK RULE
 ;;KEY^860.2:^CLOZAPINE
 ;;R^"860.2:",.01,"E"
 ;;D^CLOZAPINE
 ;;R^"860.2:","860.21:1",.01,"E"
 ;;D^NO WBC W/IN 7 DAYS
 ;;R^"860.2:","860.21:1",.02,"E"
 ;;D^SIMPLE DEFINITION
 ;;R^"860.2:","860.21:1",1,"E"
 ;;D^CLOZAPINE NO WBC W/IN 7 DAYS
 ;;R^"860.2:","860.21:1",2,"E"
 ;;D^CLOZAPINE AND NO WBC W/IN 7 DAYS
 ;;R^"860.2:","860.21:10",.01,"E"
 ;;D^1.0 >= ANC < 1.5
 ;;R^"860.2:","860.21:10",.02,"E"
 ;;D^SIMPLE DEFINITION
 ;;R^"860.2:","860.21:10",1,"E"
 ;;D^CLOZAPINE ANC >= 1.0 & < 1.5
 ;;R^"860.2:","860.21:4",.01,"E"
 ;;D^ANC < 1.0
 ;;R^"860.2:","860.21:4",.02,"E"
 ;;D^SIMPLE DEFINITION
 ;;R^"860.2:","860.21:4",1,"E"
 ;;D^CLOZAPINE ANC < 1.0
 ;;R^"860.2:","860.21:6",.01,"E"
 ;;D^NO ANC W/IN 7 DAYS
 ;;R^"860.2:","860.21:6",.02,"E"
 ;;D^SIMPLE DEFINITION
 ;;R^"860.2:","860.21:6",1,"E"
 ;;D^CLOZAPINE NO ANC W/IN 7 DAYS
 ;;R^"860.2:","860.21:7",.01,"E"
 ;;D^CLOZAPINE
 ;;R^"860.2:","860.21:7",.02,"E"
 ;;D^SIMPLE DEFINITION
 ;;R^"860.2:","860.21:7",1,"E"
 ;;D^CLOZAPINE DRUG SELECTED
 ;;R^"860.2:","860.22:1",.01,"E"
 ;;D^1
 ;;R^"860.2:","860.22:1",1,"E"
 ;;D^CLOZAPINE AND (NO WBC W/IN 7 DAYS OR NO ANC W/IN 7 DAYS)
 ;;R^"860.2:","860.22:1",2,"E"
 ;;D^CLOZAPINE APPROPRIATENESS
 ;;R^"860.2:","860.22:1",6,"E"
 ;;D^Clozapine orders require a CBC/Diff within past 7 days.  Please order CBC/Diff with WBC and ANC immediately.  Most recent results - |CLOZ LAB RSLTS|
 ;;R^"860.2:","860.22:2",.01,"E"
 ;;D^2
 ;;R^"860.2:","860.22:2",1,"E"
 ;;D^CLOZAPINE AND ANC < 1.0
 ;;R^"860.2:","860.22:2",2,"E"
 ;;D^CLOZAPINE APPROPRIATENESS
 ;;R^"860.2:","860.22:2",6,"E"
 ;;D^Moderate/Severe Neutropenia - please repeat CBC/Diff including WBC and ANC tests immediately and Daily until ANC stabilizes to greater than or equal to 1000. Most recent results - |CLOZ LAB RSLTS|
 ;;R^"860.2:","860.22:3",.01,"E"
 ;;D^3
 ;;R^"860.2:","860.22:3",1,"E"
 ;;D^CLOZAPINE AND (1.0 >= ANC < 1.5)
 ;;R^"860.2:","860.22:3",2,"E"
 ;;D^CLOZAPINE APPROPRIATENESS
 ;;R^"860.2:","860.22:3",6,"E"
 ;;D^Mild Neutropenia - please repeat CBC/Diff including WBC and ANC tests immediately and 3X weekly until ANC stabilizes to greater than or equal to 1500. Most recent results - |CLOZ LAB RSLTS|
 ;;EOR^
 ;;EOF^OCXS(860.2)^1
 ;1;
 ;

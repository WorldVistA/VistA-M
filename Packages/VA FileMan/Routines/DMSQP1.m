DMSQP1 ;SFISC/EZ-PRINT SAMPLE SQLI STATS ;10/30/97  17:06
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 Q
OK ; check if okay to run
 I '$O(^DMSQ("S",0)) W !?5,"Sorry, SQLI files are empty.",! S DMQ=1 Q 
 I $$WAIT^DMSQT1 D  S DMQ=1 Q
 . W !?5,"Try later.  SQLI is being re-built right now."
 Q
EN1 ; print total regular tables
 S DMQ="" D OK I DMQ K DMQ Q
 S DHD="SQLI TABLE COUNT (EXCLUDING INDEX-TYPE)"
 S DIC="1.5215",L=0,FLDS="!T_NAME;""REGULAR TABLES"""
 S BY="3",(FR,TO)="@"
 D EN1^DIP K DMQ Q
EN2 ; print total columns
 S DMQ="" D OK I DMQ K DMQ Q
 S DHD="SQLI COLUMN COUNT FOR ALL TABLES"
 S DIC="1.5217",L=0,FLDS="!(#.01);""COLUMNS"""
 S BY="NUMBER",(FR,TO)=""
 D EN1^DIP K DMQ Q
EN3 ; print totals for indexes
 S DMQ="" D OK I DMQ K DMQ Q
 S DHD="SQLI INDEX COUNT (INDEX-TYPE TABLES)"
 S DIC="1.5215",L=0,FLDS="!T_NAME;""INDEXES"""
 S BY(0)="^DMSQ(""T"",""E"",",L(0)=2
 D EN1^DIP K DMQ Q
EN4 ; print totals for types of table elements
 S DMQ="" D OK I DMQ K DMQ Q
 S DHD="SQLI TABLE ELEMENT TYPE TOTALS"
 S DIC="1.5216",L=0,FLDS="!E_TYPE"
 S BY(0)="^DMSQ(""E"",""E"",",L(0)=2
 S DISPAR(0,1)="+^;""TYPE= "";C1;S"
 S DISPAR(0,1,"OUT")="S Y=$$EXTERNAL^DILFD(1.5216,3,,Y)"
 D EN1^DIP K DMQ Q
EN5 ; print totals for columns in tables
 S DMQ="" D OK I DMQ K DMQ Q
 S DHD="SQLI COLUMN TOTALS BY TABLE"
 S DIC="1.5216",L=0,FLDS="!(#.01);"""""
 S BY(0)="^DMSQ(""E"",""F"",",L(0)=3
 S DISPAR(0,1)="^;S;C1;""TABLE: """
 S DISPAR(0,1,"OUT")="S Y=$P(^DMSQ(""T"",Y,0),U,1)"
 S DISPAR(0,2)="+^;",(FR(0,2),TO(0,2))="C"
 D EN1^DIP K DMQ Q
EN6 ; show totals of EN5 largest to smallest
 S DMQ="" D OK I DMQ K DMQ Q
 S DHD="SQLI TABLES SORTED BY TOTAL COLUMNS" K ^TMP("DMSQ",$J)
 S DM=0 F  S DM=$O(^DMSQ("E","F",DM)) Q:DM'>0  D
 . S DM1=0 F  S DM1=$O(^DMSQ("E","F",DM,DM1)) Q:DM1=""  D
 .. Q:DM1'="C"  S (DM2,DMC)=0
 .. F  S DM2=$O(^DMSQ("E","F",DM,DM1,DM2)) Q:DM2'>0  S DMC=DMC+1
 .. S:DMC DMC1=9999999-DMC,^TMP("DMSQ",$J,DMC1,DMC,DM)=""
 S DIC="1.5215",L=0,FLDS="T_NAME;C20"
 S BY(0)="^TMP(""DMSQ"",$J,",L(0)=3
 S DISPAR(0,2)="^;C1;S;""COLUMN COUNT:  """
 D EN1^DIP
 K DM,DM1,DM2,DMC,DMC1,^TMP("DMSQ",$J) Q
EN7 ; print total columns just for regular tables
 S DMQ="" D OK I DMQ K DMQ Q
 S DHD="SQLI COLUMN COUNT FOR REGULAR TABLES (EXCLUDING INDEXES)"
 S DIC="1.5217",L=0,FLDS="!(#.01);""COLUMNS"""
 S BY="NUMBER",(FR,TO)=""
 S DIS(0)="I '$P(^DMSQ(""T"",$P(^DMSQ(""E"",$P(^DMSQ(""C"",D0,0),U,1),0),U,3),0),U,4)"
 D EN1^DIP K DMQ Q
EN8 ; print total columns, regular tables, excluding Table_IDs
 S DMQ="" D OK I DMQ K DMQ Q
 S DHD="SQLI COLUMN COUNT, REGULAR TABLES, EXCLUDING TABLE_IDS"
 S DIC="1.5217",L=0,FLDS="!(#.01);""COLUMNS"""
 S BY(0)="^DMSQ(""C"",""D"",",L(0)=3
 D EN1^DIP K DMQ Q
EN9 ; print subtotals by domain for regular table columns
 S DMQ="" D OK I DMQ K DMQ Q
 S DHD="SQLI COLUMN COUNT BY DOMAIN (REGULAR TABLES, EXCLUDING TABLE_IDS)"
 S DIC="1.5216",L=0,FLDS="!(#.01);""COLUMNS"""
 S BY(0)="^DMSQ(""E"",""C"",",L(0)=2
 S DISPAR(0,1)="+^;""DOMAIN= "";C1;S"
 S DISPAR(0,1,"OUT")="S:Y Y=$P(^DMSQ(""DM"",Y,0),U,1)"
 S DIS(0)="I $P(^DMSQ(""E"",D0,0),U,4)'=""P"",$P($G(^DMSQ(""C"",D0,0)),U,5)"
 D EN1^DIP K DMQ Q

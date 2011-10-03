RCXVP232 ;ALBANY OI@ALTOONA,PA/TJK-AR Data Extraction - Post-Install Program ;8/18/05
 ;;4.5;Accounts Receivable;**232**;Mar 20, 1995
 ;
 ;** Program Description **
 ;  This program will be run on installation of patch
 ;  PRCA*4.5*232 for CBO to ARC Data Extractions
 ;
EN ; Entry Point
 ; Reset CBO Flag field to for bills in NEW BILL status to "INCLUDE"
 S $P(^PRCA(430.3,18,0),U,6)=1
 Q
 ;

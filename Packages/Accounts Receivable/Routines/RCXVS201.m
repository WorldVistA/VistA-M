RCXVS201 ;DAOU/ALA-AR Data Extraction Pre-Install Program ;23-JUL-03
 ;;4.5;Accounts Receivable;**201**;Mar 20, 1995
 ;
 ;** Program Description **
 ;  This program will be run on installation of patch
 ;  PRCA*4.5*201 for CBO to ARC Data Extractions
 ;
EN ; Entry Point
 ;
 K ^TMP("RCXVINSTALL")
 M ^TMP("RCXVINSTALL")=XPDQUES
 ;
 Q

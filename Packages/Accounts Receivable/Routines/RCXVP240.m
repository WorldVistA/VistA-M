RCXVP240 ;TJK/Albany OI@Altoona,Pa.-AR Data Extraction Post-Install Program ;23-JUL-03
 ;;4.5;Accounts Receivable;**240**;Mar 20, 1995
 ;
 ;** Program Description **
 ;  This program will be run on installation of patch
 ;  PRCA*4.5*240 for CBO Active Bills to ARC Data Extractions
 ;
EN ; Entry Point
 ;  Set up the active records into the AR Queue File (#348.4)
 N RCXVDSC,RCXVFL,ZTDESC,ZTRTN,ZTIO,ZTDTH
 S RCXVDSC="CBO ACTIVE BILLS"
 S RCXVFL=$$TASK^RCXVUTIL(RCXVDSC)
 I 'RCXVFL D
 . S ZTDESC=RCXVDSC,ZTRTN="ACT^RCXVTSK",ZTIO=""
 . S ZTDTH=$$DT^XLFDT()_".20"
 . D ^%ZTLOAD
 Q

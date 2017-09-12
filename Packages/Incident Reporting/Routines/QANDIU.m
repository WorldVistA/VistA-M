QANDIU ;WCIOFO/ERC-Delete obsolete files 513.72, 513.941  /9/25/97
 ;;2.0;Incident Reporting;**24**;10/6/92
 ; This routine deletes files 513.72 (*PATIENT QA EVENT FILE) and
 ; 513.941 (*INCIDENT TYPE FILE). These files were used in the
 ; precursor to the current Incident Reporting package, which uses
 ; files in the 742 file range.
 N DIU
 S DIU="^PRMQ(513.941,",DIU(0)="TSD"
 D EN^DIU2
 S DIU="^PRMQ(513.72,",DIU(0)="DST"
 D EN^DIU2
 Q

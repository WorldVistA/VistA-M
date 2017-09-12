RA15PST1 ;HIRMFO/CRT - Post-init number one (patch fifteen) ;5/19/99
VERSION ;;5.0;Radiology/Nuclear Medicine;**15**;Mar 16, 1998
 ;
EN1 ; Edit entry in the LABEL PRINT FIELDS (78.7) file
 ;
 N RAFDA
 I '$D(^RA(78.7,"B","SSN OF PATIENT BARCODE-NO DASH")) D
 . D MSG("SSN OF PATIENT BARCODE",78.7)
 . S RAFDA(78.7,"+1,",.01)="SSN OF PATIENT BARCODE-NO DASH"
 . S RAFDA(78.7,"+1,",2)="P"
 . S RADFA(78.7,"+1,",3)="SSN:"
 . S RAFDA(78.7,"+1,",4)="Barcoded SSN"
 . S RAFDA(78.7,"+1,",5)="RABSSN"
 . D UPDATE^DIE("E","RAFDA")
 . S RA100=$O(^RA(78.7,"B","SSN OF PATIENT BARCODE-NO DASH",0))
 . I RA100="" D MSG("SSN OF PATIENT BARCODE",78.7,1) Q
 . S ^RA(78.7,RA100,"E")="S RABSSN=$TR($$SSN^RAUTL,""-"",""""),RABSSN=$$BCDE^RAUTL18($S(RABSSN=""Unknown"":"""",1:RABSSN))"
 ;
 D BMES^XPDUTL(" ") ; greater readability
 Q
MSG(ENTRY,FILE,ERR) ; display a status message pertaining to the addition
 ; of entries to files: 78.7, 
 ;
 ; Variable list:
 ; ENTRY-> value of the .01 field for a particular file (60 chars max)
 ; FILE -> file # where the data will be added
 ; ERR -> only passed if error message required
 ;
 N RACNT,RATXT,STRING,WORDS S RACNT=1,RATXT(RACNT)=" "
 S STRING="Adding '"_$E(ENTRY,1,40)_"' to the "
 S:$G(ERR) STRING="** ERROR "_STRING
 S STRING=$G(STRING)_$E($P($G(^DIC(FILE,0)),"^"),1,40)_" file."
 S:$G(ERR)&($D(DIERR)) STRING=$G(STRING)_" "_$E($G(^TMP("DIERR",$J,1,"TEXT",1)),1,115) ; display the 1st error text encountered! (there may be more errors. Because of possible string length error display only the first error.)
 S:$G(ERR) STRING=$G(STRING)_" IRM should investigate."
 F  D  Q:STRING=""
 . S WORDS=$L($E(STRING,1,71)," ")
 . S RACNT=RACNT+1,RATXT(RACNT)=$P(STRING," ",1,WORDS)
 . S STRING=$P(STRING," ",WORDS+1,999)
 . Q
 D MES^XPDUTL(.RATXT)
 Q

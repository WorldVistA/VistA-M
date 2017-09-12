PRC5192P ;BP/TJH - IFCAP Post-Init for PRC*5.1*92 ; 28 Oct 2005  3:16 PM
 ;;5.1;IFCAP;**92**;Oct 20, 2000
 QUIT
 ;
START ; remove invalid entries from the "C" xref of file #442
 D BMES^XPDUTL("Removing invalid entries from the C xref of file #442...")
 N PRCDA,PRCDB,PRCREC,PRCPO
 S PRCDA=0,U="^"
 F  S PRCDA=$O(^PRC(442,"C",PRCDA)) Q:PRCDA=""  D
 . S PRCDB=0
 . F  S PRCDB=$O(^PRC(442,"C",PRCDA,PRCDB)) Q:PRCDB=""  D
 .. S PRCREC=$G(^PRC(442,PRCDB,0)) ; get associated record, zero node
 .. S PRCPO=$P($P(PRCREC,U,1),"-",2) ; extract purchase order w/o STATION NUMBER
 .. I PRCPO'=PRCDA K ^PRC(442,"C",PRCDA,PRCDB) ; if PO# doesn't match subscript, remove the xref entry.
 D BMES^XPDUTL("Cleanup of C xref complete.")
 Q

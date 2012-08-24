PSN4P77 ;ISP/RLC;POST INSTALL TO REINDEX APD XREF FILE 56;10/08/03
 ;;4.0; NATIONAL DRUG FILE;**77,83**; 30 OCT 98
 ;
 ; This routine will automatically re-index the APD cross reference
 ; (on field 1 - Drug Ingredient1) in File 56 (Drug Interaction file).
 ;
EN ;
 S DIK="^PS(56,"
 S DIK(1)="1^APD"
 D ENALL^DIK
 K DIK
 Q

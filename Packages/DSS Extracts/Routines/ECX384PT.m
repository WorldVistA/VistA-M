ECX384PT ;ALB/GTS - Extract Log Report for DSS ; 10/26/05 1:45pm
 ;;3.0;DSS EXTRACTS;**84**;Dec 22, 1997
 ;
EN ;entry point from option
 D BMES^XPDUTL("Creating new index for file 727 for START DATE/TIME field (#3) ")
 S DIK="^ECX(727,",DIK(1)="3^AE"
 D ENALL^DIK
 D BMES^XPDUTL("Indexing completed succesfully ")
 Q

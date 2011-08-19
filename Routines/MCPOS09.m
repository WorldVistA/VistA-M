MCPOS09 ;HIRMFO/DAD-MOVE MICRO DESC REMARKS INTO WP FIELD ;5/31/96  12:48
 ;;2.3;Medicine;;09/13/1996
 ;
 N MCD0,MCDATA
 S MCDATA(1)=""
 S MCDATA(2)="Moving Micro Description Remarks from a free text field"
 S MCDATA(3)="to word processing field in the Hematology file (#694)."
 D MES^XPDUTL(.MCDATA)
 ;
 S MCD0=0
 F  S MCD0=$O(^MCAR(694,MCD0)) Q:MCD0'>0  D
 . S MCDATA=$P($G(^MCAR(694,MCD0,7)),U)
 . K ^MCAR(694,MCD0,7)
 . I MCDATA="" Q
 . S ^MCAR(694,MCD0,7,0)="^^1^1^"_$$DT^XLFDT_"^"
 . S ^MCAR(694,MCD0,7,1,0)=MCDATA
 . Q
 Q

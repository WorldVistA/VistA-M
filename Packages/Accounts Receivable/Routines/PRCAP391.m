PRCAP391 ;EDE/YMG - PRCA*4.5*391 POST INSTALL; 10/01/21
 ;;4.5;Accounts Receivable;**391**;Mar 20, 1995;Build 10
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
EN ; entry point
 D BMES^XPDUTL(" >>  Start of the Post-Installation routine for PRCA*4.5*391")
 ; Update suspension types in file 433
 D UPDSTYPE
 ;
 D BMES^XPDUTL(" >>  End of the Post-Installation routine for PRCA*4.5*391")
 Q
 ;
UPDSTYPE ; Update suspension types (field 433/90.1) in file 433
 N FDA,IENS,N1,STPTR,STYPE,TRIEN
 D BMES^XPDUTL(" >>  Updating suspension types in file 433...")
 S TRIEN=0 F  S TRIEN=$O(^PRCA(433,TRIEN)) Q:'TRIEN  D
 .S N1=$G(^PRCA(433,TRIEN,1)) I N1="" Q
 .S STYPE=$P(N1,U,11) I STYPE="" Q
 .S STPTR=+$O(^PRCA(433.001,"B",STYPE,"")) I STPTR'>0 Q
 .S IENS=TRIEN_",",FDA(433,IENS,90.1)=STPTR D FILE^DIE("","FDA")
 .Q
 D MES^XPDUTL("Done.")
 Q

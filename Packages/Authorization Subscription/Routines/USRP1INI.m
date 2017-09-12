USRP1INI ; SLC/PKR - Inits for patch USR*1.0*1 ;12/12/1997
 ;;1.0;AUTHORIZATION/SUBSCRIPTION;**1**;Jun 20, 1997
 ;======================================================================
REMBP ;Remove broken subclass pointers.
 N FDA,I1,I2,IND,MSG,SUBCLASS,TOTAL
 S TOTAL=0
 S I1=0
 F  S I1=$O(^USR(8930,I1)) Q:+I1'>0  D
 . S I2=0
 . F  S I2=$O(^USR(8930,I1,1,I2)) Q:+I2'>0  D
 .. S SUBCLASS=$P(^USR(8930,I1,1,I2,0),U,1)
 .. I '$D(^USR(8930,SUBCLASS,0)) D
 ... S TOTAL=TOTAL+1
 ... S FDA(8930.01,I2_","_I1_",",.01)="@"
 D FILE^DIE("K","FDA","MSG")
 D BMES^XPDUTL(TOTAL_" broken SUBCLASS pointers were deleted.")
 Q

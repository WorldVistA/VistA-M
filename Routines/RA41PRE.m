RA41PRE ;HOIFO/SWM-Pre install ;3/1/04  11:28
 ;;5.0;Radiology/Nuclear Medicine;**41**;Mar 16, 1998
 ; This is the pre-install routine for patch RA*5.0*41
 ; 
 ; This routine may be deleted after RA*5.0*41 is installed.
 ;
 ; Three field descriptions (not data) will be deleted:
 ;     Subfile 70.03   field 26  CREDIT METHOD
 ;     File    79.1    field 21  CREDIT METHOD
 ;     File    75.1    field 14  REQUESTING PHYSICIAN
 ; Their descriptions will be put back in by the 
 ;     installation with new information.
 ;
 I '$D(XPDNM)#2 D EN^DDIOL("This entry point must be called from the KIDS installation -- Nothing Done.",,"!!,$C(7)") Q
 K %,%Z,DA,DIC,DIK,X,Y
 N RATXT
 S DIK="^DD(70.03,",DA(1)=70.03,DA=26 D ^DIK
 S RATXT(1)=" Temporarily removed description for subfile 70.03, field 26  CREDIT METHOD."
 S RATXT(2)=" "
 D MES^XPDUTL(.RATXT)
 K %,%Z,DA,DIC,DIK,X,Y
 S DIK="^DD(79.1,",DA(1)=79.1,DA=21 D ^DIK
 S RATXT(1)=" Temporarily removed description for file 79.1, field 21  CREDIT METHOD."
 D MES^XPDUTL(.RATXT)
 K %,%Z,DA,DIC,DIK,X,Y
 S DIK="^DD(75.1,",DA(1)=75.1,DA=14 D ^DIK
 S RATXT(1)=" Temporarily removed description for file 75.1, field 14  REQUESTING PHYSICIAN."
 D MES^XPDUTL(.RATXT)
 K %,%Z,DA,DIC,DIK,X,Y
 Q

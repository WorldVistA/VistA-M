DG5389PI ;ALB/CM PRETINIT ;06/27/96
 ;;5.3;Registration;**89**;Aug 13, 1993
 ;
 ;This routine will remove the WARD (#70) field from the PAF file 
 ;#45.9.  This field will be added again in the installation.
 ;
EN ;
 N MES
 D MES^XPDUTL("Starting Pre-Installation")
 S DIK="^DD(45.9,",DA=70,DA(1)=45.9
 D ^DIK
 D MES^XPDUTL("Completed Pre-Installation")
 K DIK,DA
 Q

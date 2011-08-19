PRCOSRV9 ;WISC/DJM-Special Transaction Interface ;8/22/94  1:37 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
START ;This routine will delete the following transactions coming from ISMS
 ;from file 423.6.
 ;
 ; IFC-834  IFC-839  IFC-840  IFC-841  IFC-836  IFC-843
 ; IFC-844  IFC-845
 ;
 N DA,DIK
 S DIK="^PRCF(423.6,",DA=PRCDA D ^DIK
 Q

DG53312T ;ALB/GRR - RAI/MDS REMOVE DUPLICATES FROM ROOM-BED TRANSLATION FILE
 ;;5.3;Registration;**312**;Aug 13, 1993
EN ;
 N DGRBP,DGTIEN
 W !,"Starting Post Init to remove duplicate entries in Room-Bed"
 W !,"Translation file (#46.13)"
 S DGRBP=0 F  S DGRBP=$O(^DGRU(46.13,"B",DGRBP)) Q:DGRBP=""  D
 .S DGTIEN=0 F  S DGTIEN=$O(^DGRU(46.13,"B",DGRBP,DGTIEN)) Q:DGTIEN'>0  I $O(^DGRU(46.13,"B",DGRBP,DGTIEN))>0 D
 ..S DIK="^DGRU(46.13,",DA=DGTIEN D ^DIK
 W !,"End Post Init Routine"
 Q

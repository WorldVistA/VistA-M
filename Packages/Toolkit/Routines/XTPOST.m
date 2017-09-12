XTPOST ;OAK-RAK - Post Install Routine ;6/8/06  10:19
 ;;8.0;KERNEL;**102**;Jul 10, 1995
 ;
EN ;- entry point
 ;
 N DIU,I,X,Y
 D CHECK
 D MES^XPDUTL(" Removing File #8986.095 (CM SITE PARAMETERS) data dictionary and data...")
 S DIU="8986.095",DIU(0)="DT"
 D EN^DIU2
 K DUI,X,Y
 D MES^XPDUTL(" Removing File #8986.098 (VPM RESPONSE TIME DATA) data dictionary and data...")
 S DIU="8986.098",DIU(0)="DT"
 D EN^DIU2
 K DUI,X,Y
 D MES^XPDUTL(" Removing File #8986.3 (CM SITE NODENAMES) data dictionary and data...")
 S DIU="8986.3",DIU(0)="DT"
 D EN^DIU2
 K DUI,X,Y
 D MES^XPDUTL(" Removing File #8986.35 (CM SITE DISKDRIVES) data dictionary and data...")
 S DIU="8986.35",DIU(0)="DT"
 D EN^DIU2
 K DUI,X,Y
 D MES^XPDUTL(" Removing File #8986.4 (CM METRICS) data dictionary and data...")
 S DIU="8986.4",DIU(0)="DT"
 D EN^DIU2
 K DUI,X,Y
 D MES^XPDUTL(" Removing File #8986.5 (CM DISK DRIVE RAW DATA) data dictionary and data...")
 S DIU="8986.5",DIU(0)="DT"
 D EN^DIU2
 K DUI,X,Y
 D MES^XPDUTL(" Removing File #8986.51 (CM NODENAME RAW DATA) data dictionary and data...")
 S DIU="8986.51",DIU(0)="DT"
 D EN^DIU2
 K DUI,X,Y
 D MES^XPDUTL(" Removing File #8986.6 (CM DAILY STATISTICS) data dictionary and data...")
 S DIU="8986.6",DIU(0)="DT"
 D EN^DIU2
 K DUI,X,Y
 D MES^XPDUTL(" Removing File #3.091 (RESPONSE TIME) data dictionary and data...")
 S DIU="3.091",DIU(0)="DT"
 D EN^DIU2
 K DUI,X,Y
 D MES^XPDUTL(" Removing File #3.092 (RT DATE_UCI,VOL) data dictionary and data...")
 S DIU="3.092",DIU(0)="DT"
 D EN^DIU2
 K DUI,X,Y
 D MES^XPDUTL(" Removing File #3.094 (RT RAWDATA) data dictionary and data...")
 S DIU="3.094",DIU(0)="DT"
 D EN^DIU2
 K DUI,X,Y
 S I=""
 F  S I=$O(^%ZRTL(I)) Q:I=""  D 
 .D MES^XPDUTL(" Removing data from non-FileMan compatible global ^%ZRTL("_I_")...")
 .K ^%ZRTL(I)
 ;
 D MES^XPDUTL(" Finished!")
 ;
 Q
 ;
CHECK ;- check for zero nodes if files exist
 I $D(^DIC(8986.095,0)) D 
 .S $P(^XUCM(8986.095,0),U)="CM SITE PARAMETERS"
 .S $P(^XUCM(8986.095,0),U,2)="8986.095P"
 ;
 I $D(^DIC(8986.098,0)) D 
 .S $P(^XUCM(8986.098,0),U)="VPM RESPONSE TIME DATA"
 .S $P(^XUCM(8986.098,0),U,2)="8986.098P"
 ;
 I $D(^DIC(8986.3,0)) D 
 .S $P(^XUCM(8986.3,0),U)="CM SITE NODENAMES"
 .S $P(^XUCM(8986.3,0),U,2)="8986.3"
 ;
 I $D(^DIC(8986.35,0)) D 
 .S $P(^XUCM(8986.35,0),U)="CM SITE DISKDRIVES"
 .S $P(^XUCM(8986.35,0),U,2)="8986.35"
 ;
 I $D(^DIC(8986.4,0)) D 
 .S $P(^XUCM(8986.4,0),U)="CM METRICS"
 .S $P(^XUCM(8986.4,0),U,2)="8986.4I"
 ;
 I $D(^DIC(8986.5,0)) D 
 .S $P(^XUCM(8986.5,0),U)="CM DISK DRIVE RAW DATA"
 .S $P(^XUCM(8986.5,0),U,2)="8986.5P"
 ;
 I $D(^DIC(8986.51,0)) D 
 .S $P(^XUCM(8986.51,0),U)="CM NODENAME RAW DATA"
 .S $P(^XUCM(8986.51,0),U,2)="8986.51P"
 ;
 I $D(^DIC(8986.6,0)) D 
 .S $P(^XUCM(8986.6,0),U)="CM DAILY STATISTICS"
 .S $P(^XUCM(8986.6,0),U,2)="8986.6P"
 ;
 I $D(^DIC(3.091,0)) D 
 .S $P(^%ZRTL(1,0),U)="RESPONSE TIME"
 .S $P(^%ZRTL(1,0),U,2)="3.091P"
 ;
 I $D(^DIC(3.092,0)) D 
 .S $P(^%ZRTL(2,0),U)="RT DATE_UCI,VOL"
 .S $P(^%ZRTL(2,0),U,2)="3.092"
 ;
 I $D(^DIC(3.094,0)) D 
 .S $P(^%ZRTL(4,0),U)="RT RAWDATA"
 .S $P(^%ZRTL(4,0),U,2)="3.094D"
 ;
 Q

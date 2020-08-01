PXRMP46I ;SLC/PKR - Inits for PXRM*2.0*46. ;06/11/2020
 ;;2.0;CLINICAL REMINDERS;**46**;Feb 04, 2005;Build 236
 ;
 ;==========================================
PRE ;Pre-init
 D RMEXCHENTRY^PXRMP46I
 Q
 ;
 ;==========================================
POST ;Post-init
 D SETPVER^PXRMUTIL("2.0P46")
 Q
 ;
 ;==========================================
RMEXCHENTRY ;Remove any old versions of the COVID-19 status Reminder
 ;Exchange entry.
 N IEN,IENS,FDA,MSG,NAME,PACKDT
 S NAME="VA-COVID-19 CPRS STATUS VERSION 4"
 S PACKDT=0
 F  S PACKDT=+$O(^PXD(811.8,"B",NAME,PACKDT)) Q:PACKDT=0  D
 . S IEN=0
 . F  S IEN=+$O(^PXD(811.8,"B",NAME,PACKDT,IEN)) Q:IEN=0  D
 .. S IENS=IEN_","
 .. K FDA,MSG
 .. S FDA(811.8,IENS,.01)="@"
 .. D FILE^DIE("","FDA","MSG")
 Q
 ;

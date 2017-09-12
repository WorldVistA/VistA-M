XU8P509 ; BP/BDT - POST ROUTINE; 9/8/08
 ;;8.0;KERNEL;**509**;Jul 10, 1995;Build 1
 ;;"Per VHA Directive 2004-038, this routine should not be modified".
 Q
POST ; Post routine for XU*8*509
 D DEL ;delete entries 1137-1152 if they exist
 D ADD ;add entries 1137-1152
 D DEF^XU8P509A,DEF^XU8P509B ;modify definition texts
 D DEF^XU8P509C,DEF^XU8P509D ;add definition texts
 D DELXU8P ; delete routines XU8P509A,B,C,D
 Q
DELXU8P ;
 ;Delete the routine XU8P509A,B,C,D:
 N X F X="XU8P509A","XU8P509B","XU8P509C","XU8P509D" X ^%ZOSF("DEL")
 Q
 ;
ADD ; Add new entries from 1137-1152
 N XUI,XUDATA
 F XUI=1:1:16 S XUDATA=$T(DATA+XUI) Q:XUDATA=" ;;END"  D
 . S XUDATA=$P(XUDATA,";;",2) Q:XUDATA="END"
 . D ADD1(XUDATA)
 Q
 ;
ADD1(XUDATA) ; add single entry
 N FDA,FDAIEN,XUD
 S XUD=$G(XUDATA)
 S FDAIEN(1)=$P(XUD,"^")
 S FDA(8932.1,"+1,",.01)=$P(XUD,"^",2)
 S FDA(8932.1,"+1,",1)=$P(XUD,"^",3)
 S FDA(8932.1,"+1,",2)=$P(XUD,"^",4)
 S FDA(8932.1,"+1,",3)="a"
 S FDA(8932.1,"+1,",5)=$P(XUD,"^",5)
 S FDA(8932.1,"+1,",6)=$P(XUD,"^",6)
 S FDA(8932.1,"+1,",8)=$P(XUD,"^",7)
 S FDA(8932.1,"+1,",90002)=$P(XUD,"^",8)
 D UPDATE^DIE("","FDA","FDAIEN","ERR")
 Q
 ;
DEL ; Delete entry
 N XUI F XUI=1137:1:1152 D
 . N DIK,DA S DIK="^USC(8932.1,",DA=XUI D ^DIK
 Q
 ;
GET ;Get information of entries from the Person Class file
 N XUI
 F XUI=1137:1:1152 D GET1(XUI)
 Q
 ;
GET1(XUIEN) ; Get information of given entry from Person Class file.
 N XUI
 S XUI=$G(^USC(8932.1,XUIEN,0))
 S XUI=" ;;"_XUIEN_"^"_$P(XUI,"^",1,3)_"^"_$P(XUI,"^",6,9) W !,XUI
 Q
 ;
DATA ; information of entries from 1137-1152
 ;;1137^Allopathic & Osteopathic Physicians^Family Medicine^Sleep Medicine^V180707^207QS1201X^08
 ;;1138^Behavioral Health & Social Service Providers^Behavioral Analyst^^V010700^103K00000X
 ;;1139^Respiratory, Rehabilitative and Restorative Service Providers^Occupational Therapist^Gerontology^V130110^225XG0600X^67
 ;;1140^Respiratory, Rehabilitative and Restorative Service Providers^Occupational Therapist^Mental Health^V130111^225XM0800X^67
 ;;1141^Respiratory, Rehabilitative and Restorative Service Providers^Occupational Therapist^Physical Rehabilitation^V130112^225XP0019X^67
 ;;1142^Respiratory, Rehabilitative and Restorative Service Providers^Occupational Therapist^Environmental Modification^V130113^225XE0001X^67
 ;;1143^Respiratory, Rehabilitative and Restorative Service Providers^Occupational Therapist^Feeding, Eating & Swallowing^V130114^225XF0002X^67
 ;;1144^Respiratory, Rehabilitative and Restorative Service Providers^Occupational Therapist^Low Vision^V130115^225XL0004X^67
 ;;1145^Respiratory, Rehabilitative and Restorative Service Providers^Occupational Therapy Assistant^Feeding, Eating & Swallowing^V130116^224ZF0002X^67
 ;;1146^Respiratory, Rehabilitative and Restorative Service Providers^Occupational Therapy Assistant^Low Vision^V130117^224ZL0004X^67
 ;;1147^Respiratory, Rehabilitative and Restorative Service Providers^Occupational Therapy Assistant^Driving & Community Mobility^V130118^224ZR0403X^67
 ;;1148^Respiratory, Rehabilitative and Restorative Service Providers^Occupational Therapy Assistant^Environmental Modification^V130119^224ZE0001X^67
 ;;1149^Technologists, Technicians & Other Technical Service Providers^Radiology Practitioner Assistant^^V153000^243U00000X^
 ;;1150^Agencies^In Home Supportive Care^^^253Z00000X^^N
 ;;1151^Behavioral Health & Social Service Providers^Psychologist^Health Psychologist^V010422^103TH0004X^68
 ;;1152^Allopathic & Osteopathic Physicians^Physical Medicine & Rehabilitation^Hospice and Palliative Medicine^V182605^2081H0002X^25
 ;;END

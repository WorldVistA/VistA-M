PSGWEE ;BHAM ISC/KKA - Enter/Edit all types of data ;Oct 17, 2017@14:48
 ;;2.3;Automatic Replenishment/Ward Stock;**19**;4 JAN 94;Build 45
INVENT ;*** Enter/Edit Inventory Types
 S PSGWFILE=58.16,PSGWSTR=".01;1"
 D ENTEDT Q
ITEMLOC ;*** Enter/Edit Item Location Codes
 S PSGWFILE=58.17,PSGWSTR=".01;.5"
 D ENTEDT Q
AOU ;*** Enter/Edit the Area of Use
 S PSGWFILE=58.1,PSGWSTR="[PSGW AREA OF USE EDIT]"
 D ENTEDT Q
GROUP ;*** Enter/Edit Inventory Group
 S PSGWFILE=58.2,PSGWSTR="[PSGW WARD INVENTORY]"
 D ENTEDT Q
SITE ;*** Enter/Edit Inpatient Site Data
 S PSGWFILE=59.4,PSGWSTR="4;5;4.5T//NO;5.5;32" ; Patch PSGW*2.3*19 added field 32 
 D ENTEDT Q
ENTEDT ;*** Enter/Edit Data
 F  S (DIC,DLAYGO)=PSGWFILE,DIC(0)="QEAMZL" W ! D ^DIC K DIC,DLAYGO G:+Y<0 END S DA=+Y,DIE=PSGWFILE,DR=PSGWSTR D ^DIE K DIE,DA,DR
END K PSGWFILE,PSGWSTR,Y Q

RANMPRT1 ;HISC/SWM-Nuclear Medicine Set-up file Lists ;5/22/97  09:51
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
ROUTE ; Route of Administration List - file 71.6 
 S DIC="^RAMIS(71.6,",L=0,DHD="ROUTE OF ADMINISTRATION"
 S FLDS=".01;L30,100,""(synonym)"",.01;"""";L30,,2,.01;30;""SITES OF ADMIN"",,3;L5;""PROMPT"""
 S FR="",TO="",BY=".01" D EN1^DIP K POP
 Q
SITE ; Site of Administration List - file 71.7
 S DIC="^RAMIS(71.7,",L=0,DHD="SITE OF ADMINISTRATION"
 S FLDS=".01;L30,100,.01;L30;""(SYNONYM)"""
 S FR="",TO="",BY=".01" D EN1^DIP K POP
 Q
SOURCE ; Vendor/Source List - file 71.8
 S DIC="^RAMIS(71.8,",L=0,DHD="RADIOPHARMACEUTICAL SOURCE"
 S FLDS=".01;L30"
 S FR="",TO="",BY=".01" D EN1^DIP K POP
 Q
LOT ; Lot No. List - file 71.9
 S DIC="^RAMIS(71.9,",L=0,DHD="RADIOPHARMACEUTICAL LOT"
 S FLDS=".01;L30,5;L40;""RADIOPHARMACEUTICAL"",4;L15,3;L19,6;L3"
 S FR(1)="@",FR(2)="@",TO="",BY="2;S,5"
 D 132,EN1^DIP K POP
 Q
132 ; Issue message to send to a device with a 132 column output.
 W !,"This report requires a 132 column output device."
 Q

ONCPDI ;HINES OIFO/GWB - Patient information ;10/07/11
 ;;2.2;ONCOLOGY;**1,13,19,20,21**;Jul 31, 2013;Build 6
 ;
PRT ;
 N DI,DIC,DR,DA,DIQ
 K ONC
 N PT,SIG,SOV
 I $$DPTLRT^ONCOES(D0)="LRT" S (SIG,SOV)=""
 I $$DPTLRT^ONCOES(D0)="DPT" D
 .S PT=$P($G(^ONCO(160,D0,0)),";",1)
 .S SOV=$$SO^ONCOES(PT) ;SEXUAL ORIENTATION
 .S SIG=$$GET1^DIQ(2,PT,.024,"E") ;SELF IDENTIFIED GENDER
 S DIC="^ONCO(160,",DR="7;8;8.1;8.2;8.3;8.4;9;10;25;25.1;25.2;25.3;25.4;25.5;25.6;25.7;25.8;25.9;48;50;51;52;61;55;56;62;63;64;65;66;67;71;72;73;1006;25.91:25.9901"
 S DA=D0,DIQ="ONC"
 D EN^DIQ1
 F I=7,71,8,8.1,8.2,8.3,8.4,9,10,48,50,51,52,61,55,56,62,63,64,65,66,67,72,73 S X=ONC(160,D0,I) D UCASE^ONCPCI S ONC(160,D0,I)=X
 W !
 W !,"    Place of birth.............: ",ONC(160,D0,7)
 W !,"    Birth Surname..............: ",ONC(160,D0,71)
 W !,"    Race 1.....................: ",ONC(160,D0,8)
 W !,"    Race 2.....................: ",ONC(160,D0,8.1)
 W !,"    Race 3.....................: ",ONC(160,D0,8.2)
 W !,"    Race 4.....................: ",ONC(160,D0,8.3)
 W !,"    Race 5.....................: ",ONC(160,D0,8.4)
 W !,"    Spanish origin.............: ",ONC(160,D0,9)
 W !,"    Sex........................: ",ONC(160,D0,10)
 ;W !,"    Sexual Orientation.........: ",SOV
 ;W !,"    Self Identified Gender.....: ",SIG
 W !,"    Exposure Agent Orange......: ",ONC(160,D0,48)
 W !,"    Exposure Ionizing Radiation: ",ONC(160,D0,50)
 W !,"    Exposure Chemical..........: ",ONC(160,D0,52)
 W !,"    Exposure Asbestos..........: ",ONC(160,D0,61)
 W !,"    Exposure Burn Pit..........: ",ONC(160,D0,72)
 W !,"    Exposure Other Toxic.......: ",ONC(160,D0,73)
 W !,"    Vietnam service............: ",ONC(160,D0,62)
 W !,"    Lebanon service............: ",ONC(160,D0,55)
 W !,"    Grenada service............: ",ONC(160,D0,63)
 W !,"    Panama service.............: ",ONC(160,D0,64)
 W !,"    Persian Gulf service.......: ",ONC(160,D0,51)
 W !,"    Somalia service............: ",ONC(160,D0,56)
 W !,"    Yugoslavia service.........: ",ONC(160,D0,65)
 W !,"    Afghanistan (OEF) service..: ",ONC(160,D0,67)
 W !,"    Iraq (OIF) service.........: ",ONC(160,D0,66)
 Q
 ;
PH ;Patient History
 K ONC S IEN=D0_","
 D GETS^DIQ(160,IEN,"38;39;42*;43;44*","","ONC")
 F I=38,39,43 S X=ONC(160,D0_",",I) D UCASE^ONCPCI S ONC(160,D0_",",I)=X
 W @IOF
 S SUB=0 F  S SUB=$O(ONC(160.042,SUB)) Q:SUB'>0  D
 .W !,"    Usual Occupation...........: ",ONC(160.042,SUB,.01)
 .W !,"    Usual Industry.............: ",ONC(160.042,SUB,3)
 .W !
 W !,"    Tobacco History............: ",ONC(160,IEN,38)
 W !,"    Alcohol History............: ",ONC(160,IEN,39)
 W !
 W !,"    Family History of Cancer...: ",ONC(160,IEN,43)
 S SUB=0 F  S SUB=$O(ONC(160.044,SUB)) Q:SUB'>0  D
 .W !,"    Family Member with Cancer..: ",ONC(160.044,SUB,.01),?50,"(",ONC(160.044,SUB,1),")"
 W !
 K I,IEN,ONC,SUB,X
 Q
 ;
CLEANUP ;Cleanup
 K D0

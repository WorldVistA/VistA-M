FHQUE ;EPIP/KLD - AUTO-QUEUE DIETETICS REPORTS & LABELS ;04/27/2017  3:31 PM
 ;;5.5;DIETETICS;**43**;Jan 28, 2005;Build 66
 ; Run shortly after midnight
 ; Original version June 2004
 ;ICR#   Type  Description
 ;-----  ----  --------------------------------------
 ;2056   Sup   GETI^DIQ
 ;10000  Sup   DW^%DTC
 ;10003  Sup   ^%DT
 ;10006  Sup   ^DIC
 ;10009  Sup   ^DICN: FILE, YN
 ;10013  Sup   ^DIK
 ;10018  Sup   ^DIE
 ;10063  Sup   ^%ZTLOAD
 ;10075  Sup   File 19, field .01, read w/Fileman
 ;10114  Sup   File 3.5, field .01, read w/Fileman
 ;
ST F FHI=0:0 S FHI=$O(^FH(117.024,FHI)) Q:'FHI  D:$$GET1^DIQ(117.024,FHI,5)="YES" ML
FHK K %,DA,DIC,DIE,DIK,DR,FH,FHI,FHII,FHIII,FHIEN,FHANS,X,Y,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK,^TMP("FHQUE",$J) Q
 ;
ML ;Main loop
 S FH("FLAG")=0
 I $O(^FH(117.024,FHI,2,0)) D  Q:'FH("FLAG")  ;Only run certain days of the week
 .S X=DT D DW^%DTC S Y=Y+1,FH("FLAG")=$D(^FH(117.024,FHI,2,"B",Y))
 S FH("TIME")=$$GET1^DIQ(117.024,FHI,1)
 S:FH("TIME")<600 FH("TIME")=0_FH("TIME")
 S %DT="R",X="T@"_FH("TIME") D ^%DT S ZTDTH=$S($D(FH("TEST")):$H,1:Y)
 S ZTDESC=$$GET1^DIQ(117.024,FHI,.01)_" Auto Queue"
 S ZTIO=$$GET1^DIQ(117.024,FHI,2)
 S ZTRTN=$$GET1^DIQ(117.024,FHI,3)_U_$$GET1^DIQ(117.024,FHI,4)
 F FHII=0:0 S FHII=$O(^FH(117.024,FHI,1,FHII)) Q:'FHII  D  ;Get necessary variables
 .S FH("VAR")=$$GET1^DIQ(117.0242,FHII_","_FHI,.01)
 .S @FH("VAR")=$TR($$GET1^DIQ(117.0242,FHII_","_FHI,1),"|",U)
 .D:$$GET1^DIQ(117.0242,FHII_","_FHI,2)="YES"  ;Date variable
 ..S X=$TR($$GET1^DIQ(117.0242,FHII_","_FHI,1),"|",U),%DT=$S(X["@":"R",1:"")
 ..D ^%DT S @FH("VAR")=Y
 .S X=$TR($$GET1^DIQ(117.0242,FHII_","_FHI,3),"|",U) X:X]"" X ;Xecutable code to set the variable
 .S ZTSAVE(FH("VAR"))=@FH("VAR")
 D ^%ZTLOAD W !!,"ZTSK=",$G(ZTSK) Q
 ;
TEST ;Test one particular option
 R !!,"IEN: ",FHI:DTIME Q:U[FHI!'$T  S FH("TEST")=""
 I FHI["?" S FHIEN=0 F  S FHIEN=$O(^FH(117.024,FHIEN)) G:'+FHIEN TEST W !,FHIEN,?10,$P(^FH(117.024,FHIEN,0),"^")
 I '$D(^FH(117.024,FHI)) W !,"Invalid IEN!" G TEST
 W ! S DIC="^%ZIS(1,",DIC(0)="QEAM",DIC("A")="Select printer: " D ^DIC
 G TEST:Y<1 S ZTIO=$P(Y,U,2) D ML,FHK Q
 ;
UEDIT ;User edit of options
 K ^TMP("FHQUE",$J) S FH("CNT")=0,FHI=""
 F  S FHI=$O(^FH(117.0243,"B",FHI)) Q:FHI=""  D
 .F FHII=0:0 S FHII=$O(^FH(117.0243,"B",FHI,FHII)) Q:'FHII  D
 ..S X=$$GET1^DIQ(117.0243,FHII,.01) Q:X=""
 ..S X(1)=$$GET1^DIQ(117.0243,FHII,1) S:X(1)="" X(1)="NULL"
 ..S DIC(0)="BZ",DIC="^DIC(19," D ^DIC
 ..S ^TMP("FHQUE",$J,X,X(1))=$P($G(Y(0)),U,2)_U_FHII
 S (FHI,FHII)="" W !!,"Available options are:"
 F  S FHI=$O(^TMP("FHQUE",$J,FHI)) Q:FHI=""  D
 .F  S FHII=$O(^TMP("FHQUE",$J,FHI,FHII)) Q:FHII=""  D
 ..S FH("CNT")=FH("CNT")+1,FH("SEL",FH("CNT"))=FHI_U_$P(^TMP("FHQUE",$J,FHI,FHII),U,2)
 ..W !?3,$J(FH("CNT"),2),". ",FHI W:FHII'="NULL" ?18,FHII
 ..W ?32,$P(^TMP("FHQUE",$J,FHI,FHII),U)
UEDIT1 R !,"Your choice, choose by number: ",FH("OPT"):DTIME I U[FH("OPT")!'$T D FHK Q
 I FH("OPT")["?" D FHSHOW R !!,?5,"Return to continue: ",FHANS:DTIME Q:'$T  G UEDIT
 I FH("OPT")'?1.2N!('$D(FH("SEL",FH("OPT")))) W "  ??" G UEDIT1
UEDIT2 R !!,"Time to run the option (use 4 digit military time): ",FH("TIME"):DTIME I U[FH("TIME")!'$T D FHK Q
 I FH("TIME")'?4N!(FH("TIME")>2359)!($E(FH("TIME"),3)>5) W "  ??" G UEDIT2
 S FH("NAME")=$P(FH("SEL",FH("OPT")),U)_" "_FH("TIME")
 S FH("DA")=$P(FH("SEL",FH("OPT")),U,2)
 S (DIC,DIE)="^FH(117.024,",DIC(0)="M",X=FH("NAME") D ^DIC S DA=+Y
 I Y=-1 D  G UEDIT:%'=1
 .W !!,"Add entry ",$C(34),FH("NAME"),$C(34) S %=1 D YN^DICN Q:%'=1
 .S DIC(0)="L" K DD,DO D FILE^DICN
 .S DA=+Y,DR="1///"_$P(FH("NAME")," ",2),FH("ADDED")=""
 .D ^DIE W !,"Entry added."
 W !!,"Now add/change the printer and whether it's active.",!
 S DR="3///"_$$GET1^DIQ(117.0243,FH("DA"),3)_";4///"_$$GET1^DIQ(117.0243,FH("DA"),4)_";2R;5R//YES;20"
 D ^DIE S ^FH(117.024,DA,1,0)="^117.0242^",X=DA
 K DA,DIC,DIE,DR S DIC="^FH(117.024,"_X_",1,",DIC(0)="L",DA(1)=X,FH("BAD")=0
 F FHI=0:0 S FHI=$O(^FH(117.0243,FH("DA"),1,FHI)) Q:'FHI!(FH("BAD"))  D
 .S X=$$GET1^DIQ(117.024302,FHI_","_FH("DA"),.01),DIC("DR")=""
 .D:$$GET1^DIQ(117.024302,FHI_","_FH("DA"),1)="YES" ASK Q:FH("BAD")
 .K DIC("DR"),DD,DO D FILE^DICN S DA=+Y
 .S DR="",DIE=DIC D DR,^DIE K FH("QUES")
 .S:DR["3//" ^FH(117.024,DA(1),1,DA,1)=$TR(^FH(117.024,DA(1),1,DA,1),"|",U)
 I 'FH("BAD") W !!,"Option ",$S($D(FH("ADDED")):"add",1:"chang"),"ed!" H 3
 I FH("BAD") S DIK="^FH(117.024," D ^DIK W !!,"Invalid entry - deleted!"
 K FH("ADDED") G UEDIT
 ;
ASK N %DT,FHII,FHWP,X,Y S FHWP=$$GET1^DIQ(117.024302,FHI_","_FH("DA"),5,"","FHWP")
 F FHII=0:0 S FHII=$O(FHWP(FHII)) Q:'FHII  W !,FHWP(FHII)
 R X:DTIME I U[X!'$T S FH("BAD")=1 Q
 I FHWP(1)["meal","BNE"'[X W !,"B, N or E" G ASK
 I FHWP(1)["meal","BNE"[X S FH("QUES")=$E(X,1) Q
 I $$GET1^DIQ(117.024302,FHI_","_FH("DA"),3)="YES" S %DT="ET" D ^%DT I Y<1 W !,"Invalid date/time!" G ASK
 S FH("QUES")=X Q
 ;
DR N X,FHFD S DR=""
 F FHFD=1,2,3 D
 .I $G(FH("QUES"))]"",FHFD=1 S X=FH("QUES")
 .E  S X=$$GET1^DIQ(117.024302,FHI_","_FH("DA"),FHFD+1) Q:X=""
 .S DR=DR_FHFD_"///"_X_";"
 Q
FHSHOW ;Display the print options that have been setup
 N FHIEN
 W !!,?5,"Print options and times currently set up",!!
 S FHIEN="" F  S FHIEN=$O(^FH(117.024,FHIEN)) Q:FHIEN=""  D
 . W !,?5,$P($G(^FH(117.024,FHIEN,0)),U)
 . Q
 Q

SDWLPE ;IOFO BAY PINES/TEH - WAIT LIST - PARAMETER WAIT LIST ENTER/EDIT ;20 Aug 2002  ; Compiled April 22, 2008 14:13:00
 ;;5.3;scheduling;**263,280,288,397,491**;AUG 13 1993;Build 53
 ;
 ;SD/491 - identify clinic institution through DIVISION ---> INSTITUTION path
EN ;
 ;OPTION HEADER
 ;
 D HD
 ;
 ;SELECT FILE TO EDIT
 ;
EN1 D SEL G END:X["^",END:X=""
 ;
 ;EDIT PARAMETER FILE
 ;
 D EDIT G EN:'$D(Y)
 G END
 Q
 ;
SEL ;SELECT PARAMETER FILE
 S DIR(0)="SO^1:Wait List Service/Specialty File;2:Wait List Clinic Location"
 S DIR("L",1)="Select one of the following:"
 S DIR("L",2)=""
 S DIR("L",3)="    1. Wait List Service/Specialty (409.31)"
 S DIR("L")="    2. Wait List Clinic Location (409.32)"
 D ^DIR S SDWLF=X
 K DIR,DILN,DINDEX
 Q
EDIT ;EDIT FILE PARAMETERS
 I SDWLF=1 D SB1 Q:$D(DUOUT)
 I SDWLF=2 D SB2 Q:$D(DUOUT)
 Q
SB1 S DIC(0)="AEQMZ",DIC("A")="Select DSS ID: ",DIC="^DIC(40.7,",DIC("S")="I '$P(^DIC(40.7,+Y,0),U,3)"
 D ^DIC
 I X["^" I $D(DA),'$D(^SDWL(409.31,DA,"I")) S DIK="^SDWL(409.31," D ^DIK S DUOUT=1 Q
 Q:Y<0  Q:$D(DUOUT)  S SDWLDSS=+Y
 I '$D(^SDWL(409.31,"B",SDWLDSS)) D
 .S DIC(0)="LX",X=SDWLDSS,DIC="^SDWL(409.31," K DO D FILE^DICN
 S DA=$O(^SDWL(409.31,"B",SDWLDSS,""))
SB1A S DIR(0)="PAO^4:EMZ" D ^DIR
 I X="" W *7," Required" G SB1A
 I X["^" D:'$D(^SDWL(409.31,DA,"I"))  S DUOUT=1 Q
 .S DIK="^SDWL(409.31," D ^DIK
 S X=$$GET1^DIQ(4,+Y_",",11)
 I X'["N"!'$$TF^XUAF4(+Y) W !,*7,"Invalid Entry. Must be 'National' Institution." G SB1A
 I '$D(^SDWL(409.31,DA,"I","B",+Y)) D
 .S DA(1)=DA,DIC="^SDWL(409.31,"_DA(1)_","_"""I"""_",",DIC("P")=409.311,X=+Y K D0 D FILE^DICN I +Y S DA=+Y
 I $D(^SDWL(409.31,DA,"I","B",+Y)) S DA(1)=DA,DA=$O(^(+Y,0))
 K DIC,DIE,DIR,DR
 W ! S DR="1;3",DIE="^SDWL(409.31,"_DA(1)_","_"""I"""_"," D ^DIE
 I $P(^SDWL(409.31,DA(1),"I",DA,0),U,2)="" D
 .W *7,!,"This ENTRY requires an ACTIVATION DATE. ENTRY deleted."
 .S DIK="^SDWL(409.31,"_DA(1)_","_"""I"""_"," D ^DIK I '$P(^SDWL(409.31,DA(1),"I",0),U,3) D
 ..S DIK="^SDWL(409.31,",DA=DA(1) D ^DIK
 K DA,DA(1),SDWLDSS,DIC,DR,DIE,DI,DIEDA,DIG,DIH,DIIENS,DIR,DIU,DIV
 Q
SB2 N STR,INST,DIC,SDWLSC,SDWLSTOP S SDWLSTOP=0
 W ! S DIC(0)="AEMNZ",DIC("A")="Select Clinic: ",DIC=44
 S DIC("S")="S SDWLX=$G(^SC(+Y,0)),SDWLY=$G(^(""I"")) I $P(SDWLX,U,3)=""C"",$P(SDWLY,U,1)'>$P(SDWLY,U,2)"
 S DIC("W")="S STR=$$CLIN^SDWLPE(+Y) I STR W ?50,""- "",$E($P(STR,U,3),1,25),""("",$P(STR,U,2),"")"""
 D ^DIC I Y<1 K DIC,DA Q
 Q:$D(DUOUT)  S SDWLSC=+Y S INST=+STR  ;$$CLIN(SDWLSC)
 I $P(STR,U,6)'="" W !,*7,$P(STR,U,6) G SB2
 N SDANEW S SDANEW=""
 I '$D(^SDWL(409.32,"B",SDWLSC)) D
 .S DIC(0)="LX",X=SDWLSC,DIC="^SDWL(409.32," D FILE^DICN
 .N DA S DA=$O(^SDWL(409.32,"B",SDWLSC,"")) S SDANEW=DA
 .S DIE="^SDWL(409.32,",DR=".02////^S X=INST" D ^DIE
 N DA,SDA S DA=$O(^SDWL(409.32,"B",SDWLSC,"")),SDA=DA
 S DR="1",DIE="^SDWL(409.32," D ^DIE
 I SDANEW,'X D  D ESB2 H 1 G SB2
 .W *7,!!,"This ENTRY requires an ACTIVATION DATE. ENTRY deleted."
 .S DA=SDANEW S DIK="^SDWL(409.32," D ^DIK
 I X S DR="2////^S X=DUZ" D ^DIE
 N DIC
 S SDWLSCN=$P($G(^SDWL(409.32,SDA,0)),U,1) D  Q:SDWLSTOP
 .I $D(^SDWL(409.3,"SC",SDWLSCN)) D
 ..S SDWLN="",SDWLCNT=0 F  S SDWLN=$O(^SDWL(409.3,"SC",SDWLSCN,SDWLN)) Q:SDWLN=""  D
 ...S X=$G(^SDWL(409.3,SDWLN,0)) I '$D(^SDWL(409.3,SDWLN,"DIS")) S SDWLCNT=SDWLCNT+1,^TMP("SDWLPE",$J,"DIS",SDWLN,SDWLCNT)=X,SDWLSTOP=1
 ..I SDWLSTOP W !,"This Clinic has Patients on the Wait List and can not be inactivated."  H 2 Q
 .S DR="4////^S X=DUZ" D ^DIE
 S DR="3",DIE="^SDWL(409.32," D ^DIE
ESB2 ;
 K DR,DIE,DIC,Y,X,SDWLY,DIC(0),DO,DA,DI,DIW,SDWLX,SDWLSCN,SDWLF
 Q
SWT ;SWITCH FOR INACTIVATION OF PARAMETER FILE
 Q
HD ;HEADER
 W:$D(IOF) @IOF W !!,?80-$L("Wait List Parameter Enter/Edit")\2,"Wait List Parameter Enter/Edit",!
 W !,?80-$L("------------------------------")\2,"------------------------------",!
END K SDWLSTOP,DIR,DIC,DR,DIK,SDWLX,SDWLSCN,SDWLF,SDWLY,SDWLSC,SDWLN,SDWLCNT,SDWLDSS,DUOUT,X,Y
 Q
CLIN(CL) ;identify clinic institution through DIVISON ----> INSTITUTION path.
 ; function to return:
 ;                     1                        2                     3               4                    5       6        7
 ; - Institution pointer to ^DIC(4 _U_ STATION number (# 99) _U_ INST Name _U_ DIV Pointer to ^DG(40.8 _U_N/L_U_Message_U_TYPE
 ;           ( INST^STA NUM^SNAM^DIV^N/L^MESS^TYPE )
 ;           N/L - N -National/L -Local
 ;           TYPE - type of entry in file # 44 (field #2)
 ;                 C:CLINIC
 ;                 M:MODULE
 ;                 W:WARD
 ;                 Z:OTHER LOCATION
 ;                 N:NON-CLINIC STOP
 ;                 F:FILE AREA
 ;                 I:IMAGING
 ;                OR:OPERATING ROOM
 ;           
 ;        with optional Message:
 ;        
 ;        if STA=""
 ;        -  INST^^SNAM^DIV^N/L^' - No Station Number on file' ^ TYPE
 ;          or
 ;        -  0^^^DIV^^' - No Institution has been identified '^ TYPE
 ;        -  0^^^-1^^'  - No Division has been identified' ^ TYPE
 ;        
 ;        if entry is inactivated:
 ;        
 ;        -  INST^^SNAM^DIV^N/L^' - Inactive treating medical facility' ^ TYPE
 ;        -  -1^^^^^' -  No clinic on file' ^
 ;        
 I +CL=0!'$D(^SC(+CL)) Q -1_"^^^^^ - No clinic on file^"
 N SDWMES,STN,DIV,INS,SNL,STR,SNAM S SDWMES="",STN=""
 N TYPE S TYPE=$$GET1^DIQ(44,CL_",",2,"E")
 S DIV=+$$GET1^DIQ(44,CL_",",3.5,"I")
 I DIV=0 S SDWMES=" - No Division has been identified" Q 0_"^^^"_-1_"^^"_SDWMES_U_TYPE
 S INS=+$$GET1^DIQ(40.8,DIV_",",.07,"I")
 I INS=0 S SDWMES=" - No Institution has been identified" Q 0_"^^^"_DIV_"^^"_SDWMES_U_TYPE
 E  S STR=$$NS^XUAF4(INS),STN=$P(STR,U,2),SNAM=$P(STR,U) ;station number and name
 I STN="" S SDWMES=" - No Station Number on file"
 I '$$TF^XUAF4(INS) S SDWMES=SDWMES_" - Inactive treating medical facility"
 S SNL=$$GET1^DIQ(4,INS_",",11,"I")
 Q INS_U_STN_U_SNAM_U_DIV_U_SNL_U_SDWMES_U_TYPE

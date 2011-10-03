SDWLBACC ;;IOFO BAY PINES/OG - BATCH CHANGE EWL CLINIC  ; Compiled August 14, 2007 11:20:57
 ;;5.3;scheduling;**446**;AUG 13 1993;Build 77
 ;
 ;  ******************************************************************
 ;  CHANGE LOG
 ;       
 ;   DATE         PATCH    DESCRIPTION
 ;   ----         -----    -----------
 ;   
 ;
 N SDWLERR,SDWLOPT,SDWLSCL,SDWLHD,SDWLIN1,SDWLIN2,SDWLCL0,SDWLCL1,SDWLCL2,SDWLCSC1,SDWLCSC2,SDWLCM
 S SDWLHD="Scheduling/PCMM Batch Change EWL Clinic"
 W:$D(IOF) @IOF W !?80-$L(SDWLHD)\2,SDWLHD,!
 S SDWLERR=0,SDWLOPT=1,(SDWLIN2,SDWLCL1,SDWLCL2,SDWLCM)="",SDWLIN1=+$$SITE^VASITE()
 F  D @("P"_SDWLOPT) Q:'SDWLOPT
 Q
P1 ; Source Institution
 S DIR(0)="PAO^DIC(4,:EMNZ"
 S DIR("A")="Select Source Institution: "
 I SDWLIN1'="" S DIR("B")=$$GET1^DIQ(4,SDWLIN1,.01)
 S DIR("S")="I $E($$GET1^DIQ(4,+Y,99),1,3)=$E(+$P($$SITE^VASITE(),U,3),1,3)"
 D ^DIR
 I Y<1 S SDWLOPT=0 Q
 S (SDWLIN1,SDWLIN2)=+Y,SDWLOPT=SDWLOPT+1
 Q
P2 ; Source Clinic
 N DIR,SDWLSC
 S DIR(0)="PAO^SDWL(409.32,:EMNZ"
 S DIR("A")="Select Source Clinic: "
 I SDWLCL1'="" S DIR("B")=$$GET1^DIQ(409.32,SDWLCL1,.01)
 S DIR("S")="S X=$$GET1^DIQ(409.32,+Y,.01,""I"") I $P($$CLIN^SDWLBACC(X),U)=SDWLIN1"
 D ^DIR
 I Y="^" S SDWLOPT=0 Q
 I Y<1 S SDWLOPT=SDWLOPT-1 Q
 S SDWLCL0=+Y  ; Wait list specific clinic
 S SDWLCL1=$P(Y,U,2)  ; pointer to HOSPITAL LOCATION file
 S SDWLCSC1=$$GET1^DIQ(44,SDWLCL1,8,"I")_U_$$GET1^DIQ(44,SDWLCL1,8) ; Clinic stop code
 S SDWLOPT=SDWLOPT+1
 Q
P3 ; Destination Institution
 S DIR(0)="PAO^DIC(4,:EMNZ"
 S DIR("A")="Select Destination Institution: "
 I SDWLIN1'="" S DIR("B")=$$GET1^DIQ(4,SDWLIN2,.01)
 S DIR("S")="I $E($$GET1^DIQ(4,+Y,99),1,3)=$E(+$P($$SITE^VASITE(),U,3),1,3)"
 D ^DIR
 I Y="^" S SDWLOPT=0 Q
 I Y<1 S SDWLOPT=SDWLOPT-1 Q
 S SDWLIN2=+Y,SDWLOPT=SDWLOPT+1
 Q
P4 ; Destination Clinic
 N DIR,SDWLSC,SDWLY
 S DIR(0)="PAO^SDWL(409.32,:EMNZ"
 S DIR("A")="Select Destination Clinic: "
 I SDWLCL2'="" S DIR("B")=$$GET1^DIQ(409.32,SDWLCL2,.01)
 S DIR("S")="S X=$$GET1^DIQ(409.32,+Y,.01,""I"") I $P($$CLIN^SDWLBACC(X),U)=SDWLIN2,+Y'=SDWLCL0"
 D ^DIR
 I Y="^" S SDWLOPT=0 Q
 I Y<1 S SDWLOPT=SDWLOPT-1 Q
 S SDWLY=+Y,SDWLSC=$P(Y,U,2)  ; pointer to HOSPITAL LOCATION file
 ; get clinic's stop code. warn if different.
 S SDWLCSC2=$$GET1^DIQ(44,SDWLSC,8,"I")_U_$$GET1^DIQ(44,SDWLSC,8)  ; Clinic's stop code
 I +SDWLCSC1'=+SDWLCSC2 D  Q:'Y
 .S DIR(0)="Y"
 .S DIR("A")="The clinics' stop codes are different, continue"
 .S DIR("A",1)=$$GET1^DIQ(409.32,SDWLCL1,.01)_": "_$P(SDWLCSC1,U,2)_" ("_+SDWLCSC1_")"
 .S DIR("A",2)=$$GET1^DIQ(409.32,+Y,.01)_": "_$P(SDWLCSC2,U,2)_" ("_+SDWLCSC2_")"
 .S DIR("B")="YES"
 .D ^DIR
 .S:Y="^" SDWLOPT=0
 .Q
 S SDWLSCL=SDWLY,SDWLOPT=SDWLOPT+1
 Q
P5 ; Comment
 D P4^SDWLE6
 Q
P6 ; Confirmation and processing
 N DIR,Y
 S DIR(0)="Y"
 S DIR("A")="Proceed with batch clinic change"
 S DIR("B")="YES"
 D ^DIR
 D:Y CHNGCL
 S SDWLOPT=0
 Q
CHNGCL ;
 N DIR,SDWLDA,SDWLCNT
 S SDWLDA="",SDWLCNT=0
 F  S SDWLDA=$O(^SDWL(409.3,"SC",SDWLCL1,SDWLDA)) Q:'SDWLDA  D
 .N DA,DIE,DIR,DR,SDWLDFN,SDWLIN,SDWLTMP,SDWLORDT,SDWLSCPG,SDWLSCPR,SDWLCL1,SDWLDDT,SDWLEEST,Y
 .D GETS^DIQ(409.3,SDWLDA_",","1;14;15;22;23;27","I","SDWLTMP")
 .Q:SDWLTMP(409.3,SDWLDA_",",23,"I")="C"  ; Only open entries.
 .S SDWLDFN=$$GET1^DIQ(409.3,SDWLDA,.01,"I")
 .S SDWLORDT=SDWLTMP(409.3,SDWLDA_",",1,"I")
 .S SDWLSCPG=SDWLTMP(409.3,SDWLDA_",",14,"I")
 .S SDWLSCPR=SDWLTMP(409.3,SDWLDA_",",15,"I")
 .S SDWLDDT=SDWLTMP(409.3,SDWLDA_",",22,"I")
 .S SDWLEEST=SDWLTMP(409.3,SDWLDA_",",27,"I")
 .Q:'$$UPDATE^SDWLE7(SDWLDFN,SDWLORDT,SDWLIN2,SDWLSCL,SDWLSCPG,SDWLSCPR,SDWLDDT,SDWLCM,SDWLEEST,SDWLDA)
 .; disposition old entry
 .S DIE="^SDWL(409.3,",DA=SDWLDA,DR="19////^S X=DT;20////^S X=DUZ;21////^S X=""CL"";23////^S X=""C"""
 .D ^DIE
 .S SDWLCNT=SDWLCNT+1
 .Q
 W ! W:SDWLCNT "Clinics changed. " W SDWLCNT," entries processed."
 S DIR(0)="E" D ^DIR
 Q
CLIN(CL) ;identify clinic institution through DIVISON ----> INSTITUTION path.
 ; function to return: 
 ;        - Institution pointer to ^DIC(4 _U_ STATION number (# 99) _U_ Inst Name _U_ Div Pointer to ^DG(40.8 _U_N/L_U_Message
 ;           ( INST^STA NUM^SNAM^DIV^N/L^MESS )
 ;           N/L - N -National/L -Local
 ;           with Message:
 ;           - if STA="" INST^^SNAM^DIV^^N/L^' - No Station Number on file'
 ;          or
 ;        -  0^^^DIV^^' - No Institution has been identified'
 ;        -  0^^^-1^^'  - no Division has been identified'
 ;        - -1 no clinic on file'
 I '$D(^SC(+CL)) Q -1_"^^^^^no clinic on file"
 N SDWMES,STN,DIV,INS,SNL,STR,SNAM S SDWMES="",STN=""
 S DIV=+$$GET1^DIQ(44,CL_",",3.5,"I")
 I DIV=0 S SDWMES="no Division has been identified" Q 0_"^^^"_-1_"^^"_SDWMES
 S INS=+$$GET1^DIQ(40.8,DIV_",",.07,"I")
 I INS=0 S SDWMES="No Institution has been identified" Q 0_"^^^"_DIV_"^"_SDWMES
 E  S STR=$$NS^XUAF4(INS),STN=$P(STR,U,2),SNAM=$P(STR,U) ;station number and name
 I STN="" S SDWMES="No Station Number on file"
 I '$$TF^XUAF4(INS) S SDWMES="Inactive treating medical facility"
 S SNL=$$GET1^DIQ(4,INS_",",11,"I")
 Q INS_U_STN_U_SNAM_U_DIV_U_SNL_U_SDWMES

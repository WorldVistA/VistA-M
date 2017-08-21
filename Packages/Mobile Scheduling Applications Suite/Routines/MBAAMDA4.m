MBAAMDA4 ;OIT-PD/VSL - APPOINTMENT AP ;02/10/2016
 ;;1.0;Scheduling Calendar View;**1**;Aug 27, 2014;Build 85
 ;
 ;Associated ICRs
 ;  ICR#
 ;  6053 DPT
 ;  6044 SC(
 ;
 ;code below is not being used in the initial release of MBAA. It will be released at a later date in a future release of MBAA
 ;GETOE(RETURN,SDOE) ; Get outpatient encounter
 ; N IND S IND=0
 ; F  S IND=$O(RETURN(IND)) Q:IND=""  D
 ; . S RETURN(IND)=$$GET1^DIQ(409.68,SDOE_",",IND,"I")
 ; S RETURN=1
 ; Q
 ; ;
 ;GETCHLD(RETURN,SDOE) ; Get children encounters
 ; N SDOEC
 ; F SDOEC=0:0 S SDOEC=$O(^SCE("APAR",SDOE,SDOEC)) Q:'SDOEC  D
 ; . S RETURN(SDOEC)=""
 ; . S NOD=^SCE(SDOEC,0)
 ; . S RETURN(SDOEC,"DATE")=$P(NOD,U,1)
 ; . S RETURN(SDOEC,"PATIENT")=$P(NOD,U,2)
 ; . S RETURN(SDOEC,"SCODE")=$P(NOD,U,3)
 ; . S RETURN(SDOEC,"CLINIC")=$P(NOD,U,4)
 ; . S RETURN(SDOEC,"VISIT")=$P(NOD,U,5)
 ; Q
 ;DELOE(SDOE) ; Delete Outpatient Encounter
 ; N DA,DIK
 ; S DA=SDOE,DIK="^SCE(" D ^DIK
 ; Q
UPDPAPT(DATA,DFN,SD) ; Update patient appointment MBAA RPC: MBAA APPOINTMENT MAKE
 N IENS,I
 S IENS=SD_","_DFN_","
 N FDA
 F I=0:0 S I=$O(DATA(I)) Q:I=""  D
 . S FDA(2.98,IENS,I)=DATA(I)
 N ERR
 D UPDATE^DIE("","FDA",,"ERR")
 Q
 ;
UPDCAPT(DATA,SC,SD,IEN) ; Update clinic appointment Called by RPC MBAA APPOINTMENT MAKE
 N IENS,I
 S IENS=IEN_","_SD_","_SC_","
 N FDA
 F I=0:0 S I=$O(DATA(I)) Q:I=""  D
 . S FDA(44.003,IENS,I)=DATA(I)
 N ERR
 D UPDATE^DIE("","FDA",,"ERR")
 Q
 ;code below is not being used in the initial release of MBAA. It will be released at a later date in a future release of MBAA
 ;DELCLS(SDOE) ;Delete Classification
 ; N DA,DIK,SDI,SDFL
 ; S SDFL=409.42
 ; S DIK="^SDD("_SDFL_",",SDI=0
 ; F SDI=0:0 S SDI=$O(^SDD(SDFL,"AO",SDOE,SDI)) Q:'SDI  S DA=+$O(^(SDI,0)) D ^DIK
 ; Q
 ; ;
 ;GETPAPT(RETURN,DFN,SD,FLDS) ; Get patient appointment
 ; N APT,DIQ,DIC,DA,DR
 ; I '$D(FLDS) S FLDS=".01;3;5;6;7;9;12;13;14;15;16;9.5;17;19;20;21;25;26;27;28"
 ; S DIQ(0)="IE",DIQ="APT(",DIC="^DPT(DFN,""S"",",DA=SD,DR=FLDS D EN^DIQ1
 ; M RETURN=APT(2.98,SD)
 ; Q
 ;
GETCAPT(RETURN,DFN,SD,FLDS,FLAG) ; Get clinic appointment MBAA RPC: MBAA CANCEL APPOINTMENT
 N CAPT,ZL,SDDA,SC,DIQ,DIC,DA,DR S SDDA=0
 I '$D(FLDS) S FLDS=".01;1;3;7;8;9;30;309;302;303;304;306"
 S SC=+$G(^DPT(DFN,"S",SD,0))  ;ICR#: 6053 DPT
 I $D(^SC(SC,"S",SD))  D  ;ICR#: 6044 SC(
 . S ZL=0
 . F  S ZL=$O(^SC(SC,"S",SD,1,ZL)) Q:'ZL  D  ;ICR#: 6044 SC(
 . . I +^SC(SC,"S",SD,1,ZL,0)=DFN S SDDA=ZL  ;ICR#: 6044 SC(
 . Q
 Q:SDDA=0
 S DIQ(0)=$G(FLAG)
 S DIQ="CAPT(",DIC="^SC(SC,""S"",SD,1,",DA=SDDA,DR=FLDS D EN^DIQ1  ;ICR#: 6044 SC(
 M RETURN=CAPT(44.003,SDDA)
 S RETURN(222)=SC
 S RETURN(333)=SDDA
 Q
 ;code below is not being used in the initial release of MBAA. It will be released at a later date in a future release of MBAA
 ;Linetag GETPAT will not be used until the next release of MBAA
 ;GETPAT(RETURN,DFN) ; Get patient
 ;N PAT,DIQ,DIC,DA,DR
 ;S DIQ(0)="IE",DIQ="PAT(",DIC="^DPT(",DA=DFN
 ;S DR=".01;.02;.03;.05;.08;.361;.323;.131;.111;.134;.112;.135;.1173;.1112;"
 ;S DR=DR_".114;.115;.1172;.1171;.133;.32103;.525;.32102;.3213;.32115;.322013"
 ;D EN^DIQ1
 ;M RETURN=PAT(2,DFN)
 ;Q
 ;
 ;DELCODT(RETURN,SDOE) ;Delete Check Out Process Completion Date
 ; N DA,DE,DIE,DQ,DR
 ; S DA=SDOE,DIE="^SCE(",DR=".07///@" D ^DIE
 ; Q
 ;

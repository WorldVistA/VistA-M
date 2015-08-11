ONCOAIF ;Hines OIFO/GWB - [PF Post/Edit Follow-up] ;11/08/10
 ;;2.2;ONCOLOGY;**1,4**;Jul 31, 2013;Build 5
 ;
BEG W @IOF,!," Post/Edit Follow-up"
 W !," -------------------",!
 Q
 ;
PAT ;[PF Post/Edit Follow-up]
 N ONCDUZ,ONCDT
 S ONCDUZ=DUZ,ONCDT=DT
 D BEG
 S DIC("A")=" Post/Edit Follow-Up for patient: "
 S DIC="^ONCO(160,",DIC(0)="AEMQZ" D ^DIC K DIC
 G KILL:Y<0
 S (ONCOD0,DA,D0)=+Y,ONCONM=Y(0,0)
 D SUM,LST^ONCODLF G DIE
 ;
LST ;Follow-Up
 W @IOF,!!," **********FOLLOW-UP**********",!!
 W " Patient: ",ONCONM
 W:$D(XDD) !," Date of Inpatient Discharge: ",XDD
 Q
 ;
EN ;FOLLOW-UP entry when patient has been pre-selected
 K F,DIC,DO,ONCOD1,LC,VS,NF,XDT,XDD,XR
 S ONCDUZ=DUZ,ONCDT=DT
 S PRESEL=1
 ;S XDT=$S('$D(ONCOD0P):"",1:$$GET1^DIQ(165.5,ONCOD0P,1.1,"I"))
 S XDT=""
 I (XDT="")!(XDT="0000000")!(XDT="9999999") D LST G DIE
 D DD S F=$P($G(^ONCO(160,ONCOD0,"F",0)),U,4)
 I F<1 D DLC,LST S F=1 G DIE
RF S D0=ONCOD0 W !! K DXS,DIOT D BEG W ! D LST^ONCODLF G DIE
 ;
DIE K DXS
 S ONCDUZ=DUZ,ONCDT=DT
 S ONCOSTAT=1,DA=ONCOD0,DR="[ONCO FOLLOWUP]",DIE="^ONCO(160,",FG=0
 W ! D ^DIE
 I 'FG S ONCOVS="" D UPOUT,CHKCMP I $G(FOLINP)="YES" G DIE
 I $O(^ONCO(160,ONCOD0,"F",0))="" Q
 D CHKCHG
 S XD0=ONCOD0 D DUPPRI^ONCFUNC
 I 'FG Q
 ;
UPDAT S D0=ONCOD0 K DXS,DIOT W ! D LST^ONCODLF,UPD^ONCOCRF
 N Y,ONCOD
 K DIQ,ONC S DIC="^ONCO(160,",DR=".01;16;15;15.2",DA=ONCOD0,DIQ="ONC"
 D EN^DIQ1 W !
 W !," Name..: ",ONC(160,ONCOD0,.01)
 W ?35,"Date Last Contact: ",ONC(160,ONCOD0,16)
 W !," Status: ",ONC(160,ONCOD0,15)
 W ?35,"Follow-Up Status.: ",ONC(160,ONCOD0,15.2)
 D SUM
C K DIR S DIR("A")="DATA OK",DIR("B")="Yes",DIR(0)="Y"
 D ^DIR Q:(Y=U)!(Y="")  G DIE:'Y
 I ONCOVS G KILL:$G(ONCRFOPT)=1 S ONCFRMPF=1 G REC  ;G KILL:$D(PRESEL) G PAT:'$D(REC),REC
 W !! D DEAD^ONCOFDP
 Q:$D(ONCOAI)  G REC:$D(REC) D KILL K ONCONM S ONCOD=1 Q
 ;
UPOUT ;Up-arrow out check before deleting
 Q:'$D(ONCOD1)
 Q:'$D(^ONCO(160,ONCOD0,"F",ONCOD1,0))
 Q:$P(^ONCO(160,ONCOD0,"F",ONCOD1,0),U,8)=1
 D DEL
 Q
 ;
DEL ;Delete FOLLOW-UP entry
 S DA(1)=ONCOD0,DA=ONCOD1,DIK="^ONCO(160,"_DA(1)_",""F"","
 D ^DIK S ONCOVS=""
 W:$D(^ONCO(160,ONCOD0,"F",ONCOD1,0)) $P(^(0),U,8)
 W !!," *********************ENTRY DELETED*************************"
 W !!," You have not entered all of the required information."
 W !!,"(Last Tumor Status(es) have been reset for this patient's primary site(s).)",!!
 H 1
 Q
 ;
CHKCMP ;Check for 'Complete" abstracts with no follow-up
 N AN,ASTAT,PID,PN,PRIM,PSCODE,SEQ
 Q:$O(^ONCO(160,ONCOD0,"F",0))'=""
 S PRIM=0 F  S PRIM=$O(^ONCO(165.5,"C",ONCOD0,PRIM)) Q:PRIM'>0  D
 .I $P($G(^ONCO(165.5,PRIM,7)),U,2)=3 S ASTAT(PRIM)=""
 Q:'$D(ASTAT)
 W !
 W !," There is no follow-up information for this patient."
 W !," This patient has a 'Complete' abstract."
 W !," A 'Complete' abstract requires at least one follow-up."
 W !
 K DIR
 S DIR("A")=" Do you wish to enter a follow-up at this time"
 S DIR("B")="YES",DIR(0)="Y" D ^DIR
 I Y=1 S FOLINP="YES" Q
 S FOLINP="NO"
 S PRIM=0 F  S PRIM=$O(ASTAT(PRIM)) Q:PRIM'>0  D
 .S DIE="^ONCO(165.5,"
 .S DA=PRIM
 .S DR="90///@;91///0;92///@;197///@"
 .D ^DIE
 W !!," The ABSTRACT STATUS has been changed to 0 (Incomplete)"
 W !," for the following abstracts:",!
 S PRIM=0 F  S PRIM=$O(ASTAT(PRIM)) Q:PRIM'>0  D
 .S PN=$$GET1^DIQ(165.5,PRIM,.02)
 .S AN=$$GET1^DIQ(165.5,PRIM,.05)
 .S SEQ=$$GET1^DIQ(165.5,PRIM,.06)
 .S PID=$$GET1^DIQ(165.5,PRIM,61)
 .S PSCODE=$$GET1^DIQ(165.5,PRIM,20.1)
 .W !?1,PID,"  ",PSCODE,"  ",AN,"/",SEQ
 .W !
 K DIR S DIR(0)="E" D ^DIR
 Q
 ;
CHKCHG ;Check for checksum changes to 'Complete' abstracts
 N CHECKSUM,CNT,ONCDST
 S CNT=0 W !!," Checking for changes to 'Complete' abstracts" S PRIM=0 F  S PRIM=$O(^ONCO(165.5,"C",ONCOD0,PRIM)) Q:PRIM'>0  D
 .W "."
 .I $P($G(^ONCO(165.5,PRIM,7)),U,2)=3 D
 ..S EDITS="NO" S D0=PRIM D NAACCR^ONCGENED K EDITS
 ..S CHECKSUM=$$CRC32^ONCSNACR(.ONCDST)
 ..I CHECKSUM'=$P($G(^ONCO(165.5,PRIM,"EDITS")),U,1) D
 ...S $P(^ONCO(165.5,PRIM,"EDITS"),U,1)=CHECKSUM
 ...W !!," Re-computing checksum value for 'Complete' abstract ",$$GET1^DIQ(165.5,PRIM,.061)
 ...S DIE="^ONCO(165.5,",DA=PRIM,DR="198///^S X=DT" D ^DIE
 ...S CNT=CNT+1
 W:CNT=0 " No changes found."
 Q
 ;
REC ;[RF Recurrence/Sub Tx Follow-up]
 N D,ONCDUZ,ONCDT,TX
 S ONCDUZ=DUZ,ONCDT=DT
 S XR=1,REC="" W @IOF,!," Recurrence/Sub Tx Follow-up"
 W !," ---------------------------",!
 I $G(ONCFRMPF)=1 G RECPF ;if pt pre-selected from ^PF skip pt select
 S ONCRFOPT=1,DIC("A")="Select Patient for Recurrence: "
 S DIC="^ONCO(160,",DIC(0)="AEQMZ" D ^DIC K DIC
 G KILL:Y<0
 S (D0,ONCOD0)=+Y,ONCONM=Y(0,0)
 N Y
RECPF K DIQ,ONC S DIC="^ONCO(160,",DR=".01;2;3;8;10;15",DA=ONCOD0,DIQ="ONC"
 D EN^DIQ1 W !
 W !?2,"Name.........: ",ONC(160,ONCOD0,.01)
 W ?35,"Race.........: ",ONC(160,ONCOD0,8)
 W !?2,"SSN..........: ",ONC(160,ONCOD0,2)
 W ?35,"Sex..........: ",ONC(160,ONCOD0,10)
 W !?2,"Date of Birth: ",ONC(160,ONCOD0,3)
 W ?35,"Status.......: ",ONC(160,ONCOD0,15)
 D SUM
 K DIC W !?1,"Select Primary for Recurrence: ",!
 ;S D="C",DIC="^ONCO(165.5,",X=ONCOD0,DIC(0)="EFZ" D IX^DIC G:Y<0 REC
 ;added Type of First Recurrence P *2.2*4
 N ONC16012,ONC1655
 S D="C",DIC="^ONCO(165.5,",X=ONCOD0,DIC(0)="EFZ"
 S DIC("W")="S ONC16012=$P($G(^(5)),U,2),ONC1655=+Y D FST^ONCODSP"
 D IX^DIC G:Y<0 KILL
 I Y'=" " S (ONCOD0P,DA)=+Y,DR="[ONCO RECURRENCE FOLLOWUP]",DIE="^ONCO(165.5,",DATEDX=$P(^ONCO(165.5,DA,0),U,16),TX=$P($G(^ONCO(165.5,DA,2)),U,1) D ^DIE D CHKCHG S AB=2,ONCOD0P=D0 G EN:$D(ONCRFOPT)
 G KILL Q
 ;
RE ;Recurrence
 W !!," Recurrence"," ----------"
 ; If Type of First Recurrence is not set yet, then check the
 ; Cancer Status field of Tumor Status multiple to set defaults for
 ; Type of First Rec, Rec Date 1st-Flag & Distant Sites 1-3 fields
 ;  -- Called from [ONCO RECURRENCE FOLLOWUP] template --
 S ONCTOFR=$P($G(^ONCO(165.5,ONCOD0P,5)),"^",2) I ONCTOFR'="" K ONCTOFR Q
 S ONCTSDAT=$O(^ONCO(165.5,ONCOD0P,"TS","AA",0)) Q:ONCTSDAT=""
 S ONCTSIEN=$O(^ONCO(165.5,ONCOD0P,"TS","AA",ONCTSDAT,0)) Q:ONCTSIEN=""
 S ONCTSCS=$P($G(^ONCO(165.5,ONCOD0P,"TS",ONCTSIEN,0)),"^",2)
 S ONCTOFRV=""
 I ONCTSCS=1 S ONCTOFRV=$O(^ONCO(160.12,"B","00","")),ONCRD1F=11
 I ONCTSCS=2 S ONCTOFRV=$O(^ONCO(160.12,"B",70,"")),ONCRD1F=11
 I ONCTSCS=9 S ONCTOFRV=$O(^ONCO(160.12,"B",99,"")),ONCRD1F=10
 ;Hard set the nodes since we are within an Input Template when called
 ;so ^DIE not working - there are no X-refs to set
 S $P(^ONCO(165.5,ONCOD0P,5),U,2,5)=ONCTOFRV_"^0^0^0"
 S $P(^ONCO(165.5,ONCOD0P,27),U,26)=ONCRD1F
 ;
 K ONCRD1F,ONCTOFR,ONCTOFRV,ONCTSDAT,ONCTSIEN,ONCTSCS Q
 ;
STX ;Subsequent Course of Treatment
 W !!," Subsequent Course of Treatment"
 W !," ------------------------------"
 Q
 ;
KILL ;Kill variables
 K ONCOSTAT,XR,DA,DIC,DIE,DIK,DIOT,DIR,DO,DR,DXS,F,FG,FOLINP
 K ONCOD1,ONCOLC,X,XD1,XD0,LC,ONCOVS,REC
 K AB,DATEDX,PRESEL,ONCFRMPF,ONCRFOPT
 Q
 ;
DD ;Date format
 S XDD=$E(XDT,4,5)_"/"_$E(XDT,6,7)_"/"_($E(XDT,1,3)+1700) Q
 ;
DLC ;Create FOLLOW-UP
 K DA
 S DA(1)=ONCOD0,DIC="^ONCO(160,"_DA(1)_","_"""F"""_","
 S DLAYGO=160,X=XDT,DIC(0)="ZL"
 I '$D(^ONCO(160,DA(1),"F")) S ^ONCO(160,DA(1),"F",0)="^160.04DAI^^"
 D FILE^DICN S ONCOLC=XDT,DIE=DIC,DR="1////1;2////2;" D ^DIE
 K DA,DIC,DLAYGO,DIE
 Q
 ;
SUM ;Primary summary
 S XD0=D0
 N J,XD1 W !!
 S J=0,XD1=0 F  S XD1=$O(^ONCO(165.5,"C",XD0,XD1)) Q:XD1'>0  I $D(^ONCO(165.5,XD1,0)) S J=J+1 D ^ONCOCOML
 Q
 ;
CLEANUP ;Cleanup
 K D0,ONCOAI,ONCOD0,ONCOD0P

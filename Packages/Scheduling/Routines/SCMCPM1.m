SCMCPM1 ;ALB/REW - Pt PC Team Assignment on Inpt Discharge ; 1 Apr 1996
 ;;5.3;Scheduling;**41,130**;AUG 13, 1993
 ;
PCMMDIS ; - called by 'SC ASSIGN PC TEAM ON DISCHARGE' which is 
 ;   called by the patient movement event driver
 Q:$D(ZTQUEUED)  ;interactive - quit if queued
 ;check if patient has a current PC team if no prompt to enroll
 Q:$P($G(DGPMA),U,2)'=3  ;must be a discharge
 Q:'$G(DFN)  ;should exist
 Q:'$P($G(^SD(404.91,1,"PCMM")),U,2)  ; check turn off flag
 N DIR,DIRUT,DIROUT,SCTMERR,DIC,X,Y,SCOK,SCX,SCOUTFLD,SCBADOUT
 D:'$G(DGQUIET) EN^DDIOL("Checking Primary Care Status...")
 ;display PC info, check if patient has a current PC team
 D PCMM^SCRPU4(DFN,DT)
 G:$$NMPCTM^SCAPMCU2(DFN,DT,1) END
 ;if not, check if patient has a PC team in the future
 S SCOK=$$YSPTTMPC^SCMCTMU2(DFN,DT)
 IF 'SCOK D  G END
 .D:'$G(DGQUIET) EN^DDIOL($P(SCOK,U,2))
 ;if not either, ask if they want to assign a patient to a PC team
 S DIR(0)="Y"
 S DIR("A")="Do you wish to assign patient to Primary Care"
 S DIR("B")="NO"
 D ^DIR
 G:'Y END
 S DIR(0)="Y"
 S DIR("A")="Do you wish to assign patient to a Primary Care Team"
 S DIR("B")="NO"
 D ^DIR
 IF 'Y D  G END
 .S SCOUTFLD(.04)=1
 .S SCX=$$ACOUTPT^SCAPMC20(DFN,"SCOUTFLD","SCBADOUT")
 .D:SCX&'($G(DGQUIET)) EN^DDIOL("Patient Assigned to Primary Care, but no Team Assigned...")
 S DIC="^SCTM(404.51,"
 S DIC(0)="AEMQZ"
 S DIC("S")="IF $$ACTTM^SCMCTMU(Y,DT)&($P($G(^SCTM(404.51,Y,0)),U,5))"
 ;  - select from active teams that can be PC Teams
 D ^DIC
 G:Y<1 END
 S SCTM=+Y
 ;setup fields
 S SCTMFLDS(.02)=DT
 S SCTMFLDS(.08)=1 ;primary care assignment
 S SCTMFLDS(.11)=$G(DUZ,.5)
 D NOW^%DTC S SCTMFLDS(.12)=%
 IF $$ACPTTM^SCAPMC(DFN,SCTM,"SCTMFLDS",DT,"SCTPTME") D
 .D:'$G(DGQUIET) EN^DDIOL("...PC Team Assignment Made")
END ;
 Q

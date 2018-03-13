DGMFA11 ;DAL/JCH - NDS DEMOGRAPHICS MARITAL STATUS ASSOCIATION ;15-AUG-2017
 ;;5.3;Registration;**933**;Aug 13, 1993;Build 44
 ;
 Q
 ; 
 ; Available at Master File Association Enter/Edit [DGMF AMAIN] option, at the following menu path:
 ;    Supervisor ADT Menu [DG SUPERVISOR MENU]
 ;      ADT System Definition Menu [DG SYSTEM DEFINITION MENU]
 ;        Master Demographics Files [DGMF MENU]
 ;          Master File Association Enter/Edit [DGMF AMAIN]
 ;
EN  ; Allow users to populate the MASTER MARITAL STATUS field (#90) in MARITAL STATUS file (#11)
 D INFO        ; Display option info
 D KILLTMP     ; Kill ^TMP($J,"DGMFR11"
 N DGDONE      ; Signal from user - Q:DGDONE
 S DGDONE=0
 ; Prompt for MARITAL STATUS file (#11) entries until user quits
 F  Q:DGDONE  D
 .N DIE,DA,DR,DIC,X,Y,DIR,DUOUT,DGMSI,DGMMSIV
 .N DGMSNAM,DGMS0,DGMMS0,DGEMMSI,DGMDONE,DGSUM
 .;
 .S DGMSI=$$GETMS(.DGDONE) Q:$G(DGDONE)  ; Get Marital Status IEN
 .; Get info from 11 (inclding pointer to 10.99), store in ^TMP($J
 .D GETDATA(DGMSI,.DGMMSIV)
 .; Use MMS report to print MARITAL STATUS details
 .S DGSUM=1 D PRINMS^DGMFR11(DGMSI)
 .;
 .D UPDMS(DGMSI)
 .D GETDATA(DGMSI,.DGMMSI)    ; Get updated data
 .I DGMMSI'=DGMMSIV D REDISP(DGMSI)  ; Pointer chagned, display updated record
 .;
 .S DIR(0)="EA",DIR("A",1)="",DIR("A",2)="",DIR("A")="Press Return to continue " D ^DIR
 .D INFO
 D KILLTMP
 Q
 ;
GETMS(DGDONE)  ; Prompt user for Marital Status file (#11) entry
 N DIC,X,Y
 S DIC=11,DIC(0)="QEAMZ"
 F  Q:$G(Y)>0!$G(DGDONE)  D
 .W ! D ^DIC I $G(DUOUT)!$G(DTOUT)!($G(Y)<0) S DGDONE=1 Q  ; Nothing selected, quit
 .N DGONAM
 .S DGONAM=$P($G(^DIC(11,+Y,0)),"^")
 .Q:'$D(^DGMMS(11.99,"AC",DGONAM))
 .; Use MFR11 report to print MARITAL STATUS details
 .D GETDATA(+Y)
 .S DGSUM=2 D PRINMS^DGMFR11(+Y)
 .W !!," *   This entry has been associated to the MASTER MARITAL     *",!," *   STATUS file by Standards & Terminology Services (STS)    *"
 .W !," *   and can only be edited via the Master File Server (MFS). *"
 .K Y
 S DGMSI=+Y,DGMSNAM=$P(Y,"^",2)
 Q DGMSI
 ;
UPDMS(DGMSI)   ; Use DG AMSTAT input template to restrict input to Master Marital Status field
 S DIE="^DIC(11,"
 S DR="[DGMF AMSTAT]"
 S DA=DGMSI
 D ^DIE
 Q
 ;
REDISP(DGMSI)  ; Redisplay update RACE file (#10) entry
 W !!,"Update Successful...."
 D PRINMS^DGMFR11(DGMSI)   ; display summarized Marital Status entry info
 Q
 ;
INFO ; Display message, clear screen
 N MSG
 S MSG(1)="   This option allows MARITAL STATUS file entries to be"
 S MSG(2)="   associated with the MASTER MARITAL STATUS file to enhance"
 S MSG(3)="   interoperablity. The MASTER MARITAL STATUS file contains"
 S MSG(4)="   standard Health Level Seven (HL7) marital statuses."
 S MSG(5)=""
 D CLEAR^VALM1
 D BMES^XPDUTL(.MSG)
 Q
 ;
GETDATA(DGMSI,DGMMSI) ; Define local variables and set into ^TMP($J
 S DGMS0=$G(^DIC(11,DGMSI,0))
 S DGMMSI=+$G(^DIC(11,DGMSI,"MASTER"))
 S DGMSST=+$G(^DIC(11,DGMSI,.02)),DGMSST=$S(DGMSST:"INACTIVE",1:"ACTIVE")
 S DGMMS0=$S($G(DGMMSI):$G(^DGMMS(11.99,+DGMMSI,0)),1:"Not Mapped")
 I DGMMSI S $P(DGMMS0,"^",4)=DGMMSI
 S ^TMP($J,"DGMFR11",DGMS0,DGMSI,"MSE")=$G(DGMS0)
 S ^TMP($J,"DGMFR11",DGMS0,DGMSI,"MMSE")=$G(DGMMS0)
 Q
 ;
KILLTMP  ; Kill ^TMP global
 K ^TMP($J,"DGMFR11")
 Q

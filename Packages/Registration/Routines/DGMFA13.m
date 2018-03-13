DGMFA13 ;DAL/JCH - NDS DEMOGRAPHICS RELIGION ASSOCIATION ;15-AUG-2017
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
EN  ; Allow users to populate the MASTER RELIGION field (#90) in RELIGION file (#13)
 D INFO        ; Display option info
 D KILLTMP     ; Kill ^TMP($J,"DGMFR13"
 N DGDONE      ; Signal from user - Q:DGDONE
 S DGDONE=0
 ; Prompt for RELIGION (#13) entries until user quits
 F  Q:DGDONE  D
 .N DIE,DA,DR,DIC,X,Y,DIR,DUOUT,DGMRI,DGMMRIV
 .N DGMRNAM,DGMR0,DGMMR0,DGEMMRI,DGMDONE,DGSUM
 .;
 .S DGMRI=$$GETMR(.DGDONE) Q:$G(DGDONE)   ; Get Religion file (#13) entry
 .; Get info from 13 (including pointer to 13.99), store in ^TMP($J
 .D GETDATA(DGMRI,.DGMMRIV)
 .; Use report to print details
 .S DGSUM=1 D PRINMR^DGMFR13(DGMRI)
 .;
 .D UPDMR(DGMRI)
 .D GETDATA(DGMRI,.DGMMRIV)   ; Done editing, get data again
 .I DGMMRI'=DGMMRIV D REDISP(DGMRI)  ; Pointer changed, display updated record
 .;
 .S DIR(0)="EA",DIR("A",1)="",DIR("A",2)="",DIR("A")="Press Return to continue " D ^DIR
 .D INFO
 D KILLTMP
 Q
 ;
GETMR(DGDONE)  ; Prompt user for RELIGION file (#13) entry
 N DIC
 S DIC=13,DIC(0)="QEAMZ"
 F  Q:$G(Y)>0!$G(DGDONE)  D
 .W ! D ^DIC I $G(DUOUT)!$G(DTOUT)!($G(Y)<0) S DGDONE=1 Q  ; Nothing selected, quit
 .N DGONAM
 .S DGONAM=$P($G(^DIC(13,+Y,0)),"^")
 .Q:'$D(^DGMR(13.99,"AC",DGONAM))
 .; Use MFR13 report to print RELIGION details
 .D GETDATA(+Y)
 .S DGSUM=2 D PRINMR^DGMFR13(+Y)
 .W !!," *  This entry has been associated to the MASTER RELIGION *",!," *  file by Standards & Terminology Services (STS) and    *"
 .W !," *  may only be edited via the Master File Server (MFS).  *"
 .K Y
 S DGMRI=+Y,DGMRNAM=$P(Y,"^",2)
 Q DGMRI
 ;
UPDMR(DGMRI)  ; Use DGF AMREL input template to restrict input to Master Marital Status field
 S DIE="^DIC(13,"
 S DR="[DGMF AMREL]"
 S DA=DGMRI
 D ^DIE
 Q
 ;
REDISP(DGMRI)  ; Redisplay updated MARITAL STATUS file (#13) entry
 W !!,"Update Successful..."
 D PRINMR^DGMFR13(DGMRI)   ; display summarized plan info
 Q
 L
INFO ; Display message, clear screen
 N MSG
 S MSG(1)="   This option allows RELIGION file entries to be"
 S MSG(2)="   associated with the MASTER RELIGION file to enhance "
 S MSG(3)="   interoperablity. The MASTER RELIGION file contains"
 S MSG(4)="   standard Health Level Seven (HL7) religions."
 S MSG(5)=""
 D CLEAR^VALM1
 D BMES^XPDUTL(.MSG)
 Q
 ;
GETDATA(DGMRI,DGMMRI) ; Define local variables and set into ^TMP($J
 S DGMR0=$G(^DIC(13,DGMRI,0))
 S DGMMRI=+$G(^DIC(13,DGMRI,"MASTER"))
 S DGMRST=+$G(^DIC(13,DGMRI,.02)),DGMRST=$S(DGMRST:"INACTIVE",1:"ACTIVE")
 S DGMMR0=$S($G(DGMMRI):$G(^DGMR(13.99,+DGMMRI,0)),1:"Not Mapped")
 I DGMMRI S $P(DGMMR0,"^",4)=DGMMRI
 S ^TMP($J,"DGMFR13",DGMR0,DGMRI,"MRE")=$G(DGMR0)
 S ^TMP($J,"DGMFR13",DGMR0,DGMRI,"MMRE")=$G(DGMMR0)
 Q
 ;
KILLTMP  ; Kill ^TMP global
 K ^TMP($J,"DGMFR13")
 Q

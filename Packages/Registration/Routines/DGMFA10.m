DGMFA10 ;DAL/JCH - NDS DEMOGRAPHICS RACE ASSOCIATION ;15-AUG-2017
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
EN  ; Allow users to populate the RACE MASTER field (#90) in RACE file (#10)
 D INFO        ; Display option info
 D KILLTMP     ; Kill ^TMP($J,"DGMFR10"
 N DGDONE      ; Signal from user - Q:DGDONE
 S DGDONE=0
 ; Prompt for RACE file (#10) entries until user quits
 F  Q:DGDONE  D
 .N DIE,DA,DR,DIC,X,Y,DIR,DUOUT,DGRACI,DGMISV
 .N DGRAC0,DGMRAC0,DGEMRACI,DGMDONE,DGESUM
 .; 
 .S DGRACI=$$GETRACE(.DGDONE) Q:DGDONE     ; Get Race IEN
 .; Get relevant info from 10 and 10.99, store in ^TMP($J
 .D GETDATA(DGRACI,.DGMISV)
 .; Use MRAC report to print RACE details
 .S DGSUM=2 D PRINRAC^DGMFR10(DGRACI)
 .;  
 .D UPDRACE(DGRACI)    ; Update Race file pointer to RACE MASTER (#10.99)
 .D GETDATA(DGRACI,.DGMRACI)    ; Get updated data
 .I $G(DGMRACI)'=$G(DGMISV) D REDISP(DGRACI)  ; RACE MASTER pointer changed, re-display updated info
 .;
 .S DIR(0)="EA",DIR("A",1)="",DIR("A",2)="",DIR("A")="Press Return to continue " D ^DIR
 .D INFO
 D KILLTMP
 Q
 ;
GETRACE(DGDONE)  ; Prompt for race file (#10) entry
 N DIC,X,Y
 S DIC=10,DIC(0)="QEAMZ"
 F  Q:$G(Y)>0!$G(DGDONE)  D
 .W ! D ^DIC I $G(DUOUT)!$G(DTOUT)!($G(Y)<0) S DGDONE=1 Q  ; Nothing selected, quit
 .N DGONAM
 .S DGONAM=$P($G(^DIC(10,+Y,0)),"^")
 .Q:'$D(^DGRAM(10.99,"AC",DGONAM))
 .; Use MRAC report to print RACE details
 .D GETDATA(+Y)
 .S DGSUM=2 D PRINRAC^DGMFR10(+Y)
 .W !!," * This entry has been associated to the RACE MASTER *",!," *  file by Standards & Terminology Services (STS)   *"
 .W !," *  and may only be updated via the Master File Server (MFS). *"
 .K Y
 S DGRACI=+$G(Y)
 Q DGRACI
 ;
UPDRACE(DGRACI)   ; Use DG RACM input template to restrict input to MRAC field
 S DIE="^DIC(10,"
 S DR="[DGMF ARACE]"
 S DA=DGRACI
 D ^DIE
 Q
 ;
REDISP(DGRACI)  ; Redisplay update RACE file (#10) entry
 W !!,"Update Successful...."
 S DGSUM=1 D PRINRAC^DGMFR10(DGRACI)   ; display summarized TOP entry info
 Q
 ;
INFO ; Display message, clear screen
 N MSG
 S MSG(1)="   This option allows RACE file entries to be"
 S MSG(2)="   associated with the RACE MASTER file to enhance "
 S MSG(3)="   interoperablity. The RACE MASTER file contains"
 S MSG(4)="   standard Health Level Seven (HL7) races."
 S MSG(5)=""
 D CLEAR^VALM1
 D BMES^XPDUTL(.MSG)
 Q
 ;
GETDATA(DGRACI,DGMRACI) ; Define local variables and set into ^TMP($J
 S DGRAC0=$G(^DIC(10,DGRACI,0))
 S DGMRACI=+$G(^DIC(10,DGRACI,"MASTER"))
 S DGRACST=+$G(^DIC(10,DGRACI,.02)),DGRACST=$S(DGRACST:"INACTIVE",1:"ACTIVE")
 S DGMRAC0=$S($G(DGMRACI):$G(^DGRAM(10.99,+DGMRACI,0)),1:"Not Mapped")
 I DGMRACI S $P(DGMRAC0,"^",4)=DGMRACI
 S ^TMP($J,"DGMFR10",DGRAC0,DGRACI,"RACE")=$G(DGRAC0)
 S ^TMP($J,"DGMFR10",DGRAC0,DGRACI,"MRACE")=$G(DGMRAC0)
 S ^TMP($J,"DGMFR10",DGRAC0,DGRACI,"STATUS")=DGRACST
 Q
 ;
KILLTMP  ; Kill ^TMP global
 K ^TMP($J,"DGMFR10")
 Q

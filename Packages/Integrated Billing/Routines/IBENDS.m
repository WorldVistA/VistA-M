IBENDS ;DAL/JCH - NDS PAYERS MTOP UTILITIES ;15-JUN-2017
 ;;2.0;INTEGRATED BILLING;**585**;21-MAR-94;Build 68
 ;
 Q
 ; 
 ; Available at Master Type of Plan Association [IBMTOP ASSN] option, at the following menu path:
 ;    Billing Supervisor Menu [IB BILLING SUPERVISOR MENU]
 ;      MCCR System Definition Menu [MCCR SYSTEM DEFINITION MENU]
 ;        Master Type of Plan Menu [IBMTOP MNU]
 ;          Master Type of Plan Association [IBMTOP ASSN]
 ;
EN  ; Allow users to populate the MASTER TYPE OF PLAN field (#15) in TYPE OF PLAN file (#355.1)
 D INFO,KILLTMP     ; Display option info, kill ^TMP($J,"IBENDS1"
 N IBDONE           ; Signal from user - Q:IBDONE
 N IBENAME          ; TOP Name
 S IBDONE=0
 ; Prompt for TYPE OF PLAN (#355.1) entries until user quits
 F  Q:IBDONE  D
 .N DIE,DA,DR,DIC,X,Y,DIR,DUOUT,IBETOPY,IBETOPI,IBTOPNAM,IBETOP0,IBEMTOP0,IBEMTOPI,IBESUM,IBEMISV
 .;
 .; Prompt for TOP
 .S IBETOPI=+$$GETOP(.IBTOPNAM,.IBDONE) Q:$G(IBDONE)
 .;
 .; Get relevant info from 355.1 and 355.9, store in ^TMP($J
 .D GETDATA($G(IBTOPNAM),IBETOPI)
 .S IBENAME=$P(IBETOP0,"^")
 .S IBEMISV=$G(IBEMTOPI)  ; Save associated master IEN, so we can check later if it's changed
 .;
 .; display Type of Plan record details, prompt for new MTOP pointer in TOP file
 .S IBESUM=2 D PRINTOP^IBENDS1(IBENAME,IBETOPI)
 .D UPDMTOP(IBETOPI) Q:$G(DUOUT)!$G(DTOUT)
 .D GETDATA($G(IBTOPNAM),IBETOPI)               ; Get updated TOP (#355.1) details
 .;
 .I $G(IBEMTOPI)'=$G(IBEMISV) D    ; MTOP pointer changed, re-display updated info
 ..D REDISP(IBENAME,IBETOPI)
 .;
 .S DIR(0)="EA",DIR("A",1)="",DIR("A",2)="",DIR("A")="Press Return to continue "
 .D ^DIR
 .D INFO
 D KILLTMP
 Q
 ;
INFO ; Display message, clear screen
 N MSG
 S MSG(1)="  This option allows VA TYPE OF PLAN file entries to be associated with"
 S MSG(2)="  MASTER TYPE OF PLAN file entries to enhance interoperability. MASTER"
 S MSG(3)="  TYPE OF PLAN file entries represent the Source of Payment Typology"
 S MSG(4)="  developed by the Public Health Data Standards Consortium (PHDSC)."
 S MSG(5)=""
 D CLEAR^VALM1
 D BMES^XPDUTL(.MSG)
 Q
 ;
GETOP(IBTOPNAM,IBDONE)  ; Prompt for Type of Plan
 N DIC
 S DIC=355.1
 S DIC(0)="QEAMZ"
 W ! D ^DIC I Y<0 S IBDONE=1,Y=""
 S IBTOPNAM=$P(Y,"^",2)
 Q +Y
 ;
UPDMTOP(IBMTOPI)  ; Update Master Type of Plan field (#90) in TOP file (#355.1)
 ; Use IB TOPM input template to restrict input to MTOP field
 N DIE,DR,DA
 S DIE="^IBE(355.1,"
 S DR="[IB TOPM]"
 S DA=IBETOPI
 D ^DIE
 Q
 ;
GETDATA(IBENAME,IBETOPI) ; Define local variables and set into ^TMP($J
 S IBETOP0=$G(^IBE(355.1,IBETOPI,0)),IBEMTOPI=$P(IBETOP0,"^",5)
 S IBTOPST=$P(IBETOP0,"^",4),IBTOPST=$S(IBTOPST:"INACTIVE",1:"ACTIVE")
 S IBEMTOP0=$S($G(IBEMTOPI):$G(^IBEMTOP(355.99,+IBEMTOPI,0)),1:"Not Mapped")
 I IBEMTOPI S $P(IBEMTOP0,"^",4)=IBEMTOPI
 S ^TMP($J,"IBENDS1",IBENAME,IBETOPI,"TOP")=$G(IBETOP0)
 S ^TMP($J,"IBENDS1",IBENAME,IBETOPI,"MTOP")=$G(IBEMTOP0)
 Q
 ;
REDISP(IBENAME,IBETOPI)  ; Redisplay updated Type of Plan (#355.1) entry
 W !!,"Update Successful...."
 S IBESUM=1 D PRINTOP^IBENDS1(IBENAME,IBETOPI)   ; display summarized TOP entry info
 Q
 ;
KILLTMP  ; Kill ^TMP global
 K ^TMP($J,"IBENDS1")
 Q

IBBSHDWN ;WOIFO/CLC - IB Sunset for PFSS ;7-JUN-2005
 ;;2.0;INTEGRATED BILLING;**312**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;********************************************************
 ; PURPOSE: Sunset IB Options/functionality
 ;        :
 ;        : *** The CHKSHDWN TAG is NOT currently being utilized **
 ;        : 
 ;
 ;   USAGE: PFSS - Patch(IB*2.0*312) routine
 ;
 ;*******************************************************************
 ; @INPUTS: SRC- The Source Routine, Used for Text Tags
 ;        : KEY- Identifier from Source Ex: AUTO BILLER
 ; @OUTPUTS: Boolean - True=Function Shutdown, False=Function is OK 
 ;*******************************************************************
CHKSHDWN(SRC,KEY) ;
 N SWINFO,I,ITEM,POP,RET,TAG
 S SWINFO=$$SWSTAT^IBBAPI()
 ;
 S (RET,POP)=0
 F I=1:1 S ITEM=$T(@SRC+I) Q:ITEM["%%%"  D  Q:POP
    .Q:$TR($P(ITEM,";",4)," ","")'=KEY
    .;
    .S TAG=$TR($P(ITEM,";",5)," ","")
    .I TAG="" S POP=1,RET=+SWINFO            ;No additional logic
    .;
    .D @TAG
 Q RET
IBAMTD ;
 ;;;CLAIMS TRACKING  ;        ; Disable Claims Tracking
 ;;;TRANSFER PRICING ;        ; Disable Transfer Pricing
 ;;;LTC CLOCK        ;        ; Disable LTC Clock Creation
 ;;;CHAMPVA          ;        ; Disable Co-Pay Chgs for ChampVA
 ;;;CONT HOSP PAT    ;        ; Disable Unflaf Cont Hosp Pats
 ;;;SPECIAL INPAT    ;        ; Disable Special Inpat Cases
 ;;;OBSERVATION COPAY;        ; Disable Observation Copay
 ;;;INPATIENT EVENTS ;        ; Disable Inpatient Event Charges
 ;;;%%%
IBAMTS ;
 ;;;TRANSFER PRICING ;        ; Disable Transfer Pricing
 ;;;LTC CLOCK        ;        ; Disable LTC Clock Co-pay
 ;;;OUTPAT MT COPAY  ;        ; Disable Out Pat MT Co-Pay
 ;;;%%%
IBAMTC ;
 ;;;CLAIMS TRACKING  ;        ; Disable Claims Tracking
 ;;;AUTO BILLER      ;ATOBILL ; Adjust Auto-Biller Logic
 ;;;TRANSFER PRICING ;        ; Disable Transfer Pricing
 ;;;%%%
 Q
 ;*******************************************************************
 ; @INPUTS: None
 ; @OUTPUTS: 1/0 1=User wants to continue, 0= DO Not continue
 ;*******************************************************************
PFSSWARN() ;
 N DIR,DIRUT,DTOUT,X,Y,IBSTAR,IBSWINFO
 S IBSTAR80="",$P(IBSTAR,"*",55)="",Y=1
 S IBSWINFO=$$SWSTAT^IBBAPI() G:'+IBSWINFO WARNQ
 D HOME^%ZIS  W @IOF
 S DIR(0)="YAO",DIR("B")="N"
 S DIR("A",1)=IBSTAR,DIR("A",3)=""
 S DIR("A",2)="The PFSS Environment is active as of "_$$FMTE^XLFDT($P(IBSWINFO,"^",2))_"."
 S DIR("A",4)="The action you are trying to perform may not be valid"
 S DIR("A",5)="for services provided on or after this date."
 S DIR("A",6)=IBSTAR
 S DIR("A")="Are you SURE you want to continue? "
 D ^DIR
 I $D(DIRUT)!$D(DTOUT) S Y=""
WARNQ Q Y
 ;*******************************************************************
 ; @INPUTS: Action = 1-ReInstate Option 0-(Default)-Set Out of Order
 ; @OUTPUTS: Mailman message indicating Invalid Options or Sucess...
 ;*******************************************************************
UPDOPTS(ACT) ;
 N SPC,I,OPT,DN,DA,DIC,DIE,DR,MSG,DETAIL
 S MSG="Option is unavailable with PFSS Active"
 S SPC="",$P(SPC," ",50)=""
 I $G(ACT)=1 S MSG="@"
 F I=1:1 S OPT=$T(OPTIONS+I) Q:OPT["%%%"  D
    .S DN=$P(OPT,";",4)
    .I '$D(^DIC(19,"B",DN)) S DETAIL(I)=$E(DN_SPC,1,30)_"Invalid Name" Q
    .;
    .; IA#1157 - Extrinsic functions to manage fields in OPTION file
    .D OUT^XPDMENU(DN,MSG)
 ;
 I '$D(DETAIL) S DETAIL(1)="All IB Sunset Options - Flagged:"_MSG
 D NOTIFY
 Q
UPDBTCEX(ACT) ;
 N DA,DIE,DR,DETAIL
 I $G(ACT)'=1 S ACT=0
 S DA=0
 F  S DA=$O(^IBE(350.9,1,51.17,DA)) Q:+DA=0  D
    .I ",1,2,3,4,"'[$P($G(^IBE(350.9,1,51.17,DA,0)),"^",1) Q
    .S DIE="^IBE(350.9,1,51.17,",DR=".02///"_ACT D ^DIE
 S DETAIL(1)="Batch Extracts Status Set to: "_ACT
 D NOTIFY
 Q
NOTIFY ;
 N XMDF,XMDUZ,XMSUB,XMDUN,XMTEXT,XMSTRIP,XMROU,XMY,XMZ,XMMG
 S XMDF="",XMDUZ="IBBSHDWN-"_$TR($P($$SITE^VASITE(),"^",2,3),"^","-")
 S XMY(DUZ)="",XMY("G.PATCHES")=""
 S XMSUB="IB-SUNSET OPTIONS"
 S XMTEXT="DETAIL("
 D ^XMD
 Q
OPTIONS ;
 ;;;IB FLAG CONTINUOUS PATIENTS
 ;;;IB MT CLOCK MAINTENANCE
 ;;;IB CLEAN AUTO BILLER LIST
 ;;;IB OUTPUT AUTO BILLER
 ;;;IB TRICARE DEL REJECT
 ;;;IB TRICARE REJECT
 ;;;IB TRICARE RESUBMIT
 ;;;IB TRICARE REVERSE
 ;;;IB TRICARE TRANSMISSION
 ;;;IBAEC LTC CLOCK EDIT
 ;;;IBCR ENTER TP NEG RATES
 ;;;IBCN INSURANCE BUFFER PROCESS
 ;;;IBCN MEDICARE INSURANCE INTAKE
 ;;;IBCNE AUTO MATCH BUFFER
 ;;;IBCNE AUTO MATCH ENTER/EDIT
 ;;;IBT EDIT HR REVIEWS TO DO
 ;;;IBT EDIT HR TRACKING ENTRY
 ;;;IBT EDIT REVIEWS
 ;;;IB PURGE BILLING DATA
 ;;;IB PURGE DELETE TEMPLATE ENTRY
 ;;;IB PURGE LIST LOG ENTRIES
 ;;;IB PURGE LIST TEMPLATE ENTRIES
 ;;;IB PURGE LOG INQUIRY
 ;;;IB PURGE/ARCHIVE BILLING DATA
 ;;;IB PURGE/FIND BILLING DATA
 ;;;IBCNE PURGE IIV DATA
 ;;;IBAT EXCEL REPORT
 ;;;IBAT INPT PROSTHETIC ITEMS
 ;;;IBAT PATIENT LIST
 ;;;IBAT PATIENT REPORT
 ;;;IBAT SUMMARY REPORT
 ;;;IBAT TP MANAGEMENT
 ;;;IBAT WORKLOAD REPORT
 ;;;IBCI CLAIMSMANAGER NPT FILE
 ;;;IBCI CLAIMSMANAGER PAYOR FILE
 ;;;IBT RE-GEN AVE BILL AMOUNT
 ;;;IBT RE-GEN UNBILLED REPORT
 ;;;IBT SEND TEST UNBILLED MESS
 ;;;IBT VIEW UNBILLED AMOUNTS
 ;;;IBJD UTILIZATION WORKLOAD
 ;;;IBT MONTHLY AUTO GEN AVE BILL
 ;;;IBT MONTHLY AUTO GEN UNBILLED
 ;;;IB MRA EXTRACT
 ;;%%%
 Q
 Q

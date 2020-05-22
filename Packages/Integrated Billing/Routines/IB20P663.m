IB20P663 ;/Albany - IB*2.0*663 POST INSTALL;07/25/19 2:10pm
 ;;2.0;Integrated Billing;**663**;Mar 20, 1995;Build 27
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
POSTINIT ;Post Install for IB*2.0*663
 D BMES^XPDUTL(" >>  Starting the Post-Initialization routine for IB*2.0*663")
 ; Adding AR CATEGORIES and REVENUE SOURCE CODES
 ;D QUEUEINT
 D INITUCDB  ; Load initial data into Visit tracking DB
 D NEWCREAS  ; Add more UC reason codes.
 D IBUPD     ; Inactivate CHOICE and CC MTF Action Types
 D TSKPUSH  ; add the nightly task
 D BMES^XPDUTL(" >>  End of the Post-Initialization routine for IB*2.0*663")
 Q
 ;
QUEUEINT ; Run the UC Visit DB initialization in the background.
 ;
 N ZTRTN,ZTDTH,ZTDESC,ZTIO,ZTSK
 ;
 ; Set up the other TaskManager variables
 S ZTRTN="INITUCDB^IB20P663"
 S ZTDTH=$$NOW^XLFDT
 S ZTDESC="IB*2.0*663 Initialize File 351.82 - Urgent Care Visit Tracking DB"
 S ZTIO=""
 D ^%ZTLOAD    ; Call TaskManager
 D BMES^XPDUTL(" >>  Task "_ZTSK_" started to update the Urgent Care Visit Tracking DB")
 Q
 ;
INITUCDB   ; Loop through the Copay file (350) to find any Urgent Care visits and update the UC database 
 ;
 N LOOP,FDA,FDAIEN,IBUCIEN1,IBUCIEN2,IBQUIT,IBN,IBDATA,IBDFN,IBVST,IBERR1,IBERR2
 N IBVSTIEN,IBSTAT,IBBILL,IBBLST,IBREAS,IBLSDTA,IBSITE,IBUCIEN3,IBUCIEN4
 N X,Y,DIE,DA,DR,DLAYGO,DIC,DINUM
 ;
 ; Check to see if previously installed.  If so, exit with message.
 I $O(^IBUC(351.82,0))]"" D  Q
 .  D BMES^XPDUTL(" >>  Urgent Care Visit Tracking Database present.  Initialization not tasked.")
 ;
 ;Looping through initially for adds
 S IBUCIEN1=$O(^IBE(350.1,"B","CC URGENT CARE (OPT) NEW",""))
 S IBUCIEN2=$O(^IBE(350.1,"B","DG FEE SERVICE (OPT) NEW",""))
 S IBUCIEN3=$O(^IBE(350.1,"B","CC URGENT CARE (OPT) CANCEL",""))
 S IBUCIEN4=$O(^IBE(350.1,"B","DG FEE SERVICE (OPT) CANCEL",""))
 S IBERR1=$O(^IBE(350.3,"B","UC - ENTERED IN ERROR",""))
 S IBERR2=$O(^IBE(350.3,"B","UC - DUPLICATE VISIT",""))
 D SITE^IBAUTL    ;Defines variable IBSITE
 ;
 S IBQUIT=0
 ;
 ;Initialize process tracking array in case initialization stops
 N X,X2,X1,DT
 S DT=$$DT^XLFDT,X1=DT,X2=30 D C^%DTC
 S ^XTMP("IB20P663",0)=X_U_DT_U_"IB*2.0*663 Post install Urgent Care Visit Tracking Initialization"
 ;
 F LOOP=IBUCIEN1,IBUCIEN2,IBUCIEN3,IBUCIEN4 D  Q:IBQUIT
 . ;
 . S IBN=0
 . ;
 . ;See if the initialization was halted. If so, restore loop variables to last entry processed.
 . I $D(^XTMP("IB20P663",1)) S IBLSDTA=$G(^XTMP("IB20P663",1)),LOOP=$P(IBLSDTA,U),IBN=$P(IBLSDTA,U,2)
 . ;
 . F  S IBN=$O(^IB("AE",LOOP,IBN)) Q:'IBN  D
 . . S IBDATA=$G(^IB(IBN,0))     ; Get the data
 . . Q:IBDATA=""
 . . S IBDFN=$P(IBDATA,U,2),IBVST=$P(IBDATA,U,14),IBVSTIEN=0
 . . Q:IBVST<3190606             ;Do not count UC visits prior to the start of the UC program on 6/6/2019
 . . S IBVSTIEN=$$DBCHK(IBDFN,IBVST)
 . . I ((LOOP=IBUCIEN1)!(LOOP=IBUCIEN2)),+IBVSTIEN Q    ;don't process if visit already in DB and adding a new paid visit
 . . S IBSTAT=2,(IBBILL,IBREAS)=""   ;init variables
 . . S IBBLST=$P(IBDATA,U,5)    ; Get the bill status
 . . ;If Bill cancelled because UC entered in error, then set status to not counted, reason to Entered In Error.
 . . I IBBLST=10 D
 . . . I ($P(IBDATA,U,10)=IBERR1) S IBSTAT=3,IBREAS=3    ;UC-ENTERED IN ERROR
 . . . I ($P(IBDATA,U,10)=IBERR2) S IBSTAT=3,IBREAS=4    ;UC-DUPLICATE EVENT
 . . S:IBBLST'=10 IBBILL=$P(IBDATA,U,11)   ;Billing Number
 . . I (IBBLST=8),(IBBILL="") S IBBILL="ON HOLD"
 . . I (LOOP=IBUCIEN2),($P(IBDATA,U,7)'=30) Q    ;Captures all of the DG FEE NEW entries from 6/6/2019 to install of IB*2.0*656
 . . I (LOOP=IBUCIEN4),($P(IBDATA,U,7)'=30) Q    ;Captures all of the DG FEE CANCEL entries from 6/6/2019 to install of IB*2.0*656
 . . ;Add new entry to the tracking database
 . . I (IBVSTIEN=0) D  Q
 . . . K FDA
 . . . ;Store in array for adding to the file (#351.82)
 . . . S FDA(351.82,"+1,",.01)=IBDFN    ;Patient
 . . . S FDA(351.82,"+1,",.02)=IBSITE   ;Site
 . . . S FDA(351.82,"+1,",.03)=IBVST    ;Visit Date
 . . . S FDA(351.82,"+1,",.04)=IBSTAT   ;Status (2 - Billed or 3- Not Counted)
 . . . S FDA(351.82,"+1,",1.01)=1       ;Status (2 - Billed or 3- Not Counted)
 . . . S:$G(IBBILL)'="" FDA(351.82,"+1,",.05)=IBBILL
 . . . S:$G(IBREAS)'="" FDA(351.82,"+1,",.06)=IBREAS   ;Reason (Not counted)
 . . . S FDA(351.82,"+1,",1.01)=1
 . . . ;Add to the file.
 . . . D UPDATE^DIE(,"FDA","FDAIEN")
 . . . S FDAIEN=FDAIEN(1) K FDAIEN(1)
 . . ;
 . . ;Otherwise Taking a canceled visit and updating the reason, bill no, and status fields
 . . I IBVSTIEN'=0 D
 . . . S DLAYGO=351.82,DIC="^IBUC(351.82,",DIC(0)="L"
 . . . I '+$G(IBVSTIEN) D FILE^DICN S LIEN=+IBVSTIEN K DIC,DINUM,DLAYGO
 . . . S DR=".04////"_IBSTAT      ; Visit Tracking Status
 . . . S DR=DR_";.05////"_IBBILL  ; Bill Number (should reset to NULL)
 . . . S DR=DR_";.06////"_IBREAS  ; Reason (should be UC-ENTERED IN ERROR or UC-Duplicate Event)
 . . . S DR=DR_";1.01////1"       ; Flag for multi-site transmission
 . . . ;
 . . . S DIE="^IBE(350.3,",DA=IBVSTIEN
 . . . D ^DIE
 . . ;Save the entry just processed
 . . S ^XTMP("IB20P663",1)=LOOP_U_IBN
 . . I $$S^%ZTLOAD() D  Q
 . . . ;
 . . . N ZTRTN,ZTDTH,ZTDESC,ZTIO
 . . . ;
 . . . ;requeue for later
 . . . S ZTRTN="INITUCDB^IB20P663"
 . . . S ZTDTH=$$NOW^XLFDT+.01    ; reschedule for 1 hr after time process stopped
 . . . S ZTDESC="IB*2.0*663 Initialize File 351.82 - Urgent Care Visit Tracking DB"
 . . . S ZTIO=""
 . . . D ^%ZTLOAD    ; Call TaskManager
 . . . S IBQUIT=1
 K DR   ;Clear update array before next use
 Q
 ; 
NEWCREAS ; New Cancellation Reasons
 N LOOP,LIEN,IBDATA,IBCNNM
 N X,Y,DIE,DA,DR,DTOUT,DATA,IBDATAB,DIK
 ;
 N CANIEN,UPDIEN,SVCIEN,CHGIEN
 ;
 ; Grab all of the entries to update
 D MES^XPDUTL("     -> Adding new Cancellation Reasons to the IB CHARGE REMOVE REASON file (350.3).")
 S Y=-1
 F LOOP=1:1 S IBDATA=$T(REASDAT+LOOP) Q:$P(IBDATA,";",3)="END"  D
 . S DR=""
 . ;Extract the new ACTION TYPE to be added.
 . ;Store in array for adding to the file (#350.1).
 . Q:IBDATA=""    ;go to next entry if Category is not to be updated.
 . ;
 . S IBCNNM=$P(IBDATA,";",3)
 . S LIEN=$O(^IBE(350.3,"B",IBCNNM,""))
 . ; File the update along with inactivate the ACTION TYPE
 . S DLAYGO=350.3,DIC="^IBE(350.3,",DIC(0)="L",X=IBCNNM
 . I '+LIEN D FILE^DICN S LIEN=+Y K DIC,DINUM,DLAYGO
 . S DR=".02////"_$P(IBDATA,";",4)   ; ABBREVIATION
 . S DR=DR_";.03////"_$P(IBDATA,";",5)  ; LIMIT
 . ;
 . S DIE="^IBE(350.3,",DA=LIEN
 . D ^DIE
 . ;re-index new entry here
 . S DA=LIEN,DIK="^IBE(350.3," D IX^DIK
 . K DR
 Q
 ;
 ;350.3,.01    3 NAME                   0;1 FREE TEXT (Required)
 ;350.3,.02    4 ABBREVIATION           0;2 FREE TEXT
 ;350.3,.03    5 LIMIT                  0;3 Code (3 - Generic)
 ;
REASDAT ; Fee Service to inactivate
 ;;UC - DUPLICATE VISIT;UCDUP;3
 ;;UC - SEQUENCE UPDATE;UCSEQ;3
 ;;END
 Q
 ;
DBCHK(IBDFN,IBVDT) ; Check to see if the visit is already in the DB.
 ; 
 N IBLP,IBQUIT,IBDATA,IBDT
 ; Returns IBQUIT - the IEN of the Visit OR 0
 ;loop through the patient's visits to see if it has already been recorded.
 S IBLP=0,IBQUIT=0
 F  S IBLP=$O(^IBUC(351.82,"B",IBDFN,IBLP)) Q:'IBLP  D  Q:IBQUIT
 .  S IBDATA=$G(^IBUC(351.82,IBLP,0))
 .  S IBDT=$P(IBDATA,U,3)
 .  ; quit if there is a visit already stored on that day.
 .  I IBDT=IBVDT S IBQUIT=IBLP
 Q IBQUIT
 ;
IBUPD ; Inactivate FEE Service Entries
 ;
 N LOOP,LIEN,IBDATA
 N X,Y,DIE,DA,DR,DTOUT,DATA
 ;
 ; Grab all of the entries to update
 F LOOP=1:1:36 D
 . ;Extract the new ACTION TYPE to be added.
 . S IBDATA=$T(IBDDAT+LOOP)
 . S IBDATA=$P(IBDATA,";;",2)
 . ;Store in array for adding to the file (#350.1).
 . Q:IBDATA=""    ;go to next entry if Category is not to be updated.
 . S LIEN=$O(^IBE(350.1,"B",IBDATA,""))  ; find ACTION TYPE entry 
 . Q:LIEN=""
 . ;
 . ; File the update along with inactivate the ACTION TYPE
 . S DR=".12////1;"
 . S DIE="^IBE(350.1,",DA=LIEN
 . D ^DIE
 . K DR   ;Clear update array before next use
 ;
 S DR=""
 D MES^XPDUTL("     -> Data CHOICE and CC MTF Action Types in the ACTION TYPE file (#350.1) inactiavated.")
 Q
 ;
IBDDAT ; Fee Service to inactivate
 ;;CC MTF (INPT) CANCEL
 ;;CC MTF (INPT) NEW
 ;;CC MTF (INPT) UPDATE
 ;;CC MTF (OPT) CANCEL
 ;;CC MTF (OPT) NEW
 ;;CC MTF (OPT) UPDATE
 ;;CC MTF (PER DIEM) CANCEL
 ;;CC MTF (PER DIEM) NEW
 ;;CC MTF (PER DIEM) UPDATE
 ;;CC MTF (RX) CANCEL
 ;;CC MTF (RX) NEW
 ;;CC MTF (RX) UPDATE
 ;;LTC CHOICE INPT CNH CANCEL
 ;;LTC CHOICE INPT CNH NEW
 ;;LTC CHOICE INPT CNH UPDATE
 ;;LTC CHOICE INPT RESPITE CANCEL
 ;;LTC CHOICE INPT RESPITE NEW
 ;;LTC CHOICE INPT RESPITE UPDATE
 ;;LTC CHOICE OPT ADHC CANCEL
 ;;LTC CHOICE OPT ADHC NEW
 ;;LTC CHOICE OPT ADHC UPDATE
 ;;LTC CHOICE OPT RESPITE CANCEL
 ;;LTC CHOICE OPT RESPITE NEW
 ;;LTC CHOICE OPT RESPITE UPDATE
 ;;CHOICE (INPT) CANCEL
 ;;CHOICE (INPT) NEW
 ;;CHOICE (INPT) UPDATE
 ;;CHOICE (OPT) CANCEL
 ;;CHOICE (OPT) NEW
 ;;CHOICE (OPT) UPDATE
 ;;CHOICE (PER DIEM) CANCEL
 ;;CHOICE (PER DIEM) NEW
 ;;CHOICE (PER DIEM) UPDATE
 ;;CHOICE (RX) CANCEL
 ;;CHOICE (RX) NEW
 ;;CHOICE (RX) UPDATE
 ;;END
 ;
 ;
TSKPUSH ; task the  routine as a Night Job using TaskMan.
 ;
 N DIC,DLAYGO,TSTAMP,X,Y
 D MES^XPDUTL("Tasking Nightly Copay Synch ... ")
 ;
 I $$FIND1^DIC(19.2,,"B","IBUC MULTI FAC COPAY SYNCH","B") D MES^XPDUTL(" Already scheduled") Q  ; don't overwrite existing schedule
 S (DLAYGO,DIC)=19.2,DIC(0)="L"
 S X="IBUC MUTLI FAC COPAY SYNCH"
 S TSTAMP=$$FMADD^XLFDT($$NOW^XLFDT(),1),$P(TSTAMP,".",2)="0200"
 S DIC("DR")="2////"_TSTAMP_";6////D@2AM"
 D ^DIC
 Q

IB20P669 ;/Albany - IB*2.0*669 POST INSTALL;03/10/20 2:10pm
 ;;2.0;Integrated Billing;**669**;Mar 20, 1995;Build 20
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
POSTINIT ;Post Install for IB*2.0*669
 D BMES^XPDUTL(" >>  Starting the Post-Initialization routine for IB*2.0*669")
 ; Adding AR CATEGORIES and REVENUE SOURCE CODES
 D QUEUEINT
 ;D INITUCDB  ; Load initial data into Visit tracking DB
 D NEWCREAS
 D CANCLUC
 D BMES^XPDUTL(" >>  End of the Post-Initialization routine for IB*2.0*669")
 Q
 ;
QUEUEINT ; Run the UC Visit DB initialization in the background.
 ;
 N ZTRTN,ZTDTH,ZTDESC,ZTIO,ZTSK
 ;
 ; Set up the other TaskManager variables
 S ZTRTN="INITUCDB^IB20P669"
 S ZTDTH=$$NOW^XLFDT
 S ZTDESC="IB*2.0*669 Initialize/Update File 351.82 - Urgent Care Visit Tracking DB"
 S ZTIO=""
 D ^%ZTLOAD    ; Call TaskManager
 D BMES^XPDUTL(" >>  Task "_ZTSK_" started to update the Urgent Care Visit Tracking DB")
 Q
 ;
INITUCDB   ; Loop through the Copay file (350) to find any Urgent Care visits and update the UC database 
 ;
 N LOOP,FDA,FDAIEN,IBUCIEN1,IBUCIEN3,IBUCIEN4,IBQUIT,IBN,IBDATA,IBDFN,IBVST
 N IBERR1,IBERR2,IBERR3,IBERR4,IBERR5,IBERR6
 N IBVSTIEN,IBSTAT,IBBILL,IBBLST,IBREAS,IBLSDTA,IBSITE,IBCREAS
 N X,Y,DIE,DA,DR,DLAYGO,DIC,DINUM
 ;
 ; Check to see if previously installed.  If so, exit with message.
 ;I $O(^IBUC(351.82,0))]"" D  Q
 ;.  D BMES^XPDUTL(" >>  Urgent Care Visit Tracking Database present.  Initialization not tasked.")
 ;
 ;Looping through initially for adds
 S IBUCIEN1=$O(^IBE(350.1,"B","CC URGENT CARE (OPT) NEW",""))
 S IBUCIEN3=$O(^IBE(350.1,"B","CC URGENT CARE (OPT) CANCEL",""))
 S IBUCIEN4=$O(^IBE(350.1,"B","DG FEE SERVICE (OPT) CANCEL",""))
 S IBERR1=$O(^IBE(350.3,"B","UC - ENTERED IN ERROR",""))       ;Skip
 S IBERR2=$O(^IBE(350.3,"B","UC - DUPLICATE VISIT",""))        ;Skip
 S IBERR3=$O(^IBE(350.3,"B","ENTERED IN ERROR",""))            ;Removed    Entered in Error
 S IBERR4=$O(^IBE(350.3,"B","CATASTROPHICALLY DISABLED",""))  ;Free if <3   MISSION Act otherwise Visit Only No Copay
 S IBERR5=$O(^IBE(350.3,"B","COMBAT VETERAN",""))             ;Free if <3   MISSION Act otherwise Visit Only No Copay
 S IBERR6=$O(^IBE(350.3,"B","PURPLE HEART CONFIRMED",""))     ;Free if <3   MISSION Act otherwise Visit Only No Copay
 D SITE^IBAUTL    ;Defines variable IBSITE
 ;
 S IBQUIT=0
 ;
 ;Initialize process tracking array in case initialization stops
 N X,X2,X1,DT
 S DT=$$DT^XLFDT,X1=DT,X2=30 D C^%DTC
 S ^XTMP("IB20P669",0)=X_U_DT_U_"IB*2.0*669 Post install Urgent Care Visit Tracking Initialization"
 ;
 F LOOP=IBUCIEN1,IBUCIEN3,IBUCIEN4 D  Q:IBQUIT
 . ;
 . S IBN=0
 . ;
 . ;See if the initialization was halted. If so, restore loop variables to last entry processed.
 . I $D(^XTMP("IB20P669",1)) S IBLSDTA=$G(^XTMP("IB20P669",1)),LOOP=$P(IBLSDTA,U),IBN=$P(IBLSDTA,U,2)
 . ;
 . F  S IBN=$O(^IB("AE",LOOP,IBN)) Q:'IBN  D
 . . S IBDATA=$G(^IB(IBN,0))     ; Get the data
 . . Q:IBDATA=""
 . . S IBDFN=$P(IBDATA,U,2),IBVST=$P(IBDATA,U,14),IBVSTIEN=0
 . . Q:IBVST<3190606             ;Do not count UC visits prior to the start of the UC program on 6/6/2019
 . . S IBVSTIEN=$$DBCHK(IBDFN,IBVST)
 . . S IBSTAT=4,IBREAS=5,IBBILL="@"   ;init variables
 . . S IBBLST=$P(IBDATA,U,5)         ; Get the bill status
 . . I (LOOP=IBUCIEN4),($P(IBDATA,U,7)'=30) Q    ;Captures all of the DG FEE CANCEL entries from 6/6/2019 to install of IB*2.0*656
 . . S IBCREAS=$P(IBDATA,U,10),IBBLST=$P(IBDATA,U,5)
 . . I (IBBLST'=10),(LOOP=IBUCIEN1),+IBVSTIEN Q    ;don't process if visit already in DB and adding a new paid visit
 . . I IBBLST'=10 D
 . . . S IBSTAT=1,IBREAS=""
 . . . S IBBILL=$P(IBDATA,U,11)   ;Billing Number
 . . . I (IBBLST=8),(IBBILL="") S IBBILL="ON HOLD"
 . . I IBBLST=10 D
 . . . I (IBCREAS=IBERR3) S IBSTAT=3,IBREAS=3    ;Set Visit to Removed/Entered in Error
 . . . ; If Cat Disabled, Purple Heart, or Combat Vet Cancel Reason is used, check for free visits.  If any free visits available, set the visit to free
 . . . I (IBCREAS=IBERR4)!(IBCREAS=IBERR5)!(IBCREAS=IBERR6),$$GETELGP^IBECEA36(IBDFN,IBVST) D
 . . . . S IBNOVST=$$GETVST^IBECEA36(IBDFN,IBVST)
 . . . . I $P(IBNOVST,U,2)<3 S IBSTAT=1,IBREAS=1    ;Potential Free visits
 . . ;Add new entry to the tracking database
 . . I (IBVSTIEN=0) D  Q
 . . . K FDA
 . . . ;Store in array for adding to the file (#351.82)
 . . . S FDA(351.82,"+1,",.01)=IBDFN    ;Patient
 . . . S FDA(351.82,"+1,",.02)=IBSITE   ;Site
 . . . S FDA(351.82,"+1,",.03)=IBVST    ;Visit Date
 . . . S FDA(351.82,"+1,",.04)=IBSTAT   ;Status (2 - Billed or 3- Not Counted)
 . . . S FDA(351.82,"+1,",.05)=IBBILL   ;Status (2 - Billed or 3- Not Counted)
 . . . S FDA(351.82,"+1,",1.01)=1       ;Status (2 - Billed or 3- Not Counted)
 . . . S:$G(IBREAS)'="" FDA(351.82,"+1,",.06)=IBREAS   ;Reason (Not counted)
 . . . S FDA(351.82,"+1,",1.01)=1
 . . . ;Add to the file.
 . . . D UPDATE^DIE(,"FDA","FDAIEN")
 . . . S FDAIEN=FDAIEN(1) K FDAIEN(1)
 . . ;
 . . ;Otherwise Taking a canceled visit and updating the reason, bill no, and status fields
 . . I IBVSTIEN'=0 D
 . . . ;S DLAYGO=351.82,DIC="^IBUC(351.82,",DIC(0)="L"
 . . . ;I '+$G(IBVSTIEN) D FILE^DICN S LIEN=+IBVSTIEN K DIC,DINUM,DLAYGO
 . . . S DR=".04////"_IBSTAT      ; Visit Tracking Status
 . . . S DR=DR_";.05////"_IBBILL  ; Bill Number (should reset to NULL)
 . . . S DR=DR_";.06////"_IBREAS  ; Reason (should be UC-ENTERED IN ERROR or UC-Duplicate Event)
 . . . S DR=DR_";1.01////1"       ; Flag for multi-site transmission
 . . . ;
 . . . S DIE="^IBUC(351.82,",DA=IBVSTIEN
 . . . D ^DIE
 . . . K DR
 . . ;Save the entry just processed
 . . S ^XTMP("IB20P669",1)=LOOP_U_IBN
 . . I $$S^%ZTLOAD() D  Q
 . . . ;
 . . . N ZTRTN,ZTDTH,ZTDESC,ZTIO
 . . . ;
 . . . ;requeue for later
 . . . S ZTRTN="INITUCDB^IB20P669"
 . . . S ZTDTH=$$NOW^XLFDT+.01    ; reschedule for 1 hr after time process stopped
 . . . S ZTDESC="IB*2.0*669 Initialize File 351.82 - Urgent Care Visit Tracking DB"
 . . . S ZTIO=""
 . . . D ^%ZTLOAD    ; Call TaskManager
 . . . S IBQUIT=1
 K DR   ;Clear update array before next use
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
CANCLUC ; Initialize the new CAN CANCEL URGENT CARE field (.04) in the IB CHARGE REMOVE REASON file (#350.3).
 ;  Also inactivate UC-ENTERED IN ERROR AND UC-CHANGE IN ELIGIBILITY
 ;  Also define the type of UC Visit Tracking DB (351.82) update process to follow when using the cancellation
 ;
 N LOOP,LIEN,IBDATA,IBCCUC,IBINACT,IBNM,IBNOVST,IBUCDB
 N X,Y,DIE,DA,DR,DTOUT,DATA
 ;
 D MES^XPDUTL("     -> Update of the new IB CHARGE REMOVE REASON fields started.")
 ; Grab all of the entries to update
 F LOOP=1:1:14 D
 . ;Extract the new ACTION TYPE to be added.
 . S IBDATA=$T(IBDDAT+LOOP)
 . S IBDATA=$P(IBDATA,";;",2)
 . S IBNM=$P(IBDATA,";",1),IBCCUC=$P(IBDATA,";",2),IBUCDB=$P(IBDATA,";",3),IBINACT=$P(IBDATA,";",4)
 . S LIEN=$O(^IBE(350.3,"B",IBNM,""))  ; find CHARGE REMOVE REASON entry 
 . Q:LIEN=""
 . ;
 . ; File the update along with inactivate the ACTION TYPE
 . S DR=".04///"_IBCCUC
 . S DR=DR_";.05///"_IBUCDB
 . S:IBINACT'="" DR=DR_";.06///"_IBINACT
 . S DIE="^IBE(350.3,",DA=LIEN
 . D ^DIE
 . K DR   ;Clear update array before next use
 ;
 S DR=""
 D MES^XPDUTL("     -> Update of IB CHARGE REMOVE REASON completed.")
 Q
 ;
IBDDAT ; Cancellation reasons (350.3) to update
 ;;ENTERED IN ERROR;Y;1
 ;;PATIENT DECEASED;Y;2
 ;;CHANGE IN ELIGIBILITY;Y;3
 ;;RECD INPATIENT CARE;Y;2
 ;;PURPLE HEART CONFIRMED;N;3
 ;;BILLED AT HIGHER TIER RATE;Y;2
 ;;BILLED LTC CHARGE;Y;2
 ;;COMBAT VETERAN;N;3
 ;;CATASTROPHICALLY DISABLED;N;3
 ;;UC - ENTERED IN ERROR;Y;1;Y
 ;;UC - CHANGE IN ELIGIBILITY;Y;3;Y
 ;;UC - DUPLICATE VISIT;Y;4
 ;;UC - SEQUENCE UPDATE;Y;3
 ;;UC - PG6 REVIEWED;Y;3
 ;;END
 ;
NEWCREAS ; New Cancellation Reasons
 N LOOP,LIEN,IBDATA,IBCNNM
 N X,Y,DIE,DA,DR,DTOUT,DATA,IBDATAB
 ; 
 N CANIEN,UPDIEN,SVCIEN,CHGIEN
 ;
 ; Grab all of the entries to update
 D MES^XPDUTL("     -> Adding new Cancellation Reason to the IB CHARGE REMOVE REASON file (350.3).")
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
 . ;<re-index new entry here>
 . S DA=LIEN,DIK="^IBE(350.3," D IX^DIK
 . K DR
 Q
 ;
REASDAT ; Fee Service to inactivate
 ;;UC - PG6 REVIEWED;UCPG6;3
 ;;END
 Q

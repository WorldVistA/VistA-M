IBY320PO ;ALB/ESG - Post Install for IB patch 320 ;28-JUL-2005
 ;;2.0;INTEGRATED BILLING;**320**;21-MAR-94
 ;
EN ;
 N XPDIDTOT S XPDIDTOT=9
 D TWOQ         ; 1. get rid of 2Q status messages on CSA
 D RCB          ; 2. change one EDI menu mnemonic
 D ATD          ; 3. create regular style x-ref for file 361.4
 D MCRWNR       ; 4. create 2 new entries in file 355.92 for Medicare
 D TRIGGERS     ; 5. Trigger defaults in 36 and 355.93
 D IBEFTFLG     ; 6. Set flag in 355.9 for what kind of ID it is
 D AUNIQ        ; 7. create new style x-ref IBA(355.92,"AUNIQ")
 D F35597       ; 8. Update file 355.97
 D RIT          ; 9. Recompile input templates
 ;
EX ;
 Q
 ;
TWOQ ; Remove 2Q rejection messages from the current CSA screen
 NEW DATA,TXT,DO,DA,DIC,X,Y,IBRS,IEN
 D BMES^XPDUTL(" STEP 1 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Removing 2Q rejection messages from the CSA screen ....")
 F IBRS=0,1 S IEN=0 F  S IEN=$O(^IBM(361,"ACSA","R",IBRS,IEN)) Q:'IEN  D
 . I $G(^IBM(361,IEN,1,1,0))'["2Q  CLAIM REJECTED BY CLEARINGHOUSE" Q
 . S DIE=361,DA=IEN
 . ; Change the status message
 . ; .03 - informational; .09 - review complete; .14 - auto filed
 . ;  .1 - final review action (filed - no action)
 . S DR=".03////I;.09////2;.14////1;.1////F"
 . D ^DIE
 . Q
 ;
TWOQX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(1)
 Q
 ;
RCB ; Change the menu mnemonic on the EDI menu for RCB
 NEW MENUIEN,ITEMIEN,STOP,IBX,DIE,DA,DR
 D BMES^XPDUTL(" STEP 2 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Updating EDI menu mnemonics ....")
 ;
 S MENUIEN=$O(^DIC(19,"B","IBCE 837 EDI MENU",0)) I 'MENUIEN G RCBX
 S ITEMIEN=0,STOP=0
 F  S ITEMIEN=$O(^DIC(19,MENUIEN,10,ITEMIEN)) Q:'ITEMIEN  D  Q:STOP
 . S IBX=$P($G(^DIC(19,MENUIEN,10,ITEMIEN,0)),U,1) Q:'IBX
 . I $P($G(^DIC(19,IBX,0)),U,1)'="IBCE PREV TRANSMITTED CLAIMS" Q
 . S DIE="^DIC(19,"_MENUIEN_",10,"
 . S DA=ITEMIEN,DA(1)=MENUIEN
 . S DR="2////RCB;3////40"
 . D ^DIE
 . S STOP=1
 . Q
RCBX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(2)
 Q
 ;
ATD ; create ATD x-ref on file 361.4
 NEW IBIFN,DA,DIK
 D BMES^XPDUTL(" STEP 3 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Creating 'ATD' x-ref for File 361.4 ....")
 KILL ^IBM(361.4,"ATD")
 S IBIFN=0
 F  S IBIFN=$O(^IBM(361.4,IBIFN)) Q:'IBIFN  D
 . S DA(1)=IBIFN
 . S DIK="^IBM(361.4,"_DA(1)_",1,"
 . S DIK(1)=".01^ATD"
 . D ENALL^DIK
 . Q
ATDX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(3)
 Q
 ;
MCRWNR ; Medicare (WNR) clean up file 355.92 entries and add 2 new entries
 NEW DA,DIK,INSCO,MCRWNR,DO,DIC,X,Y,DFN,OK,IBIFN,BPID,DIE,DR
 D BMES^XPDUTL(" STEP 4 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Updating Billing Provider IDs for MEDICARE (WNR) ....")
 ;
 ; First, find the MEDICARE (WNR) ins co ien
 S INSCO=0
 F  S INSCO=$O(^DIC(36,"B","MEDICARE (WNR)",INSCO)) Q:'INSCO  D
 . I $$MCRWNR^IBEFUNC(INSCO) S MCRWNR(INSCO)="" Q
 . D MES^XPDUTL("ERROR: Insurance company on file named 'MEDICARE (WNR)' incorrectly set-up.")
 . Q
 ;
 I '$D(MCRWNR) D MES^XPDUTL("ERROR: Insurance company 'MEDICARE (WNR)' not found.") G MCRX
 ;
 I $O(MCRWNR(""))'=$O(MCRWNR(""),-1) D MES^XPDUTL("ERROR: Multiple insurance companies named 'MEDICARE (WNR)' found.")
 ;
 ; Next, get rid of any entries in this file for Medicare (clean-up)
 S INSCO=0,DIK="^IBA(355.92,"
 F  S INSCO=$O(MCRWNR(INSCO)) Q:'INSCO  D
 . S DA=0
 . F  S DA=$O(^IBA(355.92,"B",INSCO,DA)) Q:'DA  D ^DIK
 . Q
 ;
 ; Next, add 2 entries for each Medicare (wnr) (should only be one)
 S INSCO=0
 F  S INSCO=$O(MCRWNR(INSCO)) Q:'INSCO  D
 . K DO
 . S DIC="^IBA(355.92,",DIC(0)="",X=INSCO
 . S DIC("DR")=".04///1;.06///MEDICARE PART A;.07///670899;.08///E"
 . D FILE^DICN
 . K DO
 . S DIC="^IBA(355.92,",DIC(0)="",X=INSCO
 . S DIC("DR")=".04///2;.06///MEDICARE PART B;.07///VA0"_$P($$SITE^VASITE,U,3)_";.08///E"
 . D FILE^DICN
 . Q
 ;
 ; Correct billing provider secondary IDs for Medicare (current ins only)
 S DFN=0
 ; "AOP" x-ref lists bills by patient with claim status 1 or 2
 F  S DFN=$O(^DGCR(399,"AOP",DFN)) Q:'DFN  D
 . S INSCO=0,OK=0
 . F  S INSCO=$O(MCRWNR(INSCO)) Q:'INSCO  I $D(^DGCR(399,"AE",DFN,INSCO)) S OK=1 Q
 . ; OK=1: claims exist for this patient in which MCRWNR is curr ins
 . I 'OK Q
 . S IBIFN=0
 . F  S IBIFN=$O(^DGCR(399,"AOP",DFN,IBIFN)) Q:'IBIFN  D
 .. I $$COBN^IBCEF(IBIFN)'=1 Q      ; current payer seq must be primary
 .. I '$$WNRBILL^IBEFUNC(IBIFN) Q   ; and payer must be Medicare
 .. S BPID=670899
 .. I $$FT^IBCEF(IBIFN)=2 S BPID="VA0"_$P($$SITE^VASITE,U,3)
 .. ; BPID = what the billing provider ID should be
 .. I $P($G(^DGCR(399,IBIFN,"M1")),U,2)=BPID Q    ; it is OK
 .. S DIE=399,DA=IBIFN,DR="122///"_BPID D ^DIE    ; change it
 .. Q
 . Q
 ;
MCRX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(4)
 Q
 ;
TRIGGERS ;
 D BMES^XPDUTL(" STEP 5 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Firing Triggers for default values file 36 and 355.93 and indexing new xrefs")
 ;
 S DIK="^DIC(36,"
 S DIK(1)=".01^2^3^4^5^6"
 D ENALL^DIK
 ;
 S DIK="^IBA(355.93,"
 S DIK(1)=".09^1"
 D ENALL^DIK
 ;
 S DIK="^IBA(355.93,"
 S DIK(1)=".02^8"
 D ENALL^DIK
 ;
 S DIK="^IBE(355.97,"
 S DIK(1)=".03^1"
 D ENALL^DIK
 ;
 ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(5)
 Q
 ;
IBEFTFLG ;
 ;
 D BMES^XPDUTL(" STEP 6 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Setting ID Type flag for 355.92")
 N DA,N0,Q,DIC,DR,DA
 S DA=0 F  S DA=$O(^IBA(355.92,DA)) Q:'+DA  D
 . S N0=$G(^IBA(355.92,DA,0))
 . Q:N0=""
 . Q:$P(N0,U,8)]""   ; already been done
 . S Q=$P(N0,U,6)
 . Q:Q=""    ; no qualifier
 . S DR=".08////"_$S(Q=29:"E",1:"LF")
 . S DIE="^IBA(355.92,"
 . D ^DIE
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(6)
 Q
 ;
AUNIQ ;xxxx/WCJ-CREATE NEW-STYLE XREF ;1:27 PM  30 Dec 2005
 ;;1.0
 ;
 N ZZWJXR,ZZWJRES,ZZWJOUT
 D BMES^XPDUTL(" STEP 7 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Create cross reference for file 355.92 ....")
 S ZZWJXR("FILE")=355.92
 S ZZWJXR("NAME")="AUNIQ"
 S ZZWJXR("TYPE")="MU"
 S ZZWJXR("USE")="S"
 S ZZWJXR("EXECUTION")="R"
 S ZZWJXR("ACTIVITY")="IR"
 S ZZWJXR("SHORT DESCR")="Xref by ins co,care unit,form type,division,prov id type"
 S ZZWJXR("DESCR",1)="This cross reference allows edits to the additonal provider id's to be "
 S ZZWJXR("DESCR",2)="replicated to linked insurance companies."
 S ZZWJXR("SET")="S ^IBA(355.92,""AUNIQ"",X(1),$E(X(2),1,30),X(3),X(4),X(5),DA)="""""
 S ZZWJXR("KILL")="K ^IBA(355.92,""AUNIQ"",X(1),$E(X(2),1,30),X(3),X(4),X(5),DA)"
 S ZZWJXR("WHOLE KILL")="K ^IBA(355.92,""AUNIQ"")"
 S ZZWJXR("SET CONDITION")="S X=0 I X(1)]"""",X(2)]"""",X(3)]"""",X(4)]"""",X(5)]"""",$P($G(^IBA(355.92,DA,0)),U,8)=""A"" S X=1"
 S ZZWJXR("KILL CONDITION")="S X=0 I X(1)]"""",X(2)]"""",X(3)]"""",X(4)]"""",X(5)]"""" S X=1"
 S ZZWJXR("VAL",1)=.01
 S ZZWJXR("VAL",1,"COLLATION")="F"
 S ZZWJXR("VAL",2)=.1
 S ZZWJXR("VAL",2,"LENGTH")=30
 S ZZWJXR("VAL",2,"COLLATION")="F"
 S ZZWJXR("VAL",3)=.04
 S ZZWJXR("VAL",3,"COLLATION")="F"
 S ZZWJXR("VAL",4)=.11
 S ZZWJXR("VAL",4,"COLLATION")="F"
 S ZZWJXR("VAL",5)=.06
 S ZZWJXR("VAL",5,"COLLATION")="F"
 D CREIXN^DDMOD(.ZZWJXR,"SW",.ZZWJRES,"ZZWJOUT")
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(7)
 Q
 ;
F35597 ;
 ;
 D BMES^XPDUTL(" STEP 8 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Updating 355.97 ....")
 ;
 N IEN,CNV,NEW,OLD,DR,DIC,DIE,DA,X,DAT0,DAT1
 ;
 S CNV("BLUE CROSS ID")="BLUE CROSS^B"
 S CNV("BLUE SHIELD ID")="BLUE SHIELD^B"
 S CNV("TRICARE ID")="CHAMPUS^P"
 S CNV("COMMERCIAL ID")="COMMERCIAL^B"
 S CNV("CLIA #")="^P"
 S CNV("MEDICARE PART A")="^B"
 S CNV("MEDICARE PART B")="^B"
 S CNV("FACILITY FED TAX ID #")="EMPLOYER'S IDENTIFICATION #"
 S CNV("NETWORK ID")="PROVIDER PLAN NETWORK^B"
 S CNV("PROVIDER FED TAX ID #")="FEDERAL TAXPAYER'S #^^TJ"
 S CNV("UPIN")="^P"
 S CNV("STATE LICENSE")="^B"
 S CNV("HMO NUMBER")="HMO"
 S CNV("STATE INDUSTRIAL ACCIDENT PRV")="ACCIDENT PROVIDER NUMBER^B"
 S CNV("BILLING FACILITY PRIMARY ID")="ELECTRONIC PLAN TYPE^I"
 S CNV("LOCATION NUMBER")="^B"
 ;
 S IEN=0 F  S IEN=$O(^IBE(355.97,IEN)) Q:'+IEN  D
 . S OLD=$P($G(^IBE(355.97,IEN,0)),U)
 . Q:OLD=""
 . S DATA=$G(CNV(OLD))
 . N FLAG
 . S FLAG=$S(".1.2.3.6.8.11.12.16.18.20.21.22.23.24.25.26.27.28.29.30.31.32.33.34."[("."_IEN_"."):1,1:0)
 . S DA=IEN
 . S DIE=355.97
 . S DR=""
 . S:$P(DATA,U)]"" DR=DR_".01///"_$P(DATA,U)_";"
 . S:$P(DATA,U,2)]"" DR=DR_".07///"_$P(DATA,U,2)_";"
 . S:$P(DATA,U,3)]"" DR=DR_".03///"_$P(DATA,U,3)_";"
 . S DR=DR_".04////@;.08////"_FLAG
 . D ^DIE
 . Q
 ;
 S NEW(30,0)="MEDICAID^0^1D^^^^B^1"
 S NEW(30,1)="^^^^^^1"
 S NEW(31,0)="USIN^0^U3^^^1^P^1"
 S NEW(31,1)="^^^^^^0"
 S NEW(32,0)="EIN^0^EI^^^1^B^1"
 S NEW(33,0)="CLINIC NUMBER^0^FH^^^1^B^1"
 S NEW(34,0)="PROVIDER SITE NUMBER^0^G5^^^1^B^1"
 ;
 S NEW="" F  S NEW=$O(NEW(NEW)) Q:NEW=""  D
 . K DO
 . S DAT0=$G(NEW(NEW,0))
 . S DAT1=$G(NEW(NEW,1))
 . S DIC="^IBE(355.97,"
 . S DIC(0)=""
 . S X=$P(DAT0,U)
 . Q:X=""
 . Q:$D(^IBE(355.97,"B",X))   ; already there (for running multiple times)
 . S DIC("DR")=".02////0;.03////"_$P(DAT0,U,3)_$S($P(DAT0,U,6)]"":";.06////"_$P(DAT0,U,6),1:"")_";.07////"_$P(DAT0,U,7)_$S($P(DAT1,U,7)]"":";1.07////"_$P(DAT1,U,7),1:"")_";.08////"_$P(DAT0,U,8)
 . D FILE^DICN
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(8)
 Q
 ;
RIT ; Recompile input templates for billing screens
 NEW X,Y,DMAX
 D BMES^XPDUTL(" STEP 9 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Recompiling Input Templates for Billing Screens 6 & 7....")
 S X="IBXSC6",Y=$$FIND1^DIC(.402,,"X","IB SCREEN6","B"),DMAX=8000
 I Y D EN^DIEZ
 S X="IBXSC7",Y=$$FIND1^DIC(.402,,"X","IB SCREEN7","B"),DMAX=8000
 I Y D EN^DIEZ
RITX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(9)
 Q
 ;

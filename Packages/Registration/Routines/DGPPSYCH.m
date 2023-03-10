DGPPSYCH ;LIB/MKN,JAM - PRESUMPTIVE PSYCHOSIS SCREEN 7 ;08/01/2019
 ;;5.3;Registration;**977,1082**August 01, 2019;;Build 29
 ;
 ;ICRs
 ; Reference to ^%DT in ICR #10003
 ; Reference to ^DIQ in ICR #10004
 ; Reference to ^DIE in ICR #10018
 ; Reference to ^DIR in ICR #10026
 ; Reference to ^GET1^DIQ in ICR #2056
 ;
YN(DFN) ;  DG*5.3*1082;  NOTE: This API is now obsolete. Patch DG*5.3*1082 removed the call to this tag from the input template DG LOAD EDIT SCREEN 7
 ;
 ;This API gets called from input template DG LOAD EDIT SCREEN 7 at tag @705 (toward the end)
 ;Some of the variables NEWd here are because FileMan was crashing due to them getting killed in DIE
 ;
 ;;N DA,DGARR,DIC,DIE,DIK,DIR,DIROUT,DIRUT,DL,DP,DR,DTOUT,DUOUT,DGPPC,IEN331,IEN3312,Y
YN1 ;
 ;K DGARR D GETS^DIQ(2,DFN_",",".5601;1901","IE","DGARR")
 ;Q:$G(DGARR(2,DFN_",",1901,"I"))'="Y"  ;Not VETERAN="YES"
 ;S DGPPC=$G(DGARR(2,DFN_",",.5601,"I"))
 ;K DIR S DIR(0)="Y",DIR("A")="PRESUMPTIVE PSYCHOSIS",DIR("B")=$S(DGPPC]"":"Y",1:"N") D ^DIR
 ;Q:$D(DIRUT)
 ;I 'Y D  Q
 ;.S IEN331=$O(^DGPP(33.1,"B",DFN,"")) I IEN331 D
 ;..S DIK="^DGPP(33.1,",DA=IEN331 D ^DIK
 ;..S DIE="^DPT(",DA=DFN,DR=".5601///@" D ^DIE
 ;..Q
 ;.Q
 ;
 ;K DIR S DIR(0)="2,.5601AO",DIR("B")=DGPPC
 ;D ^DIR G:$D(DIRUT) YN1
 ;S DIE="^DPT(",DA=DFN,DR=".5601///"_Y_";" D ^DIE
 Q
 ;
PT(DFN,DGCAT,DGCHGDT) ;
 ; DG*5.3*1082; Update Patient (#2) file field #.5601 and PRESUMPTIVE PSYCHOSIS CATEGORY CHANGES (#33.1) file
 ; Inputs:   DFN     - patient
 ;           DGCAT   - category
 ;           DGCHGDT - (Optional) The date the Category changed
 ; Output:   Status  - 0 (Error), 1 (Success)
 ;
 N DGDATA5601
 ; Update Patient (#2) file, Presumptive Psychosis Category (#.5601)
 S DGDATA5601(.5601)=DGCAT
 I '$$UPD^DGENDBS(2,DFN,.DGDATA5601) Q 0
 ; Default DGCHGDT to DT if not passed in
 I $G(DGCHGDT)="" S DGCHGDT=DT
 ; Update PRESUMPTIVE PSYCHOSIS CATEGORY CHANGES (#33.1) file
 Q $$CH(DFN,DGCHGDT)
 ;
CH(DFN,DGCHGDT) ;
 ; DG*5.3*1082; This code was originally trigger logic for PRESUMCPTIVE PSYCHOSIS CATEGORY field (#.5601) of the PATIENT file (#2)
 ; That trigger was removed by the patch and this logic modified and called by tag PT above. Parameter DGCHGDT added.
 ; Additional changes made to add error handling and return success/fail flag
 ;
 ; This code creates a top level entry into the PRESUMPTIVE PSYCHOSIS CATEGORY CHANGES (#33.1) file if one does not exist
 ; If the PRESUMPTIVE PSYCHOSIS CATEGORY has changed, it sets a new entry into the PCATEGORY CHANGES multiple (#33.12) of the PRESUMPTIVE PSYCHOSIS CATEGORY CHANGES (#33.1) file
 ;
 ; Inputs:   DFN - patient
 ;           DGCHGDT - The date the Category changed
 ; Returns: 0 if error, 1 if successful
 ;
 N DGCAT,DGERR,DGFDA,DGIEN331,DGIENS,DGX,DGIEN331,DGIEN331S
 ;
 S DGCAT=$$GET1^DIQ(2,DFN_",",.5601,"I")
 ; Find existing entry for this patient, if any, in the PRESUMPTIVE PSYCHOSIS CATEGORY CHANGES (#33.1) file
 S DGIEN331=$O(^DGPP(33.1,"B",DFN,"")),DGIEN331S=$S(DGIEN331:DGIEN331_",",1:"+1,")
 ; If Patient not currently in the file, add entry.
 I 'DGIEN331 D  I $D(DGERR) Q 0
 . S DGFDA(33.1,DGIEN331S,.01)=DFN
 . D UPDATE^DIE(,"DGFDA","DGIENS","DGERR")
 . S DGIEN331=$G(DGIENS(1)),DGIEN331S=DGIEN331_","
 ;
 ; DGIEN331 now is the entry number for this patient in the PRESUMPTIVE PSYCHOSIS CATEGORY CHANGES (#33.1) file
 ; Check if the last entry in the CATEGORY CHANGES multiple (#33.12) of the PRESUMPTIVE PSYCHOSIS CATEGORY CHANGES (#33.1) file
 ; contains the same category as DGCAT. If so, quit - do not add same category for later date.
 Q:$$EXISTS(DGIEN331,DGCAT) 1
 ;
 ; Create new entry in CATEGORY CHANGES multiple (#33.12)
 Q $$SET(DGIEN331,DGCAT)
 ;
SET(DGIEN331,DGCAT) ;
 ; Inputs:   DGIEN331 - IEN for the entry in the PRESUMPTIVE PSYCHOSIS CATEGORY CHANGES (#33.1) file for this patient
 ;           DGCAT  - PRESUMPTIVE PSYCHOSIS CATEGORY (#.5061) field of PATIENT (#2) file (may be NULL)
 ; Returns: 0 if error, 1 if successful
 ;
 ; Create new entry in the CATEGORY CHANGES multiple (#33.12) of the PRESUMPTIVE PSYCHOSIS CATEGORY CHANGES (#33.1) file
 N DGERR,DGFDA
 ;
 S DGFDA(33.12,"+1,"_DGIEN331_",",.01)=DGCHGDT
 S DGFDA(33.12,"+1,"_DGIEN331_",",.02)=DGCAT
 S DGFDA(33.12,"+1,"_DGIEN331_",",.03)=$G(DUZ)
 D UPDATE^DIE(,"DGFDA",,"DGERR")
 I $D(DGERR) Q 0
 Q 1
 ;
EXISTS(DGIEN331,DGCAT) ;
 ; Check if DGCAT is already the last entry in the CATEGORY CHANGES multiple (#33.12) of the PRESUMPTIVE PSYCHOSIS CATEGORY CHANGES (#33.1) file
 ;
 ; Inputs:   DGIEN331 - IEN for the entry in the PRESUMPTIVE PSYCHOSIS CATEGORY CHANGES (#33.1) file
 ;           DGCAT  - PRESUMPTIVE PSYCHOSIS CATEGORY (#.5061) field of PATIENT (#2) file (may be NULL)
 ; Returns: 1 if DGCAT is already in the latest entry, 0 if DGCAT is not in the latest entry 
 ;
 N DGCATE,DGN
 S DGN=$O(^DGPP(33.1,DGIEN331,"CH","B","@"),-1) Q:'DGN 0 S DGN=$O(^DGPP(33.1,DGIEN331,"CH","B",DGN,""),-1) Q:'DGN 0
 S DGCATE=$P(^DGPP(33.1,DGIEN331,"CH",DGN,0),U,2)
 Q $S(DGCATE=DGCAT:1,1:0)
 ;
GETDATA331(DFN,DGVAFPSY) ; Get Data
 ;
 ; Get most recent data from PPRESUMPTIVE PSYCHOSIS CATEGORY CHANGES (#33.1) file
 ;
 ;  Input(s):
 ;        DFN - internal entry number of Patient (#2) file
 ; Output(s):
 ;     DGVAFPSY - Array populated with the most recent Presumptive Psychosis Data from the history
 ;                    Subscript          Field#   Data
 ;                    --------------     -------  ---------------------
 ;                    "PPCAT"              .02    internal
 ;                    "PPCATDT"            .01    internal
 ;
 N DGIEN331,DGZHF,DGN,DGIENS
 S DGIEN331=$O(^DGPP(33.1,"B",DFN,""))
 I DGIEN331 D
 . S DGN=$O(^DGPP(33.1,DGIEN331,"CH","B",""),-1) Q:'DGN
 . S DGN=$O(^DGPP(33.1,DGIEN331,"CH","B",DGN,""),-1) Q:'DGN
 . S DGIENS=DGN_","_DGIEN331_","
 . S DGVAFPSY("PPCAT")=$$GET1^DIQ(33.12,DGIENS,.02,"I")
 . S DGVAFPSY("PPCATDT")=$$GET1^DIQ(33.12,DGIENS,.01,"I")
 Q

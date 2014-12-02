RMPOPED ;EDS/MDB,DDW,RVD - HOME OXYGEN MISC FILE EDITS ;7/24/98
 ;;3.0;PROSTHETICS;**29,44,41,52,77,110,140,148,168**;Feb 09, 1996;Build 43
 ;
 ; Reference to $$SINFO^ICDEX supported by ICR #5747
 ; Reference to $$CSI^ICDEX   supported by ICR #5747 
 ; Reference to $$ICDDX^ICDEX supported by ICR #5747
 ; Reference to $$VLT^ICDEX   supported by ICR #5747
 ; Reference to $$CODEC^ICDEX supported by ICR #5747
 ; Reference to $$LS^ICDEX    supported by ICR #5747
 ;
 ; HNC - patch 52
 ;                 modified SITECHK sub
 ;                 X will be undefined from GETS^DIQ if field is null
 ;                 added $G.
 ; RVD - patch #77 use FileMan to set items that are not Primary item
 ;                 to 'N' in order to set correctly the 'AC' cross-ref.
 Q
UNLOCK I $D(RMPODFN) L -^RMPR(665,RMPODFN)
 Q
EXIT K DIC,DIE,DIR,DIK,X,Y,Z,DR,DA,DD,DO,D0,DTOUT,DIROUT,DUOUT,DIRUT,QUIT,DFN,ITEM,ITEMS,IEN,IENS,ITMACT,ITM,C,S,W,PI,VDR,ZST
 D UNLOCK
 Q
 ;
KEY ;user must have the RMPRSUPERVISOR key in order to add a new patient.
 ;option name is EDIT HOME OXYGEN PATIENT
 N KEY
 S KEY=$O(^DIC(19.1,"B","RMPRSUPERVISOR",0))
 I '$D(^VA(200,DUZ,51,KEY)) D  Q
 . W !!,"You do not hold the RMPRSUPERVISOR key!!"
 G PAT
 ;
SITE ; Editing of Home Oxygen site parameter file.
 K DIC,DIE,DA,DR,DD,RMPOXITE
 S DIC="^RMPR(669.9,",DIC(0)="QEAMLZ",DIC("A")="Select SITE: "
 D ^DIC Q:Y<0!$$QUIT
 K DIC("A")
 S (DA,RMPOXITE)=+Y
 ; Lock it...
 L +^RMPR(669.9,RMPOXITE):2
 I '$T D  G SITE
 . W ?10,$C(7)_Y(0,0)_" -- record in use. Try again later."
 ; Edit it
 S DIE=DIC,DR="60;61;62;65" D ^DIE Q:$$EQUIT
 ; Edit FCP
 K DIC,DA,DD,DR,DIE
 ;
 ; Done.  Unlock
 L -^RMPR(669.9,RMPOXITE)
 G SITE
 ;
FCPHLP ; Executable help for FCP multiple in 669.9
 ;
 Q
FCPIX ; Input transform for FCP multiple in 669.9
 ;
 Q:'$D(X)
 I $L(X)>30!($L(X)<3) K X Q
 S ZST=$P(^RMPR(669.9,D0,4),U,1),RMPOX=X
 D FIND^DIC(420.01,","_ZST_",",".01;","M",X,1,,,,"X")
 S X=$S($D(X("DILIST","ID",1,.01)):X("DILIST","ID",1,.01),1:RMPOX)
 K X("DILIST"),RMPOX
 I $G(ZST),('$D(^PRC(420,+ZST,1,"B",X))) W !,"Control Point is not a valid IFCAP FCP.." K X
 Q
ACT ;activate/inactivate a home oxygen patient
 ;Set up site variables.
 D HOSITE^RMPOUTL0 I QUIT D EXIT Q
 W @IOF
 ;
ACT1 ;Toggle ACTIVATE/INACTIVATE functions.
 N NAME K DIC,DA
 S DIC="^RMPR(665,",DIC(0)="QEAMZ" D ^DIC I Y<0!$$QUIT D EXIT Q
 S DIE=DIC,DA=+Y,NAME=Y(0,0)
 L +^RMPR(665,DA):2
 I '$T D  G ACT1
 . W ?10,$C(7)_Y(0,0)_" -- record in use. Try later."
 ;If the patient has never been activated, quit.
 I $P($G(^RMPR(665,DA,"RMPOA")),U,2)="" D  G ACT1
 . W !!,$C(7)_NAME_" has not been added as a Home Oxygen patient."
 . W !,"Please add using the ""Add/Edit Home Oxygen Patient"" option."
 ;If the patient is active, perform inactivation actions.
 I $P($G(^RMPR(665,DA,"RMPOA")),U,3)="" D INACTVT^RMPOPED G ACT1
 ;If the patient is inactive, perform activation actions.
 I $P($G(^RMPR(665,DA,"RMPOA")),U,3)'="" D ACTVT^RMPOPED G ACT1
 Q
INACTVT ; Inactivate the patient if user wants to.
 ; Confirm if the user wants to proceed.
 K DIR S DIR(0)="YO",DIR("B")="NO"
 S DIR("A")="Are you sure you want to inactivate "_NAME_" ?" D ^DIR
 Q:(Y<1)!$$QUIT
 S DR="19.5//TODAY;19.6;19.7////"_DUZ,DIE("NO^")="BACK"
 D ^DIE
 Q
 ;
ACTVT ;Activate the patient if the user wants to.
 K DIR S DIR(0)="YO",DIR("B")="NO"
 S DIR("A")="Are you sure you want to reactivate "_NAME_" ?" D ^DIR
 Q:(Y<1)!$$QUIT
 S DR="19.2//TODAY;19.5///@;19.6///@;19.7///@"
 S DIE("NO^")="BACK"
 D ^DIE
 Q
PAT ;Add/Edit Home Oxygen Patient
 S QUIT=0
 D HOSITE^RMPOUTL0
 I '$D(RMPOXITE)!QUIT D EXIT Q
LOOP ;
 S QUIT=0
 D LOOKUP I QUIT!'$D(RMPODFN) D EXIT Q
 D EDBLK I QUIT D EXIT Q
 D UNLOCK G LOOP
EDBLK ;
 D SITECHK Q:QUIT
 N RMPRDOI ; ICD - Date of Interest
 N RMPRWARN ; Flag if Prescription/Item mismatch was issued
 N RMPRCONT ; Flag if user wanted to continue after warning was issued
 S (RMPRWARN,RMPRCONT,RMPRDOI)=""
 D DEMOG Q:QUIT
 D RX Q:QUIT
 Q:+RMPRDOI'>0
 D ITEM
 Q
 ;called by ^RMPOBIL1, providing RMPOPATN as the X variable
EDIT ;From Billing...
 I '$D(RMPODFN) S RMPODFN=$TR($G(RMPOPATN),"`")
 Q:'$D(^RMPR(665,+RMPODFN,0))
 W !,"EDITING "_$P(^DPT(RMPODFN,0),U)_"...",!
 S QUIT=0,DA=RMPODFN
 L +^RMPR(665,DA):2
 I '$T W !!?10,*7," << Record in use. Try later. >>" Q
 D EDBLK,EXIT
 Q
LOOKUP ;First look-up the patient
 K DIC,DIE,DA,DR,RMPODFN
 W !!! S DIC="^RMPR(665,",DIC(0)="LQEAMZ"
 D ^DIC Q:(Y<0)!$$QUIT
CONT S (RMPODFN,DA)=+Y
 L +^RMPR(665,DA):2
 I '$T W !!?10,*7," << Record in use. Try later. >>" G LOOKUP
 Q
 ;
QUIT() S QUIT=$G(QUIT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q QUIT
EQUIT() S QUIT=$D(DTOUT)!$D(Y) Q QUIT
LJ(S,W,C) ; LEFT JUSTIFY S IN A FIELD W WIDE PADDING WITH CHAR F
 ;
 S C=$G(C," ")   ;DEFAULT PAD CHAR IS SPACE
 S $P(S,C,W-$L(S)+$L(S,C))=""
 Q S
 ;
SITECHK ;If user chooses patient from site different from billing site
 ;
 S Y=$P($G(^RMPR(665,RMPODFN,"RMPOA")),U,7)
 Q:Y=RMPOXITE    ;Site is the same.. 
 I Y="" D SET Q   ;Site not defined, stuff RMPOXITE...
 ; Site is different...
 S IENS=RMPODFN_","
 D GETS^DIQ(665,IENS,19.12,"E","X")
 W !!,"Patient's Home Oxygen Contract Location (HOCL) is "
 W $G(X(665,IENS,19.12,"E"))
 W !,"You are working on billing for HOCL "_RMPO("NAME"),!
 K DIR S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Should I change this patient's HOCL to "_RMPO("NAME")
 D ^DIR Q:$$QUIT!(Y=0)
 D SET
 Q
SET ;
 K DIE,DR,DA
 S DA=RMPODFN
 S DIE="^RMPR(665,",DR="19.12////"_RMPOXITE D ^DIE
 Q
 ;
DEMOG ;First edit the patient's basic fields
 ;
 K DIE,DR,DA
 S DA=RMPODFN
 S DIE="^RMPR(665,",DR="19.1" D ^DIE Q:$$EQUIT
 S RMPOELIG=$P($G(^RMPR(665,RMPODFN,"RMPOA")),U)
 K DR S DR="19.11"_$S(RMPOELIG="D":"",1:"///@")_";19.12"
 D ^DIE Q:$$EQUIT
 K DR S Y=DT X ^DD("DD") S DR="19.2//"_Y D ^DIE Q:$$QUIT
 Q
 ;
RX ;Edit the Rx Data
 ;
 N RXD,RXDI,RMPRIENS
 K DIC,DIE,DA,DR
 S DIC="^RMPR(665,"_RMPODFN_",""RMPOB"",",DIC(0)="AEQLZ"
 S DA(1)=RMPODFN,DIC("P")="665.193D"
 S RXD=$O(^RMPR(665,DA(1),"RMPOB","B",""),-1) D:RXD
 . S DIC("B")=$$FMTE^XLFDT(RXD)
 D ^DIC Q:Y<0!$$QUIT
 ; Set RMPRIENS for loading Date of Interest after final edits
 S RMPRIENS=+Y_","_DA(1)_","
 ; Edit START DATE (#.01), EXPIRATION DATE (#2) and DESCRIPTION (#3)
 S DIE=DIC,DA=+Y,DR=".01;2//^D EXPIRE^RMPOBIL4;3" D ^DIE Q:$$EQUIT
 ; Load ICD Date of Interest
 S RMPRDOI=$$GET1^DIQ(665.193,RMPRIENS,.01,"I",,)
 Q
 ;
ITEM ;Add/Edit Items
 ;
 ; Display items
 D ITEMD
 ; If no items on file, then only allow ADD PRIMARY ITEM
 I '$D(IEN) D ITEMP Q:QUIT!(ITEM="")  G ITEM
 ; ask for ACTION, quit if <return>, timeout, etc
 S ITMACT=$$ITEMO Q:$$QUIT!(ITMACT="")
 ; if they entered 'A', do ADD ITEM, then edit it
 I ITMACT="A" D ITEMA Q:QUIT!(ITEM="")  D ITEME Q:QUIT  G ITEM
 ; if they entered 'D', select an item, then delete it
 I ITMACT="D" D ITEMS Q:QUIT!(ITEM="")  D ITEMK G ITEM
 ; if they entered 'E', select an item, then edit it
 I ITMACT="E" D ITEMS
 ; If warning issued and Continue = No
 I RMPRWARN=1,RMPRCONT'=1 S (RMPRWARN,RMPRCONT)="" G ITEM
 Q:QUIT!(ITEM="")
 D ITEME Q:QUIT
 G ITEM
 Q
 ;
ITEMP ; Add Primary Item
 W !!,$C(7)_"No items found, please enter PRIMARY ITEM",!
 D ITEMA Q:QUIT!(ITEM="")
 S PI="///Y" D ITEME K PI
 Q
ITEMA ; Add Items
 S ITEM=""
 K DIC S DIC="^RMPR(661,",DIC(0)="AEQMZ" D ^DIC Q:Y<0!$$QUIT
 K DD,DO,DA,DIC
 S DIC="^RMPR(665,"_RMPODFN_",""RMPOC"",",DIC(0)="L"
 S DIC("P")=$P(^DD(665,19.4,0),U,2),DA(1)=RMPODFN,X=+Y
 D FILE^DICN I Y>0 S IEN=$G(IEN)+1,IEN(IEN)=+Y,ITEM=IEN
 Q
 ;
ITEMS ; Select Item
 ; Return ITEM = index into both ITEMS and IEN arrays
 N RMPRQUIT,RMPRACS,RMPRCS,RMPRICD,RMPRICS,RMPRANS,RMPRACT
 ; Determine Active Coding System based on Date of Interest
 S RMPRACS=$$SINFO^ICDEX("DIAG",RMPRDOI) ; Supported by ICR 5747
 S RMPRACS=$P(RMPRACS,U,2),RMPRACS=$P(RMPRACS,"-",2)
 ; If only one Item on file
 I IEN=1 S ITEM=1 W "  ",$E(ITEMS(1),1,33) Q:ITMACT'="E"  D  Q
 .; Load Item info
 .D RMPRLOAD
 .; If item has an ICD code, verify that it was active based on 
 .; start date of currently selected prescription.
 .I RMPRICD'="",RMPRACT'="+" D
 ..; Display warning
 ..D RMPRWARN^RMPOPED1(RMPRICD,RMPRACS,RMPODFN,.ITEM,.RMPRCONT)
 ..S RMPRWARN=1 ; Set warning issued flag
 ; If multiple items on file
 K DIR
 S ITEM=""
 S DIR(0)="NO^1:"_IEN,DIR("A")="Select an ITEM"
 S DIR("?")="Select an item from the list"
 M DIR("?")=ITEMS
 F  D  Q:RMPRQUIT=1
 .S RMPRQUIT=""
 .D ^DIR
 .I Y'>0 S RMPRQUIT=1,ITEM="" Q
 .Q:$$QUIT
 .S ITEM=+Y W "  ",$E(ITEMS(ITEM),1,33)
 .; Quit if doing a Delete and item was selected
 .I ITMACT="D" S RMPRQUIT=1 Q
 .; Load ICD Code and Code Set and Active Status for selected Item
 .D RMPRLOAD
 .; If Item doesn't have an ICD code - OK
 .I RMPRICD="" W ! S RMPRQUIT=1 Q
 .; If Item has an ICD code validate that it was active based on the start
 .; date of the prescription.  If ICD was active, QUIT
 .I RMPRACT="+" S RMPRQUIT=1 Q
 .; Otherwise, issue warning
 .I ITMACT="E" D
 ..; Display warning
 ..D RMPRWARN^RMPOPED1(RMPRICD,RMPRACS,RMPODFN,IEN(ITEM),.RMPRCONT)
 ..S (RMPRWARN,RMPRQUIT)=1
 .W !
 K RMPRITEM
 Q
 ;
RMPRLOAD ; Load ICD, Code Set and Status
 S RMPRICD=$P(RMPRITEM(ITEM),U,2) ; ICD Code
 S RMPRCS=$P(RMPRITEM(ITEM),U,3)  ; Code Set
 S RMPRACT=$P(RMPRITEM(ITEM),U,4) ; Active Status
 Q
 ;
ITEME ; Edit an Item - ICD-10 Changes
 N DFCP,FCP,ICDID,RMCPRENT,RMPRACS,RMPRACSI,RMPRCSI,RMPRDATA,RMPRDATE,RMPRFILE,RMPRICD
 N RMPRICDE,RMPRICDI,RMPRIEN,RMPRIENS,RMPRINDX,RMPRQUIT,RMCPTHCP,RMPRTXT
 S (DFCP,FCP,ICDID,RMCPRENT,RMPRACS,RMPRACSI,RMPRCSI,RMPRDATA,RMPRDATE,RMPRICD,RMPRICDE)=""
 S (RMPRICDI,RMPRIEN,RMPRIENS,RMPRQUIT,RMCPTHCP,RMPRTXT)=""
 S ITMACT=$G(ITMACT)
 K DIE,DA,DR,RMCPT
 S DA(1)=RMPODFN,DA=IEN(ITEM),DIE="^RMPR(665,"_DA(1)_",""RMPOC"","
 D ITEMEP Q:QUIT
 S DR=".01R;6R" D ^DIE Q:$$EQUIT!('$D(DA))
 S RMCPTHCP=$P($G(^RMPR(665,RMPODFN,"RMPOC",DA,0)),U,7) ; (#6)   HCPCS CODE 
 S RMCPT=$P($G(^RMPR(661.1,RMCPTHCP,4)),U,1) S DR=""    ; (#.03) CPT MODIFIER 
 S RMCPRENT=$P($G(^RMPR(661.1,RMCPTHCP,5)),U,1)         ; (#30)  RENTAL FLAG 
 I RMCPT["RR",(RMCPRENT=1) S DR="11;"                   ; (#11)  HOME OXYGEN RENTAL FLAG 
 I RMCPT["QH" S DR=DR_"12;"                             ; (#12)  HOME OXYGEN CONSERVING FLAG
 ;
 ; Determine Active Coding System based on Date of Interest
 S RMPRACS=$$SINFO^ICDEX("DIAG",RMPRDOI) ; Supported by ICR 5747
 S RMPRACSI=$P(RMPRACS,U,1)
 ; Retrieve current ICD code info
 S RMPRFILE=665.194,RMPRIENS=IEN(ITEM)_","_RMPODFN_","
 S RMPRICDE=$$GET1^DIQ(RMPRFILE,RMPRIENS,7,"E",,) ; External ICD value for use with default value
 S RMPRICDI=$$GET1^DIQ(RMPRFILE,RMPRIENS,7,"I",,) ; Internal ICD value
 S RMPRIEN=RMPRICDI ; Save IEN in case user accepted default ICD value
 I RMPRICDI>0 D
 .S RMPRCSI=$$CSI^ICDEX(80,RMPRICDI) ; Code System Internal
 .S RMPRDATE=$$SINFO^ICDEX(RMPRCSI)
 .S RMPRDATE=$P(RMPRDATE,U,5) ; Implementation date of Code
 .; Retrieve ICD info - 20 piece string
 .S RMPRDATA=$$ICDDX^ICDEX(RMPRICDE,RMPRDATE,RMPRACSI,"E") ; Supported by ICR 5747
 ; Prompt for (#1) VENDOR  (#2) QUANTITY  (#3) UNIT COST  (4) UNIT OF ISSUE
 S DR=DR_"1R;2R;3R;4"
 K RMCPRENT,RMCPTHCP
 D ^DIE
 Q:$$EQUIT
 ;
 ; ICD-9 Code Set
 I $P(RMPRACS,U,2)="ICD-9-CM" D
 .; Prompt for ICD code
 .K DIC
 .S DR="7ICD-9 DIAGNOSIS CODE: "
 .I RMPRICDE'="" S DIC("B")=RMPRICDE
 .D ^DIE
 .Q:$$EQUIT
 Q:$$QUIT
 ;
 ; ICD10 Code Set
 I $P(RMPRACS,U,2)="ICD-10-CM" D
 .N RMPPARAM
 .; Initialize default prompt and help variables
 .D SETPARAM^RMPOICD1(.RMPPARAM)
 .; If existing ICD-10 code add to default prompt then Prompt and set needed variables
 .I +RMPRICDI>0 D
 ..; If existing ICD-10, add code & description
 ..S RMPRTXT=$$VLT^ICDEX(80,RMPRICDI,RMPRDOI) ; Supported by ICR 5747
 ..S RMPPARAM("SEARCH_PROMPT")=RMPPARAM("SEARCH_PROMPT")_RMPRICDE
 ..S RMPRLLEN=244-$L(RMPPARAM("SEARCH_PROMPT"))
 ..S RMPPARAM("SEARCH_PROMPT")=RMPPARAM("SEARCH_PROMPT")_" "_$E(RMPRTXT,1,RMPRLLEN)_" "
 .; Loop to prompt for ICD-10 code
 .F  D  Q:RMPRQUIT!(+RMPRICD>0)  ;  user quits OR ICD10 code was selected
 ..; Output from $$DIAG10^RMPOICD1 = IEN file #80;ICD code value;IEN file # 757.01^description
 ..S RMPRICD=$$DIAG10^RMPOICD1(RMPRDOI,RMPRICDE,.RMPPARAM)
 ..; User selected valid code
 ..I +RMPRICD>0 S RMPRQUIT=1 Q
 .. ;if no data found
 ..I RMPRICD="" W !!,RMPPARAM("NO DATA FOUND") Q
 ..; User entered ^ OR ^^ to Quit
 ..I +RMPRICD=-3 S (RMPRQUIT,QUIT)=1 Q
 ..; User entered <enter> with no existing entry
 ..I +RMPRICD=-1 S:$P(RMPRICD,U,2)=-1 RMPRQUIT=1 Q
 ..; Existing ICD and user just pressed <enter>
 ..I +RMPRICD=-5 S RMPRQUIT=1 Q
 ..; Check for Deleting the ICD from the item - User entered @
 ..I +RMPRICD=-6 D  Q
 ...I RMPRICDE="" W "  <NOTHING TO DELETE>" Q
 ...I $$QUESTION^RMPOICD1(1,RMPPARAM("DELETE IT"))=1 D DLTITEM^RMPOPED1(RMPODFN,IEN(ITEM)) S RMPRQUIT=1 Q
 ...W "  <NOTHING DELETED>",!
 ..; User timed out = QUIT
 ..I +RMPRICD=-2 S (RMPRQUIT,QUIT)=1 Q
 ..; User answered No to the "Do you wish to continue" prompt
 ..I +RMPRICD=-4 Q
 .;
 .Q:$$QUIT
 .; Set ICD Code (#7)
 .I +RMPRICD>0 D
 ..S DR="7////"_+RMPRICD
 ..D ^DIE
 ;
 Q:$$QUIT
 ; The final two fields are ask regardless of whether it was an ICD-9 or ICD-10 code
 S DR="8;9R" ; (#8) REMARKS   (#9) ITEM TYPE
 D ^DIE
 I $D(DA),$D(RMCPT),(RMCPT'["RR") S $P(^RMPR(665,DA(1),"RMPOC",DA,0),U,12)="" ; (#11) HOME OXYGEN RENTAL FLAG
 I $D(DA),$D(RMCPT),(RMCPT'["QH") S $P(^RMPR(665,DA(1),"RMPOC",DA,0),U,13)="" ; (#12) HOME OXYGEN CONSERVING FLAG
 Q:$$EQUIT
 ; Kludge to "point" to file 420
 S DFCP=$P(^RMPR(665,RMPODFN,"RMPOC",IEN(ITEM),0),U,6) ;(#5) FUND CONTROL POINT
 F  D  Q:(FCP>0)!QUIT
 . S FCP=$$GETFCP^RMPOBILU(DFCP) Q:QUIT
 . I FCP<0 W $C(7)_"REQUIRED FIELD!"
 I FCP>0 S DR="5///"_$P(FCP,U,2) D ^DIE Q:$$EQUIT
 ; End Kludge
 ;S DR="7:9" D ^DIE Q:$$EQUIT
 Q 
 ;
ITEMEP ; Primary Item edit...
 N PIEN,PFLG,RMDA,RMNO
 S RMDA=DA,DR="10" D ^DIE Q:$$QUIT
 I $P(^RMPR(665,RMPODFN,"RMPOC",RMDA,0),U,11)'="Y" Q
 ; Logic to control toggling of Primary Item flag...
 S RMNO="N"
 F RMX=0:0 S RMX=$O(^RMPR(665,RMPODFN,"RMPOC",RMX)) Q:RMX'>0  D
 . Q:RMDA=RMX
 . S DA=RMX,DR="10///^S X=RMNO" D ^DIE
 S DA=RMDA
 Q
PIEN(DFN) ; FIND PRIMARY ITEM
 ; RETURN IEN OF P.I. IN MULTIPLE ^ IEN IN FILE 661
 N X,PIEN
 S X=0,PIEN=0
 F  S X=$O(^RMPR(665,DFN,"RMPOC",X)) Q:X'>0  D  Q:PIEN
 . S:$P(^RMPR(665,DFN,"RMPOC",X,0),U,11)="Y" PIEN=X
 S:PIEN PIEN=PIEN_U_$P(^RMPR(665,DFN,"RMPOC",PIEN,0),U,1)
 Q PIEN
 ;
ITEMD ; Display Items
 N I,Z,PIF,ITMNM,VDRNM,RMPRACS,RMPRACT,RMPRICD,RMPRPCS,RMPRTXT
 S (RMPRACS,RMPRICD,RMPRPCS)=""
 ; Determine Active Coding System based on Prescription DOI
 S RMPRPCS=$$SINFO^ICDEX("DIAG",RMPRDOI)
 K IEN,ITEMS,RMPRITEM S I=0
 Q:$O(^RMPR(665,RMPODFN,"RMPOC",0))'>0
 W !!,"The following items are already in this patient's template:",!
 W !,"     Item Description                      Vendor                   ICD      CS+"
 F IEN=1:1 S I=$O(^RMPR(665,RMPODFN,"RMPOC",I)) Q:I'>0  D
 . S Z=^RMPR(665,RMPODFN,"RMPOC",I,0)
 . S PIF=$S($P(Z,U,11)="Y":"*",1:" ")
 . ; Load ICD and determine corresponding code set
 . S RMPRICD=$P(Z,U,8),RMPRACT=""
 . I RMPRICD'="" D
 . . ; Check whether ICD code for this item was active on DOI
 . . S RMPRACT=$$LS^ICDEX(80,+RMPRICD,RMPRDOI,1)
 . . ; Get Active Coding System Info
 . . S RMPRACS=$$CSI^ICDEX(80,+RMPRICD) ; Get interal coding system for this ICD code
 . . S RMPRACS=$$SINFO^ICDEX(RMPRACS) ; get external format for coding system
 . . S RMPRACS=$P(RMPRACS,U,2),RMPRACS=$P(RMPRACS,"-",2)
 . . S RMPRICD=$$CODEC^ICDEX(80,RMPRICD)
 . S ITMNM=$$ITEMNM($P(Z,U)),VDRNM=$$VDRNM($P(Z,U,2))
 . S IEN(IEN)=I
 . S VDRNM=$E(VDRNM,1,23)
 . S RMPRTXT=PIF_$J(IEN,3)_" "_$$LJ(ITMNM,38)_$$LJ(VDRNM,24)
 . S RMPRITEM(IEN)=RMPRTXT
 . I RMPRICD'="" D
 . . S $E(RMPRTXT,69)="",RMPRTXT=RMPRTXT_RMPRICD
 . . S $E(RMPRTXT,78)=""
 . . I RMPRACS=9 S RMPRTXT=RMPRTXT_" "
 . . S RMPRTXT=RMPRTXT_RMPRACS
 . . I +RMPRACT=1 S RMPRTXT=RMPRTXT_"+"
 . W !,RMPRTXT
 . S ITEMS(IEN)=RMPRTXT
 . S $P(RMPRITEM(IEN),U,2)=RMPRICD,$P(RMPRITEM(IEN),U,3)=RMPRACS,$P(RMPRITEM(IEN),U,4)=$S(+RMPRACT=1:"+",1:"")
 W !!," * = Primary Item  "
 W !,"CS = Code Set for ICD Diagnosis code"
 W !," + = Item with active ICD code on start date of prescription",!
 S IEN=IEN-1
 Q
 ;
ITEMNM(ITM) ; RETURN ITEM NAME
 S IENS=ITM_","
 D GETS^DIQ(661,IENS,.01,"","X")
 Q $E(X(661,IENS,.01),1,33)
VDRNM(VDR) ; RETURN VENDOR NAME
 I VDR="" Q "<< VENDOR NOT DEFINED >>"
 S IENS=VDR_"," D GETS^DIQ(440,IENS,.01,"","X")
 Q X(440,IENS,.01)
ITEMK ; Delete an Item
 ;
 K DIR S DIR(0)="Y",DIR("A")="Are you SURE you want to delete this item"
 S DIR("B")="NO" D ^DIR Q:Y'>0
 K DIK,DA
 S DA(1)=RMPODFN,DA=IEN(ITEM),DIK="^RMPR(665,"_DA(1)_",""RMPOC"","
 D ^DIK W "  ...deleted!"
 Q
ITEMO() ; Choose Option
 K DIR
 S DIR(0)="SBO^A:Add;D:Delete;E:Edit",DIR("A")="Select ACTION" D ^DIR
 Q Y
 ;
PARSE(RMPRTXT) ; Utility to break line of text over 80 characters into 2 lines
 ; Input:
 ; RMPRTXT = Two line array to parse
 ;          RMPRTXT(1) = ICD-## Diagnosis code: ###.#### -          Required
 ;          RMPRTXT(2) = Full Description up to 245 characters      Required
 ;          RMPRTXT(3) = Suspense Info                              Optional
 ; 
 ; Output:
 ; RMPRTXT array with each line of text < 80 characters and ending in a whole word.
 ;
 ;
 N RMPRFND,RMPRCNT1,RMPRCNT2,RMPRLLEN,RMPRSUSP
 S RMPRFND=""
 I $G(RMPRTXT(1))="" S RMPRTXT(1)="No ICD Code" Q
 I $G(RMPRTXT(2))="" S RMPRTXT(2)="No ICD Code Description" Q
 ; Save Suspense Data if it exists
 S RMPRSUSP=$G(RMPRTXT(3)) K RMPRTXT(3)
 ; Check to see if Code & Description will fit on one 80 character line
 I $L(RMPRTXT(1))+$L(RMPRTXT(2))'>80 D  Q
 .S RMPRTXT(1)=RMPRTXT(1)_RMPRTXT(2)
 .K RMPRTXT(2)
 .; If Suspense info, add it to end of description
 .I $L(RMPRSUSP)>0 D  Q
 ..I $L(RMPRTXT(1))<47 S RMPRTXT(1)=RMPRTXT(1)_RMPRSUSP Q
 ..S RMPRTXT(2)=RMPRSUSP
 ..Q
 ; Adjust parser for 1st line with ICD Code plus 1 space after ICD code
 S RMPRLLEN=80-$L(RMPRTXT(1))+1
 F RMPRCNT1=RMPRLLEN:-1:1 D  Q:RMPRFND
 .I $E(RMPRTXT(2),RMPRCNT1)=" " D  Q:RMPRFND
 ..S RMPRTXT(1)=RMPRTXT(1)_$E(RMPRTXT(2),1,RMPRCNT1-1)
 ..S RMPRTXT(2)=" "_$E(RMPRTXT(2),RMPRCNT1+1,999)
 ..S RMPRFND=1
 ; Loop through remainder of Description text and parse into 80 character lines with no word breaks
 F RMPRCNT1=2:1 Q:'$D(RMPRTXT(RMPRCNT1))!($L(RMPRTXT(RMPRCNT1))'>80)  D  ; Line counter
 .S RMPRFND=0
 .F RMPRCNT2=80:-1:1 D  Q:RMPRFND  ; line break counter
 ..I $E(RMPRTXT(RMPRCNT1),RMPRCNT2)=" " D  Q:RMPRFND
 ...S RMPRTXT(RMPRCNT1+1)=" "_$E(RMPRTXT(RMPRCNT1),RMPRCNT2+1,999)
 ...S RMPRTXT(RMPRCNT1)=$E(RMPRTXT(RMPRCNT1),1,RMPRCNT2-1)
 ...S RMPRFND=1 ; Stop for line breaks
 ; If Suspense info, add it to end of description
 I $L(RMPRSUSP)>0 D
 .; Check to Add to last line
 .I $L(RMPRTXT(RMPRCNT1))<47 S RMPRTXT(RMPRCNT1)=RMPRTXT(RMPRCNT1)_" "_RMPRSUSP Q
 .; Add to new line
 .I $L(RMPRTXT(RMPRCNT1))'<47 S RMPRTXT(RMPRCNT1+1)=" "_RMPRSUSP
 Q
 ; End of RMPOPED

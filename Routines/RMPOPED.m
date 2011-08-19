RMPOPED ;EDS/MDB,DDW,RVD - HOME OXYGEN MISC FILE EDITS ;7/24/98
 ;;3.0;PROSTHETICS;**29,44,41,52,77,110,140,148**;Feb 09, 1996;Build 1
 ;
 ; HNC - patch 52
 ;                 modified SITECHK sub
 ;                 X will be undefined from GETS^DIQ if field is null
 ;                 added $G.
 ;RVD - patch #77  use Fileman to set items that are not Primary item
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
 . W !!,"You do not hold the RMPSUPERVISOR key!!"
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
 D DEMOG Q:QUIT
 D RX Q:QUIT
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
QUIT() S QUIT=$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q QUIT
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
 ;W "HERE,RMPOXITE=",RMPOXITE
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
 N RXD,RXDI
 K DIC,DIE,DA,DR
 S DIC="^RMPR(665,"_RMPODFN_",""RMPOB"",",DIC(0)="AEQLZ"
 S DA(1)=RMPODFN,DIC("P")="665.193D"
 S RXD=$O(^RMPR(665,DA(1),"RMPOB","B",""),-1) D:RXD
 . S DIC("B")=$$FMTE^XLFDT(RXD)
 D ^DIC Q:Y<0!$$QUIT
 S DIE=DIC,DA=+Y,DR=".01;2//^D EXPIRE^RMPOBIL4;3" D ^DIE Q:$$EQUIT
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
 I ITMACT="E" D ITEMS Q:QUIT!(ITEM="")  D ITEME Q:QUIT  G ITEM
 G ITEM
 Q
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
ITEMS ; Select Item
 ; Return ITEM = index into both ITEMS and IEN arrays
 I IEN=1 S ITEM=1 W "  ",$E(ITEMS(1),1,33) Q
 K DIR
 S ITEM=""
 S DIR(0)="NO^1:"_IEN,DIR("A")="Select an ITEM"
 S DIR("?")="Select an item from the list"
 M DIR("?")=ITEMS
 D ^DIR Q:Y'>0!$$QUIT
 S ITEM=+Y W "  ",$E(ITEMS(ITEM),1,33)
 Q
ITEME ; Edit an Item
 N FCP,DFCP,RMCPTHCP,RMCPRENT K DIE,DA,DR,RMCPT
 S DA(1)=RMPODFN,DA=IEN(ITEM),DIE="^RMPR(665,"_DA(1)_",""RMPOC"","
 D ITEMEP Q:QUIT
 S DR=".01R;6R" D ^DIE Q:$$EQUIT!('$D(DA))
 S RMCPTHCP=$P($G(^RMPR(665,RMPODFN,"RMPOC",DA,0)),U,7)
 S RMCPT=$P($G(^RMPR(661.1,RMCPTHCP,4)),U,1) S DR=""
 S RMCPRENT=$P($G(^RMPR(661.1,RMCPTHCP,5)),U,1)
 I RMCPT["RR",(RMCPRENT=1) S DR="11;"
 I RMCPT["QH" S DR=DR_"12;"
 S DR=DR_"1R;2R;3R;4;7;8;9R" K RMCPRENT,RMCPTHCP
 D ^DIE I $D(DA),$D(RMCPT),(RMCPT'["RR") S $P(^RMPR(665,DA(1),"RMPOC",DA,0),U,12)=""
 I $D(DA),$D(RMCPT),(RMCPT'["QH") S $P(^RMPR(665,DA(1),"RMPOC",DA,0),U,13)=""
 Q:$$EQUIT
 ; Kludge to "point" to file 420
 S DFCP=$P(^RMPR(665,RMPODFN,"RMPOC",IEN(ITEM),0),U,6)
 F  D  Q:(FCP>0)!QUIT
 . S FCP=$$GETFCP^RMPOBILU(DFCP) Q:QUIT
 . I FCP<0 W $C(7)_"REQUIRED FIELD!"
 I FCP>0 S DR="5///"_$P(FCP,U,2) D ^DIE Q:$$EQUIT
 ; End Kludge
 ;S DR="7:9" D ^DIE Q:$$EQUIT
 Q
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
ITEMD ; Display Items
 N I,Z,PIF,ITMNM,VDRNM
 K IEN,ITEMS S I=0
 Q:$O(^RMPR(665,RMPODFN,"RMPOC",0))'>0
 W !!,"The following items are already in this patient's template:",!
 F IEN=1:1 S I=$O(^RMPR(665,RMPODFN,"RMPOC",I)) Q:I'>0  D
 . S Z=^RMPR(665,RMPODFN,"RMPOC",I,0)
 . S PIF=$S($P(Z,U,11)="Y":"*",1:" ")
 . S ITMNM=$$ITEMNM($P(Z,U)),VDRNM=$$VDRNM($P(Z,U,2))
 .; K X S IENS=$P(Z,U)_","
 .; D GETS^DIQ(661,IENS,.01,"","X") S ITMNM=$E(X(661,IENS,.01),1,33)
 .; S IENS=$P(Z,U,2)_",",VDRNM="<< VENDOR NOT DEFINED >>"
 .; I IENS'="," D GETS^DIQ(440,IENS,.01,"","X") S VDRNM=X(440,IENS,.01)
 . S IEN(IEN)=I
 . S ITEMS(IEN)=" "_PIF_$J(IEN,4)_"  "_$$LJ(ITMNM,38)_$E(VDRNM,1,30)
 . W !,ITEMS(IEN)
 W !!," * = Primary Item",!
 S IEN=IEN-1
 Q
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
 Q

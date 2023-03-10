IBAECC ;LL/ELZ - LONG TERM CARE CLOCK MAINTANCE ; 05-FEB-02
 ;;2.0;INTEGRATED BILLING;**176,199,728**;21-MAR-94;Build 14
 ;; Per VHA Directive 10-93-142, this routine should not be modified
 ;
 ; this routine will allow users to perform LTC copay clock
 ; maintance.  Every function for the user will be read and evaluated
 ; before actually filed in the LTC Copay Clock.
 ;
OPT ; menu option main entry point
 ;
 N ADDED,DFN,DIC,IBCL,IBLTCX,IBLTCZ,IBOPCL,IBSTDT,IBRES,IBX,IBY,X,Y
 ;
 ; select a patient (screen out patients with no LTC clock and are
 ; not LTC patients.
OPTA K DIC,X,Y,DFN,IBLTCX,VADP
 N DPTNOFZY S DPTNOFZY=1  ;Suppress PATIENT file fuzzy lookups
 S DIC="^DPT(",DIC(0)="AEMNQ",DIC("S")="I $$SCREEN^IBAECC(Y)" W ! D ^DIC G:Y<1 EX
 S DFN=+Y D DEM^VADPT
 ;
 ; is there a clock, if not offer to add
 ; IB*2.0*728
 S ADDED=0
 I '$D(^IBA(351.81,"C",DFN)) D  G:$G(IBLTCX)<1 OPTA
 .W !!,"The patient ",VADM(1)," has no LTC clock on file."
 .S IBRES=$$ASKCRU(0) Q:IBRES'>0
 .S IBSTDT=$$ASKSTDT(0) Q:IBSTDT'>0  ; start date  IB*2.0*728
 .; create clock entry
 .S IBLTCX=+$$ADDCL^IBAECU(DFN,IBSTDT) S:IBLTCX>0 ADDED=1
 .Q
 ;
 I 'ADDED S IBRES=$$ASKCRU(1) D:IBRES=1  G:IBRES'>0 OPTA
 .; check for existing open clock
 .S IBOPCL=$$FNDOPEN^IBAECU4(DFN) I IBOPCL>0 S IBLTCX=$$OPTB(DFN,IBOPCL,$$GET1^DIQ(351.81,IBOPCL_",",.04,"I"))
 .Q
 ; we get here either if user chose to update esitsing clock or brand new clock was added (there was no existing clock to close)
 ; choose a clock
 I $G(IBLTCX)<1 S IBLTCX=$$ASKCLK^IBAECP(DFN,1) G:$G(IBLTCX)<1 OPTA
 ;
 S IBLTCZ=^IBA(351.81,IBLTCX,0) D DISPLAY,EDIT
 G OPTA
 ;
OPTB(DFN,IBOPCL,IBOEDT,IBDEFDT) ; close existing clock and open the new one, also called from IB CANCEL  IB*2.0*728
 ;
 ; DFN - patient DFN
 ; IBOPCL - old clock ien (file 351.81)
 ; IBOEDT - old clock exp. date (internal)
 ; IBDEFDT - default start date (optional)
 ;
 ; returns 1 if new clock was opened, 0 otherwise
 ;
 N IBLTCX,IBOIENS,IBOSTDTE,IBSTDT,Z
 S IBLTCX=0
 S IBOIENS=IBOPCL_",",IBOSTDTE=$$GET1^DIQ(351.81,IBOIENS,.03)
 W !!,"WARNING!!!"
 W !,"Creating a new clock for this patient will close the existing open LTC Clock.",!
 I $$ASKYN()'>0 D  Q 0  ; ask for confirmation
 .W !!,"No new clock created."
 .W !,"Existing Clock for the Period starting on ",IBOSTDTE," is still in effect.",!
 .D ASKCONT
 .Q
 S IBSTDT=$$ASKSTDT(+$G(IBDEFDT)) Q:IBSTDT'>0 0  ; start date
 I IBSTDT'>IBOEDT D  Q 0
 .S Z=$$FMTE^XLFDT(IBOEDT)
 .W !!,"This patient's existing clock ends on ",Z,"."
 .W !!,"Unable to create a new clock for this patient until after ",Z
 .W !," at the earliest.",!
 .D ASKCONT
 .Q
 L +^IBA(351.81,IBOPCL):5 I '$T Q 0
 D CLOSECLK^IBAECU4(IBOPCL,DFN) ; close old clock
 L -^IBA(351.81,IBOPCL)
 W !!,"Clock for the Period starting on ",IBOSTDTE," is now closed."
 S IBLTCX=+$$ADDCL^IBAECU(DFN,IBSTDT) ; create new clock
 I IBLTCX>0 W !,"A new clock starting on ",$$FMTE^XLFDT(IBSTDT)," is now open.",!
 D ASKCONT
 Q IBLTCX
 ;
EX ;
 D KVAR^VADPT
 ;
 Q
 ;
ASKYN() ; "do you still wish to continue" prompt  IB*2.0*728
 ;
 ; returns 1 for "yes", or 0 otherwise
 ;
 N X,Y,DTOUT,DUOUT,DIR,DIROUT,DIRUT
 S DIR("A")="Do you still wish to continue? (Y/N): "
 S DIR(0)="YAO"
 D ^DIR
 Q $S(+Y=1:1,1:0)
 ;
ASKCONT ; "press any key to continue" prompt  IB*2.0*728
 ;
 N X,Y,DTOUT,DUOUT,DIR,DIROUT,DIRUT
 S DIR("A")="Press any key to continue."
 S DIR(0)="EA"
 D ^DIR
 Q
 ;
ASKSTDT(DEF) ; prompt for start date  IB*2.0*728
 ;
 ; DEF - default start date
 ;
 ; returns start date or "" for user exit
 ;
 N X,Y,DTOUT,DUOUT,DIR,DIROUT,DIRUT
 S DIR("A")="Please specify the clock start date: "
 I DEF>0 S DIR("B")=$$FMTE^XLFDT(DEF)
 S DIR(0)="DAO^:"_DT
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIROUT)!$D(DIRUT) Q ""
 Q +Y
 ;
ASKCRU(UFLG) ; prompt for create new / update existing clock  IB*2.0*728
 ;
 ; UFLG - 1 = prompt for update, 0 = only prompt for creation of a new clock
 ;
 ; returns 1 if user chooses to create new clock, 2 if they choose to update existing clock, or "" for user exit
 ;
 N X,Y,DTOUT,DUOUT,DIR,DIROUT,DIRUT
 I UFLG D
 .S DIR("A")="Create (N)ew Clock or (U)pdate Existing Clock? (N/U): "
 .S DIR(0)="SAO^N:Create new clock;U:Update existing clock"
 .Q
 I 'UFLG D
 .S DIR("A")="Create New Clock (Y/N): "
 .S DIR(0)="YAO"
 .Q
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q ""
 Q $S(Y="N":1,Y=1:1,Y="U":2,1:"")
 ;
DISPLAY ; display clock information
 ; Temporary
 N IBCLK
 S IBCLK=IBLTCX
 W @IOF
 D REPORT^IBAECB1
 Q
 ;
 ;
EDIT ; edit either start date or free days
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
AGAINE W ! F X=1:1:IOM W "-"
 W !,"You can edit Start Date OR Days Not Subject To LTC Copay (Free Days)"
 S DIR(0)="SO^S:Start Date;F:Free Days;" D ^DIR Q:$D(DIRUT)
 D @$S(Y="S":"START",1:"FREE"),DISPLAY
 G AGAINE
 Q
 ;
START ; edit the start date
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,IBSTDT,DIE,DA,DR,IBZ
 S DIR(0)="D",DIR("B")=$$FMTE^XLFDT($P(IBLTCZ,"^",3))
 D ^DIR Q:$D(DIRUT)  S IBSTDT=+Y
 ;
 ; no change
 I IBSTDT=$P(IBLTCZ,"^",3) W !!?10,"No Change !!" H 3 Q
 ;
 ; make sure we don't start after a free day
 S IBZ=0 F  S IBZ=$O(^IBA(351.81,IBLTCX,1,IBZ)) Q:IBZ<1  I $P(^IBA(351.81,IBLTCX,1,IBZ,0),"^",2)<IBSTDT S IBSTDT=0 Q
 I 'IBSTDT W !,"You must enter a date that is BEFORE all the Free Days" G START
 ;
 ; don't go less that 1 year before earliest free day
 S IBZ=0 F  S IBZ=$O(^IBA(351.81,IBLTCX,1,IBZ)) Q:IBZ<1  I '$$YR(IBSTDT,$P(^IBA(351.81,IBLTCX,1,IBZ,0),"^",2)) S IBSTDT=0 Q
 I 'IBSTDT W !,"You entered a start date greater than 1 year before a Free Day" G START
 ;
 ; file new start date and exp date
 S DIE="^IBA(351.81,",DA=IBLTCX,DR=".03///^S X=IBSTDT;.04///^S X=$$GETEXPDT^IBAECU4(IBSTDT)" D ^DIE
 S IBLTCZ=^IBA(351.81,IBLTCX,0)
 ;
 D LASTED
 ;
 Q
 ;
FREE ; change the free days
 N IBF,IBX,IBC,IBD,IBFREEX,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,IBOPT,IBFREEZ
 N IBCLK
 S IBCLK=IBLTCX
 ;
AGAINF ;
 D REINDEX
 ;
 S (IBC,IBX)=0 F  S IBX=$O(^IBA(351.81,IBLTCX,1,"AC",IBX)) Q:IBX<1  S IBC=IBC+1,IBF(IBX,IBC)=$O(^IBA(351.81,IBLTCX,1,"AC",IBX,0))
 ;
 ; display free days
 ;W !,"These are the Free Days currently on file:",!
 ;S IBD=0 F  S IBD=$O(IBF(IBD)) Q:IBD<1  W !?5,$O(IBF(IBD,0)),?10,$$FMTE^XLFDT(IBD)
 D FRDAYS^IBAECB1
 ;
 ; choose add, edit, or delete free day
 S DIR(0)="SO^A:Add;E:Edit;D:Delete" D ^DIR Q:$D(DIRUT)  S IBOPT=Y
 ;
 ; choose which one to change
 I IBOPT'="A" S DIR(0)="NO^1:"_IBC_":0" D ^DIR Q:$D(DIRUT)  S IBD=0 F  S IBD=$O(IBF(IBD)) Q:IBD<1  I $D(IBF(IBD,+Y)) S IBFREEX=IBF(IBD,+Y),IBFREEZ=^IBA(351.81,IBLTCX,1,IBF(IBD,+Y),0) Q
 ;
 D @(IBOPT_"FREE")
 ;
 G AGAINF
 ;
 Q
 ;
AFREE ; add free days
 N IBX,IBC,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,IBDT,DO,DIC,DINUM,DA,DIE,DR
 ;
 ; make sure there are not more than 21 already
 S (IBX,IBC)=0 F  S IBX=$O(^IBA(351.81,IBLTCX,1,IBX)) Q:IBX<1  S IBC=IBC+1
 I IBC>20 W !,"Patients are only allowed 21 free days.  ",!,VADM(1)," has ",IBC," already." Q
 ;
 ; what date do you want to add
AFREEA S IBDT=$$DATE I IBDT<1 Q
 ;
 ; is that date already there
 D ALREADY G:IBDT<1 AFREEA
 ;
 ; is free day before start date or > 1 year out
 D BADDT I IBDT<1 G AFREEA
 ;
 ; file free day
 F IBX=1:1:21 Q:'$D(^IBA(351.81,IBLTCX,1,IBX))
 K DO S DIC="^IBA(351.81,"_IBLTCX_",1,",DIC(0)="",X=IBX,DINUM=X,DA(1)=IBLTCX,DIC("DR")=".02///^S X=IBDT" D FILE^DICN
 ;
 W ?40,"... ",$$FMTE^XLFDT(IBDT)," was ",$S(Y>0:"",1:"NOT "),"added."
 I Y>0 S DIE="^IBA(351.81,",DA=IBLTCX,DR=".06///"_($P(IBLTCZ,"^",6)-1) D ^DIE S IBLTCZ=^IBA(351.81,IBLTCX,0)
 ;
 D LASTED,REINDEX
 ;
 ; allow adding more if they are not all used up.
 G:$P(IBLTCZ,"^",6)>0 AFREEA
 ;
 Q
 ;
EFREE ; edit a free day IBFREEX
 N IBDT,DIE,DA,DR
 ;
 ; what date do you want to change it to
 S IBDT=$$DATE($$FMTE^XLFDT($P(IBFREEZ,"^",2))) I IBDT<1 Q
 I IBDT=$P(IBFREEZ,"^",2) W !,"No change" Q
 ;
 ; is free day already there
 D ALREADY Q:IBDT<1
 ;
 ; is free day before start date or > 1 year out
 D BADDT Q:IBDT<1
 ;
 ; file free day
 S DIE="^IBA(351.81,"_IBLTCX_",1,",DA(1)=IBLTCX,DA=IBFREEX,DR=".02///^S X=IBDT" D ^DIE
 ;
 D LASTED,REINDEX
 ;
 Q
 ;
DFREE ; delete a free day
 N %,DA,DIK,DIE,DR
 ;
 ; are you sure
 F  W !,"Are you sure you want to delete this date" S %=2 D YN^DICN Q:%'=0  W !,"    Answer with 'Yes' or 'No'"
 Q:%'=1
 ;
 ; delete it
 S DIK="^IBA(351.81,"_IBLTCX_",1,",DA(1)=IBLTCX,DA=IBFREEX D ^DIK
 S DIE="^IBA(351.81,",DA=IBLTCX,DR=".06///"_($P(IBLTCZ,"^",6)+1) D ^DIE S IBLTCZ=^IBA(351.81,IBLTCX,0)
 ;
 D LASTED,REINDEX
 ;
 Q
 ;
SCREEN(DFN) ; screen out non-LTC patients
 N IBLTCST S IBLTCST=$$LTCST^IBAECU(DFN,DT,1)
 Q $S($D(^IBA(351.81,"C",DFN)):1,+IBLTCST=2:1,1:0)
 ;
ALREADY ; checks to see if the free day is already there
 N IBX
 S IBX=0 F  S IBX=$O(^IBA(351.81,IBLTCX,1,IBX)) Q:IBX<1  I $P(^IBA(351.81,IBLTCX,1,IBX,0),"^",2)=IBDT S IBDT="-1^"_IBDT Q
 I IBDT<1 W !!,$$FMTE^XLFDT($P(IBDT,"^",2))," is already on file!"
 Q
 ;
DATE(IBB) ; prompts for date selection (IBB is default)
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="DO^:"_DT S:$G(IBB) DIR("B")=IBB D ^DIR
 Q +Y
 ;
BADDT ; checks out IBDT to make sure it is a valid date based upon start date
 I IBDT<$P(IBLTCZ,"^",3) W !!,$$FMTE^XLFDT(IBDT)," is less than the clock start date of ",$$FMTE^XLFDT($P(IBLTCZ,"^",3)) S IBDT=0 Q
 I '$$YR($P(IBLTCZ,"^",3),IBDT) W !!,$$FMTE^XLFDT(IBDT)," is greater than 1 year pased the clock start date." S IBDT=0 Q
 ; if date is current month, don't allow
 I $E(IBDT,1,5)=$E(DT,1,5) W !!,$$FMTE^XLFDT(IBDT)," is during the current month.",!,"You must allow the montly job to enter this date into the clock." S IBDT=0
 Q
 ;
LASTED ; update last edited by and date fields
 N DIE,DR,DA
 S DIE="^IBA(351.81,",DA=IBLTCX,DR="4.03////^S X=DUZ;4.04///NOW" D ^DIE
 Q
YR(IBCLDT,IBFR) ; is the effective date of the clock too old?
 ;  Input:   IBCLDT  --  New Clock Effective Date
 ;             IBFR  --  Event Date
 ;  Output:       1  --  Effective Date is too old
 ;                0  --  Not
 N IBNUM,IBYR
 S IBNUM=$$FMDIFF^XLFDT(IBFR,IBCLDT),IBYR=$E(IBFR,1,3)
 Q IBYR#4&(IBNUM<364)!(IBYR#4=0&(IBNUM<365))
 ;
REINDEX ; this will take a clock and re-index the free days in order
 ;   assumes IBLTCX
 N IBX,DIK,DA,X,Y,IBZ
 ;
 ; clean out what is there
 S IBX=0 F  S IBX=$O(^IBA(351.81,IBLTCX,1,IBX)) Q:IBX<1  S IBZ($P(^IBA(351.81,IBLTCX,1,IBX,0),"^",2))="" S DIK="^IBA(351.81,"_IBLTCX_",1,",DA=IBX,DA(1)=IBLTCX D ^DIK
 ;
 ; place them back in - in order
 S IBZ=0 F IBX=1:1 S IBZ=$O(IBZ(IBZ)) Q:IBZ<1  K DO S DIC="^IBA(351.81,"_IBLTCX_",1,",DIC(0)="",DA(1)=IBLTCX,X=IBX,DINUM=IBX,DIC("DR")=".02////^S X=IBZ" D FILE^DICN
 Q

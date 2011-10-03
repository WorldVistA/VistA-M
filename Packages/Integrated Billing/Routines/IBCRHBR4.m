IBCRHBR4 ;ALB/ARH - RATES: UPLOAD (RC) SELECT SITES ; 10-OCT-1998
 ;;2.0;INTEGRATED BILLING;**106,138,148**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
SELSITE() ; select one site to calculate RC charges for
 ; return: 0 or 'IFN of site in IBCR RC SITE ^ site number ^ site name ^ 3-digit zip'
 ;
 D SETRGZIP,CHKRGZIP
 ;
 N IBSNAME,IBSELDIV,IBX,IBXIFN,IBMCDV
 W !!!,"Select Site to calculate Reasonable Charges v"_$$VERSION^IBCRHBRV_" for load into Charge Master"
 W !,"--------------------------------------------------------------------------------"
 ;
SELECT S (IBSELDIV,IBMCDV)=0
 S IBSNAME=$$ASKNAM I IBSNAME="" G SSQ
 ;
 S IBXIFN=$$LSTSITE(IBSNAME) I +IBXIFN'>0 G SELECT
 S IBSELDIV=$G(^XTMP("IBCR RC SITE",IBXIFN)) I IBSELDIV="" G SELECT
 S IBSELDIV=IBXIFN_U_IBSELDIV
 ;
 S IBX=$P(IBSELDIV,U,2) D MSGSITE^IBCRHBRV(IBX),MSGVERS^IBCRHBRV(IBX),MSGDIV(IBX)
 ;
 I '$$CONT(IBSELDIV) G SELECT
 ;
SSQ Q IBSELDIV
 ;
ASKNAM() ; ask the user to enter the name of a site/division, return upper case name entered or null
 N DIR,DIRUT,DUOUT,X,Y,IBX,IBY S IBX=""
 S DIR("?",1)="All or some divisions whose care is billed from your site may have charges."
 S DIR("?",2)="Some charges are unique to a single division, others cover multiple divisions."
 S DIR("?",3)="This may result in multiple sets in the Charge Master."
 S DIR("?",4)="Enter '??' for a complete list of divisions."
 S DIR("?",5)="Enter a division number or name for a matching list.",DIR("?",6)=""
 S DIR("?")="Select a division that will be billed at your site.",DIR("??")="^D LSTALL^IBCRHBR4"
 S DIR(0)="FO",DIR("A")="Select Division" W !! D ^DIR K DIR S IBX=Y I $D(DIRUT) S IBX=""
 I IBX'="" S IBX=$$UP^XLFSTR(IBX)
 Q IBX
 ;
CONT(SITE) ; as user if they want to load this division, return 1 if accept division and calculate charges, else 0
 N DIR,DIRUT,DUOUT,X,Y,IBX S IBX=0
 W !,?15,$P(SITE,U,2),?27,$P(SITE,U,3),!
 S DIR("?")="Enter 'Y' if the care provided at this division is billed at your site and you need this divisions charges loaded on your system."
 S DIR("A")="Calculate RC v"_$$VERSION^IBCRHBRV_" charges for this division"
 S DIR(0)="YO" D ^DIR K DIR I Y=1 S IBX=Y
 Q IBX
 ;
LSTALL ; list all sites, user cannot select, nothing returned
 N IBX,IBCNT,IBEND,IBXIFN,IBNODE,DIR,DIRUT,DUOUT,DTOUT,X,Y S (IBCNT,IBEND)=0 W !
 ;
 S IBX="" F  S IBX=$O(^XTMP("IBCR RC SITE","C",IBX))  Q:IBX=""  D  Q:$D(DIRUT)
 . S IBXIFN="" F  S IBXIFN=$O(^XTMP("IBCR RC SITE","B",IBX,IBXIFN)) Q:'IBXIFN  D  Q:$D(DIRUT)
 .. S IBNODE=$G(^XTMP("IBCR RC SITE",IBXIFN))
 .. W !,?15,$P(IBNODE,U,1),?27,$P(IBNODE,U,2),?65,$P(IBNODE,U,3)
 .. S IBCNT=IBCNT+1,IBEND=0 I '(IBCNT#21) W ! S DIR(0)="E" D ^DIR K DIR W ! S IBEND=1
 I 'IBEND,'$D(DIRUT) W ! S DIR(0)="E" D ^DIR K DIR W !
 Q
 ;
LSTSITE(SNAME) ; search, display, selecy from list of sites
 ; returns 'site IFN in IBCR RC SITE' if one selected, 0 if none selected, -1 if ^
 ;
 N IBX,IBL,IBXIFN,IBNODE,IBCNT,IBEND,IBSEL,SELARR,DIR,DIRUT,DUOUT,X,Y S (IBSEL,IBEND,IBCNT)=0 W !
 ;
 S IBX=SNAME,IBL=$L(SNAME) I SNAME'="" S IBX=$E(SNAME,1,$L(SNAME)-1)_$C($A($E(SNAME,$L(SNAME)))-1)_"~"
 ;
 F  S IBX=$O(^XTMP("IBCR RC SITE","B",IBX))  Q:IBX=""!($E(IBX,1,IBL)'=SNAME)  D  Q:IBSEL'=0
 . S IBXIFN="" F  S IBXIFN=$O(^XTMP("IBCR RC SITE","B",IBX,IBXIFN)) Q:'IBXIFN  D  Q:IBSEL'=0
 .. S IBNODE=$G(^XTMP("IBCR RC SITE",IBXIFN))
 .. S IBCNT=IBCNT+1,SELARR(IBCNT)=IBXIFN
 .. W !,?9,IBCNT,")",?15,$P(IBNODE,U,1),?27,$P(IBNODE,U,2),?65,$P(IBNODE,U,3)
 .. S IBEND=0 I '(IBCNT#21) S IBSEL=$$ASKSEL(IBCNT) S IBEND=1
 I SNAME'="",IBCNT'>0 W ?40,"??"
 ;
 I IBSEL=0,IBCNT>1,'IBEND S IBSEL=$$ASKSEL(IBCNT)
 I IBSEL=0,IBCNT=1 S IBSEL=1
 ;
 I IBSEL>0,$D(SELARR(+IBSEL)) S IBSEL=SELARR(+IBSEL)
 ;
 Q IBSEL
 ;
ASKSEL(CNT) ; ask user to select from list of sites, returns number selected, 0 if none selected, -1 if ^
 ;
 N DIR,DIRUT,DUOUT,DTOUT,X,Y,IBX S IBX=0 W !
 S DIR("?")="Enter return to continue, enter '^' to exit, or enter the number preceding the site you want to select.  The number may be no greater than "_CNT
 S DIR(0)="NO^1:"_CNT_":0",DIR("A")="  Press return to continue or select a site" D ^DIR
 S IBX=$S($D(DUOUT)!$D(DTOUT):-1,+Y>0:+Y,1:0) W !
 Q IBX
 ;
 ;
MSGDIV(SITE) ; check if division selected is defined as a division (40.8) on the system
 N IBMCDV,IBRG,IBX,IBY,IBFND S (IBMCDV,IBFND)="",SITE=$G(SITE)
 I SITE'="" S IBMCDV=+$O(^DG(40.8,"C",SITE,0))
 I +IBMCDV S IBX=$G(^DG(40.8,+IBMCDV,0)) D
 . W !!,?5,$P(IBX,U,2),?15,$P(IBX,U,1)," is a valid Medical Center division on your system.",!
 . S IBRG="RC" F  S IBRG=$O(^IBE(363.31,"B",IBRG)) Q:$E(IBRG,1,2)'="RC"  D  Q:IBFND
 .. I IBRG[(" "_SITE_" ") S IBFND=1 Q
 .. S IBY=$O(^IBE(363.31,"B",IBRG,0)) I 'IBY Q
 .. I '$O(^IBE(363.31,IBY,11,"B",+IBMCDV,0)) Q
 .. W !!,?5,SITE," is already assigned to Billing Region: ",IBRG,! S IBFND=1
 I 'IBMCDV W !!,?5,"*** ",SITE," is NOT defined as a Medical Center Division on your system ***",!
 Q
 ;
 ;
 ; ***************************************************************************************
 ;
SETRGZIP ; for all existing Billing Regions, set the sites 3-digit zip code into the Identifier field (363.31,.02)
 ; the 3-digit zip was not available with RC v1, so Regions created for RC v1 will not have this field set
 ;
 N DIE,DIC,DA,DR,X,Y,IBRGFN,IBLN,IBZIP I $$VERSION^IBCRHBRV=1 Q
 ;
 S IBRGFN=0 F  S IBRGFN=$O(^IBE(363.31,IBRGFN)) Q:'IBRGFN  D
 . S IBLN=$G(^IBE(363.31,IBRGFN,0)) Q:$E(IBLN,1,3)'="RC "  Q:$P(IBLN,U,2)'=""
 . ;
 . S IBZIP=$P($$SITEDV($P(IBLN," ",2)),U,4) Q:IBZIP'?3N
 . ;
 . S DIE="^IBE(363.31,",DA=IBRGFN,DR=".02////"_IBZIP D ^DIE K DIE,DIC,DA,DR
 Q
 ;
SITEDV(DIV) ; return the site data on the division passed in
 ; input: site number, output: 0 or 'IFN of site in IBCR RC SITE ^ site number ^ site name ^ 3-digit zip'
 ;
 N IBY,IBX,IBLN S (IBY,IBX)=0
 I +$G(DIV) S IBY=$O(^XTMP("IBCR RC SITE","C",DIV_" ",0))
 I +IBY S IBLN=$G(^XTMP("IBCR RC SITE",IBY)) I IBLN'="" S IBX=IBY_U_IBLN
 Q IBX
 ;
CHKRGZIP ; for all existing Billing Regions, check to ensure each division assigned is actually within that Region
 ; the 3-digit zip of the Regions Divisions must match the 3-digit zip of the Regions primary division
 ; if the 3-digit zips do not match, the Division is deleted from the Region
 ;
 N IBRGFN,IBLN,IBRGZIP,IBDVFN,IBDV,IBDVLN,IBDVZIP,ARRAY,DA,DIK,DIC,DIR,X,Y I $$VERSION^IBCRHBRV=1 Q
 ;
 S IBRGFN=0 F  S IBRGFN=$O(^IBE(363.31,IBRGFN)) Q:'IBRGFN  D
 . S IBLN=$G(^IBE(363.31,IBRGFN,0)) Q:$E(IBLN,1,3)'="RC "
 . S IBRGZIP=$P($$SITEDV($P(IBLN," ",2)),U,4) Q:IBRGZIP'?3N
 . ;
 . S IBDVFN=0 F  S IBDVFN=$O(^IBE(363.31,IBRGFN,11,IBDVFN)) Q:'IBDVFN  D
 .. S IBDV=+$G(^IBE(363.31,IBRGFN,11,IBDVFN,0)) Q:'IBDV
 .. S IBDVLN=$G(^DG(40.8,+IBDV,0)) Q:IBDVLN=""
 .. S IBDVZIP=$P($$SITEDV($P(IBDVLN,U,2)),U,4) Q:IBDVZIP'?3N
 .. ;
 .. I IBRGZIP=IBDVZIP Q
 .. S ARRAY(IBRGFN)=IBLN,ARRAY(IBRGFN,IBDV)=$P(IBDVLN,U,1,2)_U_IBDVZIP
 .. S DA(1)=IBRGFN,DIK="^IBE(363.31,"_DA(1)_",11,",DA=IBDVFN D ^DIK
 ;
 I $O(ARRAY(0)) D
 . W @IOF,!,"********************************************************************************"
 . W !,"Incorrect Billing Regions found in the Charge Master."
 . W !!,"Billing Regions are defined by the 3-digit zip code identifier of the primary",!,"division.  Only Divisions with the same 3-digit zip code identifier should",!,"be assigned to a Billing Region."
 . W !!,"There were Divisions incorrectly associated with Billing Regions in the",!,"Charge Master.  For the following Billing Regions, the corresponding Division",!,"has been deleted."
 . W !!,?3,"Billing Region",?43,"Division(s) Deleted",!,?3,"--------------------------------------------------------------------------"
 . ;
 . S IBRGFN=0 F  S IBRGFN=$O(ARRAY(IBRGFN)) Q:'IBRGFN  D
 .. S IBLN=ARRAY(IBRGFN) W !,?3,$E($P(IBLN,U,1),1,23),?26,"(",$P(IBLN,U,2),")"
 .. ;
 .. S IBDV=0 F  S IBDV=$O(ARRAY(IBRGFN,IBDV)) Q:'IBDV  D
 ... S IBLN=ARRAY(IBRGFN,IBDV) W ?43,$P(IBLN,U,2),?50,$E($P(IBLN,U,1),1,20),?72,"(",$P(IBLN,U,3),")",!
 . W !,"********************************************************************************",!
 . S DIR(0)="E" D ^DIR K DIR W @IOF
 Q

IBCRHBS4 ;ALB/ARH - RATES: UPLOAD (RC 2+) SELECT SITES ; 10-OCT-03
 ;;2.0;INTEGRATED BILLING;**245**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
SELSITE() ; select one site to calculate RC charges for
 ; return: 0 or 'IFN of site in IBCR RC SITE ^ site number ^ site name ^ 3-digit zip ^ type'
 ;
 D SETRGZIP^IBCRHBSZ,CHKRGZIP^IBCRHBSZ
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
 I $$DV999(IBSELDIV) S IBSELDIV=$$ASKDV(IBSELDIV) I IBSELDIV="" G SELECT
 ;
 I '$$RECHK(IBSELDIV) G SELECT
 ;
 S IBX=$P(IBSELDIV,U,2) D MSGSITE^IBCRHBRV(IBX),MSGVERS^IBCRHBRV(IBX),MSGDIV^IBCRHBSZ(IBX)
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
 S DIR("?")="Select a division that will be billed at your site.",DIR("??")="^D LSTALL^IBCRHBS4"
 S DIR(0)="FO",DIR("A")="Select Division" W !! D ^DIR K DIR S IBX=Y I $D(DIRUT) S IBX=""
 I IBX'="" S IBX=$$UP^XLFSTR(IBX)
 Q IBX
 ;
CONT(SITE) ; as user if they want to load this division, return 1 if accept division and calculate charges, else 0
 N DIR,DIRUT,DUOUT,X,Y,IBX S IBX=0
 W !,?15,$P(SITE,U,2),?27,$P(SITE,U,3),?60,$P(SITE,U,4),?67,$P(SITE,U,5),!
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
 .. W !,?10,$P(IBNODE,U,1),?22,$P(IBNODE,U,2),?60,$P(IBNODE,U,3),?67,$P(IBNODE,U,4)
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
 .. W !,?4,IBCNT,")",?10,$P(IBNODE,U,1),?22,$P(IBNODE,U,2),?60,$P(IBNODE,U,3),?67,$P(IBNODE,U,4)
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
DV999(SITE) ; check if Site is an valid site or a temporary placeholder
 N IBX S IBX=0 I +$G(SITE) I ($P(SITE,U,2)?1"9".2N.1"X".1N)!($P(SITE,U,5)="") S IBX=1
 Q IBX
 ;
ASKDV(SITE) ; Get new Division number, Name and Type for invalid sites
 ; return: "" or 'IFN of site in IBCR RC SITE ^ site number ^ site name ^ 3-digit zip ^ type'
 N IBNDIV,IBNM,IBTYP,IBNEW,IBI,IBX,X,Y,DIR,DIRUT,DUOUT,DTOUT S IBNEW="" I '$G(SITE) G ASKDVQ
 ;
 W !!,"--------------------------------------------------------------------------------"
 W !,"'",$P(SITE,U,2)," - ",$P(SITE,U,3),"' is an invalid site number, you may now enter",!,"the correct information on the site you are loading charges for.",!
 ;
 I $P(SITE,U,2)="999" S IBNDIV=$P(SITE,U,2),IBNM=$P(SITE,U,3) G ASKTYP
 ;
 S DIR("?")=$P(SITE,U,2)_" is not a valid site number, if you know the correct number for this division you may change it now."
 S DIR(0)="F^3:7^I X'?3N,X'?3N1.4UN K X",DIR("A")="Site Division Number" D ^DIR K DIR I $D(DIRUT) G ASKDVQ
 S IBNDIV=Y
 ;
 I '$O(^DG(40.8,"C",IBNDIV,0)) W !!,">> ",IBNDIV," is not a valid Medical Center division on your system.",!!
 ;
 I $E(IBNDIV)<9 S IBX=$$SITEDV^IBCRHBSZ(IBNDIV) I +IBX S IBNEW=IBX W !!,"**Site exists." G ASKDVQ
 ;
 S IBX=$$RGDV^IBCRHBSZ(IBNDIV)
 I +IBX,+$P(IBX,U,5) S IBNEW=+SITE_U_$P(IBX,U,2,5) W !!,"** Region ",IBNDIV," already exists." G ASKDVQ
 I +IBX,'$P(IBX,U,5) S IBNDIV=$P(IBX,U,2),IBNM=$P(IBX,U,3) W !!,"** Region ",IBNDIV," already exists." G ASKTYP
 ;
 ;
 S DIR(0)="F^3:25",DIR("A")="Location of Site, City" D ^DIR K DIR G:$D(DIRUT) ASKDVQ  S IBNM=Y
 S DIR(0)="P^5:AEQMZ",DIR("A")="Location of Site, State" D ^DIR K DIR G:$D(DIRUT) ASKDVQ
 S IBNM=IBNM_", "_$P(Y(0),U,2)
 ;
 ;
 W !!,"*** IT IS VERY IMPORTANT THAT TYPE OF FACILITY BE SET CORRECTLY"
 W !,"*** IF THERE IS ANY DOUBT OF THE TYPE OF FACILITY THEN CONTACT THE CBO ",!,?4,"OR ENTER A NOIS BEFORE CONTINUING"
ASKTYP S DIR("?",1)="If unsure of the correct Type of Facility for the site then STOP, "
 S DIR("?",2)="contact the CBO or enter a NOIS to get the correct Type of Facility.",DIR("?",3)=" "
 S DIR("?")="The Type of Facility determines the charges loaded for the site."
 ;
 S DIR(0)="S^1:Inpatient Facility (Provider Based);2:Outpatient Facility (Provider Based);3:Freestanding (Non-Provider Based)",DIR("A")="Type of Facility" D ^DIR I $D(DIRUT) G ASKDVQ
 S IBTYP=Y
 ;
 I $P(SITE,U,2)="999" S IBNDIV="999A"_IBTYP
 ;
 S IBNEW=$P(SITE,U,1)_U_IBNDIV_U_IBNM_U_$P(SITE,U,4)_U_IBTYP
 ;
ASKDVQ W !!,"--------------------------------------------------------------------------------",!
 Q IBNEW
 ;
RECHK(SITE) ; re-check site against existing region, Division number and Type are critical
 N IBX,IBY,IBOK,DA,DIC,DIE,DR S IBOK=1,SITE=$G(SITE),IBX=$P($G(SITE),U,2),IBY=0
 I IBX'="" S IBY=$$RGDV^IBCRHBSZ(IBX)
 ;
 I +IBY,'$P(IBY,U,5),+$P(SITE,U,5) D  ; needed for cases where region exists but division not in host file
 . S DR=".03////"_+$P(SITE,U,5),DIE="^IBE(363.31,",DA=+IBY D ^DIE K DIE,DIC,DA,DR S $P(IBY,U,5)=$P(SITE,U,5)
 ;
 I +IBY I ($P(SITE,U,2)'=$P(IBY,U,2))!($P(SITE,U,5)'=$P(IBY,U,5)) D
 . S IBOK=0 W !,"*** Error: Division selected does not match existing Region"
 . W !,?10,$P(SITE,U,2),?20,$P(SITE,U,3),?55,$P(SITE,U,4),?65,$P(SITE,U,5)
 . W !,?10,$P(IBY,U,2),?20,$P(IBY,U,3),?55,$P(IBY,U,4),?65,$P(IBY,U,5)
 ;
 I ($P(SITE,U,4)="")!('$P(SITE,U,5)) D
 . S IBOK=0 W !,"** Error: Required data missing (zip or type):"
 . W !,?10,$P(SITE,U,2),?20,$P(SITE,U,3),?55,$P(SITE,U,4),?65,$P(SITE,U,5)
 ;
 I $P(SITE,U,4)'="",'$O(^XTMP("IBCR RC E","A",$P(SITE,U,4),0)) D
 . S IBOK=0 W !,"** Error: No Area Factors defined for site/zip:"
 . W !,?10,$P(SITE,U,2),?20,$P(SITE,U,3),?55,$P(SITE,U,4),?65,$P(SITE,U,5)
 Q IBOK

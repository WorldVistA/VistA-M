RCRCALE ;ALB/CMS - TP REFERRAL ACTION SEL/MOD LIST BUILD ; 09/13/97
V ;;4.5;Accounts Receivable;**63**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
SEL ; Entry point to select Items on  List
 ; Select items will be highlighted and stored in TMP("RCRCAL",$J,"SEL"
 N DIC,DIRUT,DUOUT,RCSELN,RCOUT,VALMY,X,Y S RCSELN=0
 D EN^VALM2($G(XQORNOD(0)),0)
 I '$D(VALMY) W !,"   ...Nothing Selected." D PAUSE^VALM1 D
 .I ($D(DIROUT))!($D(DUOUT)) S RCOUT=1
 F  S RCSELN=$O(VALMY(RCSELN)) Q:('RCSELN)!($D(RCOUT))  D
 .I $D(^TMP("RCRCAL",$J,"SEL",RCSELN)) D UNSEL(RCSELN) Q
 .S ^TMP("RCRCAL",$J,"SEL",RCSELN)=""
 .D SELECT^VALM10(RCSELN,1)
 I $D(RCOUT) G SELQ
 I $O(^TMP("RCRCAL",$J,"SEL",0)) D
 .D FULL^VALM1
 .W @IOF,!!,"Current Selection of Items on List: "
 .S RCSELN=0 F  S RCSELN=$O(^TMP("RCRCAL",$J,"SEL",RCSELN)) Q:('RCSELN)!($D(RCOUT))  D
 ..I $Y>(IOSL+3) W ! D PAUSE^VALM1 W @IOF,!,"Current Selection of Items on List:"
 ..I $D(DIRUT)!$D(DUOUT) S RCOUT=1 Q
 ..W !,@VALMAR@(RCSELN,0)
 .W ! D PAUSE^VALM1
SELQ Q
 ;
UNSEL(RCSELN) ; Unselect and Unhighlight items on the list
 ;Ask user if they want to Unselect the Item
 N DIR,DIROUT,DTOUT,DUOUT,DIROUT,X,Y
 S DIR(0)="Y",DIR("B")="No"
 S DIR("?")="Enter Yes to un-select pre-selected item."
 S DIR("A")="Do you want to UNSELECT Item "_RCSELN_" "
 W !! D ^DIR I $D(DTOUT)!$D(DIROUT) S RCOUT=1 G UNSELQ
 I +Y K ^TMP("RCRCAL",$J,"SEL",RCSELN) D SELECT^VALM10(RCSELN,0)
UNSELQ Q
 ;
MOD ; Entry point to Modify active list for third party possible referrals
 ; Rebuilds the List of Possible Referrals by patname then resequence
 N CNT,DIR,DIROUT,DTOUT,DUOUT,DIROUT,RCA,RCD,RCOUT,RCS,RCSBN,RCSEL,RCSN,RCSP,RCY,X,Y
 ;
 ;select bill to delete from highlighted selection
 S RCSEL=""
 I $O(^TMP("RCRCAL",$J,"SEL",0)) D DELA I $G(RCOUT) G MODQ
 I RCSEL S RCD="" G MODA
 ;
 ;select bill to delete from in RCD()
 S DIR(0)="LAOC^1:"_VALMCNT_":0",DIR("A")="Delete List item number(s): "
 S DIR("?")="Enter item number(s) you want to remove from list"
 W !! D ^DIR M RCD=Y
 I ($D(DIROUT))!($D(DUOUT)) S RCOUT=1 W !,"Nothing Changed." G MODQ
 ;
MODA ;select bill to add in RCSBN()
 W !!,"Add Selected Bill(s) to List"
 D BILL^RCRCALB S RCOUT=0
 ;
 ;If none to add or delete quit
 I 'RCSEL,$G(RCD)="",'$O(RCSBN(0)) G MODQ
 ; 
 D FULL^VALM1 W @IOF
 W !!,?10,"* WARNING: ADDING OR DELETING ITEMS FROM THE CURRENT LIST   *"
 W !,?10,"* WILL CAUSE THE LIST TO BE RE-SEQUENCED WHICH MAY CAUSE A  *"
 W !,?10,"* BILL TO BE ASSOCIATED WITH A DIFFERENT ITEM NUMBER. ALSO, *"
 W !,?10,"* ALL CURRENT BILL SELECTIONS WILL BE UNSELECTED.           *"
 W !!
 ;
 ;Display Current actions
 I RCD W !,"Selected Items to Delete:",! S RCY="" F  S RCY=$O(RCD(RCY)) Q:RCY=""  D
 .F RCSP=1:1:999 S RCS=$P(RCD(RCY),",",RCSP) Q:RCS=""  D
 ..I RCS["-" F RCSN=$P(RCS,"-",1):1:$P(RCS,"-",2) W !,@VALMAR@(RCSN,0) D
 ...I $Y>(IOSL+3) D PAUSE^VALM1 W @IOF,!!,"Selected Items to Delete:",!
 ..I RCS'["-" W !,@VALMAR@(RCS,0)
 ..I $Y>(IOSL+3) D PAUSE^VALM1 W @IOF,!!,"Selected Items to Delete:",!
 ;
 I RCSEL W !,"Selected Items to Delete:",! S RCY=0 F  S RCY=$O(^TMP("RCRCAL",$J,"SEL",RCY)) Q:'RCY  D
 .I $Y>(IOSL+3) D PAUSE^VALM1 W @IOF,!!,"Selected Items to Delete:",!
 .W !,@VALMAR@(RCY,0)
 ;
 I $O(RCSBN(0)) W !!,"Selected Bills to Add:",! S RCY=0 F  S RCY=$O(RCSBN(RCY)) Q:'RCY  D
 .I $Y>(IOSL+3) D PAUSE^VALM1 W @IOF,!!,"Selected Bills to Add:",!
 .W !,$P(^PRCA(430,RCY,0),U,1)
 ;
 ;Ask user if sure 
 K DIR,DIROUT,DTOUT,DUOUT,DIROUT,X,Y
 S DIR(0)="Y",DIR("B")="No"
 S DIR("?")="Enter Yes if you want to rebuild the current list"
 S DIR("A")="Okay to Continue "
 W !! D ^DIR I 'Y G MODQ
 I ($D(DTOUT))!($D(DIROUT)) S RCOUT=1 W !,"Nothing Changed." G MODQ
 W !
 ;
 ;Delete all items in RCD variable from "B"
 I RCD W !,?3,"Deleting Selected Items..." S RCY="" F  S RCY=$O(RCD(RCY)) Q:RCY=""  D
 .F RCSP=1:1:999 S RCS=$P(RCD(RCY),",",RCSP) Q:RCS=""  D
 ..I RCS["-" F RCSN=$P(RCS,"-",1):1:$P(RCS,"-",2) D
 ...K ^TMP("RCRCAL",$J,"B",$P($G(^DPT(+$G(^TMP("RCRCALPT",$J,RCSN)),0),0),U,1),+$P($G(^TMP("RCRCALX",$J,RCSN),0),U,2))
 ..I RCS'["-" K ^TMP("RCRCAL",$J,"B",$P($G(^DPT(+$G(^TMP("RCRCALPT",$J,RCS)),0),0),U,1),+$P($G(^TMP("RCRCALX",$J,RCS),0),U,2))
 ;
 ;Delete all highlighted selected Items
 I RCSEL W !,?3,"Deleting Selected Items..." S RCY=0 F  S RCY=$O(^TMP("RCRCAL",$J,"SEL",RCY)) Q:'RCY  D
 .K ^TMP("RCRCAL",$J,"B",$P($G(^DPT(+$G(^TMP("RCRCALPT",$J,RCY)),0),0),U,1),+$P($G(^TMP("RCRCALX",$J,RCY),0),U,2))
 ;
 ;Add selected bills in RCA
 I $O(RCSBN(0)) W !,?3,"Adding Selected Items..."
 S RCY=0 F  S RCY=$O(RCSBN(RCY)) Q:'RCY  D
 .S CNT=$G(VALMCNT)+1
 .D SCRN^RCRCAL1(RCY,CNT)
 ;
 ;Delete Highlighted selected items
 I $O(^TMP("RCRCAL",$J,"SEL",0)) W !,?3,"Deleting Highlighted Items..."
 S RCY=0 F  S RCY=$O(^TMP("RCRCAL",$J,"SEL",RCY)) Q:'RCY  D SELECT^VALM10(RCY,0)
 ;
 W !,?3,"Killing current list ..."
 S RCY=0 F  S RCY=$O(^TMP("RCRCAL",$J,RCY)) Q:'RCY  K ^TMP("RCRCAL",$J,RCY)
 K ^TMP("RCRCALX",$J),^TMP("RCRCALPT",$J),^TMP("RCRCAL",$J,"IDX"),^TMP("RCRCAL",$J,"SEL")
 ;
 ;Rebuild using altered TMP("RCRCAL",$J,"B"
 D RESL^RCRCAL1
MODQ Q
 ;
DELA ;Ask if delete all items on selection list
 N DIR,DIROUT,DTOUT,DUOUT,DIROUT,X,Y
 S DIR(0)="Y",DIR("B")="Yes"
 S DIR("?")="Enter Yes if you want to delete ALL the highlighted selected items from the current list"
 S DIR("A")="Delete ALL highlighted selected items "
 W !! D ^DIR S RCSEL=+Y
 I ($D(DTOUT))!($D(DIROUT)) S RCOUT=1
DELAQ Q
 ;RCRCALE

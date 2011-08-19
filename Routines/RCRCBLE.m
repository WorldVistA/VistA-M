RCRCBLE ;ALB/CMS - TP REFERRAL ACTION SEL/MOD LIST BUILD ; 09/13/97
V ;;4.5;Accounts Receivable;**63**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
SEL ; Entry point to select Items on  List
 ; Select items will be highlighted and stored in TMP("RCRCBL",$J,"SEL"
 N DIC,DIRUT,DUOUT,RCSELN,RCOUT,VALMY,X,Y S RCSELN=0
 D EN^VALM2($G(XQORNOD(0)),0)
 I '$D(VALMY) W !,"   ...Nothing Selected." D PAUSE^VALM1 D
 .I ($D(DIROUT))!($D(DUOUT)) S RCOUT=1
 D FULL^VALM1
 F  S RCSELN=$O(VALMY(RCSELN)) Q:('RCSELN)!($D(RCOUT))  D
 .I $D(^TMP("RCRCBL",$J,"SEL",RCSELN)) D UNSEL(RCSELN) Q
 .S ^TMP("RCRCBL",$J,"SEL",RCSELN)=""
 .D SELECT^VALM10(RCSELN,1)
 I $D(RCOUT) G SELQ
 I $O(^TMP("RCRCBL",$J,"SEL",0)) D
 .W @IOF,!!,"Current Selection of Items on List: "
 .S RCSELN=0 F  S RCSELN=$O(^TMP("RCRCBL",$J,"SEL",RCSELN)) Q:('RCSELN)!($D(RCOUT))  D
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
 I +Y K ^TMP("RCRCBL",$J,"SEL",RCSELN) D SELECT^VALM10(RCSELN,0)
UNSELQ Q
 ;
 ;RCRCBLE

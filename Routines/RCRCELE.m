RCRCELE ;ALB/CMS - TRANSMISSION LOG SEL/RESEQ LIST BUILD ; 09/13/97
V ;;4.5;Accounts Receivable;**63**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
SEL ; Entry point to select Items on  List
 ; Select items will be highlighted and stored in TMP("RCRCE",$J,"SEL"
 N DIC,DIRUT,DUOUT,RCLN,RCSELN,RCOUT,VALMBG,VALMLST,VALMY,X,Y S RCSELN=0
 S VALMBG=1,VALMLST=$G(VALMCNT)
 D EN^VALM2($G(XQORNOD(0)),0)
 I '$D(VALMY) W !,"   ...Nothing Selected." D PAUSE^VALM1 D
 .I ($D(DIROUT))!($D(DUOUT)) S RCOUT=1
 F  S RCSELN=$O(VALMY(RCSELN)) Q:('RCSELN)!($D(RCOUT))  D
 .I $D(^TMP("RCRCE",$J,"SEL",RCSELN)) D UNSEL(RCSELN) Q
 .S RCLN=+$G(^TMP("RCRCEX",$J,RCSELN))
 .S ^TMP("RCRCE",$J,"SEL",RCSELN)=RCLN
 .D SELECT^VALM10(RCLN,1)
 I $D(RCOUT) G SELQ
 I $O(^TMP("RCRCE",$J,"SEL",0)) D
 .D FULL^VALM1
 .W @IOF,!!,"Current Selection of Items on List: "
 .S RCSELN=0 F  S RCSELN=$O(^TMP("RCRCE",$J,"SEL",RCSELN)) Q:('RCSELN)!($D(RCOUT))  D
 ..S RCLN=+$G(^TMP("RCRCE",$J,"SEL",RCSELN))
 ..I $Y>(IOSL+3) W ! D PAUSE^VALM1 W @IOF,!,"Current Selection of Items on List:"
 ..I $D(DIRUT)!$D(DUOUT) S RCOUT=1 Q
 ..W !,@VALMAR@(RCLN,0)
 .W ! D PAUSE^VALM1
SELQ Q
 ;
UNSEL(RCSELN) ; Unselect and Unhighlight items on the list
 ;Ask user if they want to Unselect the Item
 N DIR,DIROUT,DTOUT,DUOUT,DIROUT,RCLN,X,Y
 S DIR(0)="Y",DIR("B")="No"
 S DIR("?")="Enter Yes to un-select pre-selected item."
 S DIR("A")="Do you want to UNSELECT Item "_RCSELN_" "
 W !! D ^DIR I $D(DTOUT)!$D(DIROUT) S RCOUT=1 G UNSELQ
 I +Y S RCLN=^TMP("RCRCE",$J,"SEL",RCSELN) D
 .D SELECT^VALM10(RCLN,0)
 .K ^TMP("RCRCE",$J,"SEL",RCSELN)
UNSELQ Q
 ;
REQ ; Resequence list for Transmission Log
 N DIR,DIROUT,DTOUT,DUOUT,DIROUT,RCBN0,RCBN2,RCCNT,RCCOM,RCDATE,RCLN,RCNT,RCX,RCY,X,Y
 ;
 D FULL^VALM1
 I '$O(^RCT(349.3,0)) W !!,?10,"**  TRANSMISSION LOG EMPTY  **",!! R !,"Press ANY key to continue:",RCLN:DTIME G REQQ
 ;
 W !!!,?10,"* WARNING: THIS OPTION WILL RE-SEQUENCE ALL THE ITEMS ON THE   *"
 W !,?10,"* LIST. TRANSMISSION ENTRIES DELETED WILL NOT APPEAR. APPENDED *"
 W !,?10,"* COMMENTS WILL DISPLAY. ALL CURRENT HIGHLIGHTED SELECTIONS    *"
 W !,?10,"* WILL BE UNSELECTED.                                          *"
 W !!
 ;
 ;Ask user if sure 
 K DIR,DIROUT,DTOUT,DUOUT,DIROUT,X,Y
 S DIR(0)="Y",DIR("B")="No"
 S DIR("?")="Enter Yes if you want to rebuild the current list"
 S DIR("A")="Okay to Continue "
 D ^DIR K DIR I 'Y G REQQ
 I ($D(DTOUT))!($D(DIROUT)) S RCOUT=1 W !,"Nothing Changed." G REQQ
 W !
 ;
 ;Delete Highlighted selected items
 I $O(^TMP("RCRCE",$J,"SEL",0)) W !,?3,"Remove Highlighted Items..."
 S RCY=0 F  S RCY=$O(^TMP("RCRCE",$J,"SEL",RCY)) Q:'RCY  D
 .S RCLN=+$G(^TMP("RCRCE",$J,"SEL",RCY))
 .D SELECT^VALM10(RCLN,0)
 ;
 W !,?3,"Killing current list ..."
 K ^TMP("RCRCEX",$J),^TMP("RCRCE",$J)
 ;
 ;Rebuild
 W !,?3,"Rebuilding list ..."
 D REQ^RCRCEL
 I +$G(VALMCNT)=0 S VALMSG="NO MESSAGES FOUND"
REQQ Q
 ;
 ;RCRCELE

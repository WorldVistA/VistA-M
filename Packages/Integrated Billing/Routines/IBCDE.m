IBCDE ;ALB/ARH - AUTOMATED BILLER ERRORS ; 8/6/93
 ;;2.0;INTEGRATED BILLING;**55,287**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
SETCOMM ;sets errors/comments into file (362.1) based on array passed in
 ;^TMP("IBCE",$J,IBDT,IBTRN,IBIFN,x)=error message  (IBTRN OR IBIFN may be 0)
 ;if an entry already exists for event/bill its comments are deleted and replaced with what is passed in, if any
 ;
 Q:'$D(^TMP("IBCE",$J))
 S IBDT=0 F  S IBDT=$O(^TMP("IBCE",$J,IBDT)) Q:'IBDT  D
 . S IBTRN="" F  S IBTRN=$O(^TMP("IBCE",$J,IBDT,IBTRN)) Q:IBTRN=""  D
 .. S IBIFN="" F  S IBIFN=$O(^TMP("IBCE",$J,IBDT,IBTRN,IBIFN)) Q:IBIFN=""  D
 ... S IBDA=$$COMM1(IBTRN,IBIFN) Q:IBDA'>0  D COMM2(IBDA,"",1)
 ... S IBX=0 F  S IBX=$O(^TMP("IBCE",$J,IBDT,IBTRN,IBIFN,IBX)) Q:'IBX  D
 .... D COMM2(IBDA,^(IBX))
 K IBDT,IBTRN,IBIFN,IBDA,IBX,X,Y
 Q
 ;
COMM1(TRN,IFN) ;returns the comment entry number for event and bill, updates comment date and bill IFN
 ;if an entry does not exits one is created,  does not add any comments
 N IBDA,X,Y S IBDA=0,TRN=$G(TRN),IFN=$G(IFN) I '$D(^IBT(356,+TRN,0))!(+IFN&('$D(^DGCR(399,+IFN,0)))) G COMM1E
 S IBDA=$$FIND(TRN,IFN) I 'IBDA D  G:IBDA<0 COMM1E ; create new comment entry
 . S IBDA=$P(^IBA(362.1,0),U,3)+1 F  Q:'$D(^IBA(362.1,IBDA))  S IBDA=IBDA+1
 . S DIC="^IBA(362.1,",X=IBDA,DIC(0)="L",DIC("DR")=".02////"_$S(+TRN:TRN,1:"") K DD,DO D FILE^DICN K DD,DO,DIC S IBDA=+Y,DR=";.05////"_DT
 ; edit existing comment entry, add date (DT) and bill number
 S DIE="^IBA(362.1,",DA=IBDA,DR=".03////"_$S(+IFN:IFN,1:"")_$G(DR) D ^DIE K DIE,DA,DR,DIC
COMM1E Q IBDA
 ;
COMM2(IFNC,COMM,DEL) ;adds/deletes comments form a comment file entry, nothing returned
 ;if DEL is passed as true any comments existing for the entry are deleted
 ;if COMM contains text it is added as a comment to the entry
 N X,Y,IBDA1 S IBDA1=0 I '$D(^IBA(362.1,+$G(IFNC),0)) G COMM2E
 I +$G(DEL),$D(^IBA(362.1,+IFNC,11)) S DIE="^IBA(362.1,",DA=+IFNC,DR="11///@" D ^DIE K DIE,DIC,DR,DA
 I $G(COMM)'="" D  S ^IBA(362.1,+IFNC,11,IBDA1,0)=COMM
 . S IBDA1=+$P($G(^IBA(362.1,+IFNC,11,0)),U,3)+1 F  Q:'$D(^IBA(362.1,+IFNC,11,IBDA1))  S IBDA1=IBDA1+1
 I IBDA1>0 S ^IBA(362.1,+IFNC,11,0)="^^"_IBDA1_"^"_IBDA1_"^"_DT_"^"
COMM2E Q
 ;
FIND(TRN,IFN) ;find an entry in the comments file, returns IFN of comment entry
 ;returns comment entry that may not match with bill number if either the bill number passed in or comment entry bill number is null  (a comment entry may be initially created with no bill number)
 ;given that a comment entry is found for the event (TRN) then returns comment IFN based on following restrictions, otherwise returns 0
 ;1) if an exact match between bill number passed in and comment entry bill number is found (including null) then the IFN of that comment entry is returned
 ;2) if not 1) and no bill number passed in then returns the IFN of the last comment entry found, if any
 ;3) if not 1) and a bill number is passed in then returns the IFN of thelast comment entry found that does not have an associated bill number, if any
 N X,X1,Y S (X,Y)=0,TRN=+$G(TRN),IFN=+$G(IFN)
 F  S Y=$O(^IBA(362.1,"C",TRN,Y)) Q:'Y  S X1=+$P($G(^IBA(362.1,Y,0)),U,3) S:('X1)!('IFN) X=Y I X1=IFN S X=Y Q
 Q X
 ;
FINDB(IFN) ;search for any entries for a particular bill, returns string of comment file entry numbers separated by "^"
 N X,Y S X="",TRN=+$G(TRN),IFN=+$G(IFN)
 S Y=0 F  S Y=$O(^IBA(362.1,"D",IFN,Y)) Q:'Y  S X=Y_"^"_X
 Q X
 ;
PRINT ;print error/comments file (362.1), OPTION - replace in IB*2*287
 G ^IBCDP
 Q
 W !!,"Report requires 132 columns."
 S IBDATES=$$FMDATES^IBCU2 I IBDATES="" G PE
 S DHD="AUTOMATED BILLER ERRORS/COMMENTS FOR "_$$FMTE^XLFDT($P(IBDATES,U,1))_" - "_$$FMTE^XLFDT($P(IBDATES,U,2))
 S (FLDS,BY)="[IB AB COMMENTS]",FR=$P(IBDATES,U,1)_",,?,",TO=$P(IBDATES,U,2)_",,?,",L=0,DIC="^IBA(362.1,"
 D EN1^DIP
PE K X,Y,DTOUT,DUOUT,DIRUT,DIROUT,DIOEND,DIC,L,FLDS,BY,DHD,FR,TO,IBDATES
 Q
 ;
EDIT ;edit auto bill parameters, OPTION
 N IBFR,IBFR2
 S IBFR=$P($G(^IBE(350.9,1,7)),U,1)
 S DIE="^IBE(350.9,",DA=1,DR="7.01;7.03" D ^DIE I $D(Y) G EDITQ
 S IBFR2=$P($G(^IBE(350.9,1,7)),U,1)
 D:'IBFR CLEAN^IBCDC D:'IBFR2 ABOFF^IBCDC
E2 W ! S DIC="^IBE(356.6,",DIC(0)="AEQ" D ^DIC G EDITQ:Y<0
 S DIE="^IBE(356.6,",DA=+Y,DR=".04;.05;.06" D ^DIE
 G E2
EDITQ K DIE,DA,DR,X,Y
 Q
DELDT ;deletes entries from file (362.1) based on date and if they have a bill, OPTION
 S IBDT=$$FMADD^XLFDT(DT,-3),DIR("B")=$$FMTE^XLFDT(IBDT),DIR("?")="Enter a date before "_DIR("B")_"."
 S DIR("?",1)="All entries in the Auto Biller Comments file not associated with a bill entered on or before this date will be deleted."
 S DIR(0)="DOA^2880101:"_IBDT_":EX",DIR("A")="End Date for Delete: "
 D ^DIR K DIR G:'Y DELDTQ S IBDT=+Y
 ;
 S IBCE=0 F  S IBCE=$O(^IBA(362.1,IBCE)) Q:'IBCE  S X=$G(^IBA(362.1,IBCE,0)) I $P(X,U,5)'>IBDT,'$P(X,U,3) D
 . S DIK="^IBA(362.1,",DA=IBCE D ^DIK W "."
DELDTQ K IBCE,DIK,DIC,DA,X,Y
 Q

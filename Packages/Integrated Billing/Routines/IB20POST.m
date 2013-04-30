IB20POST ;ALB/MAF - Post-Init to correct EABD for entries in "ATOBIL" x-ref. - Aug 7, 1997
 ;;2.0; INTEGRATED BILLING ;**81**; 21-MAR-94
 ; -- Post init to correct the Earliest Auto Biller Date (EABD).
 ;    The 17th piece ^ibt(356,ifn,0) gets reset to the date the entry 
 ;    was entered into Claims Tracking plus the Days Delay.
 ;    This is only done for PRESCRIPTION REFILLS.
 D BMES^XPDUTL("*** Correcting the Earliest Auto Billing Date (EABD) for entries in the 'ATOBIL' cross reference in Claims Tracking - Only for Prescription Refills.")
 N IBDFN,IBTYPE,IBEABD,IBDT,IBDTCT,IBDFNODE,DIC,X,IBCTDA
 S (IBDFN,IBTYPE,IBDT,IBEABD,IBCTDA)=0
 F  S IBDFN=$O(^IBT(356,"ATOBIL",IBDFN)) Q:'IBDFN  S IBTYPE=$O(^IBE(356.6,"B","PRESCRIPTION REFILL",0)) D
 .F  S IBDT=$O(^IBT(356,"ATOBIL",IBDFN,IBTYPE,IBDT)) Q:'IBDT  F  S IBCTDA=$O(^IBT(356,"ATOBIL",IBDFN,IBTYPE,IBDT,IBCTDA)) Q:'IBCTDA  D
 ..S IBDFNODE=$G(^IBT(356,IBCTDA,0)),IBDTCT=$S(+$G(^IBT(356,IBCTDA,1))]"":+^IBT(356,IBCTDA,1),1:$P(IBDFNODE,"^",6))
 ..S IBEABD=$$EABD(IBTYPE,IBDTCT)
 ..S DIE="^IBT(356,",DA=IBCTDA,DR=".17////"_IBEABD
 ..D ^DIE K DA,DIE,DR
 ..Q
 I '$D(^IBT(356,"ATOBIL")) D BMES^XPDUTL("*** There are no EABD cross references to correct ***")
 D BMES^XPDUTL("DONE")
 Q
EABD(IBETYP,IBTDT) ; -- compute earliest auto bill date: date entered plus days delay for event type
 ;the difference betwieen this and EABD^IBTUTL is that the autobill of the event type may be turned off
 ;and this procedure will still return a date
 ; -- input   IBETYPE = pointer to type of entry file
 ;            IBTDT   = episode date, if not passed in uses DT
 ;
 N X,X1,X2,Y,IBETYPD S Y="" I '$G(IBETYP) G EABDQ
 S IBETYPD=$G(^IBE(356.6,+IBETYP,0)) I '$G(IBTDT) S IBTDT=DT
 S X2=+$P(IBETYPD,"^",6) ;set earliest autobill date to entered date plus days delay
 S X1=IBTDT D C^%DTC S Y=X\1
EABDQ Q Y

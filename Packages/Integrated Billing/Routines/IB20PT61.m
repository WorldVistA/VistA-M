IB20PT61 ;ALB/AAS - Insurance post init stuff ; 2/22/93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;
399 ; -- create new AE x-ref of file 399
 W !!!,"<<< Bill/Claims file Conversion."
 W !,"    Cross-reference Bill/Claims file by Primary Insurer"
 S ZTRTN="DQ399^IB20PT61",ZTDESC="IB - v2 BILL/CLAIMS FILE POST INIT UPDATE",ZTIO="" S:$G(IBFORCE) ZTDTH=$$15^IB20PT6
 W ! D ^%ZTLOAD I '$D(ZTSK) D  Q:'IBOK
 .D MANUAL
 .I 'IBOK,$P($G(^IBE(350.9,1,3)),"^",19)="" W !!,"You must run the v2.0 post init routine IB20PT6 before allowing users to",!,"print or modify Bill/Claims entries."
 I $D(ZTSK) W !,"    Bill/Claims file update queued as task ",ZTSK K ZTSK Q
 ;
 N IBCNT,IBCNTD
DQ399 D ^IB20PT62,BULL2 ;transfer/convert bill claims file
 Q
 ;
BULL1 ; -- finish bulletin for patient file conversion
 S XMSUB="IB v2 PATIENT File Conversion Complete"
 S IBT(1)=" The Integrated Billing Version 2.0 conversion of the patient file"
 S IBT(2)=" completed.",IBT(2.5)=""
 S IBT(3)="   Started on: "_$$DAT1^IBOUTL(IBSPDT,"2P")
 S IBT(4)=" Completed on: "_$$DAT1^IBOUTL(IBEPDT,"2P")
 S IBT(5)=""
 S IBT(6)=" Total Patients Checked: "_$G(IBCNT)
 S IBT(7)=" Total Patients with Insurance Entries: "_$G(IBCNTI)
 S IBT(8)=" Total number of insurance policies: "_$G(IBCNTPP)
 S IBT(9)=" Total number of Group Plans created: "_$G(IBCNTP)
 D SEND^IBTRKR31
 K IBT,XMSUB
 Q
 ;
BULL2 ; -- finish bulletin for bill/claims conversion
 S XMSUB="IB v2 BILL/CLAIMS File Conversion Complete"
 S IBT(1)=" The Integrated Billing Version 2.0 conversion of the BILL/CLAIMS file"
 S IBT(2)=" completed."
 S IBT(2.1)=""
 S IBT(3)="   Started on: "_$$DAT1^IBOUTL(IBSCDT,"2P")
 S IBT(4)=" Completed on: "_$$DAT1^IBOUTL(IBECDT,"2P")
 S IBT(5)=""
 S IBT(6)=" Total Entries in Bill/Claims file: "_$G(IBCNT)
 S IBT(7)=" Total Bill/Claims Diagnosis Entries Created: "_$G(IBCNTD)
 D SEND^IBTRKR31
 K IBT,XMSUB
 Q
 ;
BULL3 ; -- finish bulletin for loading current inpatients
 S XMSUB="IB v2 Claims Tracking Update Complete"
 S IBT(1)=" The Integrated Billing Version 2.0 initial loading of current inpatients"
 S IBT(2)=" into the claims tracking module has completed.",IBT(2.5)=""
 S IBT(2.6)="  "_IBCNT_" Patients added to the Claims Tracking Module"
 S IBT(2.7)=""
 S IBT(3)="   Started on: "_$$DAT1^IBOUTL(IBSTDT,"2P")
 S IBT(4)=" Completed on: "_$$DAT1^IBOUTL(IBETDT,"2P")
 D SEND^IBTRKR31
 K IBT,XMSUB
 Q
 ;
MANUAL ; -- ask if want to run manually
 N DIR,DIRUT,DUOUT,X,Y
 S IBOK=1
 W !!,"You did not select to QUEUE this portion of the IB v2 conversion",!
 S DIR(0)="Y",DIR("A")="OKAY TO RUN NOW"
 S DIR("?")="Enter 'YES' if you want to run this now directly on this device or 'NO' if you do not wish to run this part of the conversion now."
 D ^DIR
 S IBOK=+$G(Y)
 Q

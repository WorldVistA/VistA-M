PXRMOBJX ;SLC/AGP,JVS - CLINICAL REMINDERS ;5/15/03  14:15
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 Q
 ;
STATUS(DFN,ARRAY,MISSING) ;Evaluate The status of the Referral
 ;
 N STOP,ZTSK,CNT,GEC1,GEC2,GEC3,GECF,SOURCE
 S STOP=0,CNT=0,ARRAY=""
 ;
 ;Returned
 ;ARRAY as an array of information
 ;
 N HFDA,STOP
 D ACOPYDEL^PXRMGECK
 ;
 ;GET IEN FOR DATA SOURCES FOR GEC
 I $D(^PX(839.7,"B","GEC1")) S GEC1=$O(^PX(839.7,"B","GEC1",""))
 I $D(^PX(839.7,"B","GEC2")) S GEC2=$O(^PX(839.7,"B","GEC2",""))
 I $D(^PX(839.7,"B","GEC3")) S GEC3=$O(^PX(839.7,"B","GEC3",""))
 I $D(^PX(839.7,"B","GECF")) S GECF=$O(^PX(839.7,"B","GECF",""))
 ;
 S STOP=0
 S HFDA="" F  S HFDA=$O(^AUPNVHF("C",DFN,HFDA)) Q:HFDA=""  Q:STOP=1  D
 .I $D(^AUPNVHF(HFDA,12)) D
 ..I $P($G(^AUPNVHF(HFDA,12)),"^",1)>0 D
 ...S SOURCE=$P($G(^AUPNVHF(HFDA,812)),"^",3)
 ...Q:SOURCE=""
 ...I (SOURCE=$G(GEC1))!(SOURCE=$G(GEC2))!(SOURCE=$G(GEC3))!(SOURCE=$G(GECF)) D
 ....S STOP=1
 ;
 S (MISSING)=""
 I '$D(^PXRMD(801.5,"B",DFN))&(STOP=0) D
 .S ARRAY($$UP,1)="No GEC Referral on record."
 I '$D(^PXRMD(801.5,"B",DFN))&(STOP=1) D
 .S ARRAY($$UP,1)="No GEC Referral in progress."
 Q:'$D(^PXRMD(801.5,"B",DFN))
 ;
 ;
 ; A. look for missing dialog
 S:'$D(^PXRMD(801.5,"AD",DFN,"GEC1")) MISSING=MISSING_1_"^"
 S:'$D(^PXRMD(801.5,"AD",DFN,"GEC2")) MISSING=MISSING_2_"^"
 S:'$D(^PXRMD(801.5,"AD",DFN,"GEC3")) MISSING=MISSING_3_"^"
 ;S:'$D(^PXRMD(801.5,"AD",DFN,"GECF")) MISSING=MISSING_4
 ;    a. if none missing then set message
 ;    b. if missing then create message
 I MISSING'=""!(MISSING="") D
 .S ARRAY($$UP,1)="The following Dialog(s) are Complete:"
 .S:MISSING'[1 ARRAY($$UP,1)=$P($T(T+7),";",3) D
 ..I +$$TIUSTAT^PXRMGECK(DFN,"GEC1") D
 ...S ARRAY($$UP,1)="          Note Status: "_$P($$TIUSTAT^PXRMGECK(DFN,"GEC1"),":",2)_"  "_$P($$TIUSTAT^PXRMGECK(DFN,"GEC1"),":",3)_"  "_$P($$TIUSTAT^PXRMGECK(DFN,"GEC1"),":",4)
 .S:MISSING'[2 ARRAY($$UP,1)=$P($T(T+8),";",3) D
 ..I +$$TIUSTAT^PXRMGECK(DFN,"GEC2") D
 ...S ARRAY($$UP,1)="          Note Status: "_$P($$TIUSTAT^PXRMGECK(DFN,"GEC2"),":",2)_"  "_$P($$TIUSTAT^PXRMGECK(DFN,"GEC2"),":",3)_"  "_$P($$TIUSTAT^PXRMGECK(DFN,"GEC2"),":",4)
 .S:MISSING'[3 ARRAY($$UP,1)=$P($T(T+9),";",3) D
 ..I +$$TIUSTAT^PXRMGECK(DFN,"GEC3") D
 ...S ARRAY($$UP,1)="          Note Status: "_$P($$TIUSTAT^PXRMGECK(DFN,"GEC3"),":",2)_"  "_$P($$TIUSTAT^PXRMGECK(DFN,"GEC3"),":",3)_"  "_$P($$TIUSTAT^PXRMGECK(DFN,"GEC3"),":",4)
 .;S:MISSING'[4 ARRAY($$UP,1)=$P($T(T+10),";",3) D
 .;.I +$$TIUSTAT^PXRMGECK(DFN,"GECF") D
 .;..S ARRAY($$UP,1)="          Note Status: "_$P($$TIUSTAT^PXRMGECK(DFN,"GECF"),":",2)_"  "_$P($$TIUSTAT^PXRMGECK(DFN,"GECF"),":",3)_"  "_$P($$TIUSTAT^PXRMGECK(DFN,"GECF"),":",4)
 .I MISSING'="" S ARRAY($$UP,2)=$P($T(T+11),";",3)
 .S:MISSING[1 ARRAY($$UP,2)=$P($T(T+7),";",3)
 .S:MISSING[2 ARRAY($$UP,2)=$P($T(T+8),";",3)
 .S:MISSING[3 ARRAY($$UP,2)=$P($T(T+9),";",3)
 .;S:MISSING[4 ARRAY($$UP,2)=$P($T(T+10),";",3)
 ;
 I MISSING="" S ARRAY($$UP,2)=$P($T(T+5),";",3)
 ;S MESSAGE=MESSAGE_$P($T(T+6),";",3)
 ;S MESSAGE=MESSAGE_"^Current GEC Referral Status"
 ;
 Q
UP() ;
 S CNT=CNT+1
 Q CNT
 ;
T ;TEXT
 ;;     Social Services,
 ;;     Nursing Assessment,
 ;;     Care Recommendations,
 ;;     Care Coordination
 ;;  
 ;;Is this Referral Complete?
 ;;     Social Services
 ;;     Nursing Assessment
 ;;     Care Recommendations
 ;;     Care Coordination
 ;;The Following Dialogs are Missing:
 ;; ~~(If you select Yes, the current REFERRAL ~will be completed and any missing ~information cannot be added.
 ;; ~~If you select No, the current REFERRAL ~will include the addition of missing information.)
 Q

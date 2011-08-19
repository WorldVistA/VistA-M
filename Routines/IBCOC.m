IBCOC ;ALB/AAS - INACTIVE INS. COMPANIES WITH PATIENTS ; 04-NOV-93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;
% ;
 ; -- fileman print in inactive ins. companies
 W !!,"Print List of Inactive Insurance Companies still listed as Insuring Patients"
 W !!,"You will need a 132 column printer for this report!",!!
 S DIC="^DIC(36,",FLDS="[IB INACTIVE INS CO]",BY="[IB INACTIVE INS CO]",FR="?,?",TO="?,?"
 S DIS(0)="I $D(^DPT(""AB"",D0))"
 D EN1^DIP
 W !
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 K D,I,J,X,Y,IBCNT,DIC,FLDS,BY,TO,FR,DIS
 Q
 ;
CNT(D0) ; -- count number of entries
 N X,Y S X=0
 G:'$G(D0) CNTQ
 S Y=0 F  S Y=$O(^DPT("AB",D0,Y)) Q:'Y  S X=X+1
CNTQ Q X

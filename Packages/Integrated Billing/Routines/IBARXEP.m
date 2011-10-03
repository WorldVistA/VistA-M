IBARXEP ;ALB/AAS - RX COPAY EXEMPTION PRINT BILLING PATIENTS ; 20-JAN-93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% ; -- print list of patient by status
 K IBCNTE,BY
 I '$D(IOF) D HOME^%ZIS
 W @IOF,?20,"Print Patient Medication Copayment Exemptions",!!!
 ;
 S DIR("?")="Answer YES if you only want to print a statistical summary or answer NO if you want a list of patients plus the statistical summary."
 S DIR(0)="Y",DIR("A")="Print Summary Only",DIR("B")="YES" D ^DIR K DIR
 I $D(DIRUT) G END
 S IBSUM=Y
 I 'IBSUM W !!,"You will need a 132 column printer for this report!",!
 W !! D BY G END:$G(BY)=""
 S DIC="^IBA(354,",L=0,FR="?,?,?",TO="?,?,?"
 S FLDS=$S(IBSUM:"[IB BILLING PATIENT SUMMARY]",1:"[IB BILLING PATIENT]")
 S DHD="Patient Medication Copayment Exemption "_$S(IBSUM:"Statistics",1:"Report")
 S DIOEND="D SUMMARY^IBARXEP"
 ;
 ; -- exclude deceased patients
 I 'IBSUM S DIS(0)="I '+$G(^DPT(+D0,.35))"
 ;
 D EN1^DIP
END K DIC,L,FLDS,DIOEND,FR,TO,BY,DHD,X,Y,IBCNTE,IBCNT,IBSUM,DUOUT,DIRUT
 Q
 ;
 ;
CNT ; -- set counts into ^tmp for summary report
 N X,Y S X=$G(^IBA(354,D0,0)) Q:X=""
 S Y=$P($G(^IBE(354.2,+$P(X,"^",5),0)),"^") Q:Y=""
 S X=$P(X,"^",4) Q:X=""
 S:'$D(IBCNTE(X,Y)) IBCNTE(X,Y)=0 S IBCNTE(X,Y)=IBCNTE(X,Y)+1
 Q
 ;
BY ; -- sort by exemption reason or by exemption status
 S DIR(0)="SMA^.04:EXEMPTION STATUS;.05:EXEMPTION REASON",DIR("A")="SORT BY: ",DIR("B")="EXEMPTION STATUS"
 S DIR("?")="Sort by either Exemption Status (.04) or Exemption Reason (.05)"
 D ^DIR K DIR I $D(DIRUT) Q
 S BY=$S(Y=.05:"[IB BILLING PATIENT BY REASON]",Y=.04:"[IB BILLING PATIENT BY STATUS]",1:"")
 Q
 ;
SUMMARY ; -- print summary page
 N X,Y
 W:'IBSUM !!,"===================================================="
 S (X,Y)="",IBCNT(0)=0,IBCNT(1)=0
 F  S X=$O(IBCNTE(X)) Q:X=""  S IBCNT=0 F  S Y=$O(IBCNTE(X,Y)) Q:Y=""  D
 .;sub counts
 .S IBCNT(X)=IBCNT(X)+IBCNTE(X,Y)
 .S IBCNT=IBCNT+1
 .;print line
 .W:IBCNT=1 !,$S(X:"Exempt",1:"Non-Exempt")," Status:"
 .W !?5,Y,?40,"= ",IBCNTE(X,Y)
 W !
 W:$D(IBCNTE(1)) !,"Total Exempt Patients",?40,"= ",IBCNT(1)
 W:$D(IBCNTE(0)) !,"Total Non-Exempt Patients",?40,"= ",IBCNT(0)
 ;
 I IBSUM W !!!,"Statistics DO include counts from deceased patients."
 I 'IBSUM W !!!,"Statistics and report DO NOT include deceased patients."
 Q
 ;
NOINC ; -- print list of patient with no income data with address
 ;
 K IBCNTE,BY
 I '$D(IOF) D HOME^%ZIS
 W @IOF,?10,"Print Patients with NO INCOME DATA Medication Copayment Exemptions",!!!
 ;
 S IBSUM=0
 S DIC="^IBA(354,",L=0,FR="?,?,?",TO="?,?,?"
 S BY="[IB BILLING PAT W/INCOME]"
 S FLDS="[IB BILLING PAT W/INCOME]"
 S DHD="Patient with a NO INCOME DATA Medication Copayment Exemption Report"
 ;S DIOEND="D SUMMARY^IBARXEP"
 ;
 ; -- exclude deceased patients
 S DIS(0)="I '+$G(^DPT(+D0,.35))"
 ;
 D EN1^DIP
NOINCQ K DIC,L,FLDS,DIOEND,FR,TO,BY,DHD,X,Y,IBCNTE,IBCNT,IBSUM,DUOUT,DIRUT
 Q
 ;
EXADD ; -- print list of EXEMPT patients with address
 ;
 K IBCNTE,BY
 I '$D(IOF) D HOME^%ZIS
 W @IOF,?10,"Print List of Exempt Patients with Addresses",!!!
 ;
 S IBSUM=0
 S DIC="^IBA(354,",L=0,FR="?,?,?",TO="?,?,?"
 S BY="[IB EXEMPT PATIENTS]"
 S FLDS="[IB PATIENT ADDRESSES]"
 S DHD="List of Exempt Patients with Addresses"
 ;
 ; -- exclude deceased patients
 S DIS(0)="I '+$G(^DPT(+D0,.35))"
 ;
 D EN1^DIP
EXADDQ K DIC,L,FLDS,DIOEND,FR,TO,BY,DHD,X,Y,IBCNTE,IBCNT,IBSUM,DUOUT,DIRUT
 Q

PRSATL ; HISC/REL-Edit/Display T&L Unit ;3/4/1998
 ;;4.0;PAID;**38**;Sep 21, 1995
EDIT ; Enter/Edit T&L Unit
 D HDR K DIC
 S DIC="^PRST(455.5,",DIC(0)="AEQLM",DLAYGO=455.5,DIC("A")="Select T&L Unit: " D ^DIC K DIC G:Y'>0 EX
 S DA=+Y,DDSFILE=455.5,DR="[PRSA TL EDIT]" D ^DDS K DS G EDIT
DISP ; Display T&L Unit
 D HDR K DIC
 S DIC="^PRST(455.5,",DIC(0)="AEQM",DIC("A")="Select T&L Unit: " D ^DIC K DIC G:Y'>0 EX
 S DA=+Y,DDSFILE=455.5,DR="[PRSA TL DISP]" D ^DDS K DS G DISP
EMP ; Change T&L for an Employee
 K DIC S DIC("A")="Select EMPLOYEE: ",DIC(0)="AEQM",(DIC,DIE)="^PRSPC(" W ! D ^DIC S DFN=+Y K DIC
 I DFN<1 G EX
 S OLD=$P($G(^PRSPC(DFN,0)),"^",8)
 S DA=DFN,DR=7 D ^DIE I $P($G(^PRSPC(DFN,0)),"^",8)=OLD G EMP
 S PPI=$P(^PRST(458,0),"^",3)
 I $P($G(^PRST(458,PPI,"E",DFN,0)),"^",2)="P" K ^(5) D ONE^PRS8 S ^PRST(458,PPI,"E",DFN,5)=VAL G EMP
 S PPI=PPI-1
 I $P($G(^PRST(458,PPI,"E",DFN,0)),"^",2)="P" K ^(5) D ONE^PRS8 S ^PRST(458,PPI,"E",DFN,5)=VAL
 G EMP
SUP ; Set ASX cross-reference for Supervisor (Obsolete with PRS*4*38)
 ;S SSN=$P($G(^VA(200,DA,1)),"^",9),STL=""
 ;I SSN'="" S DFN=$O(^PRSPC("SSN",SSN,0)),STL=$P($G(^PRSPC(+DFN,0)),"^",8)
 ;F I9=0:0 S I9=$O(^PRST(455.5,"AS",DA,I9)) Q:I9<1  I DA(1)'=I9 D
 ;.S CTL=$P($G(^PRST(455.5,I9,"S",DA,0)),"^",2)
 ;.I CTL'="",CTL'=STL,'$D(^PRST(455.5,"ASX",CTL,DA)) S ^PRST(455.5,"ASX",CTL,DA)=""
 ;.Q
 ;I X'=STL,'$D(^PRST(455.5,"ASX",X,DA)) S ^PRST(455.5,"ASX",X,DA)=""
 Q
ASX ; List ASX Entries and re-index
 S PRSTLV=7 D ^PRSAUTL I TLI<1 G EX
 W !!,"Employees outside of this T&L who are Certified by this T&L:",!
 S (CNT,DA)=0 F  S DA=$O(^PRST(455.5,"ASX",TLE,DA)) Q:'DA  D
 . S SSN=$P($G(^VA(200,DA,1)),U,9) Q:SSN=""
 . S DFN=$O(^PRSPC("SSN",SSN,0)) Q:'DFN
 . Q:$P($G(^PRSPC(DFN,0)),U,8)=TLE  ; don't list if user in T&L
 . W !,?4,$P($G(^VA(200,DA,0)),U,1)
 . S CNT=CNT+1
 W:'CNT !,"  No Employees outside of this T&L are Certified by this T&L."
 W ! S DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR K DIR
 ; the following lines have been commented out by patch PRS*4*38. The
 ; x-ref should not be casually deleted since certification and approval
 ; options rely on its existance.
 ; If necessary IRM can rebuild x-ref via FileMan options.
 ;K DIR S DIR("A")="Do you wish to Re-Build this Index? ",DIR(0)="YA"
 ;S DIR("B")="No" W ! D ^DIR K DIR G:'Y EX
 ;K ^PRST(455.5,"ASX")
 ; loop thru T&Ls
 ;S DA(1)=0 F  S DA(1)=$O(^PRST(455.5,DA(1))) Q:'DA(1)  D
 ;. S DIK="^PRST(455.5,"_DA(1)_",""S"",",DIK(1)="1^ASX"
 ;. D ENALL^DIK ; rebuilds xref for all entries in supervisor subfile
 K CNT,DA,DFN,DIK,DIR,SSN,TLE,TLI
 Q
HDR ; Header
 W:$E(IOST,1,2)="C-" @IOF W !?26,"VA TIME & ATTENDANCE SYSTEM",!!?31,"TIME & LEAVE UNIT",!!! Q
EX G KILL^XUSCLEAN

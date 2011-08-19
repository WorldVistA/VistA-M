IBPUDEL ;ALB/CPM - DELETE SEARCH TEMPLATE ENTRIES ; 24-APR-92
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
DEL ; Delete Entry From Search Template
 S IBF=$$SEL G DELQ:'IBF
 D HOME^%ZIS W @IOF,*13 D HDR S I="",$P(I,"=",81)="" W !,I
 ;
 ; - list entries which may be deleted
 S IBTMDA=+IBD(IBF),(IBN,IBEN)=0 K ^TMP($J,"IBPUDEL")
 F I=1:1 S IBN=$O(^DIBT(IBTMDA,1,IBN)) D PICK:'IBN Q:'IBN  S ^TMP($J,"IBPUDEL",I)=IBN D DISP,PICK:'(I#19) G:IBEN["^" DELQ Q:IBEN
 I 'IBEN G DELQ
 ;
 ; - okay to delete?
 S DIR(0)="Y",DIR("A")="Do you wish to delete this entry"
 S DIR("?",1)="Enter:  'Y'  to delete this entry"
 S DIR("?")="        'N' or '^'  to quit this option."
 D ^DIR K DIR
 ;
 ; - if okay, update # records and delete entry
 I Y D
 . S IBNUMR=$P($G(^IBE(350.6,+$P(IBD(IBF),"^",3),0)),"^",4)
 . I IBNUMR>1 D  Q
 ..  D UPD^IBPU1(+$P(IBD(IBF),"^",3),.04,IBNUMR-1)
 ..  K ^DIBT(IBTMDA,1,+$G(^TMP($J,"IBPUDEL",IBEN))) W !,"This entry has been deleted.",!
 . D DEL^IBPU1(IBF) ; delete search template
 . D UPD^IBPU1(+$P(IBD(IBF),"^",3),.05,"/3") ; cancel log entry
 . W !,"Since this is the last template entry, the template has been deleted, and",!,"the log entry has been cancelled."
 ;
DELQ K ^TMP($J,"IBPUDEL"),DIRUT,DTOUT,DUOUT,I,IBD,IBF,IBN,IBNUMR,IBTMDA,X,Y
 Q
 ;
 ;
SEL() ; Prompt for Search Template.
 ;  Input:   NONE
 ;  Output:  File number, or 0 if none found/selected.
 ;           If file number is selected, then IBD is returned as
 ;              IBD(file #)=ien of template^status of log^ien of log
 N I,IBTM,IBTMDA,J,K K IBD
 F I=350,351,399 S J=$$LOG^IBPU(I) I J>1 S K=$$LOGIEN^IBPU1(I),IBTM=$P($G(^IBE(350.6,K,0)),"^",2) I IBTM]"" S IBTMDA=$O(^DIBT("B",IBTM,0)) I IBTMDA S IBD(I)=IBTMDA_"^"_J_"^"_K
 I '$D(IBD) S IBF=0 W !!,"There are no Search templates which are currently active.",! G SELQ
 S IBF=$O(IBD(0)) I '$O(IBD(IBF)) G SELQ
 ;
 ; - display template (file) selections
 W !,"Select one of the following files where a Search Template has been created:",!
 S IBF=0 F  S IBF=$O(IBD(IBF)) Q:'IBF  W !,?1,IBF,?6 D HDR
 ;
 ; - select a template
READ W !!,"Select a File Number: " R IBF:DTIME I $T,"^"'[IBF,'$D(IBD(IBF)) W !!,"  Enter one of the displayed file numbers, or '^' to exit this option." G READ
SELQ Q +IBF
 ;
HDR ; Write out a header.   Input:  IBF -- file name
 W $P($G(^DIC(IBF,0)),"^"),?35,"Created on ",$$DAT1^IBOUTL(+$G(^IBE(350.6,$P(IBD(IBF),"^",3),1)))," by ",$E($P($G(^VA(200,+$P($G(^(1)),"^",3),0)),"^"),1,22)
 Q
 ;
DISP ; Display entry from a file.  Input: IBF -- file name, IBN -- file entry
 N C,DATA,ROOT
 S ROOT=^DIC(IBF,0,"GL"),DATA=$G(@(ROOT_IBN_",0)"))
 W !,$J(I,2),?5,$E($P($G(^DPT(+$P(DATA,"^",2),0)),"^"),1,22),?30
 I IBF=350 W $P(DATA,"^",8) S Y=$P(DATA,"^",5),C=$P(^DD(350,.05,0),"^",2) D Y^DIQ W ?54,Y,?67,$$DAT1^IBOUTL($P($G(^IB(IBN,1)),"^",2)) G DISPQ
 I IBF=351 W $$DAT1^IBOUTL($P(DATA,"^",3)) S Y=$P(DATA,"^",4),C=$P(^DD(351,.04,0),"^",2) D Y^DIQ W ?44,Y,?59,$$DAT1^IBOUTL($P(DATA,"^",10)) G DISPQ
 W $P($G(^DGCR(399.3,+$P(DATA,"^",7),0)),"^")
 S Y=$P(DATA,"^",13),C=$P(^DD(399,.13,0),"^",2) D Y^DIQ W ?52,Y
 W ?71,$$DAT1^IBOUTL($P(DATA,"^",14))
DISPQ Q
 ;
PICK ; Select an entry to delete.
 ;  Input:  ^TMP($J,"IBPUDEL",  -- possible choices
 ;  Output:               IBEN  -- null (continue),
 ;                                 '^' (quit), or
 ;                                 a successful pick
ASK W !!,"Select 1-",$S(IBN:I,1:I-1),", or '^' to exit: " R IBEN:DTIME S:'$T IBEN="^" I "^"'[IBEN,'$D(^TMP($J,"IBPUDEL",IBEN)) W !!,"  ENTER a number between 1 and ",$S(IBN:I,1:I-1),"." G ASK
 W ! Q

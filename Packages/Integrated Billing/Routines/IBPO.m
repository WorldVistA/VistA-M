IBPO ;ALB/CPM - ARCHIVE/PURGING OUTPUTS ; 23-APR-92
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
LST ; List Archive/Purge Log Entries
 S DIC="^IBE(350.6,",FLDS="[IB PURGE LIST LOG ENTRIES]",L=0,(BY,FR,TO)=""
 D EN1^DIP
 Q
 ;
 ;
INQ ; Archive/Purge Log Inquiry
 S DIC="^IBE(350.6,",DIC(0)="QEAMZ",DIC("A")="Select LOG #: " D ^DIC K DIC G INQQ:Y<0 S IBDA=+Y
 S %ZIS="QM" D ^%ZIS G:POP INQQ
 I $D(IO("Q")) S ZTRTN="INQS^IBPO",ZTSAVE("IBDA")="",ZTDESC="ARCHIVE/PURGE LOG INQUIRY" D ^%ZTLOAD K IO("Q") D HOME^%ZIS G INQQ
 U IO
 ;
INQS ; Tasked Entry Point
 D NOW^%DTC W:$E(IOST,1,2)["C-" @IOF,*13 W " LOG #: ",IBDA,?15,$S($D(^DIC($P($G(^IBE(350.6,+IBDA,0)),"^",3),0)):$P(^(0),"^"),1:"FILE UNSPECIFIED"),?(IOM-25),$$DAT2^IBOUTL(%),!
 F I=1:1:IOM W "="
 S IBLOG0=$G(^IBE(350.6,+IBDA,0)),IBLOG1=$G(^(1)),IBLOG2=$G(^(2)),IBLOG3=$G(^(3))
 W !!,$J("Search Template : ",27),$S($P(IBLOG0,"^",2)]"":$P(IBLOG0,"^",2),1:"UNSPECIFIED")
 S IBX=$S($P(IBLOG3,"^",2):"Purged",$P(IBLOG2,"^",2):"Archived",1:"Found")
 W !,$J("# Records "_IBX_" : ",27),+$P(IBLOG0,"^",4)
 W !,$J("Log Status : ",27),$P("OPEN^CLOSED^CANCELLED","^",+$P(IBLOG0,"^",5))
 F I=1,2,3 D
 . S IBNOD="IBLOG"_I,IBNAM=$P("Search^Archive^Purge","^",I)
 . Q:@IBNOD=""
 . S Y=+@IBNOD W !!,$J(IBNAM_" Begin Date/Time : ",27),$S(Y:$$DAT2^IBOUTL(Y),1:"UNSPECIFIED")
 . S Y=$P(@IBNOD,"^",2) W !,$J(IBNAM_" End Date/Time : ",27),$S('Y:"UNSPECIFIED",1:$$DAT2^IBOUTL(Y))
 . S Y=$P(@IBNOD,"^",3) W !,$J(IBNAM_" Initiator : ",27),$S($D(^VA(200,Y,0)):$P(^(0),"^"),1:"UNSPECIFIED")
 F I=$Y:1:(IOSL-4) W !
 I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
 Q:$D(ZTQUEUED)  D ^%ZISC
INQQ K DIRUT,DUOUT,DTOUT,IBDA,IBLOG0,IBLOG1,IBLOG2,IBLOG3,IBX,X,Y
 Q
 ;
 ;
TMP ; List Search Template Entries
 S IBF=$$SEL^IBPUDEL G TMPQ:'IBF
 ;
 ; - display selection
 W ! F I=1:1:80 W "-"
 W !,"Template entries will be listed for the following file:"
 S IBOP=$P(IBD(IBF),"^",2),IBLOG=$P(IBD(IBF),"^",3)
 W !,$P($G(^DIC(IBF,0)),"^"),"      Entries ",$S(IBOP>2:"Archived",1:"Found")," on ",$$DAT2^IBOUTL($P($G(^IBE(350.6,IBLOG,IBOP-1)),"^",2)),!
 F I=1:1:80 W "-"
 W !!,"Specify Sort Criteria:",!
 ;
 ; - print list
 S DIC=^DIC(IBF,0,"GL"),L=0,FLDS=$S(IBF=399:".02;L25,.07;L20,.13;L10,.14",IBF=351:".02,.03,.04,.1",1:".02;L25,.08,.05;L10,DATE(#12);""DATE ADDED""")
 S BY="[IB ARCHIVE/PURGE #"_$$LOGIEN^IBPU1(IBF)_"],@.02,@",DHD=$P(^DIC(IBF,0),"^")_" SEARCH TEMPLATE"
 D EN1^DIP
 ;
TMPQ K I,IBD,IBF,IBLOG,IBOP,IBTM,IBTMDA,J,K
 Q

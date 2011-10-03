IBDFDE9 ;ALB/AAS - AICS Manual Data Entry, Report of inputs by form ; 31-MAY-96
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**51**;APR 24, 1997
 ;
 W !,?4,"** This option is OUT OF ORDER **" QUIT   ;Code set Versioning
 ;
% N I,J,X,Y,DIR,DIRUT,DTOUT,DUOUT,IBDF,IBDFMIEN,IBDPAG,IBDPDT,IBDOJB,IBQUIT,QLFR,RULE
 ;
 I '$D(DT) D DT^DICRW
 D HOME^%ZIS
 W !!,"Display Form Components for Data Entry",!!
 ;
STRT ; -- ask for form id
 D END
 S DIR("?")="Enter the Encounter Form Name you want to review."
 S DIR(0)="PO^357:AEQM",DIR("A")="Select Encounter Form" D ^DIR K DIR,DA,DR,DIC
 I $D(DIRUT) G END
 S IBDFMIEN=+Y
 ;
 ; -- Ask Device
 S %ZIS="MQ" D ^%ZIS I POP G STRTQ
 ; -- queue if selected
 I $D(IO("Q")) S ZTSAVE("IBD*")="",ZTRTN="DQ^IBDFDE9",ZTDESC="IBD - Print form components" D ^%ZTLOAD W !,$S($D(ZTSK):"Request Queued Task="_ZTSK,1:"Request Canceled") D HOME^%ZIS W !! G STRT
 U IO
 S X="IOINHI;IOINORM" D ENDR^%ZISS
 D DQ
 ;
STRTQ G:$G(IBQUIT) END D PAUSE^IBDFDE
 G STRT
 ;
DQ ; -- entry point to list contents of one form,  
 ;    Input IBDFMIEN := pointer to Encounter Form (357)
 ;
 S IBQUIT=0
 S IBDPAG=0
 S IBDPDT=$$FMTE^XLFDT($$NOW^XLFDT)
 D HDR
 ;
 I '$D(^TMP("IBD-OBJ",$J,IBDFMIEN,0)) D FRMLSTI^IBDFRPC("^TMP(""IBD-OBJ"",$J,IBDFMIEN)",IBDFMIEN,"",1)
 D LISTOB
 Q
 ;
LISTOB ; -- list items available for input on a form
 W !,"CHECKOUT INTERVIEW",?27,"",?45,"As Required",!
 S I=0 F  S I=$O(^TMP("IBD-OBJ",$J,IBDFMIEN,I)) Q:I=""!(IBQUIT)  D
 .I $E(IOST,1,2)="C-",$Y>(IOSL-5) D HDR Q:IBQUIT
 .S IBDOBJ=$G(^TMP("IBD-OBJ",$J,IBDFMIEN,I))
 .Q:'$P(IBDOBJ,"^",8)
 .S IBDF("PI")=+$P(IBDOBJ,"^",2),IBDF("TYPE")=$P(IBDOBJ,"^",5)
 .S IBDF("IEN")=+$P(IBDOBJ,"^",6),IBDF("VITAL")=$P(IBDOBJ,"^",7)
 .Q:IBDF("IEN")<1!(IBDF("PI")<1)
 .S RTN=$G(^IBE(357.6,IBDF("PI"),18)) Q:RTN=""
 .S Y=$S($P(IBDOBJ,"^",7)="":$P(IBDOBJ,"^"),1:$P(IBDOBJ,"^",7))
 .I Y["INPUT " S Y=$P(Y,"INPUT ",2)
 .W !,$E(Y,1,25),?27,$S(IBDF("TYPE")="HP":"Hand Print",IBDF("TYPE")="LIST":"Selection List",1:"Multiple Choice")
 .;
 .S IBDF("DFN")=$O(^DPT(0)),IBDF("CLINIC")=$O(^SC(0)),IBDF("RULE-ONLY")=1
 .S RULE(0)=$G(^TMP("IBD-LST",$J,IBDFMIEN,IBDF("PI"),IBDF("IEN")))
 .I RULE(0)="" D OBJLST^IBDFRPC1(.RULE,.IBDF)
 .D RULES(.RULE)
 .W !
 W !
 Q
 ;
HDR ; -- print patient header
 S IBDPAG=IBDPAG+1
 I $E(IOST,1,2)="C-",$Y>1,IBDPAG>1 D PAUSE^IBDFDE Q:IBQUIT
 I $E(IOST,1,2)="C-"!(IBDPAG>1) W @IOF
 W !,"Form Components Available for Data Entry",?IOM-32,IBDPDT,"  PAGE: ",IBDPAG
 W !,"COMPONENT",?27,"TYPE",?45,"RULE",?60,"QUALIFIER"
 W !,$TR($J(" ",IOM)," ","-")
 W !,"       Form Name: ",$E($P($G(^IBE(357,+IBDFMIEN,0)),"^"),1,25)
 W !,"     Form Status: ",$S(+$P($G(^IBE(357,+IBDFMIEN,0)),"^",5):"Compiled",1:"Uncompiled"),!
 Q
 ;
END I $D(ZTQUEUED) S ZTREQ="@" Q
 K I,J,X,Y,DA,DR,DIC,DIE,DIR,DTOUT,DUOUT,DIRUT,IBDSEL,CHOICE,TEXT,TEXTU,RESULT,IBDPI,IBDCO,IBDF,IBDPAG,ZTSK
 K ^TMP("IBD-OBJ",$J)
 D ^%ZISC
 Q
 ;
RULES(RULE) ; -- look at zero node, find qualifiers and selection rule
 N I,QLFR,DQR
 S RULE=$P(RULE(0),"^",3),QLFR=""
 I $P(RULE(0),"^",4) W ?45,"Data Entry Not allowed",!,?45,"Marking areas not Bubbles" Q
 F I=1:1 S ROW=$P(RULE,"::",I) Q:ROW=""  S QLFR(I)=$P(ROW,";;",1),RULE(I)=$P(ROW,";;",2) D
 .W:I>1 !
 .;
 .I IBDF("VITAL")="" W ?45,$P("Any Number^Exactly One^At Most One^At Least One","^",(RULE(I)+1))
 .E  W ?45,"Optional"
 .;
 .I IBDF("VITAL")'="",QLFR(I)[":" S QLFR(I)=$P(QLFR(I),":") ;strip ":"
 .W ?60,$E(QLFR(I),1,20)
 .I QLFR(I)="",$P($G(^IBE(357.6,+$G(IBDF("PI")),0)),"^",19) W ?60,$G(IOINHI),"Required/Missing",$G(IOINORM)
 .I QLFR(I)="PRIMARY" D
 ..;S RULE(I)=$S(RULE(I)=3:1,RULE(I)=0:2,1:RULE(I))
 S RULE=I-1
 Q

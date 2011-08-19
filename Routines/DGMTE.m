DGMTE ;ALB/RMO,CAW,LD,SCG - Edit an Existing Means Test ;03 APR 2002 2:00 pm
 ;;5.3;Registration;**33,45,182,344,332,433,624**;Aug 13, 1993
 ;
EN ;Entry point to edit an existing means test
 N DGMDOD S DGMDOD=""
 I DGMTYPT=1 S DIC("S")="I $P(^(0),U,14)"
 I DGMTYPT=2!(DGMTYPT=4) S DIC("S")="I $D(^DGMT(408.31,""AID"",DGMTYPT,+Y))"
 I $D(DGMTDFN)#2 D UNLOCK^DGMTUTL(DGMTDFN) K DGMTDFN
 S DIC="^DPT(",DIC(0)="AEMQ" W ! D ^DIC K DIC G Q:Y<0 S (DFN,DGMTDFN)=+Y
 I $P($G(^DPT(DFN,.35)),U)'="" S DGMDOD=$P(^DPT(DFN,.35),U)
 I $G(DGMDOD) W !,"Patient died on: ",$$FMTE^XLFDT(DGMDOD,"1D") Q
 ;
 ; check if income test upload in progress
 D CKUPLOAD^IVMCUPL(DFN)
 ;
 ; obtain lock used to synchronize local MT/CT options with income test upload
 I $$LOCK^DGMTUTL(DFN)
 ;
DT S DIC("A")="Select DATE OF TEST: "
 N FUTFLG,VSITE S FUTFLG=0,VSITE=+$P($$SITE^VASITE(),U,3)
 I $D(^DGMT(408.31,+$$FUT^DGMTU(DFN,"",DGMTYPT),0)),+$P($G(^(2)),U,5)=VSITE S DIC("B")=$P(^(0),"^"),FUTFLG=1
 I 'FUTFLG I $D(^DGMT(408.31,+$$LST^DGMTU(DFN,"",DGMTYPT),0)) S DIC("B")=$P(^(0),"^")
 S DIC("S")="I $P(^(0),U,2)=DFN,$P(^(0),U,19)=DGMTYPT"
 S:DGMTYPT'=4 DIC("S")=DIC("S")_" I $G(^(""PRIM""))!($P(^(0),U,1)>DT)"
 S DIC="^DGMT(408.31,",DIC(0)="EQZ" W ! D EN^DGMTLK K DIC G Q:Y<0
 S DGMTI=+Y,DGMTDT=$P(Y,"^",2),DGMT0=Y(0)
 ;
 ;If test is uneditable, print error message and allow user to view test
 ;or print 10-10EZ/EZR
 ;
 I '$P($G(^DG(408.34,+$P(Y(0),U,23),0)),U,2) D  D:$G(DGMTERR) VIEWPRT G EN
 .W !!?3,*7,"Warning: Uneditable "_$S(DGMTYPT=1:"means",1:"copay")_" test.  The source of this test is "_$S($$SR^DGMTAUD1(Y(0))]"":$$SR^DGMTAUD1(Y(0)),1:"UNKNOWN")
 .W !?12,"which has been flagged as an uneditable source.",!
 .S DIR("A")="Would you like to view the "_$S(DGMTYPT=1:"means",1:"copay")_" test or print the 10-10EZR/EZ",DIR("B")="NO",DIR(0)="Y"
 .D ^DIR K DIR S DGMTERR=Y I $D(DTOUT)!($D(DUOUT)) K DGMTERR,DTOUT,DUOUT
 I "^3^10^"[("^"_$P(Y(0),"^",3)_"^") W !?3,*7,$S(DGMTYPT=1:"Means",1:"Copay")_" test is NO LONGER "_$S(DGMTYPT=1:"REQUIRED",1:"APPLICABLE")_", it cannot be edited." G EN
 I DGMTYPT=4,$P($G(^DGMT(408.31,DGMTI,2)),U,8) D  I $G(DGOUT) K DGOUT G EN
 .N DGMT,DGT S DGMT=$P(^DGMT(408.31,DGMTI,2),U,8),DGT=$P($G(^DGMT(408.31,DGMT,0)),U,19)
 .I DGT,DGT>2 Q
 .W !!,?3,"This LTC copay exemption test is linked to the ",$$FTIME^DGMTUTL(+^DGMT(408.31,DGMT,0)),$S(DGT=1:" means",1:" RX copay")," test."
 .W !,?3,"Changes should be made using the 'Edit an Existing ",$S(DGT=1:"Means",1:"Copay Exemption")," Test'"
 .W !,?3,"menu option."
 .S DGOUT=1
 D DISPLAY^DGMTU23(DGMTI,DGMTYPT),PAUSE I $D(DTOUT)!($D(DUOUT)) K DTOUT,DUOUT G EN
 ;
 ;hardship determination, once granted, will remain unless deleted by
 ;hardship option
 ;I $P(DGMT0,"^",20),'$$EDIT() G EN ; if hardship
 ;
 S DGMTACT="EDT",DGMTROU="EN^DGMTE" G EN^DGMTSC
 ;
Q K DFN,DGMTACT,DGMTDT,DGMTERR,DGMT0,DGMTI,DGMTROU,DGMTYPT,DGMTX,DGOUT,DTOUT,DUOUT,X,Y
 ;
 ; release lock used to synchronize local MT/CT options with income test upload
 I $D(DGMTDFN)#2 D UNLOCK^DGMTUTL(DGMTDFN) K DGMTDFN
 Q
 ;
PAUSE S DIR(0)="E" D ^DIR
 Q
 ;
VIEWPRT ; Select 1 to view an uneditable means test or 2 to print a 10-10EZ/EZR
 ;
 S DIR(0)="S^1:View Means Test;2:Print Means Test 10-10EZR/EZ",DIR("A")="Select Choice"
 D ^DIR S DGMTANS=Y G:$D(DTOUT)!($D(DUOUT)) VIEWPRTQ
 I DGMTANS=1 D EN1^DGMTV
 I DGMTANS=2 D 
 .N RPTSEL,DGTASK
 .D FULL^VALM1
 .S (RPTSEL,DGTASK)=""
 .I $D(DGFINOP) DO
 ..W !!,"Options for printing financial assessment information will follow."
 ..W !,"Generally, you should answer 'YES' to 'PRINT 10-10EZR?' after updating"
 ..W !,"patient demographic or financial information.  Answer 'YES' to 'PRINT"
 ..W !,"10-10EZ?' after entering new patient demographic and financial information."
 .S RPTSEL=$$SEL1010^DG1010P("EZR/EZ") ;*Select 1010EZ/R form to print
 .S:RPTSEL'="-1" DGTASK=$$PRT1010^DG1010P(RPTSEL,DFN,DGMTI) ;*Print 1010EZ/R
 ;
VIEWPRTQ ;
 K DGMTANS,DIR,DTOUT,DUOUT,Y
 Q
 ;
EDIT() ; want to edit even though MT is hardship?
 ;
 ; Output:  1 if user wants to edit, 0 otherwise
 ;
 N DIR,DTOUT,DUOUT,DIRUT,DIROUT,I,X,Y
 S DIR("?",1)="WARNING:  You are about to access a means test for which a hardship has"
 S DIR("?",2)="          been authorized.  If you proceed, the hardship will be removed"
 S DIR("?",3)="          and the means test category will be recalculated!  To avoid"
 S DIR("?",4)="          this problem, enter NO at the next prompt and use the 'View"
 S DIR("?",5)="          a Past Means Test' option should you need to see details of"
 S DIR("?",6)="          this means test."
 S DIR("?",7)=" "
 S DIR("?")="Enter NO to stop editing this means test.  Enter YES to continue"
 F I=1:1 Q:'$D(DIR("?",I))  W !,DIR("?",I)
 S DIR("A")="Do you want to continue editing this means test?  ",DIR("B")="NO",DIR(0)="YA"
 D ^DIR
 Q Y

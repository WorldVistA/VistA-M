EASECE ;ALB/PHH,LBD - Edit an Existing LTC Co-Pay Test ;17 AUG 2001
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**5,7,34,40**;Mar 15, 2001
 ;
EN ;Entry point to edit an existing LTC co-pay test
 N DGMDOD S DGMDOD="",DGMTYPT=3
 S DIC("S")="I $D(^DGMT(408.31,""AID"",DGMTYPT,+Y))"
 I $D(DGMTDFN)#2 K DGMTDFN
 S DIC="^DPT(",DIC(0)="AEMQ" W ! D ^DIC K DIC G Q:Y<0 S (DFN,DGMTDFN)=+Y
 I $P($G(^DPT(DFN,.35)),U)'="" S DGMDOD=$P(^DPT(DFN,.35),U)
 I $G(DGMDOD) W !,"Patient died on: ",$$FMTE^XLFDT(DGMDOD,"1D") Q
 ;
DT S DIC("A")="Select DATE OF LTC COPAY TEST: "
 I $D(^DGMT(408.31,+$$LST^EASECU(DFN,"",DGMTYPT),0)) S DIC("B")=$P(^(0),"^")
 S DIC("S")="I $P(^(0),U,2)=DFN,$P(^(0),U,19)=DGMTYPT"
 S DIC="^DGMT(408.31,",DIC(0)="EQZ" W ! D EN^DGMTLK K DIC G Q:Y<0
 S DGMTI=+Y,DGMTDT=$P(Y,"^",2),DGMT0=Y(0)
 ;
 ;If test is uneditable, print error message and allow user to view test
 ;or print 10/10EC
 ;
 I '$P($G(^DG(408.34,+$P(Y(0),U,23),0)),U,2) D  D:$G(DGMTERR) VIEWPRT G EN
 .W !!?3,*7,"Warning: Uneditable LTC Copay test.  The source of this test is "_$S($$SR^DGMTAUD1(Y(0))]"":$$SR^DGMTAUD1(Y(0)),1:"UNKNOWN")
 .W !?12,"which has been flagged as an uneditable source.",!
 .S DIR("A")="Would you like to view the LTC Copay test or print the 10-10EC",DIR("B")="NO",DIR(0)="Y"
 .D ^DIR K DIR S DGMTERR=Y I $D(DTOUT)!($D(DUOUT)) K DGMTERR,DTOUT,DUOUT
 ;
 ; If user holds DG MTDELETE security key, allow test date to be edited.
 ; LTC III (EAS*1*34)
 I $D(^XUSEC("DG MTDELETE",+$G(DUZ))) D
 .N DIR,DA,DR,DIE,X,Y,DTOUT,DUOUT,DIROUT,DIRUT,DGNEWDT
 .S DIR(0)="D^:DT:EX",DIR("A")="DATE OF TEST",DIR("B")=$$FMTE^XLFDT(DGMTDT,1)
 .S DIR("?")="Enter a date that is less than or equal to today."
 .S DIR("?",1)="Enter the date of the LTC Copay Test."
 .D ^DIR K DIR Q:'Y!(Y=DGMTDT)  S DGNEWDT=Y
 .S DIR(0)="Y",DIR("A")="Are you sure you want to change the date of the LTC Copay Test",DIR("B")="NO" D ^DIR Q:'Y
 .S DIE="^DGMT(408.31,",DA=DGMTI,DR=".01////"_DGNEWDT_";2.02///NOW"
 .D ^DIE
 ;
EXMPT ; Is veteran exempt?
 S DGEXMPT=$$EXMPT^EASECU(DFN)
 I DGEXMPT D EXMPT^EASECSCC(DFN,DGMTI,DGEXMPT) D Q G EN
 ;
 D DISPLAY^EASECU23(DGMTI,DGMTYPT),PAUSE I $D(DTOUT)!($D(DUOUT)) K DTOUT,DUOUT G EN
 ;
 ; Allow user to edit LTC copay test status or reason for exemption.
 ; If veteran is exempt for reason other than low income, don't do
 ; income check.  Added for LTC Phase IV (EAS*1*40)
 W ! S DGEFLG=1 D STA^EASECSCC K DGEFLG
 I $G(DGSTA)="EXEMPT",$G(DGRE),"^2^12^"'[(U_DGRE_U) D EXMPT^EASECSCC(DFN,DGMTI,DGRE) D Q G EN
 S DGNSTA=$G(DGSTA)
 ;
 ; Check if veteran's income is below the pension threshold
 D EN^EASECMT I $G(DGOUT) D Q G EN
 I DGEXMPT D EXMPT^EASECSCC(DFN,DGMTI,2) D Q G EN
 S DGMT0=$G(^DGMT(408.31,DGMTI,0)) F I=4,5,15 I $P(DGMT0,U,I) G EDT
 ; Display message for vets who declined to provide income info
 ; LTC III (EAS*1*34)
 I $P(DGMT0,U,14)=1 D
 .W !! F I=1:1:80 W "="
 .W !!,?10,"Veteran is NOT EXEMPT from Long Term Care copayments and"
 .W !,?10,"must complete a 10-10EC form."
 .W !! F I=1:1:80 W "="
 ; Does veteran decline to provide income information?
 W !!
 D REF^EASECSCC I $D(DTOUT)!($D(DUOUT)) D Q G EN
 I $D(DGREF) D  D Q G EN
 .; Ask if veteran agrees to pay copayments; complete LTC copay test
 .D AGREE^EASECSCC Q:$D(DTOUT)!($D(DUOUT))
 .S DGSTA="NON-EXEMPT",DGCAT="T" D STA^DGMTSCU2 S (DGINT,DGDET,DGNWT)=""
 .D UPD^EASECSCC
 ;
EDT S DGMTACT="EDT",DGMTROU="EN^EASECE" G EN^EASECSC
 ;
Q K DFN,DGEXMPT,DGMTACT,DGMTDT,DGMTERR,DGMT0,DGMTI,DGMTROU,DGMTYPT,DGMTX,DGOUT,DTOUT,DUOUT,X,Y
 K DGREF,DGSTA,DGCAT,DGINT,DGDET,DGNWT,I,DGFORM,DGMTS,DGRE,DGNSTA
 Q
 ;
PAUSE S DIR(0)="E" D ^DIR
 Q
 ;
VIEWPRT ; Select 1 to view an uneditable means test or 2 to print a 10/10EC
 ;
 S DIR(0)="S^1:View LTC Copay Test;2:Print LTC Copay Test 10-10EC",DIR("A")="Select Choice"
 D ^DIR S DGMTANS=Y G:$D(DTOUT)!($D(DUOUT)) VIEWPRTQ
 I DGMTANS=1 D EN1^EASECV
 I DGMTANS=2 D OEN^EASEC10E
VIEWPRTQ ;
 K DGMTANS,DIR,DTOUT,DUOUT,Y
 Q
 ;

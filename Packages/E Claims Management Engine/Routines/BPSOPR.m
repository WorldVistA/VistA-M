BPSOPR ;ALB/PHH - OPECC Productivity Report ;9/21/2015
 ;;1.0;E CLAIMS MGMT ENGINE;**20**;JUN 2004;Build 27
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN ; Main report entry point
 N BPGLTMP,BPNOW,X,BPPHARM,BPELIG,BPUSER,BPBEGDT,BPENDDT,BPSUMDET
 N BPSSORD,BPEXCEL
 ;
 W @IOF,!,"OPECC Productivity Report",!!
 ;
 S BPGLTMP=$NA(^TMP($J,"BPSOPR"))
 ;
 ; Get current Date/Time
 S BPNOW=$$FMTE^XLFDT($$NOW^XLFDT)
 ;
 ; Prompt for ECME Pharmacy Division(s)
 ; Sets up BPPHARM variable and array where BPPHARM=0 for ALL
 ; or BPPHARM=1 and BPPHARM(IEN) = IEN^NAME for list.
 S X=$$SELPHARM(.BPPHARM)
 I X="^" Q
 ;
 ; Prompt for Eligibility Type(s)
 ; Sets up BPELIG variable and array where BPELIG=0 for ALL
 ; or BPELIG=1 and BPELIG(IEN) = IEN^NAME for list.
 S X=$$SELELIG(.BPELIG)
 I X="^" Q
 ;
 ; Prompt for ECME User(s)
 ; Sets up BPUSER variable and array where BPUSER=0 for ALL
 ; or BPUSER=1 and BPUSER(IEN) = IEN^NAME for list.
 S X=$$SELUSER(.BPUSER)
 I X="^" Q
 ;
 ; Prompt to select Date Range
 ; Returns (Start Date^End Date)
 S BPBEGDT=$$SELDATE^BPSRPT3(1)
 I BPBEGDT="^" Q
 S BPENDDT=$P(BPBEGDT,U,2)
 S BPBEGDT=$P(BPBEGDT,U)
 ;
 ; Prompt to Display Summary or Detail Format (Default to Detail)
 ; Set to 1 for Summary, 0 for Detail
 S BPSUMDET=$$SELSMDET^BPSRPT3(2)
 I BPSUMDET="^" Q
 ;
 ; Prompt for Sort Order
 ; Set to 1 for User Name, 0 for Division
 S BPSSORD=$$SELSORT(1)
 I BPSSORD="^" Q
 ;
 ; Prompt for Excel Capture
 ; Set to 1 for YES (capture data), 0 for NO (DO NOT capture data)
 S BPEXCEL=0
 I 'BPSUMDET S BPEXCEL=$$SELEXCEL I BPEXCEL="^" Q
 ;
 ; Device selection
 I '$$DEVICE() Q
 ;
 Q
 ;
SELSORT(DFLT) ; Select Sort Order
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 ;
 S DFLT=$S($G(DFLT)=1:"User Name",$G(DFLT)=0:"Division",1:"User Name")
 S DIR(0)="S^D:Division;U:User Name",DIR("A")="Sort:  (D/U)",DIR("B")=DFLT
 ;
 W !!,"Enter a code from the list to indicate the sort order."
 D ^DIR
 I ($G(DUOUT)=1)!($G(DTOUT)=1) S Y="^"
 S Y=$S(Y="U":1,Y="D":0,1:Y)
 Q Y
 ;
SELEXCEL() ; Select whether to capture data for Excel report.
 N BPEXCEL,DIR,DIRUT,DTOUT,DUOUT,DIROUT
 ;
 S BPEXCEL=0
 S DIR(0)="Y",DIR("B")="NO",DIR("T")=DTIME W !
 S DIR("A")="Do you want to capture report data for an Excel document"
 S DIR("?")="^D HEXC^BPSRPT4"
 ;
 D ^DIR
 K DIR
 I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q "^"
 I Y S BPEXCEL=1
 ;
 ;Display Excel display message
 I BPEXCEL=1 D
 .W !!?5,"Before continuing, please set up your terminal to capture the"
 .W !?5,"detail report data and save the detail report data in a text file"
 .W !?5,"to a local drive. This report may take a while to run."
 .W !!?5,"Note: To avoid undesired wrapping of the data saved to the file,"
 .W !?5,"      please enter '0;256;99999' at the 'DEVICE:' prompt.",!
 ;
 Q BPEXCEL
 ;
DEVICE() ; Device Selection
 N ZTRTN,ZTDESC,ZTSAVE,POP,RET,ZTSK,DIR,X,Y
 S RET=1
 ;
 I 'BPEXCEL D
 .W !!,"WARNING - THIS REPORT REQUIRES THAT A DEVICE WITH 132 COLUMN WIDTH BE USED."
 .W !,"IT WILL NOT DISPLAY CORRECTLY USING 80 COLUMN WIDTH DEVICES",!
 ;
 S ZTRTN="COMPILE^BPSOPR2"
 S ZTDESC="OPECC Productivity Report"
 S ZTSAVE("BPGLTMP")=""
 S ZTSAVE("BPPHARM")=""
 S ZTSAVE("BPELIG")=""
 S ZTSAVE("BPUSER")=""
 S ZTSAVE("BPBEGDT")=""
 S ZTSAVE("BPENDDT")=""
 S ZTSAVE("BPSUMDET")=""
 S ZTSAVE("BPSSORD")=""
 S ZTSAVE("BPEXCEL")=""
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE,"QM",1)
 I POP S RET=0
 I $G(ZTSK) W !!,"Report compilation has started with task# ",ZTSK,".",! S DIR(0)="E" D ^DIR
 Q RET
 ;
SELPHARM(BPPHARM) ; Select Pharmacies
 N DIR,BPSFPTR,BPSPTX,X
 ;
 S DIR(0)="S^D:DIVISION;A:ALL"
 S DIR("A")="Select Certain Pharmacy (D)ivisions or (A)LL"
 S DIR("B")="A"
 S DIR("L",1)="Select one of the following:"
 S DIR("L",2)=""
 S DIR("L",3)="     D         DIVISION"
 S DIR("L",4)="     A         ALL"
 S BPSFPTR=9002313.56
 S BPSPTX="Select ECME Pharmacy Division(s): "
 ;
 S X=$$SELMULTI(.DIR,.BPPHARM,BPSFPTR,BPSPTX)
 Q X
 ;
SELELIG(BPELIG) ;Select Eligibility Types
 N DIR,X
 ;
 S DIR(0)="SO^V:VETERAN;T:TRICARE;C:CHAMPVA;A:ALL"
 S DIR("A")="Include Certain Eligibility Type or (A)ll"
 S DIR("B")="A"
 ;
 S X=$$SELMULTI(.DIR,.BPELIG)
 Q X
 ;
SELUSER(BPUSER) ; Select Users
 N DIR,BPSFPTR,BPSPTX,X
 ;
 S DIR(0)="S^U:USER;A:ALL"
 S DIR("A")="Display ECME (U)ser or (A)LL"
 S DIR("B")="A"
 S BPSFPTR=200
 S BPSPTX="Select ECME User(s): "
 ;
 S X=$$SELMULTI(.DIR,.BPUSER,BPSFPTR,BPSPTX)
 Q X
 ;
SELMULTI(BPSDIR,BPSVAR,BPSFPTR,BPSPTX) ;
 ; Input Variable -> BPSDIR - DIR array
 ;                   BPSVAR - Variable array
 ;                   BPSFPTR - File pointer (optional)
 ;                   BPSPTX - Prompt text for DIC("A") (optional)
 ; Return Value ->   "" = Valid Entry or Entries Selected
 ;                   ^ = Exit
 ;                                       
 ; Output Variable -> BPSVAR = 1 One or more items selected
 ;                           = 0 User entered 'ALL'
 ;                            
 ; If BPSVAR = 1 then the BPSVAR array will be defined where:
 ;    BPSVAR(ptr) = ptr ^ NAME and
 ;    ptr = Internal pointer to file passed in
 ;                    
 N BPDELFLG,DIR,DIC,DIRUT,DTOUT,DUOUT,X,Y
 ;
 S BPSFPTR=$G(BPSFPTR,"")
 S BPSPTX=$G(BPSPTX,"")
 ;
 ;First see if they want to enter individual items or ALL
 S BPDELFLG=0   ;Only used for DIR.  Not used for DIC.
 M DIR=BPSDIR
 D ^DIR
 K DIR
 ;
 ;Check for "^" or timeout, otherwise define BPSVAR
 I ($G(DUOUT)=1)!($G(DTOUT)=1) S Y="^"
 E  S BPSVAR=$S(Y="A":0,1:1)
 ;
 ;If item selected, ask prompt
 I $G(BPSVAR)=1 F  D  Q:Y="^"!(Y="") 
 .;
 .;Prompt for entry
 .I BPSFPTR'="" D
 ..K X
 ..S DIC(0)="QEAM",DIC=BPSFPTR,DIC("A")=BPSPTX
 ..W !
 ..D ^DIC
 .;
 .I BPSFPTR="" D
 ..I 'BPDELFLG D
 ...S BPSVAR(Y)=Y_"^"_Y(0)
 ...S BPSVAR("B",Y(0),Y)=""
 ..K DIR
 ..M DIR=BPSDIR
 ..K DIR("B")
 ..D ^DIR
 .;
 .;Check for "^" or timeout
 .I ($G(DUOUT)=1)!($G(DTOUT)=1) K BPSVAR S Y="^" Q
 .;
 .;Check for blank entry, quit if no previous selections
 .I $G(X)="" S Y=$S($D(BPSVAR)>9:"",1:"^") K:Y="^" BPSVAR Q
 .;
 .;Handle deletes
 .I BPSFPTR'="" D
 ..I $D(BPSVAR(+Y)) D  Q:Y="^"  I 1
 ...N P
 ...S P=Y  ;Save Original Value
 ...S DIR(0)="S^Y:YES;N:NO",DIR("A")="Delete "_$P(P,U,2)_" from your list?"
 ...S DIR("B")="NO" D ^DIR
 ...I ($G(DUOUT)=1)!($G(DTOUT)=1) K BPSVAR S Y="^" Q
 ...I Y="Y" K BPSVAR(+P),BPSVAR("B",$P(P,U,2),+P)
 ...S Y=P  ;Restore Original Value
 ...K P
 ..E  D
 ...;Define new entries in BPSVAR array
 ...S BPSVAR(+Y)=Y
 ...S BPSVAR("B",$P(Y,U,2),+Y)=""
 .;
 .I BPSFPTR="" D
 ..I $D(BPSVAR(Y)) D  Q:Y="^"  I 1
 ...N P
 ...S P=Y,P(0)=Y(0)  ;Save Original Value
 ...S DIR(0)="S^Y:YES;N:NO",DIR("A")="Delete "_P(0)_" from your list?"
 ...S DIR("B")="NO" D ^DIR
 ...I ($G(DUOUT)=1)!($G(DTOUT)=1) K BPSVAR S Y="^" Q
 ...S BPDELFLG=0
 ...I Y="Y" S BPDELFLG=1 K BPSVAR(P),BPSVAR("B",P(0),P)
 ...S Y=P,Y(0)=P(0)  ;Restore Original Value
 ...K P
 ..E  D
 ...;Define new entries in BPSVAR array
 ...S BPSVAR(Y)=Y_"^"_Y(0)
 ...S BPSVAR("B",Y(0),Y)=""
 .;
 .;Display a list of selected items
 .I $D(BPSVAR)>9 D
 ..N X
 ..W !,?2,"Selected:"
 ..S X=""
 ..F  S X=$O(BPSVAR("B",X)) Q:X=""  D
 ...W !,?10,X
 ..K X
 ;
 K BPSVAR("B")
 I $G(BPSVAR)=1,$G(BPSVAR("A"))="A^ALL" K BPSVAR S BPSVAR=0
 Q Y
 ;

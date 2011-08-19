PSDNMU ;DOIFO/CMS - CS Monitoring Utility routine ;17 Dec 02
 ;;3.0; CONTROLLED SUBSTANCES ;*41*;13 Feb 97 
 ;Reference to ^PSD(58.8 supported by IA #2711
 ;Reference to ^PS(59 supported by IA #2621
 Q
 ;
CII ;Select CS DEA Codes
 ; Return PSDCII=2,3,4,5 or user selection
 ; Return PSDOUT=1 if '^" entered
 N X,Y K DIR,DTOUT,DUOUT,PSDOUT
 S DIR(0)="L^2:5:0",DIR("A")="Include RXs with CS schedule(s)"
 S DIR("B")="2"
 S DIR("?")="Enter range or combination of DEA Codes (schedules) from 2 to 5.     Enter '^' to exit."
 D ^DIR K DIR
 S PSDCII=Y
 I $D(DTOUT)!($D(DUOUT)) K PSDCII S PSDOUT=1
CIIQ K DIR,DIRUT,DIROUT,DTOUT,DUOUT,PSDNO
 Q
 ;
CIIO ;Optional Select CS DEA Codes
 ; Return PSDCII=2,3,4,5 or user selection or null
 ; Return PSDOUT=1 if '^" entered
 N X,Y K DIR,DTOUT,DUOUT,PSDOUT
 W !,"OPTIONAL"
 S DIR(0)="LO^2:5:0",DIR("A")="Include RXs with CS schedule(s)"
 S DIR("?")="Enter range or combination of DEA Codes (schedules) from 2 to 5.   Enter '^' to exit."
 D ^DIR K DIR
 S PSDCII=Y
 I $D(DTOUT)!($D(DUOUT)) K PSDCII S PSDOUT=1
CIIOQ K DIR,DIRUT,DIROUT,DTOUT,DUOUT,PSDNO
 Q
 ;
INPS ;Select Inpatient Site file 59.4
 ; Return PSDIDIV=ien^Name
 ; Return PSDOUT=1  If '^' entered
 N D,DIC,DTOUT,X,Y K PSDIDIV
INPSC S DIC="^PS(59.4,",DIC(0)="QEAM",D="B"
 S DIC("S")="I +$P(^(0),""^"",31)"
 W ! D ^DIC K DIC
 I X="^"!($D(DTOUT)) S PSDOUT=1 G INPSQ
 I +Y<0 W !!,"A CS Inpatient Site must be selected!  Enter '^' to exit." G INPSC
 I +Y S PSDIDIV=Y G INPSQ
INPSQ Q
 ;
PLOC ;Ask Pharmacy Location
 ; PSDIDIV must be defined to selected inpatient site
 ; Return PSDPLOC array  ie. PSDPLOC(file58.8ien)=""
 ; Return PSDOUT=1  If '^' entered
 ;
 N DIC,X,Y K PSDPLOC,PSDOUT
 S DIC("A")="Select Pharmacy Location(s): "
PLOCC S DIC=58.8,DIC(0)="AEMQ",DIC("S")="I $P(^(0),U,3)=+$G(PSDIDIV)" D ^DIC
 I X="^ALL" D PLOCA G PLOCQ
 I X["^"!($D(DTOUT)) K PSDPLOC S PSDOUT=1 G PLOCQ
 I +Y<1,'$O(PSDPLOC(0)) W !!,"A 'Pharmacy Location' must be selected! Enter '^ALL' to select all locations.  Enter '^' to exit." G PLOCC
 I +Y<0,$O(PSDPLOC(0)) G PLOCQ
 S PSDPLOC(+Y)=$P(Y,U,2)
 S DIC("A")="Select another Pharmacy Location: " G PLOCC
PLOCQ K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 Q
 ;
PLOCA ;Get all Pharmacy Location for selected Inpatient Site
 ; Return PSDPLOC(ien)=Name
 N PSDY
 S PSDY=0,PSDPLOC="^ALL"
 F  S PSDY=$O(^PSD(58.8,PSDY)) Q:'PSDY  D
 . I $P($G(^PSD(58.8,PSDY,0)),U,3)'=+PSDIDIV Q
 . S PSDPLOC(PSDY)=$P(^PSD(58.8,PSDY,0),U,1)
 Q
 ;
DISD ;Discharge Days Number
 ;Return PSDISB - Number of Days to ignore before Discharge Date 
 ;Return PSDISA - Number of Days to ignore after Discharge Date
 ;Return PSDOUT=1  If '^' entered
 ;
 N %,%DT,X,Y K DIR,PSDISA,PSDISB
 S DIR(0)="NO^0:3:0",DIR("B")=0
 S DIR("A")="Number of days to ignore BEFORE discharge date"
 S DIR("?")="Enter number of days (0-3) to ignore BEFORE discharge date.  Enter '^' to Exit."
 D ^DIR K DIR
 I +Y S PSDISB=+Y
 I $D(DTOUT)!($D(DUOUT)) S PSDOUT=1 G DISDQ
 S DIR(0)="NO^0:3:0",DIR("B")=0
 S DIR("A")="Number of days to ignore AFTER  discharge date"
 S DIR("?")="Enter number of days (0-3) to ignore AFTER discharge date.  Enter '^' to Exit."
 D ^DIR
 I +Y S PSDISA=+Y
 I $D(DTOUT)!($D(DUOUT)) K PSDISB,PSDISA S PSDOUT=1
DISDQ K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 Q
 ;
DATE ;Ask Date Range
 ; Pass PSDDTN - Name of Date Range (Opt.)
 ; Return PSDSD - Start Date Range ie. 3030109.9999^JAN 10, 2003
 ; Return PSDED - End Date Range ie. 3030118.9999^JAN 19, 2003
 ; Return PSDOUT=1  If '^' entered
 ;
 N %,%DT,X,Y K PSDSD,PSDED,PSDOUT
DST W ! K %DT S %DT="AEP",%DT("A")="Start with "_$G(PSDDTN)_" Date: " D ^%DT
 I X["^" K PSDSD,PSDED S PSDOUT=1 G DATEQ
 I Y<0 W !,"Date Range is required!  Enter '^' to exit." G DST
 S PSDSD=Y D D^DIQ S PSDSD=PSDSD-.0001,$P(PSDSD,"^",2)=Y
 S %DT("A")="End with "_$G(PSDDTN)_" Date: " D ^%DT
 I X["^" K PSDSD,PSDED S PSDOUT=1 G DATEQ
 I Y<PSDSD W !!,"The ending date of the range must be later than the starting date." G DST
 S PSDED=Y D D^DIQ S PSDED=PSDED+.9999,$P(PSDED,"^",2)=Y
DATEQ Q
 ;
 ;
DIV ;Ask Outpatient Division(s)
 ; Return PSDODIV array  ie. PSDODIV(file59ien)=""
 ; Return PSDOUT=1  If '^' entered
 ;
 N DIC,X,Y K PSDODIV,PSDOUT
 S DIC("A")="Select Outpatient Division: "
DIVC S DIC=59,DIC(0)="AEMQ" D ^DIC
 I X["^"!($D(DTOUT)) K PSDODIV S PSDOUT=1 G DIVQ
 I +Y<1,'$O(PSDODIV(0)) W !!,"A 'DIVISION' must be selected!  or Enter '^' to exit." G DIVC
 I +Y<0,$O(PSDODIV(0)) G DIVQ
 S PSDODIV(+Y)=$P(Y,U,2)_"^"_$P($G(^PS(59,+Y,0)),U,6)
 S DIC("A")="Select another Outpatient Division: " G DIVC
DIVQ K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 Q

RMPRPIY3 ;HINCIO/ODJ - PIP Data Entry - HCPCS prompt;3/8/01 ; 12/15/05 10:23am
 ;;3.0;PROSTHETICS;**61,93**;Feb 09, 1996;Build 6
 Q
 ;
 ;***** HCPCS - Prompt for a HCPCS code from either
 ;              an existing stock location or
 ;              the main HCPCS file (661.1)
 ;              called by RMPRPIY9
 ;
 ; Inputs:
 ;    RMPR5 - array of Location data fields...
 ;    RMPR5("STATION IEN") - Station number of selected Location
 ;                           (ptr ^DIC(4,)
 ;    RMPR5("IEN")         - ien of selected Location (ptr ^RMPR(661.5,)
 ;
 ; Outputs:
 ;    RMPR1   - HCPCS data field array (661.1)
 ;    RMPREXC - exit condition
 ;              "" - value entered, continue 
 ;               T - Time out
 ;               P - Prvious field
 ;               ^ - up arrow out
 ;
 ; AAC 12/13/05
 ; Modification to the DIC Lookup to perform any Lookup on a HCPC
 ; code that contains ONLY alph/numeric code for the HCPC code.
 ;
 ;
HCPCS(RMPR5,RMPR1,RMPREXC) ;
 N RMPRERR,DIR,X,Y,DUOUT,DTOUT,DIROUT,DIRUT,DIC,DA,RMPRSTN
 N DIC
 S RMPRERR=0
 S (RMPREXC,RMPRY)=""
 S RMPR1("HCPCS")=$G(RMPR1("HCPCS"))
HCPCS1 S RMPRSTN=RMPR5("STATION IEN")
 ; Change to DIC call is commented  above 12/13/05
 N DIC
 S DIC="^RMPR(661.1,"
 S DIC(0)="AEQM"
 ;
 ; New code for Patch 93 in Set DIC line below.
 ;
 S DIC("S")="I $P(^(0),U,5)=1&($P(^(0),U,1)?.AN)"
 D ^DIC
 ;
 I $D(DTOUT) S RMPREXC="T" G HCPCSX
 I $D(DIROUT) S RMPREXC="P" G HCPCSX
 I X=""!(X["^")!$D(DUOUT) S RMPREXC="^" G HCPCSX
 ;
 ; Change to DIC call included taking this second DIC Lookup out and 
 ; including it in the above first DIC loopup.
 ;
 ;S DIC(0)="EMNZ",RMPRY=Y
 ;S DIC("S")="I $P(^(0),U,5)=1!($P(^(0),U,1)'[""="""
 ;S DIC=661.1
 ;D ^DIC
 ;
 I $D(DTOUT) S RMPREXC="T" G HCPCSX
 I ($G(X)["^")!($D(DUOUT)) S RMPREXC="^" G HCPCSX
 I +Y'>0 D  G HCPCS1
 . W !
 . W "** No HCPCS Selected or Unable to Select Inactive HCPCS..."
 . Q
 S RMPR1("HCPCS")=$P(^RMPR(661.1,+Y,0),"^",1)
HCPCSX Q RMPRERR
 ;
 ;***** QM1 - HCPCS prompt Help - List HCPCS at a Location
 ;            requires RMRPSTN - Station number
 ;                     RMPR5("IEN") - Location ien
 ;
QM1 N DIR,X,Y,DA,DTOUT,DIROUT,DIRUT,DUOUT,RMPRMAX,RMPRLIN,RMPRH,RMPR1
 N RMPRERR,DIC
 S RMPRMAX=5,RMPRLIN=0
 S DIR(0)="EA"
 S DIR("A")="Enter <RETURN> for more or ^ to STOP listing"
 I '$D(^RMPR(661.4,"ASLHI",RMPRSTN,RMPR5("IEN"))) G QM1C
 W !,"List of HCPCS at location: ",RMPR5("NAME")
 S RMPRH=""
QM1A S RMPRH=$O(^RMPR(661.4,"ASLHI",RMPRSTN,RMPR5("IEN"),RMPRH))
 I RMPRH="" G QM1C
 S RMPR1("HCPCS")=RMPRH
 S RMPRERR=$$HPACT^RMPRPIX1(.RMPR1)
 W !,RMPRH,?12,RMPR1("SHORT DESC")
 S RMPRLIN=RMPRLIN+1
 I RMPRLIN'<RMPRMAX G QM1B
 G QM1A
QM1B D ^DIR
 I $D(DTOUT) S RMPREXC="T" G QM1X
 I $D(DIROUT) S RMPREXC="P" G QM1X
 I X="" S RMPRLIN=0 G QM1A
 I X["^"!($D(DUOUT)) S RMPREXC="^" G QM1C
 G QM1A
 ;
 ; after listing HCPCS at location make general DIC call on
 ; HCPCS file 661.1
QM1C S X="?",DIC=661.1,DIC(0)="EQM"
 S DIC("W")="W "" "",$P(^RMPR(661.1,+Y,0),U,2) I $P(^RMPR(661.1,+Y,0),U,5)=0 W ""  **Inactive HCPCS**"""
 D ^DIC
QM1X Q

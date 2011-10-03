RMPRPIY2 ;HINCIO/ODJ - PIP Data Entry - Location Prompt ;3/8/01
 ;;3.0;PROSTHETICS;**61**;Feb 09, 1996
 Q
 ;
 ;***** LOCNM - Prompt for PIP Location by name (used by AE option)
 ;              Use only where location can be added
 ;
 ; Inputs:
 ;    RMPRSTN - Station number
 ;
 ; Outputs:
 ;    RMPREXC - exit condition
 ;    RMPR5   - Array of Location data fields
 ;    RMPRERR - returned error code (ignore for time being)
 ;
LOCNM(RMPRSTN,RMPR5,RMPREXC) ;
 N RMPRERR,DIR,X,Y,DA,DUOUT,DTOUT,DIROUT,RMPRYN,RMPRTDT
 D NOW^%DTC S RMPRTDT=X ;today's date
 S RMPREXC=""
 S RMPRERR=0
 S DIR(0)="FOA^1:30"
 S DIR("A")="Enter Pros Location: "
 I $G(RMPR5("NAME"))'="" S DIR("B")=RMPR5("NAME")
 S DIR("?")="^D QM^RMPRPIY2"
 S DIR("??")="^D QQM^RMPRPIY2"
LOCNM1 D ^DIR
 I $D(DTOUT) S RMPREXC="T" G LOCNMX
 I $D(DIROUT) S RMPREXC="P" G LOCNMX
 I X=""!(X["^")!($D(DUOUT)) S RMPREXC="^" G LOCNMX
 K RMPR5
 D LIKE(RMPRSTN,X,.RMPREXC,.RMPR5)
 I RMPREXC'="" G LOCNM1
 I +$G(RMPR5("IEN")) G LOCNMX
 I $L(X)<3 D  G LOCNM1
 . W !,"Location name must be at least 3 characters long"
 . Q
 S RMPR5("STATION")=RMPRSTN
 S RMPR5("STATION IEN")=RMPRSTN
 S RMPR5("NAME")=X
 ;
 ; Add new Stock Location
LOCNMA D ADDNM(.RMPR5,.RMPRYN,.RMPREXC)
 I RMPREXC'="" G LOCNM1
 I RMPRYN="N" G LOCNM1
 D ADDR(.RMPR5,.RMPREXC) ; get address for new location
 I RMPREXC'="" G LOCNM1
 S RMPR5("STATUS")="A"
 S RMPR5("STATUS DATE")=RMPRTDT
 S RMPR5("USER")=$G(DUZ)
 S RMPRERR=$$CRE^RMPRPIX5(.RMPR5) ; create new location
LOCNMX Q RMPRERR
 ;
 ;***** ADDNM - Prompts for adding a new Stock Location
 ;
 ; Inputs:
 ;    RMPR5
 ;
 ; Outputs:
 ;    RMPRYN
 ;    RMPREXC
 ;    RMPRERR
 ;
ADDNM(RMPR5,RMPRYN,RMPREXC) ;
 N DIR,X,Y,DUOUT,DTOUT,DIROUT,DIRUT,DA
 S RMPREXC=""
 S DIR(0)="Y"
 S DIR("B")="N"
 S DIR("A")="Are you adding '"_RMPR5("NAME")_"' as a new PROS ITEM LOCATION"
 D ^DIR
 I $D(DTOUT) S RMPREXC="T" G ADDNMX
 I $D(DIROUT) S RMPREXC="P" G ADDNMX
 I X=""!(X["^") S RMPREXC="^" G ADDNMX
 S RMPRYN="N" S:Y RMPRYN="Y"
 S RMPREXC=""
ADDNMX Q
 ;
 ;***** ADDR - Prompt for Stock Location Address
 ;
 ; Inputs:
 ;    RMPR5
 ;
 ; Outputs:
 ;    RMPR5
 ;    RMPREXC
 ;
ADDR(RMPR5,RMPREXC) ;
 N DIR,X,Y,DA,DUOUT,DTOUT,DIROUT
 S RMPREXC=""
 S DIR(0)="FOA"
 S DIR("A")="   PROS ITEM LOCATION ADDRESS: "
 S DIR("?")="Answer must be 3-30 characters in length."
 D ^DIR
 I $D(DTOUT) S RMPREXC="T" G ADDRX
 I $D(DIROUT) S RMPREXC="P" G ADDRX
 I X=""!(X["^")!$D(DUOUT) S RMPREXC="^" G ADDRX
 S RMPR5("ADDRESS")=X
ADDRX Q
 ;
 ;***** QM - Single ? Help (for use by Location prompt)
QM D QM1 ;ask if want to list locns.
 I RMPREXC'="" G QMX
 I RMPRYN'="Y" G QMX
 D QM2 ;list locns.
 D QM2H
QMX Q
 ;
 ; Double ? Help
QQM D QM2 ;list locns.
 D QQM1
 Q
 ;
 ; QM1 - ask if want to list locns
 ;
 ; require RMPRSTN - Station number
 ;
 ; sets RMPREXC - exit condition
 ;      RMPRYN  - Y - list, any other response - don't bother
 ;
QM1 N DIR,X,Y,DA,DTOUT,DIROUT,DIRUT,DUOUT,%A
 S RMPRYN="N"
 S DIR("A",1)=" Answer with PROS ITEM LOCATION"
 S DIR("A")=" Do you want the entire PROS ITEM LOCATION List"
 S DIR("?")="^D QM1H^RMPRPIY2"
 S DIR(0)="YO"
 D ^DIR
 I $D(DTOUT) S RMPREXC="T" G QM1X
 I $D(DIROUT) S RMPREXC="P" G QM1X
 I X=""!(X["^")!$D(DUOUT) S RMPREXC="^" G QM1X
 S:Y RMPRYN="Y"
 S RMPREXC=""
QM1X I RMPRYN'="Y",RMPRYN'="?" D QM1H
 Q
QM1H W:$X'=0 !
 W "        You may enter a new PROS ITEM LOCATION, if you wish"
 W !,"        Answer must be 3-30 characters in length."
 S %A="V",X="^",RMPRYN="?"
 Q
QM2H W !,"        You may enter a new PROS ITEM LOCATION, if you wish"
 W !,"        Answer must be 3-30 characters in length."
 Q
QQM1 W !,"        You may enter a new PROS ITEM LOCATION, if you wish"
 W !,"        This is a location of an item or stock being tracked for inventory."
 Q
 ;
 ;***** QM2 - List Location names; part of help for Location prompt
 ;
 ; require RMPRSTN - Station number
 ;
QM2 N DIR,X,Y,DA,DTOUT,DIROUT,DIRUT,DUOUT,RMPRMAX,RMPRGBL,RMPRLIN
 S RMPRMAX=19,RMPRLIN=0
 S RMPREXC=""
 S DIR(0)="EA"
 S DIR("A")="'^' TO STOP: "
 W !?3,"Choose from:"
 S RMPRGBL="^RMPR(661.5,"_"""XSL"","_RMPRSTN_")"
QM2A S RMPRGBL=$Q(@RMPRGBL)
 I RMPRGBL="" G QM2X
 I $QS(RMPRGBL,1)'=661.5 G QM2X
 I $QS(RMPRGBL,2)'="XSL" G QM2X
 I $QS(RMPRGBL,3)'=RMPRSTN G QM2X
 W !?3,$QS(RMPRGBL,4)
 S RMPRLIN=RMPRLIN+1
 I RMPRLIN'<RMPRMAX G QM2B
 G QM2A
QM2B D ^DIR
 I $D(DTOUT) S RMPREXC="T" G QM2X
 I $D(DIROUT) S RMPREXC="P" G QM2X
 I (X["^")!$D(DUOUT) S RMPREXC="^" G QM2X
 S RMPRLIN=0
 G QM2A
QM2X W ! Q
 ;
 ;***** LIKE - List Locn names with matching chars.
 ;
 ; Inputs:
 ;    RMPRSTN - Station number
 ;    RMPRTXT - Text to be compared
 ;
 ; Outputs:
 ;    RMPREXC - exit condition
 ;    RMPR5   - array for Location data fields
 ;
LIKE(RMPRSTN,RMPRTXT,RMPREXC,RMPR5) ;
 N RMPRMAX,RMPRLIN,RMPRGBL,DIR,X,Y,DA,DTOUT,DIROUT,DIRUT,DUOUT,RMPRA
 N RMPRI,RMPRERR,RMPRYN,RMPRJ
 S RMPREXC=""
 S RMPRMAX=5
 S RMPRJ=RMPRTXT
 I '$D(^RMPR(661.5,"XSL",RMPRSTN,RMPRJ)) D
 . S RMPRJ=$O(^RMPR(661.5,"XSL",RMPRSTN,RMPRJ))
 . Q
 I RMPRJ=""!($E(RMPRJ,1,$L(RMPRTXT))'=RMPRTXT) S RMPR5("IEN")="" G LIKEX
 S RMPRI=$O(^RMPR(661.5,"XSL",RMPRSTN,RMPRJ))
 I RMPRI=""!($E(RMPRI,1,$L(RMPRTXT))'=RMPRTXT) D
 . S RMPR5("IEN")=$O(^RMPR(661.5,"XSL",RMPRSTN,RMPRJ,""))
 . W:RMPRJ'=RMPRTXT $E(RMPRJ,1+$L(RMPRTXT),$L(RMPRJ))
 . S RMPRERR=$$GET^RMPRPIX5(.RMPR5)
 . D OK^RMPRPIYB(.RMPRYN,)
 . Q
 I $G(RMPR5("IEN"))'="" S:RMPRYN'="Y" RMPR5("IEN")="",RMPREXC="^" G LIKEX
 S RMPRGBL="^RMPR(661.5,"_"""XSL"","_RMPRSTN_","""_RMPRTXT_""")"
LIKEA1 K RMPRA S RMPRLIN=0
LIKEA S RMPRGBL=$Q(@RMPRGBL)
LIKEA2 I RMPRGBL="" G LIKEB
 I $QS(RMPRGBL,1)'=661.5 G LIKEB
 I $QS(RMPRGBL,2)'="XSL" G LIKEB
 I $QS(RMPRGBL,3)'=RMPRSTN G LIKEB
 I $E($QS(RMPRGBL,4),1,$L(RMPRTXT))'=RMPRTXT G LIKEB
 I RMPRLIN,'(RMPRLIN#RMPRMAX) D  G LIKEB
 . S DIR("A",1)="Press <RETURN> to see more, '^' to exit this list, OR"
 . Q
LIKEA3 S RMPRLIN=RMPRLIN+1
 W !?4,$J(RMPRLIN,2),?9,$QS(RMPRGBL,4)
 S RMPRA(RMPRLIN)=$QS(RMPRGBL,5)
 G LIKEA
LIKEB I RMPRLIN=0 G LIKEX
 S DIR(0)="NAO^1:"_RMPRLIN_":0"
 S DIR("A")="CHOOSE 1-"_RMPRLIN_": "
 D ^DIR
 I $D(DTOUT) S RMPREXC="T" G LIKEX
 I $D(DIROUT) S RMPREXC="P" G LIKEX
 I X="",$D(DIR("A",1)) K DIR("A",1) G LIKEA3
 I X="" S RMPREXC="^" G LIKEX
 I X["^"!$D(DUOUT) S RMPREXC="^" G LIKEX
 K RMPR5
 S RMPR5("IEN")=RMPRA(X)
 S RMPRERR=$$GET^RMPRPIX5(.RMPR5)
 W "  ",RMPR5("NAME")
LIKEX Q

RMPRPIYC ;HINCIO/ODJ - PIP HCPCS Prompt utilities ;3/8/01
 ;;3.0;PROSTHETICS;**61**;Feb 09, 1996
 Q
 ;
 ;***** HCPCS - Prompt for HCPCS called by reconciliation option
 ;              (RMPRPIYA)
HCPCS(RMPR5,RMPR1,RMPR11,RMPREXC) ;
 N RMPRERR,DIR,X,Y,DUOUT,DTOUT,DIROUT,DIRUT,DIC,DA,RMPRSTN,RMPRLCN,RMPR1N
 N RMPRYN
 S DIR("A")="Select HCPCS to RECONCILE: "
 S RMPRERR=0
 S RMPREXC=""
 S RMPR1("HCPCS")=$G(RMPR1("HCPCS"))
 S RMPRSTN=RMPR5("STATION")
 S RMPRLCN=RMPR5("IEN")
 S DIR(0)="FOA"
 S DIR("?")="^D QM^RMPRPIYC"
 S DIR("??")="^D QM2^RMPRPIYC"
HCPCS1 K RMPR1N D ^DIR
 I $D(DTOUT) S RMPREXC="T" G HCPCSX
 I $D(DIROUT) S RMPREXC="P" G HCPCSX
 I X=""!(X["^")!($D(DUOUT)) S RMPREXC="^" G HCPCSX
 D LIKE^RMPRPIYC(RMPRSTN,X,.RMPREXC,.RMPR1N,.RMPR11)
 I RMPREXC'="" G HCPCS1
 I $G(RMPR1N("IEN"))'="" G HCPCSU
 G HCPCS1
HCPCSU K RMPR1 M RMPR1=RMPR1N
HCPCSX Q RMPRERR
 ;
 ;***** QM - Single ? Help
 ;           RMPRSTN required (see below QM2)
 ;
QM D QM1 ; ask if want to list HCPCS
 I RMPREXC'="" G QMX
 I RMPRYN="N" G QMX
 D QM2 ;list HCPCS
QMX Q
QM1 N DIR,X,Y,DA,DTOUT,DIROUT,DIRUT,DUOUT
 ;S DIR("A",1)=" Answer with PSAS HCPCS, or SHORT NAME, or CPT, or SYNONYM, or"
 ;S DIR("A",2)="     DESCRIPTION"
 S DIR("A",1)="This response must be a number."
 S DIR("A")="Do you want the entire list of PSAS HCPCS in inventory "
 S DIR("?")="^D QM1H^RMPRPIYC"
 S DIR(0)="YO"
 D ^DIR
 I $D(DTOUT) S RMPREXC="T" G QM1X
 I $D(DIROUT) S RMPREXC="P" G QM1X
 I X=""!(X["^")!($D(DUOUT)) S RMPREXC="^" G QM1X
 S RMPRYN="N" S:Y RMPRYN="Y"
 S RMPREXC=""
QM1X Q
QM1H S %A="V",X="^"
 Q
 ;
 ;***** QM2 - List HCPCS associated with a Location
 ;            called from a ?? help or Yes to the
 ;            question in the ? help.
 ;
 ; requires RMPRSTN - Station ien
 ;
QM2 D LIKE(RMPRSTN,"",.RMPREXC,.RMPR1N,.RMPR11)
 I $G(RMPR1N("IEN"))'="" D QM1H
QM2X Q
 ;
 ; ***** LIKE
 ; Handle the various inputs from a HCPCS prompt where HCPCS is
 ; being selected from PIP as opposed to the general
 ; HCPCS file 661.1
 ; This version uses the 661.11 file so any HCPCS that has been
 ; used in inventory can be selected.
 ;
 ; Inputs:
 ;    RMPRSTN - Station ien
 ;    RMPRTXT - Text entered at HCPCS prompt (cannot be null)
 ;
 ; Outputs:
 ;    RMPREXC - exit condition
 ;    RMPR1   - array of HCPCS data from 661.1 file
 ;      RMPR1("IEN")        - ien of HCPCS in 661.1 (null if not found)
 ;      RMPR1("HCPCS")      - HCPCS code
 ;      RMPR1("SHORT DESC") - HCPCS short description
 ;    RMPR11  - array of Inventory Item data from 661.11 file
 ;
LIKE(RMPRSTN,RMPRTXT,RMPREXC,RMPR1,RMPR11) ;
 N RMPRMAX,RMPRLIN,DIR,X,Y,DA,DTOUT,DIROUT,DIRUT,DUOUT,RMPRA,RMPRH
 N RMPRERR,RMPRHA,RMPR1N,RMPRH2,RMPRHTXT,RMPRITXT
 S RMPREXC=""
 S (RMPR1("IEN"),RMPR11("IEN"))=""
 S RMPRMAX=5
 S RMPRLIN=0
 S RMPRHTXT=$P(RMPRTXT,"-",1)
 S RMPRITXT=""
 I RMPRHTXT="" S RMPRH="" G LIKEA1
 ;
 ; Check for exact match and skip selection if it is
 I $D(^RMPR(661.11,"ASHI",RMPRSTN,RMPRHTXT)) D  G LIKEG
 . S RMPRITXT=$P(RMPRTXT,"-",2)
 . Q
 ;
 ; Check for unique partial match and skip selection if it is
 S RMPRH=$O(^RMPR(661.11,"ASHI",RMPRSTN,RMPRTXT))
 I $E(RMPRH,1,$L(RMPRTXT))'=RMPRTXT G LIKEC
 S RMPRH2=$O(^RMPR(661.11,"ASHI",RMPRSTN,RMPRH))
 I $E(RMPRH2,1,$L(RMPRTXT))'=RMPRTXT D  G LIKEG
 . W $E(RMPRH,1+$L(RMPRTXT),$L(RMPRH))
 . S RMPRHTXT=RMPRH
 . Q
 G LIKEA3
 ;
 ; List partial matches
LIKEA1 S RMPRH=$O(^RMPR(661.11,"ASHI",RMPRSTN,RMPRH))
 I RMPRH="" G:'RMPRLIN LIKEX G LIKEB
 I $E(RMPRH,1,$L(RMPRTXT))'=RMPRTXT K DIR("A",1) G LIKEB
LIKEA2 I RMPRLIN,'(RMPRLIN#RMPRMAX) D  G LIKEB
 . S DIR("A",1)="Press <RETURN> to see more, '^' to exit this list, or"
 . Q
LIKEA3 K RMPRHA S RMPRHA("HCPCS")=RMPRH
 S RMPRERR=$$HPACT^RMPRPIX1(.RMPRHA)
 S RMPRLIN=RMPRLIN+1
 W !?4,$J(RMPRLIN,2),?9,RMPRH,?19,RMPRHA("SHORT DESC")
 S RMPRA(RMPRLIN)=RMPRH
 G LIKEA1
LIKEB S DIR(0)="NAO"
 S DIR("A")="Choose 1 - "_RMPRLIN_" : "
 ;S DIR("?")="^D LIKEH^RMPRPIYC"
 D ^DIR
 I $D(DTOUT) S RMPREXC="T" G LIKEX
 I $D(DIROUT) S RMPREXC="P" G LIKEX
 I X="",$D(DIR("A",1)) S RMPREXC="" K DIR("A",1) G LIKEA3
 I X=""!(X["^")!$D(DUOUT) S RMPREXC="^" G LIKEX
 I $G(X),'$D(RMPRA(X)) W !!,"Please enter a number within the range." G LIKEB
 I '$D(RMPRA(X)) W !!,"This response must be a number." G LIKEB
 S RMPRHTXT=RMPRA(X)
 ;
 ; read in HCPCS and possibly Item as well
LIKEG K RMPR1
 S RMPR1("HCPCS")=RMPRHTXT
 S RMPRERR=$$HPACT^RMPRPIX1(.RMPR1)
 I RMPRITXT'="",$D(^RMPR(661.11,"ASHI",RMPRSTN,RMPRHTXT,RMPRITXT)) D
 . K RMPR11
 . S RMPR11("STATION")=RMPRSTN
 . S RMPR11("HCPCS")=RMPRHTXT
 . S RMPR11("ITEM")=RMPRITXT
 . S RMPRERR=$$GET^RMPRPIX1(.RMPR11)
 . Q
 G LIKEX
 ;
 ; If can't find HCPCS in PIP files use old DIC lookup
LIKEC D HCDIC(RMPRSTN,RMPRTXT,.RMPR1N)
 I $G(RMPR1N("IEN"))'="" K RMPR1 M RMPR1=RMPR1N
 ;
 ;exit
LIKEX Q
LIKEH D QM,QM1H
 Q
 ;
 ; Call DIC to match on text if not a HCPCS code
HCDIC(RMPRSTN,RMPRTXT,RMPR1) ;
 N X,Y,DA,DIC
 S DIC="^RMPR(661.1,"
 S DIC(0)="EMQ"
 S DIC("S")="I $$HCMAT^RMPRPIYC()"
 S X=RMPRTXT
 D ^DIC
 I +Y'>0!($D(DTOUT))!($D(DUOUT)) G HCDICX
 I $P(Y,"^",2)'="",$D(^RMPR(661.4,"XSHIL",RMPRSTN,$P(Y,"^",2))) D
 . S RMPR1("HCPCS")=$P(Y,"^",2)
 . S RMPRERR=$$HPACT^RMPRPIX1(.RMPR1)
 . Q
HCDICX Q
 ;
 ;***** HCMAT - extrinsic called from DIC call to screen out
 ;              HCPCS not associated with PIP
 ;              RMPRSTN (station ien) must be set
HCMAT() ;
 N RMPRMAT
 S RMPRMAT=0
 I $D(^RMPR(661.4,"XSHIL",RMPRSTN,$P(^RMPR(661.1,Y,0),"^",1))) S RMPRMAT=1
HCMATX Q RMPRMAT

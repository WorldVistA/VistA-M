RMPRPIYV ;HINCIO/ODJ - PIP Data Entry - HCPCS;3/8/01
 ;;3.0;PROSTHETICS;**61**;Feb 09, 1996
 Q
 ;
 ;***** HCPCS - Prompt for HCPCS code to TRANSFER
 ;              called by Transfer option RMPRPIYT
 ;
 ; Inputs:
 ;   RMPR5 - Location array (from 661.5) must contain...
 ;     RMPR5("IEN")     - ien of Location
 ;     RMPR5("STATION") - ien of location's Station
 ;
 ;   RMPR1("HCPCS") - (optional) Default HCPCS code
 ;
 ; Outputs:
 ;   RMPREXC - Exit condition
 ;   RMPR1   - array of HCPCS data fields from 661.1
 ;     RMPR1("IEN")        - ien of HCPCS in 661.1
 ;     RMPR1("HCPCS")      - HCPCS code
 ;     RMPR1("SHORT DESC") - HCPCS short description
 ;
HCPCS(RMPR5,RMPR1,RMPREXC) ;
 N RMPRERR,DIR,X,Y,DUOUT,DTOUT,DIROUT,DIRUT,DA,RMPRSTN,RMPRLCN,RMPR1N
 S DIR("A")="Enter HCPCS to Transfer: "
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
 D LIKE^RMPRPIYC(RMPRSTN,RMPRLCN,X,.RMPREXC,.RMPR1N)
 I RMPREXC'="" G HCPCS1
 I $G(RMPR1N("IEN"))'="" G HCPCSU
 G HCPCS1
HCPCSU K RMPR1 M RMPR1=RMPR1N
HCPCSX Q RMPRERR
 ;
 ; Help System (NOT IN USE)
HLP N RMPRMAXL,RMPRH,RMPRL,RMPRERR,RMPR
 S RMPRMAXL=9
 W ?4,"Answer with HCPCS"
 W !?3,"Choose from:"
 S RMPRL=0
 S RMPRH=""
 F  S RMPRH=$O(^RMPR(661.7,"XSLHIDS",RMPR5("STATION IEN"),RMPR5("IEN"),RMPRH)) Q:RMPRH=""  D  Q:RMPRL'<RMPRMAXL
 . S RMPRL=RMPRL+1
 . W !?3,RMPRH
 . S RMPR("HCPCS")=RMPRH,RMPRERR=$$HPACT^RMPRPIX1(.RMPR)
 . W ?26,RMPR("SHORT DESC")
 . Q
 Q

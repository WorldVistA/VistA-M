RMPRPIYN ;HINCIO/ODJ - EL - Edit Location ;3/8/01
 ;;3.0;PROSTHETICS;**61,154**;Feb 09, 1996;Build 6
 Q
 ;
 ;***** EL - Edit Inventory LOCATION
 ;           no inputs required
 ;           other than standard VISTA vars. (DUZ, etc)
 ;
EL N RMPRERR,RMPRSTN,RMPREXC,RMPR5
 ;
 ;***** STN - call prompt for Site/Station
STN S RMPRERR=$$STN^RMPRPIY1(.RMPRSTN,.RMPREXC)
 I RMPRERR G ELX
 I RMPREXC'="" G ELX
 ;
 ;***** LOCN - call prompt for Location
LOCN W @IOF,!!,"Editing an Inventory Location.....",!
LOCN1 D LOCNM^RMPRPIY7(RMPRSTN("IEN"),.RMPR5,.RMPREXC)
 I RMPREXC="T"!(RMPREXC="^") G ELX
 I RMPREXC="P" G STN
 S RMPR5("STATION")=RMPRSTN("IEN")
 S RMPR5("STATION IEN")=RMPRSTN("IEN")
 ;
 ;***** LOCN2 - call prompt to change Location name
LOCN2 W ! D EDLOC(.RMPR5,.RMPREXC)
 I RMPREXC="T" G ELX
 I RMPREXC'="" G LOCN
 G ELX
 ;
 ;***** exit points
ELX D KILL^XUSCLEAN
 Q
 ;
 ;***** EDLOC - prompt for change of Location name
EDLOC(RMPR5,RMPREXC) ;
 N DIR,X,Y,DA,DUOUT,DTOUT,DIROUT,RMPRYN,RMPRNEWN,RMPR5N,RMPRERR
 S RMPREXC=""
 S DIR(0)="FOA^3:30"
 S DIR("A")="LOCATION: "
 S DIR("B")=RMPR5("NAME")
 S DIR("?")="Answer must be 3-30 characters in length."
 S DIR("??")="^D ELQQM^RMPRPIYN"
EDLOC1 D ^DIR
 I $D(DTOUT) S RMPREXC="T" G EDLOCX
 I $D(DIROUT) S RMPREXC="P" G EDLOCX
 I X=""!(X["^") S RMPREXC="^" G EDLOCX
 I $E(X)="@" W !,"Cannot delete location, only deactivate" K X G EDLOC1
 I X=RMPR5("NAME") G EDLOCX
 L +^RMPR(661.5,RMPR5("IEN")):0 E  D  G EDLOCX
 . W !,"Location being edited by another user, cannot continue."
 . H 2
 . S RMPREXC="P"
 . Q
 I $D(^RMPR(661.5,"XSL",RMPR5("STATION"),X)) D  G EDLOCU
 . W !,"Location name already in use, cannot continue.",!
 . H 2
 . S RMPREXC="P"
 . Q
 S RMPRNEWN=X
 D ELOK(.RMPRYN,.RMPREXC)
 I RMPREXC="T" G EDLOCU
 I RMPREXC'=""!(RMPRYN="N") S RMPREXC="" L -^RMPR(661.5,RMPR5("IEN")) G EDLOC1
 S RMPR5N("IEN")=RMPR5("IEN")
 S RMPR5N("NAME")=RMPRNEWN
 S RMPRERR=$$UPD^RMPRPIX5(.RMPR5N)
 W !
 W "Location has been edited from '"_RMPR5("NAME")_"'"
 W " to '"_RMPRNEWN_"' !!!"
 H 2
EDLOCU L -^RMPR(661.5,RMPR5("IEN"))
EDLOCX Q
ELQQM W !,"This is a location of an item or stock being tracked for inventory."
 Q
 ;
 ; Y/N Prompt to confirm change of Location Name
ELOK(RMPRYN,RMPREXC) ;
 N DIR,X,Y,DA,DUOUT,DTOUT,DIROUT
 S RMPRYN="N"
 S RMPREXC=""
 S DIR(0)="Y"
 S DIR("B")="N"
 S DIR("A")="Are you sure you want to change the name of this location"
 D ^DIR
 I $D(DTOUT) S RMPREXC="T" G ELOKX
 I $D(DIROUT) S RMPREXC="P" G ELOKX
 I X=""!(X["^") S RMPREXC="^" G ELOKX
 S RMPRYN="N" S:Y RMPRYN="Y"
ELOKX Q

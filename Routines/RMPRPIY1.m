RMPRPIY1 ;HINCIO/ODJ - PIP Data Entry - Prompts;3/8/01
 ;;3.0;PROSTHETICS;**61**;Feb 09, 1996
 Q
 ;
 ;***** STN - Prompt for Station
STN(RMPRSTN,RMPRESC) ;
 N X,Y,DIC,DA,DUOUT,DTOUT,DIROUT,DIRUT,RMPR,RMPRSITE
 S RMPRERR=0
 S RMPRSTN("IEN")=$G(RMPRSTN("IEN"))
 I $G(DUZ)="" S RMPRERR=1 G STNX ;User must exist (ptr. to ^VA(200))
 S RMPRESC=""
 D DIV4^RMPRSIT ; call standard Prosthetic site look-up
 I $G(X)="^^" S RMPREXC="P" G STNX
 I $D(X) S RMPRESC="^" G STNX
 S RMPRSTN("IEN")=$G(RMPR("STA"))
 I RMPRSTN("IEN")="" S RMPRERR=99 G STNX
 S RMPRSTN("SITE NAME")=$G(RMPR("NAME"))
STNX Q RMPRERR
 ;
 ;***** ITED - Edit an Inventory Item description and update 661.11
ITED(RMPR11,RMPREXC) ;
 N DIR,X,Y,DA,DUOUT,DTOUT,DIRUT,DIROUT,RMPRYN,RMPR11N,RMPRERR
 S DIR(0)="FOA^3:60"
 S DIR("A")="PIP Item Description: "
 S DIR("??")="^D ITEDH2^RMPRPIY1"
 S DIR("B")=$G(RMPR11("DESCRIPTION"))
ITED1 D ^DIR
 I $D(DTOUT) S RMPREXC="T" G ITEDX
 I $D(DIROUT) S RMPREXC="P" G ITEDX
 I X["^"!($D(DUOUT)) S RMPREXC="^" G ITEDX
 I X="" G ITEDX
 S RMPREXC=""
 I X=$G(RMPR11("DESCRIPTION")) G ITEDX
 L +^RMPR(661.11,RMPR11("IEN")):0 E  D  G ITEDX
 . W !,"Item being edited by another user, cannot continue."
 . H 2
 . S RMPREXC="^"
 . Q
 S RMPR11N("DESCRIPTION")=X
 D ITEDO(.RMPRYN,.RMPREXC)
 I RMPREXC="T" G ITEDU
 I RMPREXC'=""!(RMPRYN="N") D  G ITED1
 . S RMPREXC=""
 . L -^RMPR(661.11,RMPR11("IEN"))
 . Q
 S RMPR11N("IEN")=RMPR11("IEN")
 S RMPRERR=$$UPD^RMPRPIX1(.RMPR11N)
 W !
 S RMPR11("DESCRIPTION")=$G(RMPR11N("DESCRIPTION"))
ITEDU L -^RMPR(661.11,RMPR11("IEN"))
ITEDX Q
 ;
 ; (??) Help text for item desc.
ITEDH2 W "Enter a description for this item which will be used locally by",!
 W "your Prosthetics Service.",!
 W "You may want to use the Item Master description with additional",!
 W "text specifying things like size, volume, etc."
 Q
 ;
 ; Y/N Prompt to confirm change of Item Description
ITEDO(RMPRYN,RMPREXC) ;
 N DIR,X,Y,DA,DUOUT,DTOUT,DIROUT,DIRUT
 S RMPRYN="N"
 S RMPREXC=""
 S DIR(0)="Y"
 S DIR("B")="N"
 S DIR("A")="Are you sure you want to change this Item's Description"
 D ^DIR
 I $D(DTOUT) S RMPREXC="T" G ITEDOX
 I $D(DIROUT) S RMPREXC="P" G ITEDOX
 I X=""!(X["^")!($D(DUOUT)) S RMPREXC="^" G ITEDOX
 S:Y RMPRYN="Y"
ITEDOX Q
 ;
 ;***** MASIT - prompt for Item Master
MASIT(RMPR1,RMPREXC) ;
 N DIC,X,Y,DA,DUOUT,DTOUT,DIROUT,DIRUT
 S DIC(0)="AEQM"
 S DIC=661
 S DIC("A")="IFCAP ITEM: "
 I $G(RMPR1("ITEM MASTER IEN"))'="" S DIC("B")=RMPR1("ITEM MASTER IEN")
 W !
 D ^DIC
 I $D(DTOUT) S RMPREXC="T" G MASITX
 I $D(DUOUT) S RMPREXC=$S(X="^^":"P",1:"^") G MASITX
 I +Y=-1 S RMPREXC="^" G MASITX
 S RMPREXC=""
 S RMPR1("IEN")=$P(Y,"^",1)
MASITX Q
 ;
 ;***** HCPCS - select HCPCS and inventory item
HCPCS(RMPRSTN,RMPRHCPC,RMPR1,RMPR11,RMPREXC) ;
HCPCS1 D HCPCS^RMPRPIY7(RMPRSTN,$G(RMPRHCPC),.RMPR1,.RMPR11,.RMPREXC)
 I RMPREXC="T" G HCPCSX
 I RMPREXC="P"!(RMPREXC="^") G HCPCSX
 I $G(RMPR11("IEN"))'="" G HCPCSX
HCPCS2 D ITEM^RMPRPIYP(RMPRSTN,RMPR1("HCPCS"),.RMPR11,.RMPREXC)
 I RMPREXC="T" G HCPCSX
 I RMPREXC="P" G HCPCS1
 I RMPREXC="^" G HCPCSX
 S RMPR11("STATION")=RMPRSTN
 S RMPR11("STATION IEN")=RMPRSTN
 ;
 ; display selected HCPCS and item and continue
HCPCS3 W !!,"HCPCS: "_$G(RMPR1("HCPCS"))_" "_$G(RMPR1("SHORT DESC"))
 W !!,"IFCAP Item: ",$G(RMPR11("ITEM MASTER"))
 W !!,"PIP Item desc.: ",$G(RMPR11("DESCRIPTION"))
HCPCSX Q

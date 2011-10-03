RMPRPIYD ;HINES OIFO/ODJ - PIP RECONCILE - Pick HCPCS Item;3/8/01
 ;;3.0;PROSTHETICS;**61**;Feb 09, 1996
 Q
 ;
 ; Get an Item - restrict choice to Location and HCPC
ITEM(RMPRSTN,RMPRLCN,RMPR11,RMPREXC) ;
 N RMPRERR,DIR,X,Y,DUOUT,DTOUT,DIROUT,DA,RMPRSRC,RMPRHCPC
 S RMPRERR=0
 S RMPREXC=""
 I $G(RMPRSTN)="" S RMPRERR=1 G ITEMX
 I $G(RMPR11("HCPCS"))="" S RMPRERR=2 G ITEMX
 S RMPR11("STATION")=RMPRSTN
 S RMPR11("STATION IEN")=RMPRSTN
 S RMPRHCPC=RMPR11("HCPCS")
 S DIR(0)="FOA^1:50"
 S DIR("A")="Enter Item to RECONCILE: "
 S DIR("?")="^D QM^RMPRPIYD"
 S DIR("??")="^D QQM^RMPRPIYD"
ITEMA1 D ^DIR
 I $D(DTOUT) S RMPREXC="T" G ITEMX
 I $D(DIROUT) S RMPREXC="P" G ITEMX
 I X=""!(X["^") S RMPREXC="^" G ITEMX
 S RMPR11("IEN")=""
 D LIKE(RMPRSTN,RMPRLCN,RMPRHCPC,X,.RMPREXC,.RMPR11)
 I RMPREXC="T" G ITEMX
 I RMPREXC="P" G ITEMX
 I RMPREXC="^" G ITEMA1
 I RMPR11("IEN")="",$L(X)<3 G ITEMA1
 I RMPR11("IEN")="" S RMPR11("DESCRIPTION")=X G ITEMX
 G ITEMX
ITEMX Q RMPRERR
 ;
 ; CHKN - Check an Item Number
 ;
 ; Inputs:
 ;    RMPR11 - array consisting of the following subscripts...
 ;    RMPR11("STATION") - Station ien (eg 499)
 ;    RMPR11("HCPCS")   - HCPCS code (eg E0111)
 ;    RMPR11("ITEM")    - HCPCS Item number (eg 1)
 ;
 ; Outputs:
 ;    RMPR11 - additional elements from 661.11 record if Item exists...
 ;    RMPR11("DESCRIPTION") - Item Description
 ;    RMPR11("HCPCS-ITEM")  - Combined HCPCS Item code (eg E0111-1)
 ;    RMPR11("IEN")         - ien of record
 ;    RMPR11("SOURCE")      - Source (external format)
 ;    RMPR11("STATION")     - Station Name (external format)
 ;    RMPR11("UNIT")        - Unit of Measure (external format)
 ;    RMPR11("STATION IEN") - ien of input Station
 ;
 ;    RMPRERR - exit condition (returned by function)
 ;              0 - no erros
 ;              1 - null station ien
 ;              2 - null HCPCS code
 ;              3 - HCPCS Item not valid number
 ;              4 - Item does not exist
 ;             99 - Problem with 661.11 file
 ;
CHKN(RMPR11) ;
 N RMPRERR
 S RMPRERR=0
 I $G(RMPR11("STATION"))="" S RMPRERR=1 G CHKNX
 S RMPR11("STATION IEN")=RMPR11("STATION")
 I $G(RMPR11("HCPCS"))="" S RMPRERR=2 G CHKNX
 I $G(RMPR11("ITEM"))'?1.N S RMPRERR=3 G CHKNX
 I '$D(^RMPR(661.11,"ASHI",RMPR11("STATION"),RMPR11("HCPCS"),RMPR11("ITEM"))) S RMPRERR=4 G CHKNX
 S RMPRERR=$$GET^RMPRPIX1(.RMPR11)
 I RMPRERR S RMPRERR=99
CHKNX Q RMPRERR
 ;
 ; CHKD - Check an Item Description
 ;
 ; Inputs:
 ;    RMPR11 - array consisting of the following subscripts...
 ;    RMPR11("STATION")     - Station ien (eg 499)
 ;    RMPR11("HCPCS")       - HCPCS code (eg E0111)
 ;    RMPR11("DESCRIPTION") - HCPCS Item Description
 ;
 ; Outputs:
 ;    RMPR11  - additional elements from 661.11 record if Item exists...
 ;    RMPR11("ITEM")        - HCPCS Item number
 ;    RMPR11("HCPCS-ITEM")  - Combined HCPCS Item code (eg E0111-1)
 ;    RMPR11("IEN")         - ien of record
 ;    RMPR11("SOURCE")      - Source (external format)
 ;    RMPR11("STATION")     - Station Name (external format)
 ;    RMPR11("UNIT")        - Unit of Measure (external format)
 ;    RMPR11("STATION IEN") - ien of input Station
 ;
 ;    RMPRERR - exit condition (returned by function)
 ;              0 - no erros
 ;              1 - null station ien
 ;              2 - null HCPCS code
 ;              3 - null HCPCS Item Desc.
 ;              4 - Item does not exist
 ;              5 - Item does not exist, but there are items matching
 ;                  the entered description text
 ;             99 - Problem with 661.11 file
 ;
CHKD(RMPR11) ;
 N RMPRERR,RMPRD
 S RMPRERR=0
 I $G(RMPR11("STATION"))="" S RMPRERR=1 G CHKDX
 S RMPR11("STATION IEN")=RMPR11("STATION")
 I $G(RMPR11("HCPCS"))="" S RMPRERR=2 G CHKDX
 I $G(RMPR11("DESCRIPTION"))="" S RMPRERR=3 G CHKDX
 I '$D(^RMPR(661.11,"XSD",RMPR11("STATION"),RMPR11("DESCRIPTION"),RMPR11("HCPCS"))) D  G CHKDX
 . S RMPRERR=4
 . S RMPRD=RMPR11("DESCRIPTION")
 . S RMPRD=$O(^RMPR(661.11,"XSD",RMPR11("STATION"),RMPRD))
 . I $E(RMPRD,1,$L(RMPR11("DESCRIPTION")))=RMPR11("DESCRIPTION") S RMPRERR=5
 . Q
 S RMPR11("IEN")=$O(^RMPR(661.11,"XSD",RMPR11("STATION"),RMPR11("DESCRIPTION"),RMPR11("HCPCS"),""))
 S RMPRERR=$$GET^RMPRPIX1(.RMPR11)
 I RMPRERR S RMPRERR=99
CHKDX Q RMPRERR
 ;
 ; Prompt if adding a new HCPCS Item
OKADD(RMPR11,RMPRYN,RMPREXC) ;
 N DIR,X,Y,DUOUT,DTOUT,DIROUT,DIRUT
 S RMPREXC=""
 S DIR(0)="Y"
 S DIR("A")="Are you adding '"_RMPR11("DESCRIPTION")_"' as a new ITEM for this HCPCS"
 D ^DIR
 I $D(DTOUT) S RMPREXC="T" G ADDNMX
 I $D(DIROUT) S RMPREXC="P" G ADDNMX
 I X=""!(X["^") S RMPREXC="^" G ADDNMX
 S RMPRYN="N" S:Y RMPRYN="Y"
 S RMPREXC=""
ADDNMX Q
 ;
 ; Single ? Help
QM W ?4,"Answer with ITEM NUMBER or DESCRIPTION:"
 D QM2
 Q
QQM D QM2
 W !!?8,"You may enter a new ITEM, if you wish"
 W !?8,"This is an Item or Appliance under PSAS HCPCS kept by local site in"
 W !?8,"Prosthetics Inventory module."
 Q
QM2 N DIR,X,Y,DA,DTOUT,DIROUT,DIRUT,DUOUT,RMPRMAX,RMPRI,RMPRLIN,RMPR,RMPRERR
 S RMPRMAX=19,RMPRLIN=0
 S RMPREXC=""
 S DIR(0)="EA"
 S DIR("A")="'^' TO STOP: "
 S RMPRI=""
QM2A S RMPRI=$O(^RMPR(661.4,"ASLHI",RMPRSTN,RMPRLCN,RMPRHCPC,RMPRI))
 I RMPRI="" G QM2X
 K RMPR
 S RMPR("STATION")=RMPRSTN
 S RMPR("HCPCS")=RMPRHCPC
 S RMPR("ITEM")=RMPRI
 S RMPRERR=$$GET^RMPRPIX1(.RMPR)
 W !?3,RMPRI,?16,RMPR("HCPCS-ITEM"),?28,RMPR("DESCRIPTION")
 S RMPRLIN=RMPRLIN+1
 I RMPRLIN'<RMPRMAX G QM2B
 G QM2A
QM2B D ^DIR
 I $D(DTOUT) S RMPREXC="T" G QM2X
 I $D(DIROUT) S RMPREXC="P" G QM2X
 I X=""!(X["^")!$D(DUOUT) S RMPREXC="^" G QM2X
QM2X Q
LIKE(RMPRSTN,RMPRLCN,RMPRHCPC,RMPRTXT,RMPREXC,RMPR11) ;
 N RMPRMAX,RMPRLIN,RMPRGBL,DIR,X,Y,DA,DTOUT,DIROUT,DIRUT,DUOUT,RMPRA
 N RMPRERR,RMPRN,RMPRGBL,RMPR,RMPREXMA
 S RMPREXC=""
 S RMPRMAX=19
 S RMPREXMA=""
 I $D(^RMPR(661.4,"ASLHI",RMPRSTN,RMPRLCN,RMPRHCPC,RMPRTXT)) D
 . S RMPREXMA=$O(^RMPR(661.4,"ASLHI",RMPRSTN,RMPRLCN,RMPRHCPC,RMPRTXT,""))
 . Q
 S RMPRGBL="^RMPR(661.11,"_"""ASHD"","_RMPRSTN_","""_RMPRHCPC_""","""_RMPRTXT_""")"
LIKEA1 K RMPRA S RMPRLIN=0
LIKEA S RMPRGBL=$Q(@RMPRGBL)
 I RMPRGBL="" G LIKEB
 I $QS(RMPRGBL,1)'=661.11 G LIKEB
 I $QS(RMPRGBL,2)'="ASHD" G LIKEB
 I $QS(RMPRGBL,3)'=RMPRSTN G LIKEB
 I $QS(RMPRGBL,4)'=RMPRHCPC G LIKEB
 I $E($QS(RMPRGBL,5),1,$L(RMPRTXT))'=RMPRTXT G LIKEB
 K RMPR
 S RMPR("IEN")=$QS(RMPRGBL,6)
 S RMPRERR=$$GET^RMPRPIX1(.RMPR)
 I '$D(^RMPR(661.4,"ASLHI",RMPRSTN,RMPRLCN,RMPRHCPC,RMPR("ITEM"))) G LIKEA
 I RMPREXMA'="" D
 . S RMPREXMA("IEN")=RMPREXMA
 . S RMPRERR=$$GET^RMPRPIX1(.RMPREXMA)
 . S RMPRLIN=RMPRLIN+1
 . W !?4,$J(RMPRLIN,2),?9,RMPREXMA("DESCRIPTION")
 . S RMPRA(RMPRLIN)=RMPREXMA("IEN")
 . K RMPREXMA
 . S RMPREXMA=""
 . Q
 S RMPRLIN=RMPRLIN+1
 W !?4,$J(RMPRLIN,2),?9,$QS(RMPRGBL,5)
 S RMPRA(RMPRLIN)=$QS(RMPRGBL,6)
 I RMPRLIN'<RMPRMAX G LIKEB
 G LIKEA
LIKEB I RMPRLIN=0 D  G LIKEX
 . Q:RMPREXMA=""
 . S RMPR11("IEN")=RMPREXMA
 . S RMPRERR=$$GET^RMPRPIX1(.RMPR11)
 . Q
 S DIR(0)="NAO^1:"_RMPRLIN_": "
 S DIR("A")="CHOOSE 1-"_RMPRLIN_": "
 D ^DIR
 W !
 I $D(DTOUT) S RMPREXC="T" G LIKEX
 I $D(DIROUT) S RMPREXC="P" G LIKEX
 I X="" S RMPREXC="" G LIKEX
 I X["^"!$D(DUOUT) S RMPREXC="^" G LIKEX
 K RMPR11
 S RMPR11("IEN")=RMPRA(X)
 S RMPRERR=$$GET^RMPRPIX1(.RMPR11)
LIKEX Q

RMPRPIYS ;HINCIO/ODJ - RC - PIP Receive Stock ;10/8/02  13:11
 ;;3.0;PROSTHETICS;**61,108,128**;Feb 09, 1996
 Q
 ;
 ;***** PB - Print Bar Code labels
 ;           RMPR INV BAR CODE
 ;           Callable from VISTA menu, no vars required other than
 ;           global VISTA vars (DUZ, etc)
 ;
PB N RMPRERR,RMPRSTN,RMPRLCN,RMPREXC,RMPR1,RMPR11,RMPROVAL,RMPRNLAB
 N RMPR6,RMPR7,RMPR7I,RMPRBARC,RMPRITXT,RMPRBCP,RMPRQ,RMPRIOP
 ;
 ;***** STN - prompt for Site/Station
STN S RMPROVAL=$G(RMPRSTN("IEN"))
 W @IOF S RMPRERR=$$STN^RMPRPIY1(.RMPRSTN,.RMPREXC)
 I RMPRERR G PBX
 I RMPREXC'="" G PBX
 I RMPROVAL'=RMPRSTN("IEN") K RMPR1,RMPR11
 ;
 ;***** HCPCS - prompt for HCPCS and Item
HCPCS W !!,"Print Bar code Labels for current inventory...",!
HCPCS2 D HCPCS^RMPRPIY7(RMPRSTN("IEN"),$G(RMPR1("HCPCS")),.RMPR1,.RMPR11,.RMPREXC)
 I RMPREXC="T" G PBX
 I RMPREXC="P" G STN
 I RMPREXC="^" D  G PBX
 . W !,"** No HCPCS selected..." H 1
 . Q
 I $G(RMPR11("IEN"))'="" G HCPCS3A
HCPCS3 D ITEM^RMPRPIYP(RMPRSTN("IEN"),RMPR1("HCPCS"),.RMPR11,.RMPREXC)
 I RMPREXC="T" G PBX
 I RMPREXC="P"!(RMPREXC="^") G HCPCS
HCPCS3A S RMPR11("STATION")=RMPRSTN("IEN")
 S RMPR11("STATION IEN")=RMPRSTN("IEN")
 ;
 ; display selected HCPCS and item and continue
HCPCS4 W !!,"HCPCS: "_RMPR1("HCPCS")_" "_RMPR1("SHORT DESC")
 W !!,"IFCAP Item: ",RMPR11("ITEM MASTER")
 W !!,"PIP Item desc.: ",RMPR11("DESCRIPTION")
 ;
 ;***** CURST - call prompt for current stock record
CURST S RMPRLCN=""
 D PVEN^RMPRPIYR(RMPRSTN("IEN"),.RMPRLCN,RMPR11("HCPCS"),RMPR11("ITEM"),.RMPR6,.RMPR7,.RMPREXC)
 I RMPREXC="T" G PBX
 I RMPREXC="P" G HCPCS3
 I RMPREXC="^" G HCPCS
 I '+$G(RMPR7("QUANTITY")) D  G HCPCS2
 . W !,"This item is not currently in stock.",!!
 . Q
 K RMPR7I
 S RMPRERR=$$ETOI^RMPRPIX7(.RMPR7,.RMPR7I)
 S RMPRBARC=RMPR11("HCPCS")_"-"_$P(RMPR7I("DATE&TIME"),".",1)_$P(RMPR7I("DATE&TIME"),".",2)
 S RMPRITXT("DATE")=$E(RMPR7I("DATE&TIME"),4,5)_"/"_$E(RMPR7I("DATE&TIME"),6,7)_"/"_(1700+$E(RMPR7I("DATE&TIME"),1,3))
 S RMPRITXT("ITEM")=RMPR11("HCPCS-ITEM")
 S RMPRITXT("MASTER DESC")=RMPR11("ITEM MASTER")
 S RMPRITXT("ITEM DESC")=RMPR11("DESCRIPTION")
 S RMPRITXT("UNIT PRICE")=+$J(RMPR7("VALUE")/RMPR7("QUANTITY"),0,2)
 S RMPRITXT("VENDOR")=RMPR6("VENDOR")
 S RMPRITXT("LOCATION")=RMPR7("LOCATION")
 ;
 ;***** NLAB - call prompt for number of labels to print
NLAB S RMPRNLAB=RMPR7("QUANTITY")
 W ! D NLABP(.RMPRNLAB,RMPR7("QUANTITY"),.RMPREXC)
 I RMPREXC="T" G PBX
 I RMPREXC="P" G HCPCS
 I RMPREXC="^" G HCPCS
 ;
 ;***** SELP - call prompt for bar code print device
SELP D PRINT G HCPCS
 G HCPCS
PBX D KILL^XUSCLEAN
 Q
 ;
 ;***** PRINT - print bar code labels
 ;              requires RMPRNLAB (number of labels) and
 ;                       RMPRBCP (bar code printer name) to be set
 ;                       RMPRBARC (bar code to print)
 ;                       RMPRIOP (the device to open)
PRINT I '$D(RMPRNLAB) S RMPRNLAB=1
 ;allows queing of bar code labels
SELD S %ZIS("A")="Select Bar Code Printer: "
 S %ZIS="QM" K IOP W ! D ^%ZIS G:POP PRINTX
 I $G(IOST)'["P-ZEBRA" D
 . W !!,"** WARNING - This is NOT a Zebra Bar Code Printer!!",!!
 I '$D(IO("Q")) U IO G PNOW
 K IO("Q") S ZTDESC="PRINT BAR CODE LABELS",ZTRTN="PNOW^RMPRPIYS"
 S ZTIO=ION,ZTSAVE("RMPRBARC")="",ZTSAVE("RMPRITXT(")=""
 S ZTSAVE("RMPRNLAB")="",ZTSAVE("RMPR(")="",ZTSAVE("RMPRSTN(")=""
 D ^%ZTLOAD W:$D(ZTSK) !,"REQUEST QUEUED!" H 2 G PRINTC
 ;
PNOW ;jump here if not queued.
 D ZPLII^RMPRPI11(RMPRBARC,.RMPRITXT,RMPRNLAB)
 S IONOFF=1
PRINTC D ^%ZISC K IONOFF
PRINTX Q
 ;
 ;***** NLABP - Number of labels prompt
NLABP(RMPRNLAB,RMPRMAX,RMPREXC) ;
 N RMPRERR,DIR,X,Y,DUOUT,DTOUT,DIROUT,DIRUT,DA
 S RMPRNLAB=$G(RMPRNLAB)
 S RMPRERR=0
 S DIR(0)="NAO^1:"_RMPRMAX_":0"
 S DIR("A")="Number of Labels to print: "
 S:RMPRNLAB'="" DIR("B")=RMPRNLAB
 S DIR("??")="^D NLABPH2^RMPRPIYS"
 D ^DIR
 I $D(DTOUT) S RMPREXC="T" G NLABPX
 I $D(DIROUT) S RMPREXC="P" G NLABPX
 I X=""!(X["^")!($D(DUOUT)) S RMPREXC="^" G NLABPX
 S RMPREXC=""
 S RMPRNLAB=+Y
NLABPX Q
NLABPH2 W "Type in the number of bar code labels you want to print for the",!
 W "inventory item you have selected.",!
 Q
 ;
 ;***** BARC - bar code prompt
BARC(RMPRBARC,RMPREXC) ;
 N RMPRERR,DIR,X,Y,DUOUT,DTOUT,DIROUT,DIRUT,DA
 S RMPRBARC=""
 S RMPREXC=""
 S RMPRERR=0
 S DIR(0)="FAO"
 S DIR("A")="Scan in item bar code: "
 S DIR("?")="^D BARCH^RMPRPIYS"
BARC1 D ^DIR
 I $D(DTOUT) S RMPREXC="T" G BARCX
 I $D(DIROUT) S RMPREXC="P" G BARCX
 I X["^"!($D(DUOUT)) S RMPREXC="^" G BARCX
 I X="",$G(REDIT) G BARCX
 I X="" G BARC1
 S RMPRBARC=X
BARCX Q
BARCH W "If you have access to a bar code scanner, use it to scan the item bar code now.",!
 W "Don't press the [Enter] key as the scanner should do this automatically.",!
 W "If the scanner cannot read the bar code, type in the character sequence",!
 W "immediately below the bar code.",!
 ;W "If there is no bar code or you prefer to enter the transaction manually",!
 ;W "leave this prompt blank.",!
 Q
 ;
 ;***** SCAN - scan bar code and set up stock issue vars.
 ;             (to be called by RMPRPIYI (too big))
SCAN K RMPR7,RMPR7I,RMPR1,RMPR1I,RMPR11,RMPR11I,RMPR6,RMDAHC,RMITQTY
SCAN1 D BARC(.RMPRBARC,.RMPREXC)
 I RMPREXC'="" S RMPRBARC="" G SCANX
 I RMPRBARC="" G SCANX
 S RMPRBARC=$$UPCASE(RMPRBARC)
 ;
 ; If we get a good bar code then populate all the fields and go
 ; straight to the Post/Edit prompt
 K RMPR7
 S (RMPR7("STATION"),RMPRSTN)=RMPR("STA")
 S RMPR7("HCPCS")=$P(RMPRBARC,"-",1)
 S RMDAHC=$O(^RMPR(661.1,"B",RMPR7("HCPCS"),0))
 I $G(RMDAHC),$D(^RMPR(661.1,RMDAHC,0)),($P(^RMPR(661.1,RMDAHC,0),U,5)'=1) S RMDAHC=$P(^RMPR(661.1,RMDAHC,0),U,3)
 I '$G(RMDAHC) W !,"** No HCPCS Selected or Unable to Select Inactive HCPCS..." G SCAN
 S RMPR7("DATE&TIME")=$E($P(RMPRBARC,"-",2),1,7)_"."_$E($P(RMPRBARC,"-",2),8,$L(RMPRBARC))
 ;
 ; look up current stock record with bar coded key fields
 S RMPRERR=$$SCAN^RMPRPIUA(.RMPR7,.RMPREXC)
 I $G(RMPR7("IEN"))="" W !,"*** The Item scanned is not available, please update your inventory !!!" G SCAN1
 I RMPRERR D SCANE G SCAN1
 S RMPRERR=$$ETOI^RMPRPIX7(.RMPR7,.RMPR7I)
 I RMPRERR D SCANE G SCAN1
 S R1("DATE&TIME")=$G(RMPR7I("DATE&TIME"))
 S $P(R1(0),U,8)=$G(RMPR7I("UNIT"))
 ;
 ; set vars. for HCPCS
 K RMPR1,RMPR1I
 S RMPR1("HCPCS")=RMPR7("HCPCS")
 S RMPRERR=$$HPACT^RMPRPIX1(.RMPR1)
 I RMPRERR D SCANE G SCAN1
 S RMPRERR=$$HPETOI^RMPRPIX1(.RMPR1,.RMPR1I)
 I RMPRERR D SCANE G SCAN1
 ;
 ; set vars. for Item
 K RMPR11,RMPR11I
 S RMPR11("STATION")=RMPR("STA")
 S RMPR11("HCPCS")=RMPR7("HCPCS")
 S RMPR11("ITEM")=RMPR7("ITEM")
 S RMPRERR=$$GET^RMPRPIX1(.RMPR11)
 I RMPRERR D SCANE G SCAN1
 S RMPRERR=$$ETOI^RMPRPIX1(.RMPR11,.RMPR11I)
 I RMPRERR D SCANE G SCAN1
 I RMPR11I("ITEM MASTER IEN")="" D  G SCAN1
 . W !,"This item is not associated with an IFCAP Item.",!
 . W "Please use the Edit Inventory option before trying to issue this item."
 . W !
 . Q
 ;S RMDAHC=RMPR1("IEN")
 D CPT(RMDAHC_"^"_$P(R1(0),U,4)_"^"_RMPR11I("SOURCE")_"^660")
 I RMPREXC="T" G SCANX
 I RMPREXC'="" G SCAN1
 ;
 ; get Vendor
 S RMPR6("DATE&TIME")=RMPR7I("DATE&TIME")
 S RMPR6("HCPCS")=RMPR7("HCPCS")
 S RMPR6("SEQUENCE")=RMPR7("SEQUENCE")
 S RMPRERR=$$GET^RMPRPIX6(.RMPR6)
 I RMPRERR D SCANE G SCAN1
 S RMPRERR=$$VNDIEN^RMPRPIX6(.RMPR6)
 I RMPRERR D SCANE G SCAN1
 S $P(R1(0),U,9)=RMPR6("VENDOR IEN")
 S $P(R3("D"),U,9)=RMPR6("VENDOR")
 ;
 ; set vars for issue
 S RMCPTC=""
 I $G(RMDAHC),$D(^RMPR(661.1,RMDAHC,0)) S RMCPTC=$P(^RMPR(661.1,RMDAHC,0),U,4)
 S $P(R1(1),U,4)=RMDAHC
 S $P(R1(0),U,22)=$G(RMCPTC)
 S $P(R1(0),U,6)=RMPR11I("ITEM MASTER IEN")
 S (RMHCNEW,RMHCDA)=RMDAHC
 S RMITDA=RMPR11("IEN")
 S RMHCPC=RMPR11("HCPCS")
 S RMIT=RMPR11("HCPCS-ITEM")
 S RDESC=RMPR1("SHORT DESC")
 S $P(R3("D"),U,14)=RMPR11("SOURCE")
 S RMSO=RMPR11I("SOURCE")
 S $P(R1(0),U,14)=RMSO
 S $P(R3("D"),U,6)=RMPR11("ITEM MASTER")
 S $P(R1(0),U,6)=RMPR11I("ITEM MASTER IEN")
 S $P(R1(2),U,1)=RMIT
 S $P(R1(2),U,2)=RMPR11("DESCRIPTION")
 S RMLOC=RMPR7I("LOCATION"),RMUBA=0,RMPR11("ITEM")=$P(RMIT,"-",2)
 S RMPR11("LOCATION")=RMLOC,RMPR11("STATION")=RMPRSTN
 I '$G(RMPR11("LOCATION")) S RMUBA=RMPR7("QUANTITY")
 S:'$G(RMUBA) RMUBA=$$BAL^RMPRPIX7(.RMPR11)
 S RMITQTY=RMPR7("QUANTITY")
 K RMPR5
 S RMPR5("IEN")=RMLOC
 S RMPRUCST=RMPR7("VALUE")/RMPR7("QUANTITY")
 S $P(R1(0),U,16)=$J(RMPRUCST,0,2)
 S $P(R3("D"),U,16)=$J(RMPRUCST,0,2)
 S $P(R1(0),U,7)=1   ;qty.
 S $P(R1(0),U,11)="" ;serial num
 S $P(R1(0),U,24)="" ;lot num
 S $P(R1(0),U,18)="" ;remarks
SCANX Q
SCANE W !,"A problem has occurred with the scan, please try again.",!
 Q
 ;
 ;***** CPT - prompt for CPT modifier
 ; (extension of RMPRPIYI and to be used only by that routine)
CPT(RDA) ;
 N DIC,Y,RQUIT,X,DA,DIR,DUOUT,DTOUT
 N RMPR1,RMPR11,RMPR11I,RMPR7,RMPR7I
 S RMPREXC=""
 D:$D(RMCPT) CHK^RMPRED5
 W:$G(REDIT) !,"OLD CPT MODIFIER: ",$P(R1(1),U,6)
 I RMHCOLD'=RMDAHC D CPT^RMPRCPTU(RDA)
 I $D(DUOUT) S RMPREXC="^" G CPTX
 I $D(DTOUT) S RMPREXC="T" G CPTX
 S $P(R1(1),U,6)=$G(RMCPT)
 W:$G(REDIT) !,"NEW CPT MODIFIER: ",$G(RMCPT)
 I RMHCOLD'="",(RMHCOLD=RMDAHC),$G(REDIT) D
 .S DIR(0)="Y",DIR("A")="Would you like to Edit CPT MODIFIER Entry  ",DIR("B")="N" D ^DIR Q:$D(DTOUT)!$D(DUOUT)
 .I $G(Y) D
 ..D CPT^RMPRCPTU(RDA)
 ..I $D(DUOUT) S RMPREXC="^"
 ..I $D(DTOUT) S RMPREXC="T"
 ..W:RMCPT=$P(R1(1),U,6) !!,"***Based on the information given above, CPT modifier string has not changed!!!",!
 ..W:RMCPT'=$P(R1(1),U,6) !,"NEW CPT MODIFIER: ",$G(RMCPT)
 ..S $P(R1(1),U,6)=$G(RMCPT)
CPTX Q
UPCASE(RMPRSTR) ;
 Q $TR(RMPRSTR,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")

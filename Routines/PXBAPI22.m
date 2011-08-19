PXBAPI22 ;ISL/DCM - API for Classification check out ; 16 Oct 2006  9:42 PM
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**1,26,184,168**;Aug 12, 1996;Build 14
ONE(TYPI,DATA,ENCOWNTR,SQUIT) ;Process One Classification
 ; Input  -- TYPI    Outpatient Classification Type IEN
 ;           DATA    Null or 409.42 IEN^Internal Value^1=n/a^1=unedt
 ;           ENCOWNTR     Outpatient Encounter file IEN (optional)
 ; Output -- SQUIT User entered '^' or timeout
 N SDCT0,SDVAL
 S SDCT0=$G(^SD(409.41,TYPI,0)) I SDCT0']"" S PXBDATA("ERR",TYPI)=1 Q  ;Bad entry
 I $P(DATA,"^",3) D:DATA  S PXBDATA("ERR",TYPI)=2 Q  ;Not applicable
 .W !,$C(7),">>> "_$P(SDCT0,"^",6)_" is no longer applicable..."
 .S DA=+DATA,DIK="^SDD(409.42," D ^DIK W "deleted."
 I DATA,$P(DATA,"^",4) D  S PXBDATA("ERR",TYPI)=3 Q  ;Uneditable data
 . W !,$P(SDCT0,"^",6)_": "_$$VAL^SDCODD(TYPI,$P(DATA,"^",2))_"  <Uneditable>"
 S SDVAL=$$VAL(TYPI,SDCT0,DATA) ;Get field value
 I SDVAL="^" S SQUIT="",PXBDATA("ERR",TYPI)=4 Q  ;user ^ out
 D STORE(+DATA,SDVAL,TYPI)
 Q
VAL(TYPI,SDCT0,DATA) ;Get Outpatient Classification
 N DIR,DA,Y,SDXS,SDEF
 I TYPI=1,$P($G(^DPT(DFN,.321)),"^",2)'="Y"!($P($G(^DPT(DFN,.321)),"^",13)'="V") G VALQ
 I TYPI=2,$P($G(^DPT(DFN,.321)),"^",3)'="Y" G VALQ
 I TYPI=4,$P($G(^DPT(DFN,.322)),"^",13)'="Y",'$$EC^SDCO22(DFN,ENCOWNTR) G VALQ
 I TYPI=3,$P($G(^SCE(+$G(ENCOWNTR),0)),"^",10)=2 S Y=1 G VALQ ;Change SC to 'yes'
 ;Automation of the SC response
 I TYPI=3,(+$G(PXD)!(+$G(PXDX))) D  I Y'="",'$G(SDSCEDIT) G VALQ
 .S SDXS($S(+$G(PXD):+PXD,1:+$G(PXDX)))=""
 .S Y=$$SC^SDSCAPI(DFN,.SDXS,ENCOWNTR,$G(VISIT)) Q:Y=""
 .S Y=+Y,SDEF=$S(Y:"YES",1:"NO")
 .I '$G(SDSCEDIT) D
 ..W !,$S($P(SDCT0,"^",2)]"":$P(SDCT0,"^",2),1:$P(SDCT0,"^")),"? "
 ..W $S(Y:"YES",1:"NO")
REASK S DIR("A")=$S($P(SDCT0,"^",2)]"":$P(SDCT0,"^",2),1:$P(SDCT0,"^"))
 I $P(DATA,"^",2)]""!($P(SDCT0,"^",4)]"") S DIR("B")=$S($D(SDEF):SDEF,$P(DATA,"^",2)]"":$$VAL^SDCODD(TYPI,$P(DATA,"^",2)),1:$P(SDCT0,"^",4))
 S DIR(0)=$P(SDCT0,"^",3)_"O" S:$D(SDEF) DIR("B")=SDEF
 I $D(^SD(409.41,TYPI,2)) S DIR(0)=DIR(0)_"^"_^(2)
 I TYPI=3 S DIR("?")="^D SC^SDCO23(DFN)"
 D ^DIR
 I $P(SDCT0,"^",5),'$D(DTOUT),$P(DATA,"^",2)="",Y=""!(Y["^"&('$P($G(^DG(43,1,"SCLR")),"^",24))) D  G REASK
 .W !,$C(7),"This is a required response." W:Y["^" "  An '^' is not allowed."
 .K DIRUT,DUOUT
 I $D(DIRUT) S Y="^"
VALQ K DIRUT,DTOUT,DUOUT
 Q $G(Y)
 ;
STORE(SDCNI,SDCNV,TYPI) ;File Outpatient Classification
 ; Input  -- SDCNI    Outpatient Classification IEN
 ;           SDCNV    Outpatient Classification Value
 ;           TYPI    Classification type 1 - Agent Orange
 ;                                        2 - Ionizing Radiation
 ;                                        3 - Service Connected
 ;                                        4 - SW Asia Conditions
 ; Output -- PXBDATA array
 ; Error codes -- PXBDATA("ERR",TYPI)=1 - Bad ptr to 409.41 in TYPI
 ;                                  2 - DATA entry not applicable
 ;                                  3 - DATA entry uneditable
 ;                                  4 - User ^ out of prompt
 S PXBDATA(TYPI)=SDCNI_"^"_SDCNV
 Q

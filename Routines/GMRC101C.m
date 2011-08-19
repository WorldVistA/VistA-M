GMRC101C ;SLC/DLT,DCM - Create Protocol entries for OE/RR ADD orders screens (Continued) ;5/21/98  13:53
 ;;3.0;CONSULT/REQUEST TRACKING;**1,5**;DEC 27, 1997
DEFAULT ;default variable setting depending on protocol type
 S OREA=$S(GMRCPFX="GMRCT ":"S GMRCEN=""C"" D EN^GMRCP",1:"S GMRCEN=""R"" D EN^GMRCP")
 S ORPKG=$$PACKAGE^GMRCR I ORPKG="" S GMRCMSG="Missing package entry for CONSULT/REQUEST TRACKING" D EXAC^GMRCADC(GMRCMSG) S GMRCEND=1 Q
 S ORFL="",ORDEF=GMRCDEF
 Q
EN ;Loop logic to process consult types/procedure request
 K DIR S DIR(0)="Y",DIR("B")="Y",DIR("A")="Do you want to select an existing "_GMRCDESC_" protocol" D ^DIR K DIR S GMRCEND=$S($D(DTOUT):1,$D(DUOUT):1,$D(DIROUT):1,1:0)
 I GMRCEND D END Q
 I Y=1 G EN1
 F  D ADD S GMRCTRLC="UPD" Q:GMRCEND
 Q
EN1 ;get a GMRCT or GMRCR prefixed protocol
 S DIC=101,DIC(0)="AEMQZ",DIC("A")="'"_GMRCPFX_"' prefixed PROTOCOL NAME: ",DIC("S")="I X["""_$E(GMRCPFX,1,$L(GMRCPFX)-1)_"""" D ^DIC K DIC I Y<0 S GMRCEND=1 D END Q
 I GMRCPFX="GMRCT ",Y(0)'?1"GMRCT ".E W !,"Select a 'GMRCT ' prefixed protocol",! G EN1
 I GMRCPFX="GMRCR ",Y(0)'?1"GMRCR ".E W !,"Select a 'GMRCR ' prefixed protocol",! G EN1
 D DEFAULT S ORDA=+Y,ORDANM=$P(Y(0),"^",1) D SETUP,ASK I GMRCEND D END Q
 S GMRCTRLC="MUP",GMRCACT="UPD"
 D BUILD,END W ! G EN
ADD ;Enter a new protocol
 K ORDA,ITEMTXT,ORDANM D DEFAULT Q:GMRCEND  D ASK I GMRCEND D END Q
 S GMRCTRLC="MAD",GMRCACT="REP"
 D BUILD,END
 Q
ASK ;Ask for Item Text and Related Service
 D ITEMTXT Q:GMRCEND
 I $D(GMRCSS),$L(GMRCSS) S DIR("B")=GMRCSS
ASK1 ;Ask for Relate Service
 K DA,X S DIR(0)="PO^123.5:EMZ",DIR("A")="RELATED CONSULT SERVICE/SPECIALTY" D ^DIR K DIR I $D(X),X="@" W !,$C(7),"You Cannot Delete This Entry, ONLY CHANGE IT!",! D  G ASK1
 .I $D(GMRCSS),$L(GMRCSS) S DIR("B")=GMRCSS
 .Q
 S GMRCEND=$S($D(DTOUT):1,$D(DUOUT):1,$D(DIROUT):1,Y<0:1,1:0) I GMRCEND D END Q
 S:+Y>0 ORFL=+Y_";GMR(123.5,"
 Q:GMRCEND
 I $P(^GMR(123.5,+Y,0),"^",2)=9 W !,$C(7),$P(^(0),"^",1)_" Has Been Disabled.",!,"You Cannot Add A Procedure To A Disabled Service!",! G ASK1
 I ORFL="" W !!,"  Each "_GMRCDESC_" will have a related consult service associated with it.",!,"  If no service is identified the service will be prompted for during the",!,"  add orders process.",!
 Q
ITEMTXT ;Ask for item text
 K DIR,DA I $D(ORDA),$L(ITEMTXT) S DIR("B")=ITEMTXT
 I '$D(ORDA) W !! S DIR("A")="Enter the new protocols ITEM TEXT"
 K REJECT S DIR(0)="101,1" D ^DIR K DIR S GMRCEND=$S($D(DTOUT):1,$D(DUOUT):1,$D(DIROUT):1,1:0) K DIROUT,DUOUT,DTOUT Q:GMRCEND  I Y="" S GMRCEND=2 Q
 I $E(Y,1)'?1A W !!,"The ITEM TEXT should begin with an alphabetic character.  Please re-enter." G ITEMTXT
 I $D(ORDA),ORDA,Y=ITEMTXT S (GMRCTXT,ORTXT)=Y Q
 S GMRCTXT=$O(^ORD(101,"C",Y,"")) I GMRCTXT D  I $D(REJECT) K REJECT G ITEMTXT
 .S GMRCY=Y W !,"** "_Y_" is already being used by "
 .S GMRCTXT="" F  S GMRCTXT=$O(^ORD(101,"C",Y,GMRCTXT)) Q:GMRCTXT=""  S TXT=$P($G(^ORD(101,GMRCTXT,0)),"^",1) W:((78-$X)'>$L(TXT)) ! W ?25," "_TXT I TXT?1"GMRCT ".E S REJECT=1
 .I $D(REJECT) W !,"This is a duplicate name.  Please re-enter a unique item text." Q
 .I '$D(ORDA) S DIR(0)="Y",DIR("A")="Do you really want to add '"_GMRCPFX_GMRCY_"' as a new "_GMRCDESC_" Protocol",DIR("B")="NO" D ^DIR K DIR I Y=0 S REJECT=1
 .S Y=GMRCY
 .Q
 I $D(ORDA),$P(^ORD(101,ORDA,0),"^",1)'=GMRCPFX_Y D ACCESS I $D(GMRC101) W !,"The Protocol name "_$P(^ORD(101,ORDA,0),"^",1),!,"     WILL NOT be changed to match ITEM TEXT due to Package Code dependencies!",!
 S ORTXT=Y I '$D(GMRC101) S ORDANM=GMRCPFX_ORTXT
 Q
SETUP ;Get the Itemtext and service name
 Q:'$D(ORDA)  Q:'ORDA
 S ITEMTXT=$P(^ORD(101,ORDA,0),"^",2)
 S GMRCSS=+$P($G(^ORD(101,ORDA,5)),"^",1),GMRCSS=$P($G(^GMR(123.5,GMRCSS,0)),"^",1)
 Q
ACCESS ;Check for Protocol Item with GMRC101 security restricting name change of the Protocols .01 field.
 Q:'$D(ORDA)
 N DIC,X,Y
 S DIC=19.1,DIC(0)="FMX",X="GMRC101" D ^DIC Q:(+Y<1)
 S:$D(^ORD(101,ORDA,3,"B",+Y)) GMRC101=1
 Q
BUILD ;Logic to update file 101
 S (GMRCPRO,ORDANM)=$TR(ORDANM,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ"),GMRCTXT=$S(GMRCTXT="":ORTXT,1:GMRCTXT),GMRCSV=ORFL,GMRCSS=ORFL
 D EN3^GMRCPREF
 S DA=$S($G(DA):DA,$G(ORDA):ORDA,1:"") I '$L(DA) W !!,$C(7),GMRCPRO_" Was Not Added To The Protocol Or Orderable Item File!",! Q
 S DIE="^ORD(101,",DR=1.1 D ^DIE D
 .S ND=0 F I=1:1 S ND=$O(^ORD(101,DA,2,ND)) Q:ND?1A.E!(ND="")  S GMRCSYN(I)=^ORD(101,DA,2,ND,0)
 .Q
 K DIR D:GMRCTRLC'="MAD"  I $S($D(DTOUT):1,$D(DUOUT):1,$D(DIROUT):1,1:0) D END S GMRCEND=1 Q
 .I $S('$L($P(^ORD(101,DA,0),"^",3)):1,+$P(^(0),"^",3)=0:1,1:0) S DIR(0)="Y",DIR("A")="Do You Want To DISABLE This Protocol" D ^DIR K DIR D:Y=1  Q
 ..S DR="2////^S X=""1 No Longer Used""" D ^DIE S GMRCTRLC="MDC"
 ..Q
 .I $L($P(^ORD(101,DA,0),"^",3)),+$P(^(0),"^",3)=1 S DIR(0)="Y",DIR("A")="Do You Want To ACTIVATE This Disabled Protocol" D ^DIR K DIR D:Y=1  Q
 ..S DR="2///@" D ^DIE
 ..Q
 .Q
 D EN^GMRC101H(GMRCACT,GMRCTRLC,DA,GMRCTXT,.GMRCSYN,GMRCPFX)
 D MSG^XQOR("GMRC ORDERABLE ITEM UPDATE",.GMRCMSG)
 I $E(GMRCPRO,1,6)="GMRCR " D
 .S GMRCPROI=$O(^ORD(101,"B",GMRCPRO,0)) Q:'GMRCPROI
 .D GMRCR^GMRCMU
 K DIC,DIE,DIR,DR,ORDA,ORDANM,ORDEF,OREA,ORFL,ORPKG,ORTXT
 Q
END ;Clean-up logic
 K I,GMRC101,GMRCMSG,GMRCPRO,GMRCPROI,GMRCSS,GMRCSYN,GMRCSV,GMRCTRLC,GMRCTXT,GMRCY,ITEMTXT,ND
 K ORDA,ORDANM,ORDEF,OREA,ORFL,ORPKG,ORTXT
 K DIROUT,DUOUT,DTOUT,TXT,Y
 Q

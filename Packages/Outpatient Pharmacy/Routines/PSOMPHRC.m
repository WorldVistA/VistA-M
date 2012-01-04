PSOMPHRC ;BIRM/JAM - Patient Medication Profile for HRC - Listmanager ;02/01/11
 ;;7.0;OUTPATIENT PHARMACY;**382**;DEC 1997;Build 9
 ;Reference to ^DISV supported by DBIA 510
 ;Standalone option provided to CAPRI supported by DBIA 4595
 ;
EN ;Menu option entry point
 N PSOEXPDC,PSOEXDCE,PSOSRTBY,PSORDER,PSOSIGDP,PSOSTSGP,PSOSTORD,PSORDCNT,PSOSTSEQ,PSORDSEQ,PSOCHNG
 N GRPLN,DIC,Y,DFN,HIGHLN,LASTLINE,VALMCNT,DFN,PSOQIT,WARD,PSODFN,PSOHRC
 ;
 ; -- Division selection
 I '$G(PSOSITE) D ^PSOLSET I '$D(PSOPAR) W $C(7),!!,"Pharmacy Division Must be Selected!",! G EXIT
 S PSOHRC=1
 ;
PAT ; -- Patient selection 
 D EN^PSOPATLK S Y=PSOPTLK
 I +Y'>0 G EXIT
 S DFN=+Y,PSOQIT=0
 D DEM^VADPT I +VADM(6) D  G PAT
 .W !?10,$C(7),VADM(1)_" ("_VA("PID")_") DIED ON "_$P(VADM(6),"^",2),!
 S WARD=$$GET1^DIQ(2,DFN,.1) I WARD]"" D  G:PSOQIT PAT
 .W !!?10,$C(7),VADM(1)_" ("_VA("PID")_")"
 .W !?10,$C(7),"Patient is an Inpatient on Ward "_WARD_" !!"
 .W ! D DIR
 S PSODFN=DFN D CHKADDR^PSOBAI(DFN,1,1)  ;bad address flag/update
 ;build listman screen ^TMP("PSOPI",$J, for patient information display
 D ^PSOORUT2,^PSOBUILD
 D LST(PSOSITE,DFN)
 G PAT
 Q
 ;
LST(SITE,PSODFN) ; -- ListManager entry point
 ; Loading Division/User preferences
 D LOAD^PSOPMPPF(SITE,DUZ)
 W !,"Please wait..."
 D EN^VALM("PSO HRC MAIN")
 D FULL^VALM1
 D EXIT
 Q
 ;
INIT ; -- rebuild ^TMP("PSOPMP0",$J and PSOLST array from ^TMP("PSOPMP0",$J
 N NUM,RX,CNT,TYP
 D INIT^PSOPMP0
INT ; rebuild PSOLST only
 K PSOLST
 S (NUM,CNT)=0
 F  S NUM=$O(^TMP("PSOPMP0",$J,NUM)) Q:'NUM  D
 .F TYP="RX","PEN","NVA" S RX=$G(^TMP("PSOPMP0",$J,NUM,TYP))  I RX'="" D
 ..S CNT=CNT+1,PSOLST(CNT)=$S(TYP="RX":52,TYP="PEN":52.41,1:55.05)_"^"_RX_"^"_$P($$STSINFO^PSOPMP1(RX),"^",2)
 S PSOCNT=CNT
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="This is a test header for PSO HRC REFILL SELECTION."
 S VALMHDR(2)="This is the second line"
 Q
 ;
HDRF ; -- rebuild listman array for Speed refill
 I $G(PSOHRCF) D INIT^PSOPMP0
 K PSOHRCF
 Q
 ;
SEL ; -- Process selection of RX entries
 N PSOSEL,PSOLIS,TYPE,XQORM,ORD,TITLE,XX
 S PSOLIS=$P(XQORNOD(0),"=",2) I 'PSOLIS S VALMSG="Invalid selection!",VALMBCK="R" Q
 S TITLE=VALM("TITLE")
 F XX=1:1:$L(PSOLIS,",") Q:$P(PSOLIS,",",XX)']""  D
 .S PSOSEL=+$P(PSOLIS,",",XX) I 'PSOSEL S VALMSG="Invalid selection!" Q
 .S TYPE=$O(^TMP("PSOPMP0",$J,PSOSEL,0)) I TYPE="" S VALMSG="Invalid selection!" Q
 .S ORD=$G(^TMP("PSOPMP0",$J,PSOSEL,TYPE))
 .I 'ORD S VALMSG="Invalid selection!" Q
 .D INT
 .;
 .; -- Regular prescription
 .I TYPE="RX" D  S VALMBCK="R" D REF^PSOPMP0
 .. N STAT,PROACT,LINE,TITLE
 .. S (Y,ORN)=PSOSEL,COPY=1
 .. D NEWSEL^PSOORNE2,INIT
 .. S STAT=$$GET1^DIQ(52,$P(PSOLST(ORN),"^",2),100,"I"),PSOACT=$S('STAT:"R",1:""),VALMSG="Enter ?? for more actions"
 .. D LG
 .;
 .; -- Pending Order
 .I TYPE="PEN" D  S VALMBCK="R" D REF^PSOPMP0
 .. N PSOACTOV,OR0,OLVLM,LINE,TITLE
 .. S OR0=^PS(52.41,ORD,0),PSOACTOV=1,OLVLM=$$ADPL()
 .. D PENHDR^PSOPMP1(PSODFN),DSPL^PSOORFI1
 .. I OLVLM S ^DISV(+$G(DUZ),"VALMMENU",$P(OLVLM,"^",2))=OLVLM
 .;
 .; -- Non-VA Order
 .I TYPE="NVA" D
 .. N LINE,TITLE D EN^PSONVAVW(PSODFN,ORD)
 .;
 S VALMBCK="R",VALM("TITLE")=TITLE
 Q
 ;
ACTIONS() ; -- screen actions on active orders
 N DIC,X,Y
 K DIC,Y S DIC="^ORD(101,"_DA(1)_",10,",X=DA,DIC(0)="ZN" D ^DIC Q:Y<0 0
 S Y=Y(0,0)
 I Y="PSO REFILL" Q $S(PSOACT["R":1,1:0)
 Q 1
 ;
ADPL() ; -- disable actions for pending orders
 N DIC,X,Y,OLVAL,PRCT
 S DIC="^ORD(101,",X="PSO PENDING ORDER MENU",DIC(0)="ZN" D ^DIC Q:Y<0 ""
 S PRCT=+Y_";ORD(101,",OLVAL=$G(^DISV(+$G(DUZ),"VALMMENU",PRCT)) I OLVAL="" Q ""
 I 'OLVAL Q 0_"^"_PRCT
 S ^DISV(+$G(DUZ),"VALMMENU",PRCT)=0
 Q 1_"^"_PRCT
 ;
PI ; -- entry point for PSO HRC Patient Information
 I '$D(^TMP("PSOPI",$J)) D ^PSOORUT2
 D EN^VALM("PSO HRC Patient Information")
 S VALMBCK="R"
 Q 
DD ; -- entry point for PSO HRC DETAILED ALLERGY
 D EN^VALM("PSO HRC DETAILED ALLERGY")
 Q
 ;
LG ; -- entry point for PSO HRC REFILL
 S (VALMCNT,PSOPF)=$O(^TMP("PSOAO",$J,"A"),-1)
 D EN^VALM("PSO HRC REFILL")
 Q
DIR ; -- Dir call
  N DIR,X,Y
  S DIR(0)="Y",DIR("B")="NO",DIR("A")="Do You Want To Continue" D ^DIR K DIR
  S:'Y PSOQIT=1
  K DIRUT,DTOUT,DUOUT
  Q
EXIT ;
 K ^TMP("PSOPMP0",$J),^TMP("PSOPMPSR",$J),^TMP("PSODA",$J),^TMP("PSONVAVW",$J)
 K COPY,DA,PSOCNT,PSONEW,ORN,PSOACT,PSOPF,PSOHRCF
 D KVA^VADPT,PTX^PSORX1,EOJ^PSORX1
 Q
 ;
HELP Q

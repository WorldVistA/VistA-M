PSOSPML1 ;BIRM/MFR - Export Batch Processing Listman Driver ;10/10/12
 ;;7.0;OUTPATIENT PHARMACY;**408,451**;DEC 1997;Build 114
 ;
 N %DT,BATIEN,DIR,DIRUT,X,DIC,DTOUT,DUOUT,STATEIEN,PSOFROM,PSOTO,VALM,VALMCNT,VALMHDR,VALMBCK,VALMSG,PSOLSTLN
 ;
STA ; STATE prompt
 K DIC W ! S DIC("A")="STATE: ",DIC="^DIC(5,"
 S STATEIEN=$O(^PS(58.41,0)) S:STATEIEN DIC("B")=STATEIEN
 S DIC(0)="AEQMZ" D ^DIC I X="^"!(Y<0) G EXIT
 I +$$SPOK^PSOSPMUT(+Y)=-1 W !!,$P($$SPOK^PSOSPMUT(+Y),"^",2),$C(7) G STA
 S STATEIEN=+Y
 ;
 ; - Ask for FROM DATE
 S %DT(0)=-DT,%DT="AEP",%DT("A")="BATCH CREATED BEGIN DATE: "
 W ! D ^%DT I Y<0!($D(DTOUT)) G EXIT
 S PSOFROM=Y\1-.00001
 ;
 ; - Ask for TO DATE
 K %DT S %DT(0)=PSOFROM+1\1,%DT="AEP",%DT("B")="TODAY",%DT("A")="BATCH CREATED END DATE: "
 W ! D ^%DT I Y<0!($D(DTOUT)) G EXIT
 S PSOTO=Y\1+.99999
 ;
 D EN(STATEIEN,PSOFROM,PSOTO)
 ;
 G EXIT
 ;
EN(STATEIEN,PSOFROM,PSOTO) ; Entry point
 D EN^VALM("PSO SPMP BATCH PROCESSING")
 D FULL^VALM1
 Q
 ;
HDR ; - Builds the Header section
 K VALMHDR
 S VALMHDR(1)="State: "_$$GET1^DIQ(5,STATEIEN,.01)
 S $E(VALMHDR(1),40)="Date Range: "_$$FMTE^XLFDT(PSOFROM+1\1,2)_" - "_$$FMTE^XLFDT(PSOTO\1,2)
 D SETHDR()
 Q
 ;
SETHDR() ; - Displays the Header Line
 N HDR,ORD,POS
 ;
 S HDR="   #",$E(HDR,7)="BATCH#",$E(HDR,15)="DATE/TIME CREATED",$E(HDR,34)="REL. DATE RANGE"
 S $E(HDR,54)="TYPE",$E(HDR,66)="Rx's",$E(HDR,72)="EXPORTED?"
 S $E(HDR,81)="" D INSTR^VALM1(IORVON_HDR_IOINORM,1,3)
 Q
 ;
INIT ; Builds the Body section
 N RXCNT,BATDT,I,LINE,TYPE,NODE0,RX,COUNT,DRUGIEN,DRUGNAM,DRUGDEA,DSPLINE,FILL
 ;
 K ^TMP("PSOSPML1",$J) S (VALMCNT,LINE,RXCNT,COUNT,PSOLSTLN)=0
 S BATDT=PSOFROM,BATIEN=0
 F  S BATDT=$O(^PS(58.42,"AD",BATDT)) Q:'BATDT!(BATDT>PSOTO)  D
 . F  S BATIEN=$O(^PS(58.42,"AD",BATDT,BATIEN)) Q:'BATIEN  D
 . . S NODE0=$G(^PS(58.42,BATIEN,0))
 . . I $P(NODE0,"^",2)'=STATEIEN Q
 . . S COUNT=COUNT+1,RXCNT=$O(^PS(58.42,BATIEN,"RX",999999),-1)
 . . S DSPLINE=$J(COUNT,4)_" "_$J(BATIEN,7),$E(DSPLINE,15)=$$FMTE^XLFDT(BATDT,"2Z")
 . . S $E(DSPLINE,34)=$$FMTE^XLFDT($P(NODE0,"^",5)\1,"2Z")_"-"_$$FMTE^XLFDT($P(NODE0,"^",6)\1,"2Z")
 . . I $P(NODE0,"^",3)="RX" S $E(DSPLINE,34,51)="SINGLE RX         "
 . . I $P(NODE0,"^",3)="VD",'$P(NODE0,"^",5) S $E(DSPLINE,34,51)="SINGLE RX         "
 . . S $E(DSPLINE,54)=$$GET1^DIQ(58.42,BATIEN,2)
 . . S $E(DSPLINE,66)=$J(RXCNT,4),$E(DSPLINE,72)=$S($$GET1^DIQ(58.42,BATIEN,9,"I"):"YES",1:"NO")
 . . D SETLN^PSOSPMU1("PSOSPML1",DSPLINE,0,0,0)
 . . S ^TMP("PSOSPML1",$J,LINE,"BAT")=BATIEN
 I '$D(^TMP("PSOSPML1",$J)) D
 . D SETLN^PSOSPMU1("PSOSPML1","There are no export batches created within the date range selected.",0,0,0)
 S VALMCNT=LINE
 Q
 ;
SEL ;Process selection of one entry
 N PSOSEL,XQORM,ORD,PSOTITLE,PSOLIS,XX,BAT
 S PSOSEL=+$P(XQORNOD(0),"=",2) I 'PSOSEL S VALMSG="Invalid selection!",VALMBCK="R" Q
 S BAT=+$G(^TMP("PSOSPML1",$J,PSOSEL,"BAT"))
 I 'BAT S VALMSG="Invalid selection!",VALMBCK="R" Q
 S PSOTITLE=VALM("TITLE")
 W ?50,"Please wait..."
 D  ; Do used to preserve a few variables that could get overwritten
 . N LINE,PSOTITLE,PSOFROM,PSOTO D EN^PSOSPML2(BAT)
 S VALMBCK="R",VALM("TITLE")=$G(PSOTITLE)
 D INIT
 Q
 ;
MAN ; Manual Batch Export
 D FULL^VALM1 S VALMBCK="R"
 N %DT,DIR,DIRUT,X,DIC,DTOUT,DUOUT,BEGINDT,PSOBGDT,ENDDT,PSOENDDT,PSOERROR,SPOK
 N RECTYPE,STATE,PSOQUIT,FILLTYPE
 ;
 K DIC W ! S DIC("A")="STATE: ",DIC("S")="I $D(^PS(58.41,+Y,0))",DIC="^DIC(5,"
 S:$G(STATEIEN) DIC("B")=STATEIEN
 S DIC(0)="AEQMZ" D ^DIC I X="^"!(Y<0) G EXIT
 S STATE=+Y
 ;
 ; - Ask for FROM DATE
 ;   Note: The legislation allowing VA to report was published on 02/11/2013
 S %DT(0)=3130211,%DT="AEP",%DT("A")="EXPORT BEGIN DATE: "
 W ! D ^%DT I Y<0!($D(DTOUT)) Q
 S BEGINDT=Y
 ;
 ; - Ask for TO DATE
 K %DT S %DT(0)=BEGINDT\1,%DT="AEP",%DT("B")="TODAY",%DT("A")="EXPORT END DATE: "
 W ! D ^%DT I Y<0!($D(DTOUT)) Q
 S ENDDT=Y
 ;
 S PSOQUIT=0,FILLTYPE=""
 I $$GET1^DIQ(58.41,STATE,1,"I")="1995" D  I PSOQUIT Q
 . K DIR S DIR("A")="Rx Fill Type"
 . S DIR("L",1)="Enter the Prescription Fill Type:"
 . S DIR("L",2)=" "
 . S DIR(0)="S^RL:RELEASED;RS:RETURNED TO STOCK"
 . S DIR("L",3)="  RL     RELEASED"
 . S DIR("L")="  RS     RETURNED TO STOCK"
 . S DIR("B")="RL" D ^DIR I $D(DUOUT)!($D(DIRUT)) K DIRUT,DUOUT,DIR S PSOQUIT=1 Q
 . S FILLTYPE=Y
 ; 
 S PSOQUIT=0,RECTYPE="N"
 I FILLTYPE'="RS" D  I PSOQUIT Q
 . K DIR S DIR("A")="Record Type"
 . S DIR("L",1)="Enter the type of record to be sent for released prescription fills:"
 . S DIR("L",2)=" "
 . S DIR(0)="S^N:NEW;R:REVISE"
 . S DIR("L",3)="  N     NEW"
 . S DIR("L")="  R     REVISE"
 . S DIR("B")="NEW" D ^DIR I $D(DUOUT)!($D(DIRUT)) K DIRUT,DUOUT,DIR S PSOQUIT=1 Q
 . S RECTYPE=Y
 ;
 D EXPORT(STATE,BEGINDT,ENDDT,FILLTYPE,RECTYPE)
 Q
 ;
EXPORT(STATE,FROMDATE,TODATE,FILLTYPE,RECTYPE) ; Export Release CS Rx's to the sate for date range
 ;Input: STATE - Pointer to the STATE file (#5)
 ;       FROMDATE - Being Rx Release for Date Range
 ;       TODATE - End Rx Release for Date Range
 ;       FILLTYPE - Rx Fill Type (RL - Released / RS - Returned to Stock) - ASAP 1995 only 
 ;       RECTYPE - Record Type (N - New / R - Revise)
 N RXRLDT,ENDRLDT,XREF,RXCNT,RXIEN,RXFILL,FILL,SPOK,DIR,Y,X,DTOUT,DUOUT,BATCHIEN
 N RTSDT,ENDRTSDT,RTSONLY,PSOMODE
 ;
 S SPOK=$$SPOK^PSOSPMUT(STATE)
 I $P(SPOK,"^")=-1 D  Q
 . W !!,$P(SPOK,"^",2),$C(7) D PAUSE^PSOSPMU1 Q
 ;
 ; The legislation allowing VA to report was published on 02/11/2013
 I FROMDATE<3130211 S FROMDATE=3130211
 ;
 ; ASAP 1995 ONLY 
 S RTSONLY=0 I $$GET1^DIQ(58.41,STATE,1,"I")="1995",FILLTYPE="RS" S RTSONLY=1
 ; 
 ; Gathering the prescriptions to be transmitted in the ^TMP("PSOSPMRX",$J) global
 W !!,"Gathering CS prescription fills...(this may take a few minutes)"
 K ^TMP("PSOSPMRX",$J) S RXCNT=$$GATHER^PSOSPMU1(STATE,FROMDATE-.1,TODATE+.24,RECTYPE,RTSONLY)
 ;
 I RXCNT'>0 D  Q
 . W !!,"There are no eligible prescriptions for the date range.",$C(7)
 . D PAUSE^PSOSPMU1
 E  W !!,RXCNT," prescription fill(s) found for the date range."
 I '$D(^TMP("PSOSPMRX",$J)) Q
 ; 
 S PSOQUIT=0
 I 'RTSONLY!$$GET1^DIQ(58.41,STATE,12,"I") D  I PSOQUIT Q
 . K DIR W ! S DIR("A",1)="These prescription fills will be transmitted to the state of "_$$GET1^DIQ(5,STATE,.01)_"."
 . S DIR("A",2)="",DIR("A")="Confirm",DIR(0)="Y",DIR("B")="N"
 . D ^DIR I $G(DIRUT)!$G(DUOUT)!'Y S PSOQUIT=1 Q
 . W ?40,"Please wait..."
 ;
 ; Return To Stock fills only
 I RTSONLY,'$$GET1^DIQ(58.41,STATE,12,"I") D  D ^%ZIS K %ZIS Q:POP  U IO
 . D EXMSG^PSOSPML2(1) W ! K %ZIS,IOP,POP,ZTSK S %ZIS="QM"
 ;
 ; The ^TMP("PSOSPMRX",$J) returned above will be used to build the batch 
 S BATCHIEN=$$BLDBAT^PSOSPMU1($S('RTSONLY:"MA",1:"VD"),FROMDATE,TODATE)
 I $P(BATCHIEN,"^")=-1 D  Q
 . W !!,$P(BATCHIEN,"^",2),$C(7) D PAUSE^PSOSPMU1
 ;
 S PSOMODE="EXPORT" I RTSONLY,'$$GET1^DIQ(58.41,STATE,12,"I") S PSOMODE="VIEW"
 D EXPORT^PSOSPMUT(BATCHIEN,PSOMODE)
 ;
 I RTSONLY,'$$GET1^DIQ(58.41,STATE,12,"I") D
 . D ^%ZISC N DIE,DA,DR S DIE="^PS(58.42,",DA=BATCHIEN
 . S DR="6///<Manual Web Upload>;7////"_DUZ_";9///"_$$NOW^XLFDT()
 . D ^DIE
 ;
 D PAUSE^PSOSPMU1
 D INIT,HDR
 Q
 ;
EXIT ;
 K ^TMP("PSOSPML1",$J)
 Q
 ;
HELP ; Listman HELP entry-point
 Q

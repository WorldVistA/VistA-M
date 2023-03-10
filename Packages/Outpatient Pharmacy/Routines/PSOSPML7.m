PSOSPML7 ;BIRM/MFR - Resend a Group of Selected Prescriptions ;10/10/12
 ;;7.0;OUTPATIENT PHARMACY;**625,630**;DEC 1997;Build 26
 ;
 ;
ASK ; MANUAL BATCH EXPORT
 ;RETRIEVE FILTERS FROM USER
 D FULL^VALM1 S VALMBCK="R"
 N %DT,DIR,DIRUT,X,DIC,DTOUT,DUOUT,BEGINDT,ENDDT,PSOERROR
 N RECTYPE,STATE,QUIT,ARRAY,TAG,FILTER
 ;
 ; - Selection of STATE
 W ! S DIC("A")="STATE: ",DIC("S")="I $D(^PS(58.41,+Y,0))",DIC="^DIC(5,"
 S DIC("B")=$$GET1^DIQ(5,+$O(^PS(58.41,0)),.01)
 S DIC(0)="AEQMZ" D ^DIC I X="^"!(Y<0) Q
 S STATE=+Y
BEGDT ;
 ; - Ask for Start DATE
 ;   Note: The legislation allowing VA to report was published on 02/11/2013
 N XDT S XDT=$$FMADD^XLFDT(DT,-1)
 S %DT(0)=3130211,%DT="AEP",%DT("A")="Export Rx's Starting with RELEASE DATE (2/11/13 to "_$$FMTE^XLFDT(XDT,2)_"): "
 W ! D ^%DT
 I X="" W !!?5,"Starting RELEASE DATE is required or enter '^' to exit.",! G BEGDT
 I Y<0!($D(DTOUT)) Q
 I (Y=DT)!(Y>DT) W !!?5,"Only past dates are allowed." D PAUSE^PSOSPMU1 G BEGDT
 S BEGINDT=Y
 ;
 W !!?5,"Prescriptions released today will be included in the next scheduled batch."
 ;
ENDDT ;
 ; - Ask for End DATE
 K %DT S %DT(0)=BEGINDT\1,%DT="AEP",%DT("B")="TODAY-1",%DT("A")="Export Rx's Ending with RELEASE DATE ("_$$FMTE^XLFDT(BEGINDT,2)_" to "_$$FMTE^XLFDT(XDT,2)_"): "
 W ! D ^%DT I Y<0!($D(DTOUT)) Q
 I (Y=DT)!(Y>DT) W !!?5,"The latest end date permitted is TODAY-1 (yesterday)." D PAUSE^PSOSPMU1 G ENDDT
 S ENDDT=Y
 ;
 S QUIT=0,FILTER="NC"
 D  Q:QUIT
 . K DIR S DIR("A")="Filter Selection"
 . S DIR(0)="S^PA:Patient;PR:Prescriber;DR:Drug;DV:Division;RX:Prescription;NC:No Criteria"
 . S DIR("L",1)="Select prescriptions by one of the following criteria:"
 . S DIR("L",2)=" "
 . S DIR("L",3)="  PA     Patient"
 . S DIR("L",4)="  PR     Prescriber"
 . S DIR("L",5)="  DR     Drug"
 . S DIR("L",6)="  DV     Division"
 . S DIR("L",7)="  RX     Prescription"
 . S DIR("L")="  NC     No criteria (unfiltered). All Rx's within the date range selected."
 . D ^DIR I $D(DUOUT)!($D(DIRUT)) K DIRUT,DUOUT,DIR S QUIT=1 Q
 . S FILTER=Y
 ;
 K ARRAY
 S TAG=$S(FILTER="PA":"PATSEL",FILTER="PR":"PRESCSEL",FILTER="DR":"DRGSEL",FILTER="DV":"DIVSEL",FILTER="RX":"RXSEL",1:"NOCRITERIA")
 D @TAG
 I TAG'="NOCRITERIA",'$O(ARRAY(0)) Q
 D RTSEL
 Q:QUIT
 ; create and export the batch passing ARRAY which will be the iens of patients, prescribers, drugs, divisions, or prescriptions.  
 ; If no filter criteria was selected then the ARRAY variable would equal "NC"
 D EXPORT^PSOSPML1(STATE,BEGINDT,ENDDT,"RL",RECTYPE,.ARRAY)
 Q
 ;
NOCRITERIA ;
 ; No criteria was selected.  All RXs will be sent within the given date range.
 S ARRAY="NC"
 Q
 ;
PATSEL ;
 ; - Selection of PATIENTS
 N DIC,X,I,Y
 N DIR,DTOUT,DUOUT,DIROUT
 S DIC(0)="QEAM",DIC("A")="Select PATIENT: "
 W !!,"You may enter one or more PATIENTS in succession.",!
 F  D PATLK S Y=PSOPTLK Q:+Y<1  S ARRAY(+Y)="" K PSOPTLK S DIC("A")="Another PATIENT: "
 I $G(PSOPTLK)="^" S QUIT=1 K ARRAY
 I $O(ARRAY(0)) S ARRAY="PA"
 Q
 ;
PRESCSEL ;
 ; - Selection of PRESCRIBERS 
 N DIC,X,I,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIC="^VA(200,",DIC(0)="QEAM"
 S DIC("W")="W ""     "",$P(^(""PS""),""^"",9)"
 S DIC("A")="Select PRESCRIBER: "
 S DIC("S")="I $D(^(""PS"")),$P(^(""PS""),""^""),$S('$P(^(""PS""),""^"",4):1,1:$P(^(""PS""),""^"",4)'<DT)"
 W !!,"You may enter one or more PRESCRIBERS in succession.",!
 F  D ^DIC D  Q:QUIT
 . I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) K ARRAY S QUIT=1 Q
 . I +Y<1&'$O(ARRAY(0)) W !!,"Please enter at least one PRESCRIBER or '^' to exit.",! Q
 . I +Y<1 S QUIT=1 Q
 . S ARRAY(+Y)=""
 . S DIC("A")="Another PRESCRIBER: "
 I $O(ARRAY(0)) S ARRAY="PR"
 Q
 ;
DIVSEL ; - Division selection (one, multiple or ALL)
 N DIC,DTOUT,DUOUT,DIROUT,Y,X,XX
 W !!,"You may enter one or more DIVISIONS in succession.",!
 I '$G(DT) N DT S DT=$$NOW^XLFDT()
 S DIC("S")="I $S('$D(^PS(59,+Y,""I"")):1,'^(""I""):1,DT'>^(""I""):1,1:0)"
 S DIC="^PS(59,",DIC(0)="QEZAM",DIC("A")="Select DIVISION: "
 F  D ^DIC D  Q:QUIT
 . I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) K ARRAY S QUIT=1 Q
 . I +Y<1&'$O(ARRAY(0)) W !!,"Please enter at least one DIVISION or '^' to exit.",! Q
 . I +Y<1 S QUIT=1 Q
 . S ARRAY(+Y)=""
 . S DIC("A")="Another DIVISION: "
 I $O(ARRAY(0)) S ARRAY="DV"
 Q
 ;
DRGSEL ;
 ; Prompt for drug
 N DIC,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIC(0)="AEMQ",DIC=50
 S DIC("S")="I $$CSDRUG^PSOSPML7(Y)"
 S DIC("A")="Select DRUG GENERIC NAME: "
 W !!,"You may enter one or more DRUGS in succession.",!
 F  D ^DIC D  Q:QUIT
 . I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) K ARRAY S QUIT=1 Q
 . I +Y<1&'$O(ARRAY(0)) W !!,"Please enter at least one DRUG or '^' to exit.",! Q
 . I +Y<1 S QUIT=1 Q
 . S ARRAY(+Y)=""
 . S DIC("A")="Another DRUG: "
 I $O(ARRAY(0)) S ARRAY="DR"
 Q
 ;
RXSEL ;
 ; - Selection of prescriptions - Prescription prompt
 N DIR,X,Y,FILLNUM,SCREEN,DTOUT,DUOUT,DIROUT
 W !!,"You may enter one or more PRESCRIPTIONS in succession.",!
 F  D RXSEL1 Q:QUIT
 I $O(ARRAY(0)) S ARRAY="RX"
 Q
RXSEL1 ;
 s DIR("A")=$S('$O(ARRAY(0)):"Select PRESCRIPTION: ",1:"Another PRESCRIPTION: ")
 S DIR(0)="FAO^1:30",(DIR("?"),DIR("??"))="^D HLP^PSOSPML7"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIROUT) K ARRAY S QUIT=1 Q
 I X=""&'$O(ARRAY(0)) W !!,"Please enter at least one PRESCRIPTION or '^' to exit.",! Q
 I X="" S QUIT=1 Q
 S X=$$UP^XLFSTR(X),QUIT=0
 I $E(X,1,2)'="E." S RXIEN=+$$RXLKP(X) I RXIEN<0 Q
 I $E(X,1,2)="E." D  I QUIT S QUIT=0 Q
 . I $L(X)'=9 W !?5,"The ECME# must be 7 digits long!",$C(7) S QUIT=1 Q
 . S RXIEN=+$$RXNUM^PSOBPSU2($E(X,3,9)) I RXIEN<0 W " ??" S QUIT=1
 S FILLNUM=$$RXFILL^PSOSPMU2(RXIEN) I FILLNUM="^" S QUIT=1 Q
 S SCREEN=$$SCREEN^PSOSPMUT(RXIEN,FILLNUM)
 I +SCREEN D  Q:$P(SCREEN,"^",3)="E"
 . W !!?1,$S($P(SCREEN,"^",3)="E":"ERROR",1:"WARNING"),": ",$P(SCREEN,"^",2),$C(7) D PAUSE^PSOSPMU1
 I '$$RXRLDT^PSOBPSUT(RXIEN,FILLNUM) D  Q
 . W !!?1,"Cannot select.  Prescription not RELEASED. " D PAUSE^PSOSPMU1
 I '$D(^PS(58.42,"ARX",RXIEN,FILLNUM)) D  Q
 . W !!?1,"Cannot select.  Prescription not previously in a transmission batch. " D PAUSE^PSOSPMU1
 S ARRAY(RXIEN,FILLNUM)=""
 ;
 Q
 ;
FILTER(LIST,RXIEN,FILL) ; Filter Rx Fills based on User Entered Filter Criteria
 ; Input: FILTER - List of Filter(s) to be screened 
 ;(LIST="PR" or "DR" or "PA" or "NC" or "RX", LIST(PROV IEN) or (LIST(PAT IEN) or LIST(RXIEN,FILL)
 ; (r) RX - Rx IEN (#52) 
 ; (r) RFL - Refill #
 ; 
 ; Output: 1 - Filter (Skip) | 0 - Don't Filter (Include)
 N RXRES
 S RXRES=0
 I LIST="NC" Q RXRES
 I LIST="RX",'$D(LIST(RXIEN,FILL)) S RXRES=1 Q RXRES
 I LIST="PR" D  Q RXRES  ;provider/prescriber filter
 . I '$D(LIST($$RXPRV(RXIEN,FILL))) S RXRES=1 Q
 . I '$D(^PS(58.42,"ARX",RXIEN,FILL)) S RXRES=1 Q   ; fill not in a previously transmitted batch
 I LIST="DR" D  Q RXRES
 . I '$D(LIST($$GET1^DIQ(52,RXIEN,6,"I"))) S RXRES=1 Q
 . I '$D(^PS(58.42,"ARX",RXIEN,FILL)) S RXRES=1 Q   ; fill not in a previously transmitted batch
 I LIST="PA" D  Q RXRES
 . I '$D(LIST($$GET1^DIQ(52,RXIEN,2,"I"))) S RXRES=1 Q
 . I '$D(^PS(58.42,"ARX",RXIEN,FILL)) S RXRES=1 Q   ; fill not in a previously transmitted batch
 I LIST="DV" D  Q RXRES
 . I '$D(LIST($$RXSITE^PSOBPSUT(RXIEN,FILL))) S RXRES=1 Q
 . I '$D(^PS(58.42,"ARX",RXIEN,FILL)) S RXRES=1 Q   ; fill not in a previously transmitted batch
 I LIST="ARX",$D(^PS(58.42,"ARX",RXIEN,FILL)),$$CHKST^PSOSPML8(RXIEN,FILL,$G(LIST("STATE"))) Q 1
 Q RXRES
 ;
RXPRV(RXIEN,FILL) ; Returns the Rx Fill Provider IEN
 ; Input:  (r) RXIEN  - Rx IEN (#52) 
 ;         (o) FILL - Refill # (Default: most recent - except Partial)
 ;                    Note: "P1", "P2"... represent partial fills
 ; Output:  RXPRV - Rx Fill Provider IEN
 N RXPRV
 I '$G(RXIEN) Q ""
 I '$D(FILL) S FILL=$$LSTRFL(RXIEN)
 I FILL S RXPRV=$$GET1^DIQ(52.1,FILL_","_RXIEN,15,"I")
 I FILL["P" S RXPRV=$$GET1^DIQ(52.2,+$E(FILL,2,9)_","_RXIEN,6,"I")
 I '$G(RXPRV) S RXPRV=$$GET1^DIQ(52,RXIEN,4,"I")
 Q RXPRV
 ;
LSTRFL(RX) ;  - Returns the latest fill for the Rx
 ; Input: (r) RX     - Rx IEN (#52)
 ;Output:     LSTRFL - Most recent refill #
 N I,LSTRFL
 S (I,LSTRFL)=0 F  S I=$O(^PSRX(RX,1,I)) Q:'I  S LSTRFL=I
 Q LSTRFL
 ;
 ;
HLP ; Help Text for the VIEW PRESCRIPTION prompt
 W !," A prescription number or ECME number may be entered.  To look-up a"
 W !," prescription by the ECME number, please enter ""E."" followed by the ECME"
 W !," number with or without any leading zeros."
 D LKP("?")
 Q 
 ;
LKP(INPUT) ; - Performs Lookup on the PRESCRIPTION file
 N DIC,X,Y
 S DIC="^PSRX(",DIC(0)="QE",D="B",X=INPUT
 S DIC("S")="I $$CSRX^PSOSPML7(Y)"
 D IX^DIC
 Q Y
 ;
RXLKP(RXNUM) ; - Peforms Lookup on the PRESCRIPTION file
 N DIC,X,Y,D
 S DIC="^PSRX(",DIC(0)="QE",D="B",X=RXNUM
 D IX^DIC
 Q Y
 ;
CSRX(RXIEN) ; Controlled Substance Rx?
 ; Input: RXIEN - PRESCRIPTION file (#52) pointer
 ;Output: $$CS  - 1:YES / 0:NO
 N DRGIEN,DEA
 S DRGIEN=$P($G(^PSRX(RXIEN,0)),U,6) I 'DRGIEN Q 0
 S DEA=$P($G(^PSDRUG(DRGIEN,0)),U,3) ; retrieve DEA special handling code(s)
 I (DEA'["0"),(DEA'["M"),(DEA["2")!(DEA["3")!(DEA["4")!(DEA["5") Q 1
 Q 0
 ; 
RTSEL ;
 ; - Selection of record type
 S RECTYPE="N",QUIT=0
 D  Q:QUIT
 . K DIR S DIR("A")="Record Type"
 . S DIR("L",1)="Enter the type of record to be sent for released prescription fills:"
 . S DIR("L",2)=" "
 . S DIR(0)="S^N:NEW;R:REVISE"
 . S DIR("L",3)="  N     NEW"
 . S DIR("L")="  R     REVISE"
 . S DIR("?",1)="NEW is used for records that were rejected and NOT sent to the State database."
 . S DIR("?")="REVISE is used only for records that were rejected but were still sent to the State database."
 . S DIR("B")="NEW" D ^DIR I $D(DUOUT)!($D(DIRUT)) K DIRUT,DUOUT,DIR S QUIT=1 Q
 . S RECTYPE=Y
 Q
CSDRUG(IEN) ;Controlled Substance drug?
 ; Input: DRGIEN - DRUG file (#50) pointer 
 ;Output: $$CS - 1:YES / 0:NO
 N DEA
 Q:'IEN 0
 S DEA=$P($G(^PSDRUG(IEN,0)),U,3)
 I (DEA'["0"),(DEA'["M"),(DEA["2")!(DEA["3")!(DEA["4")!(DEA["5") Q 1
 Q 0
 ;
PATLK ;Entry point - Prompts for Patient, Prescription Number or Barcode
 ; 
 ; Input  - DIC(0) & DIC("A") [Optional] 
 ;          Used by DIR if defined by the calling routine.
 ;
 ; Output - PSOPTLK [Processed user response]
 ;
 K PSOPTLK,PAGE
 S DIR(0)="FOU"_$S($D(DIC("A")):"A",1:"")_"^^K:$$PATVAL^PSOPATLK() X"
 S DIR("A")=$S($D(DIC("A")):DIC("A"),1:"Select PATIENT NAME")
 S (DIR("?"),DIR("??"))="^D PATHLP^PSOPATLK"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIROUT) S Y="^"
 I Y=""&'$O(ARRAY(0)) W !!,"Please enter at least one PATIENT or '^' to exit.",! G PATLK
 M PSOPTLK=Y
 Q

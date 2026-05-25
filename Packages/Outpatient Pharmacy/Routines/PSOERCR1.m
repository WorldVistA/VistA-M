PSOERCR1 ;BHAM/MR - eRx Change Request Functionality - Add Drug ; 11/14/2019 3:46pm
 ;;7.0;OUTPATIENT PHARMACY;**746,769,770**;DEC 1997;Build 145
 ;
 ; Add New Medication Suggestion for Change Request
 ; Input: ERXIEN - Pointer the ERX HOLDING QUEUE file (#52.49)
 ;Output:
 ;
EN ; Add Medication Suggestion to eRx Change Request Entry point
 N DIC,DIR,DIRUT,DIROUT,DUOUT,X,Y,I,J,MPIEN,MPIENS,ERXDRUG,DRUGTYPE,DRUGCODE,DRUGCODQ,DRUG,DAYSSUP,SUBS
 N QTY,QTYQUAL,QTYUM,NUMREFS,MRC,MRCO,CODE,DWLW,DWPK,DWDISABL,DIWESUB,TXTLEN,X,QUIT,PSOQUIT,FINISH
 ;
 I '$G(CRMED) S CRMED=$O(CRMEDS(99),-1)+1
 D LOADMED
 ;
DRUG ; Use eRx OR VistA drug?
 I '$G(ERXBTCHFLG) D  I $D(DIRUT)!$D(DIROUT) W ! G @$$GOTO(X,"DRUG")
 . D DSPERX^PSOERUT(ERXIEN)
 . K DIR S DIR(0)="S^E:USE ERX DRUG;V:CHOOSE A VISTA DRUG"
 . S DIR("A")="DRUG SELECTION" I $G(DRUGTYPE)'="" S DIR("B")=DRUGTYPE
 . D ^DIR I $D(DIRUT)!$D(DIROUT) Q
 . I Y="V",$G(DRUGTYPE)="E" S (DRUG,DRUGCODE,DRUGCODQ)=""
 . S DRUGTYPE=Y
 I $G(ERXBTCHFLG) S DRUGTYPE="V"
 ;
 K DIC,DUOUT S QUIT=0
 I DRUGTYPE="E" D
 . I $P($G(CRMEDS(+CRMED)),"^")'="V" D
 . . D LOADMED
 . E  D
 . . S DRUG=$$GET1^DIQ(52.49,ERXIEN,3.1)
 . . S DRUGCODE=$$GET1^DIQ(52.49,ERXIEN,4.1) I DRUGCODE="" S DRUGCODE=$$GET1^DIQ(52.49311,"1,"_ERXIEN_",",1.1,"I")
 . . S DRUGCODQ=$$GET1^DIQ(52.49,ERXIEN,4.2) I DRUGCODQ="",DRUGCODE'="" S DRUGCODQ="ND"
 . W !!,"eRx Drug: ",DRUG,"      ",$S(DRUGCODQ="ND":"NDC",1:"UPN")_": ",DRUGCODE,!
 E  D  W ! G EXIT:$G(QUIT) I X["^" G @$$GOTO(X,"DRUG")
 . I DRUGTYPE="E" K DRUG,DRUGCODE,DRUGCODQ
 . W ! S DIC(0)="AEMQ",DIC=50 I $G(DRUG)'="" S DIC("B")=DRUG
 . S DIC("S")="I $$ACTIVE^PSOERXA0(Y),($$OUTPAT^PSOERXA0(Y))"
 . S FINISH=0
 . F  D ^DIC D  I FINISH!QUIT Q
 . . I X="^"!(X["^"&($$GOTO(X,"DRUG")'["?")) S QUIT=1 Q
 . . I Y'>0 W !!,"VistA Drug is required",!,$C(7) Q
 . . I $$GETNDC^PSSNDCUT(+Y,$G(PSOSITE))="" W !!,"VistA Drug is missing the NDC Code, please select a different drug.",!,$C(7) Q
 . . S DRUG=$$GET1^DIQ(50,+Y,.01),DRUGCODE=$$GETNDC^PSSNDCUT(+Y,$G(PSOSITE)),DRUGCODQ="ND",FINISH=1
 ;
SUBS ; SUBSTITUTIONS? Prompt
 K DIR S DIR(0)="SA^Y:YES;N:NO",DIR("A")="SUBSTITUTIONS? "
 S DIR("B")="YES" I $G(SUBS) S DIR("B")="NO"
 D ^DIR I $D(DIRUT)!$D(DIROUT) G @$$GOTO(X,"SUBS")
 S SUBS=$S(Y="Y":0,1:1) ;,$P(CRMEDS(CRMED),"^",5)=SUBS
 ;
QTY ; QUANTITY Prompt
 K DIR S DIR(0)="52.49,5.1",DIR("A")="QUANTITY" I $G(QTY) S DIR("B")=QTY
 D ^DIR I $D(DIRUT)!$D(DIROUT) G @$$GOTO(X,"QTY")
 I X="" W !!,"Quantity is required!",!,$C(7) G QTY
 S QTY=Y
 ;
QTYQUAL ; QTY QUALIFIER Prompt
 K DIR S DIR(0)="SO^"
 S CODE=0 F  S CODE=$O(^PS(52.45,"TYPE","QCQ",CODE)) Q:'CODE  D
 . S DIR(0)=DIR(0)_$$GET1^DIQ(52.45,CODE,.01)_":"_$$GET1^DIQ(52.45,CODE,.02)_";"
 S DIR("A")="QTY QUALIFIER",DIR("B")=38 I $G(QTYQUAL)'="" S DIR("B")=QTYQUAL
 D ^DIR I $D(DIRUT)!$D(DIROUT) G @$$GOTO(X,"QTYQUAL")
 S QTYQUAL=Y ;,$P(CRMEDS(CRMED),"^",7)=QTYQUAL
 ;
QTYUM ; QTY UNIT OF MEASURE Prompt
 K DIC S DIC("A")="QTY UNIT OF MEASURE: " I $G(QTYUM)'="" S DIC("B")=QTYUM
 S DIC="^PS(52.45,",DIC(0)="AEMQ",DIC("S")="I $$CODES^PSOERXON(Y)"
 D ^DIC I $D(DUOUT) G @$$GOTO(X,"QTYUM")
 I X="" W !!,"Quantity Unit of Measure is required!",!,$C(7) G QTYUM
 S MRC=Y,MRCO=$$GET1^DIQ(52.45,MRC,.01,"E")
 I $G(MRC) S QTYUM=MRC_U_MRCO
 S QTYUM=$P(Y,"^",2) ;,$P(CRMEDS(CRMED),"^",8)=QTYUM
 ;
DAYSSUP ; DAYS SUPPLY Prompt
 K DIR S DIR(0)="NO^1:365",DIR("A")="DAYS SUPPLY" I $G(DAYSSUP) S DIR("B")=DAYSSUP
 D ^DIR I $D(DIROUT) G @$$GOTO(X,"DAYSUP")
 S DAYSSUP=Y
 ;
NUMREFS ; # OF REFILLS Prompt
 K DIR S DIR(0)="NO^0:11",DIR("A")="# OF REFILLS" I $G(NUMREFS)'="" S DIR("B")=NUMREFS
 D ^DIR I $D(DIROUT) G @$$GOTO(X,"NUMREFS")
 I X="" W !!,"# of Refills is required.",! G NUMREFS
 S NUMREFS=Y
 ;
SIG ; SIG Prompt
 K DIC,DWLW,DWPK,DWDISABL,DIWESUB,SIGLEN,X,TXTLEN
 S DIC="^TMP(""PSOCRSIG"""_",$J,"
 S DWLW=70,DWPK=1,DWDISABL="P"
 S DIWESUB="SIG Text"
 W !,"SIG Text: " D EN^DIWE
 S X=0 F  S X=$O(^TMP("PSOCRSIG",$J,X)) Q:'X  D
 . S TXTLEN=$G(TXTLEN)+$L(^TMP("PSOCRSIG",$J,X,0))
 I $G(TXTLEN)>1000 D  G SIG
 . W !,"Sig must be 1000 characters or less.",!
 . D DIRE^PSOERXX1
 G NOTE
 ;
NOTE ; NOTE TO PROVIDER Prompt
 K DIR,DIRUT S DIR(0)="FO^1:210",DIR("A")="SUGGESTED PROVIDER NOTE (FOR RESPONSE RX)"
 I $G(NOTE2PRV)'="" S DIR("B")=NOTE2PRV
 S DIR("?")="This is the suggested Provider Note that will be sent back with Rx Response if this drug option is selected by the outside Provider. It may be edited/removed by the Provider before sending the response back."
 D ^DIR I $D(DIROUT) G @$$GOTO(X,"NOTE")
 S NOTE2PRV=Y
 ;
 I $G(DRUG)="" W !,"Drug is Required!" G DRUG
 I $G(SUBS)="" W !,"Substitution is Required!" G SUBS
 I '$G(QTY) W !,"Quantity is Required!" G QTY
 I $G(QTYQUAL)="" W !,"Quantity Qualifier is Required!" G QTYQUAL
 I $G(QTYUM)="" W !,"Quantity Unit of Measure is Required!" G QTYUM
 I $G(NUMREFS)="" W !,"Days Supply is Required!" G NUMREFS
 ;
 W !?65,"Updating..."
 K CRMEDS(CRMED)
 S CRMEDS(CRMED)=DRUGTYPE_"^"_DRUG_"^"_DRUGCODE_"^"_DRUGCODQ_"^"_SUBS_"^"_QTY_"^"_QTYQUAL_"^"_QTYUM_"^"_DAYSSUP_"^"_NUMREFS
 S CRMEDS(CRMED,"NOTE")=NOTE2PRV
 M CRMEDS(CRMED,"SIG")=^TMP("PSOCRSIG",$J)
 W "OK"
 ;
EXIT ; Quit
 Q
 ;
LOADMED ; Load Default Values for an existing Medication Suggestion
 N Z,MPIEN,MPIENS,ERXSIG
 K ^TMP("PSOCRSIG",$J) S (DRUG,DRUGCODE,DRUGCODQ,SUBS,QTY,QTYQUAL,QTYUM,DAYSSUP,NOTE2PRV)=""
 I $G(DRUGTYPE)="E" D
 . S DRUG=$$GET1^DIQ(52.49,ERXIEN,3.1) I DRUG="" S DRUG=$$GETDRUG^PSOERXU5(ERXIEN)
 . S DRUGCODE=$$GET1^DIQ(52.49,ERXIEN,4.1) I DRUGCODE="" S DRUGCODE=$$GET1^DIQ(52.49311,"1,"_ERXIEN_",",1.1,"I")
 . S DRUGCODQ=$$GET1^DIQ(52.49,ERXIEN,4.2) I DRUGCODQ="",DRUGCODE'="" S DRUGCODQ="ND"
 . S MPIEN=$O(^PS(52.49,ERXIEN,311,"C","P",0))
 . I MPIEN D
 . . S MPIENS=MPIEN_","_ERXIEN_","
 . . S DRUG=$$GET1^DIQ(52.49311,MPIENS,.03)
 . . S DRUGCODE=$$GET1^DIQ(52.49311,MPIENS,1.1)
 . . S DRUGCODQ=$$GET1^DIQ(52.49311,MPIENS,1.2)
 . . S X=$$GET1^DIQ(52.49311,MPIENS,8,,"ERXSIG")
 . . F I=1:1 Q:'$D(ERXSIG(I))  S ^TMP("PSOCRSIG",$J,I,0)=ERXSIG(I)
 . S QTY=$$GET1^DIQ(52.49,ERXIEN,5.1)
 . S QTYQUAL=$$GET1^DIQ(52.49,ERXIEN,5.2,"I")
 . S QTYUM=$$GET1^DIQ(52.49,ERXIEN,5.4)
 . S DAYSSUP=$$GET1^DIQ(52.49,ERXIEN,5.5)
 . S NUMREFS=$$GET1^DIQ(52.49,ERXIEN,5.6)
 . ;S NOTE2PRV=$$GET1^DIQ(52.49,ERXIEN,8)
 I '$G(CRMED)!'$D(CRMEDS(+$G(CRMED))) Q
 ; - Loading an existing entry
 S Z=CRMEDS(CRMED),DRUGTYPE=$P(Z,"^")
 I $G(DRUGTYPE)'="E" D
 . S DRUG=$P(Z,"^",2)
 . S DRUGCODE=$P(Z,"^",3)
 . S DRUGCODQ=$P(Z,"^",4)
 S SUBS=$P(Z,"^",5)
 S QTY=$P(Z,"^",6)
 S QTYQUAL=$P(Z,"^",7)
 S QTYUM=$P(Z,"^",8)
 S DAYSSUP=$P(Z,"^",9)
 S NUMREFS=$P(Z,"^",10)
 S NOTE2PRV=$G(CRMEDS(CRMED,"NOTE"))
 M ^TMP("PSOCRSIG",$J)=CRMEDS(CRMED,"SIG")
 Q
 ;
GOTO(INPUT,HOME) ; - Directed up-arrow
 N GOTO,TAG,TRGT
 I $P(INPUT,"^",2)="" S PSOQUIT=1 Q "EXIT"
 ;
 S TRGT=$P(INPUT,"^",2)
 S TAG("DRUG SELECTION")="EORV"
 S TAG("DRUG")="DRUG"
 S TAG("SUBSTITUTION")="SUBS"
 S TAG("QUANTITY")="QTY"
 S TAG("QTY QUALIFIER")="QTYQUAL"
 S TAG("QTY UNIT OF MEASURE")="QTYUM"
 S TAG("DAYS SUPPLY")="DAYSSUP"
 S TAG("# OF REFILLS")="NUMREFS"
 S TAG("SIG")="SIG"
 S TAG("NOTE")="NOTE"
 ;
 S GOTO=HOME
 S TAG="" F  S TAG=$O(TAG(TAG)) Q:TAG=""  I $E(TAG,1,$L(TRGT))=TRGT S GOTO=TAG(TAG) Q
 I GOTO=HOME W "   ??",$C(7)
 ;
 Q GOTO
 ;
DEFREA(REACODE) ; Returns the Default Change Request Reason Text
 ; Input: REACODE - Pointer to the ERX SERVICE REASON CODES (#52.45)
 ;Output: DEFREA  - Default Change Request Reason Text for the Code passed in
 N DEFREA,I,X,REATXT
 S DEFREA="",X=$$GET1^DIQ(52.45,REACODE,20,,"REATXT")
 F I=1:1 Q:'$D(REATXT(I))  S DEFREA=DEFREA_" "_$G(REATXT(I))
 S $E(DEFREA)=""
 Q DEFREA
 ;
HELP ; Sub-Code List
 N I,XX W !,"     Complete List of Change Request Sub-Codes:",!
 F I=1:1 Q:'$D(DIR("?",I))  W !,DIR("?",I) I '(I#20) R !,"Type <Enter> to continue or '^' to exit:",XX:DTIME I XX="^" Q
 D:(I#20) PAUSE^PSOSPMU1
 Q
 ;
SUMMARY ; Displays a Summary of the RxChangeRequest
 N HIGH,NORM,XX,ERXSIG,NOTES,MEDIEN,QTYQUAL,X
 W @IOF S LINE=0
 S HIGH=$G(IOINHI),NORM=$G(IOINORM)
 W ! D PAUSE S $P(XX,$S($D(IOUON):" ",1:"-"),81)="",$E(XX,27,51)="RX CHANGE REQUEST SUMMARY" W !,$G(IOUON),XX,$G(IOUOFF)
 W ! D PAUSE W "Change Request Reason Code: ",HIGH,$$GET1^DIQ(52.45,+$G(REACODE),.01)," - ",$$GET1^DIQ(52.45,+$G(REACODE),.02),NORM
 I $G(REASCODE) D
 . W ! D PAUSE W "Change Request Reason Sub-Code: ",HIGH,$$GET1^DIQ(52.45,+$G(REASCODE),.01)," - ",$$GET1^DIQ(52.45,+$G(REASCODE),.02),NORM
 ;
 W ! D PAUSE W "Note to Provider: " F I=1:1 Q:'$D(REATXT(I))  W !,HIGH,REATXT(I),NORM
 W ! D LISTMEDS
 ; When sending a Batch, option #2, Meds are different but Sug. Provider Notes is the same
 I $G(ERXBTCHFLG),$G(CHRQTYPE)=2 D
 . W ! D PAUSE W "Suggested Medication: ",HIGH,"[VARIES FOR EACH eRx]",NORM,!
 . W ! D PAUSE W "Suggested Provider Note (For RESPONSE eRx) - SAME FOR ALL eRx's:"
 . S X=NOTE2PRV F  Q:X=""  W !,HIGH,$E(X,1,80),NORM S X=$E(X,81,999)
 . W !
 ;
 I ($G(PNCOMM)'="")!($G(RESEND))!($G(SELCTREC)="R") W ! D PAUSE W "VA Progress Note Comment: ",!,HIGH,PNCOMM,NORM,!
 ;
 S XX="",$P(XX,$S($D(IOUON):" ",1:"-"),81)="" W $G(IOUON),XX,$G(IOUOFF)
 Q
 ;
LISTMEDS ; Display Meds Already entered
 N XX,Z,MED,Y,SIG,NOTE,UON,UOFF
 ;
 I '$O(CRMEDS(0)) Q
 S UON=$G(IOUON),UOFF=$G(IOUOFF)
 S LINE=1 D PAUSE W ! W UON,"#  DRUG",?50,"QTY",?55,"# REFS",?63,"DAYS SUPPLY",?76,"SUBS",UOFF
 I UON="" S $P(XX,"-",81)="" D PAUSE W !,XX,! S LINE=2
 S MED=0 F  S MED=$O(CRMEDS(MED)) Q:'MED  D
 . S Z=$G(CRMEDS(MED))
 . I MED=1 W !
 . D PAUSE W MED,?3,"(",$P(Z,"^"),")",$E($P(Z,"^",2),1,43),?50,$J($P(Z,"^",6),3),?57,$J($P(Z,"^",10),2)
 . W ?65,$J($P(Z,"^",9),4),?76,$S($P(Z,"^",5):"NO",1:"YES"),!
 . I $O(CRMEDS(MED,"SIG",0)) D
 . . D PAUSE W ?3 W UON,"Sig :",UOFF
 . . S SIG="" F I=1:1 Q:'$D(CRMEDS(MED,"SIG",I))  S SIG=SIG_CRMEDS(MED,"SIG",I,0)_" "
 . . F I=1:1 Q:(SIG="")  W ?9,$E(SIG,1,70),! S SIG=$E(SIG,71,999) D PAUSE
 . I $G(CRMEDS(MED,"NOTE"))'="" D
 . . D PAUSE W ?3 W UON,"Note:",UOFF S NOTE=CRMEDS(MED,"NOTE")
 . . F I=1:1 Q:NOTE=""  W ?9,$E(NOTE,1,71),! S NOTE=$E(NOTE,72,999) D PAUSE
 Q
 ;
PAUSE ; Decides whether to pause the listing or not
 N XX,I,Y,X
 S LINE=LINE+1
 S Y=$S($G(IOSL):IOSL,1:24)-3 I (LINE#Y) Q
 W "Press Return to continue" R X:60
 F I=1:1:26 W $C(8)
 S $P(XX," ",26)="" W XX
 F I=1:1:26 W $C(8)
 Q

PSOERBT ;ALB/RM - Handles Multiple eRx CH REQ Submission & Drug Conversion (MbM) ;Jan 16, 2025@12:43:34
 ;;7.0;OUTPATIENT PHARMACY;**770**;DEC 16, 1997;Build 145
 ;
EN ; main entry point of the menu option
 N DIR,X,Y,CONVTYPE,BEGFLDT,ENDFLDT,ALLOWSUB,MBMSITE,PSOQUIT,ERXNERX,CHRQTYPE,NOTE2PRV,FROMDRUG,NEWDRUG,VRXSIG,PSOALLST
 S MBMSITE=$S($$GET1^DIQ(59.7,1,102,"I")="MBM":1,1:0)
 ;
 ;Division Selection
 I '$G(PSOSITE) D ^PSOLSET I '$D(PSOPAR) W $C(7),!!,"Pharmacy Division Must be Selected!",! G EXIT
 S PSNPINST=$$GET1^DIQ(59,PSOSITE,101,"I")
 ;
 K DIR S DIR("A")="CHOOSE BATCH CONVERSION TYPE"
 S DIR(0)="S^CR:MULTIPLE ERX CHANGE REQUEST SUBMISSION;DR:VISTA DISPENSE DRUG REPLACEMENT (MbM ONLY)"
 S DIR("?",1)="CR - Use this option to send the same eRx Change Request to the external"
 S DIR("?",2)="     prescribers for multiple VistA Rx's issued within a date range."
 S DIR("?",3)=" "
 S DIR("?",4)="DR - *** Available to Meds-by-Mail only ***"
 S DIR("?",5)="     Use this option to replace the VistA dispense drug for multiple VistA"
 S DIR("?",6)="     Rx's issued within a date range."
 S DIR("?")=" "
 D ^DIR I $D(DIRUT)!$D(DIROUT) G EXIT
 I Y="DR",'MBMSITE W !!,"This option is available for MbM sites only",$C(7) D PAUSE^PSOSPMU1 G EXIT
 S CONVTYPE=Y
 ;
 I CONVTYPE="DR",'$D(^XUSEC("PSNMGR",DUZ)) D  G EXIT
 . W !,"You need to hold the PSNMGR key to access this option." S DIR(0)="E" D ^DIR K DIR
 ;
 ; Ask for TYPE OF CHANGE REQUEST for Change Request submission
 S PSOQUIT=0
 I CONVTYPE="CR" D  I PSOQUIT G EXIT
 . N X,Y,DIC,DONE,FROMOI,TOOI,FROMSTRN,TOSTREN,ERXIEN
 . S (CHRQTYPE,NOTE2PRV,FROMDRUG,NEWDRUG,RXHASH)=""
 . K DIR S DIR("A")="TYPE OF CHANGE REQUEST"
 . S DIR(0)="S^1:CHANGE REQUEST FOR SAME DRUG/SIG RX'S;2:DRUG REPLACEMENT FOR SIMILAR VISTA DRUG;3:CHANGE REQUEST W/OUT DRUG SUGGESTION(S)"
 . S DIR("?",1)="1 - The software will search for VistA Rx's with the same dispense drug"
 . S DIR("?",2)="    and SIG, then it will allow you to send the same eRx Change Request"
 . S DIR("?",3)="    for these Rx's. "
 . S DIR("?",4)=" "
 . S DIR("?",5)="2 - The software will search for VistA Rx's with the same dispense drug"
 . S DIR("?",6)="    and will allow you to indicate a new dispense drug that will be used"
 . S DIR("?",7)="    as a suggestion for an eRx Change Request that can be sent for these"
 . S DIR("?",8)="    Rx's."
 . S DIR("?",9)=" "
 . S DIR("?",10)="3 - The software will search for VistA Rx's with the same dispense drug,"
 . S DIR("?",11)="    then it will allow you to send the same eRx Change Request without a"
 . S DIR("?",12)="    a drug suggestion for these Rx's."
 . S DIR("?")=" "
 . D ^DIR I $D(DIRUT)!$D(DIROUT) S PSOQUIT=1 Q
 . S CHRQTYPE=+Y
 ;
 ; Change Request for Same Drug/SIG Rx's (option 1) - Addt'l prompt
 I CONVTYPE="CR",+$G(CHRQTYPE)=1 D  I PSOQUIT G EXIT
 . W ! K DIC S DIC="52",DIC(0)="AEMQZV",DIC("A")="VISTA RX #: "
 . S (DONE,PSOQUIT)=0
 . F  D  Q:(DONE!PSOQUIT)
 . . ;keep prompting until user enter a valid entry
 . . D ^DIC I $D(DTOUT)!$D(DUOUT) S PSOQUIT=1 Q
 . . I (+Y<1)!(X="") W !!,"Required!",!,$C(7) Q
 . . S VRXIEN=+Y,ERXIEN=$$ERXIEN^PSOERXUT(VRXIEN)
 . . I ERXIEN="" W !,"  Not an eRx Prescription.",! Q
 . . S FROMDRUG=$$GET1^DIQ(52,VRXIEN,6,"I"),VRXSIG=$$RXSIG^PSOERBT1(VRXIEN)
 . . I 'FROMDRUG W !,"There's a problem with the Drug in this Rx.",! Q
 . . I VRXSIG="" W !,"There's a problem with the SIG in this Rx.",! Q
 . . S DONE=1
 . I PSOQUIT Q
 ;
 ; Drug Replacement for Similar VistA Drug (option 2) - Addt'l prompts
 I CONVTYPE="DR"!((CONVTYPE="CR")&($G(CHRQTYPE)=2)) D  I PSOQUIT G EXIT
 . W ! K DIC,X,Y S DIC="50",DIC(0)="AEMQZI",DIC("A")="FROM VISTA DRUG: ",D="B^AQ1"
 . S DIC("S")="I ($$OUTPAT^PSOERXA0(+Y))"
 . S (DONE,PSOQUIT)=0
 . F  D  Q:(DONE!PSOQUIT)
 . . ;keep prompting until user enter a valid entry 
 . . D MIX^DIC1 I $D(DTOUT)!$D(DUOUT) S PSOQUIT=1 Q
 . . I (+Y<1)!(X="") W !!,"Required!",!,$C(7) Q
 . . I CONVTYPE="CR",$$GETNDC^PSSNDCUT(+Y,$G(PSOSITE))="" W !!,"Drug does not have an NDC code!",!,$C(7) Q 
 . . S FROMDRUG=+Y,DONE=1
 . I PSOQUIT Q
 . ;
 . W ! K DIC,X,Y S DIC="50",DIC(0)="AEMQZI",DIC("A")="NEW VISTA DRUG: "
 . S DIC("S")="I $$ACTIVE^PSOERXA0(+Y),($$OUTPAT^PSOERXA0(+Y)),+Y'=FROMDRUG",D="B^AQ1"
 . S (DONE,PSOQUIT)=0
 . F  D  Q:(DONE!PSOQUIT)
 . . ;keep prompting until user enter a valid entry 
 . . D MIX^DIC1 I $D(DTOUT)!$D(DUOUT) S PSOQUIT=1 Q
 . . I (+Y<1)!(X="") W !!,"Required!",!,$C(7) Q
 . . I $$GETNDC^PSSNDCUT(+Y,$G(PSOSITE))="" W !!,"Drug does not have an NDC code!",!,$C(7) Q 
 . . I +Y=FROMDRUG W !!,"Cannot be the same drug!",!,$C(7) Q
 . . S NEWDRUG=+Y,DONE=1
 . I PSOQUIT Q
 . ;
 . ; Warnings about the 2 dispense drugs selected
 . I $$GET1^DIQ(50,FROMDRUG,2)'=$$GET1^DIQ(50,NEWDRUG,2) D
 . . W !!,"WARNING: Drugs selected belong to different VA Classes:",$C(7)
 . . W !,"         - ",$$GET1^DIQ(50,FROMDRUG,2)
 . . W !,"         - ",$$GET1^DIQ(50,NEWDRUG,2)
 . . D PAUSE^PSOERXUT
 . ; Warnings about the 2 dispense drugs selected
 . S FROMOI=$$GET1^DIQ(50,FROMDRUG,2.1,"I"),TOOI=$$GET1^DIQ(50,NEWDRUG,2.1,"I")
 . I FROMOI'=TOOI D
 . . W !!,"WARNING: Drugs selected belong to different Orderable Items:",$C(7)
 . . W !,"         - ",$$GET1^DIQ(50,FROMDRUG,2.1)
 . . W !,"         - ",$$GET1^DIQ(50,NEWDRUG,2.1)
 . . D PAUSE^PSOERXUT
 . S FROMSTRN=$$GET1^DIQ(50,FROMDRUG,901)_$$GET1^DIQ(50,FROMDRUG,902)_" "_$$GET1^DIQ(50.7,FROMOI,.02)
 . S TOSTREN=$$GET1^DIQ(50,NEWDRUG,901)_$$GET1^DIQ(50,NEWDRUG,902)_" "_$$GET1^DIQ(50.7,TOOI,.02)
 . I FROMSTRN'=TOSTREN D
 . . W !!,"WARNING: Drugs selected have different strengths/form:",$C(7)
 . . W !,"         - ",FROMSTRN
 . . W !,"         - ",TOSTREN
 . . D PAUSE^PSOSPMU1
 ;
 ; Change Request w/out Drug Suggestion(s) (option 3) - Addt'l prompt
 I CONVTYPE="CR",+$G(CHRQTYPE)=3 D  I PSOQUIT G EXIT
 . W ! K DIC S DIC="50",DIC(0)="AEMQZI",DIC("A")="VISTA DRUG: "
 . S DIC("S")="I $$OUTPAT^PSOERXA0(+Y)",D="B^AQ1"
 . S (DONE,PSOQUIT)=0
 . F  D  Q:DONE
 . . ;keep prompting until user enter a valid entry 
 . . D MIX^DIC1 I $D(DTOUT)!$D(DUOUT) S (DONE,PSOQUIT)=1 Q
 . . I (+Y<1)!(X="") W !!,"Required!",!,$C(7) Q
 . . I $$GETNDC^PSSNDCUT(+Y,$G(PSOSITE))="" W !!,"Drug does not have an NDC code!",!,$C(7) Q 
 . . S FROMDRUG=+Y,DONE=1
 ; 
 ; - Ask for FROM FILL DATE
 S %DT(0)=$$FMADD^XLFDT(DT,-366),%DT="AEP",%DT("A")="BEGIN ISSUE DATE: ",%DT("B")=$$FMTE^XLFDT($$FMADD^XLFDT(DT,-366),"2Y")
 W ! D ^%DT I Y<0!($D(DTOUT)) G EXIT
 S BEGFLDT=Y\1-.00001
 ;
 ; - Ask for END FILL DATE
 S %DT(0)=BEGFLDT+1\1,%DT("A")="END ISSUE DATE: ",%DT("B")=$$FMTE^XLFDT(DT,"2Y")
 W ! D ^%DT I Y<0!($D(DTOUT)) G EXIT
 S ENDFLDT=Y\1+.99999
 ;
 ; Ask for the type of prescription (eRx or Non-eRx)
 S ERXNERX="",PSOQUIT=0
 I CONVTYPE="DR" D  I PSOQUIT G EXIT
 . K DIR S DIR("A")="PRESCRIPTION TYPE (ERX/NON-ERX/BOTH)",DIR("B")="B"
 . S DIR(0)="SO^E:ERX PRESCRIPTIONS ONLY;N:NON-ERX PRESCRIPTIONS ONLY;B:BOTH"
 . S DIR("?")=" ",DIR("?",1)="  E - eRx Prescriptions only"
 . S DIR("?",2)="  N - Non-eRx (Backdoor and CPRS) Prescriptions only"
 . S DIR("?",2)="  B - Both, eRx and non-eRx prescriptions"
 . D ^DIR I $D(DIRUT)!$D(DIROUT) S PSOQUIT=1
 . S ERXNERX=Y
 ;
 ; Ask if the Rx should be included based on the Substitution being allowed or not
 S ALLOWSUB="",PSOQUIT=0
 I CONVTYPE="CR"!(ERXNERX="E")!(ERXNERX="B") D  I PSOQUIT G EXIT
 . K DIR S DIR("A")="SUBSTITUTION (eRx ONLY)",DIR("B")="B"
 . S DIR(0)="SO^A:SUBSTITUTION ALLOWED;N:SUBSTITUTION NOT ALLOWED;B:BOTH"
 . S DIR("?",1)="Only applies to eRx prescriptions"
 . S DIR("?",2)=""
 . S DIR("?",3)=" A - eRx's w/ Substitution allowed only (NO PRODUCT SELECTION INDICATED)"
 . S DIR("?",4)=" N - eRx's w/ Substitution NOT allowed only (SUBS. NOT ALLOWED BY PRESCRIBER)"
 . S DIR("?")=" B - Both, include all"
 . D ^DIR I $D(DIRUT)!$D(DIROUT) S PSOQUIT=1
 . S ALLOWSUB=Y
 ;
 D EN^VALM("PSO ERX BATCH ERX CHANGE")
 ;
 G EXIT
 Q
 ;
LMHDR ; Menu Protocol Header Code
 D SHOW^VALM,HDR
 S XQORM("#")=$O(^ORD(101,"B","PSO ERX BATCH CHANGE REQUEST SELECT",""))_"^1:"_VALMCNT
 S XQORM("??")="D HELP^VALM2,HDR^PSOERBT"
 Q
 ;
HDR ; Listman Header Code
 N HDR,I,DRUG,SIG,DOSE,HIGH,NORM,ERXIEN
 ;
 S VALM("TITLE")=$S(CONVTYPE="CR":"Batch eRx CH REQ Submission",1:"Dispense Drug Replacement")
 S HIGH=$G(IOINHI),NORM=$G(IOINORM)
 S HDR="DATE RANGE: "_HIGH_$$FMTE^XLFDT($G(BEGFLDT)+.01\1,"2Z")_NORM
 S HDR=HDR_" - "_HIGH_$$FMTE^XLFDT($G(ENDFLDT)\1,"2Z")_NORM
 S HDR=HDR_"      SUBS: "_HIGH_$S(ALLOWSUB="A":"ALLOWED ONLY",ALLOWSUB="N":"NOT ALLOWED ONLY",ALLOWSUB="B":"ALLOWED & NOT ALLOWED",1:"N/A")_NORM
 S HDR=HDR_$J("RX COUNT: "_HIGH_$S('$O(^TMP("PSOERBT",$J,0)):0,1:VALMCNT)_NORM,$S(ALLOWSUB="A":34,ALLOWSUB="N":30,ALLOWSUB="B":25,1:43))
 D INSTR^VALM1(HDR,1,2)
 ;
 I CONVTYPE="CR" D  ; eRx CH REQUEST header
 . I CHRQTYPE=1 D
 . . S DRUG=$$GET1^DIQ(52,FROMDRUG,6,"I")
 . . S HDR="VISTA DRUG: "_HIGH_$E($$GET1^DIQ(50,FROMDRUG,.01),1,40)_" (CMOP ID: "_$$GET1^DIQ(50,FROMDRUG,27)_")"_NORM D INSTR^VALM1(HDR,1,3)
 . . S SIG=VRXSIG S HDR="SIG: "_HIGH_$E(SIG,1,75)_NORM D INSTR^VALM1(HDR,1,4)
 . . S HDR=$E(SIG,76,999)
 . . I HDR'="" S HDR=HIGH_$S($L(HDR)<55:HDR,1:$E(HDR,1,51)_"...")_NORM D INSTR^VALM1(HDR,1,5)
 . I CHRQTYPE=2 D
 . . S HDR="FROM VISTA DRUG: "_HIGH_$E($$GET1^DIQ(50,FROMDRUG,.01),1,40)_" (CMOP ID: "_$$GET1^DIQ(50,FROMDRUG,27)_")"_NORM D INSTR^VALM1(HDR,1,3)
 . . S HDR=" NEW VISTA DRUG: "_HIGH_$E($$GET1^DIQ(50,NEWDRUG,.01),1,40)_" (CMOP ID: "_$$GET1^DIQ(50,NEWDRUG,27)_")"_NORM D INSTR^VALM1(HDR,1,4)
 . I CHRQTYPE=3 D
 . . S HDR="VISTA DRUG: "_HIGH_$E($$GET1^DIQ(50,FROMDRUG,.01),1,40)_" (CMOP ID: "_$$GET1^DIQ(50,FROMDRUG,27)_")"_NORM D INSTR^VALM1(HDR,1,3)
 E  D  ; VistA Drug Replacement header
 . S HDR="FROM VISTA DRUG: "_HIGH_$$GET1^DIQ(50,FROMDRUG,.01)_" (CMOP ID: "_$$GET1^DIQ(50,FROMDRUG,27)_")"_NORM D INSTR^VALM1(HDR,1,3)
 . S HDR=" NEW VISTA DRUG: "_HIGH_$$GET1^DIQ(50,NEWDRUG,.01)_" (CMOP ID: "_$$GET1^DIQ(50,NEWDRUG,27)_")"_NORM D INSTR^VALM1(HDR,1,4)
 . S HDR="ERX/NON-ERX    : "_HIGH_$S(ERXNERX="E":"ERX ONLY",ERXNERX="N":"NON-ERX ONLY",1:"BOTH")_NORM D INSTR^VALM1(HDR,1,5)
 ;
 S HDR="DAY",$E(HDR,5)="REF",$E(HDR,9)="LAST",$E(HDR,18)="LAST CH "
 D INSTR^VALM1($G(IORVON)_HDR_NORM,56,5)
 S HDR="#",$E(HDR,6)="VISTA RX #",$E(HDR,21)="PATIENT",$E(HDR,48)="STA",$E(HDR,52)="QTY",$E(HDR,56)="SUP",$E(HDR,60)="REM"
 S $E(HDR,64)="FILL",$E(HDR,73)="REQUEST",$E(HDR,81)=""
 D INSTR^VALM1($G(IORVON)_HDR_NORM,1,6)
 S XQORM("??")="D HELP^VALM2,HDR^PSOERBT"
 Q
 ;
INIT ; -- init variables and list array
 N I,HIGHLN,HIGUNDLN,REVLN,BLINKLN,PSOERBT,BFLDT,RXIEN,ISSUEDT,RXIEN
 S VALMBG=1,LINE=0 K ^TMP("PSOERBTS",$J),^TMP("PSOERBT",$J)
 D RESET^PSOERUT0()  ; - Resetting list to NORMAL video attributes
 ;
 W !!,"Please wait..."
 S BFLDT=BEGFLDT,LINE=0
 F  S BFLDT=$O(^PSRX("ADL",BFLDT)) Q:BFLDT=""  D
 . S RXIEN="" F  S RXIEN=$O(^PSRX("ADL",BFLDT,FROMDRUG,RXIEN)) Q:RXIEN=""  D
 . . S ISSUEDT=$$GET1^DIQ(52,RXIEN,1,"I") I $D(^TMP("PSOERBTS",$J,ISSUEDT,RXIEN)) Q
 . . I ISSUEDT>ENDFLDT Q  ;issue date vs end date check
 . . I FROMDRUG'=$$GET1^DIQ(52,RXIEN,6,"I") Q
 . . S ERXIEN=$$ERXIEN^PSOERXUT(RXIEN)
 . . I ERXIEN,ALLOWSUB'="B",$$GET1^DIQ(52.49,ERXIEN,5.8,"I")'=$S(ALLOWSUB="A":0,1:1) Q  ;substitution check
 . . I CONVTYPE="CR",'ERXIEN Q  ;Not an eRx prescription
 . . I '$G(PSOALLST),",0,3,5,"'[(","_$$GET1^DIQ(52,RXIEN,100,"I")_",") Q  ;rx status check (ACTIVE,HOLD,SUSPENDED)
 . . I CONVTYPE="CR",CHRQTYPE=1,VRXSIG'=$$RXSIG^PSOERBT1(RXIEN) Q
 . . I CONVTYPE="DR",ERXNERX="N",ERXIEN Q
 . . I CONVTYPE="DR",ERXNERX="E",'ERXIEN Q
 . . S ^TMP("PSOERBTS",$J,ISSUEDT,RXIEN)=ERXIEN
 ;
 S (ISSUEDT,RXIEN)=""
 F  S ISSUEDT=$O(^TMP("PSOERBTS",$J,ISSUEDT)) Q:'ISSUEDT  D
 . F  S RXIEN=$O(^TMP("PSOERBTS",$J,ISSUEDT,RXIEN)) Q:'RXIEN  D
 . . D ADRX2LST(RXIEN,+$G(^TMP("PSOERBTS",$J,ISSUEDT,RXIEN)))
 K ^TMP("PSOERBTS",$J)
 ;
 I '$O(^TMP("PSOERBT",$J,0)) D  Q
 . F I=1:1:6 S ^TMP("PSOERBT",$J,I,0)=""
 . S ^TMP("PSOERBT",$J,7,0)="     There were no records found that met the above criteria.",HIGHLN(7,4)=80
 . D VIDEO^PSOERUT0() ; Changes the Video Attributes for the list
 . S VALMCNT=1
 ;
 ; - Saving NORMAL video attributes to be reset later
 I LINE>$G(LASTLINE) D
 . F I=($G(LASTLINE)+1):1:LINE D SAVE^VALM10(I)
 . S LASTLINE=LINE
 D VIDEO^PSOERUT0() ; Changes the Video Attributes for the list
 S VALMCNT=$O(^TMP("PSOERBT",$J,""),-1)
 Q
 ;
ADRX2LST(RXIEN,ERXIEN) ;Add the prescription to the list for display
 ;Input:  ERXIEN  - Pointer to the PRESCRIPTION file (#52)
 ;     (o)RXIEN   - Pointer to the ERX HOLDING QUEUE file (#52.49)
 N STA,STAT,PSOCMOP,LASTCHREQ,VISTARX,LASTFLDT,PTNAME,NUMREFS,PROVIDER,QUANTITY,DAYSUP
 S STA="A^N^R^H^N^S^^^^^^E^DC^^DP^DE^HP^P^"
 S PSOCMOP=""
 S LASTCHREQ=$$LSTCHREQ^PSOERBT2(ERXIEN)
 S VISTARX=$$GET1^DIQ(52,RXIEN,.01,"E")
 S PSOCMOP=$$ISCMOPD^PSOERBT2(RXIEN) ;determine if rx is cmop dispense/transmitted, etc.
 S STAT=$P(STA,"^",$$GET1^DIQ(52,RXIEN,100,"I")+1) D
 . I $G(^PSRX(RXIEN,"DDSTA"))]"" S STAT="DD" Q
 . I $G(^PSRX(RXIEN,"PARK")),STA="A" S STAT="AP"
 S STAT=$S($P($G(^PSRX(RXIEN,7)),"^")=1:"DA",$P($G(^PSRX(RXIEN,7)),"^")=2:"DF",1:STAT)
 S STAT=STAT_PSOCMOP,DAYSUP=$$GET1^DIQ(52,RXIEN,8)
 S LASTFLDT=$$RXFLDT^PSOBPSUT(RXIEN),PTNAME=$$GET1^DIQ(52,RXIEN,2,"E"),PROVIDER=$$GET1^DIQ(52,RXIEN,4,"E")
 S QUANTITY=+$$GET1^DIQ(52,RXIEN,7,"I"),NUMREFS=+$$GET1^DIQ(52,RXIEN,9,"I")-$$LSTRFL^PSOBPSU1(RXIEN)
 S LINE=LINE+1,LINETXT=LINE_"."
 S $E(LINETXT,6)=$S(ERXIEN:"& ",1:"")_VISTARX,$E(LINETXT,21)=$E(PTNAME,1,26),$E(LINETXT,48)=STAT,$E(LINETXT,52)=$J(QUANTITY,3)
 S $E(LINETXT,56)=$J(DAYSUP,3),$E(LINETXT,60)=$J(NUMREFS,3),$E(LINETXT,64)=$TR($$FMTE^XLFDT(LASTFLDT,"2Z"),"/","-")
 S $E(LINETXT,73)=$TR($$FMTE^XLFDT($$LSTCHREQ^PSOERBT2(ERXIEN),"2Z"),"/","-")
 S ^TMP("PSOERBT",$J,LINE,0)=LINETXT
 S ^TMP("PSOERBT",$J,LINE,"RXIEN")=RXIEN
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 S VALMBCK="R"
 Q
 ;
EXIT ; -- exit code
 K ^TMP("PSOERBT",$J),^TMP("PSOERSEL",$J)
 D CLEAR^VALM1
 D FULL^VALM1
 Q
 ;
SEL ;Process selection of one entry
 N PSOSEL,XX,PSOVDA,PSOSAVE,DA,PS,RXIEN
 S PSOSEL=+$P(XQORNOD(0),"=",2) I 'PSOSEL S VALMSG="Invalid selection!",VALMBCK="R" Q
 S RXIEN=$G(^TMP("PSOERBT",$J,PSOSEL,"RXIEN")) I 'RXIEN S VALMSG="Invalid selection!",VALMBCK="R" Q
 S (PSOVDA,DA)=RXIEN,PS="REJECTMP" I $G(XQY0)="" S XQY0="PSO VIEW"
 N LINE,TITLE,PSODFN D DP^PSORXVW
 S VALMBCK="R"
 Q
 ;
EXPND ; -- expand code
 Q
 ;
REF ;Screen Refresh
 I $D(VALMEVL) F I=1:1:99 D RESTORE^VALM10(I)
 D INIT,HDR S VALMBCK="R"
 Q
 ;
ENTRYSEL ; Allows selection of Rx's in the List
 N DIR,X,DIRUT,DIROUT,RANGE,I,REC,COMSEG
 I '$D(^TMP("PSOERBT",$J,1,"RXIEN")) S VALMSG="There are no entries to be selected!" W $C(7) Q
 S DIR("A")="SELECT RX's (1-"_+$O(^TMP("PSOERBT",$J,""),-1)_"): "
 S DIR(0)="LA^1:"_+$O(^TMP("PSOERBT",$J,""),-1) W ! D ^DIR I $D(DIRUT)!$D(DIROUT) Q
 S RANGE=X
 K ^TMP("PSOERSEL",$J)
 F I=1:1:$L(RANGE,",") D
 . S COMSEG=$P(RANGE,",",I)
 . F REC=+COMSEG:1:$S(COMSEG["-":$P(COMSEG,"-",2),1:+COMSEG) D
 . . I '$G(^TMP("PSOERBT",$J,REC,"RXIEN")) Q
 . . S ^TMP("PSOERSEL",$J,^TMP("PSOERBT",$J,REC,"RXIEN"))=REC
 Q
 ;
IAS ;Include All Status Switch
 W ?52,"Please wait..." S PSOALLST=$S($G(PSOALLST):0,1:1),LINE=0 D REF
 I 'PSOALLST S VALMBG=1
 Q

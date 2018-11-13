PSOERXX1 ;ALB/BWF - eRx xml utilities ; 8/3/2016 5:14pm
 ;;7.0;OUTPATIENT PHARMACY;**467,520**;DEC 1997;Build 52
 ;
 Q
 ; PSOIEN - ien from 52.49 (erx holding queue)
 ; PSOSITE - site ien from the outpatient site file (59)
 ; REFILL REQUEST VIA THE ERX HOLDING QUEUE
RREQHQ(PSOIEN,PSOSITE) ;
 N ORNUM,RXIEN,PSSOUT,GBL,REFL,I,EXDT,PEND,PSSRET,CNT,DIR,Y
 S VALMBCK="R"
 Q:'PSOIEN
 D FULL^VALM1
 S ORNUM=$$GET1^DIQ(52.49,PSOIEN,.12,"I") I 'ORNUM W !!,"No OE/RR order number. Cannot create renewal request." D DIRE Q
 S PEND=$O(^PS(52.41,"B",ORNUM,0))
 S RXIEN=$O(^PSRX("APL",ORNUM,0))
 I PEND,'RXIEN W !!,"RX appears to be in Pending Outpatient Orders, but not yet processed to",!,"backdoor orders." D DIRE Q
 I 'PEND,'RXIEN W !!,"Cannot resolve RX#. Please ensure the prescription is in the prescription file."  D DIRE Q
 ;/BLB/ PSO*7.0*520 - correct typo in the word "prescription" - BEGIN CHANGE
 S EXDT=$$GET1^DIQ(52,RXIEN,26,"I") I EXDT<DT W !!,"Medication has expired, cannot renew prescription." D DIRE Q
 ;/BLB/ - END CHANGE
 S REFL=$$GET1^DIQ(52,RXIEN,9,"I"),I=0 F  S I=$O(^PSRX(RXIEN,1,I)) Q:'I  S REFL=REFL-1
 ; When renewal/refill request is being used, re-activate the following line of code
 ;I REFL>0 W !!,"Refills remaining for this prescription. Cannot create refill request." D DIRE Q
 W !!,"Would you like to send a refill (renewal) request to the prescriber"
 S DIR(0)="YO" D ^DIR
 I Y<1 Q
 S GBL=$$RREQ(PSOIEN,RXIEN,ORNUM,PSOSITE) I '$O(@GBL@(0)) W !!,"Could not create outgoing renewal message structure." D DIRE Q
 S PSSRET=$$RESTPOST^PSOERXO1(.PSSRET,.GBL)
 ; if the post was unsuccessful, inform the user and quit.
 I $P(PSSRET(0),U)<1 W !,$P(PSSRET(0),U,2) S DIR(0)="E" D ^DIR K DIR Q
 I $D(PSSRET("errorMessage")) W !,PSSRET("errorMessage") S DIR(0)="E" D ^DIR K DIR Q
 W !!,"Renewal Request sent." S DIR(0)="E" D ^DIR K DIR
 K @GBL
 Q
 ; CHANGE REQUEST VIA ERX HOLDING QUEUE
CREQHQ(PSOIEN) ;
 N ORNUM,RXIEN,DRUG,GBL,DROK,PSSRET,CNT
 Q:'PSOIEN
 ; IF THIS HASN'T BEEN SENT TO THE PRESCRIPTION FILE, WE DONT NEED ORDER OR RXIEN
 S ORNUM=$$GET1^DIQ(52.49,PSOIEN,.12,"I") I 'ORNUM W !!,"This order has been Accepted from eRx and cannot be changed." D DIRE Q
 S RXIEN=$O(^PSRX("APL",ORNUM,0)) I 'RXIEN W !!,"A current prescription exists for this eRx. Cannot change eRx." D DIRE Q
 ; build drug information into array to be passed into xml builder
 ; for future use
 ; may consider having the user fill in the drug validation screen then issue change request. Or replicate
 ; drug validation section into another 'Change Request' screen.
 S DROK=$$DRGPRMPT(.DRUG) I 'DROK W !!,"Insufficient drug information. Cannot create change request.",!,"Please try again." D DIRE Q
 S GBL=$$CREQ(PSOIEN,.DRUG) I '$L(GBL) W !!,"Could not create outgoing message structure." D DIRE Q
 S PSSRET=$$RESTPOST^PSOERXO1(.PSSRET,.GBL)
 ; if the post was unsuccessful, inform the user and quit.
 I $P(PSSRET(0),U)<1 W !,$P(PSSRET(0),U,2) S DIR(0)="E" D ^DIR K DIR Q
 I $D(PSSRET("errorMessage")) W !,PSSRET("errorMessage") S DIR(0)="E" D ^DIR K DIR Q
 W !!,"Change Request sent." S DIR(0)="E" D ^DIR K DIR
 K @GBL
 Q
 ; RXFILL MESSAGE
FMES(PSOIEN) ;
 N ORNUM,RXIEN,DRUG,GBL,FTYPE,PSSRET,CNT
 Q:'PSOIEN
 S ORNUM=$$GET1^DIQ(52.49,PSOIEN,.12,"I") I 'ORNUM W !!,"No OE/RR order number. Cannot create refill request." D DIRE Q
 S RXIEN=$O(^PSRX("APL",ORNUM,0)) I 'RXIEN W !!,"Could not resolve RX #. Please contact technical support." D DIRE Q
 ; FOR NOW SET NOTE AND FTYPE (FULL/PARTIAL) FOR BUILDING XML
 S NOTE="TESTING NOTE"
 S FTYPE="F"
 S GBL=$$RXFILL(PSOIEN,FTYPE,NOTE,RXIEN,ORNUM) I '$L(GBL) W !!,"Could not create outgoing message structure." D DIRE Q
 ;W !!,"RxFill message sent to prescriber." S DIR(0)="E" D ^DIR K DIR 
 S PSSRET=$$RESTPOST^PSOERXO1(.PSSRET,.GBL)
 ; if the post was unsuccessful, inform the user and quit.
 I $P(PSSRET(0),U)<1 W !,$P(PSSRET(0),U,2) S DIR(0)="E" D ^DIR K DIR Q
 I $D(PSSRET("errorMessage")) W !,PSSRET("errorMessage") S DIR(0)="E" D ^DIR K DIR Q
 W !!,"RxFill Message sent." S DIR(0)="E" D ^DIR K DIR
 K @GBL
 Q
 ; prompt for drug fields needed to create a change request - not currently used
DRGPRMPT(DRG) ;
 ; Prompt for drug
 N DIC,PSODRUG,DIR,Y
 S DIC(0)="AEMQ",DIC=50,DIC("S")="I $$ACTIVE^PSOERXA0(Y),($$OUTPAT^PSOERXA0(Y)),('$$INVCOMP^PSOERXA0(Y)),('$$CS^PSOERXA0(Y))" D ^DIC
 K DIC
 Q:$P(Y,U)<1 0
 ; FOR FUTURE USE - ADD ROUTE PROMPT
 ; Y=DRUG IEN^DRUG DESCRIPTION
 S DRG("DRUG")=$P(Y,U,2)
 S PSODRUG("IEN")=$P(Y,U)
 ; prompt for days supply
 K DIR S DIR(0)="52.49,20.2" D ^DIR
 Q:$P(Y,U)<1 0
 S DRG("DSUP")=Y
 ; prompt for quantity
 K DIR S DIR(0)="52.49,20.1" D ^DIR
 Q:$P(Y,U)<1 0
 S DRG("QTY")=Y
 ; prompt for refills
 K DIR S DIR(0)="52.49,20.5" D ^DIR
 Q:$P(Y,U)<1 0
 S DRG("REF")=Y
 ; prompt for directions
 K DIR S DIR(0)="52.49,7" D ^DIR
 Q:Y="^" 0
 Q:Y']"" 0
 S DRG("DIR")=Y
 Q 1
 ; CHANGE REQUEST VIA BACKDOOR ORDERS
CREQBD(RXIEN) ;
 Q
 ; CHANGE REQUEST VIA PSO LMOE FINISH
CREQPO(ORIEN) ;
 Q
RREQ(PSOIEN,RXIEN,ORNUM,PSOSITE) ;RefillRequest
 N GBL,PSOIENS,CNT
 Q:'PSOIEN ""
 S GBL=$NA(^TMP("RREQ^PSOERXX1",$J)) K @GBL
 S CNT=0
 D MSG^PSOERXX2(.GBL,1)
 ; header
 D HDR^PSOERXX2(.GBL,PSOIEN)
 ; body header
 D BHF^PSOERXX2(.GBL,1)
 ; request type header
 D RTYPE^PSOERXX2(.GBL,"RefillRequest",1)
 ; request info - not currently used
 ;D REQUEST^PSOERXX2(.GBL,"ACC","ACC")
 D VAPHARM^PSOERXX2(.GBL,PSOSITE,PSOIEN)
 D PRESCRIB^PSOERXX2(.GBL,PSOIEN)
 D SUPERVIS^PSOERXX2(.GBL,PSOIEN)
 D FACIL^PSOERXX2(.GBL,PSOIEN)
 D PATIENT^PSOERXX3(.GBL,PSOIEN)
 D MEDPRES^PSOERXX4(.GBL,PSOIEN)
 D MEDDIS^PSOERXX4(.GBL,RXIEN,ORNUM,PSOIEN)
 D OBSERVE^PSOERXX3(.GBL,PSOIEN)
 D BENEFITS^PSOERXX3(.GBL,PSOIEN)
 D DRUGEVAL^PSOERXX3(.GBL,PSOIEN)
 ;D DIAGNOS(.GBL,PSOIEN)
 D RTYPE^PSOERXX2(.GBL,"RefillRequest",2)
 D BHF^PSOERXX2(.GBL,2)
 D MSG^PSOERXX2(.GBL,2)
 Q GBL
 ; PSOIEN - erx IEN from 52.49
CREQ(PSOIEN,REQDRUG) ;ChangeRequest
 N GBL,PSOIENS,CNT
 Q:'PSOIEN ""
 S GBL=$NA(^TMP("CREQ^PSOERXX1",$J)) K @GBL
 S CNT=0
 D MSG^PSOERXX2(.GBL,1)
 ; header
 D HDR^PSOERXX2(.GBL,PSOIEN)
 ; body header
 D BHF^PSOERXX2(.GBL,1)
 ; request type header
 D RTYPE^PSOERXX2(.GBL,"ChangeRequest",1)
 ; request info
 D REQUEST^PSOERXX2(.GBL,"TST","TST")
 D VAPHARM^PSOERXX2(.GBL,PSOIEN)
 D PRESCRIB^PSOERXX2(.GBL,PSOIEN)
 D SUPERVIS^PSOERXX2(.GBL,PSOIEN)
 D FACIL^PSOERXX2(.GBL,PSOIEN)
 D PATIENT^PSOERXX3(.GBL,PSOIEN)
 D MEDPRES^PSOERXX4(.GBL,PSOIEN)
 D MEDREQ^PSOERXX4(.GBL,PSOIEN,.REQDRUG)
 D OBSERVE^PSOERXX3(.GBL,PSOIEN)
 D BENEFITS^PSOERXX3(.GBL,PSOIEN)
 D DRUGEVAL^PSOERXX3(.GBL,PSOIEN)
 D DIAGNOS^PSOERXX3(.GBL,PSOIEN)
 D RTYPE^PSOERXX2(.GBL,"ChangeRequest",2)
 D BHF^PSOERXX2(.GBL,2)
 D MSG^PSOERXX2(.GBL,2)
 Q GBL
 ; FP - full or partial fill (F/P)
 ; NOTE - fill notes
RXFILL(PSOIEN,FP,NOTE,RXIEN,ORNUM) ;
 N GBL,PSOIENS,CNT
 Q:'PSOIEN ""
 S GBL=$NA(^TMP("RXFILL^PSOERXX1",$J)) K @GBL
 S CNT=0
 D MSG^PSOERXX2(.GBL,1)
 ; header
 D HDR^PSOERXX2(.GBL,PSOIEN)
 ; body header
 D BHF^PSOERXX2(.GBL,1)
 ; request type header
 D RTYPE^PSOERXX2(.GBL,"RxFill",1)
 ; request info
 ;D REQUEST(.GBL,"TEST1","TEST2")
 ;FP - full or partial fill
 S FP="F"
 S NOTE=$G(NOTE,"TESTING NOTES")
 ; fill status
 D FILLST^PSOERXX3(.GBL,FP,NOTE)
 D VAPHARM^PSOERXX2(.GBL,PSOIEN)
 D PRESCRIB^PSOERXX2(.GBL,PSOIEN)
 D SUPERVIS^PSOERXX2(.GBL,PSOIEN)
 D FACIL^PSOERXX2(.GBL,PSOIEN)
 D PATIENT^PSOERXX3(.GBL,PSOIEN)
 D MEDPRES^PSOERXX4(.GBL,PSOIEN)
 D MEDDIS^PSOERXX4(.GBL,PSOIEN)
 D OBSERVE^PSOERXX3(.GBL,PSOIEN)
 D BENEFITS^PSOERXX3(.GBL,PSOIEN)
 D DRUGEVAL^PSOERXX3(.GBL,PSOIEN)
 ;D DIAGNOS^PSOERXX3(.GBL,PSOIEN)
 D RTYPE^PSOERXX2(.GBL,"RxFill",2)
 D BHF^PSOERXX2(.GBL,2)
 D MSG^PSOERXX2(.GBL,2)
 Q GBL
DIRE ;
 N DIR S DIR(0)="E" D ^DIR
 Q

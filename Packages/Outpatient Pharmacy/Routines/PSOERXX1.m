PSOERXX1 ;ALB/BWF - eRx xml utilities ; 8/3/2016 5:14pm
 ;;7.0;OUTPATIENT PHARMACY;**467,520,527,508,581,617**;DEC 1997;Build 110
 ;
 Q
 ; called by PSO ERX RX RENEWAL REQUEST action protocol
RREQLST(PSOLST,PSOSITE,PSOCNT) ;
 N ITEM,SEL,ORD,I,ERXIEN,DONE,ORDER,ORDLST,RXIEN,RXDRUG,RXDRUGN,PRECHECK,DIR
 D FULL^VALM1
 S DIR("A")="Select Orders by number",DIR(0)="LO^1:"_PSOCNT D ^DIR I $D(DTOUT)!($D(DUOUT)) K DIR,DIRUT,DTOUT,DUOUT Q
 S ORDLST=Y
 W !!,"NOTE: If you have selected items that are not inbound eRx Prescriptions,"
 W !,"those entries will be skipped during the RxRenewal process.",!!
 K DIR
 S DONE=0
 F I=1:1 D  Q:DONE
 .S ITEM=$P(ORDLST,",",I) I ITEM="" S DONE=1 Q
 .I $P(PSOLST(ITEM),U)'=52 W !,"This item is "_$P(PSOLST(ITEM),U,3)_" and cannot be renewed.",! D DIRE Q
 .S RXIEN=$P(PSOLST(ITEM),U,2)
 .S ORDER=$$GET1^DIQ(52,RXIEN,39.3,"I")
 .S ERXIEN=$$CHKERX^PSOERXU1(ORDER) Q:'ERXIEN
 .S RXDRUG=$$GET1^DIQ(52,RXIEN,6,"I"),RXDRUGN=$$GET1^DIQ(52,RXIEN,6,"E")
 .W !!,"Now renewing prescription #: "_$$GET1^DIQ(52,RXIEN,.01,"E")
 .W !,"Patient: "_$$GET1^DIQ(52,RXIEN,2,"E")
 .W !,"Drug/Supply: "_RXDRUGN
 .W !,"# of Refills: "_$$GET1^DIQ(52,RXIEN,9,"E"),?30,"Days Supply: "_$$GET1^DIQ(52,RXIEN,8,"E"),?52,"Quantity: "_$$GET1^DIQ(52,RXIEN,7,"E")
 .S PRECHECK=$$RENEW^PSORENW(RXIEN,RXDRUG)
 .I $P(PRECHECK,U)<1 W !,$P(PRECHECK,U,2),! D DIRE Q
 .D RREQOP(ERXIEN,PSOSITE)
 Q
 ; Called by PSO ERX SINGLE RX RENEWAL REQUEST action protocol
RREQSIN(RXIEN,PSOSITE) ;
 N ORDER,ERXIEN,RXDRUG,RXDRUGN,PRECHECK
 S ORDER=$$GET1^DIQ(52,RXIEN,39.3,"I") Q:'ORDER
 S ERXIEN=$$CHKERX^PSOERXU1(ORDER) I 'ERXIEN W !!,"RxRenewal request may not be used. This prescription is not an eRx." D DIRE Q
 S RXDRUG=$$GET1^DIQ(52,RXIEN,6,"I"),RXDRUGN=$$GET1^DIQ(52,RXIEN,6,"E")
 W !!,"Now renewing prescription #: "_$$GET1^DIQ(52,RXIEN,.01,"E")
 W !,"Patient: "_$$GET1^DIQ(52,RXIEN,2,"E")
 W !,"Drug/Supply: "_RXDRUGN,!!
 W !,"# of Refills: "_$$GET1^DIQ(52,RXIEN,9,"E"),?30,"Days Supply: "_$$GET1^DIQ(52,RXIEN,8,"E"),?52,"Quantity: "_$$GET1^DIQ(52,RXIEN,7,"E")
 S PRECHECK=$$RENEW^PSORENW(RXIEN,RXDRUG)
 I $P(PRECHECK,U)<1 W !,$P(PRECHECK,U,2),! Q
 D RREQOP(ERXIEN,PSOSITE)
 Q
 ; PSOIEN - ien from 52.49 (erx holding queue)
 ; PSOSITE - site ien from the outpatient site file (59)
 ; RX RENEWAL REQUEST VIA PSO LMOE FINISH/BACKDOOR ORDERS
RREQOP(PSOIEN,PSOSITE) ;
 N ORNUM,RXIEN,PSSOUT,GBL,REFL,I,EXDT,PEND,PSSRET,CNT,DIR,Y,REFQTY,REFREQ,DIV,VADAT,RRCNT
 N I,SSSTART,SSSTOP,GBL2,XXL1,XXL2,HUBID,NPIINST,STATION,Y,DIR,DONE,INNAME,NPI,NERXIEN,PROHIBIT1,PROHIBIT
 N MSGIEN,MSGDT,RESIEN,SIG,SIGLEN,DTCUT,RTHID,PSORENW,EXPFLG,S2017,MTYPE,RESVAL,REQIEN
 S VALMBCK="R"
 Q:'PSOIEN!('PSOSITE)
 S MTYPE=$$GET1^DIQ(52.49,PSOIEN,.08,"I")
 I MTYPE="CX" S NERXIEN=$$FINDNRX^PSOERXU6(PSOIEN)
 I MTYPE="CX" S PROHIBIT=$$GET1^DIQ(52.49,NERXIEN,301.3,"I")
 I MTYPE'="CX" S PROHIBIT=$$GET1^DIQ(52.49,PSOIEN,301.3,"I")
 I PROHIBIT W !!,"Renewals are prohibited for this eRx." D DIRE Q
 S RESVAL=$$GET1^DIQ(52.49,PSOIEN,52.1,"I")
 S S2017=$$GET1^DIQ(52.49,PSOIEN,312.1,"I")
 S NPIINST=$$GET1^DIQ(59,PSOSITE,101,"I")
 S INNAME=$$NAME^XUAF4(NPIINST)
 S STATION=$$WHAT^XUAF4(NPIINST,99)
 D FULL^VALM1
 ; bwf - if the NPI is not coming back from the $$NPI check, we have to pull it from the field
 ;       iteself
 S NPI=$$NPI^XUSNPI("Organization_ID",NPIINST) I $P(NPI,U)<1 D
 .S NPI=$$WHAT^XUAF4(NPIINST,41.99)
 I '$G(NPI) W !!,"NPI could not be established. Cannot create renewal request." D DIRE Q
 S DIV=INNAME_U_NPI
 S ORNUM=$$GET1^DIQ(52.49,PSOIEN,.12,"I") I 'ORNUM W !!,"No OE/RR order number. Cannot create renewal request." D DIRE Q
 S PEND=$O(^PS(52.41,"B",ORNUM,0))
 S RXIEN=$O(^PSRX("APL",ORNUM,0))
 I PEND,'RXIEN W !!,"RX appears to be in Pending Outpatient Orders, but not yet processed to",!,"backdoor orders." D DIRE Q
 I 'PEND,'RXIEN W !!,"Cannot resolve RX#. Please ensure the prescription is in the prescription file."  D DIRE Q
 I $$GET1^DIQ(52,RXIEN,100,"I")=5 W !!,"Rx is in suspense, cannot renew prescription." D DIRE Q
 S PSORENW("ORX #")=$$GET1^DIQ(52,RXIEN,.01,"E")
 I $A($E(PSORENW("ORX #"),$L(PSORENW("ORX #"))))'<90 W !!,"Cannot renew Rx # "_PSORENW("ORX #")_", Max number reached." D DIRE Q
 S EXDT=$$GET1^DIQ(52,RXIEN,26,"I")
 I EXDT<$$FMADD^XLFDT(DT,-120) W !!,"Medication has expired, cannot renew prescription." D DIRE Q
 I EXDT<DT S EXPFLG=1
 S REFL=$$GET1^DIQ(52,RXIEN,9,"I"),I=0 F  S I=$O(^PSRX(RXIEN,1,I)) Q:'I  S REFL=REFL-1
 I REFL>0,'$G(EXPFLG) W !!,"Refills remaining for this prescription. Cannot create RxRenewal request." D DIRE Q
 S (SIG,SIGLEN)=0 F  S SIG=$O(^PSRX(RXIEN,"INS1",SIG)) Q:'SIG  D
 .S SIGLEN=$G(SIGLEN)+$L(^PSRX(RXIEN,"INS1",SIG,0))
 I 'S2017,SIGLEN>140 W !!,"Sig is greater than 140 characters. Cannot create renewal request." D DIRE Q
 S (DONE,RRCNT)=0,DTCUT=$$FMADD^XLFDT(DT,-30)
 S REQIEN=$$GETREQ^PSOERXU2(PSOIEN)
 S MSGIEN=999999999 F  S MSGIEN=$O(^PS(52.49,PSOIEN,201,"B",MSGIEN),-1) Q:'MSGIEN  D
 .I $$GET1^DIQ(52.49,MSGIEN,.08,"I")'="RR" Q
 .; if this is a renwal response/replace type, and the record is the related request, quit (dont show this one)
 .I MTYPE="RE",RESVAL="R",MSGIEN=REQIEN,$$GET1^DIQ(52.49,REQIEN,.08,"I")="RR" Q
 .S MSGDT=$$GET1^DIQ(52.49,MSGIEN,.03,"I")
 .I MSGDT<DTCUT S DONE=1 Q
 .S RRCNT=$G(RRCNT)+1
 .S RESIEN=$$GETRESP^PSOERXU2(MSGIEN)
 .W !!,"********************************************************************"
 .W !!,"Previous RxRenewal Request Date/Time: "_$$FMTE^XLFDT(MSGDT)
 .W !,"RxRenewal Requested by: "_$$GET1^DIQ(52.49,MSGIEN,51.1,"E")
 .W !,"# of Refills Requested: "_$$GET1^DIQ(52.49,MSGIEN,51.2,"E")
 .I 'RESIEN D  Q
 ..W !!,"***No response received from provider.***",!
 ..S DIR(0)="E" D ^DIR K DIR
 .W !!,"RxRenewal response Date/Time: "_$$GET1^DIQ(52.49,RESIEN,.03,"E")
 .W !!,"RxRenewal response status: "_$$GET1^DIQ(52.49,RESIEN,1,"E")
 .W !!,"********************************************************************"
 I RRCNT>0 W !!,"Total Number of RxRenewal requests in the last 30 days: "_RRCNT,!!
 I RRCNT D  Q:'Y
 .K DIR S DIR(0)="YO",DIR("B")="N",DIR("A")="Are you sure you would like to send ANOTHER RxRenewal request" D ^DIR
 W !!,"Generating RxRenewal request for Rx #: "_$$GET1^DIQ(52,RXIEN,.01,"E"),!!
 K DIR S DIR(0)="SO^R:RENEW WITH PRE-POPULATED VALUE;C:CHANGE # OF REFILLS;E:EXIT"
 S DIR("?")="     E - Exit"
 S DIR("?",1)="     R - Request the same # of refills as the original Rx"
 S DIR("?",2)="     C - Request desired # of refills (0-11)"
 D ^DIR K DIR
 I Y="E"!$D(DIRUT)!(Y="^") Q
 ;Med Dispensed segments when the Qualifier is 'P' ('n' is the original Refill value sent on NEWRX)
 S REFQTY=$$GET1^DIQ(52,RXIEN,9,"I")
 I Y="R" D
 .S REFREQ=REFQTY
 ;Refill with change Quantity (questions to be displayed to the user such as # of refills, Pharmacist Notes and so on) 
 S DONE=0
 I Y="C" D
 .F  D  Q:DONE!($G(REFREQ)'="")
 ..S DIR(0)="NO^0:11",DIR("A")="Enter # of Refills or '^' to exit" D ^DIR K DIR
 ..Q:Y=""
 ..I Y="^"!$D(DIRUT) S DONE=1 Q
 ..S REFREQ=Y
 Q:DONE=1
 S REFREQ=REFREQ+1
 I '$G(REFREQ) W !!,"Number of Refills is required. RxRenewal request cancelled." S DIR(0)="E" D ^DIR K DIR
 ; display information to the user
 W !!,"Sending RxRenewal request for:"
 W !!,"Patient: "_$$GET1^DIQ(52,RXIEN,2,"E")
 W !,"Patient Status: "_$$GET1^DIQ(52,RXIEN,3,"E")
 W !,"Drug: "_$$GET1^DIQ(52,RXIEN,6,"E")
 W !,"Orderable Item: "_$$GET1^DIQ(52,RXIEN,39.2,"E")
 W !,"# of Refills Requested: "_REFREQ,?30,"Days Supply: "_$$GET1^DIQ(52,RXIEN,8,"E"),?52,"Quantity: "_$$GET1^DIQ(52,RXIEN,7,"E")
 W !!,"Would you like to send this RxRenewal request to the prescriber"
 S DIR(0)="YO",DIR("B")="N" D ^DIR K DIR
 I Y<1!(Y=U) S DIR(0)="E" W !!,"RxRenewal Request cancelled! No RxRenewal request will be sent." D ^DIR K DIR Q
 I 'S2017 S GBL=$$RREQ(PSOIEN,RXIEN,ORNUM,PSOSITE,.MESSID,REFREQ) I '$O(@GBL@(0)) W !!,"Could not create outgoing renewal message structure." D DIRE Q
 I S2017 S GBL=$$RENEWREQ^PSOERXOA(PSOIEN,RXIEN,ORNUM,PSOSITE,.MESSID,REFREQ) I '$O(@GBL@(0)) W !!,"Could not create outgoing renewal message structure." D DIRE Q
 S PSSRET=$$RESTPOST^PSOERXO1(.PSSRET,.GBL)
 ; if the post was unsuccessful, inform the user and quit.
 I $P(PSSRET(0),U)<1 W !,$P(PSSRET(0),U,2) S DIR(0)="E" D ^DIR K DIR Q
 I $D(PSSRET("errorMessage")) W !,PSSRET("errorMessage") S DIR(0)="E" D ^DIR K DIR Q
 S HUBID=$G(PSSRET("outboundMsgId")) I 'HUBID W !,"The eRx Processing hub did not return a Hub identification number." S DIR(0)="E" D ^DIR K DIR Q
 ; vista generated message will be V12345 (V concatenated to the hubId)
 S HUBID="V"_HUBID
 W !!,"Renewal Request sent." S DIR(0)="E" D ^DIR K DIR
 ; Validates if the order is an eRx and Logs Activity in AL eRx for Approved Refill Response Pending Renewal Activity 
 D RXACT^PSOBPSU2(RXIEN,,"Electronic RxRenewal Request sent to External Provider","O")
 N RES
 I 'S2017 D
 .S I=0 F  S I=$O(@GBL@(I)) Q:'I!($G(SSSTART))  D
 ..I $G(@GBL@(I,0))="<StructuredSIG>" S SSSTART=I Q
 .S I=999999999 F  S I=$O(@GBL@(I),-1) Q:'I!$G(SSSTOP)  D
 ..I $G(@GBL@(I,0))="</StructuredSIG>" S SSSTOP=I
 .S GBL2=$NA(^TMP("STSIG^PSOERXX1",$J)) K @GBL2
 .I $D(SSSTART),$D(SSSTOP) D
 ..F I=SSSTART:1:SSSTOP D
 ...S @GBL2@(I,0)=@GBL@(I,0) K @GBL@(I,0)
 .; build streams
 .; set BP
 .S I=0 F  S I=$O(@GBL@(I)) Q:'I  D
 ..S XXL1=$G(XXL1)_$G(@GBL@(I,0))
 .I $D(@GBL2) D
 ..S I=0 F  S I=$O(@GBL2@(I)) Q:'I  D
 ...S XXL2=$G(XXL2)_$G(@GBL2@(I,0))
 ..S XXL2="<SIG>"_XXL2_"</SIG>"
 .I '$D(XXL2) S XXL2=""
 .S VADAT=DUZ_U_RXIEN
 .S RTHID=$$GET1^DIQ(52.49,PSOIEN,.01,"E")
 .S HUBID=HUBID_U_U_RTHID
 .D INCERX^PSOERXA1(.RES,.XXL1,"","","",STATION,DIV,HUBID,"",.XXL2,VADAT)
 I S2017 D
 .; build stream
 .S I=0 F  S I=$O(@GBL@(I)) Q:'I  D
 ..S XXL1=$G(XXL1)_$G(@GBL@(I,0))
 .S VADAT=DUZ_U_RXIEN
 .S RTHID=$$GET1^DIQ(52.49,PSOIEN,.01,"E")
 .S HUBID=HUBID_U_U_RTHID
 .D INCERX^PSOERXI1(.RES,.XXL1,"","","",STATION,DIV,HUBID,"","",VADAT,"")
 I $P(RES,U)=0 D
 .W !,"A problem was encountered while trying to file the RxRenewal request."
 .W !,"RxRenewal Request was not filed in vista."
 .W !!,"ERROR: "_$P(RES,U,2)
 .S DIR(0)="E" D ^DIR K DIR
 K @GBL
 Q
 ; CHANGE REQUEST VIA ERX HOLDING QUEUE
CREQHQ(PSOIEN,PSOSITE) ;
 N ORNUM,RXIEN,DRUG,GBL,DROK,CNT,PSSRET
 Q:'PSOIEN!('PSOSITE)
 S ORNUM=$$GET1^DIQ(52.49,PSOIEN,.12,"I") ;I 'ORNUM W !!,"This order has been Accepted from eRx and cannot be changed." D DIRE Q
 S RXIEN=$O(^PSRX("APL",ORNUM,0)) ;I 'RXIEN W !!,"A current prescription exists for this eRx. Cannot change eRx." D DIRE Q
 ; build drug information into array to be passed into xml builder
 ; for future use
 ; may consider having the user fill in the drug validation screen then issue change request. Or replicate
 ; drug validation section into another 'Change Request' screen.
 S DROK=$$DRGPRMPT(.DRUG) I 'DROK W !!,"Insufficient drug information. Cannot create change request.",!,"Please try again." D DIRE Q
 S GBL=$$CREQ(PSOIEN,.DRUG,PSOSITE,ORNUM,RXIEN) I '$L(GBL) W !!,"Could not create outgoing message structure." D DIRE Q
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
 S ORNUM=$$GET1^DIQ(52.49,PSOIEN,.12,"I") ;I 'ORNUM W !!,"No OE/RR order number. Cannot create rx renewal request." D DIRE Q
 S RXIEN=$O(^PSRX("APL",ORNUM,0)) ;I 'RXIEN W !!,"Could not resolve RX #. Please contact technical support." D DIRE Q
 S NOTE="TESTING NOTE"
 S FTYPE="F"
 S GBL=$$RXFILL(PSOIEN,FTYPE,NOTE,RXIEN,ORNUM) I '$L(GBL) W !!,"Could not create outgoing message structure." D DIRE Q 
 S PSSRET=$$RESTPOST^PSOERXO1(.PSSRET,.GBL)
 ; if the post was unsuccessful, inform the user and quit.
 I $P(PSSRET(0),U)<1 W !,$P(PSSRET(0),U,2) S DIR(0)="E" D ^DIR K DIR Q
 I $D(PSSRET("errorMessage")) W !,PSSRET("errorMessage") S DIR(0)="E" D ^DIR K DIR Q
 W !!,"RxFill Message sent." S DIR(0)="E" D ^DIR K DIR
 ; if the message was successful, file the outbound message contents into 52.49
 K @GBL
 Q
 ; prompt for drug fields needed to create a change request - not currently used
DRGPRMPT(DRG) ;
 ; Prompt for drug
 N DIC,PSODRUG,DIR,Y
 S DIC(0)="AEMQ",DIC=50,DIC("S")="I $$ACTIVE^PSOERXA0(Y),($$OUTPAT^PSOERXA0(Y)),('$$INVCOMP^PSOERXA0(Y))" D ^DIC
 K DIC
 Q:$P(Y,U)<1 0
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
RREQ(PSOIEN,RXIEN,ORNUM,PSOSITE,MESSID,REFREQ) ;RefillRequest
 N GBL,PSOIENS,CNT
 Q:'PSOIEN ""
 S GBL=$NA(^TMP("RREQ^PSOERXX1",$J)) K @GBL
 S CNT=0
 D MSG^PSOERXX2(.GBL,1)
 ; header
 S MESSID=$$HDR^PSOERXX2(.GBL,PSOIEN)
 ; body header
 D BHF^PSOERXX2(.GBL,1)
 ; request type header
 D RTYPE^PSOERXX2(.GBL,"RefillRequest",1)
 ; request info - not currently used
 ;D REQUEST^PSOERXX2(.GBL,"ACC","ACC")
 D VAPHARM^PSOERXX2(.GBL,PSOSITE,PSOIEN)
 D PRESCRIB^PSOERXX2(.GBL,PSOSITE,PSOIEN)
 D SUPERVIS^PSOERXX2(.GBL,PSOSITE,PSOIEN)
 D FACIL^PSOERXX2(.GBL,PSOSITE,PSOIEN)
 D PATIENT^PSOERXX3(.GBL,PSOSITE,PSOIEN)
 D MEDPRES^PSOERXX4(.GBL,PSOIEN,REFREQ,REFREQ)
 D MEDDIS^PSOERXX4(.GBL,RXIEN,ORNUM,PSOIEN,REFREQ)
 D OBSERVE^PSOERXX3(.GBL,PSOIEN)
 D BENEFITS^PSOERXX3(.GBL,PSOIEN)
 D DRUGEVAL^PSOERXX3(.GBL,PSOIEN)
 ;D DIAGNOS(.GBL,PSOIEN)
 D RTYPE^PSOERXX2(.GBL,"RefillRequest",2)
 D BHF^PSOERXX2(.GBL,2)
 D MSG^PSOERXX2(.GBL,2)
 Q GBL
 ; PSOIEN - erx IEN from 52.49
CREQ(PSOIEN,REQDRUG,PSOSITE,ORNUM,RXIEN) ;ChangeRequest
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
 D RTYPE^PSOERXX2(.GBL,"RxChangeRequest",1)
 ; request info
 D REQUEST^PSOERXX2(.GBL,"TST","TST")
 D VAPHARM^PSOERXX2(.GBL,PSOSITE,PSOIEN)
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
 D RTYPE^PSOERXX2(.GBL,"RxChangeRequest",2)
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
CONVXML(ARYNM) ;
 N F,F2,F3,F4,DATA
 S F=0 F  S F=$O(@ARYNM@(F)) Q:F=""  D
 .S F2="" F  S F2=$O(@ARYNM@(F,F2)) Q:F2=""  D
 ..S F3="" F  S F3=$O(@ARYNM@(F,F2,F3)) Q:F3=""  D
 ...S F4="" F  S F4=$O(@ARYNM@(F,F2,F3,F4)) Q:F4=""  D
 ....S DATA=$G(@ARYNM@(F,F2,F3,F4))
 ....S DATA=$$SYMENC^MXMLUTL(DATA)
 ....S @ARYNM@(F,F2,F3,F4)=DATA
 Q

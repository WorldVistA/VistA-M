YSCLDIS ;HINOI/RTW,HEC/hrubovcak - DISCONTINUE CLOZAPINE PATIENT STATUS ;8 Nov 2019 15:21:58
 ;;5.01;MENTAL HEALTH;**122,154**;Dec 30, 1994;Build 48
 ;
 Q
 ; Reference to ^DPT supported by IA #10035
 ; Reference to ^PS(55 supported by IA #787
 ; Reference to $$SITE^VASITE supported by IA #10112
 ; Reference to ^DIC supported by DBIA #2051
 ; Reference to ^DIE supported by DBIA #2053
 ; Reference to ^DIQ supported by DBIA #2056
 ; Reference to ^XLFDT supported by DBIA #10103
 ; Reference to ^XMD supported by DBIA #10070
 ; Reference to ^%DTC supported by DBIA #10000
 ;
 ;This routine will loop through ^PS(55,DFN,"ASAND" and check the last prescription
 ; end date and/or the Inpatient Order stop date. If the patient has not had an active
 ; prescription or Inpatent Clozapine Order in the last 56 days, the Active Treatment will STOP
 ; YSCLPT("dataFound?") is true if reason found to NOT discontinue the patient
 ; routine rewritten for YS*5.01*154 - 27 September 2019
 ;
START ; called from XMIT^YSCLTST5
 D DT^DICRW
 ; YSEND used in DMG^YSCLTST5
 ; YSPTDISC - patients discontinued this run
 N DFN,X,Y,YSCLPT,YSEND,YSPTDISC,YSFMCLOZ,YSLN
 S YSEND=$$FMADD^XLFDT(DT,366)
 K ^TMP($J,"YSCLDATA") D XTMPZRO  ; update ^XTMP("YSCLDIS",0)
 D LIST^DIC(603.01,,1,"I",,,,,,,"YSFMCLOZ")  ; 603.01,1 - CLOZAPINE PATIENT - 0;2 POINTER TO PATIENT FILE (#2)
 ;
 F YSLN=1:1 Q:'$D(YSFMCLOZ("DILIST","ID",YSLN))  S DFN=YSFMCLOZ("DILIST","ID",YSLN,1) D:DFN
 . K YSCLPT
 . ; (#53) CLOZAPINE REGISTRATION NUMBER [1F]
 . S YSCLPT("reg#")=$$GET1^DIQ(55,DFN,53) Q:YSCLPT("reg#")=""
 . S YSCLPT("clozStatus")=$$GET1^DIQ(55,DFN,54,"I")
 . Q:YSCLPT("clozStatus")="D"   ;Not checking those already discontinued
 . S YSCLPT("regDate")=$$GET1^DIQ(55,DFN,58,"I")
 . S YSCLPT("numDays")=$$FMDIFF^XLFDT(DT,YSCLPT("regDate"))
 . I YSCLPT("reg#")?1U6N D:YSCLPT("numDays")>4  Q   ;temps greater than 4 days since registration
 ..  S YSCLPT("disconReason")=3 D SVPTINFO,DSCNPT,DMG^YSCLTST5
 . Q:YSCLPT("numDays")<28                     ;Not checking those registered 27 days or less
 . S ^TMP($J,"YSCLDATA",DT,DFN)=YSCLPT("reg#")_U_YSCLPT("regDate"),YSCLPT("dataFound?")=0
 . S YSCLPT("newReg?")=1                       ;Registration is new unless clozapine orders are found
 . D OPT Q:YSCLPT("dataFound?")  ;Not checking further
 . D INP Q:YSCLPT("dataFound?")  ;
 . S YSCLPT("disconReason")=$S(YSCLPT("newReg?"):1,1:2)
 . D SVPTINFO,DSCNPT,DMG^YSCLTST5
 ;
 D MSGTRNS
 Q
OPT ; Outpatient orders
 N YSUNTDOS,YSCLOPT,YSCLRX,YSCLDRG,YSCLFLDT,YSCLSPDT,X,X1,X2,YSCLFLDA
 D LIST^DIC(55.03,","_DFN_",",,"I",,,,,,,"YSUNTDOS")
 S YSCLOPT="A" F  S YSCLOPT=$O(YSUNTDOS("DILIST",1,YSCLOPT),-1) Q:'YSCLOPT  D  Q:YSCLPT("dataFound?")
 . S YSCLRX=YSUNTDOS("DILIST",1,YSCLOPT),YSCLDRG=$$GET1^DIQ(52,YSCLRX,6,"I") Q:'YSCLDRG
 . Q:'$L($$GET1^DIQ(50,YSCLDRG,17.5))  ;'$D(^PSDRUG("ACLOZ",+YSCLDRG))
 . S YSCLFLDT=$$GET1^DIQ(52,YSCLRX,22,"I") Q:YSCLFLDT<YSCLPT("regDate")   ;Fill Date before Registration
 . S YSCLPT("newReg?")=0  ; Registration isn't new
 . S YSCLSPDT=$$GET1^DIQ(52,YSCLRX,26,"I")
 . I YSCLSPDT'<DT S YSCLPT("dataFound?")=1 Q  ; Not Expired yet
 . S X1=DT,X2=YSCLFLDT D ^%DTC S YSCLFLDA=X
 . I YSCLFLDA<56 S YSCLPT("dataFound?")=1
 Q
 ;
INP ;Inpatient Orders
 ; YSDSPDRG - DISPENSE DRUG (sub-file 55.07)
 ; YSUNTDOS - UNIT DOSE (sub-file 55.07)
 N YSUNTDOS,YSDSPDRG,YSCLIPT,YSLINE,YSCLDRG,YSCLORDT,YSCLSPDT,YSCLORDA,X,X1,X2
 D LIST^DIC(55.06,","_DFN_",",,"I",,,,,,,"YSUNTDOS")
 S YSCLIPT="A" F  S YSCLIPT=$O(YSUNTDOS("DILIST",1,YSCLIPT),-1) Q:'YSCLIPT  D  Q:YSCLPT("dataFound?")
 . S YSLINE=YSUNTDOS("DILIST",2,YSCLIPT)
 . D LIST^DIC(55.07,","_YSLINE_","_DFN_",",,"I",,,,,,,"YSDSPDRG")
 . S YSCLDRG=+$G(YSDSPDRG("DILIST",1,1)) Q:'$G(YSCLDRG)
 . Q:$$GET1^DIQ(50,YSCLDRG,17.5)'="PSOCLO1"
 . S YSCLORDT=$$GET1^DIQ(55.06,YSLINE_","_DFN,27,"I") Q:YSCLORDT<YSCLPT("regDate")  ;Order date before Registration
 . S YSCLPT("newReg?")=0  ; Registration not new
 . S YSCLSPDT=$$GET1^DIQ(55.06,YSLINE_","_DFN,34,"I")
 . I '(YSCLSPDT<DT) S YSCLPT("dataFound?")=1 Q  ;Not Stopped yet
 . S X1=DT,X2=YSCLORDT D ^%DTC S YSCLORDA=X
 . I YSCLORDA<56 S YSCLPT("dataFound?")=1
 Q
 ;
SVPTINFO ; save reason for discontinue
 N J,C,N
 S J=YSCLPT("disconReason"),C=$S(J=1:"28 days",J=2:"56 days",1:"temp # expired"),N=$$NOW^XLFDT
 S ^XTMP("YSCLDIS",N,DFN,0)=J_U_C,YSPTDISC(DFN)=YSCLPT("disconReason")
 S ^XTMP("YSCLDIS",N,DFN,"STATUS")=YSCLPT("clozStatus")
 Q
 ;
DSCNPT ; discontinue patient in file #55
 ; ^DD(55,54,0) = 'CLOZAPINE STATUS^S'
 ; ^DD(55,56,0) = 'DEMOGRAPHICS SENT^S'
 N DA,DIE,DR
 S DIE="^PS(55,",DA=DFN,DR="54///D;56///1" D ^DIE
 Q
 ;
MSGTRNS ; transmit message
 N XMERR,YSBODY,YSFROM,YSITE,YSXMDUZ,YSXMINSTR,YSXMSUBJ,YSXMTO,YSXMZ
 K ^TMP("XMERR",$J),^TMP($J,"YSCLXDISCMSG")
 ; ^DD(8989.3,501,0) 'PRODUCTION^RS^0:No;1:Yes' Forum for production
 I $$GET1^DIQ(8989.3,1,501,"I") S YSXMTO("G.CLOZAPINE ROLL-UP@DOMAIN.EXT")=""
 S YSXMTO("G.PSOCLOZ")=""  ; always send locally
 D YSXMTEXT
 S YSXMINSTR("FROM")="CLOZAPINE MONITOR"
 S Y=$$SITE^VASITE,YSXMSUBJ=$P(Y,U,2)_" ("_$P(Y,U,3)_") Discontinued Status"
 S YSBODY=$NA(^TMP($J,"YSCLXDISCMSG"))
 D SENDMSG^XMXAPI(DUZ,YSXMSUBJ,YSBODY,.YSXMTO,.YSXMINSTR,.YSXMZ)
 I $G(YSXMZ)>0 S ^XTMP("YSCLDIS",0,"LAST MESSAGE SENT")=YSXMZ_U_$$NOW^XLFDT
 D  ; 603.03,6 - LAST DEMOGRAPHICS TRANSMISSION 0;6 DATE
 . N DA,DIE,DR
 . S DIE="^YSCL(603.03,",DA=1,DR="6///"_$$NOW^XLFDT D ^DIE
 ;
 K ^TMP($J,"YSCLXDISCMSG")
 ;
 Q
 ;
YSXMTEXT ; build message of discontinued clozapine patients data for NCC
 N J,YSCLRSN
 S YSCLRSN(1,1)="The patient status has changed to 'Discontinued' because the new clozapine"
 S YSCLRSN(1,2)="patient has not filled the prescription/order within 28 days of being"
 S YSCLRSN(1,3)="marked 'Active'."
 S YSCLRSN(2,1)="The patient status has changed to 'Discontinued' because the active clozapine"
 S YSCLRSN(2,2)="patient has not filled the prescription/order within 56 days of"
 S YSCLRSN(2,3)="being prescribed/ordered."
 S YSCLRSN(3,1)="The patient status has changed to 'Discontinued' because the temporary local"
 S YSCLRSN(3,2)="authorization number assigned has expired and NCCC has not issued"
 S YSCLRSN(3,3)="a new authorization number."
 ; count 'em
 S (DFN,Y)=0 F  S DFN=$O(YSPTDISC(DFN)) Q:'DFN  S Y=Y+1
 D ADD2TXT("Clozapine Discontinued Patient(s) Data was transmitted, "_Y_" record"_$S(Y=1:" was",1:"s were")_" sent.")
 D ADD2TXT(" ")  ; blank line
 S DFN=0 F  S DFN=$O(YSPTDISC(DFN)) Q:'DFN  D
 . K YSCLPT
 . Q:'($$GET1^DIQ(55,DFN,54,"I")="D")  ; quit if patient wasn't Discontinued
 . S YSCLPT("ssnLast4")=$E($$GET1^DIQ(2,DFN,.09),6,9)
 . S YSCLPT("ptName&last4")=$$GET1^DIQ(2,DFN,.01)_" ("_YSCLPT("ssnLast4")_")"
 . S YSCLPT("disconReason")=YSPTDISC(DFN)
 . D ADD2TXT(YSCLPT("ptName&last4"))
 . S J=0 F  S J=$O(YSCLRSN(YSCLPT("disconReason"),J)) Q:'J  D ADD2TXT(YSCLRSN(YSCLPT("disconReason"),J))
 ;
 Q
 ;
XTMPZRO ;
 N J,C
 S C=$G(^XTMP("YSCLDIS",0)),J=$$FMADD^XLFDT($$DT^XLFDT,366)  ; keep for one year
 S $P(C,U)=J,$P(C,U,2)=$$NOW^XLFDT,$P(C,U,3)="DISCONTINUED CLOZAPINE PATIENTS"
 S ^XTMP("YSCLDIS",0)=C
 Q
 ;
ADD2TXT(L) ; add line L to the Message text
 Q:'$D(L)  I L="" S L=" "
 N C S C=$G(^TMP($J,"YSCLXDISCMSG",0))+1,^(0)=C,^TMP($J,"YSCLXDISCMSG",C,0)=L
 Q
 ;

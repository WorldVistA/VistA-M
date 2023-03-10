ECUERPC2 ;ALB/JAM  - Event Capture Data Entry Broker Util ;3/6/18  09:26
 ;;2.0;EVENT CAPTURE;**41,39,50,72,134,139,156**;8 May 96;Build 28
 ;
 ; Reference to 2^VADPT supported by ICR #10061
 ; Reference to $$GET^XUA4A72 supported by ICR #1625
 ; Reference to ^DIC(4) supported by ICR #10090
 ; Reference to $$DT^XLFDT) supported by ICR #10103
 ; Reference to LIST^GMPLUTL2 supported by ICR #2741
 ; Reference to DETAIL^GMPLUTL2 supported by ICR #2741
 ; Reference to $$GET1^DIQ supported by ICR #2056
 ; Reference to ^TMP supported by SACC 2.3.2.5.1
 ;
ECDOD(RESULTS,ECARY) ;RPC Broker entry point to get a patient's date of death
 ;        RPC: EC DIEDON
 ;INPUTS   ECARY - Contains the following elements as input
 ;          ECDFN - Patient DFN
 ;
 ;OUTPUTS  RESULTS - Fileman Internal Date of Patient date of Death^
 ;                   Message with Patient External Date of Death
 ;
 N ECDFN,DFN,VADM
 D SETENV^ECUMRPC
 S ECDFN=$P(ECARY,U),RESULTS="^"
 I ECDFN="" S RESULTS="0^Patient DFN not defined" Q
 ;NOIS MWV-0603-21781: line below changed by VMP
 S DFN=ECDFN D 2^VADPT I +VADM(6) S RESULTS=$P(VADM(6),U)_"^"_"[PATIENT DIED ON "_$P(VADM(6),U,2)_"]"
 Q
VISINFO(RESULTS,ECARY) ;
 ;
 ;Broker call returns the EC values based on a Visit Number
 ;        RPC: EC GETVISITINFO
 ;INPUTS   ECARY - Contains the following subscripted elements
 ;          ECVSN - Visit Number, IEN in file (#9000010)
 ;
 ;OUTPUTS  RESULTS - Contains the following data:-
 ;        Location IEN^Location Name^DSS Unit IEN^DSS Unit Name^Send to
 ;        PCE^Procedure Date/Time Fileman^Procedure Date/Time Readable^
 ;        Patient DFN
 ;        or, if error encountered
 ;        0^Error Message
 ;
 N ECLOC,ECUNT,NODE,Y,ECPXDT,DA,ECVSN,ECDFN,DSSF,LOC,UNT
 D SETENV^ECUMRPC
 S ECVSN=$P(ECARY,U) I ECVSN="" S RESULTS=0_"^Visit undefined" Q
 K ^TMP($J,"ECVISINFO")
 S DA=$O(^ECH("C",ECVSN,0)) I 'DA D  Q
 . S RESULTS=0_"^Visit not on File"
 S NODE=$G(^ECH(DA,0)) I NODE="" D  Q
 . S RESULTS=0_"No corresponding EC procedures found for Visit"
 S ECLOC=$P(NODE,U,4),ECUNT=$P(NODE,U,7),ECPXDT=$P(NODE,U,3)
 S LOC=$P($G(^DIC(4,ECLOC,0)),U),UNT=$G(^ECD(ECUNT,0)),DSSF=$P(UNT,U,14)
 S UNT=$P(UNT,U) S:DSSF="" DSSF="N"
 S ECDFN=$P(NODE,U,2),Y=ECPXDT X ^DD("DD")
 S RESULTS=ECLOC_U_LOC_U_ECUNT_U_UNT_U_DSSF_U_ECPXDT_U_Y_U_ECDFN
 Q
PATPRV(ECIEN) ;
 ;Returns to broker a patient providers (primary & secondary) entries
 ;from EVENT CAPTURE PATIENT FILE #721
 ;INPUTS   ECIEN - Event Capture Patient ien
 ;
 ;OUTPUTS  RESULTS - Array of Event Capture Patient file contains
 ;          ^ECH IEN^provider ien^provider description^Primary/Secondary
 ;           code^Primary/Secondary description
 ;
 N ECPRV,ECPROV
 I '$D(^ECH(ECIEN,"PRV")) Q
 K ^TMP($J,"ECPRV")
 S ECPRV=$$GETPRV^ECPRVMUT(ECIEN,.ECPROV) I 'ECPRV D
 .M ^TMP($J,"ECPRV")=ECPROV
 S RESULTS=$NA(^TMP($J,"ECPRV"))
 Q
 ;
ECDEFPRV(RESULTS,ECARY) ;134 Section added
 ;Returns default provider based on user and DSS unit
 ;INPUT    ECARY contains IEN of DSS unit^Procedure date/time
 ;
 ;OUTPUT   RESULTS - IEN^Provider Name if default found
 ;                   -1^ if no default identified
 N DSSIEN,PROCDT,DSSUPCE,PROVIEN
 S RESULTS=-1_"^"
 S DSSIEN=+ECARY Q:'DSSIEN  ;Quit if no DSS unit identified
 S PROCDT=$S($P(ECARY,U,2):$P(ECARY,U,2),1:$$DT^XLFDT) ;if no procedure date/time sent in use today's date
 S DSSUPCE=$P($G(^ECD(DSSIEN,0)),U,14) S:DSSUPCE="" DSSUPCE="N" ;139 Get send to PCE setting, set to 'send no records' if null
 S RESULTS=$$CHK(DUZ) Q:+RESULTS>0  ;Stop if current user is a provider
 D ECDEF^ECUERPC1(.PROVIEN,200) Q:'+PROVIEN  ;Stop if no record in 200 for this user was identified
 S RESULTS=$$CHK(+PROVIEN)
 Q
 ;
CHK(NUM) ;134 Section added to find default provider
 N ECINFO
 S ECINFO=$$GET^XUA4A72(NUM,PROCDT)
 I +ECINFO>0 Q NUM_U_$$GET1^DIQ(200,NUM_",",.01)_U_$P(ECINFO,U,2,4)
 I +ECINFO<0,DSSUPCE="N",$D(^EC(722,"B",NUM)) Q NUM_U_$$GET1^DIQ(200,NUM_",",.01)
 Q -1_"^"
 ;
GETPLST(RESULTS,ECARY) ;156 - Broker call entry point to get a patient's problem list
 ;RPC: EC GETPRBLST
 ;INPUTS   ECARY - Contains the following elements as input
 ;          ECDFN - Patient DFN
 ;          ECSTAT - Status of the problem: Active/Inactive or null
 ;
 ;OUTPUTS  RESULTS - Array of Patient's problems contains
 ;          Problem Status^ICD Code^ICD Code Description^Onset Date^Last Modified Date^Provider^Service
 ;
 N ECGMPL,I,ECIEN,ECSTAT,CNT,ICDDESC,PRBLST,GMPL,PRBIEN
 S ECIEN=$P(ECARY,U),ECSTAT=$P(ECARY,U,2)
 D LIST^GMPLUTL2(.PRBLST,ECIEN,ECSTAT) ;ICR #2741
 I $G(PRBLST(0))<1 S RESULTS="0^No Problem List found for Patient" Q
 S CNT=0
 F  S CNT=$O(PRBLST(CNT)) Q:CNT=""  D
 . S PRBIEN=$P(PRBLST(CNT),U)
 . K GMPL
 . D DETAIL^GMPLUTL2(PRBIEN,.GMPL) ;ICR #2741
 . S ECGMPL(CNT)=$G(GMPL("STATUS"))_U_$G(GMPL("DIAGNOSIS"))_U_$G(GMPL("ICDD"))_U_$G(GMPL("ONSET"))_U_$G(GMPL("MODIFIED"))_U
 . S ECGMPL(CNT)=ECGMPL(CNT)_$G(GMPL("PROVIDER"))_U_$G(GMPL("SERVICE"))
 S ECGMPL(0)=PRBLST(0)
 M ^TMP($J,"ECPLIST")=ECGMPL
 S RESULTS=$NA(^TMP($J,"ECPLIST"))
 Q

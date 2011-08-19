ECUERPC2 ;ALB/JAM;Event Capture Data Entry Broker Utilities ;Apr 24, 2002
 ;;2.0; EVENT CAPTURE ;**41,39,50,72**;8 May 96
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
 ;          Location IEN^DSS Unit IEN^Proc Date/Time Fileman^
 ;           Procedure Date/Time Readable^Patient DFN
 ;          0^Error Message (if error)
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

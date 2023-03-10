YSCLHLMA ;DSS/PO;19 May 2020 14:13:48;28 Nov 2019 18:02:34
 ;;5.01;MENTAL HEALTH;**149**;Dec 30, 1994;Build 72
 ;
 Q
 ;
 ; Reference to ^XLFDT supported by DBIA #10103
 ;
SAVEDATA(DFN,PSGORD,PSORXIEN) ; Get and save the data needed to Build and send registration and clinical/dispense messages
 ; input:   DFN        patient file IEN
 ;          PSGORD     pharmacy patient file UnitDose ien  e.g. 167 or 167U
 ;          PSORXIEN   prescription ien  of prescription file
 Q  ; obsolete, used for HL7 trigger events, save for future use
 D GET^YSCLHLGT(.YSCLARR,DFN,PSGORD,PSORXIEN)
 M ^XTMP("YSCLHL7",$$NOW^XLFDT,DFN_U_+$G(PSGORD)_U_+$G(PSORXIEN),"DATA")=YSCLARR
 D XTMPZRO^YSCLHLOP
 Q
 ;
XMITALL(REXMIT,FROMDT,TODT) ;  re-transmit or transmit HL7 messages, 
 ; input:  inputs are optional    
 ;       REXMIT   re-transmit flag  if 1, it will retransmit the message for given date range
 ;                whether or not the HL7 messages transmit
 ;       FROMDT   start date to start re-transmission
 ;       TODT     end date for re-transmission
 ; if no input paramters, only HL7 messages that are not transferred will be transferred, up to yesterday
 ;
 N I,NODE,XMITRES,YSCLARR,YSDT
 S REXMIT=+$G(REXMIT)
 S YSDT=$S(+$G(FROMDT)>0:FROMDT,1:$$FMADD^XLFDT(DT,-7))   ; start from seven days ago in case of holiday or weekend
 S TODT=$S(+$G(TODT)>0:TODT,1:DT)
 ;
 F  S YSDT=$O(^XTMP("YSCLHL7",YSDT)) Q:(YSDT="")!(YSDT>=TODT)  D
 . S NODE=""
 . F  S NODE=$O(^XTMP("YSCLHL7",YSDT,NODE)) Q:NODE=""  D
 ..  Q:'REXMIT&($G(^XTMP("YSCLHL7",YSDT,NODE,"STATUS","ALL"))>0)  ; do not transmit, if all are already transmited
 ..  K YSCLARR,XMITRES
 ..  M YSCLARR=^XTMP("YSCLHL7",YSDT,NODE,"DATA")
 ..  M XMITRES=^XTMP("YSCLHL7",YSDT,NODE,"STATUS")
 ..  I REXMIT  F I=1:1 Q:'$D(XMITRES(I))  S XMITRES(I)=0     ; force re-transmission of messages for one patient 
 ..  D XMI1PT(.YSCLARR,.XMITRES)    ; transmit the HL7 message for one patient.
 ..  M ^XTMP("YSCLHL7",YSDT,NODE,"STATUS")=XMITRES   ; save the transmission status of messages
 Q
 ;
XMI1PT(YSCLARR,XMITRES,YSILENT) ;  Transmit the HL7 message(s) from YSCLARR  for one Patient. 
 ;        input:  YSCLARR   ; data to build the HL7 message(s) from   
 ; input/Output:  XMITRES    ; call by reference - transmission Status.
 ; YSILENT optional, if 1 no message is written
 N NODE,I
 S:'$G(XMITRES(1)) XMITRES(1)=$$ADTA28^YSCLHLAD(.YSCLARR,$G(YSILENT))_U_"ADT"_U_DT
 ;
 I YSCLARR("*PSORXIEN") D  ; patient with a Clozapine presciption order
 . S:'$G(XMITRES(2)) XMITRES(2)=$$RDEO11^YSCLHLRD(.YSCLARR,$G(YSILENT))_U_"RDE"_U_DT
 ;
 I YSCLARR("*PSGORD") D  ; patient with a unit dose med order
 . S I=0
 . F  S I=$O(YSCLARR("*RPT",I)) Q:'I  D
 ..  S NODE=""  F  S NODE=$O(YSCLARR("*RPT",I,NODE)) Q:NODE=""  S YSCLARR(NODE)=YSCLARR("*RPT",I,NODE)
 ..  S:'$G(XMITRES(I+1)) XMITRES(I+1)=$$RDEO11^YSCLHLRD(.YSCLARR)_U_"RDE"_U_DT
 ;if all messages are sent set XMITRES("ALL") to 1 otherwise 0
 S XMITRES("ALL")=1 F I=1:1 Q:'$D(XMITRES(I))  S XMITRES("ALL")=+$G(XMITRES("ALL"))&+XMITRES(I)
 Q
 ;

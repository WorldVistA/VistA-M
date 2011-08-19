RMPRPF1 ;HOIFO/TH,DDA - PFSS Account Creation ;8/18/05
 ;;3.0;PROSTHETICS;**98**;Feb 09, 1996
 ;
 ; This routine collects PFSS Account Creation required data elements,
 ; sends pre-cert or update message to IBB; obtains and stores a PFSS
 ; Account Reference in file 660.
 ;
 ; DBIA #4664 for GETACCT^IBBAPI
 ; DBIA #1997 for STATCHK^ICPTAPIU
 Q
 ;
EN ; Entry Point
 S OK=1
 S RMPRSWDT=$P($$SWSTAT^IBBAPI(),"^",2)
 ; Quit if Entry Date is before PFSS Switch on date
 I $P(^RMPR(660,RMPRDA,0),"^")<RMPRSWDT D DELAPH Q
EN2 ; Entry to be used if Delivery Date is greater than PFSS Switch on date
 ; Quit if PFSS Charge ID exists
 I $P(^RMPR(660,RMPRDA,"PFSS"),U,2)'="" D DELAPH Q
 ; Quit if Historical Data
 I $P(^RMPR(660,RMPRDA,0),U,13)=13 D DELAPH Q
 ; Quit if Shipping Charge exists
 I $P(^RMPR(660,RMPRDA,0),U,17)>0 D DELAPH Q
 S RMPREVNT="A05"        ; Pre-cert 
 ; Check if PFSS Account Ref exists
 S OK=1
 I $P(^RMPR(660,RMPRDA,"PFSS"),U,1)'="" D
 . ; Quit if PSAS HCPCS did not get updated
 . I $P(^RMPR(660,RMPRDA,1),U,4)=$P(^RMPR(660,RMPRDA,"PFSS"),U,3) D DELAPH S OK=0 Q
 . S RMPREVNT="A08"      ; Update Patient Info
 I OK D
 . D GETDATA
 . D GETACCT
 . ; If msg was sent successfully, store data and kill x-ref
 . I RMPRARFN'=0 D
 . . D STORE
 . . D DELAPH
 D EXIT
 Q
 ;
GETDATA ; Get pre-cert data
 S (RMPRDFN,RMPRARFN,RMPRAPLR)=""
 S RMPRDFN=$P(^RMPR(660,RMPRDA,0),U,2)   ; Patient ID
 S RMPRAPLR="GETACCT;RMPRPF1"
 I RMPREVNT="A08",($P(^RMPR(660,RMPRDA,"PFSS"),U,1)'="") D
 . S RMPRARFN=$P(^RMPR(660,RMPRDA,"PFSS"),U,1)   ; Acct Ref
 ;
 ; PV1
 S RMPRPV1(2)="O"        ; Patient Class
 S RMPRSTA=$P(^RMPR(660,RMPRDA,0),U,10)
 D GETSITE
 S RMPRPV1(3)=RMPRHLOC   ; Patient Location
 S (RMPRORD,RMPRADDT)=""
 S RMPRORD=$P($G(^RMPR(660,RMPRDA,10)),U,6)
 S RMPRPV1(7)=RMPRORD    ; Attending Physician
 S RMPRADDT=$P(^RMPR(660,RMPRDA,0),U,1)
 S RMPRPV1(44)=RMPRADDT  ; Admit Date/Time
 ;
 ; PV2
 S RMPRPV2(8)=RMPRADDT   ; Expected Admit Date/Time
 S RMPREXDT=""
 S RMPREXDT=$P($G(^RMPR(660,RMPRDA,10)),U,1)
 S RMPRPV2(46)=$P(RMPREXDT,".",1) ; Patient Status Effective Date
 ;
 ; PR1
 S RMPRHCPC=$P(^RMPR(660,RMPRDA,1),U,4)    ; PSAS HCPCS
 S RMPRHCDT=RMPRADDT    ;Event date
 D PSASHCPC^RMPOPF    ;CSV check; return RMPRVHC and RMPRTHC.
 S RMPRPR1(3)=RMPRVHC    ; Procedure code
 S RMPRPR1(4)=RMPRTHC    ; PSAS HCPCS text
 ; Procedure Functional Type - I:Stock Issue; P:Purchasing
 S RMPRPR1(6)=$S($P(^RMPR(660,RMPRDA,0),U,13)=11:"I",1:"P")
 ;
 ; DG1 AND ZCL
 D DG1ZCL^RMPRPF2
 Q
 ;
GETSITE ; Get Patient Location
 ; requires RMPRSTA=file 4 pointer
 ; return RMPRHLOC= hospital location or NULL if there is none.
 S RMPRHLOC="",RMPRSIEN=""
 F  S RMPRSIEN=$O(^RMPR(669.9,"C",RMPRSTA,RMPRSIEN)) Q:RMPRSIEN'>0  D
 .S RMPRHLOC=$P(^RMPR(669.9,RMPRSIEN,"PCE"),U,3)
 .Q
 I RMPRHLOC="" D
 .S RMPRSIEN=0
 .F  S RMPRSIEN=$O(^RMPR(669.9,RMPRSIEN)) Q:(RMPRSIEN'>0)!(+RMPRHLOC)  D
 ..S RMPRHLOC=$P(^RMPR(669.9,RMPRSIEN,"PCE"),U,3)
 ..Q
 .Q
 Q
 ;
GETACCT ; Call GETACCT^IBBAPI to send data and get PFSS Account Reference
 S RMPRARFN=$$GETACCT^IBBAPI(RMPRDFN,RMPRARFN,RMPREVNT,RMPRAPLR,.RMPRPV1,.RMPRPV2,.RMPRPR1,.RMPRDG1,.RMPRZCL,"","")
 Q
 ;
STORE ; Store data
 S (RMPRQTY,RMPRTC)=""
 S RMPRQTY=$P(^RMPR(660,RMPRDA,0),U,7)   ; QTY
 S RMPRTC=$P(^RMPR(660,RMPRDA,0),U,16)    ; Total Cost
 ;
 L +^RMPR(660,RMPRDA)
 ; Store 100-PFSS Account Reference; 102-latest PSAS HCPCS; 103-latest QTY; 104-latest Total Cost; 
 ; 105-latest Ordering Provider
 S DIE="^RMPR(660,",DA=RMPRDA
 S DR="100////^S X=RMPRARFN;102////^S X=RMPRHCPC;"
 S DR=DR_"103////^S X=RMPRQTY;104////^S X=RMPRTC;105////^S X=RMPRORD"
 D ^DIE
 L -^RMPR(660,RMPRDA)
 K DA,DIE,DR
 Q
 ;
DELAPD ; Delete the "APD" Flag
 S DIE="^RMPR(660,"
 S DA=RMPRDA
 S DR="107///@"
 D ^DIE
 K DIE,DA,DR
 Q
 ;
DELAPH ; Delete the "APH" Flag
 S DIE="^RMPR(660,"
 S DA=RMPRDA
 S DR="106///@"
 D ^DIE
 K DIE,DA,DR
 Q
EXIT ; Exit
 K OK,RMPREVNT,RMPRARFN,RMPRDFN,RMPRAPLR,RMPRPR1,RMPRSTA
 K RMPRPV1,RMPRHLOC,RMPRORD,RMPRADDT,RMPRSIEN,RMPRHCPC
 K RMPRPV2,RMPREXDT,RMPRDG1,RMPRDIAG,RMPRRICP,RMRICPP
 K RMPRZCL,RMPRNODE,RMPRQTY,RMPRTC,RMPRCPT,RMPRSWDT
 Q

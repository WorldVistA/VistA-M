PSOORED7 ;ISC-BHAM/MFR-edit orders from backdoor con't ;03/06/95 10:24
 ;;7.0;OUTPATIENT PHARMACY;**148,247,281,289,358**;DEC 1997;Build 35
 ;called from psooredt. cmop edit checks.
 ;Reference to file #50 supported by IA 221
 ;Reference to $$ECMEON^BPSUTIL supported by IA 4410
 ;Reference to $$DIVNCPDP^BPSBUTL supported by IA 4719
 ;
NOCHG S CMRL=1 D CHK1^PSOORED2 I '$G(CMRL) W !,"No editing allowed of "_$S(FLN=9:"Day Supply",FLN=10:"Quantity",1:"# of Refills")_" (CMOP)." D PAUSE^VALM1 K CMRL Q
 K CMRL,DIC,DIQ
 S DIC=52,DA=PSORXED("IRXN"),DIQ="PSORXED" D EN^DIQ1 K DIC,DIQ
 S PSORXED($S(FLN=9:"DAYS SUPPLY",FLN=10:"QTY",1:"# OF REFILLS"))=PSORXED(52,DA,DR)
 D:'$O(PSORXED("DOSE",0)) DOLST^PSOORED3
 I FLN=9 D  Q
 .D DAYS^PSODIR1(.PSORXED) I $G(PSORXED("DFLG")) K PSORXED("FLD",8) Q
 .S PSORXED("FLD",8)=PSORXED("DAYS SUPPLY")
 I FLN=10 D  Q
 .D QTY^PSODIR1(.PSORXED) I $G(PSORXED("DFLG")) K PSORXED("FLD",7) Q
 .S:$G(PSORXED("QTY")) PSORXED("FLD",7)=PSORXED("QTY")
 I FLN=11 D  Q
 .S X=$G(PSORXED("PATIENT STATUS")) S:'X X=$P(RX0,"^",3)
 .S DIC=53,DIC(0)="QXZ" D ^DIC K DIC
 .S:+Y PSORXED("PTST NODE")=Y(0)
 .S:'$G(PSORXED("PATIENT STATUS")) PSORXED("PATIENT STATUS")=+Y
 .K X,Y
 .I $G(PSODRUG("IEN"))=$P(RX0,"^",6) K PSODRUG S X="`"_$P(RX0,"^",6),DIC=50,DIC(0)="QXZ" D ^DIC K PSOY S PSOY=Y,PSOY(0)=Y(0) D SET^PSODRG
 .S:'$G(PSORXED("DAYS SUPPLY")) PSORXED("DAYS SUPPLY")=$P(RX0,"^",8)
 .F I=0:0 S I=$O(^PSRX(PSORXED("IRXN"),1,I)) Q:'I  S RFTT=$G(RFTT)+1
 .D REFILL^PSODIR1(.PSORXED) K RFTT
 .I $G(PSORXED("DFLG")) K PSORXED("FLD",9) Q
 .I PSORXED("# OF REFILLS")=$P(RX0,"^",9) Q
 .S PSORXED("FLD",9)=PSORXED("# OF REFILLS")
 Q
VER ;checks for changes to dosing instructions
 S ENTS=0
 F I=0:0 S I=$O(PSORXED("DOSE",I)) Q:'I  S ENTS=$G(ENTS)+1
 I ENTS<OLENT!(ENTS>OLENT) S PSOSIGFL=1 Q
 F I=1:1:OLENT D:$D(^PSRX(PSORXED("IRXN"),6,I,0))
 .I $P(^PSRX(PSORXED("IRXN"),6,I,0),"^")'=PSORXED("DOSE",I) S PSOSIGFL=1
 .I $P(^PSRX(PSORXED("IRXN"),6,I,0),"^")=PSORXED("DOSE",I) D
 ..I $G(PSORXED("DOSE ORDERED",I)) S:PSORXED("DOSE ORDERED",I)'=$P(^PSRX(PSORXED("IRXN"),6,I,0),"^",2) PSOSIGFL=1
 .I $G(PSORXED("DURATION",I))]"" D
 ..S DURATION=$S($E($P(^PSRX(PSORXED("IRXN"),6,I,0),"^",5),1)'?.N:$E($P(^PSRX(PSORXED("IRXN"),6,I,0),"^",5),2,99)_$E($P(^PSRX(PSORXED("IRXN"),6,I,0),"^",5),1),1:$P(^PSRX(PSORXED("IRXN"),6,I,0),"^",5))
 ..I +DURATION'=+$G(PSORXED("DURATION",I)) S PSOSIGFL=1
 .I $P(^PSRX(PSORXED("IRXN"),6,I,0),"^",6)'=$G(PSORXED("CONJUNCTION",I)) S PSOSIGFL=1
 .I $P(^PSRX(PSORXED("IRXN"),6,I,0),"^",7)'=$G(PSORXED("ROUTE",I)) S PSOSIGFL=1
 .I $P(^PSRX(PSORXED("IRXN"),6,I,0),"^",8)'=PSORXED("SCHEDULE",I) S PSOSIGFL=1
 .I $G(^PSRX(PSORXED("IRXN"),6,I,1))'=$G(PSORXED("ODOSE",I)) S PSOSIGFL=1
 K DURATION
 Q
 ;
RESUB ; Resubmits 3rd party claim in case of an edit (Original)
 N CHANGED S CHANGED=$$CHANGED(PSORXED("IRXN"),.FLDS)
 I CHANGED D
 . N RX S RX=PSORXED("IRXN") Q:'RX
 . I $P(CHANGED,"^",2),'$$ECMEON^BPSUTIL($$RXSITE^PSOBPSUT(RX,0)) D  Q
 . . D REVERSE^PSOBPSU1(RX,0,"DC",99,"RX DIVISION CHANGED",1)
 . I $$SUBMIT^PSOBPSUT(RX,0,1,1) D
 . . I '$P(CHANGED,"^",2),$$STATUS^PSOBPSUT(RX,0)="" Q
 . . D ECMESND^PSOBPSU1(RX,0,,"ED",$$GETNDC^PSONDCUT(RX,0),,$S($P(CHANGED,"^",2):"RX DIVISION CHANGED",1:"RX EDITED"),,+$G(CHGNDC))
 . . ; Quit if there is an unresolved Tricare non-billable reject code, PSO*7*358
 . . I $$PSOET^PSOREJP3(RX,0) S X="Q" Q
 . . ;- Checking/Handling DUR/79 Rejects
 . . I $$FIND^PSOREJUT(RX,0) S X=$$HDLG^PSOREJU1(RX,0,"79,88","ED","IOQ","Q")
 Q
 ;
CHANGED(RX,PRIOR) ; - Check if fields have changed and should for 3rd Party Claim resubmission
 ;Input:  (r) RX    - Rx IEN
 ;        (r) PRIOR - Array with fields
 ;Output:  CHANGED  - 0 - Not changed / 1 - Original Rx field changed ^ Rx Division changed (1 - YES)
 N CHANGED,SAVED
 S CHANGED=0 D GETS^DIQ(52,RX_",","4;7;8;20;22;27;81","I","SAVED")
 F I=4,7,8,22,27,81 D  I CHANGED Q
 . I $G(PRIOR(52,RX_",",I,"I"))'=$G(SAVED(52,RX_",",I,"I")) S CHANGED=1 Q
 I $$DIVNCPDP^BPSBUTL(+$G(PRIOR(52,RX_",",20,"I")))'=$$DIVNCPDP^BPSBUTL(+$G(SAVED(52,RX_",",20,"I"))) S CHANGED="1^1"
 Q CHANGED
 ;;
NDCDAWDE(ST,FLN,RXN) ; allow edit of NDC & DAW for DC'd/expired ECME RXs
 ;;  input: (r) ST  - the Rx status code
 ;;         (r) FLN - field number selected for editing
 ;;         (r) RXN - prescription #
 ;; output: VALMSG for inappropriate field selection or use
 ;;         PSODRUG & RSORXED arrays updated if edited
 Q:$G(ST)=""!($G(FLN)="")!($G(RXN)="")
 I '((ST=11)!(ST=12)!(ST=14)!(ST=15)) S VALMSG=("Invalid selection!") Q
 I '((FLN=2)!(FLN=20)!(FLN=21)) S VALMSG=("Invalid selection!") Q
 I $$STATUS^PSOBPSUT(RXN,$$LSTRFL^PSOBPSU1(RXN))="" S VALMSG=("Invalid selection!") Q
 ;
 ; edit NDCs
 I FLN=2 D  Q
 .N NDC
 .S NDC=$$GETNDC^PSONDCUT(RXN,0)
 .D NDCEDT^PSONDCUT(RXN,"",$G(DRG),$G(PSOSITE),.NDC)
 .I $G(NDC)="^" Q
 .S (PSODRUG("NDC"),PSORXED("FLD",27))=NDC
 ;;
 ; edit refill NDCs/DAWs
 I FLN=20 D  Q
 .I $$LSTRFL^PSOBPSU1(RXN)=0 S VALMSG="Invalid selection!" Q
 .D REF^PSOORED2
 ;;
 ; edit DAW
 I FLN=21 D  Q
 .N DAW
 .D EDTDAW^PSODAWUT(RXN,0,.DAW)
 .I $G(DAW)="^" Q
 .S (PSODRUG("DAW"),PSORXED("FLD",81))=DAW
 Q
 ;;

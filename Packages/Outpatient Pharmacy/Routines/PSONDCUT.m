PSONDCUT ;BIRM/MFR - NDC Utilities ;10/15/04
 ;;7.0;OUTPATIENT PHARMACY;**148,287,317,289,385,364**;DEC 1997;Build 15
 ;Reference to $$ECMEON^BPSUTIL supported by DBIA 4410
 ;References to $$GETNDC^PSSNDCUT,$$NDCFMT^PSSNDCUT,SAVNDC^PSSNDCUT supported by IA 4707
 ;
CHGNDC(RX,RFL,BCODE,STOCK)   ; Prompt for NDC code during Rx Release for HIPAA/NCPDP project
 ;Input:  (r) RX     - Rx IEN (#52)
 ;        (o) RFL    - Refill Number (#52.1)
 ;        (o) BCODE  - Displays PID: 999-99-9999/MED: XXXXX XXXXXXXXXXX 999MG in the NDC prompt (1-YES/0-NO)
 ;        (o) STOCK  - Flag denoting that Stock NDC is being Validated
 ;        
 ;Output: (r) NDCCHG - NDC was changed? (1-YES/0-NO)^New NDC number 
 ;                     OR "^" if no valid NDC or "^" entered
 ;        
 N PSONDC,NEWNDC,SITE,NOREL,ACT,NDCVALID
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 S SITE=$$RXSITE^PSOBPSUT(RX,RFL) I '$$ECMEON^BPSUTIL(SITE) Q "^"  ; ECME is not turned ON for the Rx's Division
 ;
 ; - Retrieving Rx NDC and Fill Date
 S PSONDC=$$GETNDC(RX,RFL),NOREL=0
 ;
 ; - Display NDC validation status
 S NDCVALID=$$ISVALID^PSONDCV(RX,RFL,1)
 ;
 ; - Prompts for NDC number
 I $G(BCODE) F I=1:1:5 W $C(7)
 S NEWNDC=PSONDC D NDCEDT(RX,RFL,,SITE,.NEWNDC,$G(BCODE)) I NEWNDC="^"!(NEWNDC="") Q "^"
 ;
 I '$D(PSOTRIC) N PSOTRIC S PSOTRIC="",PSOTRIC=$$TRIC^PSOREJP1(RX,RFL,PSOTRIC)
 ; - If NDC changed, resubmit to ECME and save new NDC in the DRUG and PRESCRIPTION files
 I PSONDC'=NEWNDC D  Q:'NOREL ("1^"_NEWNDC)  Q:NOREL 2
 . D RXACT^PSOBPSU2(RX,RFL,"NDC changed from "_PSONDC_" to "_NEWNDC_" during release.","E")
 . D SAVNDC(RX,RFL,NEWNDC,0,1)
 . N RESP D ECMESND^PSOBPSU1(RX,RFL,,"ED",NEWNDC,,"RX RELEASE-NDC CHANGE",,1,,1)
 . I $D(RESP),$P(RESP,"^",4)["IN PROGRESS",PSOTRIC S NOREL=1 Q
 . I '$D(RESP),$$STATUS^PSOBPSUT(RX,RFL)["IN PROGRESS",PSOTRIC D
 . . S NOREL=1,ACT=$$ELIGDISP^PSOREJP1(RX,RFL)_"-NDC edit at REL: Not released due to 'IN PROGRESS' ECME status"
 . . D RXACT^PSOBPSU2(RX,RFL,ACT,"M",DUZ)
 Q 0
 ;
NDCEDT(RX,RFL,DRG,SITE,NDC,BCODE) ; Allows editing of the Rx NDC code
 ; Input: (r) RX    - Rx IEN (#52) 
 ;        (o) RFL   - Refill Number (#52.1)
 ;        (o) DRG   - Drug IEN (#50)
 ;        (o) NDC   - Default NDC Number/Return parameter ("" means no NDC selected)  (Note: REQUIRED for Output value)
 ;        (o) BCODE - Display the PID/Drug Name in the NDC prompt
 ;Output: (r) .NDC  - Selected NDC Number
 ;
 N SNDC,SYN,Y,Z,IDX,I,PID,DFN,DRGNAM,PRPT,DIR,DEFNDC
 K ^TMP($J,"PSONDCDP"),^TMP($J,"PSONDCFM")
 I '$G(DRG),$G(RX) S DRG=$$GET1^DIQ(52,RX,6,"I")
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 S IDX=0,SITE=+$G(SITE) I 'SITE,$G(RX) S SITE=$$RXSITE^PSOBPSUT(RX,RFL)
 ;
 ; - Setting the NDC currently on the PRESCRIPTION (passed in)
 I $G(NDC)'="",$$NDCFMT^PSSNDCUT(NDC)'="" S IDX=1,^TMP($J,"PSONDCFM",IDX)=NDC,^TMP($J,"PSONDCDP",NDC)=IDX
 ;
 ; - Retrieving NDC from the PRESCRIPTION file
 I $G(RX) D
 . S NDC=$$GETNDC(RX,RFL)
 . I NDC'="",'$D(^TMP($J,"PSONDCDP",NDC)) D
 . . S IDX=IDX+1,^TMP($J,"PSONDCFM",IDX)=NDC,^TMP($J,"PSONDCDP",NDC)=IDX
 ;
 ; - Retrieve Price Per Dispense Unit for default NDC
 S DEFNDC="",DEFNDC=$$NDCFMT^PSSNDCUT($$GET1^DIQ(50,DRG,31))
 ;
 S:'IDX IDX=1
 ;
 ; - Retrieving NDC from the DRUG/NDF files
 S NDC=$$GETNDC^PSSNDCUT(DRG)
 I NDC'="",'$D(^TMP($J,"PSONDCDP",NDC)) D
 . S IDX=IDX+1,^TMP($J,"PSONDCFM",IDX)=NDC,^TMP($J,"PSONDCDP",NDC)=IDX
 ; 
 ; - Retrieving NDC by OUTPATIENT SITE from the DRUG/NDF files
 S NDC=$$GETNDC^PSSNDCUT(DRG,SITE)
 I NDC'="",'$D(^TMP($J,"PSONDCDP",NDC)) D
 . S IDX=IDX+1,^TMP($J,"PSONDCFM",IDX)=NDC,^TMP($J,"PSONDCDP",NDC)=IDX
 ;
 ; - Retrieving NDCs and price per dispense unit from SYNONYMS
 S SYN=0
 F  S SYN=$O(^PSDRUG(DRG,1,SYN)) Q:SYN=""  D
 . S Z=$G(^PSDRUG(DRG,1,SYN,0)),SNDC=$$NDCFMT^PSSNDCUT($P(Z,"^",2)) I SNDC="" Q
 . I $D(^TMP($J,"PSONDCDP",SNDC)) Q
 . S IDX=IDX+1,^TMP($J,"PSONDCFM",IDX)=SNDC
 . S ^TMP($J,"PSONDCDP",SNDC)=IDX
 ;
 I '$D(^TMP($J,"PSONDCFM")) D  S NDC="^" G END
 . W !!,"No valid NDC codes found for "_$$GET1^DIQ(50,DRG,.01),$C(7)
 ;
ASK ; Ask for NDC
 S PRPT="",DRGNAM=$E($$GET1^DIQ(50,DRG,.01),1,25)
 I $G(BCODE) D
 . S DFN=$$GET1^DIQ(52,RX,2,"I") D DEM^VADPT S PID=$P(VADM(2),"^",2) K VADM
 . S PRPT="PID: "_PID_"/MED: "_DRGNAM_"/"
 K DIR S DIR(0)="FOA^1:15",DIR("A")=$S($G(STOCK):"PRODUCT NDC: ",1:PRPT_"NDC: "),DIR("B")=$G(^TMP($J,"PSONDCFM",1)) I DIR("B")="" K DIR("B")
 S DIR("?")="^D NDCHLP^PSONDCUT",DIR("??")="^D NDCHLP2^PSONDCUT" D ^DIR I $D(DIRUT) S NDC="^" G END
 I Y'?.N S NDC=Y I '$D(^TMP($J,"PSONDCDP",NDC)) W !,$C(7) D NDCHLP W !,$C(7) G ASK
 I Y?.N D  I NDC="" W !,$C(7) D NDCHLP2 W !,$C(7) G ASK
 . I $L(Y)=11 S NDC=$$NDCFMT^PSSNDCUT(Y) D  Q
 . . S:NDC'="" NDC=$S($D(^TMP($J,"PSONDCDP",NDC)):NDC,1:"")
 . S NDC=$G(^TMP($J,"PSONDCFM",+Y))
 W " ",NDC
 ;
END K ^TMP($J,"PSONDCDP"),^TMP($J,"PSONDCFM")
 Q
 ;
SAVNDC(RX,RFL,NDC,CMP,DRG,FROM) ; Saves the NDC in the PRESCRIPTION and DRUG files
 ; Input: (r) RX - Rx IEN (#52)
 ;        (o) RFL - Refill Number (#52.1)
 ;        (r) NDC - NDC Number
 ;        (o) CMP - CMOP? (1-YES/0-NO)
 ;        (o) DRG - Save in the DRUG file (1-YES/0-NO) ((Def: 0)
 ;        (o) FROM   - Calling function
 ;
 S NDC=$$NDCFMT^PSSNDCUT(NDC) I NDC="" Q
 ;
 ;- Saving the NDC in the PRESCRIPTION file (#52)
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 ;
 I '$D(FROM) N FROM S FROM=""
 N PPDU S PPDU="",PPDU=$$GPPDU(RX,RFL,NDC,,1,FROM)
 ;
 N DA,DIE,DR
 I 'RFL S DIE="^PSRX(",DA=RX,DR="27///"_NDC D ^DIE
 I RFL,$D(^PSRX(RX,1,RFL,0)) D
 . S DIE="^PSRX("_RX_",1,",DA(1)=RX,DA=RFL,DR="11///"_NDC D ^DIE
 ;
 ;- Saving the NDC in the DRUG file (#50) only if drug is e-payable
 I $G(DRG)&($$STATUS^PSOBPSUT(RX,RFL)="E PAYABLE") D SAVNDC^PSSNDCUT($$GET1^DIQ(52,RX,6,"I"),$$RXSITE^PSOBPSUT(RX,RFL),NDC,$G(CMP))
 Q
 ;
GETNDC(RX,RFL) ; Returns the Rx NDC #
 ; Input:  (r) RX - Rx IEN (#52)
 ;         (o) RFL - Refill #
 ; Output:     NDC - Rx NDC #
 N NDC,I S NDC=""
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 I RFL S NDC=$$GET1^DIQ(52.1,RFL_","_RX,11)
 I 'RFL!(NDC="") S NDC=$$GET1^DIQ(52,RX,27)
 Q $$NDCFMT^PSSNDCUT(NDC)
 ;
GPPDU(RX,RFL,NDC,DRUG,SAVE,FROM) ;-get Price per dispense unit for the NDC
 ;Input:  (r) RX     - Rx IEN (#52)
 ;        (o) RFL    - Refill Number (#52.1)
 ;        (r) NDC    - National Drug Code
 ;        (o) DRUG   - Drug IEN from (#50)
 ;        (o) SAVE   - 1 (one) means save the PPDU and 0 (zero) means don't save it
 ;        (o) FROM   - Calling function
 ;        
 ;Output: (r) PPDU   - Price Per Dispense Unit for the NDC on the drug in file (#50)  
 ;                     OR "^" if no valid NDC or "^" entered
 ;
 N SYN,Z,SNDC,DEFNDC,PPDUARR,DEFPPDU,CMOP
 I '$G(DRUG) N DRUG S DRUG="",DRUG=$$GET1^DIQ(52,RX,6,"I")
 I '$D(RFL) S RFL="",RFL=$$LSTRFL^PSOBPSU1(RX)
 I '$G(SAVE) S SAVE=0
 S DEFNDC=$$NDCFMT^PSSNDCUT($$GET1^DIQ(50,DRUG,31))
 S (DEFPPDU,PPDU)=$$GET1^DIQ(50,DRUG,16)
 S:DEFNDC'="" PPDUARR(DEFNDC)=PPDU
 S SYN=0
 ;
 F  S SYN=$O(^PSDRUG(DRUG,1,SYN)) Q:SYN=""  D
 . S Z=$G(^PSDRUG(DRUG,1,SYN,0)),SNDC=$$NDCFMT^PSSNDCUT($P(Z,"^",2)) I SNDC="" Q
 . S:$P(Z,"^",8)'="" PPDUARR(SNDC)=$P(Z,"^",8)
 I $G(NDC),$D(PPDUARR(NDC)) S PPDU=$G(PPDUARR(NDC))
 I $$MWC^PSOBPSU2(RX,RFL)="C" D
 . I $D(FROM) Q:FROM="PE"!(FROM="PP")  ;if FROM passed, pull early from suspense gets price by NDC
 . S PPDU=DEFPPDU ;use default NDC for CMOP fills
 I SAVE&(PPDU'="") D SPPDU(RX,RFL,PPDU)
 Q PPDU
 ;
SPPDU(RX,RFL,PPDU) ;save price per dispense unit
 N DIE,DA,DR
 I 'RFL S DIE="^PSRX(",DA=RX,DR="17///"_PPDU D ^DIE
 I RFL,$D(^PSRX(RX,1,RFL,0)) D
 . S DIE="^PSRX("_RX_",1,",DA(1)=RX,DA=RFL,DR="1.2///"_PPDU D ^DIE
 Q
 ;
NDCHLP2 ;Help Text for ?? for the NDC Code Selection
 I X["?" D
 .W !!,"Enter a valid "_$S($G(STOCK):"Product ",1:"")_"NDC.  Valid NDC's are those defined for the drug in"
 .W !,"Drug file (#50) as an NDC of a synonym or the default NDC."
 I $G(STOCK)&(X["?") D
 . W !!,"If the Product is not listed below, the NDC must be entered as a synonym for"
 . W !,"the drug before NDC validation of the prescription may be completed.",!
 ;
NDCHLP ; Help Text for the NDC Code Selection
 N I
 I $G(STOCK)&(X'["?") D  ;help text for NDC Validation option
 . W !,"The NDC # entered is either invalid or there is not a matching synonym"
 . W !,"for NDC "_$S($G(Y):Y,1:DIR("B"))_" defined for "_DRGNAM_" in the"
 . W !,"drug file. Please verify that you have selected the correct product.",!
 . W !,"If the product is correct, the NDC must be entered as a synonym for"
 . W !,"the drug before NDC validation of the prescription may be completed.",!
 W !,"Select one of the following valid NDC code(s) below "_$S($G(STOCK):"or enter ^ to exit",1:"")_": ",!
 S I=0 F  S I=$O(^TMP($J,"PSONDCFM",I)) Q:'I  D
 . W !?10,$J(I,2)," - ",^TMP($J,"PSONDCFM",I)
 Q

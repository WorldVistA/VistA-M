PSODAWUT ;BIRM/MFR - BPS (ECME) - DAW Utilities ;10/15/04
 ;;7.0;OUTPATIENT PHARMACY;**148,260**;DEC 1997;Build 84
 ;Reference to $$DAWEXT^PSSDAWUT supported by IA 4708
 ;
GETDAW(RX,RFL) ; Returns the DAW code for a specific Prescription/Fill
 ;Input: (r) RX  - Rx IEN (#52)
 ;       (o) RFL - Refill #  (Default: most recent)
 ;
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 ;
 I 'RFL Q +$$GET1^DIQ(52,RX,81)
 Q +$$GET1^DIQ(52.1,RFL_","_RX,81)
 ;
SAVDAW(RX,RFL,DAW) ; - Saves the DAW code for a specific Prescription/Fill
 ;Input: (r) RX  - Rx IEN (#52)
 ;       (o) RFL - Refill #  (Default: most recent)
 ;
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 ;
 I $$GETDAW(RX,RFL)'=DAW D
 . D RXACT^PSOBPSU2(RX,RFL,"DAW CODE changed from "_$$GETDAW(RX,RFL)_" to "_DAW_".","E")
 ;
 N DIE,DA,DR
 S DR="81///"_+DAW
 I 'RFL S DA=RX,DIE="^PSRX(" D ^DIE
 I RFL,$D(^PSRX(RX,1,RFL,0)) S DIE="^PSRX("_RX_",1,",DA(1)=RX,DA=RFL D ^DIE
 Q
 ;
EDTDAW(RX,RFL,DAW) ; - Edits the DAW code for a specific Prescription/Fill W/OUT SAVING IT
 ;Input: (r) RX  - Rx IEN (#52)
 ;       (o) RFL - Refill #  (Default: most recent)
 ;       (o) DAW - Default DAW code (Default: from Rx file)
 ;Output: $$EDTDAW - DAW code selected or "^" (up arrow) 
 ;       
 N DIR,Y,DA
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 ;
 I '$D(DAW) S DAW=$$GETDAW(RX,RFL)
 ;
 I $$STATUS^PSOBPSUT(RX,RFL)="" Q
 ;
 S DIR(0)="52,81",DIR("B")=DAW D ^DIR I $D(DIRUT) S DAW="^" Q
 S DAW=Y W " - ",$$DAWEXT^PSSDAWUT(DAW)
 Q

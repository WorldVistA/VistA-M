PSOSPMU2 ;BIRM/MFR - State Prescription Monitoring Program Utility #2 - Prompts ;10/07/15
 ;;7.0;OUTPATIENT PHARMACY;**451,625**;DEC 1997;Build 42
 ;
ASAPVER(DEFTYPE,REGZERO,DSPHLP,DEFAULT,REQUIRED,ALLOWDEL) ; Prompt for the ASAP Version
 ; Input: (r) DEFTYPE - ASAP Definition Type (S: Standard Only; C: Customized Only, F: Fully Customized Only,
 ;                      A: All. A combination is also allowed, e.g., "CF") 
 ;        (r) REGZERO - Regular or Zero Report or Both ASAP Definitions (R: Regular Only; Z: Zero Report Only; 
 ;                      B: Both) ;adding new parameter for Zero Report
 ;        (o) DSPHLP   - Display Help before prompting? (1: YES / 0: NO)
 ;        (o) DEFAULT  - Default ASAP Version
 ;        (o) REQUIRED - Is Answer Required? (1: YES / 0: NO)
 ;        (o) ALLOWDEL - Allow delete? (accepts "@" as a valid input)
 ;Output: ASAPVER - ASAP Version, "^", "@" or "" 
 N DIR,X,Y,DTOUT,DIRUT,VERLST
 ;
ASK1 ; Label used in case the prompt needs to be asked again
 D VERLIST^PSOSPMU0(DEFTYPE,REGZERO,.VERLST)    ;Zero Report adding REGZERO
 ;K DIR S DIR(0)="FO^1:10",DIR("A")="ASAP VERSION" S:$G(DEFAULT)'="" DIR("B")=DEFAULT   ;Zero Report
 I REGZERO'["Z" D
 . K DIR S DIR(0)="FO^1:10",DIR("A")="ASAP VERSION" S:$G(DEFAULT)'="" DIR("B")=DEFAULT
 E  D
 . K DIR S DIR(0)="FO^1:10",DIR("A")="ZERO REPORT ASAP VERSION" S:$G(DEFAULT)'="" DIR("B")=DEFAULT
 ;
 S DIR("?")="^D HLP1^PSOSPMU2(.VERLST)" I $G(DSPHLP) D HLP1^PSOSPMU2(.VERLST)
 D ^DIR
 I '$G(REQUIRED),X="" Q X
 I $G(ALLOWDEL),X="@" Q X
 I $G(REQUIRED),(X=""!(X="@")) W !,"This is a required response. Enter '^' to exit",$C(7),! G ASK1
 I $D(DIRUT)!$D(DTOUT) Q "^"
 I '$D(VERLST(X_" ")) W ?40,"Invalid ASAP Version",$C(7),! G ASK1
 Q X
 ;
HLP1(VERLST) ; Help Text for ASAP Version prompt and Zero Report ASAP Version prompt
 ;Input: (r) VERLST  - Array containing a list ASAP versions
 N VER,HLPLN
 I REGZERO["Z" D  Q    ;start Zero Report ASAP display
 . W !?5,"American Society for Automation in Pharmacy (ASAP) Version for Zero"
 . W !?5,"Reporting to the State (no prescription fills to report). Leave blank"
 . W !?5,"if the state does not require Zero Reporting."
 . W !!?5,"Select one of the following:"
 . W !
 . S VER="" F  S VER=$O(VERLST(VER)) Q:VER=""  D
 . . S HLPLN="",$E(HLPLN,11)=VER,$E(HLPLN,22)="ASAP Version "_$E(VER,1,$L(VER)-1)_$S(VERLST(VER)="FZ":"*",1:"")_" (Zero Report)"
 . . W !,HLPLN
 . W !
 ;
 W !?5,"American Society for Automation in Pharmacy (ASAP) Version"
 W !!?5,"Select one of the following:"
 W !
 S VER="" F  S VER=$O(VERLST(VER)) Q:VER=""  D
 . S HLPLN="",$E(HLPLN,11)=VER,$E(HLPLN,22)="ASAP Version "_$E(VER,1,$L(VER)-1)_$S(VERLST(VER)="F":"*",1:"")
 . I VERLST(VER)["FZ" S HLPLN="",$E(HLPLN,11)=VER,$E(HLPLN,22)="ASAP Version "_$E(VER,1,$L(VER)-1)_"*"_" (Zero Report)"
 . I VERLST(VER)["SZ" S HLPLN=HLPLN_" (Zero Report)"    ;adding Zero Report display
 . W !,HLPLN
 W !
 Q
 ;
RXFILL(RXIEN) ; Select Prescription Fill #
 ;Input: (r) RXIEN  - Pointer to the PRESCRIPTION file (#52)
 N RXFILL,DIR,I,Y,DIRUT,DTOUT,FILLARR,RTSFILL,RTSFLDT
 S RXFILL=0,FILLARR(0)=""
 K DIR S DIR("A")=" Fill",DIR("B")=0
 S DIR(0)="S^0:Original  ("_$$FMTE^XLFDT($$RXFLDT^PSOBPSUT(RXIEN,0),2)_")  "_$$MWA(RXIEN,0)
 F I=1:1 Q:'$D(^PSRX(RXIEN,1,I))  D
 . S DIR(0)=DIR(0)_";"_I_":Refill "_I_"  ("_$$FMTE^XLFDT($$RXFLDT^PSOBPSUT(RXIEN,I),2)_")  "_$$MWA(RXIEN,I),FILLARR(I)=""
 F I=1:1 Q:'$D(^PSRX(RXIEN,"P",I))  D
 . S DIR(0)=DIR(0)_";P"_I_":Partial "_I_" ("_$$FMTE^XLFDT($$RXFLDT^PSOBPSUT(RXIEN,"P"_I),2)_")  "_$$MWA(RXIEN,"P"_I),FILLARR("P"_I)=""
 F I=1:1 Q:'$D(^PSRX(RXIEN,"RTS",I))  D
 . S RTSFILL=$P(^PSRX(RXIEN,"RTS",I,0),"^",2) Q:RTSFILL=""  I $D(FILLARR(RTSFILL)) Q
 . S RTSFLDT=$P(^PSRX(RXIEN,"RTS",I,0),"^",3)
 . S FILLARR(RTSFILL)=""
 . S DIR(0)=DIR(0)_";"_RTSFILL_":"_$S(RTSFILL["P":"Partial "_$E(RTSFILL,2,9),1:"Refill "_RTSFILL)_"  ("_$$FMTE^XLFDT(RTSFLDT,2)_") "_$$MWA(RXIEN,RTSFILL)
 D ^DIR I $D(DIRUT)!$D(DTOUT) Q "^"
 S RXFILL=$G(Y)
 Q RXFILL
 ;
MWA(RXIEN,FILL) ; Returns the Rx delivering (WINDOW/MAIL/ADMIN IN CLINIC)
 ;Input: (r) RXIEN - Pointer to the PRESCRIPTION file (#52)
 ;       (r) FILL  - Rx Fill # (0:Original, 1:Refill #1,...,"P1":Partial #1, etc....)
 I FILL["P" Q $$GET1^DIQ(52.2,$E(FILL,2,3)_","_RXIEN,.02)
 I FILL Q:$$GET1^DIQ(52.1,FILL_","_RXIEN,23,"I") "ADMIN IN CLINIC" Q $$GET1^DIQ(52.1,FILL_","_RXIEN,2)
 Q:$$GET1^DIQ(52,RXIEN,14,"I") "ADMIN IN CLINIC"
 Q $$GET1^DIQ(52,RXIEN,11)
 ;
ASAPHELP(AVER,ASEG,AFLD) ; SPMP Help Text
 ; Retrieve ASAP text definition/description from SPMP ASAP RECORD DEFINITION file (#58.4)
 ; INPUT:   AVER  = ASAP Version
 ;          ASEG  = ASAP Segment
 ;          AFLD  = ASAP Field
 ;
 N ASAP,LN
 Q:$G(AVER)=""!($G(ASEG)="")!($G(AFLD)="")
 D LOADASAP^PSOSPMU0(AVER,"B",.ASAP)
 S LN=0 F  S LN=$O(ASAP(ASEG,AFLD,"DES",LN)) Q:'LN  D
 .N TXT S TXT=$$UP^XLFSTR($G(ASAP(ASEG,AFLD,"DES",LN)))
 .W ! I $E(TXT,1,3)="  0" W $S(TXT["NEW":"  N -",TXT["CHANGE":"  R -",TXT["CANCEL":"  V -",TXT]"VOID":"  V",1:"     ")
 .W ASAP(ASEG,AFLD,"DES",LN)
 Q

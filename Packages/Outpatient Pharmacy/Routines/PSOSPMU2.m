PSOSPMU2 ;BIRM/MFR - State Prescription Monitoring Program Utility #2 - Prompts ;10/07/15
 ;;7.0;OUTPATIENT PHARMACY;**451,625,772,797**;DEC 1997;Build 7
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
 . . I $$VERSIONLOCKED^PSOSPMU0($E(VER,1,$L(VER)-1)) S HLPLN=HLPLN_" << Locked >> "  ;pso*7*772
 . . W !,HLPLN
 . W !
 ;
 W !?5,"American Society for Automation in Pharmacy (ASAP) Version"
 W !!?5,"Select one of the following:"
 W !
 S VER="" F  S VER=$O(VERLST(VER)) Q:VER=""  D
 . N CLONE S CLONE=$G(VERLST(VER,"CLONE"))   ; Standard Clone PSO*7*772
 . S HLPLN="",$E(HLPLN,11)=VER,$E(HLPLN,22)="ASAP Version "_$E(VER,1,$L(VER)-1)_$S(VERLST(VER)="F":"*",$G(CLONE):"*",1:"")   ; PSO*7*772
 . I VERLST(VER)["FZ" S HLPLN="",$E(HLPLN,11)=VER,$E(HLPLN,22)="ASAP Version "_$E(VER,1,$L(VER)-1)_"*"_" (Zero Report)"
 . I REGZERO["Z" S HLPLN=HLPLN_"*"
 . I VERLST(VER)["SZ" S HLPLN=HLPLN_" (Zero Report)"    ;adding Zero Report display
 . I $$VERSIONLOCKED^PSOSPMU0($E(VER,1,$L(VER)-1)) S HLPLN=HLPLN_" << Locked >> "  ;pso*7*772
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
 ;
CUSTDEL(PSOASVER,SEGID,ELMPOS,ELMDATA,RETURN) ; Define elements for 'custom standard' ASAP version - PSO*7*772
 ; PSOASVER - ASAP Version to be udpated
 ; ELMDATA - Input string containing updated elements
 ; RETURN - Destination array containing updated elements
 ;
 I $$CLONE^PSOSPML3(PSOASVER) D
 . I $L($P(ELMDATA,"^",2)) S $P(RETURN(SEGID,ELMPOS),"^",2)=$P(ELMDATA,"^",2)
 . I $L($P(ELMDATA,"^",3)) S $P(RETURN(SEGID,ELMPOS),"^",3)=$P(ELMDATA,"^",3)
 . I $L($P(ELMDATA,"^",5)) S $P(RETURN(SEGID,ELMPOS),"^",5)=$P(ELMDATA,"^",5)
 . I $D(ELMDATA("DES",1)) M RETURN(SEGID,ELMPOS,"DES")=ELMDATA("DES")
 ; PSO*7*772
 Q
 ;
STDSEGCU(PSOASVER,STDASAP,CUSASAP,ALLASAP,CUSSEG) ; Customize Standard Segment - 772
 ; PSOASVER  - ASAP Version
 ; STDASAP   - Array of only Standard ASAP components related to PSOASVER
 ; CUSASAP   - Array of only Custom ASAP components related to PSOASVER
 ; ALLASAP   - Array of combined Standard and Custom components related to PSOASVER
 ; CUSSEG    - Segment being worked on
 ;
 N TMPASAP,SEGNMCUS,SEGNM,DONE,NEWSEG,OK,QUIT,SEG
 S (Y,NEWSEG)=0
 S $P(TMPASAP(CUSSEG),"^",1)=CUSSEG
 ; Segment Name
 S SEGNM="",SEGNMCUS=$P($G(CUSASAP(CUSSEG)),"^",2) I $L(SEGNMCUS) S SEGNM=SEGNMCUS
 I SEGNM="" S SEGNM=$P($G(STDASAP(CUSSEG)),"^",2)
 S X=$$ASKFLD^PSOSPMA3("58.40011,.02",SEGNM) I X="^" Q
 S $P(TMPASAP(CUSSEG),"^",2)=X
 ;
 ; Parent Segment
 S DONE=0
 N SEGPARCUS,SEGPAR S SEGPAR=""
 S SEGPARCUS=$P($G(CUSASAP(CUSSEG)),"^",3) I $L(SEGPARCUS) S SEGPAR=SEGPARCUS
 I SEGPAR="" S SEGPAR=$P($G(STDASAP(CUSSEG)),"^",3)
 F  S X=$$ASKFLD^PSOSPMA3("58.40011,.03",SEGPAR) Q:X="^"!(X="")  D  I DONE Q
 . I X="@" S SEGPAR="",$P(TMPASAP(CUSSEG),"^",3)="" Q
 . I '$D(ALLASAP(X)),$D(ALLASAP($$UP^XLFSTR(X))) S X=$$UP^XLFSTR(X)
 . I '$D(ALLASAP(X))!$G(X) W !,"Parent Segment ID not found.",$C(7) Q
 . I X=CUSSEG W !,"Parent Segment ID cannot be its own parent.",$C(7) Q
 . W "   ",$P(ALLASAP(X),"^",2)
 . S $P(TMPASAP(CUSSEG),"^",3)=X,SEGPAR=X,DONE=1
 I X="^" Q
 ;
 ; Segment Requirement
 N SEGREQCUS,SEGREQ S SEGREQ=""
 S SEGREQCUS=$P($G(CUSASAP(CUSSEG)),"^",4) I $L(SEGREQCUS) S SEGREQ=SEGREQCUS
 I SEGREQ="" S SEGREQ=$P($G(STDASAP(CUSSEG)),"^",4)
 S X=$$ASKFLD^PSOSPMA3("58.40011,.04",SEGREQ) I X="^" Q
 S $P(TMPASAP(CUSSEG),"^",4)=X,SEGREQ=X
 S DONE=0
 ; 
 ; Segment Position
 N SEGPOSCUS,SEGPOS S SEGPOS=""
 S SEGPOSCUS=$P($G(ALLASAP(CUSSEG)),"^",5) I $L(SEGPOSCUS) S SEGPOS=SEGPOSCUS
 I SEGPOS="" S SEGPOS=$P($G(ALLASAP(CUSSEG)),"^",5)
 F  S X=$$ASKFLD^PSOSPMA3("58.40011,.05",SEGPOS) Q:X="^"  D  I DONE Q
 . S SEG="999",OK=1 F  S SEG=$O(ALLASAP(SEG)) Q:SEG=""  D  I 'OK Q
 . . I (SEG'=CUSSEG),($P(ALLASAP(SEG),"^",3)=$P($G(TMPASAP(CUSSEG)),"^",3)),($P(ALLASAP(SEG),"^",5)=X) D
 . . . S OK=0 W !,"The Segment '",SEG,"' (",$P(ALLASAP(SEG),"^",2),") already occupies this position.",$C(7) Q
 . I OK S $P(TMPASAP(CUSSEG),"^",5)=X,DONE=1
 I X="^" Q
 ;
 ; Segment Level
 S DONE=0
 N SEGLEVCUS,SEGLEV S SEGLEV=""
 S SEGLEVCUS=$P($G(ALLASAP(CUSSEG)),"^",6) I $L(SEGLEVCUS) S SEGLEV=SEGLEVCUS
 I SEGLEV="" S SEGLEV=$P($G(CUSASAP(CUSSEG)),"^",6)
 ;
 I SEGPAR'="",($P($G(CUSASAP(CUSSEG)),"^",6)=""),($P($G(ALLASAP(SEGPAR)),"^",6)>3) D
 . S $P(TMPASAP(CUSSEG),"^",6)=$P($G(ALLASAP(SEGPAR)),"^",6)
 F  S X=$$ASKFLD^PSOSPMA3("58.40011,.06",SEGLEV) Q:X="^"  D  I DONE Q
 . I (($P($G(CUSASAP(CUSSEG)),"^",3)="")&$P($G(ALLASAP(CUSSEG)),"^",3)=""),(X'=1),(X'=6)  D  Q
 . . W !,"Orphan segments can only be located at the MAIN HEADER or MAIN TRAILER levels.",$C(7)
 . S QUIT=0
 . I SEGPAR'="" D  I QUIT Q
 . . I $P($G(ALLASAP(SEGPAR)),"^",6)>3,X'=$P($G(ALLASAP(SEGPAR)),"^",6) D  S QUIT=1 Q
 . . . W !,"Segment level must be the same as the parent's level (",$P($G(ALLASAP(SEGPAR)),"^",6),").",$C(7)
 . . I X<$P($G(ALLASAP(SEGPAR)),"^",6) D  S QUIT=1 Q
 . . . W !,"Segment level cannot be lower than parent's level (",$P($G(ALLASAP(SEGPAR)),"^",6),").",$C(7)
 . . I X>($P($G(ALLASAP(SEGPAR)),"^",6)+1) D  S QUIT=1 Q
 . . . W !,"Segment level cannot be more than 1 level above parent's level (",$P($G(ALLASAP(SEGPAR)),"^",6),").",$C(7)
 . S $P(TMPASAP(CUSSEG),"^",6)=X,DONE=1
  I X="^" Q
 ;
 ; Has anything changed? If not, quit, don't save
 I $G(TMPASAP(CUSSEG))=$G(ALLASAP(CUSSEG)) D  Q
 . W !!?5,"** No changes made, nothing saved. **"
 ; 
 ; Confirm
 W ! S X=$$ASKFLD^PSOSPMA3("Y","YES","Save Custom Segment") I X'=1 Q
 W ?40,"Saving..."
 ; If first time the Segment is being customized, copy; otherwise save
 I '$D(CUSASAP(CUSSEG)) D
 . S STDASAP(CUSSEG)=TMPASAP(CUSSEG)
 . D COPYSEG^PSOSPMU3(PSOASVER,.STDASAP,PSOASVER,CUSSEG)
 E  D
 . D SAVESEG^PSOSPMU3(PSOASVER,CUSSEG,TMPASAP(CUSSEG),ALLASAP)
 . ; If the segment been modified back to its original values AND there are no customized data elements in the segment, remove the segment from ,2 node of 58.4
 . I ($G(TMPASAP(CUSSEG))=$G(STDASAP(CUSSEG))),'$O(CUSASAP(CUSSEG,0)) D DELCUS^PSOSPMU3(PSOASVER,CUSSEG)
 W "OK",$C(7)
 Q

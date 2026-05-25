PSOERUT6 ;ALB/MFR - eRx & Pending Order Side-by-Side LM Display - Cont'd; 06/25/2023 5:14pm
 ;;7.0;OUTPATIENT PHARMACY;**700,746,769,770**;DEC 1997;Build 145
 ;
EN ; Continuation of PSOERUT5 due to routine size limit
 ;
 ; - Provider
 S XE="Provider: "_$$COMPARE^PSOERUT0("LM",$E(ERXPRVNM,1,29),PENDATA("PROVIDER NAME"),11)
 S XV="|"_$S('RENEWORD:"13) ",1:"6) ")_"Provider: "_$$COMPARE^PSOERUT0("LM",$E(PENDATA("PROVIDER NAME"),1,26),ERXPRVNM,$S('RENEWORD:55,1:54))
 S UNDERLN(LINE,41)=$S('RENEWORD:3,1:2)
 D ADDLINE^PSOERUT0("LM",NMSPC,XE,XV)
 S PRVIEN=$S($G(PENDATA("PROVIDER")):PENDATA("PROVIDER"),1:$$GET1^DIQ(52.41,ORDIEN,5,"I"))
 I $G(PKI),+$G(DRUGDATA("DEA"))>1,+$G(DRUGDATA("DEA"))<6 D
 . D CSPRV^PSOERUT4(PRVIEN,+VADRGIEN,$$GET1^DIQ(52.41,ORDIEN,.01,"I"))
 I $$GET1^DIQ(200,PRVIEN,53.7,"I"),$$GET1^DIQ(200,PRVIEN,53.8,"I") D
 . S XV="|Cos-Provider: "_$$COMPARE^PSOERUT0("LM",$$GET1^DIQ(200,PRVIEN,53.8),$$GET1^DIQ(200,PRVIEN,53.8),55)
 . D ADDLINE^PSOERUT0("LM",NMSPC,"",XV)
 D BLANKLN^PSOERUT0("LM")
 ;
 ; - Copies
 N COPIES
 S COPIES=$S($G(PENDATA("COPIES")):PENDATA("COPIES"),1:1)
 S XV="|"_$S('RENEWORD:"14) ",1:"7) ")_"Copies: "_$$COMPARE^PSOERUT0("LM",COPIES,COPIES,$S('RENEWORD:53,1:52))
 S UNDERLN(LINE,41)=$S('RENEWORD:3,1:2)
 D ADDLINE^PSOERUT0("LM",NMSPC,"",XV)
 D BLANKLN^PSOERUT0("LM")
 ;
 ; - Remarks
 S XV="|"_$S('RENEWORD:"15) ",1:"8) ")_"Remarks: "
 S UNDERLN(LINE,41)=$S('RENEWORD:3,1:2)
 D ADDLINE^PSOERUT0("LM",NMSPC,"",XV)
 K VARR D WRAP^PSOERUT($G(PSONEW("REMARKS")),38,.VARR)
 F I=1:1 Q:'$D(VARR(I))  D
 . I $G(VARR(I,0))="" Q
 . D ADDLINE^PSOERUT0("LM",NMSPC,"","| "_$$COMPARE^PSOERUT0("LM",VARR(I,0),VARR(I,0),42))
 D BLANKLN^PSOERUT0("LM")
 ; - Diagnostics
 D SETDIAGS^PSOERUT3("LM",NMSPC,ERXIEN,"PEN")
 D BLANKLN^PSOERUT0("LM",0)
 ;
 ; - DEA compliance note for eRx CS prescriptions
 I $$GET1^DIQ(52.49,ERXIEN,95.1,"I"),$$CS^PSOERXA0(VADRGIEN) D
 . D BLANKLN^PSOERUT0("LM",1)
 . S XE=" This prescription meets the requirements of the Drug Enforcement Administration"
 . D ADDLINE^PSOERUT0("LM",NMSPC,$$COMPARE^PSOERUT0("LM",XE,XE,2))
 . S XE=" (DEA) electronic prescribing for controlled substances rules (21 CFR Parts"
 . D ADDLINE^PSOERUT0("LM",NMSPC,$$COMPARE^PSOERUT0("LM",XE,XE,2))
 . S XE=" 1300, 1304, 1306, & 1311)."
 . D ADDLINE^PSOERUT0("LM",NMSPC,$$COMPARE^PSOERUT0("LM",XE,XE,2))
 . D BLANKLN^PSOERUT0("LM",1)
 ;
 ; - Entry Accepted by/date/time
 S ACCDTBY=$$ACCDTBY^PSOERUT4(ERXIEN)
 S XX=" eRx Received on "_$P($$FMTE^XLFDT($$GET1^DIQ(52.49,ERXIEN,.03,"I"),"2Y"),":",1,2)
 S XX=XX_" | Accepted by "_$E($P(ACCDTBY,"^",2),1,17)_" on "_$P($P(ACCDTBY,"^",1),":",1,2)
 S XX=$E(XX,1,80),XE="",$E(XE,(80-$L(XX))\2+1)=XX
 D ADDLINE^PSOERUT0("LM",NMSPC,$$COMPARE^PSOERUT0("LM",XE,XE,2))
 Q
 ;
VISTAPAT(ERXIEN) ; Returns the VistA Patient For Responses that pass through the eRx Holding Queue w/out matching/validation
 ; Input: ERXIEN   - Pointer to the ERX HOLDING QUEUE (#52.49)
 ;Output: VISTAPAT - Pointer to the PATIENT file (#2) associated with the eRx
 N VISTAPAT,MTYPE,REQIEN,NEWRXIEN
 S VISTAPAT=+$$GET1^DIQ(52.49,ERXIEN,.05,"I")
 S MTYPE=$$GET1^DIQ(52.49,ERXIEN,.08,"I")
 I 'VISTAPAT,"RR,CA,"[MTYPE D
 . S NEWRXIEN=$$RESOLV^PSOERXU2(ERXIEN)
 . S VISTAPAT=+$$GET1^DIQ(52.49,NEWRXIEN,.05,"I")
 I 'VISTAPAT,"RE,CN,IE,"[MTYPE D
 . S REQIEN=$$RESOLV^PSOERXU2(ERXIEN) Q:'REQIEN
 . S VISTAPAT=+$$GET1^DIQ(52.49,REQIEN,.05,"I") I VISTAPAT Q
 . S NEWRXIEN=$$RESOLV^PSOERXU2(REQIEN)
 . S VISTAPAT=+$$GET1^DIQ(52.49,NEWRXIEN,.05,"I")
 Q VISTAPAT
 ;
CSERX(ORD) ; Check whether a Pending Order is for a CS eRx
 ; Input: ORD - Pointer to OUTPATIENT PENDING ORDER file (#52.41)
 I $$ERXIEN^PSOERXUT(ORD_"P"),$$CSDRG(+$$GET1^DIQ(52.41,+ORD,11,"I")) D  Q 1
 . S VALMSG="Only the 'Routing' field can be edited (CS eRx).",VALMBCK="R" W $C(7)
 Q 0
 ;
CSDRG(DRGIEN) ; Controlled Substance drug?
 ; Input: DRGIEN - Pointer to DRUG file (#50)
 ;Output: $$CS - 1:YES / 0:NO
 N DEA
 Q:'DRGIEN 0
 S DEA=$$GET1^DIQ(50,DRGIEN,3)
 I (DEA'["0"),(DEA'["M"),(DEA["2")!(DEA["3")!(DEA["4")!(DEA["5") Q 1
 Q 0
 ;
VS(ERXIEN,TYPE) ; View Suggestion(s)
 ;Input: ERXIEN - Pointer to ERX HOLDING QUEUE file (#52.49)
 ;       TYPE   - Type of Suggestion("PA": Patient;"PR": Provider;"DR": Drug)
 N ERXPAT,ERXPRV,DRUGHASH,ERX,VPRV,VPAT,RDAT,VPRVOK,VPATOK
 S VALMBCK="R",(VPRVOK,VPATOK)=0
 I TYPE="PR" D
 . S ERXPRV=$$GET1^DIQ(52.49,ERXIEN,2.1,"I")
 . S VPRV=0 F  S VPRV=$O(^PS(52.49,"APRVVPRV",ERXPRV,VPRV)) Q:'VPRV  D  I VPRVOK Q
 . . S RDAT=0 F  S RDAT=$O(^PS(52.49,"APRVVPRV",ERXPRV,VPRV,RDAT)) Q:'RDAT  D  I VPRVOK Q
 . . . S ERX=0 F  S ERX=$O(^PS(52.49,"APRVVPRV",ERXPRV,VPRV,RDAT,ERX)) Q:'ERX  D  I VPRVOK Q
 . . . . I ERX'=ERXIEN S VPRVOK=1
 I TYPE="PR",'VPRVOK D  Q
 . S VALMSG="There are no suggestions for this Provider" W $C(7)
 I TYPE="PA" D
 . S ERXPAT=+$$GET1^DIQ(52.49,+$G(ERXIEN),.04,"I")
 . S VPAT=0 F  S VPAT=$O(^PS(52.49,"APATVPAT",ERXPAT,VPAT)) Q:'VPAT  D  I VPATOK Q
 . . I $$DEAD^PSONVARP(VPAT) Q
 . . S RDAT=0 F  S RDAT=$O(^PS(52.49,"APATVPAT",ERXPAT,VPAT,RDAT)) Q:'RDAT  D  I VPATOK Q
 . . . S ERX=0 F  S ERX=$O(^PS(52.49,"APATVPAT",ERXPAT,VPAT,RDAT,ERX)) Q:'ERX  D  I VPATOK Q
 . . . . I ERX'=ERXIEN S VPATOK=1
 I TYPE="PA",'VPATOK D  Q
 . S VALMSG="There are no suggestions for this Patient" W $C(7)
 I TYPE="DR" S DRUGHASH=$$DRUGHASH^PSOERUT(ERXIEN)
 I TYPE="DR",'DRUGHASH D  Q
 . S VALMSG="Unable to calculate the hash value for this eRx" W $C(7)
 I TYPE="DR",'$O(^PS(52.49,"ADRGVRX",DRUGHASH,0)) D  Q
 . S VALMSG="There are no suggestions for this Drug" W $C(7)
 D FULL^VALM1
 I TYPE="PA" D MATCHSUG^PSOERPT1(ERXIEN,1)
 I TYPE="PR" D MATCHSUG^PSOERPV1(ERXIEN,1)
 I TYPE="DR" D MATCHSUG(ERXIEN,1)
 Q
 ;
LASTRXST(RXIEN) ; Returns the Rx Last Fill status (For Future Fill Suggestion only)
 ; Input: RXIEN  - pointer to PRESCRIPTION file (#52)
 ;Output: STATUS - Last fill status ("R":Relased;"T":Transmitted;"S":Suspended)
 N LASTFILL,FILLDATE,RELDATE,RXSTS
 S LASTFILL=$$LSTRFL^PSOBPSU1(RXIEN)
 S RELDATE=$$RXRLDT^PSOBPSUT(RXIEN,LASTFILL)\1
 S RXSTS=+$$GET1^DIQ(52,RXIEN,100,"I")
 S FILLDATE=$$RXFLDT^PSOBPSUT(RXIEN,LASTFILL)
 ; Last Fill released, Release Date + Days Supply in the future
 I RELDATE,$$FMADD^XLFDT(RELDATE,$$GET1^DIQ(52,RXIEN,8))>DT Q "R"
 ; Last Fill is not released, is Suspended, Not Transmitted/Printed, Future Fill Date
 I 'RELDATE,(RXSTS=5),FILLDATE>DT Q "S"
 ; Last Fill is not released, is Transmitted or Re-Transmitted to CMOP
 I 'RELDATE,$$CMOPSTS^PSOERUT(RXIEN,LASTFILL)=0!($$CMOPSTS^PSOERUT(RXIEN,LASTFILL)=2) Q "T"
 Q ""
 ;
NARRATIV(DFN,NMSPC,MODE) ;Display the Pharmacy Narrative
 ;Input: DFN    - VistA Patient - Pointer to PATIENT file (#2)
 ;       NMSPC  - ListMan Temp Global Namespace (e.g., "PSOERXP1") - Required for LM Mode only
 ;       MODE   - Display Mode: "RS": Roll & Scroll | "LM": ListMan
 Q:$G(DFN)=""
 N XX,I,LINETXT,NARRTIVE
 K XX S XX=$$GET1^DIQ(55,DFN,1,"E")
 Q:XX=""
 S LINETXT="VistA Narrative: "_$E(XX,1,63)
 S LINETXT=$$COMPARE^PSOERUT0(MODE,LINETXT,LINETXT,17)
 D ADDLINE^PSOERUT0(MODE,NMSPC,LINETXT)
 K NARRTIVE D TXT2ARY^PSOERXD1(.NARRTIVE,$E(XX,64,250),,80)
 F I=1:1 Q:'$D(NARRTIVE(I))  D
 . S LINETXT=" "_$$COMPARE^PSOERUT0(MODE,NARRTIVE(I),NARRTIVE(I),2)
 . D ADDLINE^PSOERUT0(MODE,NMSPC,LINETXT)
 Q
 ;
MATCHSUG(ERXIEN,VIEW) ; Match Suggestion Prompt
 ; Input: ERXIEN   - Pointer to ERX HOLDING QUEUE file (#52.49)
 ;     (o)VIEW     - View Only Mode (1:YES,0/null: NO)
 ;Output: MATCHSUG - p1: Vista Rx (Pointer to #52)
 ;                   p2: 1 - User want to copy Pat. Instr. | 0 - Do not copy | -1 - "^" (up-caret entered)
 ;
 N MATCHSUG,DRUGHASH,MATCHCNT,CNT,VISTARX,QUIT,DIR,Y,X,VADRUG,VASIG,SUGGARR,TEMPARR,II
 N VADAYS,VAREFS,VAQTY,VSRXPTINS,RXIEN,XQORNOD
 I '$D(^PS(52.49,+$G(ERXIEN),0)) Q 0
 ; Dosage already entered
 I '$G(VIEW),$D(^PS(52.49,ERXIEN,21)) Q 0
 ; 
 S DRUGHASH=$$DRUGHASH^PSOERUT(ERXIEN) I 'DRUGHASH Q 0
 ;
 S (MATCHSUG,MATCHCNT,QUIT)=0
 S VISTARX=""
 F  S VISTARX=$O(^PS(52.49,"ADRGVRX",DRUGHASH,VISTARX),-1) Q:'VISTARX  D  I (MATCHCNT>2) Q
 . S VADRUG=+$$GET1^DIQ(52,VISTARX,6,"I") I 'VADRUG Q
 . ; If Drug is Inactive, forget suggestion automatically
 . I $$GET1^DIQ(50,VADRUG,100,"I") D  Q
 . . K ^PS(52.49,"ADRGVRX",DRUGHASH,VISTARX)
 . S VASIG=$E($$SUGSIG^PSOERUT3(VISTARX,ERXIEN),1,500) I VASIG="" Q
 . S VAQTY=+$$GET1^DIQ(52,VISTARX,7,"I")
 . S VADAYS=+$$GET1^DIQ(52,VISTARX,8,"I")
 . S VAREFS=+$$GET1^DIQ(52,VISTARX,9,"I")
 . I $D(TEMPARR(VADRUG,VASIG,VAQTY,VADAYS,VAREFS)) Q
 . S MATCHCNT=MATCHCNT+1
 . S SUGGARR(MATCHCNT)=VISTARX_"^"_DRUGHASH,TEMPARR(VADRUG,VASIG,VAQTY,VADAYS,VAREFS)=""
 F CNT=1:1:MATCHCNT D  I MATCHSUG!QUIT Q
 . S VISTARX=+SUGGARR(CNT),DRUGHASH=$P(SUGGARR(CNT),"^",2)
 . D CMPMEDS(ERXIEN,VISTARX,CNT_"^"_MATCHCNT)
 . K DIR S DIR(0)="SOA^V:VIEW RX;"_$S('$G(VIEW):"A:ACCEPT;",1:"")_$S(MATCHCNT>1&(MATCHCNT'=CNT):"N:NEXT;",1:"")_"F:FORGET;E:EXIT"
 . S DIR("A")="ACTION on SUGGESTION: (V)IEW RX  "_$S('$G(VIEW):"(A)CCEPT  ",1:"")_$S(MATCHCNT>1&(MATCHCNT'=CNT):"(N)EXT  ",1:"")_"(F)ORGET  (E)XIT: "
 . S DIR("B")=$S(MATCHCNT>1&(MATCHCNT'=CNT):"NEXT",1:"EXIT")
 . S II=0
 . S II=II+1,DIR("?",II)="  VIEW RX - View VistA Rx where the suggestion is coming from"
 . I '$G(VIEW) D
 . . S II=II+1,DIR("?",II)="  ACCEPT - Accepts the suggested data (right column) and pre-populates the"
 . . S II=II+1,DIR("?",II)="           VistA fields"
 . I MATCHCNT>1&(MATCHCNT'=CNT) D
 . . S II=II+1,DIR("?",II)="  NEXT   - Ignores the current suggestion and view the next one"
 . S II=II+1,DIR("?",II)="  FORGET - Forgets the current suggestion so that it is not presented again"
 . S II=II+1,DIR("?",II)="           in the future to any user"
 . S DIR("?")="  EXIT   - Exits and continue to filling the VistA fields manually"
 . D ^DIR I $D(DIRUT)!$D(DIROUT)!(Y="E") S QUIT=1 Q
 . I Y="V" S RXIEN=VISTARX,XQORNOD(0)="" D VIEWNOTE,VIEW^PSOSPML4 D FULL^VALM1 S CNT=CNT-1 Q
 . I Y="A" S MATCHSUG=VISTARX D  Q
 . . ;Only prompt the Patient Instruction when Editing Drug not when Viewing suggestion
 . . ;prompt the user if they want to copy the patient instruction for the suggested rx into the eRx.
 . . I '$G(VIEW) S VSRXPTINS=$$PROMPTPI(ERXIEN,+MATCHSUG),MATCHSUG=VISTARX_"^"_VSRXPTINS
 . I Y="N" W ! Q
 . I Y="F" D
 . . K DIR S DIR(0)="SA^Y:YES;N:NO",DIR("B")="NO"
 . . S DIR("A")="Are you sure this suggestion match should be forgotten? "
 . . S DIR("?")="This suggestion originated from a VistA Rx previously dispensed for an eRx with"
 . . S DIR("?")=DIR("?")_" the exact Drug Name, NDC, SIG, Quantity, Days Supply, # of Refills"
 . . S DIR("?")=DIR("?")_" and Substitution allowance. Once you forget this match it will no"
 . . S DIR("?")=DIR("?")_"  longer be suggested as a match for future eRx's with the same fields."
 . . W ! D ^DIR I $D(DIRUT)!$D(DIROUT)!(Y="N") S CNT=CNT-1 W ! Q
 . . W !?64,"Forgetting..." K ^PS(52.49,"ADRGVRX",DRUGHASH,VISTARX) H 1 W "Ok." H .5 W ! Q
 Q MATCHSUG
 ;
CMPMEDS(ERXIEN,VISTARX,COUNTER) ; Display the Comparison Between eRx and VistA Providers
 ;Input: ERXIEN   - Pointer to ERX HOLDING QUEUE file (#52.49)
 ;       VISTARX - VistA Rx IEN (Pointer to #52)
 ;       COUNTER - P1: Entry # | P2: Number of Entries
 I '$D(^PS(52.49,+$G(ERXIEN),0))!'$D(^PSRX(+$G(VISTARX),0)) Q
 N XX,LINE,X
 W !?55,"|Sugg. " W $G(IOINHI)_+$G(COUNTER)_$G(IOINORM)_" of "_$G(IOINHI)_$P($G(COUNTER),"^",2)_$G(IOINORM)
 W " - ",$G(IOINHI)_$$FMTE^XLFDT($$GET1^DIQ(52,VISTARX,21,"I")\1,"2Z")_$G(IOINORM),?79,"|"
 W !,$G(IORVON)_"ERX MED"_$G(IORVOFF),?41,$G(IORVON)_"VISTA MED"_$G(IORVOFF)
 W ?55,"|From Rx#: "_$G(IOINHI)_$$GET1^DIQ(52,VISTARX,.01)_$G(IOINORM),?79,"|"
 S $P(XX,"_",81)="" W !,XX
 S LINE=0 D SETDRUG^PSOERUT2("RS",,ERXIEN,1,VISTARX)
 Q
 ;
PROMPTPI(ERXIEN,MATCHSUG) ;Once the user accept the suggested rx, prompt if user want to copy the patient instruction for that suggested rx into the eRx.
 ;Input : ERXIEN   - Pointer to ERX HOLDING QUEUE file (#52.49)
 ;        MATCHSUG - Pointer to PRESCRIPTION file (#52)
 ;Output: Returns 1 plus the Expanded Patient Instructions from the user's accepted suggested rx
 ;                0 - user did not accept the Patient Instruction from the suggested rx OR there are no PI for the Rx
 ;               -1 - user up carret (^) in the Patient Instruction prompt from the suggested rx
 ;
 N DTOUT,DUOUT,DIR,DIRUT,VSPATINS,PATINSARY,XX,Y,I,VARXNUM,VDRG,VAOI,PATINST,VADRGIEN,VAOIIEN,VAPATIEN
 ;
 I $$GET1^DIQ(59.7,1,102,"I")'="MBM" Q 0  ; MbM only
 I $G(ERXIEN)="" Q 0
 I $G(MATCHSUG)="" Q 0
 I $$GET1^DIQ(52.49,ERXIEN,27)'="" Q 0  ;eRx already has PI set
 ;
 ;check if the suggested rx has VA Pharmacy Orderable Item Patient Instructions
 S VADRGIEN=+$$GET1^DIQ(52,MATCHSUG,6,"I")
 S VAOIIEN=+$$GET1^DIQ(50,VADRGIEN,2.1,"I")
 S VAPATIEN=+$$GET1^DIQ(52.49,ERXIEN,.05,"I")
 ;The software will automatically populate the PI. See SAVEDRUG^PSOERUT2
 I $$VAPATINS^PSOERUT3(VAOIIEN,VAPATIEN)'="" Q 0
 ;
 S VSRXPTINS=""
 S VARXNUM=$$GET1^DIQ(52,MATCHSUG,.01)
 ;retrieve the Patient Instruction from File #52 field 115. Quits if none
 S VSPATINS=$$VARXPI^PSOERUT(MATCHSUG)
 ;
 I VSPATINS="" Q 0
 ;prompt the PATIENT INSTRUCTIONS for that suggested rx that user selected
 W !!,"Rx #"_$G(IOINHI)_VARXNUM_$G(IOINORM)," PATIENT INSTRUCTIONS:"
 K PATINSARY D TXT2ARY^PSOERXD1(.PATINSARY,$G(VSPATINS),,80)
 F I=1:1 Q:'$D(PATINSARY(I))  W !,$G(IOINHI)_PATINSARY(I)_$G(IOINORM)
 W !
 S DIR("A")="Copy PATIENT INSTRUCTIONS from Rx #"_$G(IOINHI)_VARXNUM_$G(IOINORM)
 S DIR("B")="NO",DIR(0)="Y"
 D ^DIR K DIR I $D(DIRUT)!$D(DIROUT) Q 0
 Q +$G(Y)
 ;
VIEWNOTE ; View Suggested Rx Notice
 S $P(XX,$S($D(IOUON):" ",1:"-"),81)="",$E(XX,37,42)="NOTICE" W !,$G(IOUON),XX,$G(IOUOFF)
 W !,"You will be taken to the VistA Rx#",$$GET1^DIQ(52,VISTARX,.01)," that was entered in the past for the"
 W !,"same Product (NDC/SIG/Qty/Days Supply/# of Refills/Substitution) for a different"
 W !,"eRx. This VistA Rx may or may not be for the same patient in this erx being"
 W !,"processed."
 S XX="",$P(XX,$S($D(IOUON):" ",1:"-"),81)="" W !,$G(IOUON),XX,$G(IOUOFF)
 K DIR S DIR(0)="E" D ^DIR I $D(DIRUT)!$D(DIROUT) Q
 Q

FBUTL136 ;DSS/LJF - FEE BASIS UTILITY FOR UNIQUE CLAIM ID - FEE5010 (overflow from FBUTL135) ;3/23/2012
 ;;3.5;FEE BASIS;**135**;MAR 23, 2012;Build 3
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q
 ;--------------------- OUTPATIENT ----------------------------------------
 ;
ENTROUTP(DFN,FBV,FBAAVID,FBCLAIMS) ; OUTPATIENT ENTER UCID
 ; Input:   DFN      - Patient ID 
 ;          FBV      - Vendor IEN
 ;          FBAAVID  - Vendor Invoice Date
 ;          FBCLAIMS - FPPS claim id
 ; Output:  returns UCID
 ;
 N FBCLT,FBTOUT
 I $G(DFN),$G(FBV),$G(FBAAVID) S FBCLAIMS=$G(FBCLAIMS),FBCLT="",DTIME=$G(DTIME,300),FBTOUT=""
 E  Q "-1"
 ;
 I FBCLAIMS="N/A" S FBCLAIMS=""
 I FBCLAIMS]"" D  Q FBCLAIMS
 . S FBCLAIMS=+$P($$HTE^XLFDT($H)," ",3)_"-"_FBCLAIMS
 . S FBCLT=$$OCLMTYP^FBUTL135
 . S FBCLAIMS=$$UCLAIMNO^FBUTL135($G(FBSTA),1,"E",FBCLT,FBCLAIMS)
 ;
 F  R !,"CLAIM NUMBER: ",FBANS:DTIME S FBTOUT='$T D  I FBANS]"" S FBCLAIMS=FBANS Q
 . I FBTOUT S FBANS="-1" Q
 . I $TR(FBANS,"new","NEW")="NEW" D  Q
 .. S FBANS=$$UCLAIMNO^FBUTL135 W "#: "_$E(FBANS,9,28)
 .. S $E(FBANS,8)=$$OCLMTYP^FBUTL135
 . I FBANS="??" D  W ! I FBANS="" Q    ; if no claim returns claim# - reask claim number
 .. S FBANS=$$OUTPHELP(DFN,FBV) I FBANS<1 S FBANS="" Q
 .. S FBCLT=$P(FBANS,U,2),FBANS=$P(FBANS,U)
 . I $E(FBANS)="^" S FBANS="" W !!,"This is a required response. ""^"" is not allowed.",! Q
 . I FBANS="?" D  S FBANS="" Q
 .. W !!,"Enter ""NEW"" to automatically generate a new claim number,"
 .. W !,"or enter an existing numeric claim number in format YYYY-<nn..>,"
 .. W !,"or enter ?? to see a list of existing claim numbers for this vendor.",!
 . I FBANS="" W !!,"This is a required response.",! Q
 . I FBANS'?4N1"-"1.15N W !!,"** INVALID CLAIM NUMBER **",!! S FBANS="" Q
 . S FBANS=$$UCLAIMNO^FBUTL135(,,,$G(FBCLT),FBANS)
 . S $E(FBANS,8)=$$OCLMTYP^FBUTL135
 . I FBANS'?6N2UL4N1"-"1.15N W !!,"** INVALID CLAIM NUMBER ***",!! S (FBANS,FBCLT)=""
 Q FBCLAIMS
 ;
EDITOUTP(FBXSTR,FBDA) ;
 ; Inputs:  FBXSTR = FPPS CLAIM ID entered by user
 ;          FBDA = DA variable containing SERVICE PROVIDED, INITIAL TREATMENT DATE, VENDOR, PATIENT
 ;
 N FBPAT,FBVEND,FBTDTG,FBSERVSE,DA,DR,FBINTYP
 S FBSERVSE=$G(FBDA)
 S FBTDTG=$G(FBDA(1))
 S FBVEND=$G(FBDA(2))
 S FBPAT=$G(FBDA(3))
 S FBXSTR=$G(FBXSTR)
 I FBXSTR'=-1,FBPAT,FBVEND,FBTDTG,FBSERVSE
 E  Q
 N FBDA ; New it so we don't affect it in any way
 N FBDATA,FBSTA,FBSITE,FPPSCLM,FBICLAIM,FBSRC,FBINT,FBCLT,FBCLAIMS,FBPRMPT,FBHOLD,C
 S C=",",FBSTA=$$STATION^FBUTL135,(FBHOLD,FBICLAIM)=""
 S FPPSCLM=$$GET1^DIQ(162.03,FBSERVSE_C_FBTDTG_C_FBVEND_C_FBPAT_C,50,"I")  ; get current value of FPPS claim id
 ;
 I FBXSTR]"" D  Q  ; If user entered FPPS, create UCID, save, and quit
 . S FBICLAIM=+$P($$HTE^XLFDT($H)," ",3)_"-"_FBXSTR
 . ; get claim type
 . S FBCLT=$$OCLMTYP^FBUTL135($G(FBCLT))
 . S FBICLAIM=$$PAYUCID^FBUTL135(FBPAT,FBVEND,FBTDTG,FBSERVSE,FBSTA,1,"E",FBCLT,FBICLAIM)  ; Populate UCID field
 ; If user didn't enter a new FPPS CLAIM ID
 I FBXSTR="" D
 . ;If FPPS CLAIM ID field is populated, clear out exisitng UCID and prepare for new one
 . I FPPSCLM]"" S FBICLAIM(162.03,FBSERVSE_C_FBTDTG_C_FBVEND_C_FBPAT_C,81)="" D FILE^DIE(,"FBICLAIM") K FBICLAIM S FBICLAIM="" Q
 . ;FPPS CLAIM ID field is null get existing UCID for default
 . S FBICLAIM=$$GET1^DIQ(162.03,FBSERVSE_C_FBTDTG_C_FBVEND_C_FBPAT_C,81,"I")
 . I $E(FBICLAIM,7)'="M" S FBICLAIM="" Q  ; if not a manual claim, don't use it
 ;
 I FBICLAIM="" D  Q   ; If UCID not populated
 . F  S FBICLAIM=$$ENTROUTP(FBPAT,FBVEND,FBTDTG) W:FBICLAIM<1 !,"  REQUIRED ENTRY." Q:FBICLAIM<1  D  Q:FBICLAIM>1   ; allow user to enter new UCID
 .. S FBSTA=$E(FBICLAIM,1,5)
 .. S FBSRC=$E(FBICLAIM,6)
 .. S FBINTYP=$E(FBICLAIM,7)
 .. S FBCLT=$E(FBICLAIM,8)
 .. S $E(FBICLAIM,1,8)=""
 .. S FBICLAIM=$$PAYUCID^FBUTL135(FBPAT,FBVEND,FBTDTG,FBSERVSE,FBSTA,FBSRC,FBINTYP,FBCLT,FBICLAIM)   ; Populate UCID field
 ;
 ; we have an existing UCID - validate it then allow edit
 I '$$VALIDATE^FBUTL135("O",FBICLAIM) S FBICLAIM=""  ; not valid - 
 E  D
 . S FBSTA=$E(FBICLAIM,1,5)
 . S FBSRC=$E(FBICLAIM,6)
 . S FBINT=$E(FBICLAIM,7)
 . S FBCLT=$E(FBICLAIM,8)
 . S $E(FBICLAIM,1,8)="",FBHOLD=FBICLAIM
 ;
 I FBICLAIM]"" S FBPRMPT=" "_FBICLAIM_" //"
 S FBPRMPT="CLAIM NUMBER:"_$G(FBPRMPT)_" ",FBTOUT=""
 F  W !,FBPRMPT R FBANS:DTIME S FBTOUT='$T Q:FBTOUT  D  Q:FBTOUT  I FBANS'="" S FBCLAIMS=FBANS Q
 . I FBANS="",FBICLAIM]"" D
 .. S FBANS=FBICLAIM
 . I $TR(FBANS,"new","NEW")="NEW" D  Q
 .. S (FBSTA,FBSRC)="",FBINTYP="M",FBANS=$$UCLAIMNO^FBUTL135() W "#: "_$E(FBANS,9,28)
 . I FBANS="??" D  I FBANS="" Q
 .. S FBANS=$$OUTPHELP(FBPAT,FBVEND) I FBANS<1 S FBANS="" Q
 .. S FBCLT=$P(FBANS,U,2),FBANS=$P(FBANS,U)
 . I FBANS="@" W !!,"  REQUIRED ENTRY.",! S FBANS="" Q
 . I $E(FBANS)="^" S FBANS="" W !!,"This is a required response. ""^"" is not allowed.",! Q
 . I FBANS="?" D  S FBANS="" Q
 .. W !!,"Enter ""NEW"" to automatically generate a new claim number,"
 .. W !,"or enter an existing numeric claim number in format YYYY-<nn..>,"
 .. W !,"or enter ?? to see a list of existing claim numbers for this vendor.",!
 . I FBANS="" S FBANS=FBHOLD
 . I FBANS?4N1"-"1.15N D
 .. S FBANS=$$UCLAIMNO^FBUTL135($G(FBSITE),$G(FBSRC),$G(FBINT),$G(FBCLT),FBANS)
 . I FBANS'?6N2UL4N1"-"1.15N W !!,"** INVALID CLAIM NUMBER ****",!! S FBANS=""
 I FBTOUT S DTOUT=FBTOUT,FBXSTR=-1 Q  ; flag not to save FPPS EDIT
 I $G(FBCLAIMS)]"" D  I FBCLAIMS Q
 . S FBSTA=$E(FBCLAIMS,1,5)
 . S FBSRC=$E(FBCLAIMS,6)
 . S FBINT=$E(FBCLAIMS,7)
 . S FBCLT=$$OCLMTYP^FBUTL135($E(FBCLAIMS,8))
 . S $E(FBCLAIMS,1,8)=""
 . S FBCLAIMS=$$PAYUCID^FBUTL135(FBPAT,FBVEND,FBTDTG,FBSERVSE,FBSTA,FBSRC,FBINT,FBCLT,FBCLAIMS)
 . I FBCLAIMS<1 S FBCLAIMS=""
 ;
 N DA
 S DA=$G(FBSERVSE)
 S DA(1)=$G(FBTDTG)
 S DA(2)=$G(FBVEND)
 S DA(3)=$G(FBPAT)
 S FBXSTR=$G(FBXSTR)
 W !!,"** INVALID CLAIM NUMBER *****",!! D EDITOUTP(FBXSTR,.DA)   ; Restart edit
 Q
OUTPHELP(DFN,FBV) ; ?? response
 I $G(DFN),$G(FBV)   ; gotta have a DFN, and a Vendor number
 E  Q 0
 N DTG,E7,E7TEXT,FBINT,FBIX,RETDIR,FBVENDT
 N DTOUT,DUOUT,DIRUT,DIROUT,X,Y,C
 N FBDOS,FBSVC,UCID,FBYEAR,OLINE,CNT,CLMID,CLMTYP
 S FBTOUT=""
 S E7TEXT("E")="1-EDI",E7TEXT("S")="2-SCANNED",E7TEXT("M")="3-MANUAL"
 S (CNT,DTG)=0,RETDIR="",C=","
 S FBDOS=0
 F  S FBDOS=$O(^FBAAC(DFN,1,FBV,1,FBDOS)),FBSVC=0 Q:'FBDOS  D   ; date of service
 . F  S FBSVC=$O(^FBAAC(DFN,1,FBV,1,FBDOS,1,FBSVC)) Q:'FBSVC  D   ; service provided
 .. S UCID=$P($G(^FBAAC(DFN,1,FBV,1,FBDOS,1,FBSVC,5)),U,5)
 .. I UCID="" Q
 .. I '$$VALIDATE^FBUTL135("O",UCID) Q
 .. I $E(UCID,7)="E" Q  ; Quit if Initiation Type is "E"DI
 .. S CLMTYP=$E(UCID,8)
 .. S FBYEAR=$$FMTE^XLFDT(FBDOS),FBVENDT=$$GET1^DIQ(162.02,FBDOS_C_FBV_C_DFN_C,.01,"I")
 .. S CLMID=$E(UCID,9,28)   ; Only want the YYYY-<xxxxx> 
 .. S OLINE=$E(CLMID_"                       ",1,22)
 .. S OLINE=OLINE_$E(FBVENDT_"       ",1,14)  ; Vendor date
 .. S OLINE=OLINE_"("_UCID_")"             ; Full UCID
 .. S UCID("LIST",9999999-FBVENDT,FBSVC,CLMID)=OLINE_"^^"_CLMTYP
 ;
 I '$D(UCID("LIST")) W !!,?5,"NO RECENT CLAIM NUMBERS FOR THIS PATIENT/VENDOR" Q ""   ; Nothing to display
 E  W !!,?4,"RECENT CLAIM NUMBERS FOR THIS PATIENT/VENDOR",!
 K OLINE S OLINE=$NA(UCID("LIST"))
 ; Display list of prospects
 F CNT=1:1 S OLINE=$Q(@OLINE) Q:OLINE=""  D   Q:RETDIR  Q:$G(DTOUT)  Q:$G(DUOUT)
 . I '(CNT-1#5) W !," #  CLAIM NO              VEND INV DATE  COMPLETE UCID"
 . S CNT(CNT)=$J(CNT,2)_": "_$P(@OLINE,"^^"),CNT(CNT,"CLMID")=$QS(OLINE,4)_U_$P(@OLINE,"^^",2) W !,CNT(CNT)
 . I '(CNT#5) D
 .. N DA,DIR
 .. S DIR(0)="NAO^1:"_CNT,DIR("A",1)="Press <RETURN> to see more, '^' to exit this list, or",DIR("A")="CHOOSE 1-"_CNT_": "  D ^DIR
 .. ;Possible options - X is a number = done. or X is null or X is "^" 
 .. I X?1.2N S RETDIR=X Q
 I '$G(DTOUT),'$G(DUOUT)
 E  S RETDIR="-1^"_$G(DTOUT)_"."_$G(DUOUT) K DTOUT,DUOUT Q RETDIR ; time out or opt out
 ; no opt out, no time out
 I 'RETDIR D   ; user did not select any entries so far, so display final choice prompt
 . N DA,DIR
 . S CNT=CNT-1,DIR(0)="NAO^1:"_CNT,DIR("A",1)="Press <RETURN> to return to main prompt, or",DIR("A")="CHOOSE 1-"_CNT_":" D ^DIR
 . I X?1.2N S RETDIR=X
 I '$G(DTOUT),'$G(DUOUT)
 E  S RETDIR="-1^"_$G(DTOUT)_"."_$G(DUOUT) K DTOUT,DUOUT Q RETDIR ; time out or opt out
 I RETDIR Q $G(CNT(RETDIR,"CLMID"))   ; quit with the selected claim
 Q RETDIR
 ;
 ;
 ;--------------------- INPATIENT ----------------------------------------
 ;
ENTINPAT(FBSTA,FBSRC,FBINT,FBCLT,FBCLAIMS,FBVEND) ;Returns UCID; FB*3.5*135
 ; Input:  FBSTA = Station
 ;         FBSRC = Source
 ;         FBINT = Initiation Type
 ;         FBCLT = Claim Type
 ;         FBCLAIMS = FPPS CLAIM ID - replaces sequence number
 ;         FBVEND = Vendor IEN
 ;
 ; Output: UCID
 ;
 N FBRETVAL,FBTOUT,FBANS
 K DTOUT
 S FBSTA=$G(FBSTA),FBSRC=$G(FBSRC),FBINT=$G(FBINT),FBCLT=$G(FBCLT),FBCLAIMS=$G(FBCLAIMS),FBVEND=$G(FBVEND),(FBRETVAL,FBTOUT,FBUOUT,FBANS)=""
 I FBCLAIMS="N/A" S FBCLAIMS=""
 I FBCLAIMS]"" D  Q FBCLAIMS
 . S FBCLAIMS=+$P($$HTE^XLFDT($H)," ",3)_"-"_FBCLAIMS
 . S FBCLAIMS=$$UCLAIMNO^FBUTL135(FBSTA,FBSRC,"E",FBCLT,FBCLAIMS)
 F  R !,"CLAIM NUMBER: ",FBANS:DTIME S FBTOUT='$T Q:FBTOUT  D  Q:FBTOUT  I FBANS'="" S FBCLAIMS=FBANS Q
 . I $TR(FBANS,"new","NEW")="NEW" S FBANS=$$UCLAIMNO^FBUTL135(FBSTA,$G(FBSRC),"M",$G(FBCLT)) W "#: "_$E(FBANS,9,28) Q
 . I FBANS="??" S FBANS=$$ENTHELP(FBVEND,.FBTOUT,.FBUOUT) S:FBUOUT (FBANS,FBUOUT)="" Q:FBANS=""
 . I $E(FBANS)="^" S FBANS="" W !!,"This is a required response. ""^"" is not allowed.",! Q
 . I FBANS="?" D  S FBANS="" Q
 .. W !!,"Enter ""NEW"" to automatically generate a new claim number,"
 .. W !,"or enter an existing numeric claim number in format YYYY-<nn..>,"
 .. W !,"or enter ?? to see a list of existing claim numbers for this vendor.",!
 . I FBANS="" W !!,"  REQUIRED ENTRY.",! Q
 . I FBANS?4N1"-"1.15N S FBANS=$$UCLAIMNO^FBUTL135(FBSTA,$G(FBSRC),$G(FBINT),$G(FBCLT),FBANS)
 . I FBANS'?6N2UL4N1"-"1.15N W !!,"*** INVALID CLAIM NUMBER ***",!! S FBANS=""
 I 'FBTOUT,'FBUOUT Q FBCLAIMS
 I FBTOUT S DTOUT=FBTOUT
 I FBUOUT S DUOUT=FBUOUT
 Q ""
 ;
ENTHELP(FBVEND,FBTOUT,FBUOUT) ; Help for UCID in "FBCH ENTER PAYMENT" ; FB*3.5*135
 I $G(DFN),$G(FBVEND)   ; gotta have a DFN, and a Vendor number
 E  Q 0
 N CLMID,CNT,DTG,E7,E7TEXT,FBINT,FBIX,OLINE,RETDIR,UCIDLIST,YR
 N DTOUT,DUOUT,DIRUT,DIROUT,X,Y
 S (FBTOUT,FBUOUT)=""
 S E7TEXT("E")="1-EDI",E7TEXT("S")="2-SCANNED",E7TEXT("M")="3-MANUAL"
 S (CNT,DTG)=0,RETDIR=""
 ; Build list of prospects
 F  S DTG=$O(^FBAAI("AG",DFN,DTG)),FBIX=0 Q:'DTG  D
 . F  S FBIX=$O(^FBAAI("AG",DFN,DTG,FBIX)) Q:'FBIX  D
 .. K FBINT D GETS^DIQ(162.5,FBIX,"2;46;85","IE","FBINT")
 .. I FBINT("162.5",FBIX_",",2,"I")'=FBVEND Q     ; Quit if vendor doesn't match 
 .. I FBINT("162.5",FBIX_",",85,"E")="" Q         ; Quit if no UCID
 .. I $E(FBINT("162.5",FBIX_",",85,"E"),7)="E" Q  ; Quit if Initiation Type is "E"DI
 .. I '$$VALIDATE^FBUTL135("I",FBINT("162.5",FBIX_",",85,"E")) Q  ; Quit if not valid
 .. K OLINE M OLINE=FBINT("162.5",FBIX_",")
 .. S UCIDLIST=FBINT("162.5",FBIX_",",85,"E")
 .. S YR=(9999999.999999-$G(OLINE(46,"I"))),CLMID=$P(UCIDLIST,"-",1,2),E7=$E(UCIDLIST,7)
 .. I $D(E7TEXT(E7)) S E7=E7TEXT(E7)
 .. E  S E7="4-"_E7
 .. S OLINE=$E($G(OLINE(85,"E"))_"                       ",9,30)  ; Only want the YYYY-<xxxxx> 
 .. S OLINE=OLINE_$E($G(OLINE(46,"E"))_"       ",1,14)  ; Vendor date
 .. S OLINE=OLINE_"("_$G(OLINE(85,"E"))_")"             ; Full UCID
 .. S UCIDLIST("LIST",YR,E7,CLMID,FBIX)=OLINE
 K OLINE S OLINE=$NA(UCIDLIST("LIST"))
 I '$D(UCIDLIST("LIST")) W !!,?5,"NO RECENT CLAIM NUMBERS FOR THIS PATIENT/VENDOR",! Q ""   ; Nothing to display
 E  W !!,?4,"RECENT CLAIM NUMBERS FOR THIS PATIENT/VENDOR",!
 ; Display list of prospects
 F CNT=1:1 S OLINE=$Q(@OLINE) Q:OLINE=""  D   Q:RETDIR  Q:$G(DTOUT)  Q:$G(DUOUT)
 . I '(CNT-1#5) W !," #  CLAIM NO              VEND INV DATE  COMPLETE UCID"
 . S CNT(CNT)=$J(CNT,2)_": "_@OLINE,CNT(CNT,"CLMID")=$QS(OLINE,4)_U_$QS(OLINE,3) W !,CNT(CNT)
 . I '(CNT#5) D
 .. N DA,DIR
 .. S DIR(0)="NAO^1:"_CNT,DIR("A",1)="Press <RETURN> to see more, '^' to exit this list, or",DIR("A")="CHOOSE 1-"_CNT_": "  D ^DIR
 .. ;Possible options - X is a number = done. or X is null or X is "^" 
 .. I X?1.2N S RETDIR=X Q
 S FBTOUT=$G(DTOUT),FBUOUT=$G(DUOUT)
 I 'FBTOUT,'FBUOUT
 E  Q ""   ; time out or opt out
 ; no opt out, no time out
 I 'RETDIR D   ; user did not select any entries so far, so display final choice prompt
 . N DA,DIR
 . S CNT=CNT-1,DIR(0)="NAO^1:"_CNT,DIR("A",1)="Press <RETURN> to return to main prompt, or",DIR("A")="CHOOSE 1-"_CNT_":" D ^DIR
 . I X?1.2N S RETDIR=X
 S FBTOUT=$G(DTOUT),FBUOUT=$G(DUOUT)
 I 'FBTOUT,'FBUOUT
 E  Q ""   ; time out or opt out
 I RETDIR Q $P($G(CNT(RETDIR,"CLMID")),U)   ; quit with the selected claim
 Q RETDIR
 ;
EDINPAT(FBXSTR,FBI) ; EDIT UNIQUE CLAIM ID for FEE BASIS INVOICE file - 162.5
 ; Input:  FBXSTR = FPPS value entered by user for FPPS
 ;         FBI = IEN of Invoice record
 ;
 ; Output: UCID
 ;
 N FBDATA,FBFPPSCL,FBICLAIM,FBSITE,FBSTA,FBSRC,FBINT,FBCLT,FPPSCLM,FBCLAIMS,FBPRMPT,FBHOLD,FBVEND
 S FBXSTR=$G(FBXSTR),FBI=$G(FBI),FBSTA=$$STATION^FBUTL135,FBVEND=$$GET1^DIQ(162.5,FBI_",",2,"I"),FPPSCLM=$$GET1^DIQ(162.5,FBI_",",56,"I"),(FBHOLD,FBICLAIM)=""
 I FBXSTR'=-1,FBI
 E  Q
 ;
 I FBXSTR]"" D  Q  ; If user entered FPPS, create UCID, save, and quit
 . S FBICLAIM=+$P($$HTE^XLFDT($H)," ",3)_"-"_FBXSTR
 . S FBICLAIM=$$INVUCID^FBUTL135(FBI,FBSTA,1,"E",FBICLAIM)  ; Populate UCID field
 ;
 ; If user didn't enter a new FPPS CLAIM ID
 I FBXSTR="" D
 . ;If FPPS CLAIM ID field is populated, clear out exisitng UCID and prepare for new one
 . I FPPSCLM]"" S FBICLAIM(162.5,FBI_",",85)="" D FILE^DIE(,"FBICLAIM") K FBICLAIM S FBICLAIM="" Q
 . ;FPPS CLAIM ID field is null get existing UCID for default
 . S FBICLAIM=$$GET1^DIQ(162.5,FBI_",",85,"I") I $E(FBICLAIM,7)'="M" S FBICLAIM=""  ; if not a manual claim, don't use it
 ;
 I FBICLAIM="" D  Q   ; If UCID not populated
 . S FBICLAIM=$$ENTINPAT(,1,"M","I",,FBVEND)  ; allow user to enter new UCID
 . I '$G(DTOUT),'$G(DUOUT),FBICLAIM]"" D
 .. S FBSITE=$E(FBICLAIM,1,5)
 .. S FBSRC=$E(FBICLAIM,6)
 .. S FBINT=$E(FBICLAIM,7)
 .. S $E(FBICLAIM,1,8)=""
 .. S FBICLAIM=$$INVUCID^FBUTL135(FBI,FBSITE,FBSRC,FBINT,FBICLAIM) ; Populate UCID field
 ; we have an existing UCID - validate it then allow edit
 ;
 I '$$VALIDATE^FBUTL135("I",FBICLAIM) S FBICLAIM=""  ; not valid - 
 E  D
 . S FBSITE=$E(FBICLAIM,1,5) I FBSITE="" S FBSITE=FBSTA
 . S FBSRC=$E(FBICLAIM,6) I FBSRC="" S FBSRC=1
 . S FBINT=$E(FBICLAIM,7) I FBINT="" S FBINT="M"
 . S FBCLT="I"
 . S $E(FBICLAIM,1,8)="",FBHOLD=FBICLAIM
 ;
 I FBICLAIM]"" S FBPRMPT=" "_FBICLAIM_" //"
 S FBPRMPT="CLAIM NUMBER:"_$G(FBPRMPT)_" ",(FBTOUT,FBUOUT)=""
 F  W !,FBPRMPT R FBANS:DTIME S FBTOUT='$T Q:FBTOUT  D  Q:FBTOUT  Q:FBUOUT  I FBANS'="" S FBCLAIMS=FBANS Q
 . I FBANS="",'FBTOUT,FBICLAIM]"" S FBANS=FBICLAIM Q   ; accept existing UCID suffix
 . I $TR(FBANS,"new","NEW")="NEW" S FBANS=$$UCLAIMNO^FBUTL135(FBSTA,$G(FBSRC),$G(FBINT),$G(FBCLT)) W "#: "_$E(FBANS,9,28) Q
 . I FBANS="??" D  Q:FBANS=""
 .. S FBANS=$$ENTHELP(FBVEND,.FBTOUT,.FBUOUT)
 .. I FBTOUT S (FBTOUT,FBANS)="" Q
 .. I FBUOUT Q
 .. I FBANS="" Q
 . I FBANS="@" W !!,"  REQUIRED ENTRY.",! S FBANS="" Q
 . I $E(FBANS)="^" S FBANS="" W !!,"This is a required response. ""^"" is not allowed.",! Q
 . I FBANS="?" D  S FBANS="" Q
 .. W !!,"Enter ""NEW"" to automatically generate a new claim number,"
 .. W !,"or enter an existing numeric claim number in format YYYY-<nn..>,"
 .. W !,"or enter ?? to see a list of existing claim numbers for this vendor.",!
 . I FBANS="" S FBANS=FBHOLD Q
 . I FBANS?4N1"-"1.15N S FBANS=$$UCLAIMNO^FBUTL135($G(FBSITE),$G(FBSRC),$G(FBINT),$G(FBCLT),FBANS)
 . I FBANS'?6N2UL4N1"-"1.15N W !!,"*** INVALID CLAIM NUMBER ****",!! S FBANS="" Q
 I FBTOUT S DTOUT=FBTOUT,FBX=-1   ; flag not to save FPPS EDIT
 I FBUOUT S DUOUT=FBUOUT,FBX=-1   ; flag not to save FPPS EDIT
 I 'FBTOUT,'FBUOUT D
 . I FBANS?4N1"-"1.15N D
 .. S FBANS=FBSTA_"1MI"_FBANS
 . S FBSTA=$E(FBANS,1,5)
 . S FBSRC=$E(FBANS,6)
 . S FBINT=$E(FBANS,7)
 . S $E(FBANS,1,8)=""
 . S FBICLAIM=$$INVUCID^FBUTL135(FBI,FBSTA,FBSRC,FBINT,FBANS)
 . I +FBICLAIM=-1 W !!,"*** INVALID CLAIM NUMBER *****",!! D EDINPAT(FBXSTR,FBI)   ; Populate UCID field
 Q

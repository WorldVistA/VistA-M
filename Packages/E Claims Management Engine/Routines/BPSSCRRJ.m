BPSSCRRJ ;ALB/ESG - ECME OPECC Reject Information ;02-SEP-2015
 ;;1.0;E CLAIMS MGMT ENGINE;**20**;JUN 2004;Build 27
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; ICR# 4701 for call to $$RXSITE^PSOBPSUT
 ; ICR# 4705 for call to $$GETNDC^PSONDCUT
 ; ICR# 4711 for call to DP^PSORXVW
 ; ICR# 6227 for call to REJCOM^PSOREJU4
 ; ICR# 6228 for call to MP^PSOREJU4 and PI^PSOREJU4
 ;
 Q
 ;
EN ; -- main entry point for BPS OPECC REJECT INFORMATION
 N BPSEL,DFN,PSODFN,BPINSIEN,BPORI59,RXREF,RXIEN,RXFIL,LINE,VALMHDR,RX,FILL
 W "OPECC Reject Information"
 D FULL^VALM1
 S BPSEL=$$ASKLINE^BPSSCRU4("Select item","C","Please select a single Rx line.")
 I BPSEL<1 G ENX
 S (DFN,PSODFN)=+$P(BPSEL,U,2)              ; patient DFN
 S BPINSIEN=+$P(BPSEL,U,3)                  ; insurance ien
 S BPORI59=$P(BPSEL,U,4) I 'BPORI59 G ENX   ; BPS Transaction ien
 S RXREF=$$RXREF^BPSSCRU2(BPORI59)
 S RXIEN=$P(RXREF,U,1) I 'RXIEN G ENX       ; prescription ien
 S RXFIL=$P(RXREF,U,2)                      ; fill#
 ;
 ; the claim must either be rejected or non-billable to be eligible for this action
 I '$$REJECTED^BPSSCR02(BPORI59),'$$NB^BPSSCR03(BPORI59) D  G ENX
 . W !!,"This claim is not a valid selection for the OPECC Reject Information screen."
 . W !,"This screen is for either rejected claims or non-billable claims."
 . D PAUSE^VALM1
 . Q
 ;
 D EN^VALM("BPS OPECC REJECT INFORMATION")
ENX ;
 S VALMBCK="R"
 Q
 ;
 ;
INIT ; -- init variables and list array
 ;
 K ^TMP("BPSSCRRJ",$J),^TMP("PSOPI",$J)
 S LINE=0,VALMCNT=0
 S (DFN,PSODFN)=+$P($G(^BPST(BPORI59,0)),U,6)
 ;
 D REJ          ; main reject information
 D BPSCOM       ; ecme opecc comments
 D PSOCOM       ; pso pharmacist comments
 D INS          ; insurance information
 ;
INITX ;
 Q
 ;
REJ ; main reject information data capture and display
 ;
 N BBTXT,RXCOB,ELIG,STATUS,RESPIEN,BPPOS,BPRJ,BPN,RSPREC,Z,DG,CODE,DESC,BPSNAF,BPPMSG,BPARR,PREFIX,TXTLN,BPADDMSG,PAMSG,TX
 S BBTXT=""
 S RXCOB=+$P($G(^BPST(BPORI59,0)),U,14) I 'RXCOB S RXCOB=1
 I $$BBILL^BPSBUTL(RXIEN,RXFIL,RXCOB) S BBTXT=" BACK-BILL"
 E  I $$RESUBMIT^BPSBUTL(RXIEN,RXFIL,RXCOB) S BBTXT=" RESUBMISSION"
 S ELIG=$P($G(^BPST(BPORI59,9)),U,4)
 S ELIG=$S(ELIG="C":"CHAMPVA",ELIG="T":"TRICARE",1:"Veteran")
 D SETLN("REJECT Information ("_ELIG_") "_BBTXT,1,1)
 ;
 ; for non-billable entries display some custom information and get out
 ; most of this section will not work for non-billables because there is no ECME claim or response
 I $$NB^BPSSCR03(BPORI59) D  G REJX
 . D SETLN("Current ECME Status: N/A for Non-Billable Entry")
 . D SETLN($$EREJTXT^BPSSCR03(BPORI59))
 . Q
 ;
 ; the rest of this procedure is for a normal rejected claim/response
 ;
 S STATUS=$P($$STATUS^BPSOSRX(RXIEN,RXFIL,,,RXCOB),U,1)
 D SETLN("Current ECME Status: "_STATUS)
 ;
 I '$$GRESPPOS^BPSSCRU3(BPORI59,.RESPIEN,.BPPOS) D  G INITX
 . D SETLN("No ECME Response information can be found.")
 . Q
 ;
 I '$G(RESPIEN) D  G INITX
 . D SETLN("SYSTEM ERROR: No ECME Response information can be found.")
 . Q
 ;
 ; get the number of rejects on file and the reject codes/descriptions
 K BPRJ S BPN=0
 D GETRJCOD^BPSSCRU3(BPORI59,.BPRJ,.BPN,74,"")
 I BPN D      ; if there are rejects
 . S RSPREC=$P($G(^BPSR(RESPIEN,0)),U,2)     ; date/time response received
 . D SETLN("Reject"_$S(BPN>1:"s",1:"")_" received from Payer on "_$$FMTE^XLFDT(RSPREC,"5ZPS")_"."),SETLN(" ")
 . D SETLN(" Code   Description")
 . S Z=0 F  S Z=$O(BPRJ(Z)) Q:'Z  D
 .. S DG=$G(BPRJ(Z)),CODE=$P(DG,":",1),DESC=$P(DG,":",2,99)
 .. D SETLN($J(CODE,5)_" - "_DESC)
 .. Q
 . D SETLN(" ")
 . Q
 I 'BPN D SETLN("No Reject Information was found."),SETLN(" ")
 ;
 ; get and display next available fill date from the response file
 S BPSNAF=$$NFLDT^BPSBUTL(RXIEN,RXFIL,RXCOB)
 I BPSNAF'="" D SETLN("Next Avail Fill: "_$$FMTE^XLFDT(BPSNAF,"5DZ"))
 ;
 ; get and display payer message (504-F4)
 S BPPMSG=$$MESSAGE^BPSSCRLG(RESPIEN)    ; payer message (504-F4)
 D WRAPTXT(BPPMSG,62,.BPARR)
 S BPN=0 F  S BPN=$O(BPARR(BPN)) Q:'BPN  D
 . S PREFIX=$S(BPN=1:"Payer Message  :",1:"")
 . S TXTLN=$$LJ^XLFSTR(PREFIX,17)_$G(BPARR(BPN,0))
 . D SETLN(TXTLN)
 . Q
 ;
 ; get and display payer additional message (526-FQ)
 K BPADDMSG
 D ADDMESS^BPSSCRLG(RESPIEN,1,.BPADDMSG)
 S PAMSG=""
 S BPN=0 F  S BPN=$O(BPADDMSG(BPN)) Q:'BPN  S TX=$G(BPADDMSG(BPN)),PAMSG=$S(PAMSG="":TX,1:PAMSG_" "_TX)
 D WRAPTXT(PAMSG,62,.BPARR)
 S BPN=0 F  S BPN=$O(BPARR(BPN)) Q:'BPN  D
 . S PREFIX=$S(BPN=1:"Payer Addl Msg :",1:"")
 . S TXTLN=$$LJ^XLFSTR(PREFIX,17)_$G(BPARR(BPN,0))
 . D SETLN(TXTLN)
 . Q
 ;
REJX ;
 D SETLN(" "),SETLN(" ")
 Q
 ;
BPSCOM ; display full opecc comments here
 N CMTDT,ZN,CDAT,CDATE,CUSER,RXFLG,TXT,CTXT,L,TXTLN
 D SETLN("OPECC COMMENTS",1,1)
 ;
 I '$O(^BPST(BPORI59,11,0)) D SETLN("  There are no comments found for this section.") G BPSCOMX
 ;
 S CMTDT=" " F  S CMTDT=$O(^BPST(BPORI59,11,"B",CMTDT),-1) Q:'CMTDT  S ZN=" " F  S ZN=$O(^BPST(BPORI59,11,"B",CMTDT,ZN),-1) Q:'ZN  D
 . S CDAT=$G(^BPST(BPORI59,11,ZN,0))
 . S CDATE=$$FMTE^XLFDT(CMTDT,"2ZMP")               ; external date/time of comment
 . S CUSER=$P($G(^VA(200,+$P(CDAT,U,2),0)),U,1)     ; user name who entered comment
 . S RXFLG=$S($P(CDAT,U,4):" (Pharm)",1:"")         ; flag that says if opecc comment should be displayed on PSO RI screen
 . S TXT=CDATE_RXFLG_" - "_$P(CDAT,U,3)_" ("_CUSER_")"
 . D WRAPTXT(TXT,76,.CTXT)
 . S L=0 F  S L=$O(CTXT(L)) Q:'L  D
 .. S TXTLN=$S(L=1:"- ",1:"   ")_$G(CTXT(L,0))
 .. D SETLN(TXTLN)
 .. Q
 . Q
 ;
BPSCOMX ;
 D SETLN(" "),SETLN(" ")
 Q
 ;
PSOCOM ; display the PSO comments from the pharmacist
 N RXCOB,COM,REJ,NUMREJ,REJIEN,REJDESC,COMDT,Z1,CDAT,CDATE,CUSER,TXT,CTXT,L,TXTLN
 ;
 S RXCOB=+$P($G(^BPST(BPORI59,0)),U,14) I 'RXCOB S RXCOB=1
 D REJCOM^PSOREJU4(RXIEN,RXFIL,RXCOB,.COM)     ; build the PSO comments array for this Rx/fill/cob (ICR# 6227)
 ;
 D SETLN("PHARMACIST COMMENTS",1,1)
 ;
 S REJ="" F NUMREJ=0:1 S REJ=$O(COM(REJ)) Q:REJ=""     ; count the number of reject codes that have PSO comments
 I 'NUMREJ D SETLN("  There are no comments found for this section.") G PSOCOMX
 ;
 S REJ="" F  S REJ=$O(COM(REJ)) Q:REJ=""  D
 . ;
 . ; if there are 2 or more reject codes that have comments, then display the reject code/description here
 . I NUMREJ>1 D
 .. S REJIEN=+$O(^BPSF(9002313.93,"B",REJ,""),-1)      ; reject code internal IEN
 .. S REJDESC=$P($G(^BPSF(9002313.93,REJIEN,0)),U,2)   ; reject description
 .. D SETLN(REJ_" - "_REJDESC)
 .. Q
 . ;
 . S COMDT=" " F  S COMDT=$O(COM(REJ,COMDT),-1) Q:'COMDT  S Z1=" " F  S Z1=$O(COM(REJ,COMDT,Z1),-1) Q:'Z1  D
 .. S CDAT=$G(COM(REJ,COMDT,Z1))
 .. S CDATE=$$FMTE^XLFDT($P(CDAT,U,1),"2ZMP")
 .. S CUSER=$P($G(^VA(200,+$P(CDAT,U,2),0)),U,1)
 .. S TXT=CDATE_" - "_$P(CDAT,U,3)_" ("_CUSER_")"
 .. D WRAPTXT(TXT,76,.CTXT)
 .. S L=0 F  S L=$O(CTXT(L)) Q:'L  D
 ... S TXTLN=$S(L=1:"- ",1:"   ")_$G(CTXT(L,0))
 ... D SETLN(TXTLN)
 ... Q
 .. Q
 . ;
 . ; if there are more reject codes, display a blank line here before the next reject code
 . I $O(COM(REJ))'="" D SETLN(" ")
 . Q
 ;
PSOCOMX ;
 D SETLN(" "),SETLN(" ")
 Q
 ;
INS ; gather and show insurance information
 N BPSINS,IENS,INSNAME,RXCOB,BPSPOL,BPSEFDT
 S BPSINS=+$$GET1^DIQ(9002313.59,BPORI59,901,"I") I 'BPSINS S BPSINS=1
 S IENS=BPSINS_","_BPORI59_","
 S RXCOB=+$P($G(^BPST(BPORI59,0)),U,14) I 'RXCOB S RXCOB=1
 ;
 S INSNAME=$$LJ^XLFSTR($$GET1^DIQ(9002313.59902,IENS,902.24),32)
 I RXCOB=2 S INSNAME=INSNAME_"Coord. Of Benefits: SECONDARY"
 S BPSPOL=+$$GET1^DIQ(9002313.59902,IENS,902.35,"I")                ; pt insurance 2.312 subfile ien
 S BPSEFDT=$S(BPSPOL:+$P($G(^DPT(DFN,.312,BPSPOL,0)),U,8)\1,1:"")   ; policy effective date
 I BPSEFDT S BPSEFDT=$$FMTE^XLFDT(BPSEFDT,"5DZ")                    ; external policy effective date
 ;
 D SETLN("INSURANCE Information",1,1)
 D SETLN("Insurance      : "_INSNAME)
 D SETLN("Contact        : "_$$GET1^DIQ(9002313.59902,IENS,902.26))
 D SETLN("BIN            : "_$$GET1^DIQ(9002313.59902,IENS,902.03))
 D SETLN("PCN            : "_$$GET1^DIQ(9002313.59902,IENS,902.04))
 D SETLN("Group Number   : "_$$GET1^DIQ(9002313.59902,IENS,902.05))
 D SETLN("Cardholder ID  : "_$$GET1^DIQ(9002313.59902,IENS,902.06))
 D SETLN("Effective Date : "_BPSEFDT)
 ;
INSX ;
 D SETLN(" "),SETLN(" ")
 Q
 ;
WRAPTXT(X,DIWR,RET) ; wrap text in variable X with right margin DIWR, return in array RET
 N %,DIW,DIWF,DIWI,DIWL,DIWT,DIWTC,DIWX,DN,I,Z
 K ^UTILITY($J,"W"),RET
 S DIWL=1
 D ^DIWP
 M RET=^UTILITY($J,"W",1)
 K ^UTILITY($J,"W")
WRAPX ;
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("BPSSCRRJ",$J),^TMP("PSOPI",$J)
 Q
 ;
SETLN(TEXT,REV,UND,HIG) ; set a line into the ListMan array
 I $G(TEXT)="" S TEXT=" "
 I $L(TEXT)>80 S TEXT=$E(TEXT,1,80)
 S LINE=LINE+1
 D SET^VALM10(LINE,TEXT)
 S VALMCNT=LINE
 ;
 I $G(REV) D  G SETLNX
 . D CNTRL^VALM10(LINE,1,$L(TEXT),IORVON,IOINORM)
 . I $G(UND) D CNTRL^VALM10(LINE,$L(TEXT)+1,80,IOUON,IOINORM)
 . Q
 ;
 I $G(UND) D CNTRL^VALM10(LINE,1,80,IOUON,IOINORM)
 ;
 I $G(HIG) D CNTRL^VALM10(LINE,HIG,80,IOINHI_$S($G(UND):IOUON,1:""),IOINORM)
 ;
SETLNX ;
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)=$$DVINFO(RXIEN,RXFIL)          ; division, npi, ncpdp data
 S VALMHDR(2)=$$PTINFO(RXIEN)                ; Patient data
 S VALMHDR(3)=$$RXINFO1(RXIEN,RXFIL)         ; Rx data part 1
 S VALMHDR(4)=$$RXINFO2(RXIEN,RXFIL)         ; Rx data part 2
 Q
 ;
DVINFO(RX,RFL) ; header division data
 ;Input: (r) RX   - Rx IEN (#52)
 ;       (o) RFL  - Refill #
 N DVIEN,DVINFO,NCPNPI
 S DVINFO="Division : "_$$GET1^DIQ(9002313.59,BPORI59,11)     ; Pharmacy Division name from BPS Transaction
 ;Display both NPI and NCPDP numbers
 S DVIEN=+$$RXSITE^PSOBPSUT(RX,RFL)                           ; ICR# 4701
 S NCPNPI=$$DIVNCPDP^BPSBUTL(DVIEN)
 S $E(DVINFO,33)="NPI: "_$P(NCPNPI,U,2)
 S $E(DVINFO,59)="NCPDP: "_$P(NCPNPI,U,1)
 Q DVINFO
 ;
PTINFO(RX) ; header patient data
 ;Input: (r) RX   - Rx IEN (#52)
 N DFN,VADM,PTINFO,SSN4
 S DFN=+$P($G(^BPST(BPORI59,0)),U,6)
 D DEM^VADPT S SSN4=$P($G(VADM(2)),U,2)
 S PTINFO="Patient  : "_$E($G(VADM(1)),1,24)_"("_$E(SSN4,$L(SSN4)-3,$L(SSN4))_")"
 S PTINFO=PTINFO_"  Sex: "_$P($G(VADM(5)),U,1)
 S $E(PTINFO,61)="DOB: "_$P($G(VADM(3)),U,2)_"("_$P($G(VADM(4)),U,1)_")"
 Q PTINFO
 ;
RXINFO1(RX,FILL) ; header Rx data part 1
 N RXINFO,RXDOS,PSOET
 D GETDAT^BPSBUTL(RX,FILL,,.RXDOS) ; Get Date of Service from BPS CLAIM field 401
 S RXINFO="Rx#      : "_$$RXNUM^BPSSCRU2(RX)_"/"_FILL
 S PSOET=$$NB^BPSSCR03(BPORI59)         ; TRI/CVA non-billable entry
 S $E(RXINFO,27)="ECME#: "_$S(PSOET:"",1:$P($$CLAIM^BPSBUTL(RX,FILL),U,6))
 S $E(RXINFO,49)="Date of Service: "_$S(PSOET:"",1:$$FMTE^XLFDT(RXDOS)) ; Use DOS from BPS Claims field 401
 Q RXINFO
 ;
RXINFO2(RX,FILL) ; header Rx data part 2
 N RXINFO,DRG,CMOP
 S DRG=+$$RXAPI1^BPSUTIL1(RX,6,"I")                         ; drug ien
 S CMOP=$$DRUGDIE^BPSUTIL1(DRG,213,"I")                     ; cmop dispense field in the Drug file (0/1)
 S RXINFO=$S(CMOP:"CMOP ",1:"")_"Drug"
 S $E(RXINFO,10)=": "_$E($$RXAPI1^BPSUTIL1(RX,6),1,43)      ; drug name
 ;
 S $E(RXINFO,56)="NDC Code: "_$$GETNDC^PSONDCUT(RX,FILL)    ; ICR# 4705
 Q RXINFO
 ;
VER ; selection of View ePharmacy Rx from the BPS OPECC reject information screen
 N BPSVRX
 D FULL^VALM1
 S BPSVRX("RXIEN")=$G(RXIEN)
 S BPSVRX("FILL#")=$G(RXFIL)
 D ^BPSVRX
VERX ;
 S VALMBCK="R"
 Q
 ;
VIEW ; action for View Rx on the BPS OPECC reject information screen
 N VALMCNT,LINE,VALMHDR,TITLE,PSOVDA,DA,PS,DFN,PSODFN
 S TITLE=VALM("TITLE")
 S (PSOVDA,DA)=RXIEN,PS="REJECT"
 ;
 ; - DO structure used to avoid losing key variables in this routine
 D
 . N RXIEN,RXFIL,BPORI59,TITLE
 . D DP^PSORXVW                ; ICR# 4711
 . Q
 ;
 S VALMBCK="R",VALM("TITLE")=TITLE
 Q
 ;
MP(RXIEN,RXFIL) ; entry point for Medication Profile action on OPECC reject information screen
 N VALMCNT,LINE,VALMHDR,DFN,PSODFN,BPORI59
 D MP^PSOREJU4(RXIEN,RXFIL)     ; ICR# 6228
 S VALMBCK="R"
 Q
 ;
PI(RXIEN,RXFIL) ; entry point for Patient Information action on OPECC reject information screen
 N VALMCNT,LINE,VALMHDR,DFN,PSODFN,BPORI59
 D PI^PSOREJU4(RXIEN,RXFIL)     ; ICR# 6228
 S VALMBCK="R"
 Q
 ;

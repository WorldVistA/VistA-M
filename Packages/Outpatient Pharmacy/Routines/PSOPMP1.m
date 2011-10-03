PSOPMP1 ;BIRM/MFR - Patient Medication Profile - Listmanager ;04/28/05
 ;;7.0;OUTPATIENT PHARMACY;**260,285,281,303,289,276**;DEC 1997;Build 15
 ;Reference to ^PSDRUG("AQ" supported by IA 3165
 ;Reference to EN1^GMRADPT supported by IA 10099
 ;Reference to ^PSXOPUTL supported by IA 2200
 ;
VIDEO() ; - Changes the Video Attributes for the list
 ;
 ; - Highlighting the PRESCRIPTION line if SIG is displayed
 I $G(PSOSIGDP) D
 . F I=1:1:LINE D
 . . I $D(HIGHLN(I)) D CNTRL^VALM10(I,1,80,IOINHI,IOINORM)
 ;
 ; - Highlighting the group lines (order type and status)
 I $D(GRPLN) D
 . S LN=0 F I=1:1 S LN=$O(GRPLN(LN)) Q:'LN  D
 . . S LBL=GRPLN(LN),POS=41-($L(LBL)\2)
 . . D CNTRL^VALM10(LN,1,POS-1,IOUON_IOINHI,IOINORM)
 . . D CNTRL^VALM10(LN,POS,$L(LBL),IORVON_IOINHI,IORVOFF_IOINORM)
 . . D CNTRL^VALM10(LN,POS+$L(LBL),81-POS-$L(LBL),IOUON_IOINHI,IOINORM)
 Q
 ;
RV ;reverse video for flagged pending orders
 N PSLIST S PSLIST=0 F PSLIST=1:1:VALMCNT D
 .Q:'$D(^TMP("PSOPMP0",$J,PSLIST,"RV"))
 .I $D(^TMP("PSOPMP0",$J,PSLIST,"RV")) D CNTRL^VALM10(PSLIST,1,3,IORVON,IORVOFF,0) Q
 Q
 ;
SETHDR() ; - Displays the Header Line
 N HDR,ORD,POS
 ;
 ; - Line 1
 S $E(HDR,57)="ISSUE",$E(HDR,66)="LAST",$E(HDR,74)="REF",$E(HDR,78)="DAY"
 S $E(HDR,81)="" D INSTR^VALM1(IORVON_HDR_IOINORM,1,6)
 ; - Line 2
 S HDR="  #",$E(HDR,5)="Rx#",$E(HDR,19)="DRUG",$E(HDR,49)="QTY",$E(HDR,53)="ST"
 S $E(HDR,57)="DATE",$E(HDR,66)="FILL",$E(HDR,74)="REM",$E(HDR,78)="SUP"
 S $E(HDR,81)="" D INSTR^VALM1(IORVON_HDR_IOINORM,1,7)
 S ORD=$S(PSORDER="A":"[^]",1:"[v]")
 S:PSOSRTBY="RX" POS=9 S:PSOSRTBY="DR" POS=24 S:PSOSRTBY="ID" POS=61 S:PSOSRTBY="LF" POS=70
 D INSTR^VALM1(IOINHI_IORVON_ORD_IOINORM,POS,7)
 Q
 ;
SETSIG(TYPE,RX,LINE,DFN) ; Set the SIG line
 N FSIG,L,X,DIWL,DIWR
 ;
 I TYPE="N" D  Q
 . K ^UTILITY($J,"W")
 . S X=$$SCHED^PSONVNEW($$GET1^DIQ(55.05,RX_","_DFN,4)),DIWL=1,DIWR=71 D ^DIWP
 . F L=1:1 Q:'$D(^UTILITY($J,"W",1,L))  D
 . . S X="" S:L=1 $E(X,5)="SIG:" S $E(X,10)=^UTILITY($J,"W",1,L,0)
 . . S LINE=LINE+1,^TMP("PSOPMP0",$J,LINE,0)=X
 ;
 D FSIG^PSOUTLA(TYPE,+RX,71)
 F L=1:1 Q:'$D(FSIG(L))  D
 . S X="" S:L=1 $E(X,5)="SIG:" S $E(X,10)=FSIG(L)
 . S LINE=LINE+1,^TMP("PSOPMP0",$J,LINE,0)=X
 Q
 ;
GROUP(LBL,CNT,LINE) ; Sets a group delimiter line
 N X,POS
 S LBL=LBL_$S(PSORDCNT:" ("_CNT_" order"_$S(CNT>1:"s",1:"")_")",1:"")
 S POS=41-($L(LBL)\2)
 S X="",$P(X," ",81)="",$E(X,POS,POS-1+$L(LBL))=LBL
 S LINE=LINE+1,^TMP("PSOPMP0",$J,LINE,0)=X,GRPLN(LINE)=LBL
 Q
 ;
PENHDR(DFN) ; Sets the Header in the ^TMP("PSOHDR",$J) global for displaying individual Pending Order
 N VADM,WT,HT,PSOERR,GMRA
 K ^TMP("PSOHDR",$J) D ^VADPT,ADD^VADPT
 S ^TMP("PSOHDR",$J,1,0)=VADM(1),^TMP("PSOHDR",$J,2,0)=$P(VADM(2),"^",2)
 S ^TMP("PSOHDR",$J,3,0)=$P(VADM(3),"^",2),^TMP("PSOHDR",$J,4,0)=VADM(4),^TMP("PSOHDR",$J,5,0)=$P(VADM(5),"^",2)
 S POERR=1 D RE^PSODEM K PSOERR
 S ^TMP("PSOHDR",$J,6,0)=$S(+$P(WT,"^",8):$J($P(WT,"^",9),6)_" ("_$P(WT,"^")_")",1:"_______ (______)")
 S ^TMP("PSOHDR",$J,7,0)=$S($P(HT,"^",8):$J($P(HT,"^",9),6)_" ("_$P(HT,"^")_")",1:"_______ (______)") K VM,WT,HT S PSOHD=7
 S GMRA="0^0^111" D EN1^GMRADPT S ^TMP("PSOHDR",$J,8,0)=+$G(GMRAL)
 Q
 ;
FILTER(RX) ; - Filter Rx's that should not be displayed
 I $$GET1^DIQ(52,RX,26,"I")<PSOEXPDC Q 1
 I $$GET1^DIQ(52,RX,26.1,"I"),$$GET1^DIQ(52,RX,26.1,"I")<PSOEXPDC,$$GET1^DIQ(52,RX,100,"I")>11,$$GET1^DIQ(52,RX,100,"I")'=16 Q 1
 I $$GET1^DIQ(52,RX,100,"I")=""!($$GET1^DIQ(52,RX,100,"I")=13) Q 1
 I $$GET1^DIQ(52,RX,.01)="" Q 1
 Q 0
 ;
STSINFO(RX) ; Returns the Rx Status MNEMONIC^NAME
 ; Input: RX - Prescription IEN (#52)
 ;Output: Status Mnemonic ("A","DC",etc.)^Status Name ("ACTIVE","DISCONTINUED",etc.)
 ;
 N STS
 I '$D(^PSRX(RX,"STA")) Q ""
 S STS=$$GET1^DIQ(52,RX,100,"I")
 I STS=0 Q:$$GET1^DIQ(52,RX,26,"I")>DT PSOSTSEQ("A") Q PSOSTSEQ("E")
 I STS=1 Q PSOSTSEQ("N")
 I STS=3 Q PSOSTSEQ("H")
 I STS=5 Q PSOSTSEQ("S")
 I STS=11 Q PSOSTSEQ("E")
 I STS=12 Q PSOSTSEQ("DC")
 I STS=14 Q PSOSTSEQ("DP")
 I STS=15 Q PSOSTSEQ("DE")
 I STS=16 Q PSOSTSEQ("PH")
 Q "99^UNKNOWN^??"
 ; 
ISSDT(IEN,TYPE) ; Returns the Rx ISSUE DATE formatted MM-DD-YY
 ;Input: RX   - Prescription IEN (#52)
 ;       TYPE - "R":Regular Rx, "P":Pending order
 N ISSDT
 I TYPE="R" S ISSDT=$$GET1^DIQ(52,IEN,1,"I")
 I TYPE="P" S ISSDT=$$GET1^DIQ(52.41,IEN,6,"I")
 I ISSDT'="" S ISSDT=ISSDT\1
 ;
 Q (ISSDT_"^"_$$DAT(ISSDT,"-"))
 ;
LSTFD(RX) ; Returns the Rx LAST FILL DATE formatted MM-DD-YY[R], where [R] = Returned to Stock
 ;Input: RX  - Prescription IEN (#52)
 N LSTFD,RTSTK,RFL
 S LSTFD=$$GET1^DIQ(52,RX,101,"I")\1 I LSTFD="" Q ""
 I '$$LSTRFL^PSOBPSU1(RX) D
 . I $$GET1^DIQ(52,RX,32.1,"I") S RTSTK="R"
 E  S RFL=0 F  S RFL=$O(^PSRX(RX,1,RFL)) Q:'RFL  D
 . I $$RXFLDT^PSOBPSUT(RX,RFL)'=LSTFD Q
 . I $$GET1^DIQ(52.1,RFL_","_RX,14,"I") S RTSTK="R"
 ;
 Q (LSTFD_"^"_$$DAT(LSTFD,"-")_$G(RTSTK))
 ;
REFREM(RX) ; - Returns the number of refills remaining
 N REFREM,RFL
 S REFREM=+$$GET1^DIQ(52,RX,9)
 F RFL=0:1 S RFL=$O(^PSRX(RX,1,RFL)) Q:'RFL  S REFREM=REFREM-1
 Q $S(REFREM<0:0,1:REFREM)
 ;
 ;
DAT(FMDT,SEP,Y4) ; - Formats FM dates to MM/DD/YY (SEP: Separator:"/","-",etc...)
 ;Input: (r) FMDT - Fileman Date
 ;       (r) SEP  - Separator
 ;       (o) Y4   - 4 digits year flag
 I $G(FMDT)="" Q ""
 I '$E(FMDT,6,7)!'$E(FMDT,4,7) Q $$UP^XLFSTR($TR($$FMTE^XLFDT(FMDT)," ","-"))
 Q ($E(FMDT,4,5)_SEP_$E(FMDT,6,7)_SEP_$S($G(Y4):$E(FMDT,1,3)+1700,1:$E(FMDT,2,3)))
 ;
COPAY(RX) ; Returns "$" is Rx has a copay and "" if not
 Q $S($G(^PSRX(RX,"IB")):"$",1:"")  ;*276
 ;
CMOP(DRUG,RX) ; Returns the CMOP indicator (">", "T", etc)
 N CMOP,X,DA,PSXZ
 S CMOP="" I $D(^PSDRUG("AQ",DRUG)) S CMOP=">"
 I $G(RX) S DA=RX D ^PSXOPUTL I $G(PSXZ(PSXZ("L")))=0!($G(PSXZ(PSXZ("L")))=2) S CMOP="T"
 Q CMOP
 ;
ALLERGY(LINE,DFN,POS) ; also called from PSONVAVW & PSOPMP0
 ; Input:  LINE - (r) text to concatenate allergy information to
 ;         DFN - (r) patient IEN used for ^GMRADTP
 ;         POS - (o) position # to include text
 ;Output: LINE - modified text
 N ALLERGY,PSONOAL
 S (PSONOAL,ALLERGY)=""
 D EN1^GMRADPT
 I GMRAL S ALLERGY="<A>"
 E  D ALLERGY^PSOORUT2 I PSONOAL'="" S ALLERGY="<NO ALLERGY ASSESSMENT>"
 S ALLERGY=IORVON_ALLERGY_IORVOFF_IOINORM
 I '$G(POS) S POS=80-$L(ALLERGY)
 S LINE=$$SETSTR^VALM1(ALLERGY,LINE,POS,80)
 Q LINE

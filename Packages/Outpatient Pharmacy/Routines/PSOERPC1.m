PSOERPC1 ;BIRM/MFR - All Patients (Patient Centric) eRx Queue - Supporting APIs 1 ; 12/10/22 10:07am
 ;;7.0;OUTPATIENT PHARMACY;**700,750,746,770**;DEC 1997;Build 145
 ;
HDR ; - Displays the Header Line
 N LINE1,LINE2,HDR,SRTORD,SRTPOS
 S LINE1="LOOK BACK DAYS: "_IOINHI_PSOLKBKD_IOINORM
 S $E(LINE1,40)="CS/NON-CS: "_IOINHI_$S(PSOCSERX="CS":"CS ONLY",PSOCSERX="Non-CS":"NON-CS ONLY",1:"BOTH")
 S:PSOCSERX'="Non-CS" LINE1=LINE1_" ("_$S(PSOCSSCH=1:"II",PSOCSSCH=2:"III-V",1:"II-V")_")"
 S LINE1=LINE1_IOINORM
 D INSTR^VALM1("MAX. QUEUE SIZE: "_IOINHI_$J(PSOMAXQS,4)_IOINORM,60,2)
 ;
 S LINE2="ERX STATUS: "_IOINHI
 I PSOSTFLT="A" S LINE2=LINE2_"ALL"
 I PSOSTFLT="N" S LINE2=LINE2_"NEW"
 I PSOSTFLT="I" S LINE2=LINE2_"IN PROGRESS"
 I PSOSTFLT="W" S LINE2=LINE2_"WAIT"
 I PSOSTFLT="H" S LINE2=LINE2_$S(PSOHDSTS="ALL":"HOLD (ALL)",1:"HOLD ("_PSOHDSTS_")")
 I PSOSTFLT="C" S LINE2=LINE2_$S(PSOCCRST="ALL":"CCR (ALL)",1:"CCR ("_PSOCCRST_")")
 S LINE2=LINE2_IOINORM
 S LINE3=""
 I $D(PATFLTR)!$G(DOBFLTR)!$G(MATFLTR) D
 . N FILTER S FILTER=""
 . I $G(MATFLTR) S FILTER=FILTER_"|MATCH("_$$MATCHLBL^PSOERPC2(MATFLTR)_")"
 . I $G(DOBFLTR) S FILTER=FILTER_"|DOB("_$$FMTE^XLFDT(DOBFLTR,"2Z")_")"
 . I $D(PATFLTR) S FILTER=FILTER_"|PATIENT("_$$EPATFLST^PSOERUT(53)_")"
 . S $E(FILTER,1)="" I $L(FILTER)>63 S FILTER=$E(FILTER,1,60)_"..."
 . S FILTER=FILTER
 . S LINE2="FILTERED BY: "_IOINHI_FILTER_IOINORM
 K VALMHDR S VALMHDR(1)=LINE1,VALMHDR(2)=LINE2
 ;
 S HDR="#",$E(HDR,5)="PATIENT",$E(HDR,30)="DOB",$E(HDR,41)="SSN",$E(HDR,54)="ED"
 S $E(HDR,58)="NW",$E(HDR,61)="WT",$E(HDR,64)="IP",$E(HDR,67)="HD",$E(HDR,70)="CCR"
 S $E(HDR,74)="OTH",$E(HDR,78)="TOT"
 D INSTR^VALM1(IORVON_HDR_IOINORM,1,4)
 S SRTORD=$S(PSORDER="A":"^",1:"v")
 S SRTPOS=$S(PSOSRTBY="PA":12,PSOSRTBY="DOB":33,PSOSRTBY="ED":56)
 D INSTR^VALM1(IOINHI_IORVON_SRTORD_IOINORM,SRTPOS,4)
 Q
 ;
SETSORT ; - Set Patient List
 N EXPAT,MSGDT,ERXIEN,STSIEN,STSLST,ERXSTS,INST
 S PATCNT=0
 ; - Filter By eRx Patient is set
 I $D(PATFLTR) D  Q
 . S ERXPAT="" F  S ERXPAT=$O(PATFLTR(ERXPAT)) Q:'ERXPAT  D  I PATCNT'<PSOMAXQS Q
 . . I $G(DOBFLTR),'$D(^PS(52.46,"DOB",DOBFLTR,ERXPAT)) Q
 . . S MSGDT=$$FMADD^XLFDT(DT,-PSOLKBKD)-.1
 . . F  S MSGDT=$O(^PS(52.49,"PAT2",ERXPAT,MSGDT)) Q:'MSGDT  D  I PATCNT'<PSOMAXQS Q
 . . . S ERXIEN=0 F  S ERXIEN=$O(^PS(52.49,"PAT2",ERXPAT,MSGDT,ERXIEN)) Q:'ERXIEN  D  I PATCNT'<PSOMAXQS Q
 . . . . D SETPAT(ERXIEN,.PATCNT)
 ;
 ; - Filter By eRx Patient DOB is set
 I $G(DOBFLTR)'="" D  Q
 . S ERXPAT=0 F  S ERXPAT=$O(^PS(52.46,"DOB",DOBFLTR,ERXPAT)) Q:'ERXPAT  D  I PATCNT'<PSOMAXQS Q
 . . I $D(PATFLTR),'$D(PATFLTR(ERXPAT)) Q
 . . S MSGDT=$$FMADD^XLFDT(DT,-PSOLKBKD)-.1
 . . F  S MSGDT=$O(^PS(52.49,"PAT2",ERXPAT,MSGDT)) Q:'MSGDT  D  I PATCNT'<PSOMAXQS Q
 . . . S ERXIEN=0 F  S ERXIEN=$O(^PS(52.49,"PAT2",ERXPAT,MSGDT,ERXIEN)) Q:'ERXIEN  D  I PATCNT'<PSOMAXQS Q
 . . . . D SETPAT(ERXIEN,.PATCNT)
 ;
 ; - Specific Status(es) Selected
 I $G(PSOSTFLT)'="A" D  Q
 . D LOADSTS(.STSLST)
 . I '$G(MBMSITE) D
 . . S ERXSTS=0 F  S ERXSTS=$O(STSLST(ERXSTS)) Q:'ERXSTS  D  I PATCNT'<PSOMAXQS Q
 . . . S MSGDT=$$FMADD^XLFDT(DT,-PSOLKBKD)-.1
 . . . F  S MSGDT=$O(^PS(52.49,"E",+$G(PSNPINST),ERXSTS,MSGDT)) Q:'MSGDT  D  I PATCNT'<PSOMAXQS Q
 . . . . S ERXIEN=0 F  S ERXIEN=$O(^PS(52.49,"E",+$G(PSNPINST),ERXSTS,MSGDT,ERXIEN)) Q:'ERXIEN  D  I PATCNT'<PSOMAXQS Q
 . . . . . D SETPAT(ERXIEN,.PATCNT)
 . E  D
 . . S MSGDT=$$FMADD^XLFDT(DT,-PSOLKBKD)-.1
 . . F  S MSGDT=$O(^PS(52.49,"AMSGDTSTS",MSGDT)) Q:'MSGDT  D  I PATCNT'<PSOMAXQS Q
 . . . S ERXSTS=0 F  S ERXSTS=$O(^PS(52.49,"AMSGDTSTS",MSGDT,ERXSTS)) Q:'ERXSTS  D  I PATCNT'<PSOMAXQS Q
 . . . . I '$D(STSLST(ERXSTS)) Q
 . . . . S ERXIEN=0 F  S ERXIEN=$O(^PS(52.49,"AMSGDTSTS",MSGDT,ERXSTS,ERXIEN)) Q:'ERXIEN  D  I PATCNT'<PSOMAXQS Q
 . . . . . D SETPAT(ERXIEN,.PATCNT)
 ;
 ; - No Filters (Catch All)
 S MSGDT=$$FMADD^XLFDT(DT,-PSOLKBKD)-.1
 F  S MSGDT=$O(^PS(52.49,"AMSGDTSTS",MSGDT)) Q:'MSGDT  D  I PATCNT'<PSOMAXQS Q
 . S ERXSTS=0 F  S ERXSTS=$O(^PS(52.49,"AMSGDTSTS",MSGDT,ERXSTS)) Q:'ERXSTS  D  I PATCNT'<PSOMAXQS Q
 . . I '$$ELIGSTS("PC",$P($G(^PS(52.45,ERXSTS,0)),"^")) Q
 . . S ERXIEN=0 F  S ERXIEN=$O(^PS(52.49,"AMSGDTSTS",MSGDT,ERXSTS,ERXIEN)) Q:'ERXIEN  D  I PATCNT'<PSOMAXQS Q
 . . . ; Related Institution Check (VAMCs only)
 . . . I '$G(MBMSITE),+$G(^PS(52.49,ERXIEN,24))'=PSNPINST Q
 . . . D SETPAT(ERXIEN,.PATCNT)
 Q
 ;
SETPAT(ERXIEN,PATCNT) ; - Builds a sorted list of Patients
 ;Input: (r)ERXIEN - eRx IEN (Pointer to #52.49)
 ;       (r)PATCNT - (by Ref) Counter for Patient (used to control the max number of patients in the list)
 N EPATIEN,PATNAME,ERXNODE0,ERXINST,DOB,ESCODE,MTYPE,DRGCSCH,PATSTATS,RCVDATE,Z,SORT,ED
 N VPATIEN,VPRVIEN,VDRGIEN,CSERX,ERXINST,EPTNODE0,EPTNODE1,EPTNODE2,GRP,SRT,SSN,STSIEN,ERXSTS
 ;
 S ERXNODE0=$G(^PS(52.49,ERXIEN,0))
 S STSIEN=+$G(^PS(52.49,ERXIEN,1)) I 'STSIEN Q
 S ERXSTS=$P($G(^PS(52.45,STSIEN,0)),"^")
 S EPATIEN=+$P(ERXNODE0,"^",4) I 'EPATIEN Q
 ; - Patient already on the list (or excluded by Basic Match filter)
 I $D(^TMP("PSOERPAT",$J,EPATIEN)) Q
 ;
 S MTYPE=$P(ERXNODE0,"^",8)
 S ERXINST=+$G(^PS(52.49,ERXIEN,24)),CSERX=+$G(^PS(52.49,ERXIEN,95))
 ; If the eRx is a new refill request and the status is refill request new, check for a response. 
 ; If no response within 14 days, change to RRE (refill request expired)
 I MTYPE="RR",ERXSTS="RRN" D CHKEXP^PSOERX(ERXIEN,MTYPE)
 ; ChangeRequest messages will be checked for expiration status, but will not be displayed in the holding queue list view.
 I MTYPE="CR",ERXSTS="CRN" D CHKEXP^PSOERX(ERXIEN,MTYPE)
 ;
 ; - Related Institution Filter (Non-MbM sites only)
 I '$G(MBMSITE),PSNPINST'=ERXINST Q
 ;
 ; - Controlled Substance Prompts Filter
 I $G(PSOCSERX)="CS",'CSERX Q
 I $G(PSOCSERX)="Non-CS",CSERX Q
 I '$$CSFILTER^PSOERXUT(ERXIEN) Q
 ;
 ; - Match Status Filter
 I $G(MATFLTR),'$$MATCHFLT^PSOERPC2(MATFLTR,EPATIEN) S ^TMP("PSOERPAT",$J,EPATIEN)="" Q
 ;
 ; - Checking/Filtering Statuses
 I '$$ELIGSTS("PC",ERXSTS,MTYPE) Q
 ;
 S Z=$$PATSTATS(EPATIEN),SORT=EPATIEN
 S EPTNODE0=$G(^PS(52.46,EPATIEN,0)),EPTNODE1=$G(^PS(52.46,EPATIEN,1)),EPTNODE2=$G(^PS(52.46,EPATIEN,2))
 S PATNAME=$P(EPTNODE0,"^") S:PSOSRTBY="PA" SORT=PATNAME_" "_EPATIEN
 S DOB=$P(EPTNODE1,"^",4) S:PSOSRTBY="DOB" SORT=DOB_" "_EPATIEN
 S SSN=$P(EPTNODE2,"^",4)
 S:PSOSRTBY="ED" ED=+Z,SORT=$E(ED+10000,2,5)_" "_(1000000000-ERXIEN)
 S CSERX=+$P(Z,"^",8),CSGROUP=$S('PSOCSGRP:"ALL",CSERX:"CS",1:"NON-CS")
 S ^TMP("PSOERPCS",$J,CSGROUP,SORT)=PATNAME_"^"_$$FMTE^XLFDT(DOB,"5DZ")_"^"_SSN_"^"_Z
 S ^TMP("PSOERPCS",$J,CSGROUP,SORT,"PATIEN")=EPATIEN
 S ^TMP("PSOERPAT",$J,EPATIEN)=""
 S PATCNT=$G(PATCNT)+1
 Q
 ;
PATSTATS(PATIEN) ; Set the Numbers (Stat Columns data) of eRx by Patient
 ; Input: PATIEN - eRx Patient IEN (Pointer to #52.46)
 ;Output: Patient Stats: P1: Highest Elapsed Days
 ;                       P2: Number of New eRx's
 ;                       P3: Number of eRx's on 'Wait' Status
 ;                       P4: Number of eRx's on 'In Progress' Statuses
 ;                       P5: Number of eRx's on 'On Hold' Statuses
 ;                       P6: Number of eRx's on 'CCR' Statuses
 ;                       P7: Number of eRx's on 'Other' Statuses
 ;                       P8: Number of CS eRx's
 N PATSTATS,MSGDT,ERXIEN,CSERX,STSIEN,EXTSTS
 I $G(PSOLKBKD)="" S PSOLKBKD=$$GET1^DIQ(59,PSOSITE,10.2) S:'PSOLKBKD PSOLKBKD=365
 S MSGDT=$$FMADD^XLFDT(DT,-PSOLKBKD),PATSTATS=""
 F  S MSGDT=$O(^PS(52.49,"PAT2",PATIEN,MSGDT)) Q:'MSGDT  D
 . S ERXIEN=0 F  S ERXIEN=$O(^PS(52.49,"PAT2",PATIEN,MSGDT,ERXIEN)) Q:'ERXIEN  D
 . . S CSERX=+$G(^PS(52.49,ERXIEN,95))
 . . S MTYPE=$P($G(^PS(52.49,ERXIEN,0)),"^",8)
 . . ; eRx Status Check
 . . S STSIEN=+$G(^PS(52.49,ERXIEN,1)) I 'STSIEN Q
 . . S EXTSTS=$P($G(^PS(52.45,STSIEN,0)),"^")
 . . I '$$ELIGSTS("PC",EXTSTS,MTYPE) Q
 . . ; - CS/Non-CS Filter
 . . I $G(PSOCSERX)="Non-CS",CSERX Q
 . . I $G(PSOCSERX)="CS",'CSERX Q
 . . ; - Setting Largest Elapsed Days (1st piece)
 . . I $$FMDIFF^XLFDT(DT,MSGDT)>+PATSTATS D
 . . . S $P(PATSTATS,"^",1)=$$FMDIFF^XLFDT(DT,MSGDT)
 . . ; - Data for the eRx Count columns (New, In Progress, Wait, on Hold, CCR, Other)
 . . I EXTSTS="N" S $P(PATSTATS,U,2)=$P(PATSTATS,U,2)+1
 . . I ",W,RXW,CXW,"[(","_EXTSTS_",") S $P(PATSTATS,U,3)=$P(PATSTATS,U,3)+1
 . . I ",I,RXI,CXI,"[(","_EXTSTS_",") S $P(PATSTATS,U,4)=$P(PATSTATS,U,4)+1
 . . I $E(EXTSTS)="H" S $P(PATSTATS,U,5)=$P(PATSTATS,U,5)+1
 . . I ",RXN,RXE,RXR,RXD,RXF,CAO,CAR,CAH,CAP,CAX,CAF,CXD,CXN,CXV,CXY,CXE,"[(","_EXTSTS_",") D
 . . . S $P(PATSTATS,U,6)=$P(PATSTATS,U,6)+1
 . . I MTYPE="IE",",RRE,CRE,"[(","_EXTSTS_",") S $P(PATSTATS,U,7)=$P(PATSTATS,U,7)+1
 . . I $G(PSOCSERX)'="Non-CS",CSERX S $P(PATSTATS,U,8)=$P(PATSTATS,U,8)+1
 Q PATSTATS
 ;
ELIGSTS(VIEW,ERXSTS,MSGTYPE) ; Checks whether the eRx's status is eligible to be on the list (counted)
 ; Input: VIEW    - View: "PC" - Patient Centric View | "RX" - Rx Medication View
 ;        ERXSTS  - eRx Status (External format: e.g.,"N","HDI", "I", etc...)
 ;     [o]MSGTYPE - Message Type ("N","RE","RR","CR", etc...)
 ;Output: 1 - eRx is eligible to be on the list | 0 - eRx is not Eligible to be on the list
 N STS,CCRSTS,SKIP
 S MSGTYPE=$G(MSGTYPE)
 ;
 ; If Any filter is selected, ignore the initial filter (upon entering the option)
 S STS=","_$S($E(ERXSTS)="H":$E(ERXSTS,1),$G(MBMSITE)&($E(ERXSTS,1,3)="REM"):"REM",1:ERXSTS)_","
 ; List is not Filtered
 I '$$FILTERED(VIEW),",RJ,RM,REM,PR,E,RXA,CXA,CAA,CXP,RXP,RXC,RRC,RXA,CAN,ICA,CNP,CRP,CRC,CXC,CNE,CRN,CRE,CRR,CRX,RRX,CXQ,RXA,"[STS Q 0
 I VIEW="PC",",RRE,RXI,RXW,RXR,RXE,RXN,RXD,RXF,CAH,CAO,CAP,CAR,CAX,CAF,CXD,CXN,CXV,CXY,CXE,CXI,CXW,CRE,N,I,W,H,"'[STS Q 0
 ; Match Status Filter (Only New, In Progress, Wait or Hold statuses are included)
 I $G(MATFLTR) I ",N,RXN,CXN,RXI,I,CXI,RXW,W,CXW,"'[STS Q 0
 ;
 ; Filter Inbound Error RRE and RenewalRequests For Patient Centric View
 I '$$FILTERED(VIEW) Q:((MSGTYPE="IE")&(ERXSTS'="RRE")&(ERXSTS'="CRE")) 0 Q:(MSGTYPE="RR") 0
 I VIEW="PC",'$$FILTERED(VIEW),MSGTYPE="RE","RXP,RXC,RXA,RRP,"[STS Q 0
 ;
 I '$G(STSFLTR),$G(MSTPFLTR)="",MSGTYPE="CR",ERXSTS="CRE" Q 0
 ;
 S SKIP=0
 I '$$FILTERED(VIEW) D  I SKIP Q 0
 . I $G(PSOSTFLT)="N",",RXN,N,CXN,"'[STS S SKIP=1 Q
 . I $G(PSOSTFLT)="I",",RXI,I,CXI,"'[STS S SKIP=1 Q
 . I $G(PSOSTFLT)="W",",RXW,W,CXW,"'[STS S SKIP=1 Q
 . I $G(PSOSTFLT)="C" D  S SKIP=$S(PSOCCRST="ALL"&(CCRSTS[STS):0,PSOCCRST'="ALL"&(PSOCCRST=ERXSTS):0,1:1) Q
 . . S CCRSTS=",RXN,RXR,RXE,RXD,RXF,CAO,CAR,CAH,CAP,CAX,CAF,CXD,CXN,CXV,CXY,CXE,"
 . I $G(PSOSTFLT)="H" S SKIP=$S(PSOHDSTS="ALL"&(STS=",H,"):0,PSOHDSTS'="ALL"&(PSOHDSTS=ERXSTS):0,1:1) Q
 ; Default: Eligible
 Q 1
 ;
FILTERED(VIEW) ; Return whether the list is being filtered or not
 ; Input: VIEW    - View: "PC" - Patient Centric View | "RX" - Rx Med View
 ;Output: 0 - No filters | 1 - Filters are in place
 I $G(VIEW)="PC",$D(PATFLTR)!$G(DOBFLTR)!$G(MATFLTR) Q 1
 I $G(VIEW)="RX",$D(PATFLTR)!$G(DOBFLTR)!$G(REDTFLTR)!$D(PRVFLTR)!$G(STSFLTR)!($G(DRGFLTR)'="")!$D(VPATFLTR)!$D(VPRVFLTR)!$D(VDRGFLTR)!($G(MSTPFLTR)'="")!$G(MATFLTR) Q 1
 Q 0
 ;
HLDSTS() ; - Prompt User for Hold eRx Status
 N Y,DIC,X,HLDSTS
 S DIC("A")="Select eRx Status: "
 S DIC=52.45,DIC(0)="AEQ",DIC("S")="I $D(^PS(52.45,""TYPE"",""ERX"",Y)),($E($P(^PS(52.45,Y,0),U))=""H"")"
 S DIC("W")="W "" - "",$P($G(^(0)),""^"",2)"
 W ! D ^DIC K DIC I X=U!($D(DUOUT))!(Y<1) Q ""
 S HLDSTS=$$UP^XLFSTR(X) I +HLDSTS S HLDSTS=$$GET1^DIQ(52.45,+HLDSTS,.01)
 Q HLDSTS
 ;
CCRSTS(LST) ; - Prompt User for CCR eRx Status
 N I,DONE,DIC,Y,X,CODE,CARY,CIEN
 S DONE=0
 F I=1:1 D  Q:DONE
 .S CODE=$P(LST,U,I) I CODE="" S DONE=1 Q
 .S CIEN=$$PRESOLV^PSOERXA1(CODE,"ERX")
 .S CARY(CIEN)=""
 S DIC("A")="Select eRx Status: "
 S DIC=52.45,DIC(0)="AEQ",DIC("S")="I $D(^PS(52.45,""TYPE"",""ERX"",Y)),$D(CARY(Y))"
 S DIC("W")="W "" - "",$P($G(^(0)),""^"",2)"
 W ! D ^DIC K DIC I X=U!($D(DUOUT))!(Y<1) Q ""
 Q X
 ;
NEXTPAT(CURPTIEN) ; Returns the next Patient on the Queue to be worked on
 ; Input: (o)CURPTIEN - Current eRx Patient IEN (Pointer to #52.46) (If not passed, start with first patient)
 ;Output:    NEXTPAT  - Next eRx Patient on the Queue
 N NEXTPAT,STSLST,ERXSTS,STS,MSGDT,ERXIEN,EPATIEN,VPATIEN,VPRVIEN,VDRGIEN,ERXNODE0,ERXSTS,CSERX,LKBKDAYS,REACH
 K ^TMP("PSOERSKP",$J)
 D LOADSTS(.STSLST)
 S (NEXTPAT,INST)=0
 S LKBKDAYS=PSOLKBKD I PSOSTFLT="WP",$$GET1^DIQ(59,PSOSITE,10.2)>PSOLKBKD S LKBKDAYS=$$GET1^DIQ(59,PSOSITE,10.2)
 S MSGDT=$$FMADD^XLFDT(DT,-LKBKDAYS)-.1,REACH=$S($G(CURPTIEN):0,1:1)
 F  S MSGDT=$O(^PS(52.49,"AMSGDTSTS",MSGDT)) Q:'MSGDT  D  I NEXTPAT Q
 . S ERXSTS=999999 F  S ERXSTS=$O(^PS(52.49,"AMSGDTSTS",MSGDT,ERXSTS),-1) Q:'ERXSTS  D  I NEXTPAT Q
 . . ; eRx Status Check
 . . I '$D(STSLST(ERXSTS)) Q
 . . S ERXIEN=0 F  S ERXIEN=$O(^PS(52.49,"AMSGDTSTS",MSGDT,ERXSTS,ERXIEN)) Q:'ERXIEN  D  I NEXTPAT Q
 . . . ; Related Institution Check
 . . . I '$G(MBMSITE),+$G(^PS(52.49,ERXIEN,24))'=$G(PSNPINST) Q
 . . . S ERXNODE0=$G(^PS(52.49,ERXIEN,0))
 . . . S EPATIEN=+$P(ERXNODE0,"^",4),VPATIEN=+$P(ERXNODE0,"^",5),CSERX=+$G(^PS(52.49,ERXIEN,95))
 . . . S VPRVIEN=+$P($G(^PS(52.49,ERXIEN,2)),"^",3),VDRGIEN=+$P($G(^PS(52.49,ERXIEN,3)),"^",2)
 . . . I $D(^TMP("PSOERSKP",$J,EPATIEN)) Q
 . . . I $G(CURPTIEN),EPATIEN=CURPTIEN S REACH=1 Q
 . . . I 'REACH S ^TMP("PSOERSKP",$J,EPATIEN)="" Q
 . . . ; - Match Status Filter
 . . . I $G(MATFLTR),'$$MATCHFLT^PSOERPC2(MATFLTR,EPATIEN) S ^TMP("PSOERSKP",$J,EPATIEN)="" Q
 . . . ; - CS/Non-CS Parameter Status Filter
 . . . I $G(PSOCSERX)="CS",'CSERX Q
 . . . I $G(PSOCSERX)="Non-CS",CSERX Q
 . . . I PSOSTFLT="WP",$D(^XUSEC("PSO ERX WORKLOAD TECH",DUZ)),$D(^XTMP("PSOERXWP",EPATIEN)),'$D(^XTMP("PSOERXWP",EPATIEN,DUZ)) Q
 . . . S NEXTPAT=EPATIEN
 K ^TMP("PSOERSKP",$J)
 I $G(CURPTIEN),'NEXTPAT,$$NEXTPAT(0)'=CURPTIEN S NEXTPAT=$$NEXTPAT(0)
 Q NEXTPAT
 ;
LOADSTS(STSLST) ; Load Status Filter Array based on the Filter selected
 ;Output: STSLST - Return Array passed in by Reference with status IEN as Index (e.g., ARRAY(124))
 N STS
 K STSLST
 S PSOSTFLT=$G(PSOSTFLT),PSOCCRST=$G(PSOCCRST),PSOHDSTS=$G(PSOHDSTS)
 I PSOSTFLT="A"!(PSOSTFLT="N") S STSLST($$STSIEN("N"))=""
 I PSOSTFLT="WP" F STS="N","I","W" S STSLST($$STSIEN(STS))=""
 I PSOSTFLT="A"!(PSOSTFLT="I") F STS="I","RXI","CXI" S STSLST($$STSIEN(STS))=""
 I PSOSTFLT="A"!(PSOSTFLT="W") F STS="W","RXW","CXW" S STSLST($$STSIEN(STS))=""
 I PSOSTFLT="A"!(PSOSTFLT="C") D
 . I PSOSTFLT="A"!(PSOCCRST="ALL") D
 . . F STS="RXN","RXR","RXE","RXD","RXF","CAO","CAR","CAH","CAP","CAX","CAF","CXD","CXN","CXV","CXY","CXE","RRE" D
 . . . S STSLST($$STSIEN(STS))=""
 . E  I PSOCCRST'="" S STSLST($$STSIEN(PSOCCRST))=""
 I PSOSTFLT="A"!(PSOSTFLT="H") D
 . I PSOSTFLT="A"!(PSOHDSTS="ALL") D
 . . S STS="GZ" F  S STS=$O(^PS(52.45,"B",STS)) Q:$E(STS)'="H"!(STS="")  D
 . . . S STSLST($$STSIEN(STS))=""
 . E  I PSOHDSTS'="" S STSLST($$STSIEN(PSOHDSTS))=""
 Q
 ;
STSIEN(STS) ; Returns the eRx Status IEN
 ; Input: STS - eRx Status (external format, e.g., 'N', 'I', 'RXN', etc.)
 ;Output: ### -  eRx Status IEN (internal format - pointer to #52.45)
 I $G(STS)="" Q 0
 Q +$O(^PS(52.45,"B",$G(STS),0))
 ;
LOCK(PATIEN) ; Locks eRx Patient
 ; Input: PATIEN - eRx Patient IEN (Pointer to #52.46)
 ;Output: 1 - Patient Locked Successfully | Patient Not Locked (Already Locked)
 ; - Locking the eRx Patient
 N ERXLOCK
 S ERXLOCK=$$L^PSOERX1A(PATIEN,1,1)
 I 'ERXLOCK D  Q 0
 . S VALMSG="Patient Locked"
 . I $G(^XTMP("PSOERXLOCK",PATIEN)) D
 . . S VALMSG=VALMSG_":"_$E($$GET1^DIQ(200,+$G(^XTMP("PSOERXLOCK",PATIEN)),.01),1,20)
 . . S VALMSG=VALMSG_"|"_$$FMTE^XLFDT($P($G(^XTMP("PSOERXLOCK",PATIEN)),"^",2),"2Z")
 Q 1

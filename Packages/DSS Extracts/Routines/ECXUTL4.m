ECXUTL4 ;ALB/ESD - Utilities for DSS Extracts ;3/12/15  16:41
 ;;3.0;DSS EXTRACTS;**39,41,46,49,78,92,105,112,120,127,154**;Dec 22,1997;Build 13
 ;
OBSPAT(ECXIO,ECXTS,DSSID) ;
 ; Get observation patient indicator from DSS TREATING SPECIALTY
 ; TRANSLATION file (#727.831) or DSS Identifier
 ;
 ; Input:
 ;   ECXIO  - Inpatient/Outpatient indicator
 ;   ECXTS  - Treating specialty (from file #42.4)
 ;   DSSID  - DSS Identifier
 ;
 ;Output:
 ;   ECXOBS - Observation patient indicator (YES/NO)
 ;
 ;- Check input vars
 S ECXIO=$G(ECXIO),ECXTS=+$G(ECXTS),DSSID=+$G(DSSID)
 S ECXOBS=""
 D
 .;- Look up obs patient indicator if treating spec is in file #727.831
 . I $G(^ECX(727.831,ECXTS,0)) S ECXOBS=$P($G(^ECX(727.831,ECXTS,0)),"^",4)
 . I ECXOBS'="" S ECXOBS=$S(ECXOBS="Y":"YES",1:"NO") Q
 .;
 .;- If outpatient and TS not in file, AND Feeder Key (CLI) or DSS ID
 .;- (MTL,IVP,ECQ,QSR,NOS,SUR) is 290-297, Observation Patient Ind=YES
 . I ECXIO="O",ECXOBS="",DSSID D
 .. I $E(DSSID,1,3)>289&($E(DSSID,1,3)<298) S ECXOBS="YES"
 .. E  S ECXOBS="NO"
 Q $S(ECXOBS'="":ECXOBS,1:"NO")
 ;
INOUTP(ECXTS) ;
 ; Get inpatient/outpatient indicator from DSS TREATING SPECIALTY
 ; TRANSLATION file (#727.831)
 ;
 ; Input:
 ;   ECXTS   - Treating specialty
 ;
 ; Output:
 ;             Inpatient/Outpatient indicator (I/O)
 ;
 S ECXTS=+$G(ECXTS)
 S ECXIO=""
 ;
 ;- Look up inpat/outpat indicator if treating spec is in file
 I $G(^ECX(727.831,ECXTS,0)) S ECXIO=$P($G(^ECX(727.831,ECXTS,0)),"^",5)
 Q $S(ECXIO'="":ECXIO,1:"I")
 ;
ENCNUM(ECXIO,ECXSSN,ECXADT,ECXVDT,ECXTRT,ECXOBS,ECXEXT,ECXSTP,ECXSTP2) ;
 ; Get encounter number
 ;
 ; Input:
 ;   ECXIO   - Inpat/Outpat indicator = I or O
 ;   ECXSSN  - Patient SSN
 ;   ECXADT  - Admit Date
 ;   ECXVDT  - Visit Date
 ;   ECXTRT  - Treating Spec
 ;   ECXOBS  - Observation Pat Indicator
 ;   ECXEXT  - Extract
 ;   ECXSTP  - Stop Code (or stop code related) variable
 ;   ECXSTP2 - Stop Code (or stop code related) addtl variable
 ;             (used for SUR and ECS)
 ;
 ;Output:
 ;             Encounter Number
 ;
 N ENCNUM,ECXDATE,ECXSTCD
 S (ENCNUM,ECXSTCD)=""
 ;
 ;- Check input vars
 S ECXEXT=$G(ECXEXT),ECXIO=$G(ECXIO),ECXOBS=$G(ECXOBS),ECXTRT=+$G(ECXTRT)
 S:ECXEXT'="ECS"&(ECXEXT'="ECQ") ECXSTP=+$G(ECXSTP) S ECXSTP2=+$G(ECXSTP2) ;154 Allow stop code/DSS ID for ECS&ECQ to be non-numeric
 S ECXADT=+$G(ECXADT),ECXVDT=+$G(ECXVDT)
 ;
 ;- Don't use pseudo-SSN in encounter number
 S ECXSSN=$E($G(ECXSSN),1,9)
 ;
 D
 . ;- Inpatient
 . I ECXIO="I",ECXADT,ECXSSN'="" D  Q
 .. S ECXDATE=$$ADMITDT(ECXADT)
 .. I ECXDATE'="" S ENCNUM=ECXSSN_ECXDATE_"I"
 . ;
 . ;- Outpatient branch
 . I ECXIO="O" D
 .. ;- Observation patient (outpatient)
 .. I ECXOBS="YES",ECXSSN'="" D  Q
 ... ;
 ... S ECXDATE=$S(ECXADT:$$JULDT(ECXADT),1:$$JULDT(ECXVDT))
 ... S ECXSTCD=$S(+$P($G(^ECX(727.831,ECXTRT,0)),"^",6):+$P($G(^ECX(727.831,ECXTRT,0)),"^",6),1:+$E(ECXSTP,1,3))
 ... Q:ECXDATE=""!(ECXSTCD="")
 ... S ENCNUM=ECXSSN_ECXDATE_ECXSTCD
 .. ;
 .. ;- Outpatient (no observation pat)
 .. I ECXOBS="NO",ECXVDT,ECXSSN'="" D  Q
 ... ;
 ... ;- ADM, MOV, TRT have no outpat encounter number
 ... I ECXEXT="ADM"!(ECXEXT="MOV")!(ECXEXT="TRT") Q
 ... ;
 ... ;- Use 1st 3 chars of DSS ID for NOS (feeder key for CLI)
 ... I ECXEXT="CLI"!(ECXEXT="NOS") S ECXSTCD=+$E(ECXSTP,1,3) Q:'ECXSTCD
 ... ;
 ... ;- 154, For ECS remove cost center conversion. For ECS and ECQ set stop code to first 3 characters of ECXSTP
 ... I ECXEXT="ECS"!(ECXEXT="ECQ") S ECXSTCD=$E(ECXSTP,1,3) ;154
 ... ;
 ... ;- These extracts have predetermined stop code values
 ... I ECXEXT="DEN" S ECXSTCD=180
 ... I ECXEXT="PRE"!(ECXEXT="UDP")!(ECXEXT="IVP") S ECXSTCD="PHA"
 ... I ECXEXT="LAB"!(ECXEXT="LAR")!(ECXEXT="LBB") S ECXSTCD=108
 ... I ECXEXT="MTL" S ECXSTCD=538
 ... I ECXEXT="NUR" S ECXSTCD=950
 ... I ECXEXT="PRO" S ECXSTCD=423
 ... I ECXEXT="NUT" S ECXSTCD="NUT"
 ... I ECXEXT="BCM" S ECXSTCD="BCM"
 ... ;
 ... ;- If Imaging Type fld=2, use 109 otherwise use 105
 ... I ECXEXT="RAD" S ECXSTCD=$S(ECXSTP=2:109,1:105)
 ... ;
 ... ;- Use DSS STOP CODE fld if populated or if SURG SPEC fld=59 use 430
 ... ;- otherwise if null use 429
 ... I ECXEXT="SUR" S ECXSTCD=$S(ECXSTP:ECXSTP,ECXSTP2=59:430,1:429)
 ... ;
 ... ;- Get Julian Date
 ... S ECXDATE=$$JULDT(ECXVDT)
 ... I ECXDATE'="" S ENCNUM=ECXSSN_ECXDATE_ECXSTCD
 Q ENCNUM
 ;
ADMITDT(ECXINDT) ; Returns date in YYMMDD format
 ;
 ; Input:
 ;   ECXINDT - Date (can also include time) in internal FM format
 ;
 ;Output:
 ;             Date in YYMMDD form
 ;
 N ECXDT
 S ECXDT=""
 S ECXINDT=+$G(ECXINDT)
 ;
 ;- If no input or full FM date not passed in, quit
 I 'ECXINDT!($L(ECXINDT)<7) G ADMTDTQ
 ;
 ;- Date in YYMMDD form
 S ECXDT=$TR($$FMTE^XLFDT(ECXINDT,"4DF")," /","0")
ADMTDTQ Q ECXDT
 ;
 ;
JULDT(ECXINDT) ;  Returns Julian Date in MMDDD format
 ;
 ; Input:
 ;   ECINDT  - Date (can also include time) in internal FM format
 ;
 ;Output:
 ;             Julian date in MM_DDD form
 ;
 N ECXDDD,ECXDT,ECXJUL,ECXMM
 S (ECXDDD,ECXMM)=""
 ;
 ;- If no input or full FM date not passed in, quit
 S ECXINDT=+$G(ECXINDT)
 I 'ECXINDT!($L(ECXINDT)<7) G JULDTQ
 ;
 ;- Extract date portion
 S ECXDT=$E(ECXINDT,1,7)
 ;
 ;- Get month (MM)
 S ECXMM=$E(ECXINDT,2,3)
 ;
 ;- Number of day within year (DDD)
 S ECXDDD=$$RJ^XLFSTR($$FMDIFF^XLFDT(ECXDT,$E(ECXDT,1,3)_"0101",1)+1,3,"0")
JULDTQ Q ECXMM_ECXDDD
 ;
CNHSTAT(ECXDFN) ;  Get CNH (Contract Nursing Home) status
 ;
 ; Input:
 ;   ECXDFN  - Patient DFN
 ;
 ;Output:
 ;             CNH status (YES/NO)
 ;
 N ECXCNH
 S ECXDFN=+$G(ECXDFN)
 S ECXCNH=$P($G(^DPT(ECXDFN,"NHC")),U)
 Q $S(ECXCNH="Y":"YES",ECXCNH="N":"NO",1:"")
 ;
CANC(ECXNOR,ECXTMOR) ; Get Surgery Cancelled/Aborted Status
 ;
 ; Function called after determining CANCEL DATE in SURGERY record exists
 ;
 ; Input:
 ;   ECXNOR   - Non-OR DSS ID
 ;   ECXTMOR  - Time Pat in OR
 ;
 ;Output:
 ;              Cancelled/aborted status (C/A)
 ;
 N ECXCANC
 S ECXCANC=""
 S ECXNOR=$G(ECXNOR)
 ;
 ;- If Non-OR DSS ID or Time Pat in OR, ECXCANC = "A" else = "C"
 D
 . I ECXNOR'=""&(ECXNOR'="UNKNOWN") S ECXCANC="A" Q
 . I +$G(ECXTMOR) S ECXCANC="A" Q
 . S ECXCANC="C"
 Q ECXCANC
 ;
HNCI(ECXDFN) ; Get head & neck cancer indicator
 ;
 ; Input:
 ;   ECXDFN  - Patient DFN
 ;
 ;Output:
 ;             Head/Neck CA DX (Y/N)
 ;
 N ECXHNCI,DGNT
 S ECXHNCI=""
 S ECXDFN=+$G(ECXDFN) I ECXDFN D
 .I $$GETCUR^DGNTAPI(ECXDFN,"DGNT") S ECXHNCI=$P(DGNT("HNC"),U)
 Q ECXHNCI
 ;
TSMAP(ECXTS) ;Determines DSS Identifier for the following observation
 ; treating specialty
 ; Input:
 ;   ECXTS - Observation Treating Specialty
 ;
 ; Output:
 ;   DSS Identifier (Stop Code)
 ;
 N TS,SC,I
 S TS="^18^23^24^41^65^94^108^",SC="^293^295^290^296^291^292^297^"
 F I=1:1:$L(TS) Q:$P(TS,"^",I)=ECXTS
 Q $P(SC,"^",I)_"000"
OEFDATA ;
 ;get patient OEF/OIF status and date of return
 S (ECXOEF,ECXOEFDT)=""
 I $G(VASV(11))>0 S ECXOEF=ECXOEF_"OIF"
 I $G(VASV(12))>0 S ECXOEF=ECXOEF_"OEF"
 I $G(VASV(13))>0 S ECXOEF=ECXOEF_"UNK"
 I ECXOEF'="" D
 . S ECXOEFDT=""
 . I $G(VASV(11))>0 S ECXOEFDT=$P($G(VASV(11,$G(VASV(11)),3)),"^")
 . I $G(VASV(12))>0,$P($G(VASV(12,$G(VASV(12)),3)),"^")>ECXOEFDT S ECXOEFDT=$P($G(VASV(12,$G(VASV(12)),3)),"^")
 . I $G(VASV(13))>0,$P($G(VASV(13,$G(VASV(13)),3)),"^")>ECXOEFDT S ECXOEFDT=$P($G(VASV(13,$G(VASV(13)),3)),"^")
 . I ECXOEFDT>0 S ECXOEFDT=17000000+ECXOEFDT
 ;
 S ECXPAT("ECXOEF")=ECXOEF
 S ECXPAT("ECXOEFDT")=ECXOEFDT
 Q
 ;
SHAD(ECXDFN) ; Get PROJ 112/SHAD indicator
 ;
 ; Input:
 ;   ECXDFN  - Patient DFN
 ;
 ;Output:
 ;             PROJ 112/SHAD DX (Y/N/U)
 ;             Error -1, missing parameter
 ;
 N ECXSHAD
 S ECXDFN=$G(ECXDFN)
 S ECXSHAD=$$GETSHAD^DGUTL3(ECXDFN)
 S ECXSHAD=$S(ECXSHAD=1:"Y",ECXSHAD=0:"N",ECXSHAD="":"U",1:-1)
 Q ECXSHAD

SCMSVUT0 ;ALB/ESD HL7 Segment Validation Utilities ; 7/8/04 5:06pm
 ;;5.3;Scheduling;**44,55,66,132,245,254,293,345,472,441,551,552**;Aug 13, 1993;Build 5
 ;
 ;
CONVERT(SEG,HLFS,HLQ) ; Convert HLQ ("") to null in segment
 ;      Input:  SEG  = HL7 segment
 ;             HLFS  = HL7 field separator
 ;              HLQ  = HL7 "" character
 ;
 ;     Output:  SEG  = Segment where HLQ replaced with null
 ;
 ;
 N I
 F I=1:1:55 I $P(SEG,HLFS,I)=HLQ S $P(SEG,HLFS,I)=""
 Q SEG
 ;
SETID(SDOE,SDDELOE) ; Set PCE Unique Visit Number in field #.2 of #409.68
 ;      Input:   SDOE = IEN of Outpatient Encounter (#409.68) file
 ;            SDDELOE = IEN of Deleted Outpatient Encounter (#409.74) file
 ;
 ;     Output:   Unique Visit Number set in field #.2 of #409.68
 ;               or field #.2 of #409.74
 ;
 ;
 N SDOEC,SDARRY
 S SDOEC=0
 S SDOE=+$G(SDOE)
 S SDDELOE=+$G(SDDELOE)
 ;
 ;-Outpatient Enc pointer passed in; use file #409.68
 S SDARRY="^SCE("_SDOE_",0)"
 ;
 ;-Deleted Outpatient Enc pointer passed in; use file #409.74
 S:(SDDELOE) SDARRY="^SD(409.74,"_SDDELOE_",1)"
 ;
 ;-Quit if no encounter record or deleted encounter record
 Q:($G(@SDARRY)="")
 ;-Add unique ID to parent
 D GETID
 ;
 ;-Add unique ID to children for Outpatient Enc only (quit if no child encounter record)
 I (SDOE) F  S SDOEC=+$O(^SCE("APAR",SDOE,SDOEC)) Q:'SDOEC  S SDARRY="^SCE("_SDOEC_",0)" Q:($G(@SDARRY)="")  D GETID
 Q
 ;
GETID ;Get unique visit ID
 S:$P($G(@SDARRY),"^",20)="" $P(@SDARRY,"^",20)=$$IEN2VID^VSIT($P(@SDARRY,"^",5))
 Q
 ;
SETPRTY(SDOE) ;Set outpatient provider type in field #.06 of V PROVIDER
 ;      Input:  SDOE = IEN of Outpatient Encounter (#409.68) file
 ;
 ;     Output:  Provider Type set in field #.06 of V PROVIDER
 ;
 ;
 N SDPRTYP,SDVPRV,SDPRVS
 S SDOE=+$G(SDOE),SDVPRV=0
 ;
 ;- Get all provider IENs for encounter
 D GETPRV^SDOE(SDOE,"SDPRVS")
 F  S SDVPRV=+$O(SDPRVS(SDVPRV)) Q:'SDVPRV  D
 . S SDPRTYP=0
 . ;
 . ;- If no prov type, call API and add provider type to record
 . S:$P(SDPRVS(SDVPRV),"^",6)="" SDPRTYP=$$GET^XUA4A72(+SDPRVS(SDVPRV),+$G(^SCE(SDOE,0)))
 . I +$G(SDPRTYP)>0 D PCLASS^PXAPIOE(SDVPRV)
 Q
 ;
SETMAR(PIDSEG,HLQ,HLFS,HLECH) ; Set marital status prior to PID segment validation
 ;Input:   PIDSEG = Array containing PID segment (pass by reference)
 ;                  PIDSEG = First 245 characters
 ;                  PIDSEG(1..n) = Continuation nodes
 ;            HLQ = HL7 null variable
 ;           HLFS = HL7 field separator
 ;          HLECH = HL7 encoding characters (VAFCQRY1 call)
 ;Output:  Marital status changed from null to "U" (UNKNOWN) prior to
 ;         validation of PID segment and transmittal to AAC
 ;Note: Assumes all input exists and is valid
 ;
 ;Declare variables
 N REBLD,TMPARR,X,TMPARR3,TMPARR5,TMPARR11
 ;Parse segment
 D SEGPRSE^SCMSVUT5($NA(PIDSEG),"TMPARR",HLFS)
 ;Change marital status (if needed)
 S REBLD=0
 S X=$G(TMPARR(16))
 I ((X="")!(X=HLQ)) S TMPARR(16)="U",REBLD=1
 I $D(HLECH) D  Q  ;from SCDXMSG1 (VAFCQRY call)
 . ;Change religion (if needed)
 . S X=$G(TMPARR(17))
 . I ((X="")!(X=HLQ)) S TMPARR(17)=29
 . ;Rebuild segment (due to VAFCQRY call building seg. array)
 . ;VAFCQRY Seqs 3,5,11 needs to be broken down - too long for rebuild
 . K TMPARR(0),PIDSEG
 . D SEQPRSE^SCMSVUT5($NA(TMPARR(3)),"TMPARR3",HLECH)
 . D SEQPRSE^SCMSVUT5($NA(TMPARR(5)),"TMPARR5",HLECH)
 . D SEQPRSE^SCMSVUT5($NA(TMPARR(11)),"TMPARR11",HLECH)
 . K TMPARR(3) M TMPARR(3)=TMPARR3
 . K TMPARR(5) M TMPARR(5)=TMPARR5
 . K TMPARR(11) M TMPARR(11)=TMPARR11
 . D MAKEIT^VAFHLU("PID",.TMPARR,.PIDSEG,.PIDSEG)
 I REBLD K TMPARR(0),PIDSEG D MAKEIT^VAFHLU("PID",.TMPARR,.PIDSEG,.PIDSEG)
 Q
 ;
SETPOW(DFN,ZPDSEG,HLQ,HLFS)     ; Set POW Status Indicated field prior to ZPD segment validation
 ;
 ;     Input:      DFN = IEN of Patient (#2) file
 ;              ZPDSEG = Array containing ZPD segment (pass by reference)
 ;                       ZPDSEG = First 245 characters
 ;                       ZPDSEG(1..n) = Continuation nodes
 ;                 HLQ = HL7 null variable
 ;                HLFS = HL7 field separator
 ;
 ;    Output:  If Veteran and POW Status Indicated field = null, set to
 ;              U (Unknown)
 ;             If Non-Veteran, set to null
 ;
 S DFN=$G(DFN)
 G SETPOWQ:(DFN="")!($G(ZPDSEG)="")
 ;Declare variables
 N REBLD,TMPARR,X
 ;Parse segment
 D SEGPRSE^SCMSVUT5($NA(ZPDSEG),"TMPARR",HLFS)
 ;Change POW status (if needed)
 S REBLD=0
 S X=$G(TMPARR(17))
 I $P($G(^DPT(DFN,"VET")),"^")="Y",(X=""!(X=HLQ)) S TMPARR(17)="U",REBLD=1
 I $P($G(^DPT(DFN,"VET")),"^")="N" S TMPARR(17)=HLQ,REBLD=1
 ;Rebuild segment (if needed)
 I REBLD K TMPARR(0),ZPDSEG D MAKEIT^VAFHLU("ZPD",.TMPARR,.ZPDSEG,.ZPDSEG)
 ;
SETPOWQ Q
 ;
 ;
SETVSI(DFN,ZSPSEG,HLQ,HLFS) ;Set Vietnam Service Indicated field prior to ZSP segment validation
 ;
 ;     Input:      DFN = IEN of Patient (#2) file
 ;              ZSPSEG = HL7 ZSP segment
 ;                 HLQ = HL7 null variable
 ;                HLFS = HL7 field separator
 ;
 ;    Output:  If Veteran and Vietnam Service Indicated field = null,
 ;              set to U (Unknown)
 ;             If Non-Veteran, set to null
 ;
 S DFN=$G(DFN),ZSPSEG=$G(ZSPSEG)
 G SETVSIQ:(DFN="")!(ZSPSEG="")
 I $P($G(^DPT(DFN,"VET")),"^")="Y",($P(ZSPSEG,HLFS,6)=""!($P(ZSPSEG,HLFS,6)=HLQ)) S $P(ZSPSEG,HLFS,6)="U"
 I $P($G(^DPT(DFN,"VET")),"^")="N" S $P(ZSPSEG,HLFS,6)=HLQ
 ;
SETVSIQ Q ZSPSEG
 ;
 ;
 ;
 ;The following subroutines all have to do with the validation of
 ;data using the same edit checks that are used by Austin.
 ;
HL7SEGNM(SEG,DATA) ;checks the validity of the HL7 segment name passed in.
 ;INPUT    SEG  - the HL7 segment name
 ;         DATA - the data to compare. In this case the HL7 segment name.
 ;
 ;OUTPUT   0 (ZERO) if not validate
 ;         1 if validated
 ;
 I '$D(SEG)!('$D(DATA)) Q 0
 Q $S(SEG=DATA:1,1:0)
 ;
EVTTYP(SEG,DATA) ;checks the event type of the segment passed in.
 ;INPUT  SEG  - The HL7 segment name in question
 ;       DATA - The event type from the HL7 segment in question.
 ;
 ;OUTPUT   0 (ZERO) if not validate
 ;         1 if validated
 ;
 I '$D(SEG)!('$D(DATA)) Q 0
 I SEG="EVN"&(DATA="A08"!(DATA="A23")) Q 1
 Q 0
 ;
EVTDTTM(DATA) ;Checks the date and time to ensure it is correct.
 ;INPUT  DATA - this is the date and time in quesiton.
 ;
 ;OUTPUT  0 (ZERO) if not validate
 ;        1 if validated
 ;
 I '$D(DATA) Q 0
 N STRTDT,%DT,X,Y
 S STRTDT=+$O(^SD(404.91,0))
 S STRTDT=$P($G(^SD(404.91,STRTDT,"AMB")),U,2)
 I 'STRTDT Q 0
 S %DT="T",%DT(0)=STRTDT,X=DATA
 D ^%DT
 Q $S(Y=-1:0,1:1)
 ;
VALIDATE(SEG,DATA,ERRCOD,VALERR,CTR) ;
 ;
 N ERRIEN,ERRCHK,RES
 S ERRIEN=+$O(^SD(409.76,"B",ERRCOD,""))
 I 'ERRIEN S @VALERR@(SEG,CTR)=ERRCOD D INCR Q
 S ERRCHK=$G(^SD(409.76,ERRIEN,"CHK"))
 I ERRCHK="" S @VALERR@(SEG,CTR)=ERRCOD D INCR Q
 X ERRCHK
 I 'RES S @VALERR@(SEG,CTR)=ERRCOD D INCR
 Q
 ;
DFN(DATA) ;
 ;INPUT   DATA - the DFN of the patient
 ;
 I '$D(DATA) Q 0
 I DATA=""!(DATA=0) Q 0
 I DATA'?1.N.".".N Q 0
 Q 1
 ;
PATNM(DATA) ;
 ;INPUT  DATA - The name of the patient
 ;
 I '$D(DATA) Q 0
 I DATA="" Q 0
 I DATA?.N.",".N Q 0
 I DATA?1.C Q 0
 Q 1
 ;
DOB(DATA,ENCDT) ;
 ;INPUT  DATA - The DOB to be tested.
 ;      ENCDT - The date/time of the encounter
 ;
 N %DT,X,Y
 I '$D(DATA) Q 0
 I '$D(ENCDT) Q 0
 I DATA'?1.N Q 0
 S %DT="T",%DT(0)=-ENCDT,X=DATA
 D ^%DT
 Q $S(Y=-1:0,1:1)
 ;
SEX(DATA) ;
 ;INPUT  DATA - The sex code to be validated
 ;
 I '$D(DATA) Q 0
 I "FMUO"'[DATA Q 0
 Q 1
 ;
RACE(DATA) ;
 ;INPUT  DATA - the race code to be validated (NNNN-C-XXX)
 ;
 N VAL,MTHD
 I '$D(DATA) Q 0
 I DATA="" Q 1
 S VAL=$P(DATA,"-",1,2)
 S MTHD=$P(DATA,"-",3)
 I VAL'?4N1"-"1N Q 0
 I ",SLF,UNK,PRX,OBS,"'[MTHD Q 0
 Q 1
 ;
STR1(DATA) ;
 ;INPUT   DATA - Street address line 1
 ;
 N LP,VAR
 I '$D(DATA) Q 0
 I DATA="" Q 0
 I DATA?1.N Q 0
 I DATA=" " Q 0
 F LP=1:1:$L(DATA) S VAR=$E(DATA,LP,LP) I $A(VAR)>32,($A(VAR)<127) S LP="Y" Q
 Q $S(LP="Y":1,1:0)
 ;
STR2(DATA) ;
 ;INPUT  DATA - Street address line 2
 I DATA?1.N Q 0
 Q 1
 ;
CITY(DATA) ;
 ;INPUT  DATA - The city code to be validated
 ;
 I DATA="" Q 0
 I DATA?1.N Q 0
 Q 1
 ;
STATE(DATA) ;
 ;INPUT  DATA - State code to be validated.
 ;
 I '$D(DATA) Q 0
 I DATA="" Q 0
 I '$D(^DIC(5,"C",DATA)) Q 0
 Q 1
 ;
ZIP(DATA) ;
 ;INPUT  DATA - The zipo code to be validated
 ;
 I '$D(DATA) Q 0
 I $E(DATA,1,5)="00000" Q 0
 I DATA'?5N."-".4N Q 0
 Q 1
 ;
COUNTY(DATA,STATE) ;
 ;INPUT  DATA  - The county code to be validated
 ;       STATE - STATE file IEN 
 ;
 I DATA="" Q 0
 I STATE="" Q 0
 I '$D(^DIC(5,+$G(STATE),1,"C",DATA)) Q 0
 Q 1
 ;
MARITAL(DATA) ;
 ;INPUT   DATA - The marital status code to be validated.
 ;
 I $L(DATA)>1 Q 0
 I "ADMSWU"'[DATA Q 0
 Q 1
 ;
REL(DATA) ;
 ;INPUT   DATA - The religion abbreviation to the validated
 ;
 I '$D(DATA) Q 0
 I DATA="" Q 0
 I '$D(^DIC(13,"C",+DATA)) Q 0
 Q 1
 ;
SSN(DATA,NOPCHK,NULLOK) ; SD*5.3*345 added optional parameter NULLOK
 ;INPUT   DATA - The SSN to be validated
 ;        NOPCHK - O = Check pseudo indicator (default)
 ;                 1 = Don't check pseudo indicator
 ;        NULLOK (optional) - 1 = Allow SSN to be null
 ;                            2 = Don't allow null SSNs (default)
 ;
 I $G(DATA)="" Q +$G(NULLOK)  ; SD*5.3*345
 I '$D(DATA) Q 0
 N SSN,PSD
 S SSN=$E(DATA,1,9),PSD=$E(DATA,10)
 I SSN'?9N Q 0
 I '$G(NOPCHK) I (PSD'=" "),(PSD'=""),(PSD'="P") Q 0
 I $E(SSN,1,5)="00000" Q 0
 Q 1
 ;
INCR ;increases the counter
 S CTR=CTR+1
 Q
 ;
REMOVE(SEG,ERR,VALERR,CNT) ;
 ;INPUT SEG - The segment being worked on
 ;    VALERR - The array holding the information
 ;      CNT - the counter to use
 ;      ERR - error code to remove
 ;
 N LP
 F LP=1:1:CNT I $G(@VALERR@(SEG,LP))=ERR K @VALERR@(SEG,LP)
 Q
 ;
DECR(CNT) ;
 S CNT=CNT-1
 Q
 ;

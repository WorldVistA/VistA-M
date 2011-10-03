PRS8PP ;HISC/MRL,WIRMFO/MGD-DECOMP, PREMIUM PAYS ;05/10/07
 ;;4.0;PAID;**22,40,75,92,96,112,117**;Sep 21, 1995;Build 32
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;This routine is the entry point for determining certain premium
 ;pays for an employee.  Included are overtime (OT), 
 ;night differential (ND), unscheduled hours (UH), etc.
 ;
 ;Called by Routines:  PRS8ST
 ;
 S D=DAY(DAY,"W") ;                Daily activity string.
 S W=$S(DAY<8:1,1:2) ;             Week.
 I D?1"0"."0" Q  ;                 No activity this date.
 S NDC=1,(HT,HTP,HTFFOT)=0 ;       Counter for hrs worked this 
 ;                                 day (HT=Hours total).
 N HYBRID ;                        HYBRID under P.L 107-135
 S HYBRID=$$HYBRID^PRSAENT1($G(DFN))
 D ^PRS8HR ;                       calculate Norm hrs first
 F M=1:1:96 S VAL=$E(D,M) I VAL'=0 D  ;loop thru minutes of day
 .S DH=DAY(DAY,"DH1")
 .I TWO,M'<+$P(DAY(DAY,"TWO"),"^",2) S DH=DAY(DAY,"DH2") ;    Daily hrs.
 .I NDC,"CWB"'[VAL D ND ;                                        Get ND.
 .I TYP["B",+VAL Q  ;                  Baylor get no premium during tod.
 .I "1234OosEe"'[VAL Q  ;                 Don't chk for non-work status.
 .S X=$E(D,M,96) ;                                     Remainder of day.
 .I X?1N.N,X'[4 Q  ;                      No hrs left other than normal.
 .I "J123MLSWNARXYOFGD"'[VAL!(VAL="O"&($E(DAY(DAY,"HOL"),M)'=2)) S AV="OosEe" D CALC^PRS8HR
 K AV,D,GO,M,NDC,X,X1,J1,J2 Q
 ;
ND ; --- compute ND
 ; Process wagegrade
 I TYP["W" D  Q
 . ; process WG scheduled time
 . I "J23LSARMXYUVFGDZq"[VAL!(VAL="O"&($E(DAY(DAY,"HOL"),M)=2)) D
 . . N DAT,DAYN,FND,M1,NODE,SC,TS
 . . ; find tour segment that contains the time and get it's special code
 . . S FND=0,SC="" ; FND true if found in schedule, SC = special code 
 . . ; look in schedule of current day for M and previous day for M+96
 . . ; (in 2day tour, previous day's schedules >96 are Today's activity)
 . . F DAYN=DAY,DAY-1 D  Q:FND
 . . . S M1=$S(DAYN=DAY:M,1:M+96)
 . . . ; loop thru both tours in day
 . . . F NODE=1,4 S DAT=$G(^TMP($J,"PRS8",DAYN,NODE)) Q:DAT=""  D  Q:FND
 . . . . ; loop thru tour segments in tour
 . . . . F TS=1:1:7 Q:$P(DAT,U,(TS-1)*3+1)=""  D  Q:FND
 . . . . . ; check if time contained in tour segment
 . . . . . I M1'<$P(DAT,U,(TS-1)*3+1),M1'>$P(DAT,U,(TS-1)*3+2) S FND=1,SC=$P(DAT,U,(TS-1)*3+3)
 . . ;
 . . ; if time not found in any schedule, base SC on value of variable
 . . ;   TOUR for Today (or previous day when no scheduled tour Today).
 . . I 'FND S SC=$S($G(^TMP($J,"PRS8",DAY,1))=""&(DAY(DAY-1,"TOUR")>1):DAY(DAY-1,"TOUR")+4,1:TOUR+4)
 . . Q:"^6^7^"'[(U_SC_U)  ; tour segment not coded for shift 2 or 3
 . . S X=(SC-4)+8 ; determine where to store in WK array
 . . I $E(ENT,X-4) D SET ; if employee entitled then store result
 . ;
 . ; process WG unscheduled time
 . I VAL=4!(VAL="O") D
 . . N T,SD
 . . ; unscheduled regular tours for 'shift coverage' that are eligible
 . . ;   for shift 2 or 3 differential were saved in "SD" by PRS8EX.
 . . S SD=$G(^TMP($J,"PRS8",DAY,"SD"))
 . . Q:SD=""
 . . ; see if time belongs to a tour saved in "SD" and if so use the
 . . ;   associated shift (2 or 3)
 . . S SD(1)=0 ; init shift
 . . F T=1:3 S SD(0)=$P(SD,U,T,T+2) Q:SD(0)=""!(SD(0)?1."^")  D  Q:SD(1)
 . . . I M'<+SD(0),M'>$P(SD(0),"^",2) S SD(1)=$P(SD(0),"^",3)
 . . I SD(1) S X=SD(1)+8 I $E(ENT,X-4) D SET
 ;
 ; Process Other Employees (non-Wage Grade)
 ;
 ; Not entitled to ND
 I '$E(ENT,6) Q
 ;
 ; not entitled to ND if No Premium Pay tour
 I $P(DAY(DAY,1),"^",3)=8 Q
 ;
 ; check if time segment could be eligible for ND
 I $$NOTND(TYP,DAY,M) Q
 ;
 S AV="J1234ALSRMUEOosecbVXYFGDZq"
 ;
 ; Grant ND for time before 6a/after 6p or anytime when nurse/hybrid
 ; works tour coverage
 I M<25!(M>72)!($E(DAY(DAY,"P"),M)="N"&(TYP["N"!(TYP["H")!(HYBRID))),AV[VAL D
 . ; The Hybrids defined in Public Law 107-135 will only receive Night
 . ; Differential time for OT and CT worked between 6 p.m. and 6 a.m.
 . Q:HYBRID!(PMP'=""&("^S^T^U^V^"[(U_PMP_U)))&(M'<25&(M'>72))
 . ; Tour time between 6 p.m. and 6 a.m. counts toward ND
 . N DAT,DAYN,FND,M1,NODE,SC,TS,TOT
 . ; find tour segment that contains the time and get it's special code
 . S FND=0,SC="" ; FND true if found in schedule, SC = special code 
 . S TOT="" ; Type Of Time
 . ; look in schedule of current day for M and previous day for M+96
 . ; (in 2day tour, previous day's schedules >96 are Today's activity)
 . F DAYN=DAY,DAY-1 D  Q:FND
 . . S M1=$S(DAYN=DAY:M,1:M+96)
 . . S DAT=$G(^TMP($J,"PRS8",DAYN,2)) D  Q:FND
 . . . ; loop thru tour segments in exceptions
 . . . F TS=1:1:7 Q:$P(DAT,U,(TS-1)*4+1)=""  D  Q:FND
 . . . . ; check if time contained in exception segment
 . . . . I M1'<$P(DAT,U,(TS-1)*4+1),M1'>$P(DAT,U,(TS-1)*4+2) D
 . . . . . S TOT=$P(DAT,U,(TS-1)*4+3)
 . . . . . ; On-Call and Recess are the only types of exceptions
 . . . . . ; where OT, CT and RG can be posted for the same 15 minute
 . . . . . ; segment of time, so don't stop searching if you find these.
 . . . . . I TOT="ON"!(TOT="RS") S TOT="" Q
 . . . . . S FND=1,SC=$P(DAT,U,(TS-1)*4+4)
 . . . . . Q
 . Q:TOT="OT"&("^11^12^17^"'[(U_SC_U))  ; Pre-Scheduled & Tour Coverage & OT/CT With Premiums
 . Q:TOT="CT"&("^12^17^"'[(U_SC_U))     ; Tour Coverage & OT/CT With Premiums
 . ; Code 17 - OT/CT with premiums only get ND for 6p-6a
 . Q:TOT="OT"!(TOT="CT")!(TOT="RG")&(SC=17)&((M'<25)&(M'>72))
 . Q:TOT="RG"&(SC'=7)&(SC'=17)          ; Shift Coverage & OT/CT With Premiums
 . S X=10
 . ; for 36/40 AWS, premium time resulting from their tour 
 . ; will be mapped to Night Differential-AWS (ND/NU) and
 . ; Paid at the AAC with the 1872 divisor for the hourly rate (36*52)
 . I +NAWS=36,("OEc"'[VAL!(TOT="HW")) S X=51
 . D SET
 . ; keep leave count since it may need to be backed out by PRS8MSC0
 . I "LSRUFGDZq"[VAL S WKL(WK)=WKL(WK)+1
 ;
 ; Nurse can get ND for 6a-6p time when part of tour with 4+ hrs in 6p-6a
 ; check is made when M=24 (just before 6am) or M=73 (just after 6pm).
 ; if tour eligible (4+ hours in 'night' time) then ND is granted for
 ; the portion of the tour that falls within the 'day' time.
 I TYP["N"!(TYP["H"),M=73!(M=24),AV_"m"[VAL D
 . N C,J,Q,X,X1,X2,XD
 . ;
 . ; quit if 'day' time is for tour coverage since already counted
 . I $E(DAY(DAY,"P"),$S(M=73:72,1:25))="N" Q
 . ;
 . ; first check if tour has at least 4 hours of 'night' (6pm-6am) time
 . S XD=$S(M=24:-1,1:1) ; loop direction, [6am back, 6pm forward]
 . S X1=M,X2=X1+(XD*15) ; start and stop of 4 hour range
 . ; loop thru tour 'night' time - stop if tour ends or after 4 hours
 . S C=1 ; init flag, false when tour has less than 4 hours of 'night'
 . F J=X1:XD:X2 D  Q:'C
 . . I AV_"m"'[$E(D,J) S C=0 Q  ; inappropriate type of time
 . . I $$NOTND(TYP,DAY,J) S C=0 Q
 . . ; scheduled TOD considered as separate from covered TOD
 . . I $E(DAY(DAY,"P"),M)'=$E(DAY(DAY,"P"),J) S C=0 Q
 . ;
 . Q:'C  ; tour not eligible (less than 4 hours of 'night')
 . ;
 . ; loop thru day time (6am-6pm) portion of tour and grant ND
 . ; don't pay ND for meal-time (m) but continue loop
 . S XD=$S(M=24:1,1:-1) ; loop direction [6am forward, 6pm back]
 . S X1=M+XD,X2=X1+(47*XD) ; start and stop for day time (12 hours)
 . S Q=0 ; init flag, true when end of tour reached
 . F J=X1:XD:X2 D  Q:Q
 . . I AV_"m"'[$E(D,J) S Q=1 Q  ;    inappropriate time
 . . I $$NOTND(TYP,DAY,J) S Q=1 Q
 . . ; scheduled TOD considered as separate from covered TOD
 . . I $E(DAY(DAY,"P"),M)'=$E(DAY(DAY,"P"),J) S Q=1 Q
 . . ; grant ND (unless meal-time, etc.), keep count of leave since it
 . . ;   may need to be backed out by PRS8MSC0
 . . I AV[$E(D,J) D
 . . . S X=10
 . . . ; For 36/46 AWS nurses ND for Holiday Worked (HA/HL) and normal
 . . . ; tour time will be reported as Night Differential-AWS (ND/NU)
 . . . I +NAWS=36 D
 . . . . I $E(DAY(DAY,"HOL"),J)=2 S X=51 Q  ; Holiday Worked
 . . . . I "OEc"'[VAL S X=51 ; Tour time
 . . . D SET
 . . . S:"LSRUFGDZq"[$E(D,J) WKL(WK)=WKL(WK)+1
 ;
 Q
 ;
SETJ ; --- set week node (J variable defined)
 Q:$E(D,J)="m"
 ;
SET ; --- actually set the piece
 S $P(WK(WK),"^",X)=$P(WK(WK),"^",X)+1
 Q
 ;
NOTND(PRSTY,PRSDY,PRSTM) ; Not Eligible Night Differential
 ; in PRSTY  type of employee
 ;    PRSDY  day (1-14)
 ;    PRSTM  time segment (1-96)
 ; returns 0 or 1 (True when not eligible for ND)
 ;
 N VAL
 S VAL=$E(DAY(PRSDY,"W"),PRSTM)
 ;
 ; not entitled to ND
 I ($E(DAY(PRSDY,"P"),PRSTM)=5) Q 1
 ;
 ; OT on non-premium T&L
 I "EOosecb"[VAL,$E(DAY(PRSDY,"P"),PRSTM),VAL'="O"!(VAL="O"&($E(DAY(PRSDY,"HOL"),PRSTM)'=2)) Q 1
 ;
 ; Nurses do not get ND for OT that is not for ND Tour Coverage
 I "Ecb"[VAL!(VAL="O"&'$E(DAY(PRSDY,"HOL"),PRSTM)),PRSTY["N"!(PRSTY["H")!(HYBRID)!("^S^T^U^V^"[(U_PMP_U)),$E(DAY(PRSDY,"P"),PRSTM)'="N" Q 1
 ;
 ; Baylor gets no ND for work time on regularly scheduled day
 I TYP["B","^1^7^8^14^"[("^"_DAY_"^"),"1234ALSRMUNVXYFGDZq"[VAL Q 1
 ;
 ; GS Employees do not get ND for OT that is not Pre-Scheduled
 I "Ecb"[VAL!(VAL="O"&'$E(DAY(PRSDY,"HOL"),PRSTM)),PRSTY'["N",PRSTY'["H",'HYBRID,("^S^T^U^V^"'[(U_PMP_U)),$E(DAY(PRSDY,"P"),PRSTM)'="n" Q 1
 ;
 ; Unsch Reg time needs to be Pre-scheduled to get ND
 I VAL=4,PRSTY["P"!(PRSTY["I"&(PRSTY["N"!(PRSTY["H"))),"Nn"'[$E(DAY(PRSDY,"P"),PRSTM) Q 1
 Q 0 ; did not fail any of the checks

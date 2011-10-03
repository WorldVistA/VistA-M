PRSATPE ;WOIFO/PLT - Find Exceptions ;12/3/07
 ;;4.0;PAID;**26,34,69,102,112,116,117**;Sep 21, 1995;Build 32
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 K ER S (ECNT,FATAL)=0,X0=$G(^PRST(458,PPI,"E",DFN,"D",DAY,0)),STAT=$P($G(^(10)),"^",1)
 N MLTIME S MLTIME=0
 S TC=$P(X0,"^",2) I 'TC S ER(1)=$P($T(ERTX+1),";;",2),FATAL=1 G EX
 ;
 ;ensure Normal Hrs = tour hrs for hourly employees
 I DAY=14 I '$$HRSMATCH(PPI,DFN) S FATAL=1,ERR=20 D ERR3640 G EX
 ;
 I "1 3 4"'[TC,STAT="" S ER(1)=$P($T(ERTX+2),";;",2),FATAL=1 G EX
 ;
 ;  Validate NAWS 36/40 nurse tours--can't certify if errors
 I DAY=7!(DAY=14),$$NAWS3640(DFN,PPI) D
 .  I $$SAT2DAY(DAY/7,DFN,PPI) S FATAL=1,ERR=16 D ERR3640
 .  I $$THREE12(DAY/7,DFN,PPI) S FATAL=1,ERR=$S(DAY=7:18,1:19) D ERR3640
 I DAY=1,$$NAWS3640(DFN,PPI) D
 .  I $$CARRYOVR(DFN,PPI) S FATAL=1,ERR=17 D ERR3640
 I FATAL G EX
 ;
 S X2=$G(^PRST(458,PPI,"E",DFN,"D",DAY,2)) G:X2="" EX S X1=$G(^(1)),X4=$G(^(4)),K=$P($G(^(10)),U,4)
 ;check recess entire day having un-unavailable posted for all scheduled on-on call
 I $E($G(PRSENT),5),K=2,X2["^RS" D
 . F K=1:3 QUIT:$P(X1,U,K,999)=""  S Z=$P(X1,U,K+2) I Z,$P($G(^PRST(457.2,Z,0)),"^",2)="ON",X2'[($P(X1,U,K,K+1)_"^UN") S PRSWOC=$G(PRSWOC)_DAY_"," QUIT
 . I $G(PRSWOC)'[(DAY_",") F K=1:3 QUIT:$P(X4,U,K,999)=""  S Z=$P(X4,U,K+2) I Z,$P($G(^PRST(457.2,Z,0)),"^",2)="ON",X2'[($P(X4,U,K,K+1)_"^UN") S PRSWOC=$G(PRSWOC)_DAY_"," QUIT
 . QUIT
 ;
 K TM I X2["OT"!(X2["CT") D TM
 K T,TRS F K=1:3 Q:$P(X1,"^",K)=""  S Z=$P(X1,"^",K+2) I $S('Z:1,1:$P($G(^PRST(457.2,Z,0)),"^",2)="RG") D
 .S X=$P(X1,"^",K,K+1) D CNV^PRSATIM S Z1=$P(Y,"^",1),Z2=$P(Y,"^",2) D V0
 .I Z1'="",$G(T(Z1))="*" K T(Z1) S T(Z2)="*" Q
 .S T(Z1)="",T(Z2)="*" Q
 I X4'="" F K=1:3 Q:$P(X4,"^",K)=""  S Z=$P(X4,"^",K+2) I $S('Z:1,1:$P($G(^PRST(457.2,Z,0)),"^",2)="RG") D
 .S X=$P(X4,"^",K,K+1) D CNV^PRSATIM S Z1=$P(Y,"^",1),Z2=$P(Y,"^",2) D V0
 .I Z1'="",$G(T(Z1))="*" K T(Z1) S T(Z2)="*" Q
 .S T(Z1)="",T(Z2)="*" Q
 ;
 ;find rs-type of time segments of trs array in x2 posted string
 I X2["^RS" F K=1:4:25 QUIT:$P(X2,U,K,999)=""  S X=$P(X2,"^",K,K+1) I "^"'[X,$P(X2,"^",K+2)="RS" D
 . S TT=$P(X2,"^",K+2) D CNV^PRSATIM S Z1=$P(Y,"^",1),Z2=$P(Y,"^",2) D V1
 . I Z1'="",$G(TRS(Z1))="*" K TRS(Z1) S TRS(Z2)="*" QUIT
 . S TRS(Z1)="",TRS(Z2)="*"
 . QUIT
 ; Checks for Daily employees
 I "^"[$P(X2,"^",1,2) S TT=$P(X2,"^",3),K=1,DN=0,Y0="" G L0
 F K=1:4:25 S X=$P(X2,"^",K,K+1) I "^"'[X D
 . N Z3,Z4
 . S TT=$P(X2,"^",K+2)
 . D CNV^PRSATIM S Y0=Y,Z1=$P(Y,"^",1),Z2=$P(Y,"^",2) D V1 S TIM=Z2-Z1/60
 . S Z3=Z1,Z4=Z2
 . I TT="ML" S MLTIME=MLTIME+TIM
 . S Z1=$O(T(Z1)) S:Z1'="" Z1=T(Z1)
 . S Z2=$O(T(Z2-1)) S:Z2'="" Z2=T(Z2)
 . ;trs=1 if absolute outside rs, 2 if absolute inside rs, 3 if overlap (in/outside) rs and inside tour of duty
 . ;if exception segment start/ending time outside tour of duty, reset z3 and z4
 . I Z1]""!(Z2]""),X2["^RS" S:Z1=""&(Z2="*") Z3=$O(T(Z3)) S:Z1="*"&(Z2="") Z4=$O(T(Z3)) S Z3=$O(TRS(Z3)) S:Z3]"" Z3=TRS(Z3) S Z4=$O(TRS(Z4-1)) S:Z4]"" Z4=TRS(Z4) S TRS=$S(Z3=""&(Z4=""):1,Z3="*"&(Z4="*"):2,1:3)
 . I TT="UN" D UN^PRSATPH QUIT
 . I "CT OT ON SB RG"[TT D OT QUIT
 . D LV QUIT
 ;
 ; Check for a minimum of 1 hour ML
 ;
 I TT="ML",MLTIME<1 S ER(1)=$P($T(ERTX+14),";;",2),FATAL=1 G EX
 ;
EX Q
V0 I Z2>Z1 S:$O(T(""))'<Z2 Z1=Z1+1440,Z2=Z2+1440 Q
 S Z2=Z2+1440 Q
V1 S DN=0 I Z2>Z1 Q:"CT OT ON SB UN RG"[TT  S:$O(T(""))'<Z2 Z1=Z1+1440,Z2=Z2+1440,DN=2 Q
 S Z2=Z2+1440,DN=1 Q
OT ; Check OT/CT Request
 I Z1'=""!(Z2'="") D O2 I $G(ERR)=6 S FATAL=1 D ERR
 I DN=1,$O(T(1440))="" D NX^PRSATPH
 I 'DN,$O(T(""))=""!($P(Y0,"^",1)'>$O(T(""))) D PR^PRSATPH
 I "ON SB RG"[TT Q
 ; check status of request(s)
 S DTI=$P($G(^PRST(458,PPI,1)),U,DAY) Q:'DTI
 S STAT="" ; init highest status var
 S DA=0 F  S DA=$O(^PRST(458.2,"AD",DFN,DTI,DA)) Q:'DA  D  Q:STAT="A"
 . S Z=$G(^PRST(458.2,DA,0))
 . Q:$P(Z,"^",5)'=TT  ; ignore different type
 . I $F("RSA",$P(Z,U,8))>$F("RSA",STAT) S STAT=$P(Z,U,8) ; higher status
 I STAT="" S ERR=3 D ERR Q  ; none with requested or higher status
 I STAT'="A" D  Q  ; none approved
 . S ERR=$S(STAT="R":8,1:9) D ERR
 . ; check posted hours vs requested since no approved request
 . S TM(TT,"R")=$G(TM(TT,"R"))-TIM I TM(TT,"R")<0 S ERR=7 D ERR
 ; check posted hours vs approved since we have an approved request
 S TM(TT,"A")=$G(TM(TT,"A"))-TIM I TM(TT,"A")<0 S ERR=13 D ERR
 Q
O2 ; Check for valid with-in tour or cross-tour situations
 I TT="ON"&(X2["HX") Q
 ;I "OT CT"[TT,TIM'>1 Q
 ;none-leave hours are inside tour hours, but quit if inside rs hours
 QUIT:$G(TRS)=2!(TT="HW"&(X2["^RS"))  S ERR=6 QUIT
TM ; Get OT,CT request,approve times
 S DTI=$P($G(^PRST(458,PPI,1)),"^",DAY),DA=0 Q:'DTI
T1 S DA=$O(^PRST(458.2,"AD",DFN,DTI,DA)) I 'DA Q
 S Z=$G(^PRST(458.2,DA,0)),STAT=$P(Z,"^",8) I STAT'="","XD"[STAT G T1
 S TT=$P(Z,"^",5) I TT'="OT",TT'="CT" G T1
 S TM(TT,"R")=$G(TM(TT,"R"))+$P(Z,"^",6) ; requested sum
 I STAT="A" S TM(TT,"A")=$G(TM(TT,"A"))+$P(Z,"^",6) ; approved sum
 G T1
LV ; Check Leave Request
 I TC=3!(TC=4) Q
 I TC=1,TT="HW" Q
 ;leave hours are (overlap) outside tour hours or (overlap) inside recess hours
 I ($G(TRS)'=1&(TT="HW")&$G(TRS)) QUIT
 I Z1'="*"!(Z2'="*")!($G(TRS)'=1&(TT'="RS")&$G(TRS)) S ERR=5,FATAL=1 D ERR
 ;
L0 N REMARK S REMARK=$P(X2,"^",K+3)
 Q:REMARK&(REMARK'=15&(REMARK'=16))
 I "HX"[TT D HENCAP
 ;no leave request for non-leave hour and rs types
 QUIT:"RG CP NP HX HW TR TV RS"[TT
 S DTI=$P($G(^PRST(458,PPI,1)),"^",DAY) Q:'DTI  S (DT1,DT2)=DTI
 I DN D D2 S:DN=2 DT1=DT2
 S DTIN=9999999-DT2,DA=0
 F KK=0:0 S KK=$O(^PRST(458.1,"AD",DFN,KK)) G:KK=""!(KK>DTIN) L3 F DA=0:0 S DA=$O(^PRST(458.1,"AD",DFN,KK,DA)) Q:DA=""  I ^(DA)'>DT1 D L1 G:LF L4
 Q
L1 S Z=$G(^PRST(458.1,DA,0)),LF=0 Q:$P(Z,"^",7)'=TT  S STAT=$P(Z,"^",9) I "XD"[STAT Q
 G:Y0="" L2 S Z1=$P(Y0,"^",1),Z2=$P(Y0,"^",2)
 S X=$P(Z,"^",4)_"^"_$P(Z,"^",6) D CNV^PRSATIM
 I $P(Z,"^",3)=DT1,$P(Y,"^",1)>Z1 Q
 I $P(Z,"^",5)=DT2,$P(Y,"^",2)<Z2 Q
L2 I STAT'="A" S ERR=4 D ERR
 S LF=1 Q
L3 S ERR=3 D ERR Q
L4 Q
D2 I DAY<14 S DT2=$P($G(^PRST(458,PPI,1)),"^",DAY+1) Q
 N X1,X2 S X1=DT1,X2=1 D C^%DTC S DT2=X Q
 ;
HENCAP ; Check for Holiday encapsulated by non-pay
 N DAH,DBH,HOL,QUIT
 S (DAH,DBH,HOL,QUIT)=""
 D HENCAP^PRSATP4(PPI,DFN,DAY,.DBH,.HOL,.DAH,.QUIT)
 Q:QUIT
 Q:HOL=""
 S ERR=15 D ERR Q  ; Holiday in current PP
 Q
NAWS3640(PRSEMP,PPI) ; return true if NAWS 36/40 Nurse for this PPI
 N EMPNODE,PAYPLAN,DTYBASIS,NORMHRS,S8
 S S8=$G(^PRST(458,PPI,"E",PRSEMP,5))
 I S8'="",($E(S8,26,27)'=72!("KM"'[$E(S8,28))!($E(S8,29)'=1)) Q 0
 S EMPNODE=$G(^PRSPC(PRSEMP,0))
 S PAYPLAN=$P(EMPNODE,U,21)
 S DTYBASIS=$P(EMPNODE,U,10)
 S NORMHRS=$P(EMPNODE,U,16)
 Q "KM"[PAYPLAN&(DTYBASIS=1)&(NORMHRS=72)
SAT2DAY(WK,PRSIEN,PPI) ;
 N HRS,SUNTRHRS,SAT2DAY,PRSD
 S SAT2DAY=0
 S PRSD=$S(WK=1:7,1:14)
 S SAT2DAY=$P($G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,0)),"^",2)
 I SAT2DAY>0 S SAT2DAY=$P($G(^PRST(457.1,SAT2DAY,0)),U,5)="Y"
 Q SAT2DAY
CARRYOVR(PRSIEN,PPI) ; true if hours are coming in from last pp
 N PRIORSAT,SAT2DAY
 S SAT2DAY=0
 S PRIORSAT=$P($G(^PRST(458,PPI-1,"E",PRSIEN,"D",14,0)),U,2)
 I PRIORSAT>0 S SAT2DAY=$P($G(^PRST(457.1,PRIORSAT,0)),U,5)="Y"
 Q SAT2DAY
THREE12(WK,PRSIEN,PPI) ;
 N PRSD,TOURDTY,COUNT,ST,EN
 S COUNT=0
 S ST=$S(WK=1:1,1:8),EN=$S(WK=1:7,1:14)
 F PRSD=ST:1:EN D
 . S TOURDTY=$P($G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,0)),"^",2)
 . I $P($G(^PRST(457.1,TOURDTY,0)),U,6)=12 S COUNT=COUNT+1
 I COUNT'=3 Q 1
 N HRS
 D TOURHRS^PRSARC07(.HRS,PPI,PRSIEN)
 Q:(HRS($S(WK=1:"W1",1:"W2"))'=36) 1
 Q 0
HRSMATCH(PPI,DFN) ; Return true if hourly employee tour hrs '= 8B normal hrs
 N MATCH,HRS,NH,ENT,ENTPTR
 I $G(PPI)'>0!($G(DFN)'>0) Q 1
 S MATCH=1
 S NH=-1
 S ENTPTR=$P($G(^PRST(458,PPI,"E",DFN,0)),U,5)
 I ENTPTR'="" D
 .  S ENT=$P($G(^PRST(457.5,ENTPTR,1)),U)
 .  S NH=$E($G(^PRST(458,PPI,"E",DFN,5)),26,27)
 .  Q:NH="00"
 .  I +NH'>0 S NH=$P($G(^PRSPC(DFN,0)),U,50)
 I $G(ENT)="" D ^PRSAENT
 I $G(ENT)'="",$E(ENT)'="D",($E(ENT,1,2)'="0D"),$G(NH)'=112 D
 .  D TOURHRS^PRSARC07(.HRS,PPI,DFN)
 .  I ($G(HRS("W1"))+$G(HRS("W2")))'=+$G(NH) S MATCH=0
 Q MATCH
 ;
ERR ; Set Error
 S ECNT=ECNT+1,ER(ECNT)=TT_$P($T(ERTX+ERR),";;",2)_"^"_$P(X2,"^",K) Q
ERR3640 ; Set NAWS (36/40) Errors and errors not related to a single segment
 S ECNT=ECNT+1,ER(ECNT)=$P($T(ERTX+ERR),";;",2) Q
ERTX ;;
1 ;;No Tour Entered^
2 ;;No Time Posted^
3 ;; not Requested
4 ;; Requested but not Approved
5 ;; Posted outside of Tour Hours or within Recess Hours
6 ;; Posted within Tour Hours or outside of Recess Hours
7 ;; Posted exceeds Requested Hours
8 ;; Requested but pending Supervisor Approval
9 ;; Supervisor Approved but pending Director Approval
10 ;; Overlaps with the start of the next day's Tour
11 ;; Overlaps with the prior day's Tour
12 ;; can only be posted against OT, CT, ON, & SB in Tour
13 ;; Posted exceeds Approved Hours
14 ;; The minimum charge for Military Leave is one hour
15 ;; was encapsulated by non-pay
16 ;;36/40 AWS nurse has a 2 day tour on Saturday^
17 ;;36/40 AWS nurse has tour carryover from prior pp^
18 ;;36/40 AWS nurse must have 3 12 hr tours in week 1^
19 ;;36/40 AWS nurse must have 3 12 hr tours in week 2^
20 ;;Normal/Tour hrs unequal^

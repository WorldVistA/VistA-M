SCMCBK6 ;bp/cmf - multiple patient assignments mail queue - RPCVersion = 1 ;;Aug 7, 1998
 ;;5.3;Scheduling;**148,177,210**;AUG 13, 1993
 Q
 ;
YSPTTMPC(DFN,SCACT) ;is it ok to give patient a new pc team?
 ;  Return [OK:1,Not OK: 0^Message]
 N SCOK,SCX,SCTM
 ;
 ;does pt have a current pc team?
 S SCTM=$$GETPCTM^SCAPMCU2(DFN,DT,1)
 I SCTM>0 D SCOK(2) G QTOKPC
 ;;;IF SCTM>0 S SCOK="0^Pt has current PC Team Assignment"_U_SCTM G QTOKPC
 ;
 ;does pt have a future pc team?
 S SCX=$O(^SCPT(404.42,"APCTM",DFN,1,SCACT))
 IF SCX D SCOK(3) G QTOKPC
 ;;;.S SCTM=$O(^SCPT(404.42,"APCTM",DFN,1,+SCX,0))
 ;;;.S SCOK="0^Patient has future PC Assignment to the "_$P($G(^SCTM(404.51,+SCTM,0)),U,1)_" team."_U_SCTM
 ;;;.D SCOK(3)
 ;
 S SCOK=1
QTOKPC Q SCOK
 ;
OKPTTMPC(DFN,SCTM,DATE) ; like OKPTTMPC^SCMCTMU2
 ;               ;;; supports meaningful reject messages
 ;               ;;; for PHASE II enhancement??
 ;  Return [OK:1,Not OK: 0^Message]
 N SCOK,SCPCTM,SCL
 S SCOK=1
 ;
 ;is this a possible pc team?
 ;;;I '$P($G(^SCTM(404.51,+$G(SCTM),0)),U,5) S SCOK=0 G QTOKTM
 I '$P($G(^SCTM(404.51,+$G(SCTM),0)),U,5) D SCOK(5) G QTOKTM
 S SCPCTM=$$GETPCTM^SCAPMCU2(DFN,DATE,1)
 I SCPCTM,SCPCTM'=SCTM D SCOK(7) G QTOKTM
 ;;;.I SCPCTM'=SCTM D
 ;;;..S SCOK=0
 ;;;;..D SCOK(7)
 E  D
 .S SCOK=$$YSPTTMPC(DFN,DATE)
QTOKTM Q SCOK
 ;
DP(DFN) ;output: boolean, is patient(DFN) dead?
 Q $P($G(^DPT(DFN,.35)),U)'=""
 ;
SCOK(SCL) ;
 ;input SCL = Text Line
 ;output = SCOK
 S SCOK="0^"_$$S(SCL)_U_$G(SCTM)
 Q
 ;
S(SCL) ;output: text string
 Q $P($T(T+SCL),";;",2)
 ;
T ;;
1 ;;Pt is deceased;;
2 ;;Pt has current PC assignment;;
3 ;;Pt has future PC assignment;;
4 ;;Pt has future team assignment;;
5 ;;Not PC team;;
6 ;;Team inactive;;
7 ;;Pt has PC assignment;;
 ;;
9 ;;Invalid setup;;
10 ;;Pt already assigned;;
11 ;;Filer error;;
12 ;;PC role not assignable;;
13 ;;Invalid position list;;
14 ;;Pt not added to team;;
15 ;;Pt being assigned by another PCMM process;;
 ;;

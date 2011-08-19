SCRPV1A ; bp/djb - PCMM Inconsistency Rpt - Get Data ; 8/25/99 9:57am
 ;;5.3;Scheduling;**177,528**;AUG 13, 1993;Build 4
 ;
 ;Return:
 ;  Inconsistency array in format:
 ;     ^TMP("PCMM POSITION",$J,#,Tm,TmPos,)=""
 ;     ^TMP("PCMM PATIENT",$J,Name,DFN,#,Tm,Pos)=""
 ;
 ;For a list of inconsistencies, see bottom of routine SCRPV1B.
 ;
EN ;
 D POSITION
 D PATIENT
 Q
 ;
POSITION ;Check for position inconsistencies.
 ;
 NEW POSI,POSN,TMI,TMN
 ;
 ;Look at each team
 S TMN=""
 F  S TMN=$O(^SCTM(404.51,"B",TMN)) Q:TMN=""  D  ;
 . S TMI=0
 . F  S TMI=$O(^SCTM(404.51,"B",TMN,TMI)) Q:'TMI  D  ;
 .. Q:'$D(^SCTM(404.51,TMI,0))
 .. ;If user selected teams, quit if this one isn't on list.
 .. I SCTYPE("TM")="S" Q:'$D(SCTM(TMI))
 .. ;Look at each position for this team
 .. S POSI=0
 .. F  S POSI=$O(^SCTM(404.57,"C",TMI,POSI)) Q:'POSI  D  ;
 ... S POSN=$P($G(^SCTM(404.57,POSI,0)),U,1) Q:POSN']""
 ... D CHECK45(TMI,POSI) ;..Check for inconsistencies 4 & 5.
 ... Q:'$D(^SCPT(404.43,"APTPA",POSI))
 ... D CHECK1(TMI,POSI) ;...Check for inconsistency 1.
 Q
 ;
PATIENT ;Check for patient inconsistencies.
 D CHECK28
 D CHECK367
 Q
 ;
CHECK1(TMI,POSI) ;Check positions for inconsistency 1.
 ;Input:
 ;   TMI  - Team IEN
 ;   POSI - Team Position IEN
 ;
 NEW POSN,TMN
 Q:+$$GETPRTP^SCAPMCU2(POSI,DT)  ;Current provider. Fld 304 in 404.57.
 Q:+$$ACTTM^SCMCTMU(TMI,DT)'=1  ;Team inactive
 Q:+$$ACTTP^SCMCTPU(POSI,DT)'=1  ;Position inactive
 S TMN=$$TMNAME(TMI)
 S POSN=$$POSNAME(POSI)
 S ^TMP("PCMM POSITION",$J,1,TMN,POSN)="" ;.........................#1
 Q
 ;
CHECK28 ;Check patients for inconsistencies 2 & 8.
 ;
 ;Loop thru 404.43 for each patient.
 ;Use "ACTDFN" xref. Active entries sorted by patient IEN.
 ;
 NEW DATA,DFN,DFNNAM,NUM,POSI,POSN,PTI,PTPI,TMI,TMN
 ;
 S DFN=0
 F  S DFN=$O(^SCPT(404.43,"ACTDFN",DFN)) Q:'DFN  D  ;
 . S PTPI=0
 . F  S PTPI=$O(^SCPT(404.43,"ACTDFN",DFN,PTPI)) Q:'PTPI  D  ;
 .. S DATA=$G(^SCPT(404.43,PTPI,0)) ;Team Position Assign zero node
 .. Q:$P(DATA,U,4)]""  ;.............Inactive
 .. S PTI=$P(DATA,U,1) Q:'PTI  ;.....Team Assign IEN
 .. S POSI=$P(DATA,U,2) Q:'POSI  ;...Position
 .. S DATA=$G(^SCPT(404.42,PTI,0)) ;.Team Assign zero node
 .. S TMI=$P(DATA,U,3) Q:'TMI  ;.....Team IEN
 .. ;
 .. ;If user selected teams, quit if this one isn't on list.
 .. I SCTYPE("TM")="S" Q:'$D(SCTM(TMI))
 .. ;
 .. S POSN=$$POSNAME(POSI)
 .. S TMN=$$TMNAME(TMI)
 .. S DFNNAM=$$PTNAME(DFN) ;Patient name
 .. ;
 .. D  ;Check for nconsistency 8
 ... I $P(DATA,U,9)]"" D  ;...............Tm Pos Assign Inactive....#8
 .... S ^TMP("PCMM PATIENT",$J,DFNNAM,DFN,8.1,TMN,POSN)=PTPI
 ... I +$$ACTTM^SCMCTMU(TMI,DT)'=1 D  ;...Team inactive.............#8
 .... S ^TMP("PCMM PATIENT",$J,DFNNAM,DFN,8.2,TMN,POSN)=PTPI
 ... I +$$ACTTP^SCMCTPU(POSI,DT)'=1 D  ;..Position inactive.........#8
 .... S ^TMP("PCMM PATIENT",$J,DFNNAM,DFN,8.3,TMN,POSN)=PTPI
 .. ;
 .. Q:$P(DATA,U,8)'=1  ;..Team Assign not PC
 .. Q:$P(DATA,U,9)]""  ;..Team Assign inactive
 .. ;
 .. ;Q:$D(^SCPT(404.43,"APCPOS",DFN,1))
 .. I $$GETPRTP^SCAPMCU2(POSI,DT)>0 Q  ;sd/528
 .. S ^TMP("PCMM PATIENT",$J,DFNNAM,DFN,2,TMN,POSN)=PTPI ;..........#2
 Q
 ;
CHECK367 ;Check patients for inconsistencies 3,6,7.
 ;
 ;Loop thru 404.43 for each patient.
 ;Use "ACTPC" xref. Active entries sorted by patient IEN & PC ROLE.
 ;
 NEW CNT,DATA,DFN,DFNNAM,HLD,POSI,POSN,PTI,PTPI,TMI,TMN
 ;
 S DFN=0
 F  S DFN=$O(^SCPT(404.43,"ACTPC",DFN)) Q:'DFN  D  ;
 . S CNT=0 KILL HLD ;Initialize for each DFN
 . S PTPI=0
 . F  S PTPI=$O(^SCPT(404.43,"ACTPC",DFN,1,PTPI)) Q:'PTPI  D  ;
 .. S DATA=$G(^SCPT(404.43,PTPI,0)) ;..Team Position Assign zero node
 .. Q:$P(DATA,U,4)]""  ;...............Inactive
 .. S PTI=$P(DATA,U,1) Q:'PTI  ;.......Team Assign IEN
 .. S POSI=$P(DATA,U,2) Q:'POSI  ;.....Position
 .. S DATA=$G(^SCPT(404.42,PTI,0)) ;...Team Assign zero node
 .. S TMI=$P(DATA,U,3) Q:'TMI  ;.......Team IEN
 .. ;
 .. ;If user selected teams, quit if this one isn't on list.
 .. I SCTYPE("TM")="S" Q:'$D(SCTM(TMI))
 .. ;
 .. Q:$P(DATA,U,8)'=1  ;...............Team Assign not PC
 .. Q:$P(DATA,U,9)]""  ;...............Team Assign inactive
 .. S POSN=$$POSNAME(POSI)
 .. S TMN=$$TMNAME(TMI)
 .. S DFNNAM=$$PTNAME(DFN) ;Patient name
 .. ;
 .. D CHECK67
 .. ;
 .. S CNT=CNT+1
 .. ;Save 1st occurance. Asingle occurance is not a problem.
 .. I CNT=1 S HLD(DFNNAM,DFN,3,TMN,POSN)="" Q
 .. ;
 .. ;If there is a 2nd occurance, move 1st occurance into array.
 .. I CNT=2 M ^TMP("PCMM PATIENT",$J)=HLD KILL HLD
 .. S ^TMP("PCMM PATIENT",$J,DFNNAM,DFN,3,TMN,POSN)=PTPI ;..........#3
 Q
 ;
CHECK45(TMI,POSI) ;Check positions for inconsistencies 4 & 5.
 ;Input:
 ;   TMI  - Team IEN
 ;   POSI - Team Position IEN
 ;
 NEW AP,DATA,PCP,POSN,PREHI,STAFFAP,STAFFPCP,TMN
 ;
 S PREHI=0
 F  S PREHI=$O(^SCTM(404.53,"B",POSI,PREHI)) Q:'PREHI  D  ;
 . S DATA=$G(^SCTM(404.53,PREHI,0))
 . Q:DATA']""
 . S AP=$P(DATA,U,1) ;.....................Preceptee position
 . S PCP=$P(DATA,U,6) ;....................Preceptor position
 . S STAFFAP=+$$GETPRTP^SCAPMCU2(AP,DT) ;..Preceptee staff person
 . S STAFFPCP=+$$GETPRTP^SCAPMCU2(PCP,DT) ;Preceptor staff person
 . ;
 . S TMN=$$TMNAME(TMI)
 . S POSN=$$POSNAME(POSI)
 . I STAFFAP,STAFFAP=STAFFPCP D  ;
 .. S ^TMP("PCMM POSITION",$J,4,TMN,POSN)="" ;......................#4
 . I STAFFPCP="" D  ;
 .. S ^TMP("PCMM POSITION",$J,5,TMN,POSN)="" ;......................#5
 Q
 ;
CHECK67 ;Check patients for inconsistencies 6 & 7.
 NEW ERROR,ID,LIST,NUM,POS,RESULT,TYPE,ZDATE
 ;
 S ZDATE("BEGIN")=DT
 S ZDATE("END")=DT
 S ZDATE("INCL")=0
 ;
 S RESULT=$$PRPTTPC^SCAPMC(PTPI,"ZDATE","LIST","ERROR",1)
 ;
 S NUM=0
 F  S NUM=$O(LIST(NUM)) Q:'NUM  D  ;
 . S TYPE=""
 . F  S TYPE=$O(LIST(NUM,TYPE)) Q:TYPE=""  D  ;
 .. S ID=""
 .. F  S ID=$O(LIST(NUM,TYPE,ID)) Q:ID=""  D  ;
 ... S POS=$P(LIST(NUM,TYPE,ID),U,3) Q:'POS
 ... ;See if field 4, POSSIBLE PRIMARY PRACTITIONER, equals 1.
 ... Q:$P($G(^SCTM(404.57,POS,0)),U,4)=1
 ... I TYPE="AP" D  Q
 .... S ^TMP("PCMM PATIENT",$J,DFNNAM,DFN,6,TMN,POSN)=PTPI ;........#6
 ... I TYPE="PCP" D  Q
 .... S ^TMP("PCMM PATIENT",$J,DFNNAM,DFN,7,TMN,POSN)=PTPI ;........#7
 Q
 ;
TMNAME(TMI) ;Return team name
 NEW NAME
 S NAME=$P($G(^SCTM(404.51,TMI,0)),U,1)
 S:NAME="" NAME="UNKNOWN"
 Q NAME
 ;
POSNAME(POSI) ;Return position name
 NEW NAME
 S NAME=$P($G(^SCTM(404.57,POSI,0)),U,1)
 S:NAME="" NAME="UNKNOWN"
 Q NAME
 ;
PTNAME(DFN) ;Return patient name
 NEW NAME
 S NAME=$P($G(^DPT(DFN,0)),U,1)
 S:NAME="" NAME="UNKNOWN"
 Q NAME

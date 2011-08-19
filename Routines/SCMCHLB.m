SCMCHLB ;BP/DJB - PCMM HL7 Bld Segment Array ; 3/2/00 2:12pm
 ;;5.3;Scheduling;**177,204,210,224,515,532**;AUG 13, 1993;Build 21
 ;
BUILD(VARPTR,HL,XMITARRY) ;Build an array of HL7 segments based on EVENT
 ;POINTER field in PCMM HL7 EVENT file (#404.48).
 ;
 ;Input:
 ;     VARPTR   - EVENT POINTER field in PCMM HL7 EVENT file.
 ;     HL       - Array of HL7 variables (pass by reference).
 ;                Output of call to INIT^HLFNC2().
 ;     XMITARRY - Array to store HL7 segments (full global ref).
 ;                Default=^TMP("HLS",$J)
 ;Output:
 ;     XMITARRY(n,segment) array of segments.
 ;        Examples:
 ;           ^TMP("PCMM","HL7",$J,2290,"PID")...= PID segment
 ;           ^TMP("PCMM","HL7",$J,2290,"ZPC",ID)= ZPC segments
 ;     -1^Error = Unable to build message / bad input
 ;
 ;Note: The calling program must initialize (i.e. KILL) XMITARRY.
 ;
 ;Declare variables
 NEW RESULT,SCIEN,SCGLB
 NEW HLECH,HLEID,HLFS,HLQ
 ;
 ;Convert VARPTR (ien;global) to SCIEN & SCGLB
 S RESULT=$$CHECK^SCMCHLB1($G(VARPTR))
 ;
 I 'RESULT Q "-1^Did not pass valid variable pointer"
 ;
 ;Initialize HL7 variables
 S HLECH=HL("ECH")
 S HLFS=HL("FS")
 S HLQ=HL("Q")
 ;
 I RESULT=2 D  G QUIT ;........................Process a deletion
 . I SCGLB="SCPT(404.43," D PTP^SCMCHLB2 Q  ;..Delete - File 404.43
 . I SCGLB="SCTM(404.52," D POS^SCMCHLB2 Q  ;..Delete - File 404.52
 . I SCGLB="SCTM(404.53," D PRE^SCMCHLB2 Q  ;..Delete - File 404.53
 I SCGLB="SCPT(404.43," D PTP(SCIEN,"") G QUIT ;..File 404.43
 I SCGLB="SCTM(404.52," D POS G QUIT ;.........File 404.52
 I SCGLB="SCTM(404.53," D PRE G QUIT ;.........File 404.53
QUIT Q 1
 ;
 ;==================================================================
 ;
PTP(PTPI,SCTPAIN) ;Patient Team Position Assignment (#404.43).
 ;Input: PTPI - Patient Team Position Assignment IEN
 ;
 ;To keep VISTA and NPCD in sync, for this PT TM POS ASSIGN send
 ;down a delete for all previous entries, and then send down data
 ;for current valid entries.
 ;
 ;NEW DFN,ERROR,ND,ZDATE,ZPTP
 ;djb/bp Added SCSEQ per Patch 210, replace above line with below line
 ;NEW DFN,ERROR,ND,SCSEQ,ZDATE,ZPTP
 ; ADDED SCLOW SCTPTPA PATCH 515 DLL
 NEW DFN,ERROR,ND,SCSEQ,ZDATE,ZPTP,SCLOW,SCTPTPA
 ;
 ;Get data
 S ND=$G(^SCPT(404.43,PTPI,0))
 S DFN=$$DFN^SCMCHLB1(ND) Q:'DFN  ;..Patient
 ;
 ;Get only valid entries for this PT TM POS ASSIGN. This call returns
 ;provider array for a patient team position assignment.
 ;Example: ZPTP(8944,"AP","8944-909-0-AP")=data
 ;         ZPTP(8944,"PCP","8944-911-157-PCP")=data
 KILL ZPTP
 D SETDATE ;Set date array
 S RESULT=$$PRPTTPC^SCAPMC(PTPI,"ZDATE","ZPTP","ERROR","",1)
 ; add check if primary PATCH 515 BEGIN
 ;  S SCTPTPA=$$TPACHK("",PTPI,SCTPAIN
 S SCTPTPA=$$TPACHK("",PTPI,"")
 ; If not primary then call GETOEF to find others
 S SCLOW=PTPI
 ;REMOVED IF SCTPTPA=1/532/TEH at first, now it's back in
 IF SCTPTPA=1 S SCLOW=$$GETOEF(PTPI,"","")
 ; PATCH 515 END
 ;
 ;If no valid history don't build any segments
 Q:'$D(ZPTP)
 ;
 ;Build EVN & PID segments
 D SEGMENTS^SCMCHLB1(DFN,PTPI)
 ;
 ;Generate deletes for all ID's starting with this PT TM POS ASSIGN.
 ; PATCH 515 - CHG ALWAYS DELETE TO NOT IF TPA
 ; OLD CODE =  D PTPD^SCMCHLB2(PTPI)
  IF SCTPTPA'=1 S NUM=PTPI D PTPD^SCMCHLB2(PTPI)
 ;
 ;Build data type ZPC segments.
 D ZPC^SCMCHLB1(.ZPTP)
 ;alb/rpm;Patch 224 Decrement max msg counter
 I $D(SCLIMIT) S SCLIMIT=SCLIMIT-1
 Q
 ;
POS ;Position Assign History (#404.52)
 ;
 ;To keep VISTA and NPCD in sync, for every primary care entry in Pt
 ;Tm Pos Assign for this TEAM POSITION, send down all valid entries.
 ;
 NEW TMPOS,TP
 ;
 ;Team Position pointer
 S TMPOS=$P($G(^SCTM(404.52,SCIEN,0)),U,1)
 Q:'TMPOS
 ;
 ;Get History entries for each PT TM POS ASSIGN
 D POS1(TMPOS)
 ;
 ;What if this TEAM POSITION is also a preceptor? Find every TEAM
 ;POSITION being precepted by this TEAM POSITION and for each, find
 ;every PT TM POS ASSIGN and send down all valid History entries.
 ;
 S TP=0
 F  S TP=$O(^SCTM(404.53,"AD",TMPOS,TP)) Q:'TP  D POS1(TP)
 Q
 ;
POS1(TMPOS) ;Find every primary care PT TM POS ASSIGN for this TEAM POSITION
 ;and get all valid History entries.
 ;Input:
 ;   TMPOS - TEAM POSITION pointer
 ;
 Q:'$G(TMPOS)
 NEW IFN,ND,TM,SCTPTPA
 S SCTPTPA=$$TPACHK(TMPOS,"","")
 ;
 ; ..; PTA CHG  20070518  SD*5.3*515
 ; OLD CODE =  S TM=0 (WAS MISSING PEOPLE)
 S TM=""
 F  S TM=$O(^SCPT(404.43,"APTPA",TMPOS,TM)) Q:'TM  D  ;
 . S IFN=0
 . F  S IFN=$O(^SCPT(404.43,"APTPA",TMPOS,TM,IFN)) Q:'IFN  D  ;
 .. S ND=$G(^SCPT(404.43,IFN,0))
 ..; Q:($P(ND,U,5)'=1)  ; Must be Primary Care
 ..; PTA CHG  20070518  SD*5.3*515
 ..Q:(($P(ND,U,5)'=1)&(SCTPTPA=0))  ; Must be Primary Care OR PTA
 ..; D PTP(IFN,SCTPTPA) ;..........Bld segments for this PT TM POS ASSIGN
 ..D PTP(IFN,"") ;..........Bld segments for this PT TM POS ASSIGN
 Q
 ;
PRE ;Preceptor Assign History (#404.53)
 ;
 ;Get TEAM POSITION pointer of preceptee. Find every primary care
 ;PT TM POS ASSIGN for this TEAM POSITION and send down all valid
 ;History entries.
 ;
 NEW TMPOS
 ;
 ;Preceptee TEAM POSITION pointer
 S TMPOS=$P($G(^SCTM(404.53,SCIEN,0)),U,1)
 Q:'TMPOS
 D POS1(TMPOS) ;Get History entries for each PT TM POS ASSIGN
 ;
 ;Preceptor TEAM POSITION pointer
 S TMPOS=$P($G(^SCTM(404.53,SCIEN,0)),U,6)
 Q:'TMPOS
 D POS1(TMPOS) ;Get History entries for each PT TM POS ASSIGN
 Q
 ;
SETDATE ;Set all encompassing date array
 S ZDATE("BEGIN")=2800101
 S ZDATE("END")=9991231
 S ZDATE("INCL")=0
 Q
TPACHK(SCTP,SCPTPI,SCROLEP)   ; CHECK IF TEAM POSITION IS A PTA
 ; levyd 20070518  SD*5.3*515
 ;Get data FROM 43 
 NEW ND,SCPC,SCTPD,SCTPX,SCROL,SCTM,SCTPA,TMD,SCTMP,SCTPTA,SCTPA,SCROLX,SCPURX,SCUP,SCLOW,SCROLY
 S SCTPA=0
 S SCPURX="OIF OEF"
 S SCROLX="/TPA/PM/CCM/"
 S SCUP="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 S SCLOW="abcdefghijklmnopqrstuvwxyz"
 I $L(SCPTPI) D  ;
 .S ND=$G(^SCPT(404.43,SCPTPI,0))
 .; DEBBIE LEVY PTA CHGS 20070518
 .; PRIMARY CARE ROLE CHECK
 .IF $L(ND) S SCPC=$P(ND,U,5) D  ;
 ..IF SCPC'=1 S SCTP=$P(ND,U,2) ; TP
 ; READ TP REC (57)
 IF SCTP="" Q SCTPA
 S SCTPD=$G(^SCTM(404.57,SCTP,0))
 S SCTPX=$P(SCTPD,U,4) ;not primary
 IF SCTPX=1 Q SCTPA
 S SCROL=$P(SCTPD,U,3)
 S SCROL=$P(^SD(403.46,SCROL,0),U,1)
 IF $G(SCROLEP)=1 S SCROL=$$TPACHGRL(SCROL) Q SCROL
 IF $G(SCROLEP)="" S SCROL=$$TPACHGRL(SCROL)
 S SCTM=$P(SCTPD,U,2)
 S SCROLY="/"_SCROL_"/"
 S SCTPA=0 I SCROLX[SCROLY S SCTPA=1 ; OEF ROLE
 ; READ TEAM FILE (404.51
 S TMD=^SCTM(404.51,SCTM,0)
 S SCTMP=$P(TMD,U,3)
 S SCTMP=^SD(403.47,SCTMP,0)
 ; CONVERT STR LOWER CASE TO UPPER CASE
 S SCTMP=$TR(SCTMP,SCLOW,SCUP)
 S SCTPTA=0 I SCTMP[SCPURX S SCTPTA=1
 I ((SCTPA=1)&(SCTPTA=1)) S SCTPA=1
QT Q SCTPA
 ;
GETOEF(PTPI,EFFDT,ENDDT) ;Find All OIF OEF RELATIONSHIPS FOR THIS TP in TPS array
 ; NEW RTN ADDED W PATCH 515 BY DLL 
 ;Input: TP - Team Position IEN
 ; EFFDT = Team Position EFFECTIVE DATE (OPTIONAL)
 ; ENDDT = Team Position EXPIRATION DATE (OPTIONAL)
 NEW TP,COUNT,TPD,TPX,TPDX,TPXX,TPDXX,SCOLDPAT,SCOLDTM,SCOLDTP,SCLOW,DFNX,DFNY
 S SCLOW=PTPI
 IF ENDDT="" S ENDDT=9991231
 K SCTPS,SCPCP
 ; save original trigger TP, person and team
 S SCOLD43I=PTPI
  ;Get data
 S ND=$G(^SCPT(404.43,PTPI,0))
 S DFNY=$P(ND,U,1)
 S DFNX=$G(^SCPT(404.42,DFNY,0))
 S SCOLDTP=$P(ND,U,2)
 S SCOLDPAT=$P(DFNX,U,1)
 S SCOLDTM=$P(DFNX,U,3)
 ; read thru the patient assignments for this person in 42 ^SCPT(404.42,"B",3994,6930)
 S TPX=""
 S COUNT=0
 F  S TPX=$O(^SCPT(404.42,"B",SCOLDPAT,TPX))  Q:'TPX  D
 . S TPDX=$G(^SCPT(404.42,TPX,0))
 . Q:$P(TPDX,U,3)'=SCOLDTM       ;MUST be SAME TEAM
 . ; red thru the the assignments for this patient ass in 43 ^SCPT(404.43,"B",6930
 .S TPXX=""
 .F  S TPXX=$O(^SCPT(404.43,"B",TPX,TPXX))  Q:'TPXX  D
 ..S TPDXX=$G(^SCPT(404.43,TPXX,0))
 ..S TP=$P(TPDXX,U,2)
 ..IF $G(SCPCP(TP))'=1 D   ;   TP NOT THERE ALREADY THEN ADD IT TO SCTPS
 ...S COUNT=COUNT+1
 ...S SCTPS(COUNT)=TP
 ...S SCPCP(TP)=1
 ...IF TP'=SCOLDTP  D
 ....S RESULT=$$PRPTTPC^SCAPMC(TPXX,"ZDATE","ZPTP","ERROR","",1)
 S SCLOW=$$TPAIDS(.ZPTP,.PTPI)
 Q SCLOW
TPACHGRL(SCROLEIN) ;ROLE ABBREVIATION
 NEW SCUP,SCLOW,SCPURX
 S SCPURX="OIF OEF"
 S SCROLOUT=""
 Q:$L($G(SCROLEIN))=0
 S SCUP="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 S SCLOW="abcdefghijklmnopqrstuvwxyz"
 ; CONVERT STR LOWer case  TO UPper case
 S SCROLEIN=$TR(SCROLEIN,SCLOW,SCUP)
 IF (SCROLEIN["TRANSITION PATIENT ADV")&(SCROLEIN[SCPURX) S SCROLOUT="TPA"
 IF (SCROLEIN["PROGRAM MANA")&(SCROLEIN[SCPURX) S SCROLOUT="PM"
 IF (SCROLEIN["CLINICAL CASE MAN")&(SCROLEIN[SCPURX) S SCROLOUT="CCM"
 Q SCROLOUT
TPAIDS(ARRAY,OLDPTPI) ;GET ROLE FROM ID & CHANGE  
 NEW DATA,ID,SCNEWID,NUM,TYPE,SCROLE,SCNEWROL,SCLOW,SCPTPI
 S SCLOW=""
 S NUM=0
 F  S NUM=$O(ARRAY(NUM)) Q:'NUM  D  ;
 .S TYPE=""
 .F  S TYPE=$O(ARRAY(NUM,TYPE)) Q:TYPE=""  D  ;
 ..S ID=""
 ..F  S ID=$O(ARRAY(NUM,TYPE,ID)) Q:ID=""  D  ;
 ...S DATA=$G(ARRAY(NUM,TYPE,ID))
 ...; GET ROLE FROM ID & CHANGE
 ...S SCROLE=$P(ID,"-",4)
 ...S SCPTPI=$P(ID,"-",1)
 ...IF SCROLE="PCP" D  ; 
 ....S SCNEWROL=$$TPACHK^SCMCHLB("",$P(ID,"-",1),1)
 ....;IF $L(SCNEWROL) D ;CHANGED IN 532 TO PATTERN MATCH
 ....I SCNEWROL?1.3A D
 .....S SCNEWID=ID
 .....S $P(SCNEWID,"-",4)=SCNEWROL
 .....S ARRAY(OLDPTPI,SCPTPI,SCNEWID)=DATA
 .....K ARRAY(NUM,TYPE,ID)
 .....S NUMX=NUM
 .....S NUM=OLDPTPI
 .....D PTPD^SCMCHLB2(SCPTPI)
 .....S NUM=NUMX
 .....; XMITARRY="^TMP("PCMM","HL7",546445648)"
 .....; K ^TMP("PCMM","HL7",$J,SCPTPI,"EVN")
 .....; K ^TMP("PCMM","HL7",$J,SCPTPI,"PID")
 .....;K @XMITARRY@(SCPTPI,"EVN",1) comment to stop the missing segments
 .....;K @XMITARRY@(SCPTPI,"PID",1) comment to stop the missing segments
 Q SCLOW

SCAPMC34  ;BP/DJB - Get PCP/AP Array For a Pt Tm Pos ; 5/24/99 12:39pm
 ;;5.3;Scheduling;**177,212**;May 01, 1999
 ;
PRPTTPC(PTTMPOS,SCDATES,SCLIST,SCERR,SCALLHIS,ADJDATE) ;
 ;Get provider array for a Patient Team Position Assignment (#404.43).
 ;
 ; Input: See PRPTTP^SCAPMC33
 ;Output: See PRTP^SCAPMC8
 ;
 ;Returned: 1 if ok, 0 if error
 ;
 ;Declare variables
 NEW EDATE,ND,OK,PRPTTPC,SDATE,TMPOSPTR
 ;
 ;Initialize variables
 S OK=0
 ;
 ;Check input
 I '$G(PTTMPOS) G QUIT
 I '$D(^SCPT(404.43,PTTMPOS,0)) G QUIT
 ;
 ;Get data
 S ND=$G(^SCPT(404.43,PTTMPOS,0)) ;Zero node of 404.43
 S TMPOSPTR=$P(ND,U,2) ;...........Team Position IEN
 I 'TMPOSPTR G QUIT
 S SDATE=$P(ND,U,3) ;..............Assigned Date
 S EDATE=$P(ND,U,4) ;..............Unassigned Date
 ;
 S OK=$$ADJUST1^SCAPMC33(SDATE,EDATE)
 G:'OK QUIT
 ;Get temporary array in PRPTTPC. It will be converted to @SCLIST.
 S OK=$$PRTPC^SCAPMC(TMPOSPTR,.SCDATES,"PRPTTPC",.SCERR,.SCALLHIS,.ADJDATE)
 G:'OK QUIT
 G:'$D(PRPTTPC) QUIT
 ;
 ;alb/rpm - Patch 212 start
 D ADJUST(EDATE) ;Convert array & adjust dates and unique ID subscript
 ;alb/rpm - Patch 212 end
 ;
QUIT Q OK
 ;
ADJUST(SCUDATE) ;Convert PROV-P/PROV-U/PREC array to AP/PCP array. Adjust Start/End
 ;dates in SCLIST array so they don't exceed requested date range.
 ;Add the Pt Tm Pos Assign IEN to unique ID string.
 ;alb/rpm Patch 212 start
 ; Input:
 ;       SCUDATE - Pt Tm Pos Unassign date [default=""]
 ;
 ; Output:  None
 ;alb/rpm Patch 212 end
 ;
 NEW DATA,ID,ID1,NUM,PREH,TYPE,TYPE1
 Q:'$D(PRPTTPC)
 ;
 ;alb/rpm Patch 212 start
 S SCUDATE=$G(SCUDATE,"")
 ;alb/rpm Patch 212 end
 ;
 ;Loop thru returned array and make adjustments.
 S NUM=0
 F  S NUM=$O(PRPTTPC(NUM)) Q:'NUM  S TYPE="" F  S TYPE=$O(PRPTTPC(NUM,TYPE)) Q:TYPE=""  S ID="" F  S ID=$O(PRPTTPC(NUM,TYPE,ID)) Q:ID=""  D  ;
 . S DATA=$G(PRPTTPC(NUM,TYPE,ID))
 . ;
 . ;alb/rpm Patch 212 start
 . ;
 . ;Adjust preceptor act/inact dates to represent preceptor
 . ;assign/unassign dates.
 . ;
 . I $G(ADJDATE),TYPE="PREC" D
 . . I $P(DATA,U,9)<$P(DATA,U,14) S $P(DATA,U,9)=$P(DATA,U,14)
 . . I $P(DATA,U,15)]"",$P(DATA,U,10)="" S $P(DATA,U,10)=$P(DATA,U,15)
 . ;
 . ;Enable the date adjustment to work correctly when no Team Position
 . ;Inactivation Date exists during a Patient Team Position Unassignment
 . ;by stuffing the Patient Team Position Unassignment Date into the Team
 . ;Position Inactivation Date field.  
 . ;
 . I $G(ADJDATE),SCUDATE]"",$P(DATA,U,10)="" S $P(DATA,U,10)=SCUDATE
 . ;
 . ;Continue only if the Act/Inact dates fall within Assign/Unassign
 . ;dates
 . ;
 . I $G(ADJDATE),'$$DTCHK^SCAPU1(@SCDATES@("BEGIN"),@SCDATES@("END"),0,$P(DATA,U,9),$P(DATA,U,10)) Q
 . ;
 . ;alb/rpm Patch 212 end
 . ;
 . ;Adjust dates
 . I $G(ADJDATE) D  ;
 . . I $P(DATA,U,9)<@SCDATES@("BEGIN") D  ;Begin Date
 . . . S $P(DATA,U,9)=@SCDATES@("BEGIN")
 . . I @SCDATES@("END"),$P(DATA,U,10)>@SCDATES@("END") D  ;End Date
 . . . S $P(DATA,U,10)=@SCDATES@("END")
 . ;
 . ;Add Patient Team Position Assign pointer to ID.
 . S ID1=PTTMPOS_"-"_ID
 . ;Mark subscript as AP or PCP
 . S TYPE1=$S(ID["AP":"AP",1:"PCP")
 . ;Build return array
 . S @SCLIST@(PTTMPOS,TYPE1,ID1)=DATA
 . Q
 Q
 ;
PROV(PTTMPOS,SCDATE,SCTYPE,SCPIECE) ;Return a single node/piece for AP/PCP
 ;
 ;Input:
 ;      PTTMPOS - Pointer to entry in PATIENT TEAM POSITION
 ;                ASSIGNMENT file (#404.43).
 ;       SCDATE - A single date.
 ;       SCTYPE - AP:  Associate Provider
 ;                PCP: Primary Care Provider
 ;                Default=PCP
 ;      SCPIECE - Enter number of piece of string you want displayed.
 ;                If null, return entire string.
 ;                See PRTP^SCAPMC8 for a description of the string
 ;                pieces.
 ;Return: Data specified by SCPIECE. See PRTP^SCAPMC8 for a
 ;        description of the string pieces.
 ;
 NEW DATA,ERR,I,ID,IEN,PROV,RESULT,TMP,TYPE,ZDATE
 ;
 ;Initialize variables
 I '$G(PTTMPOS) Q ""
 I '$D(^SCPT(404.43,PTTMPOS,0)) Q ""
 I '$G(SCDATE) Q ""
 S ZDATE("BEGIN")=SCDATE
 S ZDATE("END")=SCDATE
 S ZDATE("INCL")=0
 S:$G(SCTYPE)'="AP" SCTYPE="PCP"
 S TYPE=$S(SCTYPE="PCP":"AP",1:"PCP")
 S SCPIECE=$G(SCPIECE)
 ;
 S RESULT=$$PRPTTPC^SCAPMC(PTTMPOS,"ZDATE","PROV","ERR",1)
 I 'RESULT Q ""
 ;
 ;Build temp array subscripted by 404.52 IEN
 S PTTMPOS=0
 F  S PTTMPOS=$O(PROV(PTTMPOS)) Q:'PTTMPOS  D  ;
 . S ID=""
 . F  S ID=$O(PROV(PTTMPOS,SCTYPE,ID)) Q:ID=""  D  ;
 . . S IEN=$P(PROV(PTTMPOS,SCTYPE,ID),"^",11)
 . . S TMP(IEN)=PTTMPOS_U_SCTYPE_U_ID
 ;
 ;If more than one node, delete all but one with highest 404.52 IEN.
 S IEN=$O(TMP(""),-1) I 'IEN Q ""
 S DATA=$G(TMP(IEN))
 S DATA=$G(PROV($P(DATA,U,1),$P(DATA,U,2),$P(DATA,U,3)))
 I SCPIECE S DATA=$P(DATA,U,SCPIECE)
 Q DATA

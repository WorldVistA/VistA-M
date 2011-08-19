GMRCPC1 ;SLC/dee - List Manager Routine: Collect and display consults by service and status ;1/27/00
 ;;3.0;CONSULT/REQUEST TRACKING;**7**;DEC 27, 1997
 Q
 ;
ENSTS ;GMRC List Manager Routine -- Second entry point for GMRC PENDING CONSULTS with user selected statuses
 S GMRCSTAT=$$STS
 I $D(GMRCQUT) D EXIT^GMRCPC Q
 D EN^GMRCPC
 Q
 ;
NEWSTS ;
 N TEMPSTAT
 S TEMPSTAT=GMRCSTAT
 S GMRCSTAT=$$STS
 S:$D(GMRCQUT) GMRCSTAT=TEMPSTAT
 Q
 ;
STS() ;Select a set of status for view.
 I $D(IOTM),$D(IOBM),$D(IOSTBM) D FULL^VALM1
 N DIR,X,Y,GMRCSTCK
STSAGAIN ;Loop to get another status.
 ;The following commented line would as for all of the statuses.
 ;S DIR(0)="SAOM^al:All Status's;ap:All Pending;dc:Discont.;c:Completed;h:On Hold;f:Flagged;p:Pending;a:Active;e:Expired;s:Scheduled;pr:Incomplete;d:Delayed;u:Unreleased;dce:Discont/Ed;x:Cancelled;l:Lapsed;rn:Renewed;':No Status"
 S DIR(0)="SAOM^al:All Status's;ap:All Pending;dc:Discont.;c:Completed;p:Pending;a:Active;s:Scheduled;pr:Incomplete;x:Cancelled"
 S DIR("A")="Only Display Consults With Status of: "
 S DIR("B")="All Status's"
 I $G(GMRCSTCK) D
 . S DIR("A")="Another Status to display: "
 . K DIR("B")
 D ^DIR
 I $D(DUOUT)!($D(DTOUT)) S GMRCQUT=1 G END
 I '$L(Y) G END
 D STCK($$LOW^XLFSTR(Y))
 G:$G(GMRCSTCK)'="1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,99" STSAGAIN
END Q $S($D(GMRCSTCK):GMRCSTCK,1:"")
 ;
STCK(RES)     ;change code to status
 N CODE
 ; al:All Status's;dc:Discont.;c:Completed;h:On Hold;f:Flagged;p:Pending;a:Active;e:Expired;s:Scheduled
 ;;pr:Incomplete;d:Delayed;u:Unreleased;dce:Discont/Ed;x:Cancelled;l:Lapsed;rn:Renewed;':No Status")
CASE ;
 I RES="al" S GMRCSTCK="1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,99" Q  ;All Status's
 ;                                display     no.  file name      file abbr.
 I RES="ap" D  Q
 .F CODE=3,4,5,6,8,9,11,99 D CKCODE(CODE) ;   All Pending Statuses
 I RES="dc" D CKCODE(1) Q  ;  Discont.     1  DISCONTINUED       dc
 I RES="c" D CKCODE(2) Q  ;   Completed    2  COMPLETE           c
 I RES="h" D CKCODE(3) Q  ;   On Hold      3  HOLD               h
 I RES="f" D CKCODE(4) Q  ;   Flagged      4  FLAGGED           "?"
 I RES="p" D CKCODE(5) Q  ;   Pending      5  PENDING            p
 I RES="a" D CKCODE(6) Q  ;   Active       6  ACTIVE             a
 I RES="e" D CKCODE(7) Q  ;   Expired      7  EXPIRED            e
 I RES="s" D CKCODE(8) Q  ;   Scheduled    8  SCHEDULED          s
 I RES="pr" D CKCODE(9) Q  ;  Incomplete   9  PARTIAL RESULTS    pr
 I RES="d" D CKCODE(10) Q  ;  Delayed     10  DELAYED            d
 I RES="u" D CKCODE(11) Q  ;  Unreseased  11  UNRELEASED         u
 I RES="dce" D CKCODE(12) Q  ;Discont/Ed  12  DISCONTINUED/EDIT  dce
 I RES="x" D CKCODE(13) Q  ;  Cancelled   13  CANCELLED          x
 I RES="l" D CKCODE(14) Q  ;  Lapsed      14  LAPSED             l
 I RES="rn" D CKCODE(15) Q  ; Renewed     15  RENEWED            rn
 I RES="'" D CKCODE(99) Q  ;  No Status   99  NO STATUS          '
ENDCASE Q
 ;
CKCODE(CODE) ;
 I $D(GMRCSTCK),$$FND(CODE) W $C(7),!,"Already selected" Q
 I +$G(GMRCSTCK) S GMRCSTCK=GMRCSTCK_","_CODE
 E  S GMRCSTCK=CODE
 Q
 ;
FND(CD) ;status already selected?
 I GMRCSTCK=CD Q 1
 I $F(GMRCSTCK,(CD_",")) Q 1
 I $E(GMRCSTCK,$L(GMRCSTCK))=CD Q 1
 Q 0
 ;
NUMBER ;
 I GMRCCTRL'=120 S GMRCCTRL=120
 E  S GMRCCTRL=0
 Q
 ;

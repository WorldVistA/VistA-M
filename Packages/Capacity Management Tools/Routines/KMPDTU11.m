KMPDTU11 ;OAK/RAK - CP Tools Timing Utility ;5/1/07  15:07
 ;;2.0;CAPACITY MANAGEMENT TOOLS;**6**;Mar 22, 2002;Build 3
 ;
RLTMHR(KMPDQIET,KMPDASK,KMPDEF) ;-- extrinsic function - real time hours
 ;-----------------------------------------------------------------------
 ; KMPDQIET... Display output
 ;              0 - display output (not quiet)
 ;              1 - do not display output (quiet)
 ; KMPDASK.... Ask user to select hours
 ;              0 - do not ask user to select
 ;              1 - ask user to select
 ; KMPDEF..... Default
 ;              0 - do not use default
 ;              1 - use time range as default
 ;
 ; Return: List of hours (ie, 1,2,5,6,7...)
 ;         "" - no selection made
 ;-----------------------------------------------------------------------
 ;
 S KMPDQIET=+$G(KMPDQIET),KMPDASK=+$G(KMPDASK),KMPDEF=+$G(KMPDEF)
 N DATA,DIR,DOT,HOURS,HR,I,QUEUED,X,Y
 W:'KMPDQIET !," ==> building Hours list..."
 S I="",DOT=0
 F  S I=$O(^KMPTMP("KMPDT","ORWCV",I)) Q:I=""  S DATA=^(I) I DATA]"" D 
 .S DOT=DOT+1 W:'(DOT#1000)&('KMPDQIET) "."
 .; change $h to fileman format and get hour
 .S HR=$E($P($$HTFM^XLFDT($P(DATA,U)),".",2),1,2) S:HR>23 HR="0"
 .; create HOURS() array
 .S:HR'="" HOURS(+HR)=""
 ;
 ; if no HOURS() array
 Q:'$D(HOURS) ""
 ;
 ; do not ask user to select hours
 I 'KMPDASK D  Q X
 .S (I,X)="" F  S I=$O(HOURS(I)) Q:I=""  S X=X_I_","
 ;
 ; ask user to select hour(s)
 S DIR(0)="LO^"_$O(HOURS(""))_":"_$O(HOURS("A"),-1)
 S DIR("A")="Select Hour(s)"
 S:KMPDEF DIR("B")=$O(HOURS(""))_"-"_$O(HOURS("A"),-1)
 W ! D ^DIR
 Q $S(Y=""!(Y="^"):"",1:$G(Y(0)))
 ;
TIMING(KMPDSS,KMPDNODE,KMPDST,KMPDHTM,KMPDUZ,KMPDCL) ;-- start/stop timing stats
 ;--------------------------------------------------------------------
 ; KMPDSS... subscript (free text)
 ; KMPDNODE. node name (free text)
 ; KMPDST... start/stop
 ;            1 - start
 ;            2 - stop
 ; KMPDHTM.. (optional - if not defined the current $h will be used)
 ;           time in $h format
 ; KMPDUZ... (optional -if not defined the current duz will be used)
 ;           user duz
 ; KMPDCL... (optional - if not defined the current IO("CLNM")) will be used)
 ;           client name (free text)
 ; 
 ;--------------------------------------------------------------------
 ; quit if timing stats not turned on
 Q:'$G(^KMPTMP("KMPD-CPRS"))
 ; quit if no subscript
 Q:$G(KMPDSS)=""
 ; quit if no node
 Q:$G(KMPDNODE)=""
 ; start/stop
 S KMPDST=+$G(KMPDST)
 Q:KMPDST<1!(KMPDST>2)
 S:'$G(KMPDHTM) KMPDHTM=$H
 S:'$G(KMPDUZ) KMPDUZ=$G(DUZ)
 S:$G(KMPDCL)="" KMPDCL=$G(IO("CLNM"))
 ;
 ; start timing
 S:KMPDST=1 ^KMPTMP("KMPDT",KMPDSS,KMPDNODE)=KMPDHTM_"^^"_KMPDUZ_"^"_KMPDCL
 ; stop timing
 S:KMPDST=2 $P(^KMPTMP("KMPDT",KMPDSS,KMPDNODE),"^",2)=KMPDHTM
 ;
 Q

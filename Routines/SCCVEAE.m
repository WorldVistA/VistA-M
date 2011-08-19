SCCVEAE ;ALB/RMO,TMP - Add/Edit Conversion; [ 03/31/95  3:11 PM ]
 ;;5.3;Scheduling;**211**;Aug 13, 1993
 ;
EN(SCCVEVT,SCSTDT,SCENDT,SCLOG,SCREQ,SCSTOPF) ;Entry point to loop through all add/edits for a specified date range
 ; Input  -- SCCVEVT  Conversion event
 ;           SCSTST   Start date
 ;           SCENDT   End date
 ;           SCLOG    Scheduling conversion log IEN
 ;           SCREQ    Scheduling conversion request IEN
 ; Output -- SCSTOPF  Conversion stop flag
 N SCDTM
 F SCDTM=SCSTDT:0 S SCDTM=$O(^SDV(SCDTM)) Q:'SCDTM!($P(SCDTM,".")>SCENDT)!($G(SCSTOPF))  D STOPS(SCCVEVT,SCDTM,SCLOG,SCREQ,.SCSTOPF)
ENQ Q
 ;
STOPS(SCCVEVT,SCDTM,SCLOG,SCREQ,SCSTOPF) ;Loop through stop codes for a specific date/time
 ; Input  -- SCCVEVT  Conversion event
 ;           SCDTM    Visit date/time
 ;           SCLOG    Scheduling conversion log IEN
 ;           SCREQ    Scheduling conversion request IEN
 ; Output -- SCSTOPF  Conversion stop flag
 N SCDA,SCQUIT,SC0,SCE,SCE0,X
 IF SCCVEVT D ZERO(SCDTM)
 S SCDA=0
 F  S SCDA=$O(^SDV(SCDTM,"CS",SCDA)) Q:'SCDA!($G(SCSTOPF))  I $D(^SDV(SCDTM,"CS",SCDA,0)) S SC0=^(0),SCQUIT=0 D
 .I $P(SC0,U,8) D  Q:SCQUIT  ; Is 'parent encounter' invalid?
 .. S SCE=+$P($G(^SCE(+$P(SC0,U,8),0)),U,6)
 .. Q:'SCE  ;Encounter IS a parent, so it's OK to process
 .. ;Check parents of children for validity
 .. S SCE0=$G(^SCE(SCE,0))
 .. ;
 .. ;'Estimate' processes Add/Edit data separate from 'parent' to avoid counting them twice, so the following checks are necessary to be sure the parent was a valid appt
 .. I $P(SCE0,U,8)=1 S X=$G(^DPT(+$P(SCE0,U,2),"S",+SCE0,0)) IF $P(X,U,2)'="",$P(X,U,2)'="I" S SCQUIT=1 Q  ;Don't convert or add to estimate counts if children of an invalid appt
 .. I $P(SCE0,U,8)=3 S X=$G(^DPT(+$P(SCE0,U,2),"DIS",9999999-SCE0,0)) IF $P(X,U,2)=2 S SCQUIT=1 Q  ;Don't convert or add to estimate counts if children of an invalid disposition
 .. IF $P(SCE0,U,5),'$P($G(^SCE(SCE,"CNV")),U,4) S SCQUIT=1 Q  ; -- visit already exists / not historial visit 
 .. I SCCVEVT,'$P(SCE0,U,5) S SCQUIT=1 ;Parent has no visit, don't convert children
 .. ;
 . D EN^SCCVEAE1(SCCVEVT,SCDTM,SCDA,0,SCLOG)
 . I $G(SCLOG) D STOP^SCCVLOG(SCLOG,SCREQ,.SCSTOPF)
 . I '$G(SCLOG) S SCTOT("OK")=1
STOPQ Q
 ;
ZERO(SCDTM) ; -- fix zeroth if missing
 IF '$D(^SDV(SCDTM,"CS",0)),$O(^SDV(SCDTM,"CS",0)) S ^SDV(SCDTM,"CS",0)="^409.51P^^"
 Q
 ;

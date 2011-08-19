ONCOU55A ;Hines OIFO/GWB,RTK-UTILITY ROUTINE 2 ;12/15/99
 ;;2.11;ONCOLOGY;**6,25,28**;Mar 07, 1995
 Q  ;no direct invocations
 ;
RSTG(ONCDDX) ;restage all primaries diagnosed from year YEAR1 forward - called by STAGEM
 ;ONCDDX:optional parameter - date from which to begin
 ;default = beginning of time
 W !!,"This option is no longer available." Q
 N DXDATE,WRTFLG,SYBIX,SYBIX1,COUNT,COUNTCHG
 D INIT ;initialize our variables
 D PROCESS ;process the primaries
 Q
 ;
INIT ;initialize our variables - called by RSTG
 S (COUNT,COUNTCHG)=0
 S WRTFLG=0 ;    suppress interaction with the stager
 S SYBIX=$G(^ONCO("RESTAGE",0))+1,^(0)=SYBIX,^(SYBIX,0)=$H,SYBIX1=0 ;    indices for use in saving old stage
 I '$D(ONCDDX) S ONCDDX=0 ;    date dx index - will be used in PROC
 I ONCDDX S ONCDDX=ONCDDX-1E10 ;    to catch the first one if we're not starting at the top
 Q
 ;
PROCESS ;Process the primaries - called by RSTG
 F  S ONCDDX=$O(^ONCO(165.5,"ADX",ONCDDX)) Q:ONCDDX=""  D
 .N PRIMIX S PRIMIX=0
 .F  S PRIMIX=$O(^ONCO(165.5,"ADX",ONCDDX,PRIMIX)) Q:PRIMIX=""  I $$DIV^ONCFUNC(PRIMIX)=DUZ(2) D PROC1(PRIMIX)
 ;
 W !,"Number of primaries processed :  ",$J(COUNT,6)
 W !,"Number of primaries restaged  :  ",$J(COUNTCHG,6),!!
 S $P(^ONCO("RESTAGE",SYBIX,0),U,2)=COUNT
 Q
 ;
PROC1(D0) ;process a single primary D0 - called by PROCESS
 ;save off the old value, calculate and store the new value
 ;(not user override of stage) AND (tumor not a Lymphoma)
 I '$$NOSTAGE^ONCOU55(D0),'$$LYMPHOMA^ONCFUNC(D0),'$$MYCOSIS^ONCOU55(D0) D
 .N OLDSTAGE S OLDSTAGE=$P($G(^ONCO(165.5,D0,2)),U,20) ;    get old stage
 .S SYBIX1=$G(SYBIX1)+1,^ONCO("RESTAGE",SYBIX,SYBIX1,0)=D0_U_OLDSTAGE ;    save old stage
 .S DA=D0 D ES^ONCOTN ;    do the staging - returns variable SG
 .S COUNT=$G(COUNT)+1 ;    number processed
 .I $P($G(^ONCO(165.5,+D0,2)),U,20)'=OLDSTAGE S COUNTCHG=$G(COUNTCHG)+1 ;    number changed
 .W:$R(50)=0 "."
 Q
 ;
STAGEM ;Interact with user to restage primaries
 ;Called by routine ONCOPOS
 ;Called by option ONCO #SITE-RESTAGE PRIMARY
 N FIRST S FIRST=$$RSTGASK()
 I FIRST<0 W !!,*7,"Restaging aborted - no data changed - continuing...",!!
 E  D RSTG(FIRST) ;    start with date returned in Y
 Q
 ;
RSTGASK() ;Function to determine initial restaging date/time
 N DIR,DTOUT,DUOUT,Y
 S DIR(0)="DO^2880101:"_DT_":EP",DIR("A")="Beginning date for restaging",DIR("B")="1/1/88",DIR("?")="Enter the date from which to restage all primaries (just the year is fine)"
 D ^DIR ;    returns result in Y
 I $D(DTOUT)!$D(DUOUT) S Y=-1 ;    they bailed out or fell asleep
 QUIT +Y

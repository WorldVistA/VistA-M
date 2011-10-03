BPSOSU3 ;BHAM ISC/FCS/DRS/FLS - copied for ECME ;03/07/08  10:37
 ;;1.0;E CLAIMS MGMT ENGINE;**1,7**;JUN 2004;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;----------------------------------------------------------------------
 ;Standard SET and YESNO Functions
 ;----------------------------------------------------------------------
 ;Standard SET PROMPT:
 ;
 ;Parameters:
 ;    PROMPT  = Text to be displayed before read
 ;    DFLT    = DEFAULT choice (external format)
 ;    OPT     = 1 - Answer optional       0 - Answer required
 ;    DISPLAY = V - Vertical display      H - Horizontal display
 ;              N - No display
 ;    CHOICES = <code>:<choice>;<code>:<choice>.....
 ;    TIMEOUT = Number of seconds
 ;
 ;Returns:
 ;    <null>     = No response             <^> - Up-arrow entered
 ;    <-1>       = Timeout occurred       <^^> - Two up-arrows entered
 ;    <Choice>   = Response choice (internal format)
 ;---------------------------------------------------------------------
SET(PROMPT,DFLT,OPT,DISPLAY,CHOICES,TIMEOUT) ;EP
 ;
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 ;
 Q:$G(PROMPT)="" ""
 Q:$G(DISPLAY)="" ""
 Q:$G(CHOICES)="" ""
 ;
 S $P(DIR(0),"^",1)="S"_$S(DISPLAY="H":"B",DISPLAY="N":"A",1:"")_$S(OPT=1:"O",1:"")
 S $P(DIR(0),"^",2)=CHOICES
 S DIR("A")=PROMPT
 S:$G(DFLT)'="" DIR("B")=DFLT
 S:+$G(TIMEOUT)>0 DIR("T")=TIMEOUT
 D ^DIR
 Q $S($G(DTOUT)=1:-1,$G(DIROUT)=1:"^^",$G(DUOUT)=1:"^",1:Y)
 ;---------------------------------------------------------------------
 ;Standard Yes/No PROMPT:
 ;
 ;Parameters:
 ;    PROMPT  = Text to be displayed before read
 ;    DFLT    = YES, NO or <Null>
 ;    OPT     = 1 - Answer optional       0 - Answer required
 ;    TIMEOUT = Number of seconds
 ;
 ;Returns:
 ;    <null>     = No response             <^> - Up-arrow entered
 ;    <-1>       = Timeout occurred       <^^> - Two up-arrows entered
 ;    <0>        = No                      <1> - Yes
 ;---------------------------------------------------------------------
YESNO(PROMPT,DFLT,OPT,TIMEOUT) ;EP
 ;
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 ;
 Q:$G(PROMPT)="" ""
 ;
 S $P(DIR(0),"^",1)="Y"_$S(OPT=1:"O",1:"")
 S DIR("A")=PROMPT
 S:$G(DFLT)'="" DIR("B")=DFLT
 S:+$G(TIMEOUT)>0 DIR("T")=TIMEOUT
 D ^DIR
 Q $S($G(DTOUT)=1:-1,$G(DIROUT)=1:"^^",$G(DUOUT)=1:"^",1:Y)

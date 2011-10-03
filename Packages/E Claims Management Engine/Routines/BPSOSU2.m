BPSOSU2 ;BHAM ISC/FCS/DRS/FLS - copied for ECME ;03/07/08  10:36
 ;;1.0;E CLAIMS MGMT ENGINE;**1,7**;JUN 2004;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;----------------------------------------------------------------------
 ;Standard FREETEXT and Numeric Functions
 ;----------------------------------------------------------------------
 ;Standard FREETEXT PROMPT:
 ;
 ;Parameters:
 ;    PROMPT  = Text to be displayed before read
 ;    DFLT    = DEFAULT text
 ;    OPT     = 1 - Answer optional       0 - Answer required
 ;    MINLEN  = Minimum length of response text
 ;    MAXLEN  = Maximum length of response text
 ;    TIMEOUT = Number of seconds
 ;
 ;Returns:
 ;    <null>  = No response             <^> - Up-arrow entered
 ;    <-1>    = Timeout occurred       <^^> - Two up-arrows entered
 ;    <text>  = Response text
 ;---------------------------------------------------------------------
FREETEXT(PROMPT,DFLT,OPT,MINLEN,MAXLEN,TIMEOUT) ;EP
 ;
 N XDATA,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 ;
 Q:$G(PROMPT)="" ""
 S:$G(MINLEN)="" MINLEN=0
 S:$G(MAXLEN)="" MAXLEN=245
 ;
 S $P(DIR(0),"^",1)="FA"_$S(OPT=1:"O",1:"")
 S $P(XDATA,":",1)=MINLEN
 S $P(XDATA,":",2)=MAXLEN
 S $P(DIR(0),"^",2)=XDATA
 S DIR("A")=PROMPT
 S:$G(DFLT)'="" DIR("B")=DFLT
 S:+$G(TIMEOUT)>0 DIR("T")=TIMEOUT
 D ^DIR
 Q $S($G(DTOUT)=1:-1,$G(DIROUT)=1:"^^",$G(DUOUT)=1:"^",1:Y)
 ;---------------------------------------------------------------------
 ;Standard Numeric PROMPT:
 ;
 ;Parameters:
 ;    PROMPT  = Text to be displayed before read
 ;    DFLT    = DEFAULT Numeric
 ;    OPT     = 1 - Answer optional       0 - Answer required
 ;    MINNUM  = Minimum numeric value
 ;    MAXNUM  = Maximum numeric value
 ;    MAXDEC  = Maximum number of decimal places allowed
 ;    TIMEOUT = Number of seconds
 ;
 ;Returns:
 ;    <null>     = No response             <^> - Up-arrow entered
 ;    <-1>       = Timeout occurred       <^^> - Two up-arrows entered
 ;    <Numeric>  = Response Numeric
 ;---------------------------------------------------------------------
NUMERIC(PROMPT,DFLT,OPT,MINNUM,MAXNUM,MAXDEC,TIMEOUT) ;EP
 ;
 N XDATA,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 ;
 Q:$G(PROMPT)="" ""
 ;
 S $P(DIR(0),"^",1)="NA"_$S(OPT=1:"O",1:"")
 S $P(XDATA,":",1)=$G(MINNUM)
 S $P(XDATA,":",2)=$G(MAXNUM)
 S $P(XDATA,":",3)=$G(MAXDEC)
 S $P(DIR(0),"^",2)=XDATA
 S DIR("A")=PROMPT
 S:$G(DFLT)'="" DIR("B")=DFLT
 S:+$G(TIMEOUT)>0 DIR("T")=TIMEOUT
 D ^DIR
 Q $S($G(DTOUT)=1:-1,$G(DIROUT)=1:"^^",$G(DUOUT)=1:"^",1:Y)

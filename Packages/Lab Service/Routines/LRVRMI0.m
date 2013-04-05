LRVRMI0 ;DALOI/FHS - MI SUB Lab Routine Data Verification ;02/28/12  19:32
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 ; HL7 MI Auto-instrument verification
 Q
 ;
LEDIERR(LRLL,ISQN,QUIET,KILLAH) ;
 ; Check if this LAH entry has any errors that should prevent
 ; the user from processing the results.
 ; Inputs
 ;  LRLL : LL of ^LAH
 ;  ISQN : ISQN of ^LAH
 ;  QUIET <opt> : dflt=0 0=display info  1=dont display info
 ; KILLAH <opt> : dflt=0 1=delete LAH entry  0=dont delete LAH entry
 ;
 N X,Y,DIR,ERR,LSTERR,CNT
 S LRLL=$G(LRLL),ISQN=$G(ISQN),QUIET=+$G(QUIET),KILLAH=+$G(KILLAH)
 S X=$$LAHSTAT^LA7VHLU1(LRLL,ISQN,.5)
 I X'=2 Q 0
 ;
 S X=$$LAHSTAT^LA7VHLU1(LRLL,ISQN,1,.ERR)
 S (X,LSTERR)=$O(ERR(""),-1)
 ;
 S CNT=1
 F  S X=$O(ERR(X),-1) Q:$P(X,".",1)'=$P(LSTERR,".",1)  S CNT=CNT+1
 ;
 I $D(ERR),'QUIET D
 . D  ;
 . . N %ZIS,X
 . . S X="IORVON;IORVOFF"
 . . D ENDR^%ZISS
 . W $C(7),!!
 . I $G(IORVON)'="",$G(IORVOFF)'="" W IORVON
 . W "HL7 message processing error for this accession -- Processing aborted."
 . I $G(IORVOFF)'="" W IORVOFF
 . W !!,"Total errors: ",CNT,"   Last error: ",$$FMTE^XLFDT(LSTERR)
 . W !,ERR(LSTERR),!
 . I KILLAH W !,"     Entry deleted from ^LAH global."
 . S DIR(0)="E"
 . D ^DIR,KILL^%ZISS
 ;
 S LRNOP=1,LREND=1
 I KILLAH D ZAP^LRVR0
 Q 1

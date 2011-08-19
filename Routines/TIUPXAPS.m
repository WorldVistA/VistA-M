TIUPXAPS ; SLC/JER - Ask Service Connection Question(s) ;6/11/98@14:30:28
 ;;1.0;TEXT INTEGRATION UTILITIES;**20,107,126**;Jun 20, 1997
SCASK(TIUY,DFN,TIU) ; Ask Service Connection stuff
 N TIUPRMT,TIUSC,TIUDFLT,TIUHLP
 D SCCOND^PXUTLSCC(DFN,+$G(TIU("EDT")),+$G(TIU("LOC")),+$G(TIU("VISIT")),.TIUSC)
 ; Don't ask if none of the above
 I '+$G(TIUSC("SC")),'+$G(TIUSC("AO")),'+$G(TIUSC("IR")),'+$G(TIUSC("EC")),'+$G(TIUSC("MST")),'+$G(TIUSC("HNC")) Q
 W !!,"Was this encounter related to any of the following:",!
 I +$G(TIUSC("SC")) D
 . F  D  Q:TIUY("SC")]""!$D(DTOUT)
 . . N DUOUT,DIROUT,DIRUT
 . . S TIUDFLT=$P(TIUSC("SC"),U,2)
 . . S TIUDFLT=$S(TIUDFLT=1:"YES",TIUDFLT=0:"NO",1:"")
 . . S TIUPRMT="Service Connected Condition"
 . . S TIUY("SC")=$$READ^TIUU("YO",TIUPRMT,TIUDFLT,"^D SC^SDCO23(DFN)")
 . . I $S(TIUY("SC")="":1,TIUY("SC")="^":1,1:0) S TIUY("SC")="" W !,$C(7),"(Y)ES or (N)o Required." W:$D(DUOUT) " An '^' is not allowed."
 I +$G(TIUY("SC"))>0 S (TIUY("AO"),TIUY("IR"),TIUY("EC"))=""
 I +$G(TIUSC("AO")),+$G(TIUY("SC"))'>0 D
 . F  D  Q:TIUY("AO")]""!$D(DTOUT)
 . . N DUOUT,DIROUT,DIRUT
 . . S TIUDFLT=$P(TIUSC("AO"),U,2)
 . . S TIUDFLT=$S(TIUDFLT=1:"YES",TIUDFLT=0:"NO",1:"")
 . . S TIUPRMT="      Agent Orange Exposure"
 . . S TIUY("AO")=$$READ^TIUU("YO",TIUPRMT,TIUDFLT)
 . . I +$P($G(TIUDPRM(0)),U,15)=0,(TIUY("AO")="") S TIUY("AO")="^NOT ANSWERED" Q
 . . I $S(TIUY("AO")="":1,TIUY("AO")="^":1,1:0) S TIUY("AO")="" W !,$C(7),?7,"(Y)ES or (N)o Required." W:$D(DUOUT) " An '^' is not allowed."
 I +$G(TIUSC("IR")),+$G(TIUY("SC"))'>0 D
 . F  D  Q:TIUY("IR")]""!$D(DTOUT)
 . . N DUOUT,DIROUT,DIRUT
 . . S TIUDFLT=$P(TIUSC("IR"),U,2)
 . . S TIUDFLT=$S(TIUDFLT=1:"YES",TIUDFLT=0:"NO",1:"")
 . . S TIUPRMT="Ionizing Radiation Exposure"
 . . S TIUY("IR")=$$READ^TIUU("YO",TIUPRMT,TIUDFLT)
 . . I +$P($G(TIUDPRM(0)),U,15)=0,(TIUY("IR")="") S TIUY("IR")="^NOT ANSWERED" Q
 . . I $S(TIUY("IR")="":1,TIUY("IR")="^":1,1:0) S TIUY("IR")="" W !,$C(7),"(Y)ES or (N)o Required." W:$D(DUOUT) " An '^' is not allowed."
 I +$G(TIUSC("EC")),+$G(TIUY("SC"))'>0 D
 . F  D  Q:TIUY("EC")]""!$D(DTOUT)
 . . N DUOUT,DIROUT,DIRUT
 . . S TIUDFLT=$P(TIUSC("EC"),U,2)
 . . S TIUDFLT=$S(TIUDFLT=1:"YES",TIUDFLT=0:"NO",1:"")
 . . S TIUPRMT=" Environmental Contaminants"
 . . S TIUY("EC")=$$READ^TIUU("YO",TIUPRMT,TIUDFLT)
 . . I +$P($G(TIUDPRM(0)),U,15)=0,(TIUY("EC")="") S TIUY("EC")="^NOT ANSWERED" Q
 . . I $S(TIUY("EC")="":1,TIUY("EC")="^":1,1:0) S TIUY("EC")="" W !,$C(7),?2,"(Y)ES or (N)o Required." W:$D(DUOUT) " An '^' is not allowed."
 I +$G(TIUSC("MST")) D
 . F  D  Q:TIUY("MST")]""!$D(DTOUT)
 . . N DUOUT,DIROUT,DIRUT
 . . S TIUDFLT=$P(TIUSC("MST"),U,2)
 . . S TIUDFLT=$S(TIUDFLT=1:"YES",TIUDFLT=0:"NO",1:"")
 . . S TIUPRMT="                        MST"
 . . S TIUHLP="Enter 'Y' or 'N' if treatment was related to Military Sexual Trauma."
 . . S TIUY("MST")=$$READ^TIUU("YO",TIUPRMT,TIUDFLT,TIUHLP)
 . . I $S(TIUY("MST")="":1,TIUY("MST")="^":1,1:0) S TIUY("MST")="" W !,$C(7),?6,"(Y)ES or (N)o Required." W:$D(DUOUT) " An '^' is not allowed."
 I +$G(TIUSC("HNC")) D
 . F  D  Q:TIUY("HNC")]""!$D(DTOUT)
 . . N DUOUT,DIROUT,DIRUT
 . . S TIUDFLT=$P(TIUSC("HNC"),U,2)
 . . S TIUDFLT=$S(TIUDFLT=1:"YES",TIUDFLT=0:"NO",1:"")
 . . S TIUPRMT="    Head and/or Neck Cancer"
 . . S TIUHLP="Enter 'Y' or 'N' if treatment was related to Head and/or Neck Cancer."
 . . S TIUY("HNC")=$$READ^TIUU("YO",TIUPRMT,TIUDFLT,TIUHLP)
 . . I $S(TIUY("HNC")="":1,TIUY("HNC")="^":1,1:0) S TIUY("HNC")="" W !,$C(7),?6,"(Y)ES or (N)o Required." W:$D(DUOUT) " An '^' is not allowed."
 Q

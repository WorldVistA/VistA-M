SCRPV1B1 ; bp/djb - PCMM Inconsistency Rpt - Print ; 8/25/99 10:04am
 ;;5.3;Scheduling;**177**;AUG 13, 1993
 ;
LIST ;List inconsistency descriptions
 NEW I,NUM,OPT,PAGE,QUIT,TXT,X,Y
 S QUIT=0
 S OPT="Team Assignment/Team/Position"
 D HD^SCRPV1B
 F I=1:1:8 D  Q:QUIT
 . S TXT=$T(TXT+I^SCRPV1B)
 . S NUM=$P(TXT,";",3)
 . S TXT=$P(TXT,";",4)
 . ;If error 8, substitute in text.
 . I TXT["[]" S TXT=$P(TXT,"[]",1)_OPT_$P(TXT,"[]",2)
 . I $Y>(IOSL-8) D PAUSE^SCRPV1B Q:QUIT
 . W !!
 . ;W NUM_". " ;Display inconsistency number
 . S X=TXT X ^%ZOSF("UPPERCASE") S TXT=Y ;Convert to all caps
 . W "<> ",TXT
 . D @("LIST"_NUM) ;Display additional descriptive text.
 W !
 Q
LIST1 ;
 W !?6,"Position exists with patients assigned to the Position, but no staff"
 W !?6,"member is assigned to that Position."
 W !?9,"FIX..: Use PCMM GUI"
 W !?9,"STEPS: Go to Team, go to Position, open Team, clinic on Staff button"
 W !?9,"       and assign staff to position."
 Q
LIST2 ;
 W !?6,"Patient is assigned to a Primary Care Team but has no Primary Care"
 W !?6,"Practitioner assigned."
 W !?9,"FIX..: Use VistA options"
 W !?9,"STEPS: Go to Appointment Management or PCE, enter patient name, type"
 W !?9,"       in PC for PC Assign or Unassign, select one of the following:"
 W !?9,"           1. POSITION ASSIGNMENT - BY PRACTITIIONER NAME"
 W !?9,"           2. POSITION ASSIGNMENT - BY POSITION NAME"
 W !?9,"           3. TEAM UNASSIGNMENT"
 W !?9,"       Use either #1 or #2 to assign patient."
 Q
LIST3 ;
 W !?6,"Patient has multiple active Primary Care Practitioners assigned."
 W !?9,"FIX..: Use PCMM GUI"
 W !?9,"STEPS: Go to Patient Assignment, enter patient name, double click on"
 W !?9,"       team name, open Positions Assignment tab, determine which PCP"
 W !?9,"       assigned need to be deleted, highlight that selection, go to"
 W !?9,"       EDIT, Position Assignment, then delete. No VistA fix."
 Q
LIST4 ;
 W !?6,"Associate Provider and Primary Care Provider is the same staff member."
 W !?9,"FIX..: Use PCMM GUI"
 W !?9,"STEPS: First determine which position the staff member should be in."
 W !?9,"       Under the Patient drop down menu, have 'Show All Team"
 W !?9,"       Assignments' checked. Do not check under Team drop down menu,"
 W !?9,"       'Active Only'. Under Team, click on speed positions setup"
 W !?9,"       button and select team. Primary Care Position Setup screen is"
 W !?9,"       displayed, click on one of the positions, either AP or PCP."
 W !?9,"       Click the staff button, click the Inactive button and assign"
 W !?9,"       an effective date, status, and reason. Close."
 Q
LIST5 ;
 W !?6,"Associate Provider has not been assigned a Preceptor."
 W !?9,"FIX..: Use PCMM GUI"
 W !?9,"STEPS: Go to Team, Positions, double click team that AP is on,"
 W !?9,"       double click AP's name, click Preceptor button and assign"
 W !?9,"       preceptor to AP."
 Q
LIST6 ;
 W !?6,"Associate Provider is not listed as 'Can Provide Primary Care'."
 W !?9,"FIX..: Use PCMM GUI"
 W !?9,"STEPS: Go to Team, Positions, double click AP's name, go to Settings"
 W !?9,"       tab and click on 'Can Provide Primary Care'."
 Q
LIST7 ;
 W !?6,"Primary Care Provider position is not listed as 'Can Provide Primary"
 W !?6,"Care'."
 W !?9,"FIX..: Use PCMM GUI"
 W !?9,"STEPS: Go to Team, Positions, double click PCP's name, go to Settings"
 W !?9,"       tab and click on 'Can Provide Primary Care'."
 Q
LIST8 ;
 W !?6,"An active Position assignment is associated with an inactive Team"
 W !?6,"assignment, Team, or Position."
 W !?9,"FIX..: Use PCMM GUI"
 W !?9,"INACTIVE POSITION"
 W !?9,"STEPS: Determine if POSITION should be inactive."
 W !?9,"       If answer is NO:"
 W !?9,"       The position should not be inactive. Reactivate the position."
 W !?9,"       If answer is YES:"
 W !?9,"       The position should be inactive. Reactive the position so"
 W !?9,"       that the patients assigned to this position can be"
 W !?9,"       inactivated/reassigned. Then inactivate position."
 W !?9,"INACTIVE TEAM"
 W !?9,"STEPS: Determine if TEAM should be inactive."
 W !?9,"       If answer is NO:"
 W !?9,"       Team should not be inactive. Reactivate the team."
 W !?9,"       If answer is YES:"
 W !?9,"       Team should be inactive. Reactivate the team so that"
 W !?9,"       active patient position assignments can be inactivated or"
 W !?9,"       reassigned. Then inactivate team."
 Q
 ;
BRIEFPOS ;Print POSITION error counts only.
 NEW ERROR,NUM,NUM1,POS,TM,TXT
 ;
 S NUM=0
 F  S NUM=$O(^TMP("PCMM POSITION",$J,NUM)) Q:'NUM  D  ;
 . S TM=""
 . F  S TM=$O(^TMP("PCMM POSITION",$J,NUM,TM)) Q:TM=""  D  ;
 .. S POS=""
 .. F  S POS=$O(^TMP("PCMM POSITION",$J,NUM,TM,POS)) Q:POS=""  D  ;
 ... S ERROR(NUM\1)=($G(ERROR(NUM\1))+1)
 ;
 W !,"Total teams/positions per inconsistency type:"
 S NUM=0
 F  S NUM=$O(ERROR(NUM)) Q:'NUM!QUIT  D  ;
 . S NUM1=(NUM\1)
 . S TXT=$T(TXT+NUM1^SCRPV1B)
 . I $Y>(IOSL-6) D PAUSE^SCRPV1B Q:QUIT
 . ;W !?3,$P(TXT,";",3)_". "
 . S TXT=$P(TXT,";",4)
 . I TXT["[]" D  ;
 .. S TXT=$P(TXT,"[]",1)_"Team Assign/Team/Position"_$P(TXT,"[]",2)
 . W !?3,TXT_" - "_ERROR(NUM1)
 Q
 ;
BRIEFPT ;Print PATIENT error counts only.
 NEW DFN,DFNNAM,ERROR,NUM
 ;
 S DFNNAM=""
 F  S DFNNAM=$O(^TMP("PCMM PATIENT",$J,DFNNAM)) Q:DFNNAM=""  D  ;
 . S DFN=0
 . F  S DFN=$O(^TMP("PCMM PATIENT",$J,DFNNAM,DFN)) Q:'DFN  D  ;
 .. S NUM=0
 .. F  S NUM=$O(^TMP("PCMM PATIENT",$J,DFNNAM,DFN,NUM)) Q:'NUM  D  ;
 ... S ERROR("PT",NUM\1)=($G(ERROR("PT",NUM\1))+1)
 ;
 W !,"Total patients per inconsistency type:"
 S NUM=0
 F  S NUM=$O(ERROR("PT",NUM)) Q:'NUM!QUIT  D  ;
 . S NUM=NUM\1
 . S TXT=$T(TXT+NUM^SCRPV1B)
 . I $Y>(IOSL-6) D PAUSE^SCRPV1B Q:QUIT
 . ;W !?3,$P(TXT,";",3)_". "
 . S TXT=$P(TXT,";",4)
 . I TXT["[]" D  ;
 .. S TXT=$P(TXT,"[]",1)_"Team Assign/Team/Position"_$P(TXT,"[]",2)
 . W !?3,TXT_" - "_ERROR("PT",NUM)
 Q

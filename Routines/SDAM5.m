SDAM5 ;MJK/ALB - Appt Mgt (HELP) ; 12/1/91
 ;;5.3;Scheduling;;Aug 13, 1993
 ;
HLP ; -- help for list
 I $D(X),X'["??" D HLPS,PAUSE^VALM1 G HLPQ
 D CLEAR^VALM1
 F I=1:1 S SDX=$P($T(HELPTXT+I),";",3,99) Q:SDX="$END"  D PAUSE^VALM1:SDX="$PAUSE" Q:'Y  W !,$S(SDX["$PAUSE":"",1:SDX)
 W !,"Possible actions are the following:"
 D HLPS,PAUSE^VALM1 S VALMBCK="R"
HLPQ K SDX,Y Q
 ;
HLPS ; -- short help
 S X="?" D DISP^XQORM1 W ! Q
 ;
HELPTXT ; -- help text
 ;;Enter actions(s) by typing the name(s), or abbreviation(s).
 ;;
 ;;ACTION PRE-SELECTION:
 ;;  Actions may be pre-selected by separating them with ";".
 ;;
 ;;  For example, "AL;CI" will advance through the 2 menus,
 ;;  automatically selecting the actions.  In this example, the user
 ;;  would be selecting the 'Appointment List Menu' and then the
 ;;  'Checked In' list.
 ;;
 ;;LIST ENTRY PRE-SELECTION:
 ;;  Entries from appointment list can be pre-selected in the following
 ;;  manner:
 ;;           CI=1        ...will process entry #1 for check in
 ;;           CI=3 4 5    ...will process entries 3,4,5 for check in
 ;;           CI=1-3      ...will process entries 1,2,3 for check in
 ;; 
 ;;  If no entry is pre-selected, the user will be prompted for a
 ;;  selection.
 ;;------------------------------------------------------------------------------
 ;;$PAUSE
 ;;$END
 ;;MULTIPLE ACTION SELECTION:
 ;;  More than one action can be selected in the following manner:
 ;;
 ;;   Select Action: CL,CD     ...user will select a clinic and then
 ;;                               be asked to enter a new date range
 ;; 
 ;;                  CL,AL;NA  ...user will select a clinic and then
 ;;                               all 'NO ACTION TAKEN' appointments
 ;;                               will be listed.
 ;;------------------------------------------------------------------------------
 ;;$END
 ;

SDPPHLP ;ALB/CAW - Patient Profile - Help ; 7/16/92
 ;;5.3;Scheduling;**6**;Aug 13, 1993
 ;
HLP ; -- help for list
 I $D(X),X'["??" D HLPS G HLPQ
 D CLEAR^VALM1
 F I=1:1 S SDX=$P($T(@VAR+I),";",3,99) Q:SDX="$END"  D PAUSE^VALM1:SDX="$PAUSE" Q:'Y  W !,$S(SDX["$PAUSE":"",1:SDX)
HLPQ K SDX,Y S X="" Q
 ;
HLPS ; -- short help
 S X="?" W !,"Enter action by typing the name or the abbreviation.",! Q
 ;
HELPTXT ; -- help text
 ;;Enter action by typing the name or abbreviation.
 ;;
 ;;DI - Display Info
 ;;  Allows selection of Appointments, Add/Edits, Enrollments, Means Test,
 ;;  and Dispositions.  Selection of ALL information is also available.
 ;;
 ;;PP - Print Profile
 ;;  Allows the patient profile to be printed, with patient demographics
 ;;  as well as user selected appts, add/edits, dispositions, etc.
 ;;
 ;;CP - Change Patient
 ;;  Allows the patient to be changed within the Patient Profile without
 ;;  exiting the option.
 ;;
 ;;CD - Change Date Range
 ;;  Allows the selection of the date range to be changed.  This changes
 ;;  the date range the appointments, add/edits, etc. will be displayed
 ;;  for.
 ;;
 ;;$PAUSE
 ;;$END
 Q
HLPTXT1 ;help text for DI - Display Info Menu
 ;;AE - Add/Edits
 ;;  This will display information on add/edit appointments.  You
 ;;  may select a specific stop code to view.
 ;;
 ;;AP - Appointments
 ;;  This will display information on appointments.  You may select a
 ;;  specific clinic to view.
 ;;
 ;;DE - Enrollments
 ;;  This will display information on enrollments.  You may select
 ;;  specific clinic to view.  You may select active enrollments only
 ;;  to either all or a specified clinic.
 ;;
 ;;DD - Dispositions
 ;;  This will display information on dispositions.
 ;;
 ;;MT - Means Test
 ;;  This will display information on means test.  You may select
 ;;  a specific means test.
 ;;
 ;;$PAUSE
 ;;AL - All
 ;;  This will display information on add/edits, appointments,
 ;;  enrollments, dispositions and means test.
 ;;
 ;;$PAUSE
 ;;$END
 ;

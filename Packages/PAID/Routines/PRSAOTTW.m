PRSAOTTW ;WCIOFO/JAH-OVERTIME WARNINGS (OTW) LISTER--8/18/98
 ;;4.0;PAID;**43**;Sep 21, 1995
 ; = = = = = = = = = = = = = = = = = 
 ;
LISTEN ; -- main entry point for OTW LIST--called by list manager 
 ;
 S PRSOUT=0
 D LISPARAM(.PRSWPP,.PRSWPPI,.PRSWSTAT,.PRSOUT)
 Q:PRSOUT
 ;convert status to internal value in ot warnings file
 ; A = active i = inactive (b for both is not an internal status)
 S PRSWSTAT=$S(PRSWSTAT=1:"A",PRSWSTAT=2:"C",1:"B")
 ;
 ; Call to List Manager to run PRSA OVERTIME WARNINGS template
 D EN^VALM("PRSA OVERTIME WARNINGS")
 Q
 ;
 ; = = = = = = = = = = = = = = = = = 
 ;
LISPARAM(PP,PPI,STAT,USEROUT) ;
 ;Ask the user if they want the list to contain 1 or all pay peroids
 ;and whether they want to see cleared, active or all warnings.
 N DIR,DIRUT,X,Y
 S USEROUT=0
 S DIR(0)="S^1:select a pay period;2:all pay periods"
 D ^DIR S PP=Y
 I $D(DIRUT) S USEROUT=1 Q
 ;
 ; get pp if user chose a single pp
 I PP=1 D
 .  S DIC="^PRST(458,",DIC(0)="AEMNQ" D ^DIC
 .  S PPI=+Y
 ;
 ;Prompt user for type of warnings to display
 I Y'>0 S USEROUT=1 Q
 N DIR,X,Y,DIRUT
 S DIR(0)="S^1:Active Warnings;2:Cleared Warnings;3:Active & Cleared"
 D BLDHLP,^DIR
 I $D(DIRUT) S USEROUT=1 Q
 S STAT=Y
 Q
 ;
 ; = = = = = = = = = = = = = = = = = 
 ;
BLDHLP ;
 N I,TXT
 S DIR("?")="       Enter 1, 2, 3 or '^' to exit."
 F I=1:1 S TXT=$P($T(HLPTXT+I),";;",2) Q:TXT=""  S DIR("?",I)=TXT
 Q
HLPTXT ;
 ;;       Overtime Warnings occur when an employee has more
 ;;  overtime in their TT8B string than approved overtime in the
 ;;  overtime requests file.  Normally, a warning becomes ACTIVE when a
 ;;  timecard is certified that will result in unapproved overtime
 ;;  being paid.  If corrective action is taken payroll may then
 ;;  CLEAR the overtime warning.  Although CLEARED warnings may be
 ;;  viewed through this option they WILL NO LONGER appear on the Pay
 ;;  Period Exceptions report.  ACTIVE warnings will appear on the
 ;;  exceptions report.
 ;;
 Q 
 ;
 ; = = = = = = = = = = = = = = = = = 
 ;
HDR ; -- header code
 ; All pperiods.
 I PRSWPP=2 D
 . I PRSWSTAT="C" S VALMHDR(1)="Cleared for all pay periods"
 . I PRSWSTAT="A" S VALMHDR(1)="Active for all pay periods"
 . I PRSWSTAT="B" S VALMHDR(1)="Active & cleared for all pay periods."
 ;
 I PRSWPP=1 D
 . I PRSWSTAT="C" S VALMHDR(1)="Cleared for single pay period"
 . I PRSWSTAT="A" S VALMHDR(1)="Active for single pay period"
 . I PRSWSTAT="B" S VALMHDR(1)="Active & cleared for a single pay period"
 Q
 ;
 ; = = = = = = = = = = = = = = = = = 
 ;
INIT ; -- init variables and list array
 ;  This entry point is called from list manager
 ;
 N IEN,PPE,WK,OT8B,OTAP,COUNT
 S U="^"
 K ^TMP("PRSAOTW",$J)
 S LIST=0,NUMBER=0
 D CLEAN^VALM10
 S COUNT=0,NUMBER=""
 ;
 ;loop adds list items if user chose active OR inactive & all pperiods.
 I PRSWPP=2,PRSWSTAT'="B" D
 .F  S NUMBER=$O(^PRST(458.6,"E",PRSWSTAT,NUMBER)) Q:NUMBER=""  D
 ..  D LISITEM(NUMBER,.COUNT)
 ;
 ;loop adds list items if user chose active OR inactive & 1 pperiod
 ;
 I PRSWPP=1,PRSWSTAT'="B" D
 .S NUMBER=0
 .F  S NUMBER=$O(^PRST(458.6,"C",PRSWPPI,NUMBER)) Q:NUMBER=""  D
 ..  I $D(^PRST(458.6,"E",PRSWSTAT,NUMBER)) D LISITEM(NUMBER,.COUNT)
 ;
 ;loop adds list items if user chose active & inactive & 1 pperiod
 ;
 I PRSWPP=1,PRSWSTAT="B" D
 .S NUMBER=0
 .F  S NUMBER=$O(^PRST(458.6,"C",PRSWPPI,NUMBER)) Q:NUMBER=""  D
 ..  D LISITEM(NUMBER,.COUNT)
 ;
 ;loop adds list items if user chose active & inactive & all pperiods.
 ;
 I PRSWPP=2,PRSWSTAT="B" D
 .;1st loop through 4 digit year pp x-ref
 .S PRSWPPI=""
 .F  S PRSWPPI=$O(^PRST(458.6,"D",PRSWPPI)) Q:PRSWPPI']""  D
 ..  S NUMBER=0
 ..  F  S NUMBER=$O(^PRST(458.6,"D",PRSWPPI,NUMBER)) Q:NUMBER'>0  D
 ...  D LISITEM(NUMBER,.COUNT)
 ;
 S VALMCNT=COUNT
 Q
 ;
 ; = = = = = = = = = = = = = = = = = 
 ;
LISITEM(IEN,COUNT) ;ADD A SINGLE ITEM TO OT WARNINGS LIST
 N PPI,PPE,EMP,WK,OT8B,OTAP,STAT,TL,CLEARER
 S COUNT=COUNT+1
 ;
 ;get fields from a record in the ot warnings file
 ;
 S PPI=$P($G(^PRST(458.6,IEN,0)),U,3) ;                 Pay per ien
 S PPE=$P($G(^PRST(458,PPI,0)),U) ;              pay per ext format
 S EMP=$P($G(^PRST(458.6,IEN,0)),U,2) ;          employee ien in 450
 S EMP=$P($G(^PRSPC(EMP,0)),U),TL=$P(^(0),U,8) ;   name and t&l unit
 S WK=$P($G(^PRST(458.6,IEN,0)),U,4) ;        week 1 or 2 of pay per
 S OT8B=" "_$P($G(^PRST(458.6,IEN,0)),U,8) ;     all ot in 8b string
 S OTAP=" "_$P($G(^PRST(458.6,IEN,0)),U,9) ;  all ot in request file
 S STAT=$P($G(^PRST(458.6,IEN,0)),U,5) ;           status of warning
 S STAT=$S(STAT="A":"Active",1:"Cleared")
 S CLEARER=$P($G(^PRST(458.6,IEN,0)),U,6) ;          clearer 450 IEN
 I CLEARER S CLEARER=$P($G(^VA(200,CLEARER,0)),U) ; clearer 450 name
 ;
 ;Build one line (X) for list manager containing a warning.
 ; 3rd parameter is name of field on List Template
 ;
 S X=$$SETFLD^VALM1(COUNT,"","NUMBER")
 S X=$$SETFLD^VALM1(PPE,X,"PAY PERIOD")
 S X=$$SETFLD^VALM1(WK,X,"WEEK")
 S X=$$SETFLD^VALM1(EMP,X,"EMPLOYEE")
 S X=$$SETFLD^VALM1(TL,X,"TL")
 S X=$$SETFLD^VALM1(STAT,X,"STATUS")
 S X=$$SETFLD^VALM1(OT8B,X,"OT8B")
 S X=$$SETFLD^VALM1(OTAP,X,"OTAP")
 S X=$$SETFLD^VALM1(CLEARER,X,"UPDATER")
 D SET^VALM10(COUNT,X,COUNT)
 ;
 ; save the ien of the record in the list global for easier
 ; reference to the acutal data.
 ;
 S ^TMP("PRSAOTW",$J,COUNT)=IEN
 Q
 ;
 ; = = = = = = = = = = = = = = = = = 
 ;
PRSIEN() ;RETURN PAID IEN FROM 450 BASED ON DUZ.
 N SSN
 ;
 S PRSIEN=""
 Q:'DUZ PRSIEN
 ;
 S SSN=$P($G(^VA(200,DUZ,1)),"^",9)
 I SSN'="" S PRSIEN=$O(^PRSPC("SSN",SSN,0)) S:PRSIEN'>0 PRSIEN=""
 Q PRSIEN
 ;
 ; = = = = = = = = = = = = = = = = = 
 ;
CLEAR ; Clear an OT warning.  This code called when a user running the
 ; OT warnings option selects clear OT warnings protocol.
 ;
 N PRSCREC,PRSCLCNT,PRSELECT,PRSNOCL,DIE,DIR,DIRUT,PLURAL
 ;
 ;allow selection of list items in the display region.
 ;
 D EN^VALM2("","")
 Q:$O(VALMY(0))'>0
 ;
 S PRSCLCNT=0,DIE="^PRST(458.6,"
 S (PRSCREC,PRSELECT,PRSNOCL)=""
 F  S PRSCREC=$O(VALMY(PRSCREC)) Q:PRSCREC=""  D
 .  ;
 .  ;Get ien for 458.6 that matches the list item.
 .  S PRSCIEN=$G(^TMP("PRSAOTW",$J,PRSCREC))
 .  ;
 .  ;Get status of ot warning
 .  S PRSCSTAT=$P($G(^PRST(458.6,PRSCIEN,0)),U,5)
 .  ;
 .  ;increment clearable warning count
 .  ;& build variable of items that will be cleared
 .  ;& highlight selected items
 .  I PRSCSTAT="A" D
 ..    S PRSCLCNT=PRSCLCNT+1,PRSELECT=PRSELECT_","_PRSCREC
 ..    ;
 ..    D CNTRL^VALM10(PRSCREC,2,$L(PRSCREC),IORVON,IORVOFF)
 ..    D CNTRL^VALM10(PRSCREC,5,74,IOINHI,IOINORM),WRITE^VALM10(PRSCREC)
 ;
 ;strip off leading comma from clear list
 S PRSELECT=$P(PRSELECT,",",2,999)
 ;
 ;return to list if no active warnings selected.
 ;
 I PRSELECT="" S VALMSG="No ACTIVE warnings selected." S VALMBCK="R" Q
 ;
 ; If user wants to clear items then clear all selected.  Skip any 
 ; that r already clear & keep track of any that are locked (PRSNOCL).
 ; Build ListMan message w/ all unclearable records due to locks.
 ;
 S DIR(0)="YA"
 S PLURAL=$S($L(PRSELECT,",")<2:"entry",1:"entries")
 S DIR("A")="Clear "_PLURAL_" "_PRSELECT_" ?"
 D ^DIR
 I Y D
 .  S PRSCREC=0
 .  F  S PRSCREC=$O(VALMY(PRSCREC)) Q:PRSCREC=""  D
 ..    S PRSCIEN=$G(^TMP("PRSAOTW",$J,PRSCREC))
 ..    S PRSCSTAT=$P($G(^PRST(458.6,PRSCIEN,0)),U,5)
 ..    I PRSCSTAT="A" D
 ...     S PRSCSTAT="C"
 ...     S DR="4///^S X=PRSCSTAT",DA=PRSCIEN
 ...     L +^PRST(458.6,PRSCIEN):0
 ...     I $T D 
 ....      D ^DIE L -^PRST(458.6,PRSCIEN)
 ...     E  S PRSNOCL=PRSNOCL_" "_PRSCREC
 S:PRSNOCL'="" VALMSG=PRSNOCL_" NOT CLEARED.  EDIT BY ANOTHER USER"
 ;
 ;whether list items cleared or not rebuild list and return
 ;
 D INIT
 S VALMBCK="R"
 Q
HELP ;Help for the PRSA OVERTIME WARNINGS list template
 D FULL^VALM1
 W !!,?2,"At the Action prompt you may enter CL or VI.",!
 W !,?4,"Enter CL to select any of the active overtime warnings on the"
 W !,?4,"screen that you wish to clear.",!
 W !,?4,"Enter VI to select one of the displayed warnings to view requests"
 W !,?4,"on file that correlate to the week and pay period of the warning."
 D PAUSE^VALM1
 D RE^VALM4
 Q

DGJTHLP ;MJK/MAF/ESD/ALB - Help for IRT module using list processor ; 20-OCT-92
 ;;1.0;Incomplete Records Tracking;;Jun 25, 2001
 ;
 ;
HLP ; -- IRT ListMan menu help
 I X="?" D HLPS,PAUSE^VALM1 S VALMBCK="" G HLPQ
 D CLEAR^VALM1
 S DGJTHTXT=$S(DGJTHFLG="EN":"ENHLPTXT",DGJTHFLG="DL":"DLHLPTXT",DGJTHFLG="CE":"CEHLPTXT",DGJTHFLG="VW":"VWHLPTXT",DGJTHFLG="AD":"ADHLPTXT",1:"ENHLPTXT")
HLPRTN S DGJTHRTN=$S(DGJTHTXT="ENHLPTXT"!(DGJTHTXT="DLHLPTXT"):"DGJTHLP",1:"DGJTHLP1")
 F I=1:1 S DGJXX=$P($T(@DGJTHTXT+I^@DGJTHRTN),";;",2,99) Q:DGJXX="$END"  D
 .D PAUSE^VALM1:DGJXX="$PAUSE" Q:'Y
 .W !,$S(DGJXX["$PAUSE":"",1:DGJXX)
 W !,"Possible actions for this option are the following:"
 D HLPS,PAUSE^VALM1 S VALMBCK="R"
 ;
HLPQ K I,DGJXX,DGJTHTXT,DGJTHRTN,Y
 Q
HLPS ; -- short help
 S X="?" D DISP^XQORM1 W !
 Q
 ;
HLP1 ; -- Edit IRT Deficiency (from Completed IRT Edit) menu help text
 I X="?" D HLPS,PAUSE^VALM1 S VALMBCK="" G HLPQ
 D CLEAR^VALM1
 S DGJTHTXT="CIHLPTXT" G HLPRTN
 ;
ENHLPTXT ; -- Enter/Edit menu help text
 ;;Enter actions by typing the names or abbreviations.
 ;;
 ;;LIST ENTRY PRE-SELECTION:
 ;;  Certain actions allow the user to pre-select one or more entries
 ;;  from the Deficiency list.  For the Enter/Edit Menu option, these
 ;;  actions are:
 ;;                 DE   --  Edit Deficiencies
 ;;                 EP   --  Expand Deficiency
 ;;                 QC   --  Quick Complete of Def.
 ;;                 TS   --  Treating Spec. Update
 ;;  For example:
 ;;
 ;;      DE=1      ...will process entry #1 using the Edit action.
 ;;      DE=3 4 5  ...will process entries 3,4,5 using the Edit action.
 ;;      DE=1-3    ...will process entries 1,2,3 using the Edit action.
 ;;$PAUSE
 ;;  The Jump to a Category (JC) action can be pre-selected by
 ;;  Type of Category.
 ;;
 ;;  For example:
 ;;
 ;;      JC=PHYS   ...will jump to the PHYSICAL EXAMINATION category.
 ;;
 ;;  If no entry is pre-selected, the user will be prompted for a
 ;;  selection.
 ;;
 ;;ACTION MENU DISPLAY:
 ;; The ADPL 'Auto Display(On/Off)' action can be used to turn on/off
 ;; the action menu that is displayed at the bottom of the screen.
 ;;------------------------------------------------------------------------------
 ;;$END
DLHLPTXT ; -- Delete menu help text
 ;;Enter actions by typing the names or abbreviations.
 ;;
 ;;LIST ENTRY PRE-SELECTION:
 ;;  Certain actions allow the user to pre-select one or more entries
 ;;  from the Deficiency list.  For the IRT Delete Menu option, these
 ;;  actions are:
 ;;
 ;;                 DL   --  Delete an IRT
 ;;                 EP   --  Expand Deficiency
 ;;  For example:
 ;;
 ;;      DL=3      ...will process entry #3 using the Delete action.
 ;;      DL=2 4 5  ...will process entries 2,4,5 using the Delete action.
 ;;      DL=1-3    ...will process entries 1,2,3 using the Delete action.
 ;;
 ;;  If no entry is pre-selected, the user will be prompted for a
 ;;  selection.
 ;;$PAUSE
 ;;ACTION MENU DISPLAY:
 ;; The ADPL 'Auto Display(On/Off)' action can be used to turn on/off
 ;; the action menu that is displayed at the bottom of the screen.
 ;;------------------------------------------------------------------------------
 ;;$END
 ;
STATUS ;This code is the screen code for the Status field (.11) of the
 ;Incomplete Records Tracking file (393).  This screens out the status
 ;for the different types of deficiencies and the divisions if they
 ;review IRTs.
 N DGJX,DGJY,DGJTPD S DGJX=$G(^VAS(393,DA,0)) Q:DGJX']""  S DGJY=$P(DGJX,"^",6),DGJTPD=$P($G(^VAS(393.3,$P(DGJX,"^",2),0)),"^",1)
 I $D(^DG(40.8,+DGJY,"DT")),$P(^DG(40.8,+DGJY,"DT"),"^",3)=1 I "^DISCHARGE SUMMARY^INTERIM SUMMARY^OP REPORT^"[DGJTPD S DIC("S")="I ""^COMPLETED^SIGNED NO REVIEW^""'[$P(^DG(393.2,+Y,0),U,1)" Q
 I "^DISCHARGE SUMMARY^INTERIM SUMMARY^OP REPORT^"[DGJTPD S DIC("S")="I ""^COMPLETED^SIGNED^REVIEWED^""'[$P(^DG(393.2,+Y,0),U,1)" Q
 S DIC("S")="I ""^COMPLETED^INCOMPLETE^""[$P(^DG(393.2,+Y,0),U,1)" Q
 Q

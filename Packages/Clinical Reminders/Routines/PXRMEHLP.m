PXRMEHLP ; SLC/PJH - Reminder Extract help. ;05/31/2006
 ;;2.0;CLINICAL REMINDERS;**4**;Feb 04, 2005;Build 21
 ;====================================================
LOAD(SUB) ;
 ;If necessary load the help text into the ^TMP array.
 ;Check if the help text has already been loaded.
 I $D(^TMP(SUB,$J,"VALMCNT")) D  Q
 . S VALMCNT=^TMP(SUB,$J,"VALMCNT")
 ;
 N DONE,IND,LABEL,TEXT
 S LABEL="NOHLP"
 I SUB["ETM" S LABEL="TX1"
 I SUB["ETH" S LABEL="TX2"
 I SUB["ETT" S LABEL="TX3"
 I SUB["EPM" S LABEL="TX4"
 I SUB["EPED" S LABEL="TX5"
 I SUB["EFM" S LABEL="TX6"
 I SUB["EFED" S LABEL="TX7"
 I SUB["EGM" S LABEL="TX8"
 I SUB["EGED" S LABEL="TX9"
 S DONE=0,VALMCNT=0
 F IND=1:1 Q:DONE  D
 . S TEXT=$P($T(@(LABEL_"+"_IND)),";;",2)
 . I TEXT="**End Text**" S DONE=1 Q
 . S VALMCNT=VALMCNT+1,^TMP(SUB,$J,VALMCNT,0)=TEXT
 S ^TMP(SUB,$J,"VALMCNT")=VALMCNT
 Q
 ;
 ;====================================================
TX1 ;Help text
 ;;The following actions are available:
 ;;
 ;;EDM Extract Definition Management
 ;;    Display/edit extract definitions.
 ;;
 ;;VSE View/Schedule Extract
 ;;    Display list of prior extract summaries or schedule manual
 ;;    extracts and transmission runs.
 ;;
 ;;QU  Quit
 ;;**End Text**
 Q
 ;
 ;====================================================
TX2 ;Help text
 ;;The following actions are available:
 ;;
 ;;CV  Change View
 ;;    Toggle view of extract summaries between creation date order and
 ;;    extract period order.
 ;;
 ;;ES  Extract Summary
 ;;    Display reminder compliance and finding totals for extract summary.
 ;;    Also displays patient list with option to print Health Summary.
 ;;
 ;;ME  Manual Extract
 ;;    Initiate a new extract for a selected period with option to 
 ;;    transmit. 
 ;;
 ;;MT  Manual Transmission
 ;;    Initiate a transmission or retransmission of an existing extract
 ;;    summary. 
 ;;
 ;;TH  Transmission History
 ;;    Display transmission history and HL7 message ID's for an
 ;;    existing extract.
 ;;
 ;;QU  Quit
 ;;**End Text**
 Q
 ;
 ;====================================================
TX3 ;Help text
 ;;The following actions are available:
 ;;
 ;;DPL Display Patient List
 ;;    Display a patient list used to create extract summary with
 ;;    option to print Health Summary.
 ;;
 ;;DSF Display/Suppress Finding Totals
 ;;    Toggle between display with reminder compliance totals only and
 ;;    display with both reminder compliance and finding totals.
 ;;
 ;;PL  Print List
 ;;    Print extract totals currently displayed.
 ;;
 ;;QU  Quit
 ;;**End Text**
 Q
 ;
 ;====================================================
TX4 ;Help text
 ;;The following actions are available:
 ;;
 ;;CR  Create Extract Definition
 ;;
 ;;DE  Display/Edit Extract Definition
 ;;
 ;;QU  Quit
 ;;**End Text**
 Q
 ;
 ;====================================================
TX5 ;Help text
 ;;The following actions are available:
 ;;
 ;;ED  Edit Extract Definition
 ;;
 ;;QU  Quit
 ;;**End Text**
 Q
 ;
 ;====================================================
TX6 ;Help text
 ;;The following actions are available:
 ;;
 ;;CR  Create Extract Counting Rule
 ;;
 ;;DE  Display/Edit Extract Counting Rule
 ;;
 ;;QU  Quit
 ;;**End Text**
 Q
 ;
 ;====================================================
TX7 ;Help text
 ;;The following actions are available:
 ;;
 ;;ED  Edit Extract Counting Rule
 ;;
 ;;CG  Counting Groups
 ;;
 ;;QU  Quit
 ;;**End Text**
 Q
 ;
 ;====================================================
TX8 ;Help text
 ;;The following actions are available:
 ;;
 ;;CR  Create Extract Counting Group
 ;;
 ;;DE  Display/Edit Extract Counting Group
 ;;
 ;;QU  Quit
 ;;**End Text**
 Q
 ;
 ;====================================================
TX9 ;Help text
 ;;The following actions are available:
 ;;
 ;;ED  Edit Extract Counting Group
 ;;
 ;;QU  Quit
 ;;**End Text**
 Q
 ;
 ;====================================================
NOHLP ;Help text
 ;;
 ;;No Help Text Available
 ;;
 ;;**End Text**
 Q
 ;

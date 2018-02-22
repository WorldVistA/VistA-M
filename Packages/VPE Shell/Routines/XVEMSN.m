XVEMSN ;DJB/VSHL**VPE Notes [2/1/97 10:32am];2017-08-16  10:24 AM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
NOTES ;;;;
 ;;; ----->   V P E   P A R A M E T E R   P A S S I N G
 ;;;
 ;;; NOTE: When entering fields, if the field is a multiple you MUST use the
 ;;; field's name, not it's number. When entering file or field names, if the
 ;;; name contains a space you MUST enclose the name in quotes.
 ;;;
 ;;; 1) VEDD  PARAM^XVEMD(File Name/Num,Menu Option Mnemonic,Field Names/Nums)
 ;;;          Ind Fld Sum............DO PARAM^XVEMD("USER","I",".01;2")
 ;;;          Fld Global Location....DO PARAM^XVEMD("USER","G",30)
 ;;;          ..VEDD USER I .01;2
 ;;;          ..VEDD "NEW PERSON" G 30
 ;;;
 ;;; 2) VGL   PARAM^XVEMG(^Global -or- File Name)
 ;;;          DO PARAM^XVEMG("^VA(200")      ..VGL ^VA(200
 ;;;          DO PARAM^XVEMG("NEW PERSON")   ..VGL "NEW PERSON"
 ;;;
 ;;; 3) VRR   PARAM^XVEMR(Routine Name)
 ;;;          DO PARAM^XVEMR("XVEMD")        ..VRR XVEMD
 ;;;
 ;;; ----->   V P E   P R O G R A M M E R   C A L L S
 ;;;
 ;;; 1) SINGLE CHARACTER READ
 ;;;    S X=$$READ^XVEMKRN   X=String, XVV("K")=Key, XVV array left defined
 ;;;
 ;;; 2) STRING EDITOR
 ;;;    S CD=String D SCREEN^XVEMKEA("PROMPT:",2,75)
 ;;;    CD=Edited String, XVVSHC=<RET>, XVV array left defined
 ;;;
 ;;; 3) CHOICE SELECTION
 ;;;    W !?2,"Proceed with deletion?" S X=$$CHOICE^XVEMKC("YES^NO",1,10,21)
 ;;;    1=Option to be highlighted 10,21=$X,$Y (use when placing prompts)
 ;;;    For MSM, RM0 is in effect, after calling CHOICE.
 ;;;    Returns number of CHOICE selected, or 0. XVV array left defined.
 ;;;
 ;;; 4) MENU
 ;;;    Copy ^XVEMSH,^XVEMSHY. Change any calls to the new rtns.
 ;;;    Edit subroutine INIT^ROUTINE:
 ;;;          COLUMNS="6^7"   ;Number of options in each column
 ;;;          WIDTH=31        ;Width of reverse video
 ;;;          HD=Heading      ;Heading for new menu
 ;;;    Insert ";;***" in MENU lines and adj COLUMNS to reduce number of menu
 ;;;    options. Can be more than 2 columns. Edit TOPICS^ROUTINE for subheadings.
 ;;;          Ex: TOPICS+1 - ;;;E D I T;;;3;4
 ;;;
 ;;; 5) GENERIC SELECTOR
 ;;;    Put items in an array.
 ;;;    Call SELECTOR, passing 3 parameters:
 ;;;          Parameter 1: Array root
 ;;;          Parameter 2: 1=All choices in the display will be numbered
 ;;;          Parameter 3: 1=NEW allowed. This adds menu option N=New to bottom
 ;;;                       of the screen. ^TMP("VPE","SELECT",$J,"NEW")="" will
 ;;;                       be returned if user hits N. This allows user to
 ;;;                       indicate that they want to add a new entry.
 ;;;
 ;;;    SELECTOR will return items selected in ^TMP("VPE","SELECT",$J)
 ;;;
 ;;;    Example: Build array of names:
 ;;;               ^TMP("TEST",$J,1)="Bolduc,David J."
 ;;;               ^TMP("TEST",$J,2)="Duck,Donald"
 ;;;               ^TMP("TEST",$J,3)="Mouse,Mickey"
 ;;;             Call SELECTOR:
 ;;;               D SELECT^XVEMKT("^TMP(""TEST"","_$J_")",1)
 ;;;             SELECTOR returns items selected:
 ;;;               ^TMP("VPE","SELECT",$J,1)="Bolduc,David J."
 ;;;
 ;;;    You can control what SELECTOR returns in ^TMP("VPE","SELECT",$J).
 ;;;    When array is built, concantenate what you want returned, to the front
 ;;;    of the array node using $C(9) as a delimiter. A common returned value
 ;;;    is the item's Internal Entry Number. The SELECTOR will only display
 ;;;    the characters to the right of the $C(9).
 ;;;
 ;;;    The default heading is "Select: ITEMS". You can replace the word ITEMS
 ;;;    with a word of your choice by setting a "HD" node in your array.
 ;;;
 ;;;    Example:
 ;;;               ^TMP("TEST",$J,"HD")="PARTICIPANT"
 ;;;               ^TMP("TEST",$J,1)="234"_$C(9)_"Bolduc,David J."
 ;;;               ^TMP("TEST",$J,2)="45"_$C(9)_"Duck,Donald"
 ;;;               ^TMP("TEST",$J,3)="14"_$C(9)_"Mouse,Mickey"
 ;;;    If Bolduc were selected, SELECTOR would return:
 ;;;               ^TMP("VPE","SELECT",$J,1)="234$C(9)Bolduc,David J."
 ;;;
 ;;; 6) FILEMAN FIELD SELECTOR
 ;;;    D SELECT^XVEMKTF(FileNumber,LEVEL)
 ;;;    LEVEL: "TOP"=Top level flds only  "ALL"=Include multiple flds
 ;;;    Example: D SELECT^XVEMKTF(200,"TOP")
 ;;;             Allows you to select from all top level fields
 ;;;             of the NEW PERSON file.
 ;;;    Returns array: ^TMP("VPE","FIELDS",$J,FILE#,FIELD#)
 ;;;***

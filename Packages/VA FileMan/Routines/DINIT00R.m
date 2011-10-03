DINIT00R ; SFISC/TKW-DIALOG & LANGUAGE FILE INITS ; 3/30/99  10:41:48
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,9201,2,154,0)
 ;;=     'R'.  A separate list keeps track of the documents chosen during the
 ;;^UTILITY(U,$J,.84,9201,2,155,0)
 ;;=     current Browse session.  R will return all the way back to the very
 ;;^UTILITY(U,$J,.84,9201,2,156,0)
 ;;=     first document when used repeatedly.
 ;;^UTILITY(U,$J,.84,9201,2,157,0)
 ;;=
 ;;^UTILITY(U,$J,.84,9201,2,158,0)
 ;;=     To COPY text to VA FileMan's Clipboard, press <PF1> followed by the
 ;;^UTILITY(U,$J,.84,9201,2,159,0)
 ;;=     letter C.  A prompt will appear where a range of lines can be entered
 ;;^UTILITY(U,$J,.84,9201,2,160,0)
 ;;=     separated with a colon (:), or wild card such as (*), to copy the
 ;;^UTILITY(U,$J,.84,9201,2,161,0)
 ;;=     entire text.  If the letter 'A' is appended, the text will be
 ;;^UTILITY(U,$J,.84,9201,2,162,0)
 ;;=     appended to the existing content of the VA FileMan Clipboard, when
 ;;^UTILITY(U,$J,.84,9201,2,163,0)
 ;;=     applicable.  The text in the clipboard may then be retrieved by VA
 ;;^UTILITY(U,$J,.84,9201,2,164,0)
 ;;=     FileMan's Screen Editor.
 ;;^UTILITY(U,$J,.84,9201,2,165,0)
 ;;=
 ;;^UTILITY(U,$J,.84,9201,2,166,0)
 ;;=     To VIEW the content of the VA FileMan's Clipboard, press <PF1>
 ;;^UTILITY(U,$J,.84,9201,2,167,0)
 ;;=     followed by the letter V.  A new Browser screen appears, which
 ;;^UTILITY(U,$J,.84,9201,2,168,0)
 ;;=     displays the text.  Many functions are restricted, when in the 'View
 ;;^UTILITY(U,$J,.84,9201,2,169,0)
 ;;=     Clipboard' mode.
 ;;^UTILITY(U,$J,.84,9201,2,170,0)
 ;;=
 ;;^UTILITY(U,$J,.84,9201,2,171,0)
 ;;=     To SPLIT SCREEN, while in Full (Browse Region) Screen mode, press
 ;;^UTILITY(U,$J,.84,9201,2,172,0)
 ;;=     <PF2> followed by the letter 'S'.  This causes the screen to split
 ;;^UTILITY(U,$J,.84,9201,2,173,0)
 ;;=     into two separate scroll regions.
 ;;^UTILITY(U,$J,.84,9201,2,174,0)
 ;;=
 ;;^UTILITY(U,$J,.84,9201,2,175,0)
 ;;=     To navigate to the bottom screen, while in Split Screen mode, press
 ;;^UTILITY(U,$J,.84,9201,2,176,0)
 ;;=     <PF2> followed by pressing the ARROW DOWN key.
 ;;^UTILITY(U,$J,.84,9201,2,177,0)
 ;;=
 ;;^UTILITY(U,$J,.84,9201,2,178,0)
 ;;=     To navigate to the top screen, while in Split Screen mode, press
 ;;^UTILITY(U,$J,.84,9201,2,179,0)
 ;;=     <PF2> followed by pressing the ARROW UP key.
 ;;^UTILITY(U,$J,.84,9201,2,180,0)
 ;;=
 ;;^UTILITY(U,$J,.84,9201,2,181,0)
 ;;=     To return to FULL SCREEN mode, while in Split Screen mode, press
 ;;^UTILITY(U,$J,.84,9201,2,182,0)
 ;;=     <PF2> followed by the letter 'F'.  This causes the entire browse
 ;;^UTILITY(U,$J,.84,9201,2,183,0)
 ;;=     region to return to one Full (Browse) Screen scroll region.
 ;;^UTILITY(U,$J,.84,9201,2,184,0)
 ;;=
 ;;^UTILITY(U,$J,.84,9201,2,185,0)
 ;;=     To RESIZE screens, while in Split Screen mode, press <PF2><PF2>
 ;;^UTILITY(U,$J,.84,9201,2,186,0)
 ;;=     followed by the ARROW UP key.  This makes the top window smaller and
 ;;^UTILITY(U,$J,.84,9201,2,187,0)
 ;;=     the bottom window larger.  <PF2><PF2> followed by the ARROW DOWN key
 ;;^UTILITY(U,$J,.84,9201,2,188,0)
 ;;=     makes the top window larger and the bottom window smaller.
 ;;^UTILITY(U,$J,.84,9201,2,189,0)
 ;;=
 ;;^UTILITY(U,$J,.84,9201,2,190,0)
 ;;=     The TITLE BAR, at the top, is a non scrolling region which contains
 ;;^UTILITY(U,$J,.84,9201,2,191,0)
 ;;=     static information, while browsing in the selected document.  The
 ;;^UTILITY(U,$J,.84,9201,2,192,0)
 ;;=     title bar information only changes when switching documents or
 ;;^UTILITY(U,$J,.84,9201,2,193,0)
 ;;=     requesting help.  To move text header into the Title Bar, one line at
 ;;^UTILITY(U,$J,.84,9201,2,194,0)
 ;;=     a time, press <PF1><PF1>ARROW DOWN or <PF1><PF1>ARROW UP.  This
 ;;^UTILITY(U,$J,.84,9201,2,195,0)
 ;;=     replaces the text in the Title Bar with the content of the text in
 ;;^UTILITY(U,$J,.84,9201,2,196,0)
 ;;=     the scroll region, one line at a time.  This can be usefull, when
 ;;^UTILITY(U,$J,.84,9201,2,197,0)
 ;;=     Browser is called via the Device Handler (Browser Device), for
 ;;^UTILITY(U,$J,.84,9201,2,198,0)
 ;;=     Browsing through standard VA FileMan Prints.  This allows a user to
 ;;^UTILITY(U,$J,.84,9201,2,199,0)
 ;;=     move the field headers into the Title Bar.
 ;;^UTILITY(U,$J,.84,9201,2,200,0)
 ;;=
 ;;^UTILITY(U,$J,.84,9201,2,201,0)
 ;;=     The STATUS BAR, at the bottom, is also a non scroll region.  It shows
 ;;^UTILITY(U,$J,.84,9201,2,202,0)
 ;;=     the column indicator, how to get help, how to exit, line information
 ;;^UTILITY(U,$J,.84,9201,2,203,0)
 ;;=     and screen information.  The "Col>" indicates the column number the
 ;;^UTILITY(U,$J,.84,9201,2,204,0)
 ;;=     left edge of the browse window is over in the document.  The "Line>"
 ;;^UTILITY(U,$J,.84,9201,2,205,0)
 ;;=     shows the current line at the bottom of the scroll region and the
 ;;^UTILITY(U,$J,.84,9201,2,206,0)
 ;;=     total number of lines in the document.  The "Screen>" shows the
 ;;^UTILITY(U,$J,.84,9201,2,207,0)
 ;;=     current screen and the total number of screens in the document.
 ;;^UTILITY(U,$J,.84,9201,2,208,0)
 ;;=
 ;;^UTILITY(U,$J,.84,9201,2,209,0)
 ;;=     The SCROLLING REGION, between the TITLE BAR and the STATUS BAR, is
 ;;^UTILITY(U,$J,.84,9201,2,210,0)
 ;;=     where the Browser displays the text being viewed.
 ;;^UTILITY(U,$J,.84,9201,2,211,0)
 ;;=
 ;;^UTILITY(U,$J,.84,9201,2,212,0)
 ;;=     To print the help text, press <PF1><PF1><PF1>H.  This will prompt for
 ;;^UTILITY(U,$J,.84,9201,2,213,0)
 ;;=     a Device.  Only valid print devices can be selected.
 ;;^UTILITY(U,$J,.84,9201,2,214,0)
 ;;=
 ;;^UTILITY(U,$J,.84,9201,2,215,0)
 ;;=     <<<Press 'R' or <PF1>'E' to exit this help document>>>
 ;;^UTILITY(U,$J,.84,9202,0)
 ;;=9202^3^^5
 ;;^UTILITY(U,$J,.84,9202,1,0)
 ;;=^^1^1^2950511^^^
 ;;^UTILITY(U,$J,.84,9202,1,1,0)
 ;;=Browser help text, for hypertext mode.
 ;;^UTILITY(U,$J,.84,9202,2,-1,"DATE")
 ;;=56904,33726
 ;;^UTILITY(U,$J,.84,9202,2,-1,"TITLE")
 ;;=9202
 ;;^UTILITY(U,$J,.84,9202,2,0)
 ;;=^^126^1262950515^
 ;;^UTILITY(U,$J,.84,9202,2,1,0)
 ;;=VA FileMan Browser Help for Hypertext Mode
 ;;^UTILITY(U,$J,.84,9202,2,2,0)
 ;;=
 ;;^UTILITY(U,$J,.84,9202,2,3,0)
 ;;=Hypertext jumps are represented in 'bold' text. Press the Tab or 'Q' keys to
 ;;^UTILITY(U,$J,.84,9202,2,4,0)
 ;;=navigate forward and backward, in order to select a jump. Once a jump is

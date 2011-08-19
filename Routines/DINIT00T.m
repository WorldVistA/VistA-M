DINIT00T ; SFISC/TKW-DIALOG & LANGUAGE FILE INITS ;11:00 AM  25 Aug 2000
 ;;22.0;VA FileMan;**8,18**;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,9202,2,90,0)
 ;;=if screen 10 is a valid screen. L99 will go to line 99.
 ;;^UTILITY(U,$J,.84,9202,2,91,0)
 ;;=
 ;;^UTILITY(U,$J,.84,9202,2,92,0)
 ;;=To change the content of the Title Bar, press <PF1> <PF1> ARROW DOWN or ARROW
 ;;^UTILITY(U,$J,.84,9202,2,93,0)
 ;;=UP. This function replaces the content of the Title Bar with the text in the
 ;;^UTILITY(U,$J,.84,9202,2,94,0)
 ;;=body of the document. Users with programmer access can also use <PF4> 'T', to
 ;;^UTILITY(U,$J,.84,9202,2,95,0)
 ;;=permanently change the title of a hypertext document.
 ;;^UTILITY(U,$J,.84,9202,2,96,0)
 ;;=
 ;;^UTILITY(U,$J,.84,9202,2,97,0)
 ;;=To copy text to VA FileMan's Clipboard, press <PF1><PF1>C. This open up a
 ;;^UTILITY(U,$J,.84,9202,2,98,0)
 ;;=dialog screen and prompts for a line or range of lines to copy or append to the
 ;;^UTILITY(U,$J,.84,9202,2,99,0)
 ;;=clipboard. A range of lines are represented by two numeric values separated by
 ;;^UTILITY(U,$J,.84,9202,2,100,0)
 ;;=a colon (:), the wild card (*) may also be used if the entire text is
 ;;^UTILITY(U,$J,.84,9202,2,101,0)
 ;;=desired.  To append to the existing clipboard text, enter the letter 'A'
 ;;^UTILITY(U,$J,.84,9202,2,102,0)
 ;;=as the last character, when entering the range of lines to copy.  This
 ;;^UTILITY(U,$J,.84,9202,2,103,0)
 ;;=text is then retrieved for word-processing fields, when using VA FileMan's
 ;;^UTILITY(U,$J,.84,9202,2,104,0)
 ;;=Screen Editor.
 ;;^UTILITY(U,$J,.84,9202,2,105,0)
 ;;=
 ;;^UTILITY(U,$J,.84,9202,2,106,0)
 ;;=To SPLIT SCREEN, while in Full (Browse Region) Screen mode, press <PF2>
 ;;^UTILITY(U,$J,.84,9202,2,107,0)
 ;;=followed by the letter 'S'. This causes the screen to split into two separate
 ;;^UTILITY(U,$J,.84,9202,2,108,0)
 ;;=scroll regions.
 ;;^UTILITY(U,$J,.84,9202,2,109,0)
 ;;=
 ;;^UTILITY(U,$J,.84,9202,2,110,0)
 ;;=To navigate to the bottom screen, while in Split Screen mode, press <PF2>
 ;;^UTILITY(U,$J,.84,9202,2,111,0)
 ;;=followed by pressing the DOWN ARROW key.
 ;;^UTILITY(U,$J,.84,9202,2,112,0)
 ;;=
 ;;^UTILITY(U,$J,.84,9202,2,113,0)
 ;;=To navigate to the top screen, while in Split Screen mode, press <PF2> followed
 ;;^UTILITY(U,$J,.84,9202,2,114,0)
 ;;=by pressing the UP ARRAY key.
 ;;^UTILITY(U,$J,.84,9202,2,115,0)
 ;;=
 ;;^UTILITY(U,$J,.84,9202,2,116,0)
 ;;=To return to FULL SCREEN mode, while in Split Screen mode, press <PF2> followed
 ;;^UTILITY(U,$J,.84,9202,2,117,0)
 ;;=by the letter 'F'. This causes the entire browse region to return to one Full
 ;;^UTILITY(U,$J,.84,9202,2,118,0)
 ;;=(Browse) Screen scroll region.
 ;;^UTILITY(U,$J,.84,9202,2,119,0)
 ;;=
 ;;^UTILITY(U,$J,.84,9202,2,120,0)
 ;;=The BOTTOM STATUS LINE shows that the Browser is in hypertext mode. It
 ;;^UTILITY(U,$J,.84,9202,2,121,0)
 ;;=indicates the line numbers that correspond to the bottom text line on the
 ;;^UTILITY(U,$J,.84,9202,2,122,0)
 ;;=screen, in the display text section, and provides the total line count. The
 ;;^UTILITY(U,$J,.84,9202,2,123,0)
 ;;=screen indicator shows what screen the last line is on and also provides the
 ;;^UTILITY(U,$J,.84,9202,2,124,0)
 ;;=total number of screens.
 ;;^UTILITY(U,$J,.84,9202,2,125,0)
 ;;=
 ;;^UTILITY(U,$J,.84,9202,2,126,0)
 ;;=<<<Press 'R' or <PF1>'E' to exit this help document>>>
 ;;^UTILITY(U,$J,.84,9211,0)
 ;;=9211^3^^5
 ;;^UTILITY(U,$J,.84,9211,1,0)
 ;;=^^1^1^2960423^^^^
 ;;^UTILITY(U,$J,.84,9211,1,1,0)
 ;;=Screen 1 of Screen Editor help.
 ;;^UTILITY(U,$J,.84,9211,2,0)
 ;;=^^18^18^2961212^
 ;;^UTILITY(U,$J,.84,9211,2,1,0)
 ;;=                                                           \BHelp Screen 1 of 4\n
 ;;^UTILITY(U,$J,.84,9211,2,2,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9211,2,3,0)
 ;;=\BSUMMARY OF KEY SEQUENCES\n
 ;;^UTILITY(U,$J,.84,9211,2,4,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9211,2,5,0)
 ;;=\BNavigation\n
 ;;^UTILITY(U,$J,.84,9211,2,6,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9211,2,7,0)
 ;;=   Incremental movement            Arrow keys
 ;;^UTILITY(U,$J,.84,9211,2,8,0)
 ;;=   One word left and right         <Ctrl-J> and <Ctrl-L>
 ;;^UTILITY(U,$J,.84,9211,2,9,0)
 ;;=   Next tab stop to the right      <Tab>
 ;;^UTILITY(U,$J,.84,9211,2,10,0)
 ;;=   Jump left and right             <PF1><Left> and <PF1><Right>
 ;;^UTILITY(U,$J,.84,9211,2,11,0)
 ;;=   Beginning and end of line       <PF1><PF1><Left> and <PF1><PF1><Right>
 ;;^UTILITY(U,$J,.84,9211,2,12,0)
 ;;=                                      or:  <Find> and <Select>
 ;;^UTILITY(U,$J,.84,9211,2,13,0)
 ;;=                                      or:  <Home> and <End>
 ;;^UTILITY(U,$J,.84,9211,2,14,0)
 ;;=   Screen up or down               <PF1><Up> and <PF1><Down>
 ;;^UTILITY(U,$J,.84,9211,2,15,0)
 ;;=                                      or:  <Prev Scr> and <Next Scr>
 ;;^UTILITY(U,$J,.84,9211,2,16,0)
 ;;=                                      or:  <Page Up>  and <Page Down>
 ;;^UTILITY(U,$J,.84,9211,2,17,0)
 ;;=   Top or bottom of document       <PF1>T and <PF1>B
 ;;^UTILITY(U,$J,.84,9211,2,18,0)
 ;;=   Go to a specific location       <PF1>G
 ;;^UTILITY(U,$J,.84,9212,0)
 ;;=9212^3^^5
 ;;^UTILITY(U,$J,.84,9212,1,0)
 ;;=^^1^1^3000816^^^^
 ;;^UTILITY(U,$J,.84,9212,1,1,0)
 ;;=Screen 2 of Screen Editor help.
 ;;^UTILITY(U,$J,.84,9212,2,0)
 ;;=^^18^18^3000816^
 ;;^UTILITY(U,$J,.84,9212,2,1,0)
 ;;=                                                           \BHelp Screen 2 of 4\n
 ;;^UTILITY(U,$J,.84,9212,2,2,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9212,2,3,0)
 ;;=\BExiting/Saving\n
 ;;^UTILITY(U,$J,.84,9212,2,4,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9212,2,5,0)
 ;;=   Exit and save text              <PF1>E
 ;;^UTILITY(U,$J,.84,9212,2,6,0)
 ;;=   Quit with optional save         <PF1>Q  or  <Ctrl-E>
 ;;^UTILITY(U,$J,.84,9212,2,7,0)
 ;;=   Exit, save, and switch editors  <PF1>A
 ;;^UTILITY(U,$J,.84,9212,2,8,0)
 ;;=   Save without exiting            <PF1>S
 ;;^UTILITY(U,$J,.84,9212,2,9,0)
 ;;=   Enter minutes for AutoSave      <PF1><PF1>S
 ;;^UTILITY(U,$J,.84,9212,2,10,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9212,2,11,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9212,2,12,0)
 ;;=\BDeleting\n
 ;;^UTILITY(U,$J,.84,9212,2,13,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9212,2,14,0)
 ;;=   Character before cursor         <Backspace>
 ;;^UTILITY(U,$J,.84,9212,2,15,0)
 ;;=   Character at cursor             <PF4>  or  <Remove>  or  <Delete>
 ;;^UTILITY(U,$J,.84,9212,2,16,0)
 ;;=   From cursor to end of word      <Ctrl-W>
 ;;^UTILITY(U,$J,.84,9212,2,17,0)
 ;;=   From cursor to end of line      <PF1><PF2>
 ;;^UTILITY(U,$J,.84,9212,2,18,0)
 ;;=   Entire line                     <PF1>D
 ;;^UTILITY(U,$J,.84,9213,0)
 ;;=9213^3^^5
 ;;^UTILITY(U,$J,.84,9213,1,0)
 ;;=^.842^1^1^3000825^^^^
 ;;^UTILITY(U,$J,.84,9213,1,1,0)
 ;;=Screen 3 of Screen Editor help.
 ;;^UTILITY(U,$J,.84,9213,2,0)
 ;;=^^16^16^3000825^

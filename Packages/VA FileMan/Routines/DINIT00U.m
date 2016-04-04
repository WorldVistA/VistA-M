DINIT00U ; SFISC/TKW-DIALOG & LANGUAGE FILE INITS ;06:10 PM  5 Dec 2002
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**8,999**
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,9213,2,1,0)
 ;;=                                                           \BHelp Screen 3 of 4\n
 ;;^UTILITY(U,$J,.84,9213,2,2,0)
 ;;=\BSettings/Modes\n
 ;;^UTILITY(U,$J,.84,9213,2,3,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9213,2,4,0)
 ;;=   Wrap/nowrap mode toggle         <F2>
 ;;^UTILITY(U,$J,.84,9213,2,5,0)
 ;;=   Insert/replace mode toggle      <F3>  or  <Insert Here>  or  <Insert>
 ;;^UTILITY(U,$J,.84,9213,2,6,0)
 ;;=   Set/clear tab stop              <F1><Tab>
 ;;^UTILITY(U,$J,.84,9213,2,6.5,0)
 ;;=   Enter columns for tab stops     <F1><F1><Tab>
 ;;^UTILITY(U,$J,.84,9213,2,7,0)
 ;;=   Set left margin                 <F1>,
 ;;^UTILITY(U,$J,.84,9213,2,8,0)
 ;;=   Set right margin                <F1>.
 ;;^UTILITY(U,$J,.84,9213,2,9,0)
 ;;=   Status line toggle              <F1>?
 ;;^UTILITY(U,$J,.84,9213,2,10,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9213,2,11,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9213,2,12,0)
 ;;=\BFormatting\n
 ;;^UTILITY(U,$J,.84,9213,2,13,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9213,2,14,0)
 ;;=   Join current line to next line  <F1>J
 ;;^UTILITY(U,$J,.84,9213,2,15,0)
 ;;=   Reformat paragraph              <F1>R
 ;;^UTILITY(U,$J,.84,9214,0)
 ;;=9214^3^^5
 ;;^UTILITY(U,$J,.84,9214,1,0)
 ;;=^^1^1^2940624^^^^
 ;;^UTILITY(U,$J,.84,9214,1,1,0)
 ;;=Screen 4 of Screen Editor help.
 ;;^UTILITY(U,$J,.84,9214,2,0)
 ;;=^^19^19^2961212^^
 ;;^UTILITY(U,$J,.84,9214,2,1,0)
 ;;=                                                           \BHelp Screen 4 of 4\n
 ;;^UTILITY(U,$J,.84,9214,2,2,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9214,2,3,0)
 ;;=\BFinding\n
 ;;^UTILITY(U,$J,.84,9214,2,4,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9214,2,5,0)
 ;;=   Find text                       <F1>F
 ;;^UTILITY(U,$J,.84,9214,2,6,0)
 ;;=   Find next occurence of text     <F1>N
 ;;^UTILITY(U,$J,.84,9214,2,7,0)
 ;;=   Find/RePlace text               <F1>P
 ;;^UTILITY(U,$J,.84,9214,2,8,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9214,2,9,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9214,2,10,0)
 ;;=\BCutting/Copying/Pasting\n
 ;;^UTILITY(U,$J,.84,9214,2,11,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9214,2,12,0)
 ;;=   Select (Mark) text              <F1>M at beginning and end of text
 ;;^UTILITY(U,$J,.84,9214,2,13,0)
 ;;=   Unselect (Unmark) text          <F1><F1>M
 ;;^UTILITY(U,$J,.84,9214,2,14,0)
 ;;=   Delete selected text            <Delete>  or  <Backspace> on selected text
 ;;^UTILITY(U,$J,.84,9214,2,15,0)
 ;;=   Cut and save to buffer          <F1>X on selected text
 ;;^UTILITY(U,$J,.84,9214,2,16,0)
 ;;=   Copy and save to buffer         <F1>C on selected text
 ;;^UTILITY(U,$J,.84,9214,2,17,0)
 ;;=   Paste from buffer               <F1>V
 ;;^UTILITY(U,$J,.84,9214,2,18,0)
 ;;=   Move text to another location   <F1>X at new location
 ;;^UTILITY(U,$J,.84,9214,2,19,0)
 ;;=   Copy text to another location   <F1>C at new location
 ;;^UTILITY(U,$J,.84,9231,0)
 ;;=9231^3^^5
 ;;^UTILITY(U,$J,.84,9231,1,0)
 ;;=^^1^1^2940706^^
 ;;^UTILITY(U,$J,.84,9231,1,1,0)
 ;;=Screen 1 of ScreenMan help.
 ;;^UTILITY(U,$J,.84,9231,2,0)
 ;;=^^18^18^2940831^
 ;;^UTILITY(U,$J,.84,9231,2,1,0)
 ;;=                                                                \BScreen 1 of 3\n
 ;;^UTILITY(U,$J,.84,9231,2,2,0)
 ;;=                               \BSCREENMAN HELP\n
 ;;^UTILITY(U,$J,.84,9231,2,3,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9231,2,4,0)
 ;;=\BCursor Movement\n
 ;;^UTILITY(U,$J,.84,9231,2,5,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9231,2,6,0)
 ;;=Move right one character            <Right>
 ;;^UTILITY(U,$J,.84,9231,2,7,0)
 ;;=Move left one character             <Left>
 ;;^UTILITY(U,$J,.84,9231,2,8,0)
 ;;=Move right one word                 <Ctrl-L> or <F1><Space>
 ;;^UTILITY(U,$J,.84,9231,2,9,0)
 ;;=Move left one word                  <Ctrl-J>
 ;;^UTILITY(U,$J,.84,9231,2,10,0)
 ;;=Move to right of window             <F1><Right>
 ;;^UTILITY(U,$J,.84,9231,2,11,0)
 ;;=Move to left of window              <F1><Left>
 ;;^UTILITY(U,$J,.84,9231,2,12,0)
 ;;=Move to end of field                <F1><F1><Right>
 ;;^UTILITY(U,$J,.84,9231,2,13,0)
 ;;=Move to beginning of field          <F1><F1><Left>
 ;;^UTILITY(U,$J,.84,9231,2,14,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9231,2,15,0)
 ;;=\BModes\n
 ;;^UTILITY(U,$J,.84,9231,2,16,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9231,2,17,0)
 ;;=Insert/Replace toggle               <F3>
 ;;^UTILITY(U,$J,.84,9231,2,18,0)
 ;;=Zoom (invoke multiline editor)      <F1>Z
 ;;^UTILITY(U,$J,.84,9232,0)
 ;;=9232^3^^5
 ;;^UTILITY(U,$J,.84,9232,1,0)
 ;;=^^1^1^2940706^
 ;;^UTILITY(U,$J,.84,9232,1,1,0)
 ;;=Screen 2 of ScreenMan help.
 ;;^UTILITY(U,$J,.84,9232,2,0)
 ;;=^^20^20^2940831^
 ;;^UTILITY(U,$J,.84,9232,2,1,0)
 ;;=                                                                \BScreen 2 of 3\n
 ;;^UTILITY(U,$J,.84,9232,2,2,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9232,2,3,0)
 ;;=\BDeletions\n
 ;;^UTILITY(U,$J,.84,9232,2,4,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9232,2,5,0)
 ;;=Character under cursor           <F2> or <Delete>
 ;;^UTILITY(U,$J,.84,9232,2,6,0)
 ;;=Character left of cursor         <Backspace>
 ;;^UTILITY(U,$J,.84,9232,2,7,0)
 ;;=From cursor to end of word       <Ctrl-W>
 ;;^UTILITY(U,$J,.84,9232,2,8,0)
 ;;=From cursor to end of field      <F1><F2>
 ;;^UTILITY(U,$J,.84,9232,2,9,0)
 ;;=Toggle null/last edit/default    <F1>D or <Ctrl-U>
 ;;^UTILITY(U,$J,.84,9232,2,10,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9232,2,11,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9232,2,12,0)
 ;;=\BMacro Movement\n
 ;;^UTILITY(U,$J,.84,9232,2,13,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9232,2,14,0)
 ;;=Field below         <Down>    |   Next page           <F1><Down> or <PageDown>
 ;;^UTILITY(U,$J,.84,9232,2,15,0)
 ;;=Field above         <Up>      |   Previous page       <F1><Up> or <PageUp>
 ;;^UTILITY(U,$J,.84,9232,2,16,0)
 ;;=Field to right      <Tab>     |   Next block          <F1><F4>
 ;;^UTILITY(U,$J,.84,9232,2,17,0)
 ;;=Field to left       <F4>     |   Jump to a field     ^caption
 ;;^UTILITY(U,$J,.84,9232,2,18,0)
 ;;=Pre-defined order   <Return>  |   Go to Command Line  ^
 ;;^UTILITY(U,$J,.84,9232,2,19,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9232,2,20,0)
 ;;=Go into multiple or word processing field             <Return>
 ;;^UTILITY(U,$J,.84,9233,0)
 ;;=9233^3^^5
 ;;^UTILITY(U,$J,.84,9233,1,0)
 ;;=^^1^1^2941116^^
 ;;^UTILITY(U,$J,.84,9233,1,1,0)
 ;;=Screen 3 of ScreenMan help.
 ;;^UTILITY(U,$J,.84,9233,2,0)
 ;;=^^18^18^2941116^
 ;;^UTILITY(U,$J,.84,9233,2,1,0)
 ;;=                                                                \BScreen 3 of 3\n
 ;;^UTILITY(U,$J,.84,9233,2,2,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9233,2,3,0)
 ;;=\BCommand Line Options\n (Enter '^' at any field to jump to the command line.)

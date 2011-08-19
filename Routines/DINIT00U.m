DINIT00U ; SFISC/TKW-DIALOG & LANGUAGE FILE INITS ;12:15 PM  25 Aug 2000
 ;;22.0;VA FileMan;**8,18**;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,9213,2,1,0)
 ;;=                                                           \BHelp Screen 3 of 4\n
 ;;^UTILITY(U,$J,.84,9213,2,2,0)
 ;;=\BSettings/Modes\n
 ;;^UTILITY(U,$J,.84,9213,2,3,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9213,2,4,0)
 ;;=   Wrap/nowrap mode toggle         <PF2>
 ;;^UTILITY(U,$J,.84,9213,2,5,0)
 ;;=   Insert/replace mode toggle      <PF3>  or  <Insert Here>  or  <Insert>
 ;;^UTILITY(U,$J,.84,9213,2,6,0)
 ;;=   Set/clear tab stop              <PF1><Tab>
 ;;^UTILITY(U,$J,.84,9213,2,7,0)
 ;;=   Enter columns for tab stops     <PF1><PF1><Tab>
 ;;^UTILITY(U,$J,.84,9213,2,8,0)
 ;;=   Set left margin                 <PF1>,
 ;;^UTILITY(U,$J,.84,9213,2,9,0)
 ;;=   Set right margin                <PF1>.
 ;;^UTILITY(U,$J,.84,9213,2,10,0)
 ;;=   Status line toggle              <PF1>?
 ;;^UTILITY(U,$J,.84,9213,2,11,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9213,2,12,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9213,2,13,0)
 ;;=\BFormatting\n
 ;;^UTILITY(U,$J,.84,9213,2,14,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9213,2,15,0)
 ;;=   Join current line to next line  <PF1>J
 ;;^UTILITY(U,$J,.84,9213,2,16,0)
 ;;=   Reformat paragraph              <PF1>R
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
 ;;=   Find text                       <PF1>F
 ;;^UTILITY(U,$J,.84,9214,2,6,0)
 ;;=   Find next occurence of text     <PF1>N
 ;;^UTILITY(U,$J,.84,9214,2,7,0)
 ;;=   Find/RePlace text               <PF1>P
 ;;^UTILITY(U,$J,.84,9214,2,8,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9214,2,9,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9214,2,10,0)
 ;;=\BCutting/Copying/Pasting\n
 ;;^UTILITY(U,$J,.84,9214,2,11,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9214,2,12,0)
 ;;=   Select (Mark) text              <PF1>M at beginning and end of text
 ;;^UTILITY(U,$J,.84,9214,2,13,0)
 ;;=   Unselect (Unmark) text          <PF1><PF1>M
 ;;^UTILITY(U,$J,.84,9214,2,14,0)
 ;;=   Delete selected text            <Delete>  or  <Backspace> on selected text
 ;;^UTILITY(U,$J,.84,9214,2,15,0)
 ;;=   Cut and save to buffer          <PF1>X on selected text
 ;;^UTILITY(U,$J,.84,9214,2,16,0)
 ;;=   Copy and save to buffer         <PF1>C on selected text
 ;;^UTILITY(U,$J,.84,9214,2,17,0)
 ;;=   Paste from buffer               <PF1>V
 ;;^UTILITY(U,$J,.84,9214,2,18,0)
 ;;=   Move text to another location   <PF1>X at new location
 ;;^UTILITY(U,$J,.84,9214,2,19,0)
 ;;=   Copy text to another location   <PF1>C at new location
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
 ;;=Move right one word                 <Ctrl-L> or <PF1><Space>
 ;;^UTILITY(U,$J,.84,9231,2,9,0)
 ;;=Move left one word                  <Ctrl-J>
 ;;^UTILITY(U,$J,.84,9231,2,10,0)
 ;;=Move to right of window             <PF1><Right>
 ;;^UTILITY(U,$J,.84,9231,2,11,0)
 ;;=Move to left of window              <PF1><Left>
 ;;^UTILITY(U,$J,.84,9231,2,12,0)
 ;;=Move to end of field                <PF1><PF1><Right>
 ;;^UTILITY(U,$J,.84,9231,2,13,0)
 ;;=Move to beginning of field          <PF1><PF1><Left>
 ;;^UTILITY(U,$J,.84,9231,2,14,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9231,2,15,0)
 ;;=\BModes\n
 ;;^UTILITY(U,$J,.84,9231,2,16,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9231,2,17,0)
 ;;=Insert/Replace toggle               <PF3>
 ;;^UTILITY(U,$J,.84,9231,2,18,0)
 ;;=Zoom (invoke multiline editor)      <PF1>Z
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
 ;;=Character under cursor           <PF2> or <Delete>
 ;;^UTILITY(U,$J,.84,9232,2,6,0)
 ;;=Character left of cursor         <Backspace>
 ;;^UTILITY(U,$J,.84,9232,2,7,0)
 ;;=From cursor to end of word       <Ctrl-W>
 ;;^UTILITY(U,$J,.84,9232,2,8,0)
 ;;=From cursor to end of field      <PF1><PF2>
 ;;^UTILITY(U,$J,.84,9232,2,9,0)
 ;;=Toggle null/last edit/default    <PF1>D or <Ctrl-U>
 ;;^UTILITY(U,$J,.84,9232,2,10,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9232,2,11,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9232,2,12,0)
 ;;=\BMacro Movement\n
 ;;^UTILITY(U,$J,.84,9232,2,13,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9232,2,14,0)
 ;;=Field below         <Down>    |   Next page           <PF1><Down> or <PageDown>
 ;;^UTILITY(U,$J,.84,9232,2,15,0)
 ;;=Field above         <Up>      |   Previous page       <PF1><Up> or <PageUp>
 ;;^UTILITY(U,$J,.84,9232,2,16,0)
 ;;=Field to right      <Tab>     |   Next block          <PF1><PF4>
 ;;^UTILITY(U,$J,.84,9232,2,17,0)
 ;;=Field to left       <PF4>     |   Jump to a field     ^caption
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

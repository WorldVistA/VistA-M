DINIT00S ; SFISC/TKW-DIALOG & LANGUAGE FILE INITS ;7:41 AM  6 Dec 2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**169,1044**
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,9202,2,5,0)
 ;;=selected, pressing the arrow right key causes the jump to occur. To return to
 ;;^UTILITY(U,$J,.84,9202,2,6,0)
 ;;=the previous jump location from the jump, press the arrow left key. On the
 ;;^UTILITY(U,$J,.84,9202,2,7,0)
 ;;=return, the selected hypertext represent the previous jump made.
 ;;^UTILITY(U,$J,.84,9202,2,8,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9202,2,9,0)
 ;;=To EXIT the VA FileMan Browser, in hypertext mode, press <F1> followed by the
 ;;^UTILITY(U,$J,.84,9202,2,10,0)
 ;;=letter 'E'. This is also true for this HELP document which is being presented
 ;;^UTILITY(U,$J,.84,9202,2,11,0)
 ;;=by the Browser, in hypertext mode. Pressing the letter 'R', returns the Browser
 ;;^UTILITY(U,$J,.84,9202,2,12,0)
 ;;=to the hypertext document.
 ;;^UTILITY(U,$J,.84,9202,2,13,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9202,2,14,0)
 ;;=For help, select, using TAB and press ARROW RIGHT to jump:
 ;;^UTILITY(U,$J,.84,9202,2,15,0)
 ;;=     * $.%#NAVIGATION^Navigation$.%
 ;;^UTILITY(U,$J,.84,9202,2,16,0)
 ;;=     * $.%#SEARCH^Search$.%
 ;;^UTILITY(U,$J,.84,9202,2,17,0)
 ;;=     * $.%#SCREEN^Screen$.%
 ;;^UTILITY(U,$J,.84,9202,2,18,0)
 ;;=     * $.%#CLIPBOARD^Clipboard$.%
 ;;^UTILITY(U,$J,.84,9202,2,19,0)
 ;;=     * $.%#HELP^Help$.%
 ;;^UTILITY(U,$J,.84,9202,2,20,0)
 ;;=     * $.%#EXIT^Exit$.%
 ;;^UTILITY(U,$J,.84,9202,2,21,0)
 ;;=     * $.%#MORE_HELP^More Help$.%
 ;;^UTILITY(U,$J,.84,9202,2,22,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9202,2,23,0)
 ;;=  ---------------------------------------------------------------------------
 ;;^UTILITY(U,$J,.84,9202,2,24,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9202,2,25,0)
 ;;=$.$NAVIGATION$.$NAVIGATION:
 ;;^UTILITY(U,$J,.84,9202,2,26,0)
 ;;============
 ;;^UTILITY(U,$J,.84,9202,2,27,0)
 ;;=Select hypertext, left to right and down     TAB
 ;;^UTILITY(U,$J,.84,9202,2,28,0)
 ;;=Select hypertext right to left and up        Q
 ;;^UTILITY(U,$J,.84,9202,2,29,0)
 ;;=Invoke hypertext jump, selected              ARROW RIGHT
 ;;^UTILITY(U,$J,.84,9202,2,30,0)
 ;;=Return from hypertext jump                   ARROW LEFT
 ;;^UTILITY(U,$J,.84,9202,2,31,0)
 ;;=Scroll Down (one line)                       ARROW DOWN
 ;;^UTILITY(U,$J,.84,9202,2,32,0)
 ;;=Scroll Up (one line)                         ARROW UP
 ;;^UTILITY(U,$J,.84,9202,2,33,0)
 ;;=Page Down                                    <F1>ARROW DOWN
 ;;^UTILITY(U,$J,.84,9202,2,34,0)
 ;;=Page Up                                      <F1>ARROW UP
 ;;^UTILITY(U,$J,.84,9202,2,35,0)
 ;;=Jump to the Top                              <F1>T
 ;;^UTILITY(U,$J,.84,9202,2,36,0)
 ;;=Jump to the Bottom                           <F1>B
 ;;^UTILITY(U,$J,.84,9202,2,37,0)
 ;;=Goto                                         <F1>G
 ;;^UTILITY(U,$J,.84,9202,2,38,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9202,2,39,0)
 ;;=$.$SEARCH$.$SEARCH:
 ;;^UTILITY(U,$J,.84,9202,2,40,0)
 ;;========
 ;;^UTILITY(U,$J,.84,9202,2,41,0)
 ;;=Find text                                    <F1>F
 ;;^UTILITY(U,$J,.84,9202,2,42,0)
 ;;=Next (occurrence)                            <F1>N
 ;;^UTILITY(U,$J,.84,9202,2,43,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9202,2,44,0)
 ;;=Direction-terminate find text with:
 ;;^UTILITY(U,$J,.84,9202,2,45,0)
 ;;=-----------------------------------
 ;;^UTILITY(U,$J,.84,9202,2,46,0)
 ;;=Down                                         ARROW DOWN
 ;;^UTILITY(U,$J,.84,9202,2,47,0)
 ;;=Up                                           ARROW UP
 ;;^UTILITY(U,$J,.84,9202,2,48,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9202,2,49,0)
 ;;=$.$SCREEN$.$SCREEN:
 ;;^UTILITY(U,$J,.84,9202,2,50,0)
 ;;========
 ;;^UTILITY(U,$J,.84,9202,2,51,0)
 ;;=Repaint screen                               <F1>P
 ;;^UTILITY(U,$J,.84,9202,2,52,0)
 ;;=Split screen                                 <F2>S
 ;;^UTILITY(U,$J,.84,9202,2,53,0)
 ;;=Restore Full screen                          <F2>F
 ;;^UTILITY(U,$J,.84,9202,2,54,0)
 ;;=Print document                               <F1><F1>P
 ;;^UTILITY(U,$J,.84,9202,2,55,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9202,2,56,0)
 ;;=Split Screen Mode Navigation:
 ;;^UTILITY(U,$J,.84,9202,2,57,0)
 ;;=-----------------------------
 ;;^UTILITY(U,$J,.84,9202,2,58,0)
 ;;=Navigate to bottom screen                    <F2>ARROW DOWN
 ;;^UTILITY(U,$J,.84,9202,2,59,0)
 ;;=Navigate to top screen                       <F2>ARROW UP
 ;;^UTILITY(U,$J,.84,9202,2,60,0)
 ;;=Resize Split Screen:
 ;;^UTILITY(U,$J,.84,9202,2,61,0)
 ;;=--------------------
 ;;^UTILITY(U,$J,.84,9202,2,62,0)
 ;;=Top/Bottom screen larger/smaller             <F2><F2>ARROW DOWN
 ;;^UTILITY(U,$J,.84,9202,2,63,0)
 ;;=Bottom/Top screen larger/smaller             <F2><F2>ARROW UP
 ;;^UTILITY(U,$J,.84,9202,2,64,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9202,2,65,0)
 ;;=$.$HELP$.$HELP:
 ;;^UTILITY(U,$J,.84,9202,2,66,0)
 ;;======
 ;;^UTILITY(U,$J,.84,9202,2,67,0)
 ;;=Browse Key Summary                           <F1>H
 ;;^UTILITY(U,$J,.84,9202,2,68,0)
 ;;=More Help                                    <F1><F1>H
 ;;^UTILITY(U,$J,.84,9202,2,69,0)
 ;;=Print Help                                   <F1><F1><F1>H
 ;;^UTILITY(U,$J,.84,9202,2,70,0)
 ;;=Return to hypertext document, from HELP      R
 ;;^UTILITY(U,$J,.84,9202,2,71,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9202,2,72,0)
 ;;=$.$CLIPBOARD$.$CLIPBOARD:
 ;;^UTILITY(U,$J,.84,9202,2,73,0)
 ;;===========
 ;;^UTILITY(U,$J,.84,9202,2,74,0)
 ;;=Copy to FileMan's Clipboard                  <F1>C
 ;;^UTILITY(U,$J,.84,9202,2,75,0)
 ;;=View FileMan's Clipboard                     <F1>V
 ;;^UTILITY(U,$J,.84,9202,2,76,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9202,2,77,0)
 ;;=$.$EXIT$.$EXIT:
 ;;^UTILITY(U,$J,.84,9202,2,78,0)
 ;;======
 ;;^UTILITY(U,$J,.84,9202,2,79,0)
 ;;=Exit Browser or help text                    <F1>E or "EXIT"
 ;;^UTILITY(U,$J,.84,9202,2,80,0)
 ;;=Quit                                         <F1>Q or <Ctrl-E>
 ;;^UTILITY(U,$J,.84,9202,2,81,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9202,2,82,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9202,2,83,0)
 ;;=  ---------------------------------------------------------------------------
 ;;^UTILITY(U,$J,.84,9202,2,84,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9202,2,85,0)
 ;;=$.$MORE_HELP$.$MORE HELP
 ;;^UTILITY(U,$J,.84,9202,2,86,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9202,2,87,0)
 ;;=To GOTO a specific screen or line press the <F1> key followed by the letter
 ;;^UTILITY(U,$J,.84,9202,2,88,0)
 ;;='G'. This will cause a prompt to be displayed where a screen or line number can
 ;;^UTILITY(U,$J,.84,9202,2,89,0)
 ;;=be entered preceded by an 'S' or 'L'. The default is screen, meaning that the

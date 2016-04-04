DINIT00P ; SFISC/TKW-DIALOG & LANGUAGE FILE INITS ; 11DEC2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**169,1044**
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,9117,3,1,0)
 ;;=1^The prefix for a variable pointer file.
 ;;^UTILITY(U,$J,.84,9117,3,2,0)
 ;;=2^The message for a variable pointer file.
 ;;^UTILITY(U,$J,.84,9201,0)
 ;;=9201^3^^5
 ;;^UTILITY(U,$J,.84,9201,1,0)
 ;;=^^1^1^2950511^^
 ;;^UTILITY(U,$J,.84,9201,1,1,0)
 ;;=Browser help
 ;;^UTILITY(U,$J,.84,9201,2,-1,"DATE")
 ;;=62796,32024
 ;;^UTILITY(U,$J,.84,9201,2,-1,"TITLE")
 ;;=9201
 ;;^UTILITY(U,$J,.84,9201,2,0)
 ;;=^^221^221^3121205^
 ;;^UTILITY(U,$J,.84,9201,2,1,0)
 ;;=
 ;;^UTILITY(U,$J,.84,9201,2,2,0)
 ;;=                                 HELP SUMMARY
 ;;^UTILITY(U,$J,.84,9201,2,3,0)
 ;;=                                 ============
 ;;^UTILITY(U,$J,.84,9201,2,4,0)
 ;;=
 ;;^UTILITY(U,$J,.84,9201,2,5,0)
 ;;=NAVIGATION:
 ;;^UTILITY(U,$J,.84,9201,2,6,0)
 ;;============
 ;;^UTILITY(U,$J,.84,9201,2,7,0)
 ;;=     Scroll Down (one line)                  ARROW DOWN
 ;;^UTILITY(U,$J,.84,9201,2,8,0)
 ;;=     Scroll Up (one line)                    ARROW UP
 ;;^UTILITY(U,$J,.84,9201,2,9,0)
 ;;=     Page Down                               <F1>ARROW DOWN
 ;;^UTILITY(U,$J,.84,9201,2,10,0)
 ;;=     Page Up                                 <F1>ARROW UP
 ;;^UTILITY(U,$J,.84,9201,2,11,0)
 ;;=     Scroll Right (default 22 columns)       ARROW RIGHT
 ;;^UTILITY(U,$J,.84,9201,2,12,0)
 ;;=     Scroll Left (default 22 columns)        ARROW LEFT
 ;;^UTILITY(U,$J,.84,9201,2,13,0)
 ;;=     Scroll Horizontally to the end          <F1>ARROW RIGHT
 ;;^UTILITY(U,$J,.84,9201,2,14,0)
 ;;=     Scroll Horizontally to the end          <F1>ARROW LEFT
 ;;^UTILITY(U,$J,.84,9201,2,15,0)
 ;;=     Jump to the Top                         <F1>T
 ;;^UTILITY(U,$J,.84,9201,2,16,0)
 ;;=     Jump to the Bottom                      <F1>B
 ;;^UTILITY(U,$J,.84,9201,2,17,0)
 ;;=     Goto                                    <F1>G
 ;;^UTILITY(U,$J,.84,9201,2,18,0)
 ;;=
 ;;^UTILITY(U,$J,.84,9201,2,19,0)
 ;;=SEARCH:
 ;;^UTILITY(U,$J,.84,9201,2,20,0)
 ;;========
 ;;^UTILITY(U,$J,.84,9201,2,21,0)
 ;;=     Find text                               <F1>F
 ;;^UTILITY(U,$J,.84,9201,2,22,0)
 ;;=     Next (occurrence)                       <F1>N
 ;;^UTILITY(U,$J,.84,9201,2,23,0)
 ;;=
 ;;^UTILITY(U,$J,.84,9201,2,24,0)
 ;;=     Direction-terminate find text with:
 ;;^UTILITY(U,$J,.84,9201,2,25,0)
 ;;=     -----------------------------------
 ;;^UTILITY(U,$J,.84,9201,2,26,0)
 ;;=     Down                                    ARROW DOWN
 ;;^UTILITY(U,$J,.84,9201,2,27,0)
 ;;=     Up                                      ARROW UP
 ;;^UTILITY(U,$J,.84,9201,2,28,0)
 ;;=
 ;;^UTILITY(U,$J,.84,9201,2,29,0)
 ;;=BRANCH:
 ;;^UTILITY(U,$J,.84,9201,2,30,0)
 ;;========
 ;;^UTILITY(U,$J,.84,9201,2,31,0)
 ;;=     Switch to another document              <F1>S
 ;;^UTILITY(U,$J,.84,9201,2,32,0)
 ;;=     Return to previous document(s)          R
 ;;^UTILITY(U,$J,.84,9201,2,33,0)
 ;;=
 ;;^UTILITY(U,$J,.84,9201,2,34,0)
 ;;=SCREEN:
 ;;^UTILITY(U,$J,.84,9201,2,35,0)
 ;;========
 ;;^UTILITY(U,$J,.84,9201,2,36,0)
 ;;=     Repaint screen                          <F1>P
 ;;^UTILITY(U,$J,.84,9201,2,37,0)
 ;;=     Print document                          <F1><F1>P
 ;;^UTILITY(U,$J,.84,9201,2,38,0)
 ;;=     Split screen                            <F2>S
 ;;^UTILITY(U,$J,.84,9201,2,39,0)
 ;;=     restore Full screen                     <F2>F
 ;;^UTILITY(U,$J,.84,9201,2,40,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9201,2,41,0)
 ;;=     Split Screen Mode Navigation:
 ;;^UTILITY(U,$J,.84,9201,2,42,0)
 ;;=     -----------------------------
 ;;^UTILITY(U,$J,.84,9201,2,43,0)
 ;;=     Navigate to bottom screen              <F2>ARROW DOWN
 ;;^UTILITY(U,$J,.84,9201,2,44,0)
 ;;=     Navigate to top screen                 <F2>ARROW UP
 ;;^UTILITY(U,$J,.84,9201,2,45,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9201,2,46,0)
 ;;=     Resize Split Screen:
 ;;^UTILITY(U,$J,.84,9201,2,47,0)
 ;;=     --------------------
 ;;^UTILITY(U,$J,.84,9201,2,48,0)
 ;;=     Top/Bottom screen larger/smaller       <F2><F2>ARROW DOWN
 ;;^UTILITY(U,$J,.84,9201,2,49,0)
 ;;=     Bottom/Top screen larger/smaller       <F2><F2>ARROW UP
 ;;^UTILITY(U,$J,.84,9201,2,50,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9201,2,51,0)
 ;;=CLIPBOARD:
 ;;^UTILITY(U,$J,.84,9201,2,52,0)
 ;;===========
 ;;^UTILITY(U,$J,.84,9201,2,53,0)
 ;;=     Copy to VA FileMan's Clipboard         <F1>C
 ;;^UTILITY(U,$J,.84,9201,2,54,0)
 ;;=     View VA FileMan's Clipboard            <F1>V
 ;;^UTILITY(U,$J,.84,9201,2,55,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9201,2,56,0)
 ;;=TITLE BAR:
 ;;^UTILITY(U,$J,.84,9201,2,57,0)
 ;;===========
 ;;^UTILITY(U,$J,.84,9201,2,58,0)
 ;;=     Change content of title bar,           <F1><F1>ARROW DOWN
 ;;^UTILITY(U,$J,.84,9201,2,59,0)
 ;;=     Or                                     <F1><F1>ARROW UP
 ;;^UTILITY(U,$J,.84,9201,2,60,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9201,2,61,0)
 ;;=HELP:
 ;;^UTILITY(U,$J,.84,9201,2,62,0)
 ;;======
 ;;^UTILITY(U,$J,.84,9201,2,63,0)
 ;;=     Browse Key Summary                     <F1>H
 ;;^UTILITY(U,$J,.84,9201,2,64,0)
 ;;=     More Help                              <F1><F1>H
 ;;^UTILITY(U,$J,.84,9201,2,65,0)
 ;;=     Print this help text                   <F1><F1><F1>H
 ;;^UTILITY(U,$J,.84,9201,2,66,0)
 ;;=     To Return to document from this help   R
 ;;^UTILITY(U,$J,.84,9201,2,67,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9201,2,68,0)
 ;;=EXIT:
 ;;^UTILITY(U,$J,.84,9201,2,69,0)
 ;;======
 ;;^UTILITY(U,$J,.84,9201,2,70,0)
 ;;=     Exit Browser or help text              <F1>E or "EXIT"
 ;;^UTILITY(U,$J,.84,9201,2,71,0)
 ;;=     Quit                                   <F1>Q or <Ctrl-E>
 ;;^UTILITY(U,$J,.84,9201,2,72,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9201,2,73,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9201,2,74,0)
 ;;=                                  MORE HELP
 ;;^UTILITY(U,$J,.84,9201,2,75,0)
 ;;=                                  =========
 ;;^UTILITY(U,$J,.84,9201,2,76,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9201,2,77,0)
 ;;=     To EXIT the VA FileMan Browser, press <F1> followed by the letter
 ;;^UTILITY(U,$J,.84,9201,2,78,0)
 ;;=     'E'.  This is also true for this HELP document which is being
 ;;^UTILITY(U,$J,.84,9201,2,79,0)
 ;;=     presented by the Browser.
 ;;^UTILITY(U,$J,.84,9201,2,80,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9201,2,81,0)
 ;;=     To SCROLL DOWN one line at a time, press the ARROW DOWN key.
 ;;^UTILITY(U,$J,.84,9201,2,82,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9201,2,83,0)
 ;;=     To SCROLL UP one line at a time, press the ARROW UP key.
 ;;^UTILITY(U,$J,.84,9201,2,84,0)
 ;;=

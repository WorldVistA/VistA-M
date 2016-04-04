DINIT00Q ; SFISC/TKW-DIALOG & LANGUAGE FILE INITS ;15JAN2013
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**169,1044**
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,9201,2,85,0)
 ;;=     To SCROLL RIGHT, press the ARROW RIGHT key.
 ;;^UTILITY(U,$J,.84,9201,2,86,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9201,2,87,0)
 ;;=     To SCROLL LEFT, press the ARROW LEFT key.
 ;;^UTILITY(U,$J,.84,9201,2,88,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9201,2,89,0)
 ;;=     Try pressing these keys at this time and observe the behavior. Get a
 ;;^UTILITY(U,$J,.84,9201,2,90,0)
 ;;=     feel for 'browsing' through a document.  Press the arrow down key a
 ;;^UTILITY(U,$J,.84,9201,2,91,0)
 ;;=     few times, then press the arrow up key.  Also notice that the 'Line>'
 ;;^UTILITY(U,$J,.84,9201,2,92,0)
 ;;=     and 'Screen>' indicator numbers are changing. To see more of this
 ;;^UTILITY(U,$J,.84,9201,2,93,0)
 ;;=     text keep pressing the ARROW DOWN key.  Now try the arrow right key,
 ;;^UTILITY(U,$J,.84,9201,2,94,0)
 ;;=     then the arrow left key.  Notice that the 'Col>' indicator number is
 ;;^UTILITY(U,$J,.84,9201,2,95,0)
 ;;=     also changing.  This shows what column the left most edge of the
 ;;^UTILITY(U,$J,.84,9201,2,96,0)
 ;;=     document is on.  As you can see, the VA FileMan Browser is like a
 ;;^UTILITY(U,$J,.84,9201,2,97,0)
 ;;=     window placed over a document. You are in control of this window
 ;;^UTILITY(U,$J,.84,9201,2,98,0)
 ;;=     which moves over the document by pressing the functional key
 ;;^UTILITY(U,$J,.84,9201,2,99,0)
 ;;=     sequences.  Here are a few more functions.
 ;;^UTILITY(U,$J,.84,9201,2,100,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9201,2,101,0)
 ;;=     To PAGE DOWN one screen at one time, press the NEXT SCREEN key, PAGE
 ;;^UTILITY(U,$J,.84,9201,2,102,0)
 ;;=     DOWN or F1 followed by the ARROW DOWN key, depending on what kind of
 ;;^UTILITY(U,$J,.84,9201,2,103,0)
 ;;=     CRT or workstation that is being used.
 ;;^UTILITY(U,$J,.84,9201,2,104,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9201,2,105,0)
 ;;=     To PAGE UP one screen at one time, press the PREV SCREEN key, PAGE UP
 ;;^UTILITY(U,$J,.84,9201,2,106,0)
 ;;=     or F1 followed by the ARROW UP key, depending on what kind of CRT or
 ;;^UTILITY(U,$J,.84,9201,2,107,0)
 ;;=     workstation that is being used.
 ;;^UTILITY(U,$J,.84,9201,2,108,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9201,2,109,0)
 ;;=     To return to the TOP, back to the beginning of the document, press
 ;;^UTILITY(U,$J,.84,9201,2,110,0)
 ;;=     the <F1> key followed by the letter 'T'.
 ;;^UTILITY(U,$J,.84,9201,2,111,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9201,2,112,0)
 ;;=     To go to the BOTTOM, end of the document, press the <F1> key
 ;;^UTILITY(U,$J,.84,9201,2,113,0)
 ;;=     followed by the letter 'B'.
 ;;^UTILITY(U,$J,.84,9201,2,114,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9201,2,115,0)
 ;;=     To GOTO a specific screen, line or column press the <F1> key
 ;;^UTILITY(U,$J,.84,9201,2,116,0)
 ;;=     followed by the letter 'G'.  This will cause a prompt to be displayed
 ;;^UTILITY(U,$J,.84,9201,2,117,0)
 ;;=     where a screen, line or column number can be entered preceded by a
 ;;^UTILITY(U,$J,.84,9201,2,118,0)
 ;;=     'S' , 'L' or 'C'.  The default is screen, meaning that the 'S' is
 ;;^UTILITY(U,$J,.84,9201,2,119,0)
 ;;=     optional when entering a screen number.  10 or S10 will go to screen
 ;;^UTILITY(U,$J,.84,9201,2,120,0)
 ;;=     10, if screen 10 is a valid screen.  L99 will go to line 99 and C33
 ;;^UTILITY(U,$J,.84,9201,2,121,0)
 ;;=     will go to column 33.
 ;;^UTILITY(U,$J,.84,9201,2,122,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9201,2,123,0)
 ;;=     To FIND a string of characters, on a line, press the <F1> key
 ;;^UTILITY(U,$J,.84,9201,2,124,0)
 ;;=     followed by the letter 'F' or 'FIND' key.  A prompt will appear where
 ;;^UTILITY(U,$J,.84,9201,2,125,0)
 ;;=     a search string of characters can be entered.  The Find facility will
 ;;^UTILITY(U,$J,.84,9201,2,126,0)
 ;;=     search the document and immediately stop when it finds a match and
 ;;^UTILITY(U,$J,.84,9201,2,127,0)
 ;;=     'Goto' the line/screen.  The matched text will be highlighted in
 ;;^UTILITY(U,$J,.84,9201,2,128,0)
 ;;=     reverse video, if available, so it can be found easily.  However, if
 ;;^UTILITY(U,$J,.84,9201,2,129,0)
 ;;=     a string contains two or more words, matching will only be done if
 ;;^UTILITY(U,$J,.84,9201,2,130,0)
 ;;=     the words are found on the same line.  The default direction of the
 ;;^UTILITY(U,$J,.84,9201,2,131,0)
 ;;=     search is down.  This can be controlled by using the ARROW UP or
 ;;^UTILITY(U,$J,.84,9201,2,132,0)
 ;;=     ARROW DOWN keys instead of the RETURN key to terminate the search
 ;;^UTILITY(U,$J,.84,9201,2,133,0)
 ;;=     string.
 ;;^UTILITY(U,$J,.84,9201,2,134,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9201,2,135,0)
 ;;=     To, NEXT FIND, find the next occurrence of the same search string,
 ;;^UTILITY(U,$J,.84,9201,2,136,0)
 ;;=     press the letter 'N' or <F1> followed by the letter 'N'. The FIND
 ;;^UTILITY(U,$J,.84,9201,2,137,0)
 ;;=     facility keeps track of the last find string including the direction
 ;;^UTILITY(U,$J,.84,9201,2,138,0)
 ;;=     and continues searching through the document and brings up the next
 ;;^UTILITY(U,$J,.84,9201,2,139,0)
 ;;=     screen.  If no match is found a message appears indicating this and
 ;;^UTILITY(U,$J,.84,9201,2,140,0)
 ;;=     the screen is repainted at it's original location.
 ;;^UTILITY(U,$J,.84,9201,2,141,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9201,2,142,0)
 ;;=     To rePAINT the screen, press the <F1> key followed by the letter
 ;;^UTILITY(U,$J,.84,9201,2,143,0)
 ;;=     'P'.
 ;;^UTILITY(U,$J,.84,9201,2,144,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9201,2,145,0)
 ;;=     To PRINT the current document, press <F1><F1> followed by the
 ;;^UTILITY(U,$J,.84,9201,2,146,0)
 ;;=     letter 'P'. You will be prompted whether to print a header on each
 ;;^UTILITY(U,$J,.84,9201,2,147,0)
 ;;=     page, whether to wrap the text at word bounaries, whether to
 ;;^UTILITY(U,$J,.84,9201,2,148,0)
 ;;=     interpret wp windows (|), and for a DEVICE to print to.
 ;;^UTILITY(U,$J,.84,9201,2,149,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9201,2,150,0)
 ;;=     To SWITCH to another document press the <F1> key followed by the
 ;;^UTILITY(U,$J,.84,9201,2,151,0)
 ;;=     letter 'S'.  This will allow the selection of another file, (wp)field
 ;;^UTILITY(U,$J,.84,9201,2,152,0)
 ;;=     and entry.  The document is put on an active list and Browse
 ;;^UTILITY(U,$J,.84,9201,2,153,0)
 ;;=     switches to the newly selected document.  Subsequent use of Switch
 ;;^UTILITY(U,$J,.84,9201,2,154,0)
 ;;=     will allow choosing from the active list if desired or branch to
 ;;^UTILITY(U,$J,.84,9201,2,155,0)
 ;;=     select file, (wp)field and entry prompts. This function CAN BE
 ;;^UTILITY(U,$J,.84,9201,2,156,0)
 ;;=     RESTRICTED depending on how the running application calls the Browser
 ;;^UTILITY(U,$J,.84,9201,2,157,0)
 ;;=     utility.
 ;;^UTILITY(U,$J,.84,9201,2,158,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9201,2,159,0)
 ;;=     To RETURN to the previous document after using Switch or Help, press

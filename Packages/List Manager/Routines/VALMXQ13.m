VALMXQ13 ; alb/mjk - XQORM5 for export with LM v1 ; 3/30/93
 ;;1;List Manager;;Aug 13, 1993
 ;
 ;
XQORM5 ; SLC/KCM - Menu Help ;10/10/89  14:02 ;
 ;;6.7;Sidewinder;;Jan 08, 1993
HELP1 ;From: XQORM4
 I $D(XQORM("?"))'[0 X XQORM("?") Q:X="?"
 W ! F J=1:1 S ORUSV=$T(HTX1+J) Q:ORUSV["ZZZZ"  W !,$P(ORUSV,";",3,99)
 W ! ;I $D(XQORM("?"))'[0 X XQORM("?")
 Q
HELP2 ;From: XQORM4
 F J=1:1 S ORUSV=$T(HTX2+J) Q:ORUSV["ZZZZ"  W !,$P(ORUSV,";",3,99)
 Q
HELP3 ;From: XQORM3
 W !!,"Enter a number or type another selection",!
 Q
HTX1 ;;Help Text for "?"
 ;;Enter selection(s) by typing the name(s), number(s), or abbreviation(s).
 ;;ZZZZ
HTX2 ;;Help Text for "??"
 ;;ALL items may be selected by typing "ALL".
 ;;
 ;;RANGES of items (if numbered consecutively) may be selected using the dash.
 ;;  For example, "2-5" selects the items numbered 2,3,4,5.
 ;;
 ;;EXCEPTIONS may be entered by preceding them with an minus.
 ;;  For example, "2-5,-4" selects the items numbered 2,3,5.
 ;;           or, "ALL,-THAT" selects all items except "THAT".
 ;;
 ;;PRE-SELECTION of items may be done by separating them with ";".
 ;;  For example, "THIS MENU SELECTION;NEXT MENU SELECTION;FINAL SELECTION"
 ;;  automatically steps through 3 successive menu selections.
 ;;
 ;;JUMP AND RETURN may be done by typing "^^item".
 ;;  For example, "^^ABC" jumps directly to ABC, allows interaction,
 ;;  then returns to the menu where you first typed "^^ABC".
 ;;ZZZZ

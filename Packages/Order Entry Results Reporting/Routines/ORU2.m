ORU2 ; slc/dcm - More OE/RR Utilities ;1/21/92  16:08
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**11**;Dec 17, 1997
 ;
FORMAT(TEXT,LENGTH) ; Formats text field
 N ORI,ORX
 F ORI=1:1:$L(TEXT,"|") S $P(TEXT,"|",ORI)=$$STRIP($P(TEXT,"|",ORI))
 S ORX="" F ORI=1:1:$L(TEXT,"|") S:$P(TEXT,"|",ORI)]"" ORX=ORX_$S(ORI=1:"",1:" -")_$P(TEXT,"|",ORI)
 S TEXT=ORX
 I $L(TEXT)>LENGTH S TEXT=$$WRAP(TEXT,LENGTH)
 Q TEXT
STRIP(TEXT) ; Strips white space from text
 N ORI,ORX
 S ORX="" F ORI=1:1:$L(TEXT," ") S:$A($P(TEXT," ",ORI))>0 ORX=ORX_$S(ORI=1:"",1:" ")_$P(TEXT," ",ORI)
 S TEXT=ORX
 Q TEXT
WRAP(TEXT,LENGTH) ; Breaks text string into substrings of length LENGTH
 N ORI,LINE,ORX,ORY
 S LINE=1,ORX(1)="",ORY=0
 F ORI=1:1:$L(TEXT," ") S:$L(ORX(LINE)_" "_$P(TEXT," ",ORI))>LENGTH LINE=LINE+1,ORY=0 S:'$D(ORX(LINE)) ORX(LINE)="" S ORX(LINE)=$G(ORX(LINE))_$S(ORY=0:"",1:" ")_$P(TEXT," ",ORI),ORY=1
 S TEXT="" F ORI=1:1:3 Q:$G(ORX(ORI))']""  S TEXT=TEXT_$S(ORI=1:"",1:"| ")_$G(ORX(ORI))
 Q TEXT
PATHLP(X) ; Writes executable help for Patient lookup
 N I,J,XQH,Y
 I X?1.2"?" W !!,"Enter selection(s) by typing the name(s) or number(s) (separated by commas)."
 I X?2"?" D
 . W !!,"ALL items (except those numbered above 900) may be selected by typing 'ALL'."
 . W !!,"RANGES of numbers may be entered using dashes."
 . W !?5,"For example:    2-5,7-9"
 . W !!,"EXCEPTIONS may be entered by preceding them with an apostrophe."
 . W !?5,"For example:    1-10,'9   or   1-10,'BRANDX"
 . W !,"(These select items 1 thru 10 except for 9 or BRANDX, respectively.)"
 . I $E($G(^%ZOSF("OS")),1,3)'="DSM" W !!,"HELP for advanced look-up features may be obtained by entering '???'."
 I X?3"?",($E($G(^%ZOSF("OS")),1,3)'="DSM") S XQH="OR PATIENT LOOKUP" D EN^XQH
 Q ""
PATHLP1(X) ; Writes executable help for Patient lookup
 N DIC,I,J,XQH,Y
 I X?1.2"?" S DIC=2,DIC(0)="M" D ^DIC
 I X?2"?",($E($G(^%ZOSF("OS")),1,3)'="DSM") D
 . W !!?1,"You may also enter User, Provider or Treating Specialty name to pick from",!?5,"corresponding patient lists."
 . W !!?1,"HELP for advanced look-up features may be obtained by entering '???'."
 I X?3"?",($E($G(^%ZOSF("OS")),1,3)'="DSM") S XQH="OR PATIENT LOOKUP" D EN^XQH
 Q ""

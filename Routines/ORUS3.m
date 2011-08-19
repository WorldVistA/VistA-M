ORUS3 ; slc/KCM - Help for Display Lists ;11/7/90  16:57
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
EN D HLP,ASK S Y=0 Q
HLP I $D(ORUS("H")) X ORUS("H") S Y=0 Q
 W !!,"Enter selection(s) by typing the name or ",$S($D(ORUS("M")):"abbreviation.",1:"number.")
 Q:X'["??"!(ORUS(0)["S")
 W !!,"ALL items (except those numbered above 900) may be selected by typing 'ALL'."
 I '$D(ORUS("M")) W !!,"RANGES of numbers may be entered using dashes.",!,?5,"For example:    2-5,7-9"
 W !!,"EXCEPTIONS may be entered by preceding them with an apostrophe."
 W !?5,"For example:    1-10,'9   or   1-10,'BRANDX",!,"(This selects items 1 thru 10 except for 9, or BRANDX.)"
 Q
ASK I ORUS(0)'["M" D DISP Q  ;W !!,"Display items" S %=1 D YN^DICN W ! D:%=1 DISP Q
 I ORUS(0)["M",X["??" W !!,"Redisplay items" S %=1 D YN^DICN W ! D
 . I %Y["?" W "ANSWER 'YES' OR 'NO'." D ASK Q
 . I %=1 D SHOW^ORUS Q
 Q
DISP S ORHL=0 F I=0:0 D MOVE^ORUS5,SHOW^ORUS Q:'ORMOR  D PGBRK1^ORUHDR Q:OREND

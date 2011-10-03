YSSRU1 ;DALISC/LJA - Seclusion/Restraint Utility Code ;08/13/93 11:21
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;
PWARN ;  Warn user of danger of editing pointer entries
 N EX,I,OPT,T,TXT
 ;
 ;  General warning
 W @IOF
 S TXT="HD" D DISPLAY
 S TXT="GWARN" D DISPLAY
 ;
 ;  Find option name
 QUIT:$G(XQY)'>0  ;->  Don't know which option it is...
 S DIC=19,DIQ="OPT",DIQ(0)="E",DA=+XQY,DR=1 D EN^DIQ1
 S OPT=$$UP^XLFSTR($G(OPT(19,+DA,1,"E")))
 S EX=$S(OPT["REASONS":"REAEX",OPT["CATEGORY":"CATEX",OPT["RELEASE":"RELEX",OPT["ALTERNATIVES":"ALTEX",OPT["CHECKLIST":"CHKEX",1:"")
 I EX']"" S TXT="HD" D DISPLAY QUIT  ;->
 ;
 ;  Specific example
 S TXT=EX W ! D DISPLAY
 S TXT="HD" D DISPLAY
 QUIT
 ;
HD ;
 ;;
 ;;          ---------------------------------------------------------
 ;;                     !!     W  A  R  N  I  N  G     !!
 ;;          ---------------------------------------------------------
 ;;
 ;
GWARN ;
 ;;  You may edit the name of the file entry, but do NOT change it's meaning!
 ;
REAEX ;  S/R Reasons example
 ;;  For example, "disrupting therapeutic milieu" can be changed to "disruption
 ;;  of therepeutic milieu".  However, "disrupting therapeutic milieu" should
 ;;  NOT be changed to "harm to family"!
 ;
CATEX ;  S/R Category example
 ;;  For example, "Velcro Restraints" can be changed to "VELCRO RESTRAINTS".
 ;;  However, "Velcro Restraints" should NOT be changed to "UNLOCKED SECLUSION"!
 ;
RELEX ;  S/R Release example
 ;;  For example, "DISRUPTING BEHAVIOR CEASED" can be changed to "DISRUPTING
 ;;  BEHAVIOR STOPPED".  However, "DISRUPTING BEHAVIOR CEASED" should NOT be
 ;;  changed to "CESSATION OF HARM TO OTHERS"!
 ;
ALTEX ;  S/R Alternatives example
 ;;  For example, "RELAXATION TECHNIQUES" can be changed to "RELAXATION
 ;;  METHODS".  However, "RELAXATION TECHNIQUES" should NOT be changed to
 ;;  "PROBLEM RESOLUTION"!
 ;
CHKEX ;  S/R Check list example
 ;;  For example, "BEATING ON DOOR" can be changed to "BEATING ON DOOR OR WALL". 
 ;;  However, "BEATING ON DOOR" should NOT be changed to "CURSING"!
 ;
DISPLAY ; Display text...
 QUIT:$G(TXT)']""  ;->
 N I,T F I=1:1 S T=$T(@TXT+I) Q:T'[";;"  S T=$P(T,";;",2,99) W !,T
 QUIT
 ;

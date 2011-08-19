IBDFU6 ;ALB/CJM - ENCOUNTER FORM - (utilities for data fields);3/29/93
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
FORMAT(ARY,WIDTH,LABEL) ;formats the word-processing field pointed to by @ARY into a column of width=WIDTH
 N LINE,W
 K ^UTILITY($J,"W"),DIWF
 S LINE=0,DIWL=1,DIWR=WIDTH
 I $D(LABEL) S X=$E(LABEL_" ",1,WIDTH) I X'="" D ^DIWP
 F  S LINE=$O(@ARY@(LINE)) Q:'LINE  S X=$G(@ARY@(LINE,0)) I X'="" D ^DIWP
 K X,DIWL,DIWR,DIWF
 Q

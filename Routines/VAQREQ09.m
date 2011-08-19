VAQREQ09 ;ALB/JFP - PDX, REQUEST PATIENT DATA, HELP MESSAGES;01MAR93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
EP ; -- Main entry point for the list processor
HLPDOM1 ; -- Displays options for call to domain
 W !!,"The network address of the site you are requesting/sending PDX"
 W !,"data (ie: BOSTON.VA.GOV).  The following prompt will repeat until"
 W !,"a <RET> is entered.  This will allow for multiple selection."
 W !!,"Options for Domain Prompt:",!
 W !," Enter Domain: domain name            ; selects domain"
 W !," Enter Domain: G.domain group name    ; selects domain group"
 W !," Enter Domain: -domain name           ; de-selects a domain"
 W !," Enter Domain: *L                     ; list selected domains"
 W !," Enter Domain: ^                      ; terminates without selection"
 W !," Enter Domain: return                 ; done with option"
 W !," Enter Domain: ?                      ; definition/list of input options"
 W !," Enter Domain: ??                     ; prompt to display domain or"
 W !,"                                        domain group"
 QUIT
 ;
HLPSEG1 ; -- Displays options for call to segment 
 W !!,"The name associated with the data being requested or received"
 W !,"(ie. RXOP Pharmacy Outpatient).  The user may enter the full"
 W !,"segment name or the mnemonic.  The following prompt will repeat"
 W !,"until a <RET> is entered. This allows for multiple selection."
 W !!,"Options for Segment Prompt:",!
 W !," Enter Segment: segment name            ; selects segment"
 W !," Enter Segment: G.segment group name    ; selects segment group"
 W !," Enter Segment: -segment name           ; de-selects a segment"
 W !," Enter Segment: *L                      ; list selected segments"
 W !," Enter Segment: ^                       ; terminates without selection"
 W !," Enter Segment: return                  ; done with option"
 W !," Enter Segment: ?                       ; list of input options"
 W !," Enter Segment: ??                      ; prompt to display segment or"
 W !,"                                          segment group"
 QUIT
 ;
HLPDOM2 ;  -- Displays the file of domains or domain groups
 W !!,"(1) - Domain",!,"(2) - Domain Group",!
 R "Select Display Option: ",X:DTIME  Q:X=""
 I X="^"  QUIT
 I X=1 D HLPD1  QUIT
 I X=2 D HLPD2  QUIT
 W "        ...invalid entry"
 K X
 QUIT
 ;
HLPD1 ; -- Displays domain
 S DIC="^DIC(4.2,"
 S DIC(0)="C"
 S D="B"
 D DQ^DICQ
 K DIC,D
 QUIT
 ;
HLPD2 ; -- Displays domain groups
 S DIC="^VAT(394.83,"
 S DIC(0)="CM"
 S D="B",DZ="??"
 D DQ^DICQ
 K DIC,D,DZ
 QUIT
 ;
HLPSEG2 ;  -- Displays the file of Segment or Segment groups(public) or private
 W !!,"(1) - Segment",!,"(2) - Segment group (public)",!,"(3) - Segment group (private)",!
 R "Select Display Option: ",X:DTIME  Q:X=""
 I X="^"  QUIT
 I X=1 D HLPG1  QUIT
 I X=2 D HLPG2  QUIT
 I X=3 D HLPG3  QUIT
 W "        ...invalid entry"
 K X
 QUIT
 ;
HLPG1 ; -- Displays Segments
 S DIC="^VAT(394.71,"
 S DIC(0)="C"
 S D="B"
 D DQ^DICQ
 K DIC,D
 QUIT
 ;
HLPG2 ; -- Displays public segment groups
 S DIC="^VAT(394.84,"
 S DIC("S")="I $P(^(0),U,2)=""1"""
 S DIC(0)="M"
 S D="B",DZ="??"
 D DQ^DICQ
 K DIC,D,DZ
 QUIT
 ;
HLPG3 ; -- Displays private segment groups
 S DIC="^VAT(394.84,"
 S DIC("S")="I $P(^(0),U,2)=""0""&($P(^(0),U,3)=DUZ)"
 S DIC(0)="M"
 S D="B",DZ="??"
 D DQ^DICQ
 K DIC,D,DZ
 QUIT
PAT ; -- Double question mark response for patient prompt
 W !!,"Enter patient in the format of (Last,first middle)."
 W !,"Please note a comma is required after last name"
 QUIT
 ;
END ; -- End of code
 QUIT

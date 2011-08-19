PXBHLPR ;ISL/JVS - ROUTINE NAMES FOR HELP MESSAGES ;6/17/03  10:29
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**124**;Aug 12, 1996
 ;
 ;
 ;
 Q
 ;  This routine contains the name of the routines in which
 ;the HELP frames and the PROMPTS ARE STORED.
 ;
 ;  The line tags are the PACK variable and the SUBJ variable
 ;combined together
 ;
 ; ~PIECE 1   - The body of the Introduction
 ; ~PIECE 2   - The body of the extended help
 ; ~PIECE 3   - The routine with the dir call for prompting
 ; ~PIECE 4   - The routines for gathering the selecion list 
 ;
EN1 ; -- The main entry point
 S PXBREC=""
 S PXBREC=$P($T(@PXBNOD),";;",2)
 ;
 Q
 ;
PXBSTP ;;INTRO^PXBHLP1~BODY^PXBHLP1~PROMPT^PXBHLP1~ROUTINE^PXBHLP1
PXBPRV ;;INTRO^PXBHLP2~BODY^PXBHLP2~PROMPT^PXBHLP2~ROUTINE^PXBHLP2
PXBORD ;;INTRO2^PXBHLP2~BODY^PXBHLP2~PROMPT^PXBHLP2~ROUTINE^PXBHLP2
PXBPOV ;;INTRO^PXBHLP3~BODY^PXBHLP3~PROMPT^PXBHLP3~ROUTINE^PXBHLP3
PXBCPT ;;INTRO^PXBHLP4~BODY^PXBHLP4~PROMPT^PXBHLP4~ROUTINE^PXBHLP4
 Q

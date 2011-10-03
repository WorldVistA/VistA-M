PSGLH ;BIR/CML3-LABEL HELP ;16 DEC 97 / 1:36 PM 
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ;
DTM ;
 W !!,"Only labels created after the date entered will be printed.",!!,"FUTURE DATES CANNOT BE ENTERED" Q
 ;
CHKM ;
 W !!,"Enter a 'Y' to print these labels now, or enter an 'N' to NOT print these labelsnow.  Enter an '^' to exit this option." Q
 ;
LM ;
 W !!?2,"Enter a 'Y'  if you will want these new labels at a later date.  Enter an 'N' if you will not want these new labels at a later date.  Enter an '^' to exit    this option now.  PLEASE NOTE - If you answer 'N' here, you will not be"
 W " prompted for these labels again, but you may still print them through this option." Q

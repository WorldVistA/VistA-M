YSD4DSM ;DALISC/LJA - Master DSM-IV Conversion Routine ;[ 07/13/94  2:37 PM ]
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;
 QUIT  ;->
 ; ---------------------- DSM Patient Data Conversion -------------------
 ;           Call CONVERT to start the DSM-IV Conversion process...
 ; ----------------------------------------------------------------------
CONVERT ;
 D CHECKENV^YSD4C000 QUIT:'YSD4OK  ;-> Call examines environment, and
 ;                                     establishes var's needed for
 ;                                     control of following process
 ;
 ;  Give user overall process instructions IF restarting
 I '$O(^YSD(627.99,0)) D INSTR^YSD4C001("OVERALL",0,2,2)
 ;
 S YSD4RS=0 ; restart switch
 ;
 ;  Let user stop process now IF restarting...
 I $O(^YSD(627.99,0)) D
 .  S YSD4RS=1
 .  D OUT^YSD4PRE0 ; Place out order message on all DSM options
 .  S YSD4DIRA="OK to restart conversion now"
 .  D OKCONT^YSD4C000(2)
 .  I 'YSD4OK D  Q
 .  .  D OUT^YSD4POST
 .  .  K YSD4RS
 ;
CTRL1 ;  YSD4POST calls here...  Independent calls allowed to CONVERT, above.
 ;  Tell them ^MR conversion is starting... Ask for OK
 I $$DO^YSD4C010("MRCONV") D
 .  D INSTR^YSD4C001("STARTMR",0,2,1)
 .  D CTRL^YSD40030 ;  Convert ^MR data here
 ;
 ;  Tell user ^GMR(121 conversion is starting... Ask for OK
 I $$DO^YSD4C010("GPNCONV") D
 .  D INSTR^YSD4C001("STARTGPN",0,1,1)
 .  D CTRL^YSD40050 ;  Convert ^GMR(121 data here
 ;
 ;  Tell user ^YSD(627.8, conversion is starting... Ask for OK
 I $$DO^YSD4C010("DRCONV") D
 .  D INSTR^YSD4C001("STARTDR",0,1,1)
 .  D CTRL^YSD40040 ;  Convert ^GMR(121 data here
 ;
 ;  Tell user that Conversion is completed...
 D INSTR^YSD4C001("PROCDONE",0,2)
 ;
 D ERRORS
 D:YSD4RS OUT^YSD4POST ; take out of order message off all DSM options
 K YSD4RS
 QUIT
 ;
ERRORS ;  Give user error information
 D REP^YSD4E010
 QUIT
 ;
REPORT ;  Give user statistics from conversion
 D STATS^YSD4E020
 QUIT
 ;
EOR ;YSD4DSM - Master DSM-IV Conversion Routine ;3/24/94 16:02

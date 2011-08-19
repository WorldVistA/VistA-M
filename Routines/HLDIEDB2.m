HLDIEDB2 ;CIOFO-O/LJA - Debug $$STORESCR Code ;1/9/04 @ 09:01
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13,1995
 ;
STORESCR(RTN,LOC,STORE) ; Called by Xecutable M code to set or "unset" (don't
 ; collect) data...
 ;
 ; Steps to add SCREEN logic below
 ; -------------------------------
 ; (1) Add M code that evaluates environment and optionally sets STORE.
 ; (2) Update NEWs at top of STORESCR
 ;
 ; Error Handling
 ; --------------
 ; What if your M code errors out?  You don't want the call to 
 ; FILE^HLDIE failing.  But, you do want to be notified about the
 ; error.  For this reason, error trapping has been added to this
 ; $$STORESCR API.
 ;
 ; In order to set up error handling, you must define in your M code
 ; the users who should receive an "error notification email message."
 ; Do this by defining the SENDUZ(DUZ)="" array, with one entry for
 ; each recipient of the message.
 ;
 ;
 ; >>> Step #2 - Update NEWS After M Code Creations <<<
 N SENDUZ
 ;
 I ^%ZOSF("OS")["DSM" N $ETRAP S $ET=""
 S X="ERR^HLDIEDB1",@^%ZOSF("TRAP")
 ;
 ; RTN = RTN~SUBRTN
 ; LOC = 1 if at top of FILE^HLDIE call
 ;     = 2 if at bottom of FILE^HLDIE call
 ; STORE = "",1,2 (see below)
 ;
 ; STORE can be set to the following value...
 ;
 ; "" - Don't store anything
 ;  1 - Store "select" data
 ;  2 - Store all data
 ;
 ; Warning!  The only acceptable action by this API is to change the
 ;           value of STORE.
 ;
 ; >>> Step #1 - M Code Starts Here <<<
 ;
 ; Create list of recipients of error notification message now!
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ; >>> M Code Ends Here <<<
 ;
 Q STORE
 ;
EOR ;HLDIEDB2 - Debug $$STORESCR Code ;1/9/04 @ 09:01

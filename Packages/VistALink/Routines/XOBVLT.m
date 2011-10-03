XOBVLT ;; mjk/alb - VistALink Tester  ; 07/27/2002  13:00
 ;;1.6;VistALink;;May 08, 2009;Build 15
 ;Per VHA directive 2004-038, this routine should not be modified.
 QUIT
 ;
 ; ----------------------------------------------------------
 ;                 XOB Remote Procedure Testers
 ; ----------------------------------------------------------
 ; 
PINGRP(XOBY) ; -- rpc: XOBV TEST PING
 SET XOBY="Ping Successful!"
 QUIT
 ;
STRRP(XOBY,XOBSTR) ; -- rpc: XOBV TEST STRING
 SET XOBY="Returned Input Value: "_XOBSTR
 QUIT
 ;
XMLRP(XOBY) ; -- rpc: XOBV TEST XML RESULTS
 ; -- send back XML node
 SET XOBY="<?xml version='1.0' encoding='utf-8' ?>"
 SET XOBY=XOBY_"<fruits>"
 SET XOBY=XOBY_"   <fruit color='yellow' >banana</fruit>"
 SET XOBY=XOBY_"   <fruit color='red' >apple</fruit>"
 SET XOBY=XOBY_"   <fruit color='orange' >orange</fruit>"
 SET XOBY=XOBY_"</fruits>"
 QUIT
 ;
LARRRP(XOBY,XOBARR) ; -- rpc: XOBV TEST LOCAL ARRAY
 NEW XOBX,XOBLINE
 SET XOBLINE=0
 SET XOBX="" FOR  SET XOBX=$ORDER(XOBARR(XOBX)) QUIT:XOBX=""  DO
 . SET XOBLINE=XOBLINE+1
 . SET XOBY(XOBLINE)=XOBX_" / "_XOBARR(XOBX)
 QUIT
 ;
MSUBS(XOBY,XOBARR) ; -- rpc: XOBV TEST MULTIPLE SUBSCRIPTS
 NEW XOBX,XOBLINE
 SET XOBLINE=0
 SET XOBX="" FOR  SET XOBX=$ORDER(XOBARR("FRUIT",XOBX)) QUIT:XOBX=""  DO
 . SET XOBLINE=XOBLINE+1
 . SET XOBY(XOBLINE)=XOBX_" / "_XOBARR("FRUIT",XOBX)
 QUIT
 ;
MARRAYS(XOBY,XOBARR,XOBARR2,XOBARR3) ; -- rpc: XOBV TEST MULT ARRAY PARAMS
 NEW XOBX,XOBLINE
 SET XOBLINE=0
 SET XOBX="" FOR  SET XOBX=$ORDER(XOBARR(XOBX)) QUIT:XOBX=""  DO 
 . SET XOBLINE=XOBLINE+1
 . SET XOBY(XOBLINE)=XOBLINE_" / "_XOBARR(XOBX)
 SET XOBX="" FOR  SET XOBX=$ORDER(XOBARR2(XOBX)) QUIT:XOBX=""  DO 
 . SET XOBLINE=XOBLINE+1
 . SET XOBY(XOBLINE)=XOBLINE_" / "_XOBARR2(XOBX)
 SET XOBX="" FOR  SET XOBX=$ORDER(XOBARR3(XOBX)) QUIT:XOBX=""  DO 
 . SET XOBLINE=XOBLINE+1
 . SET XOBY(XOBLINE)=XOBLINE_" / "_XOBARR3(XOBX)
 QUIT  ;
 ;
GARRRP(XOBY,XOBARR) ; -- rpc: XOBV TEST GLOBAL ARRAY
 SET XOBY=$NAME(^TMP("XOB VL TEST",$JOB))
 KILL @XOBY
 MERGE @XOBY=XOBARR
 QUIT
 ;
RPCRP(XOBY,XOBSTR) ; -- rpc: XOBV TEST RPC LIST
 ;
 ;-- List all RPC's starting with same string (i.e. namespace)
 ;
 ;  Input:
 ;    XOBSTR  -   string to look up (ex. "XOBV" will look up all RPCs starting with XOBV)
 ;
 ; Output:
 ;    XOBY    -   output array, passed by reference, defined as:
 ;                  XOBY(0)   contains either error message or header line
 ;                  XOBY(1-n) contains data line
 ;
 IF $LENGTH($GET(XOBSTR))=0 SET XOBY(0)="<no RPC prefix defined>" QUIT
 SET XOBY(0)="RPCs Starting with '"_XOBSTR_"'..."
 DO LIST^DIC(8994,"","","","",XOBSTR,XOBSTR,"","","","")
 SET XOBY(0)=XOBY(0)_" ("_+^TMP("DILIST",$JOB,0)_") entries found."
 MERGE XOBY=^TMP("DILIST",$JOB,1)
 KILL ^TMP("DILIST",$JOB),^TMP("DIERR",$JOB)
 QUIT
 ;
 ;
NOCNTXT(XOBY) ; -- rpc: XOB VL NOT IN CONTEXT TEST
 ; This code is not used.
 ; See REMOTE PROCEDURE file entry for description why.
 QUIT ""
 ;
WPRP(XOBY) ; -- rpc: XOBV TEST WORD PROCESSING
 NEW I,X
 FOR I=1:1 SET X=$PIECE($TEXT(GA+I),";;",2) QUIT:X="$$END$$"  SET XOBY(I)=X
 QUIT
 ;
GA ;; -- 'Gettysburg Address' text
 ;;==================
 ;;Gettysburg Address
 ;;==================
 ;;Four score and seven years ago our fathers brought forth, 
 ;;upon this continent, a new nation, conceived in liberty, 
 ;;and dedicated to the proposition that 'all men are 
 ;;created equal'. 
 ;; 
 ;;Now we are engaged in a great civil war, testing whether that 
 ;;nation, or any nation so conceived, and so dedicated, can long 
 ;;endure. We are met on a great battle field of that war. We come 
 ;;to dedicate a portion of it, as a final resting place for those 
 ;;who died here, that the nation might live. This we may, in all 
 ;;propriety do. But, in a larger sense, we can not dedicate -- we 
 ;;can not consecrate -- we can not hallow, this ground -- The brave 
 ;;men, living and dead, who struggled here, have hallowed it, far 
 ;;above our poor power to add or detract. The world will little 
 ;;note,nor long remember what we say here; while it can never 
 ;;forget what they did here."
 ;; 
 ;;It is rather for us, the living, we here be dedicated to the great 
 ;;task remaining before us -- that, from these honored dead we take 
 ;;increased devotion to that cause for which they here, gave the 
 ;;last full measure of devotion -- that we here highly resolve these 
 ;;dead shall not have died in vain; that the nation, shall have a 
 ;;new birth of freedom, and that government of the people by the 
 ;;people for the people, shall not perish from the earth.
 ;;$$END$$
 ;
GNODERP(XOBY,XOBSTR) ; -- rpc: XOBV TEST GLOBAL NODE
 SET XOBY=$NAME(^TMP("XOB VL TEST",$JOB))
 KILL @XOBY
 SET @XOBY="Returned Input Value: "_XOBSTR
 QUIT
 ;
EXTASCII(XOBY,XOBSTR) ; -- rpc: XOBV TEST EXTENDED ASCII
 ; return value (array): 
 ; XOBY(1): 0^XOBSTR if didn't get ASCII extended chars 128-255, 1^XOBSTR if did
 ; XOBY(128-255): ASCII value expected^ASCII value received
 ; 
 NEW XOBI,XOBCH,XOBPOS
 SET XOBY(1)="0^"_XOBSTR
 QUIT:$LENGTH(XOBSTR)'=123  ;(128-255, but 5 chars undefined)
 SET XOBY(1)="1^"_XOBSTR
 SET XOBPOS=1
 FOR XOBI=128,130:1:140,142,145:1:156,158:1:255 DO
 .SET XOBCH=$EXTRACT(XOBSTR,XOBPOS)
 .SET XOBY(XOBI)=XOBI_"^"_$ASCII(XOBCH)
 .SET:$ASCII(XOBCH)'=(XOBI) XOBY(1)="0^"_XOBSTR,XOBY(XOBI)=XOBY(XOBI)_"^PROBLEM"
 .SET XOBPOS=XOBPOS+1
 QUIT
 ;

HDISVS04 ;BPFO/JRP - PROCESS UUENCODED MESSAGE FOR LAB EXCEPTIONS;6/26/2007
 ;;1.0;HEALTH DATA & INFORMATICS;**7**;Feb 22, 2005;Build 33
 ;
LABXCPT(MSGARR,ERRARR) ;Main entry point for Lab exception messages
 ; Input : MSGARR - Array containing received message (closed root)
 ;           @MSGARR@(1..n,0) = Message text
 ;         ERRARR - Array to output errors in (closed root)
 ;Output : None
 ;         @ERRARR@(x) = Error text (if applicable)
 ; Notes : ERRARR is initialized (KILLed) on input
 ;
 NEW DECARR,FILENAME,PATH
 SET DECARR=$NAME(^TMP("HDISVS04",$JOB,"DECARR"))
 KILL @DECARR
 ;UUDecode attachment in received message
 DO DECODE^HDISVM04(MSGARR,DECARR,1,1)
 ;Nothing decoded
 IF ('$DATA(@DECARR)) DO  QUIT
 .SET @ERRARR@(1)="Unable to find attachment to UUDecode"
 .KILL @DECARR
 .QUIT
 ;Remember filename of attachment and remove from decoded array
 SET FILENAME=$GET(@DECARR@(0))
 KILL @DECARR@(0)
 ;Save file to disk - hard coded as FORUM's Anonymous directory
 SET PATH="USER$:[ANONYMOUS]"
 IF ('$$GTF^%ZISH(DECARR,($QLENGTH(DECARR)+1),PATH,FILENAME)) DO  QUIT
 .SET @ERRARR@(1)="Unable to store attached document to disk ("_PATH_")"
 .KILL @DECARR
 .QUIT
 ;Done
 KILL @DECARR
 QUIT
 ;
 ; === Code from here down was used when the received
 ; === data was a delimitted text file that was broken
 ; === down into a "grid" for hand-off to interface to
 ; === HWSC.  Left for reference purposes.  Removed
 ; === NEWing and instantiation of GRIDARR variable.
 ;
 ;  Break up into individual columns
 ;  SET ROW=0
 ;  FOR  SET ROW=+$ORDER(@DECARR@(ROW)) QUIT:('ROW)  DO
 ;  .DO PARSE^HDISVM05($NAME(@DECARR@(ROW)),$NAME(@GRIDARR@(ROW)),"|",1,245)
 ;  .QUIT
 ;  ;Done
 ;  KILL @DECARR,@GRIDARR
 ;  QUIT

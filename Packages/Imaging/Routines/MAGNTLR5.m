MAGNTLR5 ;WOIFO/NST - TeleReader Configuration utilities ; 11 Apr 2012 11:19 AM
 ;;3.0;IMAGING;**127**;Mar 19, 2002;Build 4231;Apr 01, 2013
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
 ;***** Get TIU Note Titles list
 ;
 ; RPC: MAG3 TELEREADER TIU TITLES LST
 ;
 ; .MAGRY   Reference to a local variable where the results are returned to.
 ; 
 ; Input Parameters
 ; ================
 ; N/A
 ; 
 ; Return Values
 ; =============
 ; A list with TIU NOTE TITLES for consult and clinical procedure classes
 ;
 ; if error
 ;  MAGRY(0) = 0 ^ Error message
 ; if success
 ;  MAGRY(0) = 1 ^ Number of records return
 ;  MAGRY(1..n) = IEN of TIU NOTE TITLE ^ Long description of TIU NOTE TITLE
 ;
 ; Notes
 ; =====
 ; Temporary global nodes ^TMP("MAGNTLR5",$J) is used by this procedure.
 ;
TIUTLST(MAGRY) ; RPC [MAG3 TELEREADER TIU TITLES LST]
 N $ETRAP,$ESTACK S $ETRAP="D AERRA^MAGGTERR"
 N TARR,CLASSNUM,FROM
 K ^TMP("MAGNTLR5",$J)
 S MAGRY=$NA(^TMP("MAGNTLR5",$J))
 ; Get TIU NOTE Consult titles
 D CNSLCLAS^TIUSRVD(.CLASSNUM) ; IA #2876
 D BUILDONE^MAGNTLR5(MAGRY,CLASSNUM)  ; append the TIU NOTE Consult titles
 ; Get TIU NOTE CP titles
 D CPCLASS^TIUCP(.CLASSNUM) ; IA #3568
 D BUILDONE^MAGNTLR5(MAGRY,CLASSNUM)  ; append the TIU NOTE CP titles
 Q
 ;
BUILDONE(MAGARR,CLASSNUM) ; Get all TIU NOTE TITLES per a TIU CLASS
 ; MAGARR = The name of the result array
 ; MAGARR(0)= current number of records in MAGARR
 ; MAGARR(n) = TIU NOTE TITLE IEN ^ Name of the Title  
 ; CLASSNUM = TIU CLASS IEN
 N CNT,TARR,FROM,DONE,I
 S FROM=""
 S DONE=0
 S CNT=$P($G(@MAGARR@(0),0),"^",2)
 F  Q:DONE  D
 . K TARR
 . D LONGLIST^TIUSRVD(.TARR,CLASSNUM,FROM,1) ; IA #2876
 . ; TARR(n)="647^OPHTHALMOLOGY  <CP OPHTHALMOLOGY NOTE>" 
 . I '$D(TARR) S DONE=1 Q  ; No more titles
 . S I=0
 . F  S I=$O(TARR(I)) Q:I=""  D
 . . S CNT=CNT+1
 . . S @MAGARR@(CNT)=TARR(I)
 . . Q
 . S FROM=$P(@MAGARR@(CNT),U,2)
 . Q
 S @MAGARR@(0)=1_"^"_CNT
 Q

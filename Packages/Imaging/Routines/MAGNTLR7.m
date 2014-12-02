MAGNTLR7 ;WOIFO/NST - TeleReader Configuration utilities ; 30 Apr 2012 11:19 AM
 ;;3.0;IMAGING;**138**;Mar 19, 2002;Build 5380;Sep 03, 2013
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
 ;***** Get CPT Codes list by searching CPT Code description 
 ;
 ; RPC: MAG3 TELEREADER CPT CODELOOKUP
 ;
 ; .MAGRY   Reference to a local variable where the results are returned to.
 ; 
 ; Input Parameters
 ; ================
 ; MAGFIND = Look up CPT code description value 
 ; 
 ; Return Values
 ; =============
 ; A list with CPT CODES for consult or procedure request.
 ;
 ; if error
 ;  MAGRY(0) = 0 ^ Error message
 ; if success
 ;  MAGRY(0) = 1 ^ Number of records return
 ;  MAGRY(1..n) = CPT CODE IEN^ CPT CODE ^ Description
 ;
 ; Notes
 ; =====
 ; Temporary global nodes  ^TMP("LEXFND",$J),^TMP("LEXHIT",$J),^TMP("LEXSCH",$J),^TMP("LEXLE",$J)
 ; are used by this procedure.
 ;
CPTFIND(LST,MAGFIND) ; RPC [MAG3 TELEREADER CPT CODELOOKUP]
 N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 ; Borrowed from LEX^ORWPCE
 N X,APP,ORDATE  ; Parameters in LEX^ORWPCE 
 N LEX,DIC
 S X=MAGFIND
 S APP="CHP"
 K LST
 ;
 S:APP="CPT" APP="CHP" ; LEX PATCH 10
 S:'+$G(ORDATE) ORDATE=DT
 D CONFIG^LEXSET(APP,APP,ORDATE)  ;DBIA 1609
 I APP="CHP" D
 . ; Set the filter for CPT only using CS APIs - format is the same as for DIC("S")
 . S ^TMP("LEXSCH",$J,"FIL",0)="I $L($$CPTONE^LEXU(+Y,$G(ORDATE)))!($L($$CPCONE^LEXU(+Y,$G(ORDATE))))"  ;DBIA 1609
 . ; Set Applications Default Flag (Lexicon can not overwrite filter)
 . S ^TMP("LEXSCH",$J,"ADF",0)=1
 D LOOK^LEXA(X,APP,1,"",ORDATE)  ;DBIA 2950
 I '$D(LEX("LIST",1)) D  QUIT
 . D LEXX
 . S LST(0)="0^No matches found."
 D LIST(.LEX)  ; prepare the result
 D LEXX  ; Clean up temp globals
 Q
 ;
LIST(LEX)  ; Generate the list
 N CPTCODE,CPTIEN
 N ILST,I,IEN
 ;
 S ILST=0
 S IEN=$P(LEX("LIST",1),U)
 S CPTCODE=$$CPTONE^LEXU(IEN,ORDATE)  ;DBIA 1573
 I CPTCODE'="" D
 . S CPTIEN=$P($$CPT^ICPTCOD(CPTCODE),U) ;IA # 1995, supported reference
 . S:CPTIEN>0 ILST=ILST+1,LST(ILST)=CPTIEN_U_CPTCODE_U_$P(LEX("LIST",1),U,2)
 . Q
 ;
 S (I,IEN)=""
 F  S I=$O(^TMP("LEXFND",$J,I)) Q:I=""  D  ;DBIA 2950
 . F  S IEN=$O(^TMP("LEXFND",$J,I,IEN)) Q:IEN=""  D
 . . S CPTCODE=$$CPTONE^LEXU(IEN,ORDATE)  ; IA 1573
 . . Q:CPTCODE=""
 . . S CPTIEN=$P($$CPT^ICPTCOD(CPTCODE),U) ; IA # 1995, supported reference
 . . Q:CPTIEN'>0
 . . S ILST=ILST+1,LST(ILST)=CPTIEN_U_CPTCODE_U_^TMP("LEXFND",$J,I,IEN)
 S LST(0)=1_"^"_ILST
 Q
 ;
LEXX ; Clean up temp globals
 K ^TMP("LEXFND",$J),^TMP("LEXHIT",$J),^TMP("LEXSCH",$J),^TMP("LEXLE",$J)
 Q

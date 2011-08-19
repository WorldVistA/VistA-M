TIUPUTC1 ; SLC/JER - Document filer Cont'd - captioned header ;27-SEP-1999 12:28:28
 ;;1.0;TEXT INTEGRATION UTILITIES;**81**;Jun 20, 1997
 ;
GETREC(HEADER,RECORD,TIUHDR) ; ---- Look-up/create record (if LAYGO allowed)
 N DIC,DLAYGO,TIUD1,TIUD4,TIUKEY,X,Y
 I '$D(ZTQUEUED) W !!,">>> HEADER IDENTIFIED:",!,HEADER
 S X=$$STRIP^TIULS($P(HEADER,":",2)),Y=$$WHATYPE^TIUPUTU(X)
 I +Y'>0 D MAIN^TIUPEVNT(DA,1,3,X) D  Q
 . W:'$D(ZTQUEUED) !!,"INVALID DOCUMENT TYPE ",X,".",!
 . S ^TMP("TIUPUTC",$J,"FAIL")=+$G(^TMP("TIUPUTC",$J,"FAIL"))+1
 S TIUD1=$G(^TIU(8925.1,+Y,1)),TIUD4=$G(^TIU(8925.1,+Y,4))
 S RECORD("TYPE")=+Y,RECORD("FILE")=$P(TIUD1,U)
 S RECORD("BOILON")=$P(TIUD1,U,4)
 I RECORD("FILE")']"" D MAIN^TIUPEVNT(DA,1,4,X) D  Q
 . W:'$D(ZTQUEUED) !!,"TARGET FILE NOT DEFINED FOR ",X,".",!
 . S ^TMP("TIUPUTC",$J,"FAIL")=+$G(^TMP("TIUPUTC",$J,"FAIL"))+1
 S RECORD("ROOT")=$G(^DIC(+RECORD("FILE"),0,"GL"))
 I $P(TIUD1,U,3)']"" D MAIN^TIUPEVNT(DA,1,5,X) D  Q
 . W:'$D(ZTQUEUED) !!,"TEXT FIELD NOT DEFINED FOR ",X,".",!
 . S ^TMP("TIUPUTC",$J,"FAIL")=+$G(^TMP("TIUPUTC",$J,"FAIL"))+1
 I $P(TIUD1,U,3)]"" D
 . ; ---- Get subscript of target file TEXT field
 . S RECORD("TEXT")=$P($P(TIUD1,U,3),";",2)
 . I RECORD("TEXT")]"",'+RECORD("TEXT") S RECORD("TEXT")=""""_RECORD("TEXT")_""""
 F  D  Q:TIULINE[TIUBGN!(+TIUI'>0)
 . N TIUNOD,TIUCAP,TIUVAR,TIUFIELD,TIUREQ S TIUREQ=0
 . ; ---- Reset TIUI and Write out transferred header info:
 . S TIUI=$O(^TIU(8925.2,+DA,"TEXT",TIUI)) Q:+TIUI'>0
 . S TIULINE=$G(^TIU(8925.2,+DA,"TEXT",TIUI,0)) Q:TIULINE[TIUBGN
 . I '$D(ZTQUEUED) W !,TIULINE
 . ; ---- Check for field number, required missing fields:
 . S TIUCAP=$P(TIULINE,":") Q:TIUCAP']""
 . S TIUNOD=$O(^TIU(8925.1,+RECORD("TYPE"),"HEAD","B",TIUCAP,0)) Q:+TIUNOD'>0
 . S TIUFIELD=$P(^TIU(8925.1,+RECORD("TYPE"),"HEAD",+TIUNOD,0),U,3)
 . I TIUFIELD']"" W:'$D(ZTQUEUED) !,"Field Number NOT SPECIFIED for ",TIUCAP Q
 . S TIUREQ=$P(^TIU(8925.1,+RECORD("TYPE"),"HEAD",+TIUNOD,0),U,7)
 . S TIUHDR(TIUFIELD)=$$STRIP^TIULS($P(TIULINE,":",2,99))
 . I +TIUREQ,TIUHDR(TIUFIELD)="" S TIUHDR(TIUFIELD)="** REQUIRED FIELD MISSING FROM UPLOAD **"
 . ; ---- Get local lookup variables for document type:
 . S TIUVAR=$P(^TIU(8925.1,+RECORD("TYPE"),"HEAD",+TIUNOD,0),U,4) Q:TIUVAR']""
 . S TIUHDR(TIUVAR)=$$STRIP^TIULS($P(TIULINE,":",2,99))
 I '$D(ZTQUEUED) W !,TIUBGN,!
 S:+$P(TIUD1,U,2) DLAYGO=RECORD("FILE")
 ; ---- If a LOOKUP METHOD is defined for a given document type,
 ;      then set lookup variables and call it:
 I $G(TIUD4)]"" D  Q
 . N TIUJ,TIUVAR,TIUNOD S TIUVAR="A"
 . F  S TIUVAR=$O(TIUHDR(TIUVAR)) Q:TIUVAR=""  D
 . . S TIUJ=+$G(TIUJ)+1,TIUVAR(TIUJ)=TIUVAR
 . . S @TIUVAR=TIUHDR(TIUVAR)
 . X TIUD4 S RECORD("#")=+Y
 . I +Y'>0 D
 . . ; ---- If lookup fails, log 8925.4 error w/ hdr info.  Create new
 . . ;      8925.2 buffer entry with hdr, text, & 8925.4 log #.
 . . ;      Kill most of old buffer. Send file error alerts:
 . . D MAIN^TIUPEVNT(DA,1,6,$P($G(^TIU(8925.1,+RECORD("TYPE"),0)),U))
 . . ;W:'$D(ZTQUEUED) !!,"LOOK-UP FAILED FOR ",X,".",!
 . . S ^TMP("TIUPUTC",$J,"FAIL")=+$G(^TMP("TIUPUTC",$J,"FAIL"))+1
 . ; ---- Kill local lookup variables:
 . S TIUJ=0 F  S TIUJ=$O(TIUVAR(TIUJ)) Q:+TIUJ'>0  K @TIUVAR(TIUJ)
 ; Otherwise set-up for ^DIC call
 S DIC=RECORD("FILE"),DIC(0)="MX"
 S:+$P(TIUD1,U,2) DIC(0)=DIC(0)_"L"
 S:+$G(TIUHDR(.001)) DIC(0)=DIC(0)_"N"
 S TIUKEY=$S(+$G(TIUHDR(.001)):+$G(TIUHDR(.001)),1:$G(TIUHDR(.01)))
 S X=$S(DIC(0)["N":"`",1:"")_TIUKEY D ^DIC
 S RECORD("#")=+Y
 I +Y'>0 D
 . D MAIN^TIUPEVNT(DA,1,6,$P($G(^TIU(8925.1,+RECORD("TYPE"),0)),U))
 . ;W:'$D(ZTQUEUED) !!,"LOOK-UP FAILED FOR ",X,".",!
 . S ^TMP("TIUPUTC",$J,"FAIL")=+$G(^TMP("TIUPUTC",$J,"FAIL"))+1
 Q
 ;

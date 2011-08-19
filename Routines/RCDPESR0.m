RCDPESR0 ;ALB/TMK - Server auto-update utilities - EDI Lockbox ;06/03/02
 ;;4.5;Accounts Receivable;**173,208**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ; IA for read access to ^IBM(361.1 = 4051
 ;
DISP(RCMIN,RCMOUT,RCFMT,RCFULL,RCW,RC3444) ; Format the 835 return msg
 ; RCMIN = the name of the array that contains the raw message data
 ;         The data is contained at the next level and the subscript is
 ;         numeric and greater than 0 or the data can be at the
 ;         0-node subsequent to the final subscript.
 ;         If the message array is a global ^TMP($J,"MSG",n), RCMIN
 ;         will equal "^TMP($J,""MSG"")" and the message text will be
 ;         in ^TMP($J,"MSG",1), ^TMP($J,"MSG",2), etc.  OR
 ;         the message text can be defined at TMP($J,"MSG",1,0) ^...,2,0)
 ;         etc.
 ; RCMOUT = the name of the array that should be returned.  This array
 ;          will follow the same convention as the input array.  The
 ;          array will be returned with a numeric final subscript.  If
 ;          RCMOUT is passed as "^TMP($J,""MSG1"")", then the display
 ;          lines will be returned in ^TMP($J,"MSG1",1),
 ;          ^TMP($J,"MSG1",2), etc.  Note the array RCMOUT is killed
 ;          on entry to this call
 ; RCFMT = 0 or null if call should return raw data, 1 to execute the
 ;         transforms attached to the fields
 ; RCFULL = the name of an array if the data should be returned in
 ;          this array, formatted into lines for display.  If not sent,
 ;          only the display data by element is returned in RCMOUT.  If
 ;          RCFULL is sent, the array is killed before populating it
 ; RCW = max # of characters per line to return in array RCFULL
 ; RC3444 = flag that indicates only return bill data, not header data
 ;
 N Z,Z0,Z1,RC,RCCT,RCREF,RCDATA,RCQ,R
 S RCCT=0,RCREF="" K @RCMOUT
 S Z=0 F  S Z=$O(@RCMIN@(Z)) Q:'Z  S Z0=$S($G(@RCMIN@(Z))'="":@RCMIN@(Z),1:$G(@RCMIN@(Z,0))) I Z0'="" S RCQ=0 D
 . F Z1=1:1:$L(Z0,U) I $P(Z0,U,Z1)'="" D  Q:RCQ
 .. S RCDATA=$P(Z0,U,Z1)
 .. I Z1=1 D  Q:RCQ
 ... S RC=""
 ... I RCDATA'="",RCDATA?.N.A D
 .... S RCREF=$S($E(RCDATA,1,3)'="835":$E(RCDATA,1,8),1:"835"),R=RCREF_"^RCDPESR9",RC=$P($T(@R),";;",2)
 ... I RC="" S RCCT=RCCT+1,@RCMOUT@(RCCT)="<<<INVALID LINE TYPE - RAW DATA IS:",RCCT=RCCT+1,@RCMOUT@(RCCT)=Z0,RCDATA=""
 .. Q:RCDATA=""!(RCREF="")!$S(RCREF="835":$G(RC3444),1:0)
 .. S RC=""
 .. I RCREF?.A.N D
 ... S R=RCREF_"+"_Z1_"^RCDPESR9",RC=$P($T(@R),";;",2)
 .. I RC=""!($P(RC,U)'=RCREF) S:$S(RCDATA'="":1,1:'$P(RC,U,2)) RCCT=RCCT+1,@RCMOUT@(RCCT)="NO DATA DEFINITION PC "_Z1_": "_RCDATA Q
 .. I RC'="" D
 ... N X,X1,Y
 ... S X1=$P(RC,U,4,99)
 ... I $G(RCFMT),X1'="" S X=RCDATA X X1 S RCDATA=Y ; Output transform
 ... Q:RCDATA=""&($P(RC,U,2))  ; Don't output if null data
 ... S RC=$P(RC,U,3)
 ... S RCCT=RCCT+1,@RCMOUT@(RCCT)=$S(Z1=1:"<<<",1:"")_RC_": "_RCDATA_$S(Z1=1:">>>",1:"")
 I $G(RCFULL)'="" D FMTDSP(RCMOUT,RCFULL,$G(RCW),$G(RC3444))
 Q
 ;
FMTDSP(RCMUN,RCMFO,RCW,RCNOH05) ; Format the display data in array named in
 ; RCMUN into lines up to RCW characters wide  RCMUN must be set up the
 ; same as the output of the DISP call above
 ; Returns array named in RCMFO with the last subscript being the line #
 ; Note @RCMFO is killed on entry to this call
 ; Default is 80 if RCW=0 or null
 ; RCNOH05 = flag that if =1, suppresses the '05' header
 ;
 N Z,RCLINE,RCCT,RCCT1,RCMID,RCD,RCSTART,RCLINE,RCDASH
 K @RCMFO
 S:'$G(RCW) RCW=80
 S RCDASH=" "_$TR($J("",RCW-2)," ","-")
 S (RCCT,RCCT1)=0,RCLINE="",RCMID=RCW\2-1
 S Z=0 F  S Z=$O(@RCMUN@(Z)) Q:'Z  S RCD=$G(@RCMUN@(Z)) D
 . I $E(RCD,1,3)="<<<" D  Q  ; New line needed ... record start
 .. I $L(RCLINE)>0 S RCCT=RCCT+1,@RCMFO@(RCCT)=RCLINE,RCLINE=""
 .. I $L(RCLINE)=0 D
 ... I Z>1 S RCCT=RCCT+1,@RCMFO@(RCCT)=" "
 ... I RCD["<<<Line Type: 05 ",'$G(RCNOH05) S RCCT1=RCCT1+1,RCCT=RCCT+1,@RCMFO@(RCCT)=RCDASH,RCCT=RCCT+1,@RCMFO@(RCCT)="****** ERA DETAIL START ******",RCCT=RCCT+1,@RCMFO@(RCCT)=RCDASH
 ... I $L(RCD)>RCW D  Q
 .... S RCSTART=1
 .... F  S RCCT=RCCT+1,@RCMFO@(RCCT)=$E(RCD,RCSTART,RCSTART+RCW-1),RCSTART=RCSTART+RCW Q:RCSTART>$L(RCD)
 ... S RCCT=RCCT+1,@RCMFO@(RCCT)=RCD
 . ;
 . I $L(RCD)>RCW D  Q  ; Split line if greater than width given
 .. I $L(RCLINE) S RCCT=RCCT+1,@RCMFO@(RCCT)=RCLINE
 .. S RCSTART=1
 .. F  S RCCT=RCCT+1,@RCMFO@(RCCT)=$E(RCD,RCSTART,RCSTART+RCW-1),RCSTART=RCSTART+RCW Q:RCSTART>$L(RCD)
 .. S RCLINE=""
 . I $L(RCLINE)=0 D  Q  ; Format left side of line
 .. S RCLINE=RCD
 .. ;
 .. I $L(RCLINE)>RCMID S RCCT=RCCT+1,@RCMFO@(RCCT)=RCLINE,RCLINE=""
 . ;
 . I (RCMID+$L(RCD)+1)>RCW D  Q  ; data too long for right side of line
 .. S RCCT=RCCT+1,@RCMFO@(RCCT)=RCLINE,RCLINE=""
 . S RCLINE=$E(RCLINE_$J("",RCMID),1,RCMID)_"  "_RCD,RCCT=RCCT+1,@RCMFO@(RCCT)=RCLINE,RCLINE=""
 I $L(RCLINE) S RCCT=RCCT+1,@RCMFO@(RCCT)=RCLINE
 Q
 ;
BULLERA(RC,RCTDA,RCXMG,RCSUBJ,RCERR,RCTYP) ; Send a bulletin for entries in 344.5
 ; RC = flags for data to include (one or more can can be used)
 ;   'D': display text   'R': raw data    'F': formatted data from raw
 ;        data in file 344.5
 ; RCTDA = ien of the entry in file 344.5
 ; RCXMG = mail msg # for the ERA
 ; RCSUBJ = subject of the bulletin 
 ; RCERR = error text in array or name of error global
 ; RCTYP = if 0:ERA  1:EEOB
 ;
 N XMBODY,XMB,XMINSTR,XMTYPE,XMFULL,XMTO,XMZ,XMERR,Z,Z0,CT,RCXM,RCVAR
 K ^TMP("RCXM_344.5",$J)
 S RCERR=$G(RCERR)
 S RCVAR=$S($E(RCERR,1,5)="^TMP(":RCERR,1:"RCERR")
 S XMTO("I:G.RCDPE PAYMENTS EXCEPTIONS")="",CT=0,RCTYP=$S('$G(RCTYP):"ERA",1:"EEOB")
 S CT=CT+1,^TMP("RCXM_344.5",$J,CT)="The following electronic "_RCTYP_" was received at your site.",CT=CT+1,^TMP("RCXM_344.5",$J,CT)="It was received on: "_$$FMTE^XLFDT($$NOW^XLFDT(),2)_" in mail msg # "_RCXMG_"."
 S CT=CT+1,^TMP("RCXM_344.5",$J,CT)="This message is sent to alert you to conditions regarding this "_RCTYP_".",CT=CT+1,^TMP("RCXM_344.5",$J,CT)=" "
 I RC["D" D DTXT(RCTDA,.RCXM,.CT) M ^TMP("RCXM_344.5",$J)=RCXM K RCXM
 S Z=0 F  S Z=$O(@RCVAR@(Z)) Q:'Z  I $D(@RCVAR@(Z,"*")) S CT=CT+1,^TMP("RCXM_344.5",$J,CT)=@RCVAR@(Z,"*")
 I $G(RCERR)'="",RCVAR="RCERR" S CT=CT+1,^TMP("RCXM_344.5",$J,CT)=RCERR,CT=CT+1,^TMP("RCXM_344.5",$J,CT)=" "
 I $O(@RCVAR@(""))'="" D
 . S Z="" F  S Z=$O(@RCVAR@(Z)) Q:Z=""  D
 .. I $G(@RCVAR@(Z))'="" S CT=CT+1,^TMP("RCXM_344.5",$J,CT)=@RCVAR@(Z)
 .. I $O(@RCVAR@(Z,0)) S Z0="" F  S Z0=$O(@RCVAR@(Z,Z0)) Q:Z0=""  I Z0'="*" S CT=CT+1,^TMP("RCXM_344.5",$J,CT)=@RCVAR@(Z,Z0)
 I RC["F" D
 . N RCCT1
 . S RCCT1=0
 . K ^TMP($J,"PRCAZ_RAW"),^TMP($J,"PRCAZ_FMT1"),^TMP($J,"PRCAZ_FMT")
 . D DISP("^RCY(344.5,"_RCTDA_",2)","^TMP($J,""PRCAZ_FMT1"")",1,"^TMP($J,""PRCAZ_FMT"")",75)
 . S CT=CT+1,^TMP("RCXM_344.5",$J,CT)="FORMATTED DATA: "
 . S Z=0 F  S Z=$O(^TMP($J,"PRCAZ_FMT",Z)) Q:'Z  S CT=CT+1,^TMP("RCXM_344.5",$J,CT)=^TMP($J,"PRCAZ_FMT",Z)
 . S:RC["R" CT=CT+1,^TMP("RCXM_344.5",$J,CT)=" "
 I RC["R" D
 . S CT=CT+1,^TMP("RCXM_344.5",$J,CT)="RAW DATA: "
 . S Z=0 F  S Z=$O(^RCY(344.5,RCTDA,2,Z)) Q:'Z  S CT=CT+1,^TMP("RCXM_344.5",$J,CT)=$G(^RCY(344.5,RCTDA,2,Z,0))
 S XMBODY="^TMP(""RCXM_344.5"",$J)"
 D
 . N DUZ S DUZ=.5,DUZ(0)="@"
 . D SENDMSG^XMXAPI(.5,$E(RCSUBJ,1,65),XMBODY,.XMTO,,.XMZ)
 K ^TMP($J,"PRCAZ_RAW"),^TMP($J,"PRCAZ_FMT1"),^TMP($J,"PRCAZ_FMT"),^TMP("RCXM_344.5",$J)
 Q
 ;
BULLEFT(RCTDA,RCXMG,RCSUBJ,RCERR) ; Send a bulletin for 'bad' EFT entries
 ; RCTDA = ien of the entry in file 344.3
 ; RCXMG = mail msg # for the EFT
 ; RCSUBJ = subject of the bulletin 
 ; RCERR = error text in array
 N XMBODY,XMB,XMINSTR,XMTYPE,XMFULL,XMTO,RCXM,XMZ,XMERR,Z,Z0,CT
 S XMTO("I:G.RCDPE PAYMENTS EXCEPTIONS")="",CT=0
 S CT=CT+1,RCXM(CT)="The following electronic EFT deposit was received at your site.",CT=CT+1,RCXM(CT)="It was received on: "_$$FMTE^XLFDT($$NOW^XLFDT(),2)_" in mail msg # "_RCXMG_"."
 S CT=CT+1,RCXM(CT)="This message is sent to alert you to conditions regarding this EFT.",CT=CT+1,RCXM(CT)=" "
 I $G(RCERR)'="" S CT=CT+1,RCXM(CT)=RCERR,CT=CT+1,RCXM(CT)=" "
 I $O(RCERR(""))'="" D
 . S Z="" F  S Z=$O(RCERR(Z)) Q:Z=""  D
 .. I $G(RCERR(Z))'="" S CT=CT+1,RCXM(CT)=RCERR(Z)
 .. I $O(RCERR(Z,0)) S Z0="" F  S Z0=$O(RCERR(Z,Z0)) Q:Z0=""  S CT=CT+1,RCXM(CT)=RCERR(Z,Z0)
 S XMBODY="RCXM"
 D
 . N DUZ S DUZ=.5,DUZ(0)="@"
 . D SENDMSG^XMXAPI(.5,$E(RCSUBJ,1,65),XMBODY,.XMTO,,.XMZ)
 Q
 ;
DTXT(RCTDA,RCXM,RCNT) ; Add display text to array RCXM(CT)
 ; RCTDA = ien of entry in file 344.5
 ; Send RCNT and RCXM by reference for return values
 N RCDIQ
 D GETS^DIQ(344.5,RCTDA_",",1,"EN","RCDIQ")
 D TXTDE^RCDPEX(RCTDA,.RCDIQ,1,.RCXM,.RCNT)
 Q
 ;
BILLREF(RC3444,RC34441) ; Returns the bill # for the EOB in file 344.4, entry
 ; number RC3444 and subfile entry RC34441
 N RCARR
 D DIQ34441^RCDPEDS(RC3444,RC34441,99,"RCARR")
 Q $G(RCARR(344.41,RC34441,99,"E"))
 ;
GETBILL(DA) ; Called from computed field to find bill reference
 ;  Assumes DA(1)= ien of file 344.4,  DA = ien of file 344.41
 N Z,VAL
 S Z=$G(^RCY(344.4,DA(1),1,DA,0))
 I $P(Z,U,2) S VAL=$$BN1^PRCAFN(+$G(^IBM(361.1,+$P(Z,U,2),0))) ; IA 4051
 I $G(VAL)="" S VAL=$P(Z,U,5)
 Q VAL
 ;

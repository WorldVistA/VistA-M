RCDPESR8 ;ALB/TMK - EFT return file field captions ;09-SEP-2003
 ;;4.5;Accounts Receivable;**173**;Mar 20, 1995
 ;
 ; Note: if the 835 EFT flat file changes, make the corresponding changes
 ;       in this routine.
DISP(RCMIN,RCMOUT,RCFMT,RCFULL,RCW) ; Format display for 835 EFT return msg
 ; RCMIN = the name of the array that contains the raw message data
 ;         The data is contained at the next level and the subscript is
 ;         numeric and greater than 0 OR the data can be at the
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
 ;
 N Z,Z0,Z1,R,RC,RCCT,RCREF,RCDATA,RCQ
 S RCCT=0 K @RCMOUT
 S Z=0 F  S Z=$O(@RCMIN@(Z)) Q:'Z  S Z0=$S($G(@RCMIN@(Z))'="":@RCMIN@(Z),1:$G(@RCMIN@(Z,0))) I Z0'="" S RCQ=0 D
 . F Z1=1:1:$L(Z0,U) I $P(Z0,U,Z1)'="" D  Q:RCQ
 .. S RCDATA=$P(Z0,U,Z1)
 .. I Z1=1 D  Q:RCQ
 ... S RCREF=$S(RCDATA'["EFT":RCDATA,1:"EFT"),R=RCREF_"^RCDPESR8",RC=$P($T(@R),";;",2)
 ... I RC="" S RCCT=RCCT+1,@RCMOUT@(RCCT)="<<<INVALID LINE TYPE - RAW DATA IS:",RCCT=RCCT+1,@RCMOUT@(RCCT)=Z0
 .. Q:RCDATA=""
 .. S R=RCREF_"+"_Z1_"^RCDPESR8",RC=$P($T(@R),";;",2)
 .. I RC=""!($P(RC,U)'=RCREF) S:$S(RCDATA'="":1,1:'$P(RC,U,2)) RCCT=RCCT+1,@RCMOUT@(RCCT)="NO DATA DEFINITION PC "_Z1_": "_RCDATA Q
 .. I RC'="" D
 ... N X,X1,Y
 ... S X1=$P(RC,U,4,99)
 ... I $G(RCFMT),X1'="" S X=RCDATA X X1 S RCDATA=Y ; Output transform
 ... S RC=$P(RC,U,3)
 ... Q:RC=""&(RCDATA="")
 ... S RCCT=RCCT+1,@RCMOUT@(RCCT)=$S(Z1=1:"<<<",1:"")_RC_": "_RCDATA_$S(Z1=1:">>>",1:"")
 I $G(RCFULL)'="" D FMTDSP(RCMOUT,RCFULL,$G(RCW))
 Q
 ;
FMTDSP(RCMUN,RCMFO,RCW) ; Format the display data in array named in RCMUN into
 ; lines up to RCW characters wide  RCMUN must be set up the same as the
 ; output of the DISP call above
 ; Returns array named in RCMFO with the last subscript being the line #
 ; Note @RCMFO is killed on entry to this call
 ; Default is 80 if RCW=0 or null
 N Z,RCLINE,RCCT,RCCT1,RCMID,RCD,RCSTART,RCDASH
 K @RCMFO
 S:'$G(RCW) RCW=80
 S RCDASH=" "_$TR($J("",RCW-2)," ","-")
 S (RCCT,RCCT1)=0,RCLINE="",RCMID=RCW\2-1
 S Z=0 F  S Z=$O(@RCMUN@(Z)) Q:'Z  S RCD=$G(@RCMUN@(Z)) D
 . I $E(RCD,1,3)="<<<" D  Q  ; New line needed ... record start
 .. I $L(RCLINE)>0 S RCCT=RCCT+1,@RCMFO@(RCCT)=RCLINE,RCLINE=""
 .. I $L(RCLINE)=0 D
 ... I Z>1 S RCCT=RCCT+1,@RCMFO@(RCCT)=" "
 ... I RCD["<<<Line Type: 01 " S RCCT1=RCCT1+1,RCCT=RCCT+1,@RCMFO@(RCCT)=RCDASH,RCCT=RCCT+1,@RCMFO@(RCCT)="*** EFT PAYMENT DETAIL START - PAYMENT SEQUENCE #"_RCCT1_"***",RCCT=RCCT+1,@RCMFO@(RCCT)=RCDASH
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
 ;
DISPADJ(RC3444,RCARRAY) ; Returns formatted lines of ERA level takeback data
 ; in array @RCARRAY@(n) where n=line #.  Data is taken from entry
 ; # RC3444 in file 344.4, subfile 344.42
 N RCT,Z,Z0
 S RCT=0
 S Z=0 F  S Z=$O(^RCY(344.4,RC3444,2,Z)) Q:'Z  S Z0=$G(^(Z,0)) D
 . S RCT=RCT+1,@RCARRAY@(RCT)="REFERENCE #/BILL #: "_$P(Z0,U)
 . S RCT=RCT+1,@RCARRAY@(RCT)="   "_$E("ADJUSTMENT CODE: "_$P(Z0,U,2)_$J("",30),1,30)_"AMOUNT: "_$J($P(Z0,U,3),0,2)
 Q
 ;
EFT ;;HEADER DATA
 ;;EFT^^Return Message ID^S Y=X_" (EFT HEADER DATA)"
 ;;EFT^^^S Y=""
 ;;EFT^^File Date^S Y=$$FDT^RCDPESR9(X)
 ;;EFT^^File Time^S Y=$E(X,1,2)-$S($E(X,1,2)>12:12,1:0)_":"_$E(X,3,4)_$S($E(X,1,2)=24:" AM",$E(X,1,2)>11:" PM",1:" AM")
 ;;EFT^1^
 ;;EFT^^Deposit #
 ;;EFT^^Deposit Date^S Y=$$FDT^RCDPESR9(X)
 ;;EFT^^Total Deposit Amount^S Y=$$ZERO^RCDPESR9(X,1)
 ;
01 ;;EFT DETAIL RECORD
 ;;01^^Line Type^S Y=X_" (PAYMENT IDENTIFICATION)"
 ;;01^^Trace #
 ;;01^^Date Claims Paid^S Y=$$FDT^RCDPESR9(X)
 ;;01^^TOTAL AMOUNT PAID^S Y=$$ZERO^RCDPESR9(X,1)
 ;;01^^Payer Name
 ;;01^^Payer ID
 ;;01^^Provider Tax ID Sent
 ;;01^^Tax ID correction Flag^S Y=$S(X="E":"CHANGED BY EPHRA",X="C":"DETERMINED FROM CLAIM DATA",X="":"NO CHANGE MADE",1:X)
 ;;01^^ACH Trace #
 ;

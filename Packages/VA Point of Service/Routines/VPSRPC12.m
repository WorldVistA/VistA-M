VPSRPC12  ;WOIFO/BT - Patient Demographic - Lab Orders;08/14/14 13:07
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**4**;Aug 14, 2014;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External Reference DBIA#
 ; ------------------------
 ; #3366  - AGET^ORWORR           (Controlled Subs)
 ; #3367  - GET4LST^ORWORR        (Controlled Subs)
 ; #6100  - DETAIL^ORWOR          (Private)
 ; #10104 - XLFSTR call           (Supported)
 QUIT
 ;
GETLAB(VPSARR,DFN,DTRANGE) ;given DFN, returns the patient lab
 ; OUTPUT
 ;   VPSARR   - passed in by reference; this is the output array to store lab order
 ; INPUT
 ;   DFN      - patient DFN (This value must be validated before calling this procedure)
 ;   DTRANGE  - FROMDATE:THROUGHDATE
 ;
 ; --- Filter ---------
 K ^TMP("ORR",$J)
 N DTFROM S DTFROM=$P(DTRANGE,":")
 N DTTHRU S DTTHRU=$P(DTRANGE,":",2)
 S:DTFROM="" DTFROM=0
 S:DTTHRU="" DTTHRU=0
 I $P(DTFROM,".")=$P(DTTHRU,"."),$P(DTFROM,".",2)>$P(DTTHRU,".",2),$P(DTTHRU,".",2)="" S $P(DTTHRU,".",2)=2359
 ;
 ; --- Compile ---------
 N GROUP S GROUP=$O(^ORD(100.98,"B","LABORATORY",0)) ;lab orders
 N ORSLT D AGET^ORWORR(.ORSLT,DFN,,GROUP,DTFROM,DTTHRU)
 N LST D PREPLST(.LST)
 ;
 ; --- Store Lab Order --------------
 N DETRES,VAL,ORDIEN
 N SEQ S SEQ=0
 N EXIST S EXIST=0
 ;
 F  S SEQ=$O(LST(SEQ)) QUIT:'SEQ  D
 . S ORDIEN=LST(SEQ)
 . QUIT:'ORDIEN
 . D DETAIL^ORWOR(.DETRES,ORDIEN,DFN) ; Get Detail Info
 . D STORE(.VPSARR,DFN,ORDIEN,DETRES) ;Store Lab Orders
 . S EXIST=1
 . K @DETRES
 ;
 I 'EXIST D SET(.VPSARR,"E",DFN,"","NO LAB ORDER RECORDS FOUND FOR PATIENT","LAB ORDER NOT FOUND")
 K ^TMP("ORR",$J)
 QUIT
 ;
PREPLST(LST) ;Prepare Lab Order List
 N MAX,DAT,SEQ
 S (SEQ,DAT)=0
 K LST
 ;
 F  S DAT=$O(^TMP("ORR",$J,DAT)) QUIT:'DAT  D
 . S MAX=+$G(^TMP("ORR",$J,DAT,.1)) QUIT:'MAX
 . F SEQ=1:1:MAX S LST(SEQ)=$P(^TMP("ORR",$J,DAT,SEQ),U)
 QUIT
 ;
STORE(VPSARR,DFN,ORDIEN,LST) ;Store Lab Orders
 ; OUTPUT
 ;   VPSARR   - passed in by reference; this is the output array to store lab order
 ; INPUT
 ;   DFN      - patient DFN (This value must be validated before calling this procedure)
 ;   ORDIEN   - Order Number
 ;   LST      - Detail Result Array
 ;
 N IDX S IDX=DFN_";"_ORDIEN
 D SET(.VPSARR,100,IDX,.01,+ORDIEN) ;ORDER NUMBER
 N VAL S VAL=$$GET1^DIQ(100,+ORDIEN_",",16,"I")
 D SET(.VPSARR,100,IDX,16,VAL,"LAB APPOINTMENT DATE/TIME")
 N LINE,FLD,VAL,SEQ S SEQ=0
 ;
 F  S SEQ=$O(@LST@(SEQ)) Q:'SEQ  D
 . S LINE=@LST@(SEQ)
 . S FLD=$P(LINE,":")
 . S VAL=$$TRIM^XLFSTR($P(LINE,":",2,99))
 . I FLD="Lab Test" D SET(.VPSARR,69.03,IDX,.01,VAL,"LAB TEST")
 . I FLD="Urgency" D SET(.VPSARR,69.03,IDX,1,VAL,"URGENCY")
 . I FLD="Current Status" D SET(.VPSARR,100,IDX,8,VAL,"CURRENT STATUS")
 . I FLD="Collection Date/Time" S VAL=$$EXT2FM(VAL) D SET(.VPSARR,69.01,IDX,10,VAL,"COLLECTION DATE/TIME")
 QUIT
 ;
EXT2FM(VAL) ;External to FM Date -> Oct 20, 2014@17:30 -> 3141020@173
 ; -- Get Date
 N MTHS S MTHS="Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec"
 N MTH S MTH=$P(VAL," "),MTH=$F(MTHS,MTH)\4
 I 'MTH QUIT VAL
 N DAT S DAT=+$P(VAL," ",2)
 N YR S YR=+$P(VAL," ",3)
 N FMDT S FMDT=YR-1700*100+MTH*100+DAT
 ;
 ; -- Get Time
 N EXTTM S EXTTM=$P(VAL,"@",2) ;Time
 N FMTM S FMTM="."_$TR(EXTTM,":")
 ;
 QUIT FMDT_(+FMTM)
 ;
SET(VPSARR,VPSFL,VPSIEN,VPSFLD,VPSDA,VPSDS) ;Set line item to output array
 I VPSDA'="" D SET^VPSRPC1(.VPSARR,VPSFL,VPSIEN,VPSFLD,VPSDA,$G(VPSDS),2) ;Set line item to output array
 QUIT

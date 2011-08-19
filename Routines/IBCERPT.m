IBCERPT ;ALB/TMP - 277 EDI ENVOY REPORT MESSAGE PROCESSING ;15-JUL-98
 ;;2.0;INTEGRATED BILLING;**137,296**;21-MAR-94
 Q
 ;
RPTHDR(IBD,IBDATE) ; Report message header
 ;   ^TMP("IBMSG",$J,"REPORT",0,0)=MESSAGE HEADER DATA STRING
 ;                                  ,"D",0,1)=header record raw data
 ;                                  ,line #)=report message lines
 ;
 N X,Y,%DT
 S IBD("LINE")=0
 S ^TMP("IBMSG",$J,"REPORT",0,0)="REPORT^"_$G(IBD("MSG#"))_U_$G(IBD("SUBJ"))_U_U_U_IBDATE_"^0^ENVOY"
 Q
 ;
REPORT(IBHD,IBDATE,IBD,IBTXN) ; Assemble, store report message
 ; Returns IBD array if passed by reference, IBHOLDCT, IBLAST
 ;
 N IBWANT,IBMCT
 S IBMCT=($G(IBD("Q"))="MCT")
 S IBWANT=$S($P(IBTXN,U,3)'="":+$P($G(^IBE(361.2,+$O(^IBE(361.2,"B",$P(IBTXN,U,3),0)),0)),U,2),1:1) ; Send report anyway if name is not in the file
 D RPTHDR(.IBD,IBDATE)
 S (IBD("MESSAGE"),IBD)=IBTXN
 I IBWANT D RPTLINE(.IBD,IBHD),RPTLINE(.IBD,IBHD,1,IBMCT)
 ;
 F  X XMREC Q:XMER<0  D  Q:IBLAST  ;Extract rest of message
 . S IBHOLDCT=IBHOLDCT+1,(IBD,^TMP("IB-HOLD",$J,IBHOLDCT))=XMRG
 . D:IBWANT RPTLINE(.IBD,IBHD)
 . ;
 . I $P(XMRG,U)="REPORT" D  Q  ; Add message subject as part of text
 .. S IBD("MESSAGE")=XMRG,IBWANT=$S($P(XMRG,U,3)'="":+$P($G(^IBE(361.2,+$O(^IBE(361.2,"B",$P(XMRG,U,3),0)),0)),U,2),1:1)
 .. D:IBWANT RPTLINE(.IBD,IBHD,1,IBMCT)
 .. ;
 . I +XMRG=99,$P(XMRG,U,2)="$" S IBLAST=1 Q
 K:'$O(^TMP("IBMSG",$J,"REPORT",0,"D",0,0)) ^TMP("IBMSG",$J,"REPORT")
 Q
 ;
RPTLINE(IBD,IBHD,IBSUB,IBMCT) ;Process report lines
 ; INPUT:
 ;   IBD must be passed by reference = entire message line
 ;   IBHD = the header data from the message
 ;   IBSUB = 1 to signify the subject line should be output
 ;   IBMCT = 1 if message from the MCT (test) queue
 ;
 ; OUTPUT:
 ;   IBD array returned with processed data
 ;      "LINE" = The last line # populated in the message
 ;
 ;   ^TMP("IBMSG",$J,"REPORT",0,"D",0,line #)=report line data
 ;
 S IBMCT=+$G(IBMCT)
 I $G(IBSUB) S IBD="SUBJECT^WebMD REPORT "_$S('IBMCT:"",1:" * * TEST RESULTS * * ")_$P($G(IBD("MESSAGE")),U,3)_" "_$P(IBHD,U)_" "_$P(IBHD,U,6)
 S IBD("LINE")=$G(IBD("LINE"))+1
 S ^TMP("IBMSG",$J,"REPORT",0,"D",0,IBD("LINE"))=IBD
 Q
 ;

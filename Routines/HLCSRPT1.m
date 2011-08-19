HLCSRPT1 ;ISC-SF/RAH-TRANS LOG PENDING MSG LIST;03/01/2010  14:59 ;08/25/2010
 ;;1.6;HEALTH LEVEL SEVEN;**19,50,107,145,151**;Oct 13, 1995;Build 1
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
EN ; Entry Point for Pending Message Search.
 D LNKSRCH Q:$D(STOP)
 I HLCSLS=1 D SEARCH1 Q
 D SEARCH2
 Q
 ;
 ;
SEARCH1 ;
 W !!," . . . PLEASE WAIT, THIS CAN TAKE AWHILE . . .",!
 S HLCSI=0,HLCSIO="" S HLCSLN=0
 F  S HLCSIO=$O(^HLMA("AC",HLCSIO)) Q:(HLCSIO="")  D
 . S HLCSN=HLCSI,HLCSJ=0
 . F  S HLCSJ=$O(^HLMA("AC",HLCSIO,HLCSLINK,HLCSJ)) Q:(HLCSJ="")  D
 .. I '$D(^HLMA(HLCSJ,0)) Q
 .. I '$D(^HLMA("AG",1,HLCSJ)) Q
 .. S HLCSX=^HLMA(HLCSJ,0),HLCSDTE=$P(HLCSX,U,1)
 .. S HLCSLNK="          "
 .. I $D(^HLCS(870,HLCSLINK,0)) S HLCSLNK=$P(^HLCS(870,HLCSLINK,0),U,1)
 .. ; patch HL*1.6*145 start
 .. ; S HLCSEVN1=$P(HLCSX,U,13) I HLCSEVN1'="",($D(^HL(771.2,HLCSEVN1,0))) S HLCSEVN1=$P(^HL(771.2,HLCSEVN1,0),U,1)
 .. ; S HLCSEVN2=$P(HLCSX,U,14) I HLCSEVN2'="",($D(^HL(779.001,HLCSEVN2,0))) S HLCSEVN2=$P(^HL(779.001,HLCSEVN2,0),U,1)
 .. N SEG
 .. D HEADSEG(HLCSJ,.SEG)
 .. S HLCSEVN1=$G(SEG("MESSAGE TYPE"))
 .. S HLCSEVN2=$G(SEG("EVENT TYPE"))
 .. ; patch HL*1.6*145 end
 .. I HLCSEVN1="" S HLCSEVN1="   "
 .. I HLCSEVN2="" S HLCSEVN2="   "
 .. I $L(HLCSEVN1)<3 S HLCSEVN1=HLCSEVN1_"   ",HLCSEVN1=$E(HLCSEVN1,1,3)
 .. I $L(HLCSEVN2)<3 S HLCSEVN2=HLCSEVN2_"   ",HLCSEVN2=$E(HLCSEVN2,1,3)
 .. S HLCSEVN=HLCSEVN1_":"_HLCSEVN2
 .. D FORMAT^HLCSRPT
 .. Q
 . Q
 I '$D(^TMP("TLOG",$J,1)) W !!,HLCSNREC,!! S DIR(0)="E" D ^DIR K DIR Q
 I VERS22'="YES" S HLCSTITL="IEN RECORD #   MESSAGE ID #         Log Link   Msg:Evn IO Sndg Apl Rcvr Apl HDR"
 E  S HLCSTITL="MESSAGE ID #         D/T Entered   Log Link   Msg:Evn IO Sndg Apl Rcvr Apl     "
 I VERS22'="YES" D FAKR
 D DISPLAY^HLCSRPT K ^TMP("TLOG",$J)
 Q
 ;
SEARCH2 ;
 W !!," . . . PLEASE WAIT, THIS CAN TAKE AWHILE . . .",!
 S HLCSI=0,HLCSIO="" S HLCSLN=0
 F  S HLCSIO=$O(^HLMA("AC",HLCSIO)) Q:(HLCSIO="")  D
 . S HLCSN=HLCSI,HLCSJ=0,HLCSLINK=0
 . F  S HLCSLINK=$O(^HLMA("AC",HLCSIO,HLCSLINK)) Q:(HLCSLINK="")  D
 .. F  S HLCSJ=$O(^HLMA("AC",HLCSIO,HLCSLINK,HLCSJ)) Q:(HLCSJ="")  D
 ... I '$D(^HLMA(HLCSJ,0)) Q
 ... I '$D(^HLMA("AG",1,HLCSJ)) Q
 ... S HLCSX=^HLMA(HLCSJ,0),HLCSDTE=$P(HLCSX,U,1)
 ... S HLCSLNK="          "
 ... I $D(^HLCS(870,HLCSLINK,0)) S HLCSLNK=$P(^HLCS(870,HLCSLINK,0),U,1)
 ... ; patch HL*1.6*145 start
 ... ; S HLCSEVN1=$P(HLCSX,U,13) I HLCSEVN1'="",($D(^HL(771.2,HLCSEVN1,0))) S HLCSEVN1=$P(^HL(771.2,HLCSEVN1,0),U,1)
 ... ; S HLCSEVN2=$P(HLCSX,U,14) I HLCSEVN2'="",($D(^HL(779.001,HLCSEVN2,0))) S HLCSEVN2=$P(^HL(779.001,HLCSEVN2,0),U,1)
 ... N SEG
 ... D HEADSEG(HLCSJ,.SEG)
 ... S HLCSEVN1=$G(SEG("MESSAGE TYPE"))
 ... S HLCSEVN2=$G(SEG("EVENT TYPE"))
 ... ; patch HL*1.6*145 end
 ... I HLCSEVN1="" S HLCSEVN1="   "
 ... I HLCSEVN2="" S HLCSEVN2="   "
 ... I $L(HLCSEVN1)<3 S HLCSEVN1=HLCSEVN1_"   ",HLCSEVN1=$E(HLCSEVN1,1,3)
 ... I $L(HLCSEVN2)<3 S HLCSEVN2=HLCSEVN2_"   ",HLCSEVN2=$E(HLCSEVN2,1,3)
 ... S HLCSEVN=HLCSEVN1_":"_HLCSEVN2
 ... D FORMAT^HLCSRPT
 ... Q
 .. Q
 . Q
 I '$D(^TMP("TLOG",$J,1)) W !!,HLCSNREC,!! S DIR(0)="E" D ^DIR K DIR Q
 I VERS22'="YES" S HLCSTITL="IEN RECORD #   MESSAGE ID #         Log Link   Msg:Evn IO Sndg Apl Rcvr Apl HDR"
 E  S HLCSTITL="MESSAGE ID #         D/T Entered   Log Link   Msg:Evn IO Sndg Apl Rcvr Apl     "
 I VERS22'="YES" D FAKR
 D DISPLAY^HLCSRPT K ^TMP("TLOG",$J)
 Q
 ;
LNKSRCH ; Report pending messages on A logical link.
 W @IOF,! S HLCSHDR="Logical Link Selection" D HLCSBAR
 S DIR(0)="PAO^870:AEO",DIR("A")="Select Logical Link:  ALL//"
 D ^DIR S:($D(DTOUT)!($D(DUOUT))) STOP=1 Q:$D(STOP)
 I X="" S HLCSLS="" K DIR,X,Y Q
 I Y=-1 W !,X_" NOT VALID " K X,Y G LNKSRCH
 S HLCSLINK=$P(Y,U,1),HLCSLNK=$P(Y,U,2) K DIR,X,Y
 S HLCSLS=1
 Q
 ;
FAKR ; Build fake record to pass FM21 Browser edits.
 S HLCSJ=^TMP("TLOG",$J,1)
 S HLCSJ=+$P(HLCSJ," ",1)
 S ^TMP($J,"MESSAGE",HLCSJ,0)="^^1^1"
 S ^TMP($J,"MESSAGE",HLCSJ,1,0)=" Fake Record to pass Browser edits. "
 S HLCSRNO=HLCSJ
 Q
 ;
SHOWMSG(XXY,XXZ) ;
 ; Each node, ^tmp($j,"message",record_ien), invokes this code
 ; to compile a 'virtual w-p document' when a message is browsed.
 I $D(^HLMA(XXY,"MSH",0)) D
 . S ^TMP($J,"MESSAGE",XXY,0)=^HLMA(XXY,"MSH",0)
 . S YY1=$P(^HLMA(XXY,"MSH",0),U,3),YY2=$P(^HLMA(XXY,"MSH",0),U,4)
 E  S ^TMP($J,"MESSAGE",XXY,0)="1^1"
 S XLINE=^HLMA(XXY,0)
 S LINE="Record #: "_XXY_"                    ",LINE=$E(LINE,1,30)
 S LINE=LINE_"Message #: "_$P(XLINE,U,2)
 S ^TMP($J,"MESSAGE",XXY,1,0)=LINE
 S DTE=$P(XLINE,U,1) I $P($G(^HL(772,DTE,0)),U,1)'="" S DTE=$P(^HL(772,DTE,0),U,1),DTE=$E(DTE,4,7)_$E(DTE,2,3)_"."_$P(DTE,".",2)_"      "
 I $D(^HLMA(XXY,"S")),$P(^HLMA(XXY,"S"),U,1)'="" S DTP=$P(^HLMA(XXY,"S"),U,1) S DTP=$E(DTP,4,7)_$E(DTP,2,3)_"."_$P(DTP,".",2)
 E  S DTP=" "
 S LINE="D/T Entered: "_DTE,LINE=$E(LINE,1,30)_"D/T Processed: "_DTP
 S ^TMP($J,"MESSAGE",XXY,2,0)=LINE K DTE,DTP
 S LINE="Logical Link: " I $P(XLINE,U,7)'="",($D(^HLCS(870,$P(XLINE,U,7),0))) S LINE=LINE_$P(^HLCS(870,$P(XLINE,U,7),0),U,1)
 S LINE=LINE_"                ",LINE=$E(LINE,1,30)
 S LINE=LINE_"Ack To MSG#: " I $P(XLINE,U,6)'="",($D(^HLMA($P(XLINE,U,6),0))) S LINE=LINE_$P(^HLMA($P(XLINE,U,6),0),U,2)
 S ^TMP($J,"MESSAGE",XXY,3,0)=LINE
 S DTS="" I $P($G(^HLMA(XXY,"P")),U,2)'="" S DTS=$P(^HLMA(XXY,"P"),U,2),DTS=$E(DTS,4,7)_$E(DTS,2,3)_"."_$P(DTS,".",2)
 S LINE="D/T STATUS: "_DTS_"                  ",LINE=$E(LINE,1,30),LINE=LINE_"STATUS: "
 I $P(^HLMA(XXY,"P"),U,1)'="" S LINE=LINE_$P(^HL(771.6,+$P(^HLMA(XXY,"P"),U,1),0),U,1)
 S ^TMP($J,"MESSAGE",XXY,4,0)=LINE K DTS
 S LINE="ERR MSG: " I $P(^HLMA(XXY,"P"),U,3)'="" S LINE=LINE_$E($P(^HLMA(XXY,"P"),U,3),1,20)
 S LINE=LINE_"                      ",LINE=$E(LINE,1,30)_"ERR TYPE: "
 I $P(^HLMA(XXY,"P"),U,4)'="" S LINE=LINE_$P(^HL(771.7,+$P(^HLMA(XXY,"P"),U,4),0),U,1)
 S ^TMP($J,"MESSAGE",XXY,5,0)=LINE
 S LINE="Sending Appl: " I $P(XLINE,U,11)'="",($D(^HL(771,$P(XLINE,U,11),0))) S LINE=LINE_$P(^HL(771,$P(XLINE,U,11),0),U,1)
 S ^TMP($J,"MESSAGE",XXY,6,0)=LINE
 S LINE="Receiving Appl: " I $P(XLINE,U,12)'="",($D(^HL(771,$P(XLINE,U,12),0))) S LINE=LINE_$P(^HL(771,$P(XLINE,U,12),0),U,1)
 S ^TMP($J,"MESSAGE",XXY,7,0)=LINE
 ; patch HL*1.6*145 start
 ; S LINE="Message Type: " I $P(XLINE,U,13)'="",($D(^HL(771.2,$P(XLINE,U,13),0))) S LINE=LINE_$P(^HL(771.2,$P(XLINE,U,13),0),U,1)
 N SEG
 D HEADSEG(XXY,.SEG)
 S LINE="Message Type: "_$G(SEG("MESSAGE TYPE"))
 S LINE=LINE_"                    ",LINE=$E(LINE,1,30)_"Event Type: "
 ; I $P(XLINE,U,14)'="",($D(^HL(779.001,$P(XLINE,U,14),0))) S LINE=LINE_$P(^HL(779.001,$P(XLINE,U,14),0),U,1)
 S LINE=LINE_$G(SEG("EVENT TYPE"))
 ; patch HL*1.6*145 end
 S ^TMP($J,"MESSAGE",XXY,8,0)=LINE K LINE,XLINE
 S ^TMP($J,"MESSAGE",XXY,9,0)="MESSAGE HEADER: "
 S LN1=.5,LN2=10
 I $D(^HLMA(XXY,"MSH",0)) D
 . F  S LN1=$O(^HLMA(XXY,"MSH",LN1)) Q:LN1=""  D
 .. S ^TMP($J,"MESSAGE",XXY,LN2,0)=^HLMA(XXY,"MSH",LN1,0)
 .. ;HL*1.6*107 start:  to fix the multiple lines per segment
 .. ;S LN2=LN2+1,LN1=LN1+1
 .. S LN2=LN2+1
 .. ;HL*1.6*107 end
 ..Q
 S LN1=.5
 S ^TMP($J,"MESSAGE",XXY,LN2,0)="MESSAGE TEXT: ",LN2=LN2+1
 I $D(^HL(772,XXZ,"IN",0)) D
 . F  S LN1=$O(^HL(772,XXZ,"IN",LN1)) Q:(LN1="")  D
 .. S ^TMP($J,"MESSAGE",XXY,LN2,0)=^HL(772,XXZ,"IN",LN1,0)
 .. ;HL*1.6*107 start: to fix the multiple lines per segment
 .. ;S LN2=LN2+1,LN1=LN1+1
 .. S LN2=LN2+1
 .. ;HL*1.6*107 end
 ..Q
 S (YY1,YY2)=LN2-1
 S Y1Y2=YY1_"^"_YY2
 S $P(^TMP($J,"MESSAGE",XXY,0),U,3,4)=Y1Y2
 K LN1,LN2,Y1Y2,YY1,YY2
 Q
 ;
HLCSBAR ; Center Title on Top Line of Screen
 W RVON,?(80-$L(HLCSHDR)\2),HLCSHDR,$E(SPACE,$X,77),RVOFF,!
 Q
 ;
HEADSEG(IEN,SEG) ;
 ; patch HL*1.6*145
 ; input:
 ;    IEN: ien of message in file #773
 ;    SEG: passing by reference
 ; output:
 ;    SEG
 ;
 Q:'$G(IEN)
 K SEG
 S SEG=$G(^HLMA(IEN,"MSH",1,0))_$G(^HLMA(IEN,"MSH",2,0))
 Q:SEG']""
 S SEG("CODE")=$E(SEG,1,3)
 Q:$L(SEG("CODE"))'=3
 S SEG("FIELD")=$E(SEG,4)
 Q:SEG("FIELD")=""
 S SEG("COMPONENT")=$E(SEG,5)
 Q:SEG("COMPONENT")=""
 S SEG("SUB-COMPONENT")=$E(SEG,8)
 S SEG("ECH-2")=$E(SEG,6)
 ;
 S SEG("MESSAGE TYPE")=""
 S SEG("EVENT TYPE")=""
 ;
 I SEG("CODE")="MSH" D
 . S SEG("SEG-9")=$P(SEG,SEG("FIELD"),9)
 . S SEG("MESSAGE TYPE")=$P(SEG("SEG-9"),SEG("COMPONENT"))
 . S SEG("EVENT TYPE")=$P(SEG("SEG-9"),SEG("COMPONENT"),2)
 ;
 I SEG("CODE")="BHS" D
 . S SEG("SEG-9")=$P(SEG,SEG("FIELD"),9)
 . I SEG("SEG-9")]"" D
 .. S SEG("SEG-9-2")=$P(SEG("SEG-9"),SEG("COMPONENT"),3)
 .. S SEG("MESSAGE TYPE")=SEG("SEG-9-2")
 .. I SEG("SEG-9-2")]"",$L(SEG("ECH-2")),(SEG("SEG-9-2")[SEG("ECH-2")) D
 ... S SEG("MESSAGE TYPE")=$P(SEG("SEG-9-2"),SEG("ECH-2"))
 ... S SEG("EVENT TYPE")=$P(SEG("SEG-9-2"),SEG("ECH-2"),2)
 .. ;
 .. Q:SEG("SUB-COMPONENT")=""
 .. I SEG("SEG-9-2")]"",(SEG("SEG-9-2")[SEG("SUB-COMPONENT")) D
 ... S SEG("MESSAGE TYPE")=$P(SEG("SEG-9-2"),SEG("SUB-COMPONENT"))
 ... S SEG("EVENT TYPE")=$P(SEG("SEG-9-2"),SEG("SUB-COMPONENT"),2)
 Q
 ;

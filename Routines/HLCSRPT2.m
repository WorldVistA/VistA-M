HLCSRPT2 ;ISC-SF/RAH-TRANS LOG ERROR LIST ;08/25/2010
 ;;1.6;HEALTH LEVEL SEVEN;**50,85,107,145,151**;Oct 13, 1995;Build 1
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;Calls to SAVEDDB^DDBR2, USAVEDDB^DDBR2, PSR^DDBR0, and WP^DDBR2 supported by IA#2540 & IA#3594
 ;
 Q
 ;
EN ; Entry point for reporting error messages.
 ;
 ; All NEWs below added by HL*1.6*85
 N BLDOFF,BLDON,DY,ERRDTB,ERRDTE,HLCSCLNT,HLCSDTE,HLCSDTP
 N HLCSEVN,HLCSEVN1,HLCSEVN2,HLCSHDR,HLCSK,HLCSLINK
 N HLCSLNK,HLCSMID,HLCSMX,HLCSNREC,HLCSPTR,HLCSRNO,HLCSSRVR
 N HLCSTITL,HLCSTYP,HLERR,IEN773,LAST773,LASTPDT
 N LPIENS,NOREC,NUMERR,OLD773,OLDPDT,RVOFF,RVON,SPACE
 N SPACE20,SPACE25,SPACE30,SPACE80,STOP,TYPEINFO,VERS22
 ;
 D CLEANGBL ;HL*1.6*85
 ;
 S (STOP,NOREC)=""
 D SCREEN^HLCSRPT
 S HLCSNREC=BLDON_" ===>>>  NO MATCHING RECORDS  <<<=== "_BLDOFF
 S HLCSTITL="#773-IEN      Message-ID       Procd     Log-Link   Msg:Evn IO Sndg-Apl Rcvr-Apl" ;HL*1.6*85
 S HLCSPTR=1,HLCSRNO=1
 S VERS22=""
 I 22'>+$$VERSION^XPDUTL("DI")!($$PATCH^XPDUTL("DI*21.0*32")) S VERS22="YES" ;HL*1.6*85
 I VERS22'="YES" D
 . S ^TMP("DDBPF1Z",$J)="D SHOWMSG^HLCSRPT2 Q"
 . S HLCSTITL=HLCSTITL_" ERR"
 E  S HLCSTITL=HLCSTITL_"    "
 S ^TMP($J,"LIST","MESSAGE")="^TMP($J,""MESSAGE"",HLCSRNO)"
 S ^TMP($J,"LIST",HLCSTITL_" ERR")="^TMP(""TLOG"",$J)" ;HL*1.6*85
 ;
REEN ; Internal Re-entry Point
 S STOP=""
 D WHATERR Q:(+$G(STOP))
 QUIT:'$$SETUP^HLCSRPT4  ;-> HL*1.6*85
 I TYPEINFO=2 S HLCSTITL="#773-IEN      Message-ID       Procd     Log-Link   Error-type               " ;HL*1.6*85
 D ERRSRCH
 I ERRDTE[9999999 S ERRDTE=$$NOW^XLFDT
 I +$G(STOP) D EXIT Q
 I +$G(NOREC) W !!,HLCSNREC,!! S DIR(0)="E" D ^DIR K DIR,X,Y D EXIT Q
 D DISPLAY^HLCSRPT ;HL*1.6*85
 D CLEANGBL ;HL*1.6*85
 D EXIT
 S STOP=1
 Q
 ;
CLEANGBL ; New subroutine added by HL*1.6*85 to clean up globals
 N GBL
 F GBL="LIST","MESSAGE" KILL ^TMP($J,GBL)
 F GBL="DDBPF1Z","DDBLST","TLOG","TMPLOG" KILL ^TMP(GBL,$J)
 QUIT
 ;
WHATERR ; Ask for one error code; with default of all
 W @IOF,! S HLCSHDR="Error Type Selection" D HLCSBAR
 S X="",HLCSER="ALL"
 S DIR(0)="PAO^771.7:AEO",DIR("A")="Select Error Type:  ALL//"
 D ^DIR S:($D(DTOUT)!($D(DUOUT))) STOP=1
 I +$G(STOP) K DIR,X,Y Q
 I X="" K DIR,X,Y Q
 I Y=-1 W !,X_" NOT VALID " K DIR,X,Y G WHATERR
 S HLCSTER1=$P(Y,U,1),HLCSTER2=$P(Y,U,2) K DIR,X,Y
 S HLCSER=1
 Q
 ;
ERRSRCH ; Find and report the 'errored' messages (Multiple HL*1.6*85 changes start here)
 ; ERRDTB,ERRDTE,NUMERR -- req
 N NEXT,CT
 W !!,"PLEASE WAIT, THIS CAN TAKE AWHILE..."
 ;
 ;HL*1.6*85 - LOADERR loads all errors, using the user-supplied 
 ;            parameters, and places them in ^TMP.  Below, the code
 ;            now loops thru ^TMP instead of ^HLMA (which happened
 ;            in LOADERR.)
 D LOADERR^HLCSRPT4
 ;
 ; Looping starts here...
 S HLCSI=0,HLCSST=0,HLCSLN=0
 F  S HLCSI=$O(^TMP("ERRLST",$J,HLCSI)) Q:HLCSI'>0  D
 .  S HLCSN=HLCSI,HLCSJ=0
 .  F  S HLCSJ=$O(^TMP("ERRLST",$J,HLCSI,HLCSJ)) Q:HLCSJ'>0  D
 .. ;HL*1.6*85 changes end here, until noted otherwise below.
 ..
 .. I '$D(^HLMA(HLCSJ,0)) Q
 .. S HLCSX=^HLMA(HLCSJ,0),HLCSDTE=$P(HLCSX,U,1)
 .. I $D(^HLMA(HLCSJ,"S")) S HLCSDTP=$P(^HLMA(HLCSJ,"S"),U,1)
 .. E  S HLCSDTP=""
 .. I $D(^HLMA(HLCSJ,"P")) S HLCSY=^HLMA(HLCSJ,"P")
 .. E  S HLCSY=""
 .. I HLCSER=1,(HLCSTER1'=$P(HLCSY,U,4)) Q
 .. S HLCSER1=$P(HLCSY,U,4),HLCSER2=HLCSER1
 .. I HLCSER1'="",($D(^HL(771.7,HLCSER1,0))) S HLCSER1=$P(^HL(771.7,HLCSER1,0),U,1)
 .. S HLCSERMS=$P(HLCSY,U,3)
 .. S HLCSLINK=$P(HLCSX,U,7) S HLCSLNK="          "
 .. I HLCSLINK'="",($D(^HLCS(870,HLCSLINK,0))) S HLCSLNK=$P(^HLCS(870,HLCSLINK,0),U,1)
 .. ; patch HL*1.6*145 start
 .. ; S HLCSEVN1=$P(HLCSX,U,13) I HLCSEVN1'="",($D(^HL(771.2,HLCSEVN1,0))) S HLCSEVN1=$P(^HL(771.2,HLCSEVN1,0),U,1)
 .. ; S HLCSEVN2=$P(HLCSX,U,14) I HLCSEVN2'="",($D(^HL(779.001,HLCSEVN2,0))) S HLCSEVN2=$P(^HL(779.001,HLCSEVN2,0),U,1)
 .. N SEG
 .. D HEADSEG^HLCSRPT1(HLCSJ,.SEG)
 .. S HLCSEVN1=$G(SEG("MESSAGE TYPE"))
 .. S HLCSEVN2=$G(SEG("EVENT TYPE"))
 .. ; I HLCSEVN1="" S HLCSEVN1=$$MSGEVN^HLCSRPT5(HLCSJ,2) ;HL*1.6*85
 .. ; I HLCSEVN2="" S HLCSEVN2=$$MSGEVN^HLCSRPT5(HLCSJ,2) ;HL*1.6*85
 .. ; patch HL*1.6*145 end
 .. I $L(HLCSEVN1)<3 S HLCSEVN1=HLCSEVN1_"   ",HLCSEVN1=$E(HLCSEVN1,1,3)
 .. I $L(HLCSEVN2)<3 S HLCSEVN2=HLCSEVN2_"   ",HLCSEVN2=$E(HLCSEVN2,1,3)
 .. S HLCSEVN=HLCSEVN1_":"_HLCSEVN2
 .. D ERRRPT^HLCSRPT5 ;HL*1.6*85 - Code overrun moved
 .. Q
 .Q
 KILL ^TMP("ERRLST",$J) ;HL*1.6*85
 D TMPLOG^HLCSRPT4 ;HL*1.6*85 Reset ^TMP("TMPLOG",$J) to ^TMP("TLOG",$J)
 I '$D(^TMP("TLOG",$J,1)) S NOREC=1 Q
 ;HL*1.6*85 - HLCSTITL already set above ;S HLCSTITL="IEN Record #   MESSAGE ID #         Log Link   Msg:Evn IO Sndg Apl Rcvr Apl"
 I '$D(VERS22) S HLCSTITL=HLCSTITL_" ERR"
 E  S HLCSTITL=HLCSTITL_"    "
 D TEST
 Q
 ;
SHOWMSG ; Enable switching to specific message (used by PF1Z).
 ; If FM version 22 installed, uses VERS22 code, instead.
 W @IOF
 S DIR(0)="F:AE",DIR("A")="Enter Record Number: "
 D ^DIR Q:$D(DIRUT)
 I Y=-1!(X="") Q
 S HLCSRNO=X I '$D(^HLMA(HLCSRNO,0)) D  Q
 . W !!,BLDON,"  ==>  NO SUCH RECORD NUMBER <== ",BLDOFF H 3
 S HLCSPTR=$P(^HLMA(HLCSRNO,0),"^",1)
 S XXY=HLCSRNO,XXZ=HLCSPTR D VERS22(XXY,XXZ)
 D SWITCH
 Q
SWITCH ; Non-standard Fileman Browser calls covered by IA# 2540.
 N DDBLN,DDBZ,DIC,DIR,X,Y,DIRUT,DIROUT,DUOUT,DILN
 S DILN=DDBRSA(DDBRSA,"DDBSRL")-2
 S:$G(DDBLST)="" DDBLST="^TMP(""DDBLST"",$J)" S DDBLN=$S($D(@DDBLST@("A",DDBSA)):^(DDBSA),1:$O(@DDBLST@(" "),-1)+1)
 I $D(@DDBLST) D
 .I $O(@DDBLST@(" "),-1)=1,$G(@DDBLST@(1,"DDBSA"))=DDBSA Q
 .S DDBZ=$G(@DDBLST@("A",DDBSA),0)
 .S Y=2
 .D SAVEDDB^DDBR2(DDBLST,DDBLN),USAVEDDB^DDBR2(DDBLST,+Y)
 .S DIROUT=1
 N DDBLNA
 I $G(DDBLNA,-1)=-1 G PS
 I $G(DDBLNA(6))=DDBSA G PS  ;if current doc re-selected
 I $G(DDBLNA(6))]"",$D(@DDBLST@("APSA",DDBSA)) G PS  ;on list
 D:DDBLNA>0 SAVEDDB^DDBR2(DDBLST,DDBLN),WP^DDBR2(.DDBLNA)
PS D PSR^DDBR0(1)
 Q
 ;
VERS22(XXY,XXZ) ; this is modified code from SHOWMSG^HLCSRPT1.
 ; Each node, ^tmp($j,"message",record_ien), invokes this code
 ; to compile a 'virtual w-p document' when a message is browsed.
 I $D(^HLMA(XXY,"MSH",0)) D
 .S ^TMP($J,"MESSAGE",XXY,0)=^HLMA(XXY,"MSH",0)
 .S YY1=$P(^HLMA(XXY,"MSH",0),U,3),YY2=$P(^HLMA(XXY,"MSH",0),U,4)
 E  S ^TMP($J,"MESSAGE",XXY,0)="^^1^1" S (YY1,YY2)=1
 S XLINE=^HLMA(XXY,0)
 S LINE="Record #: "_XXY_"                    ",LINE=$E(LINE,1,30)
 S LINE=LINE_"Message #: "_$P(XLINE,U,2)
 S ^TMP($J,"MESSAGE",XXY,1,0)=LINE
 S DTE=$P(XLINE,U,1) I $P($G(^HL(772,DTE,0)),U,1)'="" S DTE=$P(^HL(772,DTE,0),U,1),DTE=$E(DTE,4,7)_$E(DTE,2,3)_"."_$P(DTE,".",2)_"      "
 I $D(^HLMA(XXY,"S")),$P(^HLMA(XXY,"S"),U,1)'="" S DTP=$P(^HLMA(XXY,"S"),U,1) S DTP=$E(DTP,4,7)_$E(DTP,2,3)_"."_$P(DTP,".",2)
 E  S DTP=" "
 S LINE="D/T Entered: "_DTE,LINE=$E(LINE,1,30)_"D/T Processed: "_DTP
 S ^TMP($J,"MESSAGE",XXY,2,0)=LINE K DTE,DTP
 S LINE="Logical Link: " I $P(XLINE,U,7)'="",($G(^HLCS(870,$P(XLINE,U,7),0))) S LINE=LINE_$P(^HLCS(870,$P(XLINE,U,7),0),U,1)
 S LINE=LINE_"                ",LINE=$E(LINE,1,30)
 S LINE=LINE_"Ack To MSG#: " I $P(XLINE,U,6)'="",$G(^HLMA($P(XLINE,U,6),0)) S LINE=LINE_$P(^HLMA($P(XLINE,U,6),0),U,2)
 S ^TMP($J,"MESSAGE",XXY,3,0)=LINE
 S DTS="" I $P($G(^HLMA(XXY,"P")),U,2)'="" S DTS=$P(^HLMA(XXY,"P"),U,2),DTS=$E(DTS,4,7)_$E(DTS,2,3)_"."_$P(DTS,".",2)
 S LINE="D/T STATUS: "_DTS_"                 ",LINE=$E(LINE,1,30),LINE=LINE_"STATUS: "
 I $P(^HLMA(XXY,"P"),U,2)'="",($G(^HL(771.6,+$P(^HLMA(XXY,"P"),U,1),0))) S LINE=LINE_$P(^HL(771.6,+$P(^HLMA(XXY,"P"),U,1),0),U,1)
 S ^TMP($J,"MESSAGE",XXY,4,0)=LINE K DTS
 S LINE="ERR MSG: " I $P(^HLMA(XXY,"P"),U,3)'="" S LINE=LINE_$E($P(^HLMA(XXY,"P"),U,3),1,20)
 S LINE=LINE_"                      ",LINE=$E(LINE,1,30)_"ERR TYPE: "
 I $P(^HLMA(XXY,"P"),U,4)'="",($D(^HL(771.7,+$P(^HLMA(XXY,"P"),U,4),0))) S LINE=LINE_$P(^HL(771.7,+$P(^HLMA(XXY,"P"),U,4),0),U,1)
 S ^TMP($J,"MESSAGE",XXY,5,0)=LINE
 S LINE="Sending Appl: " I $P(XLINE,U,11)'="",($D(^HL(771,$P(XLINE,U,11),0))) S LINE=LINE_$P(^HL(771,$P(XLINE,U,11),0),U,1)
 S ^TMP($J,"MESSAGE",XXY,6,0)=LINE
 S LINE="Receiving Appl: " I $P(XLINE,U,12)'="",($D(^HL(771,$P(XLINE,U,12),0))) S LINE=LINE_$P(^HL(771,$P(XLINE,U,12),0),U,1)
 S ^TMP($J,"MESSAGE",XXY,7,0)=LINE
 ; patch HL*1.6*145 start
 ; S LINE="Message Type: " I $P(XLINE,U,13)'="",($D(^HL(771.2,$P(XLINE,U,13),0))) S LINE=LINE_$P(^HL(771.2,$P(XLINE,U,13),0),U,1)
 N SEG
 D HEADSEG^HLCSRPT1(XXY,.SEG)
 S LINE="Message Type: "_$G(SEG("MESSAGE TYPE"))
 S LINE=LINE_"                    ",LINE=$E(LINE,1,30)_"Event Type: "
 ; I $P(XLINE,U,14)'="",($D(^HL(779.001,$P(XLINE,U,14),0))) S LINE=LINE_$P(^HL(779.001,$P(XLINE,U,14),0),U,1)
 S LINE=LINE_$G(SEG("EVENT TYPE"))
 ; patch HL*1.6*145 end
 S ^TMP($J,"MESSAGE",XXY,8,0)=LINE K LINE,XLINE
 S ^TMP($J,"MESSAGE",XXY,9,0)="MESSAGE HEADER: "
 S LN2=10
 I $D(^HLMA(XXY,"MSH",0)) D
 .S LN1=.5
 .F  S LN1=$O(^HLMA(XXY,"MSH",LN1)) Q:LN1=""  D
 .. S ^TMP($J,"MESSAGE",XXY,LN2,0)=^HLMA(XXY,"MSH",LN1,0)
 .. ;HL*1.6*107 start: to fix the multiple lines per segment
 .. ;S LN2=LN2+1,LN1=LN1+1
 .. S LN2=LN2+1
 .. ;HL*1.6*107 end
 E  S ^TMP($J,"MESSAGE",XXY,LN2,0)=" No Header in MSG Admin File (#773)" S LN2=LN2+1
 S LN1=.5
 S ^TMP($J,"MESSAGE",XXY,LN2,0)="MESSAGE TEXT: ",LN2=LN2+1
 I $D(^HL(772,XXZ,"IN",0)) D
 .F  S LN1=$O(^HL(772,XXZ,"IN",LN1)) Q:(LN1="")  D
 .. S ^TMP($J,"MESSAGE",XXY,LN2,0)=^HL(772,XXZ,"IN",LN1,0)
 .. ;HL*1.6*107 start: to fix the multiple lines per segment
 .. ;S LN2=LN2+1,LN1=LN1+1
 .. S LN2=LN2+1
 .. ;HL*1.6*107 end
 ..Q
 E  S ^TMP($J,"MESSAGE",XXY,LN2,0)=" No Message in MSG Text File (#772)" S LN2=LN2+1
 S (YY1,YY2)=LN2-1
 S Y1Y2=YY1_"^"_YY2
 S $P(^TMP($J,"MESSAGE",XXY,0),U,3,4)=Y1Y2
 K LN1,LN2,Y1Y2,YY1,YY2
 Q
 ;
EXIT D EXIT^HLCSRPT6 Q  ; Exceeded 10,000 bytes, so split on 12/2/03-LJA
HLCSBAR D HLCSBAR^HLCSRPT6 Q  ; Exceeded 10,000 bytes, so split on 12/2/03-LJA
TEST D TEST^HLCSRPT6 Q  ; Exceeded 10,000 bytes, so split on 12/2/03-LJA

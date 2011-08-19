ORPR09 ; slc/dcm - Getting Consults pre-formatted output ;12/21/98  12:16
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**11**;Dec 17, 1997
EN(Y,ORIFN,QUIET) ;Get consult report
 I $G(ORTEST) D TEST Q
 Q:'$L($T(GUI^GMRCP5))
 N IEN,ARRAY,OREND,CNT,I
 Q:'$D(^OR(100,+$G(ORIFN),0))  Q:'$G(^(4))  S IEN=+^(4)
 S ARRAY="",CNT=1
 D GUI^GMRCP5(.ARRAY,IEN)
 S I=499999.9 F  S I=$O(@ARRAY@(1,I)) Q:'I!(I>599999.9)  S CNT=CNT+1
 I $G(QUIET) K Y S (I,Y)=0 D  Q
 . S ORPICKUP=1,Y=$E(ARRAY,1,($L(ARRAY)-1))_",1)"
 U IO
 I '$D(ORIOSL) N ORIOSL S ORIOSL=$S($D(IOSL):IOSL,1:50)
 I '$D(ORIOF) N ORIOF S ORIOF=$S($D(IOF):IOF,1:"!")
 I $G(ORFIRST1)=0,$Y>ORIOSL W @ORIOF
 D HEAD()
 D TEXTOUT(ARRAY,299999.9,399999.9,1,$S($E(IOST)="C":2,1:CNT))
 I $E(IOST)="C",$Y+CNT>ORIOSL D PGBRK^ORUHDR W @ORIOF
 D FOOT(CNT)
 I $E(IOST)="C" D PGBRK^ORUHDR
 K @ARRAY
 Q
TEXTOUT(OROOT,START,END,FFCHK,CNT) ;Non DIWP text function that Raps for ^TMP arays
 I '$L($G(OROOT)) Q
 N X,ORI
 S ORI=$S($G(START):START,1:0),END=$S($G(END):END,1:99999999999)
 F  S ORI=$O(@OROOT@(1,ORI)) Q:'ORI!(ORI>END)  S X=$S($L($G(@OROOT@(1,ORI))):@OROOT@(1,ORI),$L($G(@OROOT@(1,ORI,0))):@OROOT@(1,ORI,0),1:"") D:$G(FFCHK) FEED(CNT) Q:$G(OREND)  W !,X
 Q
TEST ;Test the output
 W !,"This format does the entire consult report and cannot be customized"
 W !,"There is no need for a separate Header and Footer formats."
 W !,"..."
 Q
TEST1 ;Test for Consult Body only
 W !,"This format does the 'body' of the consult report"
 W !,"Headers and Footers have to be added to the report"
 W !,"format for a complete report."
 Q
FEED(CNT) ;Roomcheck
 Q:$G(ORTEST)
 I $Y+CNT<ORIOSL Q
 I $E(IOST)'="C" D FOOT(CNT)
 I $E(IOST)="C" D PGBRK^ORUHDR W @ORIOF
 I $E(IOST)'="C" D HEAD(1)
 Q
HEAD(FF) ;Header
 I $G(FF)!($E(IOST)="C") W @ORIOF
 D TEXTOUT(ARRAY,99999.9,199999.9,,1)
 Q
FOOT(CNT) ;Footer
 F  Q:$Y+$G(CNT)>(ORIOSL-1)  W !
 D TEXTOUT(ARRAY,499999.9,599999.9,,1)
 Q
EN1(Y,ORIFN,QUIET) ;Get consult report (Body only)
 I $G(ORTEST) D TEST1 Q
 Q:'$L($T(GUI^GMRCP5))
 N IEN,ARRAY,OREND,CNT,I
 Q:'$D(^OR(100,+$G(ORIFN),0))  Q:'$G(^(4))  S IEN=+^(4)
 S ARRAY="",CNT=1
 D GUI^GMRCP5(.ARRAY,IEN)
 S I=99999.9 F  S I=$O(@ARRAY@(1,I)) Q:'I!(I>199999.9)  K @ARRAY@(1,I) ;Remove header
 S I=499999.9 F  S I=$O(@ARRAY@(1,I)) Q:'I!(I>599999.9)  K @ARRAY@(1,I) ;Remove footer
 I $G(QUIET) K Y S (I,Y)=0 D  Q
 . S ORPICKUP=1,Y=$E(ARRAY,1,($L(ARRAY)-1))_",1)"
 U IO
 I '$D(ORIOSL) N ORIOSL S ORIOSL=$S($D(IOSL):IOSL,1:50)
 I '$D(ORIOF) N ORIOF S ORIOF=$S($D(IOF):IOF,1:"!")
 I $G(ORFIRST1)=0,$Y>ORIOSL W @ORIOF
 D TEXTOUT(ARRAY,299999.9,399999.9,1,$S($E(IOST)="C":2,1:CNT))
 I $E(IOST)="C",$Y+CNT>ORIOSL D PGBRK^ORUHDR W @ORIOF
 K @ARRAY
 Q

HLEMSU ;ALB/CJM,ALB/BRM - Utilities for building ListManager screens; 2/27/01 1:25pm
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13,1995
 ;
 ;
SET(LINE,TEXT,COL,CNTRL) ; -- set display array
 ; Input:
 ;  LINE - line# to put the TEXT
 ;  TEXT - **optional** text to put in the array
 ;  COL - **optional** column # to put the TEXT
 ;  CNTRL - **optional** video display chracteristic - "H"= high, "B"-blinking
 ; Output:
 ;  function returns the number of lines in the list
 N X,ON,OFF
 S:LINE>VALMCNT VALMCNT=LINE
 S:'$L(TEXT) TEXT=" "
 S X=$G(@IDX@(VALMCNT,0))
 S @IDX@(VALMCNT,0)=$$SETSTR^VALM1(TEXT,X,COL,$L(TEXT))
 I $G(CNTRL)["R" S ON=IORVON,OFF=IORVOFF
 I $G(CNTRL)["B" S ON=$G(ON)_IOBON,OFF=$G(OFF)_IOBOFF
 I $G(CNTRL)["H" S ON=$G(ON)_IOINHI,OFF=$G(IOINORM)
 I $G(CNTRL)["U" S ON=$G(ON)_IOUON,OFF=$G(IOUOFF)
 D:$L($G(ON)) CNTRL^VALM10(LINE,COL,$L(TEXT),ON,OFF)
 Q VALMCNT
 ;
STATION(IEN) ;
 ;Description:  Given an ien to the Institution file, returns as the function value the <facility name>^<station number>
 ;
 N RETURN
 Q:'$G(IEN) ""
 Q:'$D(^DIC(4,IEN,0)) ""
 Q $P($$NNT^XUAF4(IEN),"^",1,2)
 ;
CENTER(STRING) ;
 Q $$CJ^XLFSTR(STRING,80)

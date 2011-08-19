HLEVX ;O-OIFO/LJA - VistA HL7 Event Monitor Code ;02/04/2004 15:25
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
 ; All official event code for the VistA HL7 package will be included
 ; in the LIST subroutine below (for internal team use.)
 ;
CTRL D LIST
 F  QUIT:($Y+3)>IOSL  W !
 S X=$$BTE^HLCSMON("Press RETURN to exit... ")
 Q
 ;
LIST N I,T W @IOF,$$CJ^XLFSTR("Official VistA HL7 Event Monitor Code",IOM),!,$$REPEAT^XLFSTR("=",IOM) F I=1:1 S T=$T(LIST+I) Q:T'[";;"  S T=$P(T,";;",2,99)  W !,$P(T,U,1,2),?18,$P(T,U,3)
 ;;
 ;;The "monitors" that are officially included in the VistA HL7 package are
 ;;listed below.
 ;;
 ;;Routine           Monitor-Name
 ;;==============================================================================
 ;;SYSTEM^HLEVX001^EVENT MONITOR
 ;;CHK870^HLEVX000^STUB 870 SEARCH & MORE
 ;;CHKXREF^HLEVX002^XREF CHECK - FILE 772 & 773
 Q
 ;
EOR ;HLEVX - VistA HL7 Event Monitor Code ;5/30/03 15:25

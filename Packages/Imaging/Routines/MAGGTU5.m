MAGGTU5 ;WOIFO/GEK - Silent Utilities ; [ 06/20/2001 08:57 ]
 ;;3.0;IMAGING;**8,48**;Jan 11, 2005
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
CLOSE ;Close Execute for the WS.DAT Device
 Q:IO["nul"  ; OPENM calls this 'close execute' twice, we get "" array.
 N MAGDT
 ; IF NOT CALLED FROM IMAGING ROUTINE, USE ^TMP GLOBAL
 I '$D(MAGRPTY) S MAGRPTY=$NA(^TMP($J,"WSDAT")) K @MAGRPTY
 S MAGDT=$$FMTE^XLFDT($$NOW^XLFDT,"1P")
 N I S I=3
 U IO W !!,"** END REPORT "_MAGDT_" **",!
 S X=$$REWIND^%ZIS(IO,IOT,IOPAR) I 'X S @MAGRPTY@(0)="0^Failed: Rewinding to beginning of Host File. Call IRM" Q
 IF $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D EOF^MAGGTU5"
 E  S X="EOF^MAGGTU5",@^%ZOSF("TRAP")
 F  U IO R X:5 D  Q:X["** END REPORT "_MAGDT_" **"
 . I X[$C(8)_"_" D
 . . ;strip backspaces and separate underline if they exist saf 4/19/00
 . . S @MAGRPTY@(I)=$E(X,1,$FIND(X,$P(X,$C(8)))-1),I=I+1
 . . S @MAGRPTY@(I)=$E(X,$FIND(X,$P(X,"_")),$L(X)),I=I+1
 . E  S @MAGRPTY@(I)=$$TRIM(X),I=I+1
 S @MAGRPTY@(0)="1^Report Complete"
 Q
EOF ;
 S X=$$EC^%ZOSV
 I ((X["ENDOFFILE")!(X["EOF")) S @MAGRPTY(0)="1^Report Complete" Q
 D ^%ZTER
 S @MAGRPTY@(0)="0^ERROR: "_$$EC^%ZOSV
 Q
 ;
DTTM(MAGRY,INDT,NOFDT) ; RPC [MAGG DTTM] Call to return DHCP Date/Time
 ; Output MAGRY 
 ;  0^Error message
 ;  1 ^ External Date  in "Jan 04, 1999@11:55"   format  ^ Internal DateTime
 ;  INDT         is the input, it is validated and the external value is returned.
 ;       NOFDT   1|0
 ;               Flag to Not Allow Future Dates.
 ;               prior to P48 we allowed future dates.  Now the Parameter can stop that.
 ;
 N INPUT,Y
 S X=INDT,NOFDT=+$G(NOFDT)
 S %DT="TS" D ^%DT
 I Y=-1 S MAGRY="0^Incorrect date format: "_X Q
 S MAGRY="1^"_$$FMTE^XLFDT(Y,"1")_U_Y
 Q:'NOFDT
 ;    Now error if future.
 S INPUT=$P(Y,".",1)
 D NOW^%DTC
 S X=$P(X,".",1)
 I INPUT]X S MAGRY="0^Future dates are not allowed."
 Q
TRIM(X) ;trim backspace characters
 N I,Y
 S Y=X
 I X[$C(8) D
 . S Y=""
 . F I=1:1:$L(X) I $E(X,I)'=$C(8) S Y=Y_$E(X,I)
 Q Y

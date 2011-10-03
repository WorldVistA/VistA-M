DGPWBD ;ALB/CAW - Device Specifications for Patient Wristband ;2/14/95
 ;;5.3;Registration;**62,82,246,385**;Aug 13, 1993
 ;
BL ; Barcode Blazer
 N LINE
 U IO
 S LINE=$G(^%ZIS(2,IOST(0),203)) W LINE,LINE1,!
 S LINE=$G(^%ZIS(2,IOST(0),205)) W LINE,LINE2,!
 S LINE=$G(^%ZIS(2,IOST(0),207)) W LINE,LINE3,!
 S LINE=$G(^%ZIS(2,IOST(0),209)) W LINE,LINE4,!
 S VARIABLE=$P(VADM(2),U)
 ;VARIABLE is the SSN without dashes.
 I $L($G(^%ZIS(2,+IOST(0),"BAR1"))) W @^%ZIS(2,IOST(0),"BAR1")
 Q
ADD ; Add different barcode set up here
 Q

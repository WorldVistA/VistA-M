LA7SBCR ;DALOI/JMC - Shipping Barcode Reader Utility ; 7 Feb 1997
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**27,46**;Sep 27, 1994
 Q
 ;
BAR(Y) ; Ask user if utilizing a barcode reader
 ; Returns -1 = user aborted
 ;          0 = No
 ;          1 = Yes
 ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="Y0",DIR("A")="Are you using a barcode reader",DIR("B")="YES"
 D ^DIR
 I $G(DIRUT) Q -1
 Q Y
 ;
RD(LA7SDP,LA7CASE) ; Read input from barcode reader.
 ; Input
 ;   LA7SDP=array containing default prompt to display
 ;   LA7CASE=0 return scanned text as barcoded
 ;          =1 return scanned text in upper case.
 ;          =2 return scanned text in lower case.
 ;
 ; Returns
 ;        Y=1^barcode value.
 ;         =0 if user quits/timeouts
 ;         =-1 if invalid read
 ;
 N DIR,DIRUT,DTOUT,DUOUT,I,LA7Y,X,Y
 I $G(LA7SDP)="" S LA7SDP="Scan barcode"
 S LA7CASE=+$G(LA7CASE)
 S I=0
 F  S I=$O(LA7SDP(I)) Q:'I  S DIR("A",I)=LA7SDP(I)
 S DIR("A")=LA7SDP
 S DIR(0)="FUO^3:245"
 D ^DIR
 I $D(DIRUT) Q 0 ; User quit
 I Y="" Q -1 ; Invalid read
 S LA7Y=Y
 I LA7CASE=1 S LA7Y=$$UP^XLFSTR(LA7Y)
 I LA7CASE=2 S LA7Y=$$LOW^XLFSTR(LA7Y)
 Q "1^"_LA7Y
 ;
DT(X) ; Validate date/time
 N %DT,Y
 S %DT="ST" D ^%DT
 I Y<1 S Y=""
 Q Y

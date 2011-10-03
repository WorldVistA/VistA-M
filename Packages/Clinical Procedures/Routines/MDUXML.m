MDUXML ; HOIFO/WAA -Utilities for XML text  ; 7/26/00
 ;;1.0;CLINICAL PROCEDURES;**6**;Apr 01, 2004;Build 102
 ; This routine will loop throught the HL7 Message as sent
 ; by the vendor and convert that message into XML for
 ; Processing by the gateway.
 ;
EN1 ;
 N NUM,LBL,XMLCNT,XMLLINE,DL,DEVICE,Q,ORDER
 K ^TMP($J,"MDHL7XML")
 S DL="|",QUOT=""""
 S (XMLCNT,ORDER,NUM)=0
 D HEAD^MDUXMLU1
 F  S NUM=$O(^TMP($J,"MDHL7A",NUM)) Q:NUM<1  D
 . N LINE,LBL
 . S LINE=$G(^TMP($J,"MDHL7A",NUM)) Q:LINE=""
 . I $P(LINE,DL,1)="OBX" D
 . . I LINE["//" S LINE=$TR(LINE,"/","\")
 . . I LINE["\E\" D
 . . . N Y,Z,I S Z="" F I=1:1:$L(LINE) S Y=$E(LINE,I) D:Y="\"  S Z=Z_Y
 . . . . I $E(LINE,I+1)="E",$E(LINE,I+2)="\" S I=I+2
 . . . . Q
 . . . S LINE=Z
 . . . Q
 . . I $P(LINE,DL,6)["\\" D
 . . . N I
 . . . S I=$O(^TMP($J,"MDHL7A",NUM),-1)
 . . . S ^TMP($J,"MDHL7A",(NUM+1))="OBX||ST|PROCEDURE STATUS||DONE"
 . . . Q
 . . Q
 . S LINE=$$VAL^MDUXMLU1(LINE)
 . S LBL=$P(LINE,DL,1)
 . Q:'($S(LBL="MSH":1,LBL="PID":1,LBL="PV1":1,LBL="ORC":1,LBL="OBR":1,LBL="OBX":1,1:0))
 . S LBL=LBL_"^MDUXMLM"
 . D @LBL
 . Q
 D TAIL^MDUXMLU1
 Q

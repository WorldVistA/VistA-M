GMTS125A ; CIO/SLC - Environmental Check GMTS*2.7*125    ;Feb 18, 2019@18:40:12
 ;;2.7;Health Summary;**125**;Oct 20, 1995;Build 15
 Q
ENV ; Environmental Check
 N A,XPDABORT
 I '$D(^GMT(142.1,269)),'$D(^GMT(142.1,270)) Q
 S A=$G(^GMT(142.1,269,0)) I $P(A,"^")'="Meds OP/Drug Class" S XPDABORT=1 D ERROR Q
 I $P(A,"^",3)'="RXDC" S XPDABORT=1 D ERROR Q
 S A=$G(^GMT(142.1,270,0)) I $P(A,"^")'="Meds OP/Rx Ord Item" S XPDABORT=1 D ERROR Q
 I $P(A,"^",3)'="RXOI" S XPDABORT=1 D ERROR
 Q
ERROR ;
 D MES^XPDUTL("Health Summary Component Conflict - one or more components already exist on your")
 D MES^XPDUTL("system. Please log a ServiceNow ticket to have the conflict reviewed and ")
 D MES^XPDUTL("resolved then install GMTS*2.7*125.") H 10
 Q

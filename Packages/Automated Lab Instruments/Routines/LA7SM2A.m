LA7SM2A ;DALOI/JMC - Shipping Manifest Options ;Oct 4, 2006
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**74**;Sep 27, 1994;Build 229
 ;
 ; Continuation of LA7SM2
 ;
INFOEE ; Required Info Enter/Edit
 ;
 ; Called by LA7SM2
 ; 
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,LA7CDT,LA7I,LA7INFO,LA7J,LA7RINFO,LA7TCNT,LA7X,LA7Y,X,Y
 ;
 D SEL^LA7SM
 I LA7QUIT Q
 ;
 S (LA7I,LA7TCNT)=0
 F  S LA7I=$O(^LAHM(62.8,+LA7SM,10,"UID",LA7UID,LA7I)) Q:'LA7I  D
 . F LA7J=0,1,2 S LA7I(LA7J)=$G(^LAHM(62.8,+LA7SM,10,LA7I,LA7J))
 . I $P(LA7I(0),"^",8)=0 Q  ; Previously "removed".
 . I $P(LA7I(0),"^",8),$P(LA7I(0),"^",8)'=1 S LA7QUIT="1^Accession not pending shipment" Q  ; Not pending shipment
 . S LA7TCNT=LA7TCNT+1
 . F LA7J=1,4 I $P(LA7I(1),"^",LA7J) D
 . . I '$P(LA7I(1),"^",LA7J+2) Q  ; No units specified
 . . S LA7X=$S(LA7J=1:1.11,LA7J=4:1.21,1:0)
 . . S LA7RINFO(LA7X)=$P(LA7I(1),"^",LA7J+1) ; Value
 . . S $P(LA7RINFO(LA7X),"^",2)=$P(LA7I(1),"^",LA7J+2) ; Units
 . . S LA7RINFO(LA7X,LA7I)=LA7RINFO(LA7X)_"^"_$P(LA7I(0),"^",2)
 . F LA7J=1,4,8 I $P(LA7I(2),"^",LA7J) D
 . . I '($S(LA7J=4:$P(LA7I(2),"^",7),1:$P(LA7I(2),"^",LA7J+2))) Q  ; No units specified.
 . . S LA7X=$S(LA7J=1:2.11,LA7J=4:2.21,LA7J=8:2.31,1:0)
 . . S LA7RINFO(LA7X)=$P(LA7I(2),"^",LA7J+1) ; Value
 . . S $P(LA7RINFO(LA7X),"^",2)=$S(LA7J=4:$P(LA7I(2),"^",7),1:$P(LA7I(2),"^",LA7J+2)) ; Units
 . . S LA7RINFO(LA7X,LA7I)=LA7RINFO(LA7X)_"^"_$P(LA7I(0),"^",2)
 ;
 I 'LA7TCNT,'LA7QUIT S LA7QUIT="1^Accession is not on this shipping manifest"
 I '$O(LA7RINFO(0)),'LA7QUIT S LA7QUIT="1^No test needs required information for shipping"
 I LA7QUIT Q
 ;
 S LA7CDT=+$P($G(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,3)),"^")
 S LA7Y=0
 F  S LA7Y=$O(LA7RINFO(LA7Y)) Q:'LA7Y  D  Q:LA7QUIT
 . N DA,DIR,DIRUT
 . S DIR(0)="62.801,"_LA7Y
 . S DIR("A")=$$GET1^DID(62.801,LA7Y,"","LABEL")
 . I LA7Y=2.21 D
 . . S DIR("A",1)=" "
 . . S DIR("A",2)="Specimen Collection Date/time: "_$$FMTE^XLFDT(LA7CDT,"M")
 . . S $P(DIR(0),"^",3)="I Y<LA7CDT!(Y>$$NOW^XLFDT) K X" ; d/t after specimen collect d/t
 . I LA7Y'=2.21 D
 . . N LA7X
 . . S LA7X=$$GET1^DIQ(64.061,$P(LA7RINFO(LA7Y),"^",2)_",",.01) ; Units
 . . S DIR("A")=DIR("A")_" (in "_LA7X_")"
 . I $P(LA7RINFO(LA7Y),"^")'="" D   ; Default value
 . . I LA7Y=2.21 S DIR("B")=$$FMTE^XLFDT($P(LA7RINFO(LA7Y),"^"))
 . . E  S DIR("B")=$P(LA7RINFO(LA7Y),"^")
 . D ^DIR
 . I $D(DTOUT)!$D(DUOUT) S LA7QUIT=1 Q
 . S $P(LA7INFO(LA7Y),"^")=$P(Y,"^") ; New value
 I LA7QUIT Q
 ;
 S LA7Y=0
 F  S LA7Y=$O(LA7RINFO(LA7Y)) Q:'LA7Y  D
 . S LA7I=0
 . F  S LA7I=$O(LA7RINFO(LA7Y,LA7I)) Q:'LA7I  D
 . . I $P(LA7INFO(LA7Y),"^")=$P(LA7RINFO(LA7Y,LA7I),"^") Q  ; Value unchanged
 . . N FDA,LA7628,LA768,LA7DATA
 . . S LA762801=LA7I_","_+LA7SM_","
 . . I LA7Y=2.21 D
 . . . N LA7DURT,LA7UID,LA7UNITS,LA7X
 . . . S LA7UNITS=$$GET1^DIQ(64.061,+$P(LA7RINFO(LA7Y,LA7I),"^",2)_",",.01,"E")
 . . . S LA7DURT=$$FMDIFF^XLFDT(LA7INFO(LA7Y),LA7CDT,2) ; Collection duration (in seconds)
 . . . I LA7UNITS="min" S LA7DURT=$FN(LA7DURT/60,"",0) ; Convert to minutes, rounded to nearest minute.
 . . . I LA7UNITS="hr" S LA7DURT=$FN(LA7DURT/3600,"",0) ; Convert to hours, rounded to nearest hour.
 . . . S FDA(62.8,62.801,LA762801,2.22)=LA7DURT
 . . S FDA(62.8,62.801,LA762801,LA7Y)=$P(LA7INFO(LA7Y),"^") ; New value
 . . D FILE^DIE("","FDA(62.8)","LA7DIE(2)") ; Update required info
 . . ; Update event file
 . . S LA7DATA="SM40^"_$$NOW^XLFDT_"^"_$P(LA7RINFO(LA7Y,LA7I),"^",3)_"^"_$P(LA7SM,"^",2)
 . . D SEUP^LA7SMU(LA7UID,2,LA7DATA)
 Q

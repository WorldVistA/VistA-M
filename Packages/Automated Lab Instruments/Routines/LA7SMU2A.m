LA7SMU2A ;DALOI/JMC - Shipping Manifest Utility (Cont'd) ;11/17/11  09:07
 ;;5.2;AUTOMATED LAB INSTRUMENTS;*74**;Sep 27, 1994;Build 229
 ;
 Q
 ;
 ;
BINDX ; Build index of tests for a shipping configuration.
 ; Called from LA7SMU2.
 ;
 N I,J,K,LA760,LA761,LA762,LA76205,LA764,LA7HL,LA7NLT,LA7NLTN,LA7TC,LA7X,LA7Y,LA7Z,LRSS
 S LA7X=0
 F  S LA7X=$O(^LAHM(62.9,LA7SCFG,60,LA7X)) Q:'LA7X  D BLD
 Q
 ;
 ;
BLD ; Build TMP global for a test
 ; Called from above
 ;
 K LA761,LA762,LA76205,LA764,LA7NLT,LA7NLTN,LA7TC,LA7Y,LA7Z
 ;
 S LA7X(0)=$G(^LAHM(62.9,LA7SCFG,60,LA7X,0))
 S LA7X(5)=$G(^LAHM(62.9,LA7SCFG,60,LA7X,5))
 ;
 ; Laboratory test/collection sample.
 S LA760=$P(LA7X(0),"^"),LA761=+$P(LA7X(0),"^",3),LA762=+$P(LA7X(0),"^",9),LRSS=$P(^LAB(60,LA760,0),"^",4)
 I 'LA761 S LA761=$$GET1^DIQ(62,LA762_",",2,"I")
 I LA761,'LA762 S LA762=+$$GET1^DIQ(61,LA761_",",4.1,"I")
 ; Incomplete entry if in CH or BB subscript.
 I 'LA762,"BBCH"[LRSS Q
 I 'LA761,"BBCH"[LRSS Q
 ;
 ; Test urgency/HL7 priority code.
 S LA76205=$P(LA7X(0),"^",4),LA76205("HL")=""
 I LA76205 S LA76205("HL")=$$GET1^DIQ(62.05,LA76205_",","LEDI HL7:HL7 ABBR")
 ;
 ; Use HL7 specimen code if using table 0070, SNOMED if SCT and mapping in 62.9 for local.
 S LA761("HL70070")=$$GET1^DIQ(61,LA761_",","LEDI HL7:HL7 ABBR")
 S LA761("SCT")=$P($$IEN2SCT^LA7VHLU6(61,LA761,DT),"^")
 I $P(LA7X(5),"^",3)'="" D
 . I $P(LA7X(5),"^",6)="" S $P(LA7X(5),"^",6)="L"
 . S LA761($P(LA7X(5),"^",6))=$P(LA7X(5),"^",3)
 ;
 ; Use SNOMED CT and local mapping in 62.9 for collection sample.
 S LA762("SCT")=$P($$IEN2SCT^LA7VHLU6(62,LA762,DT),"^")
 I $P(LA7X(5),"^",7)'="" D
 . I $P(LA7X(5),"^",9)="" S $P(LA7X(5),"^",9)="L"
 . S LA762($P(LA7X(5),"^",9))=$P(LA7X(5),"^",7)
 ;
 ; File #64 ien/NLT code/NLT code test name.
 ; Use NLT code if using VA coding else use non-VA test order code.
 S LA764=+$$GET1^DIQ(60,LA760_",",64,"I")
 I 'LA764 Q
 S LA7TC("99VA64")=$$GET1^DIQ(64,LA764_",",1,"I")
 S LA7NLTN=$$GET1^DIQ(64,LA764_",",.01)
 I $P(LA7X(5),"^")'="" D
 . I $P(LA7X(5),"^",5)="" S $P(LA7X(5),"^",5)="L"
 . S LA7TC($P(LA7X(5),"^",5))=$P(LA7X(5),"^")
 ;
 ; Set TMP global with information
 S LA7Y=LA760_"^"_LA761_"^"_LA762_"^"_LA76205_"^"_LA7TC("99VA64")_"^"_LA7NLTN
 S I=""
 F  S I=$O(LA7TC(I)) Q:I=""  D
 . S K=""
 . F  S K=$O(LA762(K)) Q:K=""  I LA762(K)'=""  D
 . . S J=""
 . . F  S J=$O(LA761(J)) Q:J=""  I LA761(J)'="" D
 . . . S ^TMP("LA7TC",$J,LA7SCFG,I,LA7TC(I),J,LA761(J),0,K,LA762(K))=LA7Y
 . . . I LA76205("HL")'="" S ^TMP("LA7TC",$J,LA7SCFG,I,LA7TC(I),J,LA761(J),LA76205("HL"),K,LA762(K))=LA7Y
 . . I 'LA761,LRSS="MI" D  Q
 . . . S ^TMP("LA7TC",$J,LA7SCFG,I,LA7TC(I),0,0,0,K,LA762(K))=LA7Y
 . . . I LA76205("HL")'="" S ^TMP("LA7TC",$J,LA7SCFG,I,LA7TC(I),0,0,LA76205("HL"),K,LA762(K))=LA7Y
 . . I 'LA761,"SPCYEM"[LRSS D
 . . . S ^TMP("LA7TC",$J,LA7SCFG,I,LA7TC(I),"HL70070","XXX",0,K,LA762(K))=LA7Y
 . . . I LA76205("HL")'="" S ^TMP("LA7TC",$J,LA7SCFG,I,LA7TC(I),"HL70070","XXX",LA76205("HL"),K,LA762(K))=LA7Y
 . I LRSS="MI" S LA7Z=LA7Y,$P(LA7Z,"^",2,4)="^^",^TMP("LA7TC",$J,LA7SCFG,I,LA7TC(I),0,0,0,0,0)=LA7Z
 . S J=""
 . F  S J=$O(LA761(J)) Q:J=""  I LA761(J)'="",LRSS?1(1"CH",1"MI") D
 . . I LA76205("HL")'="" S ^TMP("LA7TC",$J,LA7SCFG,I,LA7TC(I),J,LA761(J),LA76205("HL"))=LA7Y
 . . E  S ^TMP("LA7TC",$J,LA7SCFG,I,LA7TC(I),J,LA761(J))=LA7Y
 ;
 Q

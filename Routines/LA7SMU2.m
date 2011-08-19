LA7SMU2 ;DALOI/JMC - Shipping Manifest Utility (Cont'd);5/5/97 14:44
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**46,64**;Sep 27, 1994
 Q
 ;
DTTO(LA7SCFG,LA7VNLT,LA7HLSC,LA764NCS,LA761NCS,LA7HLPRI,LA7CSC) ; Determine test to order
 ; Call with LA7SCFG = ien of Shipping Configuration file #62.9
 ;           LA7VNLT = NLT code or non-VA test code
 ;           LA7HLSC = HL7 Specimen Code
 ;          LA764NCS = HL7 Name of Test Coding System
 ;          LA761NCS = HL7 Name of Specimen Coding System
 ;          LA7HLPRI = HL7 Priority Code
 ;            LA7CSC = collection sample code^name^coding system
 ;
 ; Returns      LA7X = 0^0^0^0^^^ (if unsuccessful)
 ;                     LABORATORY TEST (ien file #60)^TOPOGRAPHY (ien file #61)^COLLECTION SAMPLE (ien file #62)^URGENCY (ien file #62.05)^NLT TEST CODE^NLT TEST NAME
 ;
 N LA760,LA7V64,LA7X,X,Y,Z
 ;
 ; Make sure variables initialized.
 S LA7X="0^0^0^0^^^"
 I LA7VNLT="" Q LA7X
 S LA7SCFG=+$G(LA7SCFG)
 I LA7HLPRI="" S LA7HLPRI="R"
 I LA7HLSC="" S LA7HLSC="XXX"
 ; 
 ; If coding systems not defined then assume
 ; HL7 Table 0070 and VA NLT file
 I LA761NCS="0070" S LA761NCS="HL70070"
 I LA761NCS="" S LA761NCS="HL70070"
 I LA764NCS="" S LA764NCS="99VA64"
 I LA764NCS="L",$P(^LAHM(62.9,LA7SCFG,0),"^",15)=0 S LA764NCS="99VA64"
 ;
 ; Build index of tests if not previously done for this session.
 I '$D(^TMP("LA7TC",$J,LA7SCFG)) D BINDX
 ;
 ; Found test info with priority
 I LA7HLPRI]"" D
 . I $P(LA7CSC,"^")'="" D  Q:LA7X
 . . S X=$G(^TMP("LA7TC",$J,LA7SCFG,LA7VNLT,LA7HLSC,LA7HLPRI,$P(LA7CSC,"^")))
 . . I X S LA7X=X
 . S X=$G(^TMP("LA7TC",$J,LA7SCFG,LA7VNLT,LA7HLSC,LA7HLPRI))
 . I X S LA7X=X Q
 . S X=$G(^TMP("LA7TC",$J,LA7SCFG,LA7VNLT,"XXX",LA7HLPRI))
 . I X,"MISPCYEM"[$P(^LAB(60,+X,0),"^",4) S LA7X=X
 ;
 ; Found test info with no priority specified
 I 'LA7X D
 . I $P(LA7CSC,"^")'="" D  Q:LA7X
 . . S X=$G(^TMP("LA7TC",$J,LA7SCFG,LA7VNLT,LA7HLSC,0,$P(LA7CSC,"^")))
 . . I X S LA7X=X
 . S X=$G(^TMP("LA7TC",$J,LA7SCFG,LA7VNLT,LA7HLSC))
 . I X S LA7X=X Q
 . S X=$G(^TMP("LA7TC",$J,LA7SCFG,LA7VNLT,"XXX"))
 . I X,"MISPCYEM"[$P(^LAB(60,+X,0),"^",4) S LA7X=X
 ;
 ; Otherwise get values from files #60 LABORATORY TEST and #61, TOPOGRAPHY
 ; Lookup test using NLT code and get first lab test in "AC" for this
 ; NLT code that's type (I)nput or (B)oth.
 I 'LA7X,LA764NCS="99VA64" D
 . S LA7V64=$O(^LAM("E",LA7VNLT,0)),Y=0 Q:'LA7V64
 . F  S Y=$O(^LAB(60,"AC",LA7V64,Y)) Q:'Y  Q:"BI"[$P(^LAB(60,Y,0),"^",3)
 . I Y S $P(LA7X,"^")=Y
 ;
 ; Get default topography and collection sample for HL7 specimen type.
 ; Check file #60 collection samples first, then check first entry in file #61 for match
 ; If non-table 0070 then look for "XXX" in table 0070
 I $P(LA7X,"^"),'$P(LA7X,"^",2),LA761NCS="HL70070" D
 . S (X,Y)=0,LA760=$P(LA7X,"^")
 . F  S X=$O(^LAB(60,LA760,3,"B",X)) Q:'X  D  Q:Y
 . . S Z=$P(^LAB(62,X,0),"^",2)
 . . I Z,$D(^LAB(61,"HL7",LA7HLSC,Z)) S Y=Z_"^"_X
 . I Y S $P(LA7X,"^",2,3)=Y
 I '$P(LA7X,"^",2),LA761NCS="HL70070" D
 . S X=$O(^LAB(61,"HL7",LA7HLSC,0)) Q:'X
 . S $P(LA7X,"^",2)=X
 . I '$P(LA7X,"^",3) S $P(LA7X,"^",3)=$P(^LAB(61,X,0),"^",6)
 I $P(LA7X,"^"),'$P(LA7X,"^",2),LA761NCS'="HL70070","MISPCYEM"[$P(^LAB(60,$P(LA7X,"^"),0),"^",4) D
 . S X=$O(^LAB(61,"HL7","XXX",0))
 . I X S $P(LA7X,"^",2)=X
 ;
 ; No urgency mapping, get last using this HL7 code or site's default urgency from #69.9
 ; Find highest non-workload urgency using this priority code else use site's default
 I '$P(LA7X,"^",4) D
 . S X=$O(^LAB(62.05,"HL7",LA7HLPRI,50),-1)
 . I X S $P(LA7X,"^",4)=X
 . E  S $P(LA7X,"^",4)=+$P($G(^LAB(69.9,1,3)),"^",2)
 ;
 ; Check file #60 forced and highest urgency.
 I $P(LA7X,"^"),$P(LA7X,"^",4) D
 . S X=$G(^LAB(60,$P(LA7X,"^"),0))
 . I $P(X,"^",18) S $P(LA7X,"^",4)=$P(X,"^",18)
 . I $P(X,"^",16),$P(LA7X,"^",4)<$P(X,"^",16) S $P(LA7X,"^",4)=$P(X,"^",16)
 ;
 Q LA7X
 ;
 ;
BINDX ; Build index of tests for a shipping configuration.
 ; Called from above.
 ;
 I '$D(^LAHM(62.9,LA7SCFG,0)) Q
 N LA760,LA761,LA762,LA76205,LA764,LA7HL,LA7NLT,LA7NLTN,LA7TC,LA7X
 S LA7X=0
 F  S LA7X=$O(^LAHM(62.9,LA7SCFG,60,LA7X)) Q:'LA7X  D BLD
 Q
 ;
 ;
BLD ; Build TMP global for a test
 ; Called from above
 ;
 S LA7X(0)=$G(^LAHM(62.9,LA7SCFG,60,LA7X,0))
 S LA7X(5)=$G(^LAHM(62.9,LA7SCFG,60,LA7X,5))
 ;
 ; Laboratory test/collection sample.
 S LA760=$P(LA7X(0),"^"),LA762=$P(LA7X(0),"^",9)
 ; Incomplete entry.
 I 'LA760!('LA762) Q
 ;
 ; Test urgency/HL7 priority code.
 S LA76205=$P(LA7X(0),"^",4),LA76205("HL")=""
 I LA76205 S LA76205("HL")=$$GET1^DIQ(62.05,LA76205_",","LEDI HL7:HL7 ABBR")
 ;
 ; Topography
 S LA761=$$GET1^DIQ(62,LA762_",",2,"I")
 I 'LA761,"BBCH"[$P(^LAB(60,LA760,0),"^",4) Q  ; Incomplete entry.
 ; Handle MI with no topography associated with collection sample.
 I 'LA761,$P(^LAB(60,LA760,0),"^",4)="MI"  S LA761=+$P(LA7X(0),"^",3)
 ;
 ; Use HL7 specimen code if using table 0070 else use mapping in 62.9
 S LA7HL=""
 I LA761NCS="HL70070" S LA7HL=$$GET1^DIQ(61,LA761_",","LEDI HL7:HL7 ABBR")
 I LA7HL="" S LA7HL=$P(LA7X(5),"^",3)
 ;
 ; File #64 ien/NLT code/NLT code test name.
 ; Use NLT code if using VA coding else use non-VA test order code.
 S LA764=+$$GET1^DIQ(60,LA760_",",64,"I")
 S LA7NLT=$$GET1^DIQ(64,LA764_",",1)
 S LA7NLTN=$$GET1^DIQ(64,LA764_",",.01)
 I LA764NCS="99VA64" S LA7TC=LA7NLT
 E  S LA7TC=$P(LA7X(5),"^")
 ;
 ; Set TMP global with information
 I LA7HL'="",LA7TC'="" D
 . I "MISPCYEM"[$P(^LAB(60,LA760,0),"^",4),$P(LA7X(5),"^",7)'="" D
 . . S ^TMP("LA7TC",$J,LA7SCFG,LA7TC,LA7HL,0,$P(LA7X(5),"^",7))=LA760_"^"_LA761_"^"_LA762_"^^"_LA7NLT_"^"_LA7NLTN
 . E  S ^TMP("LA7TC",$J,LA7SCFG,LA7TC,LA7HL)=LA760_"^"_LA761_"^"_LA762_"^^"_LA7NLT_"^"_LA7NLTN
 . I LA76205("HL")'="" D
 . . I "MISPCYEM"[$P(^LAB(60,LA760,0),"^",4),$P(LA7X(5),"^",7)'="" D
 . . . S ^TMP("LA7TC",$J,LA7SCFG,LA7TC,LA7HL,LA76205("HL"),$P(LA7X(5),"^",7))=LA760_"^"_LA761_"^"_LA762_"^"_LA76205_"^"_LA7NLT_"^"_LA7NLTN
 . . E  S ^TMP("LA7TC",$J,LA7SCFG,LA7TC,LA7HL,LA76205("HL"))=LA760_"^"_LA761_"^"_LA762_"^"_LA76205_"^"_LA7NLT_"^"_LA7NLTN
 ;
 ; Set TMP global when collection sample does not have a topography.
 ; Used for "MISPCYEM" subscripts which can have collection sample with no tpopgraphy.
 I LA7TC'="",'LA761,"MISPCYEM"[$P(^LAB(60,LA760,0),"^",4) D
 . S ^TMP("LA7TC",$J,LA7SCFG,LA7TC,"XXX")=LA760_"^"_LA761_"^"_LA762_"^^"_LA7NLT_"^"_LA7NLTN
 . I LA76205("HL")'="" S ^TMP("LA7TC",$J,LA7SCFG,LA7TC,"XXX",LA76205("HL"))=LA760_"^"_LA761_"^"_LA762_"^"_LA76205_"^"_LA7NLT_"^"_LA7NLTN
 ;
 Q

LA7SMB1 ;DALOI/JMC - Shipping Manifest Build ;03/07/12  08:31
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**74**;Sep 27, 1994;Build 229
 ;
ADD ; Add test to shipping manifest
 ; Called from LA7SMB, LA7SM
 ; Lock on ^LRO(68,LA7AA,1,LA7AD,1,LA7AN,4,LA760) should be set before entering here.
 ;
 N FDA,IENS,LA7628,LA768,LA7DATA,X,Y
 ;
 S LRDFN=+$G(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,0))
 S LA7UID=$P($G(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,.3)),"^")
 I LA7UID="" S LA7UID=$$LRUID^LRX(LA7AA,LA7AD,LA7AN)
 S LA7SMCNT=$G(LA7SMCNT)+1
 S ^TMP("LA7SMADD",$J,LA7SMCNT)=LRDFN_"^"_LA760_"^"_LA76805_"^"_LA76205_"^"_LA7UID
 S LA7628(1)=+LA7SM,IENS="+2,"_LA7628(1)_","
 S FDA(2,62.801,IENS,.01)=LRDFN
 S FDA(2,62.801,IENS,.02)=LA760
 I LA76805 S FDA(2,62.801,IENS,.03)=LA76805
 S FDA(2,62.801,IENS,.04)=LA76205
 S FDA(2,62.801,IENS,.05)=LA7UID
 S FDA(2,62.801,IENS,.08)=1
 I $D(LA7X(0)) D
 . I $P(LA7X(0),"^",5) S FDA(2,62.801,IENS,.06)=$P(LA7X(0),"^",5)
 . I $P(LA7X(0),"^",6) S FDA(2,62.801,IENS,.07)=$P(LA7X(0),"^",6)
 . I $P(LA7X(0),"^",7) S FDA(2,62.801,IENS,.09)=$P(LA7X(0),"^",7)
 I $D(LA7X(1)) D
 . I $P(LA7X(1),"^",1)]"" S FDA(2,62.801,IENS,1.1)=$P(LA7X(1),"^",1)
 . I $P(LA7X(1),"^",2)]"" S FDA(2,62.801,IENS,1.13)=$P(LA7X(1),"^",2)
 . I $P(LA7X(1),"^",5)]"" S FDA(2,62.801,IENS,1.14)=$P(LA7X(1),"^",5)
 . I $P(LA7X(1),"^",3)]"" S FDA(2,62.801,IENS,1.2)=$P(LA7X(1),"^",3)
 . I $P(LA7X(1),"^",4)]"" S FDA(2,62.801,IENS,1.23)=$P(LA7X(1),"^",4)
 . I $P(LA7X(1),"^",6)]"" S FDA(2,62.801,IENS,1.24)=$P(LA7X(1),"^",6)
 I $D(LA7X(2)) D
 . I $P(LA7X(2),"^",1)]"" S FDA(2,62.801,IENS,2.1)=$P(LA7X(2),"^",1)
 . I $P(LA7X(2),"^",2)]"" S FDA(2,62.801,IENS,2.13)=$P(LA7X(2),"^",2)
 . I $P(LA7X(2),"^",7)]"" S FDA(2,62.801,IENS,2.14)=$P(LA7X(2),"^",7)
 . I $P(LA7X(2),"^",3)]"" S FDA(2,62.801,IENS,2.2)=$P(LA7X(2),"^",3)
 . I $P(LA7X(2),"^",4)]"" S FDA(2,62.801,IENS,2.23)=$P(LA7X(2),"^",4)
 . I $P(LA7X(2),"^",8)]"" S FDA(2,62.801,IENS,2.24)=$P(LA7X(2),"^",8)
 . I $P(LA7X(2),"^",5)]"" S FDA(2,62.801,IENS,2.3)=$P(LA7X(2),"^",5)
 . I $P(LA7X(2),"^",6)]"" S FDA(2,62.801,IENS,2.33)=$P(LA7X(2),"^",6)
 . I $P(LA7X(2),"^",9)]"" S FDA(2,62.801,IENS,2.34)=$P(LA7X(2),"^",9)
 I $D(LA7X(5)) D
 . F I=1:1:9 I $P(LA7X(5),"^",I)]"" S FDA(2,62.801,IENS,"5."_I)=$P(LA7X(5),"^",I)
 ;
 ; Check for Non-VA SNOMED mapping on interface for specimen and/or collection sample.
 I $P(LA7SCFG(0),"^",7),$D(^LAHM(62.48,$P(LA7SCFG(0),"^",7),"SCT")) D
 . I LA76805 D
 . . S X=$O(^LAHM(62.48,$P(LA7SCFG(0),"^",7),"SCT","AC",LA76805_";LAB(61,",""))
 . . I X'="" S FDA(2,62.801,IENS,20.1)=X
 . I LA762 D
 . . S X=$O(^LAHM(62.48,$P(LA7SCFG(0),"^",7),"SCT","AC",LA762_";LAB(62,",""))
 . . I X'="" S FDA(2,62.801,IENS,20.2)=X
 ;
 D UPDATE^DIE("","FDA(2)","LA7628","LA7DIE(2)")
 ;
 ; Update event file
 S LA7DATA="SM50^"_$$NOW^XLFDT_"^"_LA760_"^"_$P(LA7SM,"^",2)
 D SEUP^LA7SMU(LA7UID,2,LA7DATA)
 ;
 ; Update accession
 D ACCSUP^LA7SMU(LA7UID,LA760,+LA7SM)
 Q

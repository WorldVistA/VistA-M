LA7VORR1 ;BIRMFO/DLR - LAB ORM (Order Response) message builder ; 12-12-96
 ;;5.2;LAB MESSAGING;**27**;Sep 27, 1994
EN(LA) ;
 S GBL="^TMP(""HLS"","_$J_")",ORDER="^LRO(69.6)"
 ;assuming the receiving institution is the primary site (site with the computer system)
 ; LA("AUTO-INST") - Auto-Instrument
 N PRIMARY S PRIMARY=$$PRIM^VASITE(DT) I $G(PRIMARY)'="" S PRIMARY=$$SITE^VASITE(DT,PRIMARY) S PRIMARY=$P(PRIMARY,U,3)
 S LA("AUTO-INST")="LA7V HOST "_PRIMARY
 D MSA,PID,ACC
EXIT Q
MSA ;
 N ID
 S ID=$O(^LRO(69.6,"RST",LA("SITE"),LA("RUID"),0)) I $G(ID)'="" S ID=$P(^LRO(69.6,ID,1),U,8)
 S @GBL@(LA("I"))="MSA"_HL("FS")_"AA"_HL("FS")_$G(ID)
 S LA("I")=LA("I")+1
 Q
PID ;Original routine saved as all lower case  Frank
 ;S HLFS="^",HLECH="~|&\",HLQ="""""",HLCOMP="~"
 N NODE0,LRHMSG
 Q:$G(LA("LRDFN"))=""
 ;Q:LA("LRDFN")=$G(LA("LLRDFN"))
 I $P(^LR(LA("LRDFN"),0),U,2)=2 S DFN=$P(^LR(LA("LRDFN"),0),U,3) S (LRHMSG,@GBL@(LA("I")))=$$EN^VAFHLPID(DFN,"1,3,5,7,8,19",1),$P(@GBL@(LA("I")),HLFS,4)=$$M11^HLFNC(LA("LRDFN"))
 I $P(^LR(LA("LRDFN"),0),U,2)=67 D
 . S NODE0=^LR(LA("LRDFN"),0),DFN=$P(NODE0,U,3)
 . S LRHMSG="PID"_HLFS_LA("PCNT")_HLFS_HLFS_$$M11^HLFNC(LA("LRDFN"))_HLFS_HLFS_$$HLNAME^HLFNC($P(^LRT(67,DFN,0),U),HLECH)
 . S LRHMSG=LRHMSG_HLFS_HLFS_$$HLDATE^HLFNC($P(NODE0,U,3),"DT")_HLFS_$P(NODE0,U,2)
 . S @GBL@(LA("I"))=LRHMSG
 S LA("I")=LA("I")+1,LA("PCNT")=$G(LA("PCNT"))+1
 S LA("LLRDFN")=LA("LRDFN")
 Q
ACC ;
 N LRAA,LRAD,LRAN
 S LRAA=0 F  S LRAA=$O(^LRO(68,"C",LA("RUID"),LRAA)) Q:'LRAA  S LRAD=0 F  S LRAD=$O(^LRO(68,"C",LA("RUID"),LRAA,LRAD)) Q:'LRAD  S LRAN=0 F  S LRAN=$O(^LRO(68,"C",LA("RUID"),LRAA,LRAD,LRAN)) Q:'LRAN  D OBR
 Q
PV1 ;
 S @GBL@(LA("I"))="PV1"_HLFS_1_HLFS_HLFS_$P(^LRO(68,LRAA,1,LRAD,1,LRAN,0),U,7),LA("I")=LA("I")+1
 Q
ORC ;Order Control
 N ORC
 S @GBL@(LA("I"))="ORC"
 S ORC(1)="OK"
 S ORC(2)=LA("RUID")
 S ORC(3)=LA("HUID")
 S ORC(9)=$$HLDATE^HLFNC($P(^LRO(68,LRAA,1,LRAD,1,LRAN,0),U,4))  ; Order Date/Time
 S ORC(12)=$$HLNAME^HLFNC($$GET1^DIQ(68.02,LRAN_","_LRAD_","_LRAA_",",6.5))
 F X=1:1:27 S @GBL@(LA("I"))=$G(@GBL@(LA("I")))_HLFS_$G(ORC(X))
 S LA("I")=$G(LA("I"))+1
 Q
OBR ;Observation Request segment for Lab Order
 N OBR,RCNT
 S LTN=0 F  S LTN=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LTN)) Q:'LTN  D
 . ;Q:$P(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LTN,0),U,10)'=LA7V("IEN")
 . D ORC
 . S OBR(1)=$G(RCNT)+1,@GBL@(LA("I"))="OBR" ;initialize OBR segment
 . S OBR(2)=LA("RUID") ; Remote UID
 . S OBR(3)=LA("HUID") ; Host UID
 . S LTN=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LTN,0),U),LRACC=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,.2),U),LTST=$P(^LAB(60,LTN,0),U) I $D(^LAB(60,LTN,64)) S NLTIEN=$P(^LAB(60,LTN,64),U) I NLTIEN=""!'$D(^LAM(NLTIEN,0)) K OBR Q
 . S NTST=$P(^LAM(NLTIEN,0),U),NLT=$P(^LAM(NLTIEN,0),U,2)
 . S OBR(4)=NLT_HLCOMP_NTST_HLCOMP_"99VA64"_HLCOMP_LTN_HLCOMP_LTST_HLCOMP_"99VA60" ; WKLD code/text/"99VA64"
 . ;check to see if this TEST is setup in Auto-Instrument
 . S OBR(7)=$$HLDATE^HLFNC($P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,3)),U)) ; Collection D/T
 . ;S OBR(8)=$$HLDATE^HLFNC() ; DT Results Avail
 . S OBR(12)=$P($G(^LR(LA("LRDFN"),.091)),U) ; Infection Warning
 . S OBR(14)=$$HLDATE^HLFNC($P(^LR(LA("LRDFN"),LA("SUB"),LA("LRIDT"),0),U)) ; Lab Arrival Time
 . ;S OBR(15)=$$GET1^DIQ(61,+$P(@SHP@(LA7V("IEN"),10,LA7V("S"),0),U,3)_",",.08)_HLSUB_$$GET1^DIQ(61,+$P(@SHP@(LA7V("IEN"),10,LA7V("S"),0),U,3)_",",.01)_HLSUB_"0070"
 . S LA7CSI=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,5,0)) I LA7CSI'="" S LA7CS=$P(^(LA7CSI,0),U,2)
 . S OBR(15)=$G(OBR(15))_HLCOMP_HLCOMP_$$GET1^DIQ(62,+$G(LA7CS)_",",.01)_HLCOMP_HLCOMP_HLCOMP ; Specimen source 
 . S OBR(18)=LA("AUTO-INST") ; Placer Field #1 (HOST site)
 . S $P(OBR(19),HLCOMP,7)=LA("RUID") ; Placer Field  #2
 . S $P(OBR(27),HLCOMP,6)=$$GET1^DIQ(68.04,LTN_","_LRAN_","_LRAD_","_LRAA_",",1)
 . F X=1:1:27 S @GBL@(LA("I"))=$G(@GBL@(LA("I")))_HLFS_$G(OBR(X))
 . S LA("I")=$G(LA("I"))+1,RCNT=+$G(RCNT)+1
 . D CHKTST
 K LA7CS,LA7CSI
 Q
CHKTST ;
 S X="LA7V HOST "_LA("SITE"),DIC=62.4,DIC(0)="ME" D ^DIC I Y>0 S TIEN=+Y,X=LTST,DIC="^LAB(62.4,"_TIEN_",3," D ^DIC I Y<1 D
 . S DA(1)=TIEN,DIC("P")=$P(^DD(62.4,30,0),U,2),DIC(0)="L",DIC("DR")=".01///"_X_";6///"_NLT D ^DIC
 Q

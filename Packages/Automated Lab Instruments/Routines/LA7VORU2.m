LA7VORU2 ;DALOI/JMC - LAB ORU (Result) message builder cont'd ;Jun 17, 2005
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**46,64,68**;Sep 27, 1994;Build 56
 ;
AP ; Observation/Result segment for Lab AP Results
 ;
 N LA7DATA,LA7IDT,LRSB,LRSS
 ;
 S LRDFN=LA("LRDFN"),LRSS=LA("SUB"),(LA7IDT,LRIDT)=LA("LRIDT")
 ;
 S (LA7NLT,LA("NLT"))=$P($$DEFCODE^LA7VHLU5(LRSS,.012,"",""),"!")
 D OBR^LA7VORU
 D NTE^LA7VORU
 ;
APORM ; Entry point when building OBX segments for ORM message
 ; Process AP subscripts
 ;
 N LA7ORG,LA7P,LA7SR,LA7SS
 S LA7OBXSN=0
 ;
 ; Process main report
 I LA7NVAF'=1 F LRSB=.012,.013,.014,.015,.016,1,1.1,1.3,1.4 D OBX^LA7VORU1
 I LA7NVAF=1 D SPDOD
 ;
 ; Process supplementary reports
 S LRSB=1.2,LA7SR=0
 F  S LA7SR=$O(^LR(LRDFN,LRSS,LRIDT,1.2,LA7SR)) Q:'LA7SR  D
 . N LA7IDT
 . ; If don't release this report then skip.
 . I $P($G(^LR(LRDFN,LRSS,LRIDT,1.2,LA7SR,0)),"^",2)'=1 Q
 . S LA7IDT=LRIDT_","_LA7SR D OBX^LA7VORU1
 ;
 ; Process organ/tissue subfile
 S LA7ORG=0
 F  S LA7ORG=$O(^LR(LRDFN,LRSS,LRIDT,2,LA7ORG)) Q:'LA7ORG  D
 . N LA7IDT
 . S LRSB=10,LA7IDT=LRIDT_","_LA7ORG D OBX^LA7VORU1
 . I LRSS="SP" S LRSB="10,2",LA7IDT=LRIDT_","_LA7ORG D OBX^LA7VORU1
 . ; Procedures
 . ;S LA7P=0,LRSB="10,1.5"
 . ;F  S LA7P=$O(^LR(LRDFN,LRSS,LRIDT,2,LA7ORG,4,LA7P)) Q:'LA7P  D
 . ;. S LA7IDT=LRIDT_","_LA7ORG_","_LA7P D OBX^LA7VORU1
 . ; Special studies
 . S LA7SS=0,LRSB="10,5"
 . F  S LA7SS=$O(^LR(LRDFN,LRSS,LRIDT,2,LA7ORG,5,LA7SS)) Q:'LA7SS  D
 . . S LA7IDT=LRIDT_","_LA7ORG_","_LA7SS D OBX^LA7VORU1
 ;
 Q
 ;
 ;
SPDOD ; Build OBX segment's to special DoD specifications.
 ; Send word-processing fields as series of OBX's for DoD.
 ; DoD cannot handle formatted text (FT) data type.
 N LA7DA
 ;
 S LRSB=.012 D OBX^LA7VORU1
 ;
 F LRSB=.013,.014,.015,.016,1,1.1,1.3,1.4 D
 . N LA7IDT,LA7SB
 . S LA7DA=0,LA7SB=$S(LRSB=.013:.2,LRSB=.014:.3,LRSB=.015:.4,LRSB=.016:.5,1:LRSB)
 . F  S LA7DA=$O(^LR(LRDFN,LRSS,LRIDT,LA7SB,LA7DA)) Q:'LA7DA  D
 . . S LA7IDT=LRIDT_","_LA7DA D OBX^LA7VORU1
 ;
 Q

LA7VORU2 ;DALOI/JMC - LAB ORU (Result) message builder cont'd ;12/09/09  14:18
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**46,64,68,74**;Sep 27, 1994;Build 229
 ;
AP ; Observation/Result segment for Lab AP Results
 ;
 N LA7DATA,LA7IDT,LRSB,LRSS
 ;
 S LRDFN=LA("LRDFN"),LRSS=LA("SUB"),(LA7IDT,LRIDT)=LA("LRIDT")
 ;
 I $G(LA("NLT"))'="" S LA7NLT=LA("NLT")
 E  S (LA7NLT,LA("NLT"))=$P($$DEFCODE^LA7VHLU5(LRSS,.012,"",""),"!")
 ;
 D OBR^LA7VORU
 I LA7NVAF=1 D PLC^LA7VORUA
 D NTE^LA7VORU
 D PMR
 ;
 I $D(^LR(LRDFN,LRSS,LRIDT,1.2)) D PSR
 Q
 ;
 ;
APORM ; Entry point when building OBX segments for ORM message
 ;
 D PMR
 ;
 ; Process supplementary reports
 N LA7SR,LA7SS
 S LA7OBXSN=0,LRSB=1.2,LA7SR=0
 F  S LA7SR=$O(^LR(LRDFN,LRSS,LRIDT,1.2,LA7SR)) Q:'LA7SR  D
 . N LA7IDT
 . ; If don't release this report then skip.
 . I $P($G(^LR(LRDFN,LRSS,LRIDT,1.2,LA7SR,0)),"^",2)'=1 Q
 . S LA7IDT=LRIDT_","_LA7SR D OBX^LA7VORU1
 ;
 Q
 ;
 ;
PMR ; Process main report
 N LA7ORG,LA7SS
 S LA7OBXSN=0
 ;
 D SPEC
 I LA7NVAF'=1 F LRSB=.013,.014,.015,.016,1,1.1,1.3,1.4 D OBX^LA7VORU1
 I LA7NVAF=1 D DOD
 ;
 ; Process organ/tissue subfile
 S LA7ORG=0
 F  S LA7ORG=$O(^LR(LRDFN,LRSS,LRIDT,2,LA7ORG)) Q:'LA7ORG  D
 . N LA7IDT
 . S LRSB=10,LA7IDT=LRIDT_","_LA7ORG D OBX^LA7VORU1
 . I LRSS="SP" S LRSB="10,2",LA7IDT=LRIDT_","_LA7ORG D OBX^LA7VORU1
 . ; Special studies
 . S LA7SS=0,LRSB="10,5"
 . F  S LA7SS=$O(^LR(LRDFN,LRSS,LRIDT,2,LA7ORG,5,LA7SS)) Q:'LA7SS  D
 . . S LA7IDT=LRIDT_","_LA7ORG_","_LA7SS D OBX^LA7VORU1
 ;
 Q
 ;
 ;
PSR ; Process supplementary reports
 N LA7SR,LA7SS
 I $G(LA("NLT"))'="" S LA7NLT=LA("NLT")
 E  S (LA7NLT,LA("NLT"))=$P($$DEFCODE^LA7VHLU5(LRSS,1.2,"",""),"!")
 S LA7OBXSN=0,LRSB=1.2,LA7SR=0
 F  S LA7SR=$O(^LR(LRDFN,LRSS,LRIDT,1.2,LA7SR)) Q:'LA7SR  D
 . N LA7IDT
 . ; If don't release this report then skip.
 . I $P($G(^LR(LRDFN,LRSS,LRIDT,1.2,LA7SR,0)),"^",2)'=1 Q
 . D OBR^LA7VORU
 . I LA7NVAF=1 D PLC^LA7VORUA,DODSR Q
 . S LA7IDT=LRIDT_","_LA7SR D OBX^LA7VORU1
 Q
 ;
 ;
SPEC ; Send specimen multiple as series of OBX segments. One OBX segment for each specimen
 ; If DoD then send two OBX for each specimen, 1st with free text specimen description, 2nd  with SNOMED CT,
 ;
 N LA7DA,LA7IDT,LRSB
 ;
 S LA7DA=0,LRSB=.012
 F  S LA7DA=$O(^LR(LRDFN,LRSS,LRIDT,.1,LA7DA)) Q:'LA7DA  D
 . S LA7IDT=LRIDT_","_LA7DA S:LA7NVAF=1 LRSB=".012,.01" D OBX^LA7VORU1
 . I LA7NVAF=1 S LRSB=".012,.06" D OBX^LA7VORU1
 Q
 ;
 ;
DOD ; Build OBX segment's to special DoD specifications.
 ; Send word-processing fields as series of ST data type OBX's for DoD.
 ; DoD cannot handle formatted text (FT) data type.
 N LA7DA
 ;
 F LRSB=.013,.014,.015,.016,1,1.1,1.3,1.4 D
 . N LA7IDT,LA7SB
 . S LA7DA=0,LA7SB=$S(LRSB=.013:.2,LRSB=.014:.3,LRSB=.015:.4,LRSB=.016:.5,1:LRSB)
 . F  S LA7DA=$O(^LR(LRDFN,LRSS,LRIDT,LA7SB,LA7DA)) Q:'LA7DA  D
 . . S LA7IDT=LRIDT_","_LA7DA  D OBX^LA7VORU1
 ;
 Q
 ;
 ;
DODSR ; Build OBX segment's to special DoD specifications.
 ; Send Supplementary reports fields as series of ST data type OBX's for DoD.
 ; DoD cannot handle formatted text (FT) data type.
 ;
 N LA7IDT,LA7DA
 S LA7DA=0
 F  S LA7DA=$O(^LR(LRDFN,LRSS,LRIDT,1.2,LA7SR,1,LA7DA)) Q:'LA7DA  D
 . S LA7IDT=LRIDT_","_LA7SR_","_LA7DA  D OBX^LA7VORU1
 ;
 Q
 ;
 ;
RPTNTE ; Send report comments
 ; Called from LA7VORU1 to send MI NTE segments
 ;
 N LA7CMTYP,LA7FMT,LA7J,LA7ND,LA7SOC,LA7TXT,LA7X
 ;
 ; Source of comment - handle special codes for other systems, ie DOD-CHCS
 S LA7SOC=$S($G(LA7NVAF)=1:"RC",1:"L"),LA7ND=0
 ;
 S LA7FMT=0,LA7CMTYP=""
 ; If HDR interface then send as repetition text.
 I $G(LA7INTYP)=30 S LA7FMT=2
 ;
 D
 . ; Bacterial preliminary/report/tests remark
 . I LRSB=11 S LA7ND=4,LA7CMTYP="VA-LRMI010" Q
 . I LRSB=1 S LA7ND=19,LA7CMTYP="VA-LRMI011" Q
 . I LRSB=1.5 S LA7ND=26,LA7CMTYP="VA-LRMI012" Q
 . I LRSB=11.7 S LA7ND=25,LA7CMTYP="VA-LRMI013" Q
 . ; Parasite preliminary/report/tests remark
 . I LRSB=14 S LA7ND=7,LA7CMTYP="VA-LRMI020" Q
 . I LRSB=16.5 S LA7ND=21,LA7CMTYP="VA-LRMI021" Q
 . I LRSB=16.4 S LA7ND=27,LA7CMTYP="VA-LRMI022" Q
 . I LRSB=15.1 S LA7ND=24,LA7CMTYP="VA-LRMI023" Q
 . I LRSB="16,1" S LA7ND=6,LA7CMTYP="VA-LRMI53" Q
 . ; Fungal preliminary/report/tests remark
 . I LRSB=18 S LA7ND=10,LA7CMTYP="VA-LRMI030" Q
 . I LRSB=20.5 S LA7ND=22,LA7CMTYP="VA-LRMI031" Q
 . I LRSB=20.4 S LA7ND=28,LA7CMTYP="VA-LRMI032" Q
 . I LRSB=19.6 S LA7ND=15,LA7CMTYP="VA-LRMI033" Q
 . ; Mycobacteria preliminary/report/tests remark
 . I LRSB=22 S LA7ND=13,LA7CMTYP="VA-LRMI040" Q
 . I LRSB=26.5 S LA7ND=23,LA7CMTYP="VA-LRMI041" Q
 . I LRSB=26.4 S LA7ND=29,LA7CMTYP="VA-LRMI042" Q
 . ; Viral preliminary/report/tests remark
 . I LRSB=33 S LA7ND=18,LA7CMTYP="VA-LRMI050" Q
 . I LRSB=36.5 S LA7ND=20,LA7CMTYP="VA-LRMI051" Q
 . I LRSB=36.4 S LA7ND=30,LA7CMTYP="VA-LRMI052" Q
 ;
 I LA7ND'>0 Q
 ;
 S LA7J=0
 F  S LA7J=$O(^LR(LRDFN,LRSS,LRIDT,LA7ND,LA7J)) Q:'LA7J  D
 . S LA7X=$G(^LR(LRDFN,LRSS,LRIDT,LA7ND,LA7J,0))
 . I LA7FMT S LA7TXT(LA7J)=LA7X
 . E  S LA7TXT=LA7X D NTE^LA7VORU1
 ;
 ; If formatted or repetition format then build comments to a NTE segment.
 I LA7FMT,$D(LA7TXT) D NTE^LA7VORU1
 ;
 Q
 ;
 ;
RPT ; Report specimen results as OBX segments to DoD - taken from various XXX RPT REMARK fields (13, 17, 21, 27, 37)
 ; Called from LA7VORU1.
 N LA7DA,LA7IDT,LA7ND
 ;
 S LA7ND=$S(LRSB=11:4,LRSB=14:7,LRSB=18:10,LRSB=22:13,LRSB=33:18,1:0)
 I 'LA7ND Q
 S LA7DA=0
 F  S LA7DA=$O(^LR(LRDFN,LRSS,LRIDT,LA7ND,LA7DA)) Q:'LA7DA  S LA7IDT=LRIDT_","_LA7DA  D OBX^LA7VORU1
 Q

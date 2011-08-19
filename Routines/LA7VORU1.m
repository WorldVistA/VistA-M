LA7VORU1 ;DALOI/JMC - Builder of HL7 Lab Results Microbiology OBR/OBX/NTE ;12/08/09  16:39
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**46,64,68**;Sep 27, 1994;Build 56
 Q
 ;
 ;
MI ; Build segments for "MI" subscript
 ;
 N LA7I,LA7ID,LA7IDT,LA7IENS,LA7NLT,LRDFN,LRIDT,LRSB,LRSS
 ;
 S LRDFN=LA("LRDFN"),LRSS=LA("SUB"),(LA7IENS,LRIDT)=LA("LRIDT")
 ;
 ; Bacteriology Report
 I $D(^LR(LRDFN,LRSS,LRIDT,1)) D
 . S LA7IDT=LRIDT,LRSB=11,LA7NLT="87993.0000"
 . D OBR^LA7VORU
 . D NTE^LA7VORU
 . F LRSB=1,11.7,1.5,11 D RPTNTE
 . N LRSB
 . S LA7OBXSN=0
 . ; Report urine/sputum screens
 . F LA7I=5,6 I $P(^LR(LRDFN,LRSS,LRIDT,1),"^",LA7I)'="" S LRSB=$S(LA7I=5:11.58,1:11.57) D OBX
 . ; Report gram stain
 . I $D(^LR(LRDFN,LRSS,LRIDT,2)) D GS
 . ; Check for organism id
 . I '$D(^LR(LRDFN,LRSS,LRIDT,3)) Q
 . S LRSB=12
 . D ORG
 . D MIC
 ;
 ; Parasite report
 I $D(^LR(LRDFN,LRSS,LRIDT,5)) D
 . S LRSB=14,LA7NLT="87505.0000"
 . D OBR^LA7VORU
 . D NTE^LA7VORU
 . F LRSB=16.5,15.51,16.4,14 D RPTNTE
 . ; Check for organism id
 . I '$D(^LR(LRDFN,LRSS,LRIDT,6)) Q
 . N LRSB
 . S LA7OBXSN=0,LA7IDT=LRIDT,LRSB=16
 . D ORG
 ;
 ; Mycology report
 I $D(^LR(LRDFN,LRSS,LRIDT,8)) D
 . S LRSB=18,LA7NLT="87994.0000"
 . D OBR^LA7VORU
 . D NTE^LA7VORU
 . F LRSB=20.5,19.6,20.4,18 D RPTNTE
 . ; Check for organism id
 . I '$D(^LR(LRDFN,LRSS,LRIDT,9)) Q
 . N LRSB
 . S LA7OBXSN=0,LA7IDT=LRIDT,LRSB=20
 . D ORG
 ;
 ; Mycobacterium report
 I $D(^LR(LRDFN,LRSS,LRIDT,11)) D
 . S LRSB=22,LA7NLT="87995.0000"
 . D OBR^LA7VORU
 . D NTE^LA7VORU
 . F LRSB=26.5,26.4,22 D RPTNTE
 . N LRSB
 . S LA7OBXSN=0,LA7IDT=LRIDT
 . ; Report acid fast stain
 . I $P(^LR(LRDFN,LRSS,LRIDT,11),"^",3)'="" D
 . . S LRSB=24 D OBX
 . . S LRSB=25 D OBX
 . ; Check for organism id
 . I '$D(^LR(LRDFN,LRSS,LRIDT,12)) Q
 . S LRSB=26
 . D ORG
 . D MIC
 ;
 ; Virology report
 I $D(^LR(LRDFN,LRSS,LRIDT,16)) D
 . S LRSB=33,LA7NLT="87996.0000"
 . D OBR^LA7VORU
 . D NTE^LA7VORU
 . F LRSB=36.5,36.4,33 D RPTNTE
 . ; Check for virus id
 . I '$D(^LR(LRDFN,LRSS,LRIDT,17)) Q
 . N LRSB
 . S LA7OBXSN=0,LA7IDT=LRIDT,LRSB=36
 . D ORG
 ;
 ; Antibiotic Levels
 I $D(^LR(LRDFN,LRSS,LRIDT,14)) D
 . N LA7SR
 . S LRSB=28,LA7NLT="93978.0000",LA7NTESN=0
 . D OBR^LA7VORU
 . S LA7SR=0
 . F  S LA7SR=$O(^LR(LRDFN,LRSS,LRIDT,14,LA7SR)) Q:'LA7SR  S LA7IDT=LRIDT_","_LA7SR D OBX
 ;
 Q
 ;
 ;
GS ; Report Gram stain
 ;
 N LA7GS
 ;
 S LRSB=11.6,LA7GS=0
 F  S LA7GS=$O(^LR(LRDFN,LRSS,LRIDT,2,LA7GS)) Q:'LA7GS  D
 . S LA7IDT=LRIDT_","_LA7GS
 . D OBX
 Q
 ;
 ;
RPTNTE ; Send report comments
 ;
 N LA7CMTYP,LA7FMT,LA7J,LA7ND,LA7SOC,LA7TXT,LA7X
 ;
 ; Source of comment - handle special codes for other systems, i,e. DOD-CHCS
 S LA7SOC=$S($G(LA7NVAF)=1:"AC",1:"L"),LA7ND=0
 ;
 S LA7FMT=0
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
 . I LA7FMT=0 S LA7TXT=LA7X D NTE^LA7VORU1 Q
 . S LA7TXT(LA7J)=LA7X
 ;
 ; If formatted or repetition format then build comments to a NTE segment.
 I LA7FMT,$D(LA7TXT) D NTE^LA7VORU1
 ;
 Q
 ;
 ;
ORG ; Build OBR/OBX segments for MI subscript organism id
 ;
 N LA7ND,LA7ORG
 ;
 ; Bacterial organism
 I LRSB=12 S LA7ND=3
 ; Parasite organism
 I LRSB=16 S LA7ND=6
 ; Fungal organism
 I LRSB=20 S LA7ND=9
 ; Mycobacteria organism
 I LRSB=26 S LA7ND=12
 ; Viral agent
 I LRSB=36 S LA7ND=17
 ;
 S LA7ORG=0
 F  S LA7ORG=$O(^LR(LRDFN,LRSS,LRIDT,LA7ND,LA7ORG)) Q:'LA7ORG  D
 . S LA7IDT=LRIDT_","_LA7ORG_","
 . D OBX
 . I LA7ND=17 Q  ; no quantity/comments on viruses
 . D ORGNTE
 . I $P($G(^LR(LRDFN,LRSS,LRIDT,LA7ND,LA7ORG,0)),"^",2)'="" D CC
 Q
 ;
 ;
CC ; Send colony count (quantity)
 ;
 N LRSB
 ;
 I LA7ND=3 S LRSB="12,1"
 I LA7ND=9 S LRSB="20,1"
 I LA7ND=12 S LRSB="26,1"
 ;
 D OBX
 ;
 Q
 ;
 ;
ORGNTE ; Send comments on organisms.
 ;
 N LA7CMTYP,LA7FMT,LA7J,LA7SOC,LA7NTESN,LA7TXT,LA7X
 ;
 ; Source of comment - handle special codes for other systems, i,e. DOD-CHCS
 S LA7SOC=$S($G(LA7NVAF)=1:"RC",1:"L")
 ;
 S LA7FMT=0,LA7CMTYP=""
 ; If HDR interface then send as repetition text.
 I $G(LA7INTYP)=30 S LA7FMT=2
 ;
 S (LA7J,LA7NTESN)=0
 F  S LA7J=$O(^LR(LRDFN,LRSS,LRIDT,LA7ND,LA7ORG,1,LA7J)) Q:'LA7J  D
 . S LA7X=$G(^LR(LRDFN,LRSS,LRIDT,LA7ND,LA7ORG,1,LA7J,0))
 . I LA7X="" S LA7X=" "
 . I LA7FMT=0 S LA7TXT=LA7X D NTE Q
 . S LA7TXT(LA7J)=LA7X
 ;
 ; If formatted or repetition format then build comments to a NTE segment.
 I LA7FMT,$D(LA7TXT) D NTE^LA7VORU1
 ;
 Q
 ;
 ;
MIC ; Build OBR/OBX segments for MI subscript susceptibilities(MIC)
 ;
 N LA7ORG,LA7ND,LA7NLT,LA7SB,LA7SB1,LA7SOC
 ;
 ; Source of comment - handle special codes for other systems, i,e. DOD-CHCS
 S LA7SOC=$S($G(LA7NVAF)=1:"RC",1:"L")
 ;
 S (LA7NLT,LA7NLT(1))=""
 I LRSB=12 S LA7ND=3,LA7NLT="87565.0000",LA7NLT(1)="87993.0000"
 I LRSB=26 S LA7ND=12,LA7NLT="87899.0000",LA7NLT(1)="87525.0000"
 ;
 S LA7ORG=0,LA7SB=LRSB
 F  S LA7ORG=$O(^LR(LRDFN,LRSS,LRIDT,LA7ND,LA7ORG)) Q:'LA7ORG  D
 . N LA7NTESN,LA7PARNT
 . ; Check for susceptibilities for this organism
 . S X=$O(^LR(LRDFN,LRSS,LRIDT,LA7ND,LA7ORG,2))
 . I X<2!(X>3) Q
 . S LA7PARNT=LA7SB_"-"_LA7ORG
 . M LA7PARNT=LA7ID(LA7PARNT)
 . D OBR^LA7VORU
 . S LA7OBXSN=0,LA7SB1=2
 . F  S LA7SB1=$O(^LR(LRDFN,LRSS,LRIDT,LA7ND,LA7ORG,LA7SB1)) Q:'LA7SB1!(LA7SB1>2.99)  D
 . . N LA7CMTYP,LA7FMT,LA7TXT,LRSB
 . . S LA7IDT=LRIDT_","_LA7ORG_","_LA7SB1,LRSB=LA7SB_","_LA7SB1
 . . D OBX
 . . S X=$O(^LAB(62.06,"AD",LA7SB1,0)) Q:'X
 . . S LA7TXT=$P($G(^LAB(62.06,X,0)),"^",3)
 . . I LA7TXT'="" S (LA7NTESN,LA7FMT)=0,LA7CMTYP="" D NTE
 . I LA7ND'=3 Q  ; no free text antibiotics on AFB
 . S LA7SB1=0
 . F  S LA7SB1=$O(^LR(LRDFN,LRSS,LRIDT,LA7ND,LA7ORG,3,LA7SB1)) Q:'LA7SB1  D
 . . N LRSB
 . . S LA7IDT=LRIDT_","_LA7ORG_","_LA7SB1
 . . S LRSB=LA7SB_",3,1" D OBX
 . . S LRSB=LA7SB_",3,2" D OBX
 . 
 Q
 ;
 ;
OBX ; Build OBX segments for MI subscript
 ; Also called by AP^LA7VORU2 to build AP OBX segments.
 ;
 N LA7DATA
 D OBX^LA7VOBX(LRDFN,LRSS,LA7IDT,LRSB,.LA7DATA,.LA7OBXSN,LA7FS,LA7ECH,LA7NVAF)
 ;
 ; If OBX failed to build then don't store
 I '$D(LA7DATA) Q
 ;
 D FILESEG^LA7VHLU(GBL,.LA7DATA)
 ;
 ; Check for flag to only build meesage but do not file
 I '$G(LA7NOMSG) D FILE6249^LA7VHLU(LA76249,.LA7DATA)
 Q
 ;
 ;
NTE ; Build NTE segment with comment
 ;
 N LA7DATA
 ;
 D NTE^LA7VHLU3(.LA7DATA,.LA7TXT,$G(LA7SOC),LA7FS,LA7ECH,.LA7NTESN,$G(LA7CMTYP),$G(LA7FMT))
 D FILESEG^LA7VHLU(GBL,.LA7DATA)
 ;
 ; Check for flag to only build meesage but do not file
 I '$G(LA7NOMSG) D FILE6249^LA7VHLU(LA76249,.LA7DATA)
 ;
 Q

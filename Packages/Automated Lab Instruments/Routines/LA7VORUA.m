LA7VORUA ;DALOI/JMC - Builder of HL7 Lab Results ;10/12/11  14:28
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**61,64,68,74**;Sep 27, 1994;Build 229
 ;
 Q
 ;
 ;
OBX ;Observation/Result segment for Lab Results
 ;
 ;ZEXCEPT: GBL,LA,LA76249,LA7NOMSG,LA7NTESN,LA7NVAF
 ;
 N LA7953,LA7DATA,LA7VT,LA7VTIEN,LA7X
 ;
 S LA7VTIEN=0
 F  S LA7VTIEN=$O(^LAHM(62.49,LA(62.49),1,LA7VTIEN)) Q:'LA7VTIEN  D
 . S LA7VT=$P(^LAHM(62.49,LA(62.49),1,LA7VTIEN,0),"^",1,2)
 . ;
 . ; Send back an OBX if individual test from a panel was NP'ed - ccr_6164n
 . N LA7VNP ; LA7VNP is a flag used by CH^LA7VOBX1 to determine if test was NP'ed.
 . S LA7VNP=0
 . S LA7VNP=$$CHECKNP(LA("HUID"),+$P(LA7VT,"^",1))
 . ;
 . ; Build OBX segment
 . K LA7DATA
 . D OBX^LA7VOBX(LA("LRDFN"),LA("SUB"),LA("LRIDT"),$P(LA7VT,"^",1,2),.LA7DATA,.LA7OBXSN,LA7FS,LA7ECH,$G(LA7NVAF))
 . ; If OBX failed to build then don't store
 . I '$D(LA7DATA) Q
 . ;
 . D FILESEG^LA7VHLU(GBL,.LA7DATA)
 . I '$G(LA7NOMSG) D FILE6249^LA7VHLU(LA76249,.LA7DATA)
 . ;
 . ; Send performing lab comment and interpretation from file #60
 . S LA7NTESN=0
 . I LA7NVAF=1 D PLC^LA7VORUA
 . I LA7VNP Q  ; ccr_6164n
 . D INTRP^LA7VORUA
 . ;
 . ; Mark result as sent - set to 1, if corrected results set to 2
 . I LA("SUB")="CH" D
 . . I $P(^LR(LA("LRDFN"),LA("SUB"),LA("LRIDT"),$P(LA7VT,"^")),"^",10)>1 Q
 . . S $P(^LR(LA("LRDFN"),LA("SUB"),LA("LRIDT"),$P(LA7VT,"^")),"^",10)=$S($P(LA7VT,"^",2)="C":2,1:1)
 ;
 Q
 ;
 ;
NTE ; Build NTE segment
 ;
 ;ZEXCEPT: LA,LA7INTYP,LA7NVAF
 ;
 N LA7CMTYP,LA7FMT,LA7J,LA7NTE,LA7SOC,LA7TXT,LA7TYP,LA7X,LA7Y,X
 ;
 ; Source of comment - handle other system's special codes, i.e. DOD-CHCS
 S LA7SOC=$S($G(LA7NVAF)=1:"AC",1:"L")
 ;
 S LA7FMT=0
 ; If HDR interface then send as repetition text.
 I $G(LA7INTYP)=30 S LA7FMT=2
 ;
 ; Send "MI" specimen's comments
 I LA("SUB")="MI" D
 . K LA7NTE
 . S LA7X=$G(^LR(LA("LRDFN"),LA("SUB"),LA("LRIDT"),99)),LA7CMTYP="VA-LRMI001",LA7J=1
 . I LA7X="" Q
 . I LA7FMT S LA7Y(LA7CMTYP,LA7J)=LA7X
 . E  S LA7TXT=LA7X D NTE^LA7VORU1
 ;
 ; Send "CH" specimen's comments
 I LA("SUB")="CH" D
 . S LA7J=0
 . F  S LA7J=$O(^LR(LA("LRDFN"),LA("SUB"),LA("LRIDT"),1,LA7J)) Q:'LA7J  D
 . . K LA7NTE
 . . S LA7X=$G(^LR(LA("LRDFN"),LA("SUB"),LA("LRIDT"),1,LA7J,0)),LA7CMTYP="VA-LR002"
 . . I $E(LA7X,1)="~" S LA7CMTYP="VA-LR001"
 . . I LA7X="" S LA7X=" "
 . . I LA7FMT S LA7Y(LA7CMTYP,LA7J)=LA7X
 . . E  S LA7TXT=LA7X D NTE^LA7VORU1
 ;
 ; If formatted or repetition format then build each type of comments to an NTE segment.
 I LA7FMT D
 . S LA7CMTYP=""
 . F  S LA7CMTYP=$O(LA7Y(LA7CMTYP)) Q:LA7CMTYP=""  D
 . . K LA7TXT
 . . M LA7TXT=LA7Y(LA7CMTYP)
 . . D NTE^LA7VORU1
 ;
 Q
 ;
 ;
PLC ; Reporting lab comment
 ;
 ;ZEXCEPT: LA,LA7VT
 ;
 N LA74,LA7DIV,LA7NTE,LA7RNLT,LA7SOC,LA7TSTN,LA7X,X
 S (LA74,LA7DIV,LA7RNLT,LA7TSTN)=""
 ;
 ; Find reporting facility (division).
 I LA("SUB")="CH" D
 . S LA7X=$G(^LR(LA("LRDFN"),LA("SUB"),LA("LRIDT"),$P(LA7VT,"^")))
 . S LA74=$P(LA7X,"^",9)
 . ; If verifying institution not stored with result, use releasing inst. or inst. of user - ccr_6164n
 . I LA74="" S LA74=$P($G(^LR(LA("LRDFN"),LA("SUB"),LA("LRIDT"),"RF")),"^")
 . I LA74="",$$DIV4^XUSER(.LA74,$P(LA7X,"^",4)) S LA74=$O(LA74(0))
 . ;
 . ; if NLT code of reported test is not stored with result, use default code - ccr_6164n
 . I $P($P(LA7X,"^",3),"!",2)="" D
 . . S $P(LA7X,"^",3)=$$DEFCODE^LA7VHLU5(LA("SUB"),$P(LA7VT,"^"),$P(LA7X,"^",3),$P($G(^LR(LA("LRDFN"),LA("SUB"),LA("LRIDT"),0)),"^",5))
 . ;
 . S LA7RNLT=$P($P(LA7X,"^",3),"!",2)
 ;
 I LA("SUB")="MI" D
 . S LA74=$P($G(^LR(LA("LRDFN"),LA("SUB"),LA("LRIDT"),"RF")),"^") Q:LA74
 . S LA7X=$G(^LR(LA("LRDFN"),LA("SUB"),LA("LRIDT"),0))
 . S LA74=$P(LA7X,"^",15)
 ;
 I "SPCYEM"[LA("SUB") S LA74=$P($G(^LR(LA("LRDFN"),LA("SUB"),LA("LRIDT"),"RF")),"^")
 ;
 D BPLC
 Q
 ;
 ;
BPLC ; Build NTE segment with performing lab disclosure statement
 ;
 ;ZEXCEPT: LA,LA74,LA7DIV,LA7NLT,LA7NVAF,LA7RNLT,LA7SOC,LA7TSTN,LA7TXT
 ;
 N LA7CMTYP,LA7FMT,LA7TXT,LA7X,X
 ;
 S LA7CMTYP="",LA7FMT=0
 ;
 ; Source of comment - handle other system's special codes, i.e. DOD-CHCS
 S LA7SOC=$S($G(LA7NVAF)=1:"DS",1:"L")
 ;
 I LA74="" S LA74=+$$KSP^XUPARAM("INST")
 I LA74 S LA7DIV=$$NAME^XUAF4(LA74)
 ;
 ; Build result test name
 I LA7RNLT="" D
 . I $G(LA("NLT"))'="" S LA7RNLT=LA("NLT") Q
 . S LA7RNLT=$G(LA7NLT)
 I LA7RNLT D
 . S LA7X=$O(^LAM("E",LA7RNLT,0))
 . I LA7X S LA7TSTN=$$GET1^DIQ(64,LA7X_",",.01,"I")
 ;
 S LA7TXT=LA7TSTN_" results from "_LA7DIV_"."
 D NTE^LA7VORU1
 S X=$$PADD^XUAF4(LA74)
 S LA7TXT=$P(X,U)_" "_$P(X,U,2)_", "_$P(X,U,3)_" "_$P(X,U,4)
 S X=$$ID^XUAF4("CLIA",LA74)
 I X'="" S LA7TXT=LA7TXT_" (CLIA# "_X_")"
 D NTE^LA7VORU1
 Q
 ;
 ;
INTRP ; Send test interpretation
 ; Send "CH" subscript file #60 site/specimen's interpretation field (#5.5)
 ;
 ;ZEXCEPT: LA,LA763,LA7INTYP,LA7NVAF,LA7V,LA7VT
 ;
 N LA760,LA761,LA7CMTYP,LA7FMT,LA7J,LA7NTE,LA7SOC,LA7TXT,LA7X,LA7Y,LRSB
 ;
 S LRSB=$P(LA7VT,"^"),(LA7FMT,LA7Y)=0
 S LA761=+$P(LA763(0),"^",5)
 S LA7X=^LR(LA("LRDFN"),LA("SUB"),LA("LRIDT"),LRSB)
 S LA760=+$P($P(LA7X,"^",3),"!",7)
 I LA760,$D(^LAB(60,LA760,1,LA761,1)) S LA7Y=1
 I 'LA760 D
 . S LA760=0
 . F  S LA760=$O(^LAB(60,"C","CH;"_LRSB_";1",LA760)) Q:'LA760  D  Q:LA7Y
 . . I $D(^LAB(60,LA760,1,LA761,1)) S LA7Y=1
 ;
 I 'LA7Y Q
 ;
 ; Source of comment - handle other system's special codes, i.e. DOD-CHCS
 S LA7SOC=$S($G(LA7NVAF)=1:"RI",1:"L"),LA7CMTYP="VA-LR003"
 ;
 ; If HDR interface then send as repetition text.
 I $G(LA7INTYP)=30 S LA7FMT=2
 ;
 ; Build each line of interpretation as a NTE segment unless formatting flag (LA7FMT) indicates
 ;  either formatted text or repetition.
 S LA7J=0
 F  S LA7J=$O(^LAB(60,LA760,1,LA761,1,LA7J)) Q:'LA7J  D
 . S LA7X=$G(^LAB(60,LA760,1,LA761,1,LA7J,0))
 . I LA7X="" S LA7X=" "
 . I LA7FMT S LA7TXT(LA7J)=LA7X
 . E  S LA7TXT=LA7X D NTE^LA7VORU1
 ;
 I LA7FMT,$D(LA7TXT) D NTE^LA7VORU1
 ;
 Q
 ;
 ;
CHECKNP(HUID,LRSB) ; Check if test was NP'ed - added with ccr_6164n
 ;
 ; Call with HUID = Host UID
 ;           LRSB = "CH" subscript node (Data Name)
 ;
 ; Returns LA7VNP = 0 - Test was not NP'ed
 ;                  1 - This test was NP'ed
 ;
 ;
 N LA760,LA7AA,LA7AD,LA7AN,LA7VNP,LA7Y
 ;
 S LA7VNP=0
 ;
 S LA7Y=$$CHECKUID^LRWU4(HUID)
 S LA760=+$O(^LAB(60,"C","CH;"_+LRSB_";1",0))
 I 'LA7Y!('LA760) Q LA7VNP
 ;
 S LA7AA=+$P(LA7Y,U,2)
 S LA7AD=+$P(LA7Y,U,3)
 S LA7AN=+$P(LA7Y,U,4)
 ;
 I $P($G(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,4,LA760,0)),U,6)="*Not Performed" S LA7VNP=1 Q LA7VNP
 ;
 I '$D(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,4,LA760,0)),'LA7VNP D
 . N LA7TST
 . S LA7TST=0
 . F  S LA7TST=$O(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,4,LA7TST)) Q:'LA7TST!(LA7VNP)  D
 . . N LA7TREE
 . . I $P($G(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,4,LA7TST,0)),U,6)'="*Not Performed" Q
 . . D UNWIND^LA7ADL1(LA7TST,9,LA7TST)
 . . I $D(LA7TREE(LA760)) S LA7VNP=1
 ;
 Q LA7VNP

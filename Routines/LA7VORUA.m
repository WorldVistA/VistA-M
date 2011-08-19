LA7VORUA ;DALOI/JMC - Builder of HL7 Lab Results NTE ;12/08/09  16:39
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**61,64,68**;Sep 27, 1994;Build 56
 ;
 ;
NTE ; Build NTE segment
 ;
 N LA7CMTYP,LA7FMT,LA7J,LA7NTE,LA7SOC,LA7TXT,LA7TYP,LA7X,LA7Y,X
 ;
 ; Initialize segment set id
 S LA7NTESN=0
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
 Q
 ;
 ;
PLC ; Performing lab comment
 N LA74,LA7DIV,LA7CMTYP,LA7FMT,LA7NTE,LA7RNLT,LA7SOC,LA7TSTN,LA7TXT,LA7X,X
 S (LA74,LA7CMTYP,LA7DIV,LA7RNLT,LA7TSTN)="",LA7FMT=0
 ;
 ; Source of comment - handle other system's special codes, i.e. DOD-CHCS
 S LA7SOC=$S($G(LA7NVAF)=1:"DS",1:"L")
 ;
 ; Find reporting facility (division).
 I LA("SUB")="CH" D
 . S LA7X=$G(^LR(LA("LRDFN"),LA("SUB"),LA("LRIDT"),$P(LA7VT,"^")))
 . S LA74=$P(LA7X,"^",9)
 . S LA7RNLT=$P($P(LA7X,"^",3),"!",2)
 I LA74="" S LA74=+$P($G(^XMB(1,1,"XUS")),"^",17)
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
 D NTE^LA7VORU1
 Q
 ;
 ;
INTRP ; Send test interpretation
 ; Send "CH" subscript file #60 site/specimen's interpretation field (#5.5)
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
 I LA7FMT>0,$D(LA7TXT) D NTE^LA7VORU1
 ;
 Q

LRVRARU ;DALOI/STAFF - AUTO RELEASE UTILITY PROGRAM ;04/05/16  11:02
 ;;5.2;LAB SERVICE;**458**;Sep 27, 1994;Build 10
 ;
 ; Reference to DUZ^XUP supported by DBIA #4129
 ; Reference to DIVSET^XUSRB2 supported by DBIA #4055
 ;
 ; ZEXCEPT is used to identify variables which are external to a specific TAG
 ;         used in conjunction with Eclipse M-editor.
 ;
 Q
 ;
 ;
INIT ; Initialize user/environment
 ;
 ;ZEXCEPT: DIQUIET,LAMSG,LRAA,LRALERT,LRANYAA,LRAUTORELEASE,LRAUTOVERIFY,LRCDEF,LRCNT,LRDELTACHKOK,LRDFWKLD,LRDUZ
 ;ZEXCEPT: LREND,LRERR,LRIEN,LRLABKY,LRLD,LRLL,LRNOECHO,LRORDNLT,LROUTINE,LRPARAM,LRPROF,LRQUIET,LRSTORE,LRVBY,VAERR
 ;ZEXCEPT: ZTREQ
 ;
 N I,LR60,LR61,LR62,LR64,LR0070,LRNLT,LRX,LRY
 ;
 ; If rollover has not completed then requeue task 5 minutes in future and send alert.
 I +$G(^LAB(69.9,1,"RO"))'=(+$H) D  Q
 . S ZTREQ=$$HADD^XLFDT($H,0,0,5,0)
 . S LAMSG="AR: Lab Rollover has not completed as of "_$$HTE^XLFDT($H,"1M")
 . S LREND=1
 ;
 I '$D(^LRO(68.2,LRLL,0))#2 D  Q
 . S LREND=1
 . S LAMSG="AR: No Entry for Load/Work List using IEN: "_LRLL
 ;
 S LRLL(0)=^LRO(68.2,LRLL,0)
 S (LRAUTOVERIFY,LRCNT,LRDELTACHKOK,LREND,LRSTORE)=0,(DIQUIET,LRAUTORELEASE,LRNOECHO,LRQUIET)=1,LAMSG=""
 ;
 K LRDUZ,LRERR,LRIEN,LRORDNLT
 D KVAR^VADPT
 ;
 ; DUZ = set to IEN of LRLAB,AUTO RELEASE application proxy
 S LRX=$$FIND1^DIC(200,"","OX","LRLAB,AUTO RELEASE","B","")
 I LRX<1 D  Q
 . S LREND=1
 . S LAMSG="AR: Unable to identify proxy 'LRLAB,AUTO RELEASE' in NEW PERSON file"
 D DUZ^XUP(LRX)
 S LRDUZ("AR")=LRX
 ;
 ; LRDUZ("AR") = set to IEN of LRLAB,AUTO VERIFY application proxy
 S LRX=$$FIND1^DIC(200,"","OX","LRLAB,AUTO VERIFY","B","")
 I LRX<1 D  Q
 . S LREND=1
 . S LAMSG="AR: Unable to identify proxy 'LRLAB,AUTO VERIFY' in NEW PERSON file"
 S LRDUZ("AV")=LRX
 ;
 ;Initialize LRDUZ("USER"), used to hold the user's DUZ when user verified on external system
 S LRDUZ("USER")=""
 ;
 D EN^LRPARAM
 I $G(LREND) S LAMSG="AR: LRPARAM Error for Load/Work List "_$P(LRLL(0),"^") Q
 S $P(LRPARAM,U,3)="",$P(LRPARAM,U,4)=""
 S LRLABKY="1^^^1" ;lab verification keys
 ;
 ; Use first profile designated for auto release on this load list.
 S LRPROF=$O(^LRO(68.2,LRLL,10,"AR",1,0))
 I 'LRPROF D  Q
 . S LREND=1
 . S LAMSG="AR: No Auto Release Profile for Load/Work List "_$P(LRLL(0),"^")
 ;
 S LRPROF(0)=^LRO(68.2,LRLL,10,LRPROF,0)
 S LRAA=$P(LRPROF(0),U,2)
 I $P(^LRO(68,LRAA,0),U,2)'="CH" S LREND=1,LAMSG="AR: No CH accession area for Load/Work List "_$P(LRLL(0),"^") Q
 S LRANYAA=+$P(LRPROF(0),"^",3)
 ;
 ; Use default reference lab field as performing and releasing lab
 S LRDUZ(2)=+$P(LRPROF(0),"^",5)
 I LRDUZ(2)'=DUZ(2) D  Q:LREND
 . S LRY=0
 . I LRDUZ(2)>0 D DIVSET^XUSRB2(.LRY,"`"_LRDUZ(2))
 . I LRY Q
 . S LREND=1,LAMSG="AR: Unable to set user 'LRLAB,AUTO RELEASE' to division "_$S(LRDUZ(2)<1:"<none specified>",1:$$GET1^DIQ(4,LRDUZ(2)_",",.01))_" on profile: "_$P(LRPROF(0),U)
 ;
 S LRX=$G(^LRO(68,LRAA,0))
 S LRLD=$S($P(LRX,U,19)'="":$P(LRX,U,19),1:"CP")
 ;
 S LRDFWKLD=+$G(^LRO(68.2,LRLL,"SUF"))
 D WKLD(LRDFWKLD)
 I LRCDEF="" D  Q
 . S LREND=1
 . S LAMSG="AR: No Default Suffix for Load/Work List "_$P(LRLL(0),"^")
 ;
 ; Explode the test list
 K ^TMP("LR",$J)
 D EXPLODE^LRGP2
 I '$O(^TMP("LR",$J,"VTO",0)) D  Q
 . S LREND=1
 . S LAMSG="AR: No Test defined for Load/Work List "_$P(LRLL(0),"^")_" using profile: "_$P(LRPROF(0),U)
 ;
 K LRIEN,LRERR
 S (LRERR,VAERR)=0
 S LROUTINE=$$GET1^DIQ(69.9,"1,",301,"I","ANS","ERR") ;Routine urgency
 S:'LROUTINE LROUTINE=9
 S LRALERT=LROUTINE
 ;
 S LRVBY=2
 Q
 ;
 ;
WKLD(LRP) ; Setup LRCDEF* variables for workload
 ; Call with LRP = ien of WKLD suffix in file #64.2
 ;
 ;ZEXCEPT: LRCDEF,LRCDEF0
 ;
 S LRCDEF0=$G(^LAB(64.2,LRP,0)),LRCDEF0(1)=$P(LRCDEF0,"^",19)
 S LRCDEF=$P($P(LRCDEF0,"^",2),".",2)
 ;
 Q
 ;
 ;
WKLDC(LRLL,LRAA) ; Setup LRCAP*, LRCS*, LRSUF* variables for workload
 ; Call with LRLL = ien of load/workk list in file #62.8
 ;           LRAA = ien of accession area in file #68
 ;
 ;ZEXCEPT: LRCAPMS,LRCAPWA,LRCSQ,LRCSQQ,LRPARAM,LRSUF0,LRUSUFO
 ;
 N LREND,Y
 ;
 ; Cleanup values from processing a previous accession as area could be different.
 K LRCAPMS,LRCAPWA,LRCSQ,LRCSQQ,LRSUF0,LRUSUFO
 ;
 ; Check if workload turned on.
 I '$P(LRPARAM,U,14)!('$G(LRAA)) Q
 I '$P($G(^LRO(68,+LRAA,0)),U,16) Q
 ;
 ; Setup worload code variables for this accession area
 S Y=LRLL D EN1^LRCAPV
 ;
 ; Override file setting, do not prompt for COLLECT STD/QC/REPEATS (#11) (nobody to answer).
 S LRCSQQ=0
 ;
 Q
 ;
 ;
SPALERT ; Send Processing Alert Message
 ;
 ;ZEXCEPT: LRLL,LRSTORE
 ;
 N LAMSG,LRTIME,LRX
 S LRX=0,LRTIME=$$HTE^XLFDT($H,"1M")
 F  S LRX=$O(LRSTORE(LRX)) Q:'LRX  D
 . I '$D(^LAHM(62.48,LRX,20,"B",1)) Q  ; New result alerts not defined
 . S LAMSG=$P(LRSTORE(LRX),"^")_" Patient(s) processed for Auto Release: "_$P(LRLL(0),"^")_" on "_LRTIME
 . D XQA^LA7UXQA(1,LRX,"","",LAMSG,"",1)
 Q
 ;
 ;
SENDACK ; Send HL7 ACKnowledgment message
 ;
 ;ZEXCEPT: LA7624,LA76248,LA76249,LA7AAT,LRERR,LRUID,PNM,SSN
 ;
 N LA
 ;
 I LA7AAT(1)=""!(LA7AAT(1)="NE") Q
 I LA7AAT(1)="SU",$G(LRERR)'="" Q
 I LA7AAT(1)="ER",$G(LRERR)="" Q
 ;
 S LA(62.4)=LA7624,LA(62.48)=LA76248,LA(62.49)=LA76249
 S LA("ACK")=$S(+LRERR:"AE",1:"AA")
 S LA("ID",1)=LRUID
 S LA("ID",2)=PNM
 S LA("ID",3)=SSN
 S LA("MSG")=$P(LRERR,"^",2)
 I $L(LA("MSG"))>80 S LA("MSG")=$E(LA("MSG"),1,80),LA("MSG")=$P(LA("MSG"),". ") ; HL7 specifies field length 80.
 ;
 ; Build info for ERR segment
 D BLDERR^LA7VHLU8(.LA,LRERR)
 ;
 D ACK^LA7VHLU8(.LA)
 ;
 Q
 ;
 ;
CLEAN ;Clean-up point
 ;
 ;ZEXCEPT: AGE,COMB,CONTROL,DFN,DOB,DTS,H8,I5,LRACC,LRACD,LRAD,LRAN,LRAOD,LRASSN,LRBLBP,LRCAPLOC,LRCDEF,LRCDEF0,LRCDEF0X,LRCDT
 ;ZEXCEPT: LRCODEN,LRCOM,LRDATA,LRERR,LRIDT,LRIN,LRIX,LRM,LRNLT,LRNOCODE,LRNOW,LRNT,LRNX,LRODT,LRODTIM,LROLDIV,LROLLOC,LRORD
 ;ZEXCEPT: LRORU3,LROT,LRPRAC,LRRB,LRSB,LRSN,LRSSCX,LRSSN,LRST,LRSUB,LRSUM,LRSXN,LRT,LRTN,LRTREA,LRTS,LRTSORU,LRTST,LRTT,LRUID
 ;ZEXCEPT: LRUNQ,LRWRD,OCXAP,PNM,S5,SEGID,SEX,SSN,T1,VA,VADMVT,VAINDT,VAL,XP,Z
 ;
 D KVAR^VADPT
 K AGE,COMB,CONTROL,DFN,DOB,DTS,H8,I5
 K LRACC,LRACD,LRAD,LRAN,LRAOD
 K LRASSN,LRCAPLOC,LRCDT,LRCDEF,LRCDEF0,LRCDEF0X,LRCODEN,LRCOM
 K LRDATA,LRERR,LRNOCODE,LROLDIV
 K LRPRAC,LRRB
 K LRSB,LRSN,LRSSCX,LRSSN,LRSUB,LRSXN,LRST,LRSUB,LRSUM
 K LRSXN,LRT,LRTN,LRTREA,LRTS,LRTSORU,LRTST,LRTT,LRUID
 K LRUNQ,LRWRD,PNM,S5,SEGID,SEX,SSN
 K LRIDT,LRIN,LRIX,LRBLBP,LRM,LRNLT,LRNOW,LRNT,LRNX,LRODT
 K LROLLOC,LRORD,LRODTIM,LRORU3,LROT,OCXAP
 K T1,VA,VADMVT,VAINDT,VAL,XP,Z
 Q

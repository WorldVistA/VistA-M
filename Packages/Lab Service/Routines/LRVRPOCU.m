LRVRPOCU ;DALOI/JMC - POINT OF CARE UTILITY PROGRAM ; May 10, 2004 12:06
 ;;5.2;LAB SERVICE;**290**;Sep 27, 1994
 ;
 ; Reference to DUZ^XUP supported by DBIA #4129
 ; Reference to DIVSET^XUSRB2 supported by DBIA #4055
 ;
 Q
 ;
 ;
INIT ; Initialize user
 ;
 N I,LR60,LR61,LR62,LR64,LR0070,LRNLT,LRX,LRY
 S (LRCNT,LREND,LRSTORE)=0,(DIQUIET,LRNOECHO,LRQUIET)=1,LAMSG=""
 K LRDUZ,LRERR,LRIEN,LRORDNLT
 D KVAR^VADPT
 S LRX=$$FIND1^DIC(200,"","OX","LRLAB,POC","B","")
 I LRX<1 D  Q
 . S LREND=1
 . S LAMSG="Unable to identify user 'LRLAB,POC' in NEW PERSON file"
 D DUZ^XUP(LRX)
 ;
 D EN^LRPARAM
 I $G(LREND) S LAMSG="LRPARAM Error for Load/Work List "_$P(LRLL(0),"^") Q
 S $P(LRPARAM,U,3)="",$P(LRPARAM,U,4)=""
 S LRLABKY="1^^^1" ;lab verification keys
 ;
 ; Get list of test and setup variables 
 S (LRORDR,LRLWC)="P" ; Order type POC
 S LRTYPE=+$P($G(^LRO(68.2,LRLL,0)),U,3)
 ;
 S LRPROF=$O(^LRO(68.2,LRLL,10,0))
 I 'LRPROF D  Q
 . S LREND=1
 . S LAMSG="No Profile for Load/Work List "_$P(LRLL(0),"^")
 ;
 S LRPROF(0)=^LRO(68.2,LRLL,10,LRPROF,0)
 S (LRDAA,LRAA)=$P(LRPROF(0),U,2)
 I $S('$G(LRDAA):1,'$D(^LRO(68,LRDAA,0))#2:1,1:0) D  Q
 . S LREND=1
 . S LAMSG="No Default accession area for Load/Work List "_$P(LRLL(0),"^")
 I $P(^LRO(68,LRAA,0),U,2)'="CH" S LREND=1,LAMSG="No CH accession area for Load/Work List "_$P(LRLL(0),"^") Q
 ;
 I $$GET1^DIQ(68,LRDAA_",",.4)="" D  Q
 . S LREND=1
 . S LAMSG="No Numeric Identifier for Accession Area "_$$GET1^DIQ(68,LRDAA_",",.01)
 ;
 S LRX=$G(^LRO(68,LRAA,0))
 S LRLD=$S($P(LRX,U,19)'="":$P(LRX,U,19),1:"CP")
 ;
 S LRDFWKLD=+$G(^LRO(68.2,LRLL,"SUF"))
 D WKLD(LRDFWKLD)
 I LRCDEF="" D  Q
 . S LREND=1
 . S LAMSG="No Default Suffix for Load/Work List "_$P(LRLL(0),"^")
 ;
 ; Explode the test list
 K ^TMP("LR",$J)
 D EXPLODE^LRGP2
 I '$O(^TMP("LR",$J,"VTO",0)) D  Q
 . S LREND=1
 . S LAMSG="No Test defined for Load/Work List "_$P(LRLL(0),"^")
 ;
 ; Build array of order NLT codes and corresponding file #60 tests.
 S I=0
 F  S I=$O(^LRO(68.2,LRLL,10,LRPROF,1,I)) Q:'I  D
 . S LRY=$G(^LRO(68.2,LRLL,10,LRPROF,1,I,0)),(LR0070,LR62)=""
 . S LR60=+LRY,LR61=$P(LRY,"^",2),LR64=+$G(^LAB(60,LR60,64))
 . I LR64 D
 . . S LRNLT=$P($G(^LAM(LR64,0)),"^",2)
 . . I LR61 D
 . . . S LR0070=$$GET1^DIQ(61,LR61_",","LEDI HL7:HL7 ABBR")
 . . . S LR62=$P(LRY,"^",5)
 . . . I 'LR62 S LR62=$$GET1^DIQ(61,LR61_",",4.1,"I")
 . . I LRNLT'="",LR0070'="" S LRORDNLT(LRNLT,LR0070)=LR60_"^"_LR61_"^"_LR62_"^"_$P(LRY,"^",4)
 ;
 K LRIEN,LRERR
 S LRDPF="2^DPT(",(LRERR,VAERR)=0,(LRLBLBP,LREAL,LRASSN,VA200,COMB)=""
 S LROUTINE=$$GET1^DIQ(69.9,"1,",301,"I","ANS","ERR") ;Routine urgency
 S:'LROUTINE LROUTINE=9
 S LRALERT=LROUTINE
 ;
 I $$GET1^DIQ(68.2,LRLL_",",.03,"I")'=2 D  Q
 . S LREND=1
 . S LAMSG="Load/Work List "_$P(LRLL(0),"^")_" not set to POC type."
 ;
 ; Determine division to set user LRLAB,POC.
 S LRDIV=$O(^LRO(68,LRDAA,3,0))
 I LRDIV<1 D  Q
 . S LREND=1
 . S LAMSG="No associated division for accession area "_$$GET1^DIQ(68,LRDAA_",",.01)
 I LRDIV'=DUZ(2) D  Q:LREND
 . S LRY=0
 . D DIVSET^XUSRB2(.LRY,"`"_LRDIV)
 . I LRY Q
 . S LREND=1,LAMSG="Unable to set user 'LRLAB,POC' to division "_$$GET1^DIQ(4,LRDIV_",",.01)
 ;
 ; Set CPRS nature of order to 'AUTO'.
 S LRNATURE=$P($$NEW1^LROR6(9),"^",4,6)
 ;
 S LRVBY=2
 Q
 ;
 ;
WKLD(LRP) ; Setup LRCDEF* variables for workload
 ; Call with LRP = ien of WKLD suffix in file #64.2
 S LRCDEF0=$G(^LAB(64.2,LRP,0)),LRCDEF0(1)=$P(LRCDEF0,"^",19)
 S LRCDEF=$P($P(LRCDEF0,"^",2),".",2)
 ;
 Q
 ;
 ;
SPALERT ; Send Processing Alert Message
 ;
 N LAMSG,LRTIME,LRX
 S LRX=0,LRTIME=$$HTE^XLFDT($H,"1M")
 F  S LRX=$O(LRSTORE(LRX)) Q:'LRX  D
 . I '$D(^LAHM(62.48,LRX,20,"B",1)) Q  ; New result alerts not defined
 . S LAMSG=$P(LRSTORE(LRX),"^")_" Patient(s) processed for POC: "_$$GET1^DIQ(62.48,LRX_",",.01)_" on "_LRTIME
 . D XQA^LA7UXQA(1,LRX,"","",LAMSG,"",1)
 Q
 ;
 ;
CLEAN ;Clean-up point
 D KVAR^VADPT
 K AGE,COMB,CONTROL,DFN,DOB,DTS,H8,I5
 K LRACC,LRACD,LRAD,LRAN,LRAOD
 K LRASSN,LRCAPLOC,LRCDT,LRCDEF,LRCDEF0,LRCDEF0X,LRCODEN,LRCOM
 K LRDATA,LRERR,LRNOCODE,LROLDIV
 K LRPRAC,LRRB
 K LRSB,LRSN,LRSQ,LRSSCX,LRSSN,LRSUB,LRSXN,LRST,LRSUB,LRSUM
 K LRSXN,LRT,LRTN,LRTREA,LRTS,LRTSORU,LRTST,LRTT,LRUID
 K LRUNQ,LRWRD,PNM,S5,SEGID,SEX,SSN
 K LRIDT,LRIN,LRIX,LRBLBP,LRM,LRNLT,LRNOW,LRNT,LRNX,LRODT
 K LROLLOC,LRORD,LRODTIM,LRORU3,LROT,OCXAP
 K T1,VA,VADMVT,VAINDT,VAL,XP,Z
 Q
 ;
 ;
VASD ; Check for clinic appointment at same time as specimen
 ; else for clinic appointment before specimen date/time on same date.
 ;
 ; If unable to find an appointment before the specimen date/time then
 ; look for first appointment after specimen date/time.
 ;
 ; If ordering division in message then only check those clinic locations
 ; that are in the same division.
 ;
 N LRDATE,LRCLIEN,LRCOUNT,LRENC,LREXACT,LRP,LRX,LRY
 S (LRDATE,LRENC,LREXACT,LRY)=0
 S LRP(1)=(LRCDT\1)_";"_(LRCDT\1)
 S LRP(3)="R;I;NT"
 S LRP(4)=DFN
 S LRP("FLDS")="2;12"
 S LRP("SORT")="P"
 S LRCOUNT=$$SDAPI^SDAMA301(.LRP)
 I LRCOUNT>0 D
 . I 'LROLLOC D FINDAPPT Q
 . I LROLLOC,'LRPRAC D CHKAPPT
 ;
 I LRCOUNT'=0 K ^TMP($J,"SDAMA301")
 ;
 ; If no provider then try provider from outpatient encounter.
 I 'LRPRAC,LROLLOC,LRENC D OENC(LRENC)
 Q
 ;
 ;
FINDAPPT ; Find an appointment for the collection date/time
 F  S LRDATE=$O(^TMP($J,"SDAMA301",DFN,LRDATE)) Q:LRDATE=""  D  Q:LREXACT
 . S LRX=$G(^TMP($J,"SDAMA301",DFN,LRDATE))
 . S LRCLIEN=$P($P(LRX,"^",2),";")
 . I LROLDIV,LROLDIV'=$$GET1^DIQ(44,LRCLIEN_",",3,"I") Q
 . I LRDATE=LRCDT S LROLLOC=LRCLIEN,LRENC=$P(LRX,"^",12),LREXACT=1 Q
 . I 'LRY,LRDATE<LRCDT S LRY=LRX,LROLLOC=LRCLIEN,LRENC=$P(LRX,"^",12) Q
 . I 'LRY,LRDATE>LRCDT S LRY=LRX,LROLLOC=LRCLIEN,LRENC=$P(LRX,"^",12) Q
 . I LRDATE>LRY,LRDATE<LRCDT S LRY=LRX,LROLLOC=LRCLIEN,LRENC=$P(LRX,"^",12)
 Q
 ;
 ;
CHKAPPT ; Check for an appointment that matches the ordering location
 ; to find the provider on the encounter when no provider sent.
 F  S LRDATE=$O(^TMP($J,"SDAMA301",DFN,LRDATE)) Q:LRDATE=""  D  Q:LRENC
 . S LRX=$G(^TMP($J,"SDAMA301",DFN,LRDATE))
 . S LRCLIEN=$P($P(LRX,"^",2),";")
 . I LROLLOC=LRCLIEN S LRENC=$P(LRX,"^",12) Q
 Q
 ;
 ;
OENC(LRENC) ; Lookup provider on encounter
 ; Use primary provider if possbile otherwise use first provider listed.
 ;
 N LRI,LRPRVLST,LRERR
 D GETPRV^SDOE(LRENC,"LRPRVLST","LRERR")
 I $G(LRPRVLST)<1 Q
 S LRI=0
 F  S LRI=$O(LRPRVLST(LRI)) Q:'LRI  D  Q:LRPRAC
 . I $P(LRPRVLST(LRI),"^",4)="P" S LRPRAC=+LRPRVLST(LRI) Q
 I 'LRPRAC S LRI=$O(LRPRVLST(0)),LRPRAC=+LRPRVLST(LRI)
 Q
 ;
 ;
SENDACK ; Send HL7 ACKnowledgment message
 ;
 N LA
 S LA(62.48)=LA76248,LA(62.49)=LA76249
 S LA("ACK")=$S(+LRERR:"AE",1:"AA")
 S LA("MSG")=$S($G(LRUID)'="":LRUID_"^",1:"")
 S LA("MSG")=LA("MSG")_$P(LRERR,"^",2)
 D ACK^LA7POC(.LA)
 Q

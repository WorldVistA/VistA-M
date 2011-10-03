PSXDODB1 ;BIR/HTW-HL7 2.1 FILE AND PATIENT SAFETY CHECKS ;01/15/02 13:10:52
 ;;2.0;CMOP;**45**;11 Apr 97
 ;
 Q
 ;Returns PSXERR="" if passed, if not PSXERR='error format in EDI document'
 ;called by PSXDODB
 ;if the file fails a negative ack is placed in the outbox and a mailmessage
 ;is sent using GRP1^PSXNOTE, and the file is placed in the pending box.
 ;This process does not move it to archive nor remove it from the inbox.
EN D BLDSEQ
 K BTS
TESTBT ;test the sequence of the messages in the batch
 ; stored in ^TMP($J,"PSXDOD",I)
 S PSXERR="",LSEG="",PTCNT=0,ORDCNT=0
 F LNNUM=1:1 S LN=$G(^TMP($J,"PSXDOD",LNNUM)) Q:LN=""  D  Q:$G(SEGSTOP)
 . I $E(LN)="$" S SEG=$P(LN,"^") I 1 ; discern $seg^  vs "seg|"
 . E  S SEG=$P(LN,"|")
 . S:SEG="NTE" SEG=$P(LN,"|",1,2)
 . Q:SEG="$$ENDXMIT"
 . ;I $E(IOST)="C" W " ",SEG," "
 . I LNNUM=1,SEG="$$XMIT" S LSEG=SEG,XMIT=LN Q
 . I '$D(SEGSEQ(LSEG,SEG)) S PSXERR=PSXERR_$S($L(PSXERR):"~",1:"")_"SEQ^"_LSEG_U_SEG S LSEG=SEG,SEGSTOP=1 Q
 . S LSEG=SEG
 . I "BHS,$MSG,MSH,RX1,ZX1,PID,BTS"[SEG D CHECK
 ;
 I PSXERR="",$G(BTS)="" S PSXERR=PSXERR_$S($L(PSXERR):"~",1:"")_"56^" D
 . I $E(IOST)="C" W !,"Batch Orders ",PSXERR,!,$G(PTCNTB),?40,$G(PTCNT)
 ;
 I PSXERR="" G EXIT ; FILE PASSED SAFETY CHECKS
 ; FILE FAILED SAFETY CHECK send neg ack
 K ACK
 S ACK="MSH|^~\&|VistA||CHCS||20010925202704||ORM^O02|573-013240530|P|2.3.1|||NE|NE"
 S BATID=$G(BATIDB)
 D NOW^%DTC S BATDTM=+$$HLDATE^HLFNC(%)
 F YY="BATID^10","BATDTM^7" D PUT(.ACK,"|",YY)
 S ACK(1)=ACK,ACK(2)="MSA|CR|"_BATID
 I PSXERR'="" S ACK(2)=ACK(2)_"|"_PSXERR
 S FNAME2=$P(FNAME,".",1)_".TAC",PATH=$$GET1^DIQ(554,1,21)
 F XX=1:1:5 S Y=$$GTF^%ZISH("ACK(1)",1,PATH,FNAME2) Q:Y=1  H 4
 I Y'=1 S GBL="ACK" D FALERT^PSXDODNT(FNAME2,PATH,GBL)
 S PATH=$$GET1^DIQ(554,1,22)
 F XX=1:1:5 S Y=$$GTF^%ZISH("ACK(1)",1,PATH,FNAME2) Q:Y=1  H 4
 I Y'=1 S GBL="ACK" D FALERT^PSXDODNT(FNAME2,PATH,GBL)
ERRMSG ;send error message to PSXCMOPMGR key and copy file to pending.
 S DIRHOLD=$$GET1^DIQ(554,1,23)
 S Y=$$GTF^%ZISH($NA(^TMP($J,"PSXDOD",1)),3,DIRHOLD,FNAME)
 S XMSUB="DOD CMOP Safety ALERT "_FNAME
 D GRP1^PSXNOTE
 ;S XMY(DUZ)="" ;***TESTING
 S XMTEXT="PSXTXT("
 S PSXTXT(1,0)="DOD CMOP File/Data Patient Safety checker found an error"
 S PSXTXT(2,0)="FILE: "_FNAME
 S PSXTXT(3,0)="A copy of the file has been placed in the hold directory "_DIRHOLD
 S PSXTXT(4,0)="The Error code given back to DoD is:"
 S L=$L(PSXERR) F I=1:1:1+(L\200) S XX=$E(PSXERR,(I-1)*200,I*200),PSXTXT(4+I,0)=XX
 D ^XMD
 I $E(IOST)="C" W ! F I=1:1:4 W !,PSXTXT(I,0) I I=4 H 3
 K PSXTXT,DIRHOLD
 G EXIT
CHECK ;patient safety check; pull variables from segments/elements
 I SEG="BHS" S BATIDB=$P(LN,"|",11),BHS=LN Q
 I SEG="$MSG" S ORDSEQG=$P(LN,U,2) Q
 I SEG="MSH" S BATIDM=$P(LN,"|",10),ORDSEQH=$P(BATIDM,"-",3),BATIDM=$P(BATIDM,"-",1,2) D
 .I BATIDM'=BATIDB S PSXERR=PSXERR_$S($L(PSXERR):"^",1:"")_"22~"_BATIDM_"~"_ORDSEQH D
 .. I $E(IOST)="C" W !,"Order Batch ID ",PSXERR,!,BATIDM,?40,BATIDB
 .I ORDSEQH'=ORDSEQG S PSXERR=PSXERR_$S($L(PSXERR):"^",1:"")_"22~"_ORDSEQG D
 .. I $E(IOST)="C" W !,"Order Sequence ",PSXERR,!,ORDSEQG,?40,ORDSEQH
 I SEG="RX1" S RXIDR=$P(LN,"|",27),ORDCNT=ORDCNT+1 Q
 I SEG="ZX1" S RXIDZ=$P(LN,"|",2) I RXIDZ'=RXIDR S PSXERR=PSXERR_$S($L(PSXERR):"^",1:"")_"44~"_ORDSEQH_U D  Q
 . I $E(IOST)="C" W !,"RX Number ",PSXERR,!,RXIDR,?40,RXIDZ
 I SEG="PID" S PTCNT=PTCNT+1 Q
 I SEG="BTS" S PTCNTB=$P(LN,"|",2),ORDCNTB=$P(LN,"|",4),BTS=LN D
 . I PTCNTB'=PTCNT S PSXERR=PSXERR_$S($L(PSXERR):"^",1:"")_"56~" D
 .. I $E(IOST)="C" W !,"Batch Orders ",PSXERR,!,PTCNTB,?40,PTCNT
 . I ORDCNTB'=ORDCNT S PSXERR=PSXERR_$S($L(PSXERR):"^",1:"")_"58~" D
 .. I $E(IOST)="C" W !,"Batch Totals ",PSXERR,!,ORDCNTB,?40,ORDCNT
 Q
BLDSEQ ;build check sequence of SEGMENTS
 K SEGSEQ
 F I=1:1 S LINE=$P($T(SEGBLD+I),";;",2,99) Q:LINE["$$END$"  D
 . S LSEG=$P(LINE,";;")
 . F J=2:1 S SEG=$P(LINE,";;",J) Q:SEG=""  S SEGSEQ(LSEG,SEG)="" ;W !,LSEG,?10,SEG
 Q
SEGBLD ; data for checking sequencing of segments.
 ;;$$XMIT;;BHS
 ;;BHS;;ORC
 ;;ORC;;NTE|1;;NTE|2;;NTE|3;;NTE|4;;$MSG
 ;;NTE|1;;NTE|2;;NTE|3;;NTE|4;;$MSG
 ;;NTE|2;;NTE|2;;NTE|3;;NTE|4;;$MSG
 ;;NTE|3;;NTE|3;;NTE|4;;$MSG
 ;;NTE|4;;NTE|4;;$MSG
 ;;$MSG;;MSH
 ;;MSH;;PID
 ;;PID;;NTE|8;;ORC
 ;;NTE|8;;ORC;;NTE|8
 ;;ORC;;RX1
 ;;RX1;;ZX1;;NTE|7
 ;;NTE|7;;NTE|7;;ZX1
 ;;ZX1;;ORC;;BTS;;$MSG;;PID;;ORC
 ;;BTS;;$$ENDXMIT
 ;;$$END$
 Q
PIECE(REC,DLM,XX) ;
 ; Set variable V = piece P of REC using delimiter DLM
 N V,P S V=$P(XX,U),P=$P(XX,U,2),@V=$P(REC,DLM,P)
 Q
PUT(REC,DLM,XX) ;
 ; Set Variable V into piece P of REC using delimiter DLM
 N V,P S V=$P(XX,U),P=$P(XX,U,2)
 S $P(REC,DLM,P)=$G(@V)
 Q
EXIT ;
 K BTS,SEGSEQ,PTCNT,PTCNTB,ORDCNT,ORDCNTB,RXIDR,RXIDZ,BATID,BATIDM,ORDSEQH,BHS,ORDSEQG
 K BATDTM,BATIDB,FNAME2,LN,LNNUM,LSEG,SEG,YY,XMIT,LINE,SEGSTOP
 Q
LOAD ; used for testing seperate from the call from PSXDODB
 K ^TMP($J,"PSXDOD")
 S GBL="^TMP("_$J_",""PSXDOD"",1)"
 S PATH=$$GET1^DIQ(554,1,20)
 S FNAME="0029_022751430_2.TRN"
 S Y=$$FTG^%ZISH(PATH,FNAME,GBL,3)
 Q

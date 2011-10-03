OCXOHL7 ;SLC/RJS,CLA - External Interface - PROCESS HL7 DATA ARRAY ;4/02/03  13:50
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**32,179**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
 ;
 Q
SILENT(OCXMSG,OUTMSG) ;
 ;
 N OCXSEG0,OCXRDT,OCXHL7,OCXOZZT
 S OCXRDT=($H*86400+$P($H,",",2))
 S:'$D(OUTMSG) OUTMSG=""
 D CHECK(.OCXMSG,.OUTMSG)
 Q
 ;
VERBOSE(OCXMSG) ;
 ;
 N OCXSEG0,OCXX,OUTMSG,OCXHL7,OCXOZZT
 S OCXRDT=($H*86400+$P($H,",",2))
 S OUTMSG=""
 D CHECK(.OCXMSG,.OUTMSG)
 W:$O(OUTMSG(0)) !,"Order Check Message: ",$C(7)
 S OCXX=0 F  S OCXX=$O(OUTMSG(OCXX)) Q:'OCXX  W !,OUTMSG(OCXX)
 W:$O(OUTMSG(0)) !,$C(7)
 Q
 ;
CHECK(OCXMSG,OUTMSG) ;
 ;
 N OCXARY,OCXDFN,OCXEL,OCXODATA,OCXOLOG,OCXOSRC,OCXDSIZE
 N OCXOTIME,OCXQUIT,OCXSEG0,OCXSEQ,OCXSUB,OCXTEST,OCXVAR
 ;
 I $$RTEST D  Q
 .N OMSG,OTMOUT,OCXM
 .S OMSG="^25^^Order Checking is recompiling and momentarily disabled"
 .S OCXM=0 F  S OCXM=$O(OUTMSG(OCXM)) Q:'OCXM  Q:(OUTMSG(OCXM)[OMSG)
 .Q:OCXM
 .S OUTMSG($O(OUTMSG(""),-1)+1)=OMSG
 ;
 S OCXARY=$S($L($G(OCXMSG)):OCXMSG,1:"OCXMSG") Q:'$O(@OCXARY@(0))
 ;
 S (OCXQUIT,OCXSUB)=0 F  S OCXSUB=$O(@OCXARY@(OCXSUB)) Q:'OCXSUB  I ($P($G(@OCXARY@(OCXSUB)),"|",1)="ORC") D  Q
 .S:($P($P($G(@OCXARY@(OCXSUB)),"|",2),"^",1)="ZC") OCXQUIT=1
 ;
 Q:OCXQUIT
 ;
 S OCXOLOG=$$LOG(OCXARY)
 ;
 S OCXODATA="",OCXTEST=$G(OCXOVRD)
 ;
 S OCXVAR("DUZ")=""
 S OCXVAR("OCXMSG")=""
 S OCXVAR("OCXARY")=""
 S OCXOSRC="GENERIC HL7 MESSAGE ARRAY"
 ;
 S OCXSUB=0 F  S OCXSUB=$O(@OCXARY@(OCXSUB)) Q:'OCXSUB  D
 .N OCXLINE,OCXPC,X,OCXTDAT,OCXCLIN,LASTPC
 .S OCXDSIZE=$$ARYSIZE($NAME(@OCXARY@(OCXSUB)))
 .;
 .I (OCXDSIZE<5000) D  Q:'$L($G(OCXLINE(0)))
 ..M OCXLINE(0)=@OCXARY@(OCXSUB)
 ..S OCXLINE(0,0)=OCXLINE(0)  ;  This will make first node consistent with continuation lines.
 ..S OCXSEG=$P($G(OCXLINE(0)),"|",1)
 .;
 .I (OCXDSIZE>4999) D  Q:'$L($G(^TMP($J,"OCXLDATA",0)))
 ..K ^TMP($J,"OCXLDATA")
 ..M ^TMP($J,"OCXLDATA",0)=@OCXARY@(OCXSUB)
 ..S ^TMP($J,"OCXLDATA",0,0)=^TMP($J,"OCXLDATA",0)  ;  This will make first node consistent with continuation lines.
 ..S OCXSEG=$P($G(^TMP($J,"OCXLDATA",0)),"|",1)
 .;
 .Q:'$L(OCXSEG)
 .;
 .I $D(OCXODATA(OCXSEG)) D   ;  This is another instance of this segment.
 ..;                            Process current OCXODATA and reset OCXODATA for this new instance.
 ..; Process OCXODATA
 ..S OCXDFN=$$GETDFN(OCXARY) I $G(OCXDFN) D UPDATE^OCXOZ01(+OCXDFN,OCXOSRC,.OUTMSG)
 ..;
 ..; Reset OCXODATA
 ..S OCXSEQ=+$G(OCXODATA(OCXSEG)) F  Q:'OCXSEQ  D  S OCXSEQ=$O(OCXODATA(OCXSEQ))
 ...S OCXSEG0=$G(OCXODATA(OCXSEQ)) Q:'$L(OCXSEG0)
 ...K OCXODATA(OCXSEQ),OCXODATA(OCXSEG0)
 .;
 .S OCXODATA(OCXSUB)=OCXSEG    ;  Set OCXODATA 'cross reference'
 .S OCXODATA(OCXSEG)=OCXSUB    ;  Set OCXODATA 'cross reference'
 .;
 .;  Load this segment instance into OCXODATA
 .;
 .;  OCXPC - Keeps track of which "|" piece we're on
 .;
 .I (OCXDSIZE<5000) D LOADATA(OCXSEG,"OCXLINE(0)")
 .;
 .I (OCXDSIZE>4999) D LOADATA(OCXSEG,$NAME(^TMP($J,"OCXLDATA",0)))
 ;
 S OCXDFN=$$GETDFN(OCXARY)
 I $G(OCXDFN) D UPDATE^OCXOZ01(+OCXDFN,OCXOSRC,.OUTMSG) I 1  ; Process OCXODATA for the last segment
 ;
 D FINISH^OCXOLOG(OCXOLOG)
 ;
 K ^TMP($J,"OCXLDATA")
 ;
 Q
 ;
LOADATA(OCXSEG,OCXSD) ; Get '|' piece #OCXPC of OCXSD Segment Data array.
 ;
 N OCXTEXT,OCXPCNT,OCXD0,OCXD1
 ;
 Q:'$L(OCXSEG)
 S OCXPCNT=0,OCXD0="" F  S OCXD0=$O(@OCXSD@(OCXD0)) Q:'$L(OCXD0)  D
 .S OCXTEXT=$G(@OCXSD@(OCXD0))
 .F OCXD1=1:1:$L(OCXTEXT) D
 ..I ($E(OCXTEXT,OCXD1)="|") S OCXPCNT=OCXPCNT+1 Q
 ..I ($L($G(OCXODATA(OCXSEG,OCXPCNT)))<241) S OCXODATA(OCXSEG,OCXPCNT)=$G(OCXODATA(OCXSEG,OCXPCNT))_$E(OCXTEXT,OCXD1)
 ;
 Q
 ;
RTEST() ; Does ^OCXOZ01 exist ??  Is it currently being compiled ??
 N DATE,TMOUT
 Q:'$L($T(^OCXOZ01)) 1
 I '($P($G(^OCXD(861,1,0)),U,1)="SITE PREFERENCES") K ^OCXD(861,1) S ^OCXD(861,1,0)="SITE PREFERENCES"
 S DATE=$P($G(^OCXD(861,1,0)),U,3)
 I DATE,((+DATE)=(+$H)),(((+$P($H,",",2))-(+$P(DATE,",",2)))<1800) Q 1
 Q 0
 ;
LOG(OCXARY) ;
 ;   Log Data Messages
 ;
 I $G(OCXTRACE),$$CDATA^OCXOZ01 W:$G(OCXTRACE) !,"  Raw Input Data: ",! D ZW(OCXARY) Q 0
 Q:'$L($T(LOG^OCXOZ01)) 0 Q:'$$LOG^OCXOZ01 0
 N OCXDFN,OCXNL
 I '$O(@OCXARY@(0)) S OCXARY="OCXNL",OCXNL(1)="Null HL7 Data Array Found"
 S OCXDFN=$$GETDFN(OCXARY)
 Q $$NEW^OCXOLOG(OCXARY,"HL7",+$G(DUZ),+OCXDFN)
 ;
ARYSIZE(ARY) ; Get array size (Local or Global)
 ;
 N ARY1,SIZE
 ;
 S SIZE=0
 ;
 I '(ARY["^") F  S ARY=$Q(@ARY) Q:'$L(ARY)  S SIZE=SIZE+$L(@ARY)
 ;
 I (ARY["^") D
 .S ARY=$NAME(@ARY),ARY1=ARY
 .S:($E(ARY,$L(ARY))=")") ARY=$E(ARY,1,$L(ARY)-1)_","
 .F  S ARY1=$Q(@ARY1) Q:'$L(ARY1)  Q:'(ARY1[ARY)  S SIZE=SIZE+$L(@ARY1)
 ;
 Q SIZE
 ;
ZW(ARY) ; ZWrite an array (Local or Global)
 ;
 N ARY1
 ;
 I '(ARY["^") D  Q
 .F  S ARY=$Q(@ARY) Q:'$L(ARY)  W !,ARY," = ",@ARY
 ;
 I (ARY["^") D  Q
 .S ARY=$NAME(@ARY),ARY1=ARY
 .S:($E(ARY,$L(ARY))=")") ARY=$E(ARY,1,$L(ARY)-1)_","
 .F  S ARY1=$Q(@ARY1) Q:'$L(ARY1)  Q:'(ARY1[ARY)  W !,ARY1," = ",@ARY1
 ;
 Q
 ;
ERROR Q
 ;
 ; **** Old Labels to insure backwards compatibility ****
 ;
 ;
GETDFN(ARRAY) ;   Returns the patient IEN from file 2.
 ;
 N OCXNDX,OCXARY,OCXP1,OCXP2,OCXP3
 S OCXARY=$S($L($G(ARRAY)):ARRAY,1:"ARRAY")
 S OCXNDX=0 F  S OCXNDX=$O(@OCXARY@(OCXNDX)) Q:'OCXNDX  I $P($G(@OCXARY@(OCXNDX)),"|",1)="PID" Q
 Q:'OCXNDX 0
 ;
 S OCXP1=$P($G(@OCXARY@(OCXNDX)),"|",4)
 S OCXP2=$P($G(@OCXARY@(OCXNDX)),"|",5)
 S OCXP3=$P($G(@OCXARY@(OCXNDX)),"|",6)
 ;
 Q:(OCXP2["DPT(") +OCXP2
 ;
 I $L(OCXP3),($P($G(^DPT(+OCXP1,0)),U,1)=OCXP3) Q +OCXP1
 ;
 Q 0
 ;
 ;  Old line label area.
 ;
PROC(OCXMSG,OUTMSG) ;
 D SILENT(.OCXMSG,.OUTMSG)
 Q
 ;
EN(OCXMSG) ;
 D VERBOSE(.OCXMSG)
 Q
 ;

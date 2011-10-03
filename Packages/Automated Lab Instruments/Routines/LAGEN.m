LAGEN ;DALOI/CJS - LAB AUTOMATED DATA ; 1 Feb 2005
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**1,17,22,27,47,46,64,67**;Sep 27, 1994
 Q
 ;
LOG ; Run by accession number.
 S LINK="",LRDFN=0,DPF=2
 I $G(LOG)<1 G LG2
 ; If overlay data -> find if accession exists in LAH
 I LROVER D  Q:ISQN>0
 . N I,X
 . S (ISQN,I)=0
 . F  S I=$O(^LAH(LWL,1,"C",LOG,I)) Q:I<1  D  Q:ISQN
 . . S X=$G(^LAH(LWL,1,I,0))
 . . ; Quit if different accession area.
 . . I $P(X,"^",3)'=WL Q
 . . ; Quit if different accession date and not a rollover accession (same original accession date).
 . . I $P(X,"^",4)'=LADT,$P($G(^LRO(68,WL,1,LADT,1,LOG,0)),"^",3)'=$P($G(^LRO(68,WL,1,$P(X,"^",4),1,LOG,0)),"^",3) Q
 . . S ISQN=I
 . . D UPDT(LWL,ISQN)
 I '$D(^LRO(68,WL,1,LADT,1,LOG,0)) S LINK="^^"_+LOG G LG2
 S X=^LRO(68,WL,1,LADT,1,LOG,0),LINK=WL_U_LADT_U_LOG,LRDFN=+X,DPF=$P(X,U,2)
LG2 D ISQN
 I $G(LOG)>0 S ^LAH(LWL,1,"C",LOG,ISQN)="",$P(^LAH(LWL,1,ISQN,0),U,3,5)=LINK
 I $G(CENUM)>0 S $P(^LAH(LWL,1,ISQN,0),U,6)=CENUM,^LAH(LWL,1,"D",+CENUM,ISQN)=""
 I $D(^LRO(68.2,LWL,1,+TRAY,1,+CUP,0)) S ^(4,ISQN)=""
 Q
 ;
 ;
ISQN ;
 L +^LAH(LWL):99999
 ;
 F  S (^LAH(LWL),ISQN)=1+$G(^LAH(LWL)) Q:'$D(^LAH(LWL,1,ISQN))
 ;
 S:CUP="" TRAY=1,CUP=ISQN
 S ^LAH(LWL,1,ISQN,0)=TRAY_U_CUP_"^^^^^"_METH_"^"_+$G(IDE)
 ;
 D UPDT(LWL,ISQN)
 ;
 S ^LAH(LWL,1,"B",(+TRAY)_";"_(+CUP),ISQN)=""
 ;
 ; IDE xref added to enable correct identifier for CX4/CX5 instruments
 S ^LAH(LWL,1,"E",+$G(IDE),ISQN)=""
 ;
 ; Set UID xref and .3 node, used to verify by unique identifier (UID).
 I $G(LA7UID)'="" D UID(LWL,ISQN,LA7UID)
 ;
 L -^LAH(LWL)
 Q
 ;
 ;
LLIST ;
 S LRDFN=0,DPF=2
 ;
 I LROVER D  Q:ISQN>0
 . S ISQN=+$O(^LAH(LWL,1,"B",(+TRAY)_";"_(+CUP),0))
 . I ISQN D UPDT(LWL,ISQN)
 ;
 ; Run by load/work list number sent.
 D ISQN S LINK="^^"
 ;
 I $D(^LRO(68.2,LWL,1,TRAY,1,CUP,0)) S LINK=$P(^(0),"^",1,3),^(4,ISQN)=""
 ;
 S $P(^LAH(LWL,1,ISQN,0),U,3,5)=LINK
 ;
 S DPF=2
 Q:LINK="^^"
 S WL=+$P(LINK,"^",1),WDT=+$P(LINK,"^",2),LOG=+$P(LINK,"^",3),^LAH(LWL,1,"C",LOG,ISQN)=""
 S X=$S($D(^LRO(68,WL,1,WDT,1,LOG,0)):^(0),1:"0^2"),DPF=+$P(X,U,2),LRDFN=+X
 ;
 Q
 ;
 ;
SEQN ;
 ; Run by the order data received
 S CUP=""
 D LLIST
 Q
 ;
 ;
CENUM ;
 S DPF=2,LRDFN=0,LOG=$O(^LRO(68,WL,1,DT,1,"D",+CENUM,0))
 G LOG:LOG>0 ;for martinez only
 ;IF CENUM?1A.ANP S Y=CENUM D CEPACK I Y?.ANP S DFN=$O(^LAB(62.3,"B",Y,0)) I DFN S DPF=62.3
 ;
 D ISQN
 ;
 S ^LAH(LWL,1,"C",LOG,ISQN)="",^LAH(LWL,1,"D",+CENUM,ISQN)="",$P(^LAH(LWL,1,ISQN,0),U,6)=CENUM
 ;
 I $D(^LRO(68.2,LWL,1,TRAY,1,CUP,0)) S ^(4,ISQN)=""
 Q
 ;
 ;
IDENT ;
 S DPF=2,LRDFN=0,LOG=$O(^LRO(68,WL,1,DT,1,"C",IDENT,0))
 I LOG>0 D LOG Q
 D ISQN
 Q
 ;
 ;
POC ; Entry point for POC interfaces to setup LAH using "E" x-ref
 ; IDE xref used to identify for POC specimen
 I $G(IDE)'="" D  Q:ISQN
 . S ISQN=$O(^LAH(LWL,1,"E",IDE,0))
 . I ISQN D UPDT(LWL,ISQN) Q
 D LOG
 Q
 ;
 ;
CONTROL ; Verify control's
 ;
 Q:'$D(^LRO(68,WL,1,DT,1,LOG,0))  Q:$P(^(0),U,2)'=62.3
 ;
 S LRDFN=+^LRO(68,WL,1,DT,1,LOG,0)
 S IDT=+$P($G(^LRO(68,WL,1,DT,1,LOG,3)),"^",3)
 I IDT<1 Q
 I '$D(^LR(LRDFN,"CH",IDT,0)) Q
 S $P(^LRO(68,WL,1,DT,1,LOG,3),U,4)=NOW
 S $P(^LR(LRDFN,"CH",IDT,0),U,3)=NOW
 ;
 F I=1:0 S I=$O(^LAH(LWL,1,ISQN,I)) Q:I<1  S ^LR(LRDFN,"CH",IDT,I)=^LAH(LWL,1,ISQN,I)
 ;
 S:'$D(LRTEC) LRTEC=$P(^VA(200,DUZ,0),U,2)
 ;
 F I=0:0 S I=$O(^LRO(68,WL,1,DT,1,LOG,4,I)) Q:I<1  I +$P(^(I,0),U,3)[LWL,'$P(^(0),U,5) S $P(^(0),U,5)=NOW,$P(^(0),U,4)=LRTEC,^LRO(68,WL,1,DT,1,"AC",NOW,LOG)="",^LRO(68,WL,1,DT,1,"AD",NOW\1,LOG)=""
 D CONTXREF
 K:$G(LOG) ^LAH(LWL,1,"C",+LOG)
 K ^LAH(LWL,1,"B",(+TRAY)_";"_(+CUP)),^LAH(LWL,1,ISQN)
 ;
 Q
 ;
 ;
CEPACK S Y=$P(Y,"\",1),YY="" F I=1:1:$L(Y) S:$A(Y,I)>32 YY=YY_$E(Y,I)
 S Y=YY
 K YY
 Q
 ;
 ;
CONTXREF ; Set up verification X-Ref for controls
 ;
 N DA,LRTEST,LRTN,I,LRGTN,X1,X,S1,J,J1
 ;
 S LRTEST=""
 F LRTN=0:0 S LRTN=$O(^LRO(68,WL,1,DT,1,LOG,4,LRTN)) Q:LRTN<1  I $D(^(LRTN,0)),+$P(^(0),U,3)[LWL,+$P(^(0),U,5) S:LRTEST'="" LRTEST=LRTEST_"^"_LRTN S:LRTEST="" LRTEST=LRTN
AC ;
 K ^TMP("LR",$J,"T")
 D ^LREXPD
 F X=0:0 S X=$O(^TMP("LR",$J,"T",X)) Q:X<1  S X1=$P(^(X),";",2) I X1,$D(^LR(LRDFN,"CH",IDT,X1)) S:'$D(^LRO(68,"AC",LRDFN,IDT,X1)) ^(X1)=""
 K ^TMP("LR",$J,"T")
 Q
 ;
 ;
UPDT(LWL,ISQN) ; Set/update date/time this entry in LAH has data added.
 ; Used by clear instrument data option to allow selective clearing based on date/time criteria.
 ; Call with LWL = ien of load/list in LAH
 ;          ISQN = ien of sequence
 N LANOW,LAX
 ;
 S LANOW=$$NOW^XLFDT
 S LAX=$P($G(^LAH(LWL,1,ISQN,0)),"^",10,11)
 ;
 ; Created date/time_"^"_update date/time.
 S LAX=$S($P(LAX,"^",1):$P(LAX,"^",1),1:LANOW)_"^"_LANOW
 S $P(^LAH(LWL,1,ISQN,0),"^",10,11)=LAX
 Q
 ;
 ;
UID(LWL,ISQN,UID) ; Set .3 node and "U" xref with accession's UID.
 ; Used to verify by unique identifier (UID).
 ; Call with LWL = ien of load/list in LAH
 ;          ISQN = ien of sequence
 ;           UID = accession's UID
 ; Called from above, LRVR1, LRVRW
 ;
 N X
 ;
 S X=$P($G(^LAH(LWL,1,ISQN,.3)),"^")
 ; Kill x-ref if existing value different than new value.
 I X]"",X'=UID K ^LAH(LWL,1,"U",X,ISQN)
 ;
 S $P(^LAH(LWL,1,ISQN,.3),"^")=UID
 S ^LAH(LWL,1,"U",UID,ISQN)=""
 Q
 ;
 ;
POI(LWL,ISQN,NODE,LAID) ; Set .1 node with patient/order info
 ; Call with LWL = ien of load/list in LAH
 ;          ISQN = ien of sequence
 ;          NODE = node to store data on (PID, OBR)
 ;          LAID = array containing values
 ;                 PID - "DFN","DOB","ICN","LRDFN","LRTDFN","PNM","SEX","SSN"
 ;                 OBR - "EOL","FID","ORCDT","ORDNLT","ORDP","PON","SID","PEB","PVB"
 ;
 ; ^LAH(LWL,1,ISQN,.1,"OBR","EOL") = enterer's ordering location
 ; ^LAH(LWL,1,ISQN,.1,"OBR","FID") = filler specimen id
 ; ^LAH(LWL,1,ISQN,.1,"OBR","ORCDT") = order date/time (FileMan d/t)
 ; ^LAH(LWL,1,ISQN,.1,"OBR","ORDNLT") = order NLT (multiple separated by "^")
 ; ^LAH(LWL,1,ISQN,.1,"OBR","ORDP") = ordering provider (DUZ or id^last name, first name, mi [id])
 ; ^LAH(LWL,1,ISQN,.1,"OBR","PEB") = placer entered by (DUZ or id^last name, first name, mi [id])
 ; ^LAH(LWL,1,ISQN,.1,"OBR","PON") = placer order number
 ; ^LAH(LWL,1,ISQN,.1,"OBR","PVB") = placer verified by (DUZ or id^last name, first name, mi [id])
 ; ^LAH(LWL,1,ISQN,.1,"OBR","SID") = placer specimen id
 ; ^LAH(LWL,1,ISQN,.1,"PID","DFN") = patient's DFN in file #2
 ; ^LAH(LWL,1,ISQN,.1,"PID","DOB") = date of birth (FileMan d/t)
 ; ^LAH(LWL,1,ISQN,.1,"PID","ICN") = patient's ICN
 ; ^LAH(LWL,1,ISQN,.1,"PID","LRDFN") = patient's LRDFN in file #63
 ; ^LAH(LWL,1,ISQN,.1,"PID","LRTDFN") = patient's LRTDFN in file #67
 ; ^LAH(LWL,1,ISQN,.1,"PID","PNM") = patient's name
 ; ^LAH(LWL,1,ISQN,.1,"PID","SEX") = patient's sex
 ; ^LAH(LWL,1,ISQN,.1,"PID","SSN") = patient's SSN
 ;
 N LAX,LAY,LAZ
 ;
 S LAX=""
 F  S LAX=$O(LAID(LAX)) Q:LAX=""  D
 . S LAY=LAID(LAX)
 . I LAY="" Q
 . S LAZ=$G(^LAH(LWL,1,ISQN,.1,NODE,LAX))
 . I LAY=LAZ Q
 . ; Remove old data and cross-references.
 . I LAZ'="" D
 . . K ^LAH(LWL,1,ISQN,.1,NODE,LAX)
 . . I $P(LAZ,"^")]"" K ^LAH(LWL,1,"A"_LAX,$P(LAZ,"^"),ISQN)
 . ; Set new values and cross-references.
 . S ^LAH(LWL,1,ISQN,.1,NODE,LAX)=LAY
 . I $P(LAY,"^")'="" S ^LAH(LWL,1,"A"_LAX,$P(LAY,"^"),ISQN)=""
 ;
 Q
 ;
 ;
LATYP(LWL,ISQN,LAX) ; Set type of interface for this entry
 ; Call with LWL = ien of load/list in LAH
 ;          ISQN = ien of sequence
 ;           LAX = type of interface
 ; 
 S $P(^LAH(LWL,1,ISQN,0),"^",12)=LAX
 Q
 ;
 ;
LAMSGID(LWL,ISQN,LAX) ; Set pointer to file #62.49 for this entry.
 ; Call with LWL = ien of load/list in LAH
 ;          ISQN = ien of sequence
 ;           LAX = ien of entry in file #62.49 that is source of these results
 ; 
 S $P(^LAH(LWL,1,ISQN,0),"^",13)=LAX
 S ^LAH(LWL,1,ISQN,.01,LAX)=""
 Q
 ;
 ;
METH(LWL,ISQN,LAX) ; Save instrument name/method for this entry
 ; Call with LWL = ien of load/list in LAH
 ;          ISQN = ien of sequence
 ;           LAX = method text
 ;
 N X
 S X=$P(^LAH(LWL,1,ISQN,0),"^",7)
 I X'[LAX S X=LAX_";"_X,$P(^LAH(LWL,1,ISQN,0),"^",7)=X
 Q

LAXSYM ;MLD/ABBOTT/SLC/RAF - TEMPLATE ROUTINE FOR AUTOMATED DATA ;6/13/96 0900 ;
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**11,19**;Sep 27, 1994
 ;CROSS LINK BY ID OR IDE
 ;
LAPX ; orig routine name, copied to LAXSYM (for Abbott AxSYM) 5/3/94 /mld
 ;
 N FR,LANM,TSK,LANM,A,I,X,Y,TC,TV,V1,TOUT,BAD,ID,IDE,TRAY,CUP,LANOCTL1,TP
 N LATEST,RMK,DATE,CNT,LAGEN,RESCOM,RESTYPE,HCNT,DFN,HTYPE,IN,OUT,D
 N LALCT,LAZZ,LINK,LOG,LRDFN,LROVER,LWL,METH,NOW,WL,ALPHA,TST60,TSK
 N ISQN,LADT
 ;
LA1 ; Init vars/arrays
 S LANM=$T(+0),TSK=$O(^LAB(62.4,"C",LANM,0)) Q:TSK<1
 K LATOP D ^LASET Q:'TSK
 D LA1INIT^LAXSYMU ; init vars in util routine
 ;
LA2 ; Begin here to parse out data
 K TV,Y
 S (TST60,TOUT)=0,(A,TRAY)=1,(CUP,ID,IDE,RMK)="",D="|"
 D IN ; get data
 G QUIT:TOUT,LA2:IN=""!(V1'="H") ; 'H' is start of packet
 G:$F("HPORLCQMS",V1)<2 LA2 ; frame hdr = line tag
 I V1="H" S HCNT=CNT-1 ; get hdr count for error trapping
 D @V1 ; get hdr info
 ;
 ; loop thru single packet, L=end of packet
 F A=2:1 D IN Q:TOUT!(V1="L")  I $F("ORLCQMS",V1)>1 D @V1 ; bypass HP
 ;
LA3 ; Now process the packet
 G:'$G(ID) LA2 ; not valid or incomplete record
 X LAGEN G LA2:'ISQN ; Can be changed by the cross-link code
 F I=0:0 S I=$O(TV(I)) Q:I<1  S:TV(I,1)]"" ^LAH(LWL,1,ISQN,I)=TV(I,1)
 I RMK]"" D RMK^LASET
 G LA2
 ;
H ; Header node TYPE: P=pt, Q=qc
 S HTYPE=$P(IN,D,12)
 Q
 ;
P ; Patient node
 S DFN=$P($P(IN,D,5),U)
 Q
 ;
O ; Order node.
 N SPECID,TNUM,PTYPE,X,AN,L
 S SPECID=$P(IN,D,4),AN=$P(SPECID,U),L=$L(AN)
 ; AN is the numeric value of the last 4 characters of SID field!
 S AN=+$TR($E(AN,(L-4),L),ALPHA) ; just the #
 S TNUM=+$P($P(IN,D,5),U,4)
 Q:'TNUM  Q:'AN  ; no AxSYM test or Accn Num
 S TST60=$$ACCN ; get file 60 test num (TST60)
 Q:'TST60  ; invalid test
 S PTYPE=$P(IN,D,12) ; ""=pt, Q=QC
 Q:$P(IN,D,26)'="F"  ; 'F'inal, X=could not run tst
 S (ID,IDE)=AN ; should be OK
 Q
 ;
R ; Results node
 Q:'ID  ; no accn to put results to!
 N TST,TNUM,TRES,V,DEC,FLAG
 S FLAG=$P(IN,D,7) Q:FLAG="<"  Q:FLAG=">"  ; test out of range
 ;
 S TST=$P(IN,D,3) ; eg., TST = "^^^211^GLUCOSE^UNDILUTED"
 S TNUM=+$P(TST,U,4) ; AxSYM's internal test number
 Q:'$D(LATEST(TNUM,TST60))  ; invalid AxSYM/DHCP test match
 ;
 S TRES=$P(TST,U,8),V=$P(IN,D,4)
 I TRES="X" S ^LA(INST,"ERX",$H)=IN Q  ; Xception results (error msg)
 Q:"F"'[TRES  ; type result should be "F"inal or NULL
 Q:V=""  ; no result!
 ;
 S DEC=TC(+LATEST(TNUM,TST60),3)
 I $L(DEC) S V=$J(V,1,DEC) ; # dec'mls (Param 2)
 X:$L(TC(+LATEST(TNUM,TST60),2)) TC(+LATEST(TNUM,TST60),2) ; use param 1
 S @TC(+LATEST(TNUM,TST60),1)=V ; save to TV array
 Q
 ;
L ; Packet termination node
 Q
 ;
C ; Comments node.  type = G if result comment, = I if Exception string
 S (RMK,RESCOM)=$P(IN,D,4),RESTYPE=$P(IN,D,5)
 Q
 ;
Q ; Set-up Query node
 N LRAN,LRAA,LRDT,LRNAME,SSN,LRFRM,BAD,LRAD,INST
 S LRAA=WL,(LRDT,LRAD)=LADT,LRNAME="",LRFRM=0,BAD=0,INST=TSK
 S LRAN=$P($P(IN,D,3),U,2)
 D PNM^LAXSYMBL
 ; chk for valid request
 I LRNAME=""!('$F(IN,"^^ALL")) S $P(IN,"|",13)="X",BAD=1
 D HQSET^LAXSYMHQ ; builds H/Q/L frames for downloading
 S X="TRAP^"_LANM,@^%ZOSF("TRAP") ; reset error trap
 Q
 ;
M ; Manufacturer node
 Q
 ;
S ; Scientific (not used)
 Q
 ;
ACCN() ; Chk file 68 for Accn'd test (file 60)
 N I,J,N S (I,J,N)=0
 F  S I=$O(LATEST(TNUM,I)) Q:'I  I $D(^LRO(68,WL,1,LADT,1,AN,4,I)) Q
 I 'I F  S J=$O(^LRO(68,WL,1,LADT,1,AN,4,J)) Q:'J  S I=0 D  I N S I=N Q
 .F  S I=$O(^LAB(60,J,2,I)) Q:'I  I $D(LATEST(TNUM,^(I,0))) S N=^(0) Q
 Q +I
 ;
NUM ;- not used here - IN+3,4 replaces this (slower) code  /mld
 S X="" F JJ=1:1:$L(V) S:$A(V,JJ)>32 X=X_$E(V,JJ)
 S V=X
 Q
 ;
IN S CNT=^LA(TSK,"I",0)+1 IF '$D(^(CNT)) S TOUT=TOUT+1 Q:TOUT>5  H 5 G IN
 S ^LA(TSK,"I",0)=CNT,IN=^(CNT),TOUT=0
 ; strip contl chars, get FRame num and hdr node (H,P,O,R,L)
 ; NOTE: $TR(IN,LANOCTL1) replaces 'D NUM' code in template routine /mld
 S IN=$TR(IN,LANOCTL1),FR=+IN,V1=$TR($P(IN,D),FR)
 Q
 ;
QUIT L +^LA(TSK,"I")
 K ^LA(TSK,"I"),^LA("LOCK",TSK),^TMP($J),^TMP("LA",$J)
 I $D(ZTSK) D KILL^%ZTLOAD K ZTSK
 L -^LA(TSK,"I")
 Q
 ;
TRAP ; Process errors
 D ^LABERR S T=TSK
 S ^LA(TSK,"I",0)=+$G(HCNT) ; keeps last HDR frame location
 D SET^LAB G LA2

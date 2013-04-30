ECXPHVE ;ALB/JAM - Pharmacy Volume Edit ;6/27/12  15:12
 ;;3.0;DSS EXTRACTS;**92,120,136**;Dec 22, 1997;Build 28
 ;
EN ;entry point from menu option
 N DIR,DIRUT,ECXX,Y,STOP,ECPIECE
 N $ESTACK,$ETRAP S $ETRAP="D RESET^ECXPHVE"
 S DIR(0)="SO^P:PRE;I:IVP;U:UDP"
 S DIR("A")="Which extract do you need to edit?"
 D ^DIR I $D(DIRUT) Q
 S ECXX=Y(0),ECPIECE=$S(ECXX="PRE":2,ECXX="IVP":19,1:8)
 S STOP=0 I $P($G(^ECX(728,1,7.1)),"^",ECPIECE)]"" D  I STOP Q
 .W !!,ECXX," Extract running, cannot edit. Try later.",!! S STOP=1
 .K DIR S DIR(0)="E" D ^DIR
 S $P(^ECX(728,1,7.1),"^",ECPIECE)="R"
 D EXTEDT
 Q
 ;
EXTEDT ;Edit extracts - PRE, IVP, or UDP
 N DIC,DIE,DA,DR,DTOUT,DUOUT,Y,D
 ;PRE extract (file #727.1) edit Quantity (field #16) & Unit of Issue (field #22)
 I ECXX="PRE" D
 .S DA=$$GETSEQ(727.81)
 .S DIC="^ECX(727.81,",DR="16;22"
 .D TURNON^DIAUTL(727.81,"16;22","y")
 ;IVP extract (file #727.819) edit Quantity (field #10)&Total Doses per Day (#20)
 I ECXX="IVP" D
 .S DA=$$GETSEQ(727.819)
 .S DIC="^ECX(727.819,",DR="10;20"
 .D TURNON^DIAUTL(727.819,"10;20","y")
 ;UDP extract (file #727.809) edit Quantity (field #10)
 I ECXX="UDP" D
 .S DA=$$GETSEQ(727.809)
 .S DIC="^ECX(727.809,",DR="10"
 .D TURNON^DIAUTL(727.809,"10","y")
 S DIE=DIC D ^DIE
RESET I $G(ECXX)="" Q
 I ECXX="PRE" D TURNON^DIAUTL(727.81,"16;22","e")
 I ECXX="IVP" D TURNON^DIAUTL(727.819,"10;20","e")
 I ECXX="UDP" D TURNON^DIAUTL(727.809,"10","e")
 I $G(ECPIECE) S $P(^ECX(728,1,7.1),"^",ECPIECE)=""
 Q
CKREC(ECXN) ;Checks if record should be edited.
 I ECXN="" Q 0
 I $G(^ECX(727,ECXN,"PURG"))'="" Q 0
 I $G(^ECX(727,ECXN,"TR"))'="" Q 0
 I $G(^ECX(727,ECXN,"Q"))'="" Q 0
 Q 1
 ;
CHKSEQ() ;Check sequence to see if it can be edited - API added in 136
 N CANEDIT
 S CANEDIT=1
 I '$D(^ECX(FILE,X,0)) S CANEDIT=0
 I +SSN I $P($G(^ECX(FILE,X,0)),U,6)'=SSN S CANEDIT=0
 Q CANEDIT
 ;
GETSEQ(FILE) ;Get sequence number to edit
 N EXT,SEQ,DIR,SSN
 S SEQ=0
 S EXT=$$GETEXT(FILE) I '+EXT Q SEQ  ;Nothing selected
 S SSN=$$GETSSN I SSN=-1 Q SEQ
 S DIR(0)="NA^1:1000000000^K:'$$CHKSEQ^ECXPHVE X"
 S DIR("A")="Select "_$G(ECXX)_" EXTRACT SEQUENCE NUMBER: "
 S DIR("?")="^D HELP2^ECXPHVE"
 D ^DIR
 I Y>0 S SEQ=+Y
 Q SEQ
 ;
GETEXT(FILE) ;get extract number
 N DIR,RES
 S RES=0
 S DIR(0)="NA^1:10000000:0^K:'$D(^ECX(FILE,""AC"",X))!('$$CKREC^ECXPHVE(X)) X"
 S DIR("A")="Select "_$G(ECXX)_" EXTRACT NUMBER: "
 S DIR("?")="^D HELP^ECXPHVE"
 D ^DIR
 I +Y S RES=+Y
 Q RES
 ;
HELP ;
 N NUM
 W !,"Select from one of the following extract numbers:",!,"If no numbers appear then there are no extracts that can",!,"be edited.",!
 S NUM=0 F  S NUM=$O(^ECX(FILE,"AC",NUM)) Q:'+NUM  I $$CKREC(NUM) W !,NUM
 Q
 ;
GETSSN() ;
 N DIR,NUM,DUOUT,DTOUT
 S NUM=0
 S DIR(0)="FAO^9:10^K:X'?9N&(X'?9N1""P"") X"
 S DIR("A")="Enter patient's SSN, if known, or press ENTER to continue: "
 S DIR("?",1)="Enter patient's SSN, if known.  The SSN will be used to find sequence numbers"
 S DIR("?",2)="associated with this patient.  Enter 9 digits or 9 digits and P, no"
 S DIR("?")="hyphens or spaces.  Entry is optional."
 D ^DIR
 I $L(Y)=9!($L(Y)=10) S NUM=Y
 I $D(DUOUT)!($D(DTOUT)) S NUM=-1
 Q NUM
 ;
HELP2 ;Display list of sequence numbers to choose from
 N SEQNO,DIR,Y,CNT
 W !,"Select from one of the following sequence numbers:"
 S Y=1,CNT=0
 D HDR
 S SEQNO=0 F  S SEQNO=$O(^ECX(FILE,"AC",EXT,SEQNO)) Q:'+SEQNO!('+Y)  D
 .I SSN I $P($G(^ECX(FILE,SEQNO,0)),U,6)'=SSN Q  ;Check for SSN if user entered
 .W !,SEQNO,?12,$P(^ECX(FILE,SEQNO,0),U,6),?24,$$ECXDATEX^ECXUTL($P(^(0),U,9)),?38,$P(^(0),U,$S(FILE=727.81:17,1:11)),?48,$S(FILE=727.81:$P(^(0),U,23),FILE=727.819:$P(^(0),U,20),1:"") S CNT=CNT+1
 .I CNT>18 S DIR(0)="E" D ^DIR S CNT=0 D HDR
 Q
 ;
HDR ;
 W !,"SEQUENCE #",?12,"SSN",?24,$S(ECXX="PRE":"FILL DT",1:"DISPENSE DT"),?38,"QUANTITY",?48,$S(ECXX="PRE":"UNIT OF ISSUE",ECXX="IVP":"TOTAL DOSES/DAY",1:"")
 W !,$$REPEAT^XLFSTR("-",$S(ECXX'="UDP":64,1:48))
 Q

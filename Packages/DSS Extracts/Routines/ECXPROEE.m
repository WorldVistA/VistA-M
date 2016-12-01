ECXPROEE ;ALB/DAN - Prosthetics Extract Edit ;4/5/16  15:15
 ;;3.0;DSS EXTRACTS;**161**;Dec 22, 1997;Build 6
 ;
EN ;entry point from menu option
 N DIR,DIRUT,ECXX,Y,STOP,ECPIECE
 S ECXX="PRO",ECPIECE=23
 S STOP=0 I $P($G(^ECX(728,1,7.1)),"^",ECPIECE)]"" D  I STOP Q
 .W !!,ECXX," Extract running, cannot edit. Try later.",!! S STOP=1
 .K DIR S DIR(0)="E" D ^DIR
 S $P(^ECX(728,1,7.1),"^",ECPIECE)="R"
 D EXTEDT
 S $P(^ECX(728,1,7.1),"^",ECPIECE)=""
 Q
 ;
EXTEDT ;Edit extract
 N DIC,DIE,DA,DR,DTOUT,DUOUT,Y,D,DIR,DIRUT
 S DA=$$GETSEQ(727.826) Q:'+DA
 S DIR(0)="NOA^1:1000",DIR("A")="QUANTITY: ",DIR("B")=+$P(^ECX(727.826,DA,0),U,12),DIR("?")="Enter quantity. Must be between 1 and 1000 with no decimal digits."
 D ^DIR
 I Y=+$P(^ECX(727.826,DA,0),U,12)!($G(DIRUT)) Q  ;Quantity didn't change or user exited
 S DIC="^ECX(727.826,",DR="11////"_$$RJ^XLFSTR(Y,8,0) ;Expand answer to have leading zeroes
 D TURNON^DIAUTL(727.826,"11","y")
 S DIE=DIC D ^DIE
 D TURNON^DIAUTL(727.826,"11","n")
 Q
CKREC(ECXN) ;Checks if record should be edited.
 I ECXN="" Q 0
 I $G(^ECX(727,ECXN,"PURG"))'="" Q 0
 I $G(^ECX(727,ECXN,"TR"))'="" Q 0
 I $G(^ECX(727,ECXN,"Q"))'="" Q 0
 Q 1
 ;
CHKSEQ() ;Check sequence to see if it can be edited
 N CANEDIT
 S CANEDIT=1
 I '$D(^ECX(FILE,X,0)) S CANEDIT=0
 I +SSN I $P($G(^ECX(FILE,X,0)),U,6)'=SSN S CANEDIT=0
 I '$D(^ECX(FILE,"AC",EXT,X)) S CANEDIT=0 ;check to be sure sequence number is in selected extract
 Q CANEDIT
 ;
GETSEQ(FILE) ;Get sequence number to edit
 N EXT,SEQ,DIR,SSN
 S SEQ=0
 S EXT=$$GETEXT(FILE) I '+EXT Q SEQ  ;Nothing selected
 S SSN=$$GETSSN I SSN=-1 Q SEQ
 S DIR(0)="NA^1:1000000000^K:'$$CHKSEQ^ECXPROEE X"
 S DIR("A")="Select "_$G(ECXX)_" EXTRACT SEQUENCE NUMBER: "
 S DIR("?")="^D HELP2^ECXPROEE"
 D ^DIR
 I Y>0 S SEQ=+Y
 Q SEQ
 ;
GETEXT(FILE) ;get extract number
 N DIR,RES
 S RES=0
 S DIR(0)="NA^1:10000000:0^K:'$D(^ECX(FILE,""AC"",X))!('$$CKREC^ECXPROEE(X)) X"
 S DIR("A")="Select "_$G(ECXX)_" EXTRACT NUMBER: "
 S DIR("?")="^D HELP^ECXPROEE"
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
 .W !,SEQNO,?12,$P(^ECX(FILE,SEQNO,0),U,6),?24,$$ECXDATEX^ECXUTL($P(^(0),U,9)),?39,+$P(^(0),U,12)
 .S CNT=CNT+1
 .I CNT>18 S DIR(0)="E" D ^DIR S CNT=0 D HDR
 Q
 ;
HDR ;
 W !,"SEQUENCE #",?12,"SSN",?24,"DELIVERY DATE",?39,"QUANTITY"
 W !,$$REPEAT^XLFSTR("-",48)
 Q

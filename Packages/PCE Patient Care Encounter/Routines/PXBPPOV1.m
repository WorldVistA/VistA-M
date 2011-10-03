PXBPPOV1 ;ISL/JVS,ESW - PROMPT POV ;4/6/05 2:41pm
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**11,112,121,124**;Aug 12, 1996
 ;
 ;
 ;
 ;
 ;
ADDM ;--------If Multiple POV entries have been entered.
 ;
 ;
 ;
 N OK,PXBLEN,BDATA
 D WIN17^PXBCC(PXBCNT)
 S NF=0,PXBLEN=0
 I DATA[",",$E(DATA,1)'["@" S NF=1 D
 .S PXBLEN=$L(DATA,",") F PXI=1:1:PXBLEN S PXBPIECE=$P(DATA,",",PXI) D
 ..S X=PXBPIECE,DIC=80,DIC(0)="IMZ",DIC("S")="I $P($$ICDDX^ICDCODE(Y,IDATE),U,10)" D ^DIC
 ..I Y=-1 S BAD(+$G(PXBPIECE))="" Q
 ..S $P(REQI,"^",5)=+Y
 ..S PXBNPOV(PXBPIECE)=""
 ..;
 ..;--Prompt for Primary or Secondary DIAGNOSIS
 ..W !,"For the DIAGNOSIS: ",PXBPIECE,"--"
 ..W $P($$ICDDX^ICDCODE(PXBPIECE,IDATE),U,2),!
 ..D WIN17^PXBCC(PXBCNT)
 ..D PRI^PXBPPOV1
 ..I $D(DIRUT) D RSET^PXBDREQ("POV") Q
 ..D ORD^PXBPPOV1
 ..N PXCEVIEN,PXCEAFTR,PXD
 ..S PXCEVIEN=PXBVST,PXD=$P(REQI,U,5)
 ..D WIN17^PXBCC(PXBCNT),GET800^PXCEC800 ;CI's
 ..S PXBREQ(PXD,"I")=$G(PXCEAFTR(800))
 ..;
 ..D EN0^PXBSTOR(PXBVST,PATIENT,REQI)
 ..D EN1^PXKMAIN
 ..D RSET^PXBDREQ("POV")
 I $G(NF)&($D(BAD)) D  Q
 .S (BDATA,EDATA)="" F  S BDATA=$O(BAD(BDATA)) Q:BDATA=""  S EDATA=EDATA_BDATA_"  "
 .W ! D HELP^PXBUTL0("CPTM") W !
 .S DIR(0)="E" D ^DIR K DIR,DIRUT
 .S:Y=1 DATA="^P" S:Y=0!(Y="") DATA="^" K Y
 I $G(NF)&('$D(BAD)) S DATA="^P" Q
 ;
 Q
 ;
DELM ;--------If Multiple deleting
 N DELM,PXBJ,BAD,PXBLEN,BDATA
 S NF=0,PXBLEN=0 S $P(DELM,"^",3)=1
 I $E(DATA,1)="@" S DATA=$P(DATA,"@",2),NF=1 D
 .S PXBLEN=$L(DATA,",") F PXI=1:1:PXBLEN S PXBPIECE=$P(DATA,",",PXI) D
 ..I PXBPIECE'["-"&(PXBPIECE'>0!(PXBPIECE'<(PXBCNT+1))) S BAD(+$G(PXBPIECE))="" Q
 ..I PXBPIECE'["-" D
 ...I $D(GONE(PXBPIECE)) Q
 ...Q:PXBPIECE'?.N
 ...S $P(REQI,"^",9)=$O(PXBSKY(PXBPIECE,0)) ;-IEN
 ...S X=$P(PXBSAM(PXBPIECE),"^",1),DIC=80,DIC(0)="IZM",DIC("S")="I $P($$ICDDX^ICDCODE(Y,IDATE),U,10)" D ^DIC
 ...S $P(REQI,"^",5)=+Y K Y
 ...S GONE(PXBPIECE)=""
 ...D EN0^PXBSTOR(PXBVST,PATIENT,REQI)
 ...D EN1^PXKMAIN
 ..I PXBPIECE["-" D
 ...F PXBJ=$P(PXBPIECE,"-",1):1:$P(PXBPIECE,"-",2) D
 ....I $D(GONE(PXBJ)) Q
 ....I PXBJ'>0!(PXBJ'<(PXBCNT+1)) S BAD(PXBJ)="" Q
 ....S $P(REQI,"^",9)=$O(PXBSKY(PXBJ,0)) ;-IEN
 ....S X=$P(PXBSAM(PXBJ),"^",1),DIC=80,DIC(0)="IZM",DIC("S")="I $P($$ICDDX^ICDCODE(Y,IDATE),U,10)" D ^DIC
 ....S $P(REQI,"^",5)=+Y K Y
 ....S GONE(PXBJ)=""
 ....D EN0^PXBSTOR(PXBVST,PATIENT,REQI)
 ....D EN1^PXKMAIN
 K GONE
 I $G(NF)&($D(BAD)) D  Q
 .S (BDATA,EDATA)="" F  S BDATA=$O(BAD(BDATA)) Q:BDATA=""  S EDATA=EDATA_BDATA_"  "
 .W ! D HELP^PXBUTL0("CPTMD") W !
 .S DIR(0)="E" D ^DIR K DIR
 .S:Y=1 DATA="^P" S:Y=0!(Y="") DATA="^" K Y
 I $G(NF)&('$D(BAD)) S DATA="^P" Q
 Q
PRI ;--Prompt for primary secondary DIAGNOSIS
 N DIR,Y,X,SEQ
 S SEQ=0 I $D(PXBKY(DATA)) S SEQ=+$O(PXBKY(DATA,"")) ;PX112
 I $G(FPRI),$P($G(PXBKY(DATA,SEQ)),U,4)'="PRIMARY" Q  ;PX112
 W IOCUD,IOELALL,IOCUU
 S DIR("A",1)="ONE primary diagnosis must be established for each encounter!"
 S DIR("A")="Is this the PRIMARY DIAGNOSIS for this ENCOUNTER? "
 S DIR("B")="YES"
 S DIR("?")="One PRIMARY DIAGNOSIS must be established for each patient encounter. 'Yes' will mean PRIMARY and 'No' will mean SECONDARY."
 S DIR(0)="Y,A,O"
 D ^DIR I $G(DIRUT) G PPXIT
PPFIN ;--Finish off variables
 I Y=1 S PRI="P^PRIMARY"
 I Y=0 S PRI="S^SECONDARY"
 S $P(REQI,"^",6)=$P(PRI,"^",1)
 S $P(REQE,"^",6)=$P(PRI,"^",2)
PPXIT ;--EXIT
 Q
ORD ;--Prompt for ordering resulting DIAGNOSIS
 N DIR,Y,X,SEQ
 S SEQ=0 I $D(PXBKY(DATA)) S SEQ=+$O(PXBKY(DATA,""))
 W IOCUD,IOELALL,IOCUU
 S DIR("A")="Is this Diagnosis Ordering or Resulting:"
 S DIR("B")=$P($G(PXBKY(DATA,SEQ)),U,7)
 S DIR("?")="Resulting and/or Ordering indicators are only entered if at least one of each diagnosis type exists."
 S DIR(0)="SO^O:ORDERING;R:RESULTING;OR:BOTH O&R"
 D ^DIR I $G(DIRUT) G PPXIT
ORFIN ;--Finish off variables
 S $P(REQI,"^",7)=Y
 S $P(REQE,"^",7)=$S(Y="O":"ORDERING",Y="R":"RESULTING",1:"BOTH O&R")
 Q
PRBLM ;--Prompt for Problem list
 N DIR,Y,X,VALL
 W IOCUD,IOELALL,IOCUU
 D WIN17^PXBCC(PXBCNT)
 S DIR("?")="^S VALL=1,VALL=$$DOUBLE1^PXBGPL2(WHAT)"
 S DIR("A")="Do you want this DIAGNOSIS added to the PROBLEM LIST? "
 S DIR("B")="NO"
 S DIR(0)="Y,A,O"
 D ^DIR
 I X="+"!(X="-") S DIR("?")="D DPOV4^PXBDPL(X)"
 I $G(DIRUT) G PPXIT
PRPFIN ;--Finish off variables
 K PXBKYPL,PXBSKYPL,PXBSAMPL,PXBCNTPL
 K ^TMP("PXBKYPL",$J),^TMP("PXBSAMPL",$J)
 S PXBPRBLM=+Y
PRPXIT ;--EXIT
 Q
 ;

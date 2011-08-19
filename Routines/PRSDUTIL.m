PRSDUTIL ;HISC/MGD-PAID DOWNLOAD UTILITY SUB-ROUTINES ;09/10/2003
 ;;4.0;PAID;**32,82,99**;Sep 21, 1995
PIC9 ;Replace 0s
 S DIF=LTH-$L(GRPVAL) I DIF>0 F FF=1:1:DIF S GRPVAL="0"_GRPVAL
 K DIF,FF Q
SIGN ;Sign conversion
 S L=$L(DATA),S=$E(DATA,L)
 S LC=$S(S="{":0,S="A":1,S="B":2,S="C":3,S="D":4,S="E":5,S="F":6,S="G":7,S="H":8,S="I":9,S="}":0,S="J":1,S="K":2,S="L":3,S="M":4,S="N":5,S="O":6,S="P":7,S="Q":8,S="R":9,1:S)
 S DATA=$E(DATA,1,L-1)_LC
 S:(S="}")!(S="J")!(S="K")!(S="L")!(S="M")!(S="N")!(S="O")!(S="P")!(S="Q")!(S="R") DATA="-"_DATA
 K L,LC,S Q
D ;.0
 S L=$L(DATA),DATA=$E(DATA,1,L-1)_"."_$E(DATA,L) K L G RZ
DD ;.00
 S L=$L(DATA),DATA=$E(DATA,1,L-2)_"."_$E(DATA,L-1,L) K L G RZ
DDD ;.000
 S L=$L(DATA),DATA=$E(DATA,1,L-3)_"."_$E(DATA,L-2,L) K L G RZ
DDDD ;.0000
 S L=$L(DATA),DATA=$E(DATA,1,L-4)_"."_$E(DATA,L-3,L) K L G RZ
DDDDD ;.00000
 S L=$L(DATA),DATA=$E(DATA,1,L-5)_"."_$E(DATA,L-4,L) K L G RZ
AHRS ;Acct hrs
 S L=$L(DATA),LD=$E(DATA,L),FD=$E(DATA,1,L-1)
 S LD=$S(LD=0:"00",LD=1:25,LD=2:50,LD=3:75,1:LD)
 S DATA=FD_"."_LD,DATA=+DATA
 K FD,L,LD G RZ
PCT ;%
 S:+$P(DATA,".",2)=0 DATA=DATA\1
 S DATA=DATA_"%" Q
RZ ;Remove leading 0s
 I +DATA=0 S DATA="" Q
 S FC=$E(DATA,1)
 S $P(DATA,".")=+$P(DATA,".")
 I FC="-",$E(DATA,1)'="-" S DATA="-"_DATA
 K FC Q
DATE ;Convert Austin Date to Fileman Date
 ;Austin's date has form xxYYMMDD or YYYYMMDD
 Q:DATA=""
 I $E(DATA,5,8)="0000" S DATA="" Q
 N X,Y,%DT,DTOUT
 S X=$E(DATA,5,8)_$S(+$E(DATA)'=$E(DATA):$E(DATA,3,4),1:$E(DATA,1,4))
 S %DT="" D ^%DT
 S DATA=$S(Y>0:Y,1:"")
 Q
LZ ;Insert leading 0s
 F UUU=1:1:L-$L(DATA) S DATA=0_DATA
 K L,UUU Q
RTS ;Remove trailing spaces
 Q:$E(DATA,$L(DATA))'=" "
 F SLOOP=$L(DATA):-1 Q:$E(DATA,SLOOP)'=" "  S DATA=$E(DATA,1,SLOOP-1)
 K SLOOP Q
OT ;Output trans
 Q:Y=""  S IEN454=0,IEN454=$O(^PRSP(454,1,SUB454,"B",Y,IEN454))
 I IEN454>0,$P(^PRSP(454,1,SUB454,IEN454,0),U,2)'="" S Y=$P(^PRSP(454,1,SUB454,IEN454,0),U,2) I SUB454="ORG",$D(^PRSP(454.1,Y,0)) S Y=$P(^PRSP(454.1,Y,0),U,1)
 K IEN454,SUB454 Q
SOT ;State
 Q:Y=""
 S IEN5=0,IEN5=$O(^DIC(5,"C",Y,IEN5))
 S Y=$S(IEN5>0:$P(^DIC(5,IEN5,0),U,1),1:Y)
 K IEN5 Q
AC ;Asgmnt code
 Q:Y=""
 S AC="",AC1="",OSC=$E($P(^PRSPC(D0,0),U,17),1,4)
 F LLL=0:0 S LLL=$O(^PRSP(454,1,"ASS","B",Y,LLL)) Q:LLL=""  D  Q:AC'=""
 .S OCCS=$P(^PRSP(454,1,"ASS",LLL,0),U,3)
 .I OCCS="" S AC1=$P(^PRSP(454,1,"ASS",LLL,0),"^",2)
 .I OCCS[OSC S AC=$P(^PRSP(454,1,"ASS",LLL,0),"^",2)
 S Y=$S(AC'="":AC,1:AC1)
 K AC,AC1,LLL,OCCS,OSC Q
TITLE ;Title
 I DATA="      " S DATA="" Q
 S LD=$E(DATA,6) S:LD'?1N $P(^PRSPC(IEN,0),U,42)=LD
 I $P(^PRSPC(IEN,0),U,42)?1U&(LD?1N) S $P(^PRSPC(IEN,0),U,42)=""
 K LD Q
NH ;Norm Hrs
 S DATA=+DATA,DB=$P(^PRSPC(IEN,0),U,10)
 S NH=$S(DATA>0:DATA,DB=1:80,DB=2:DATA,DB=3:0,1:0)
 S $P(^PRSPC(IEN,0),U,50)=NH
 K DB,NH Q
STEP ;Step
 I DATA="  " S DATA="" Q
 S:$E(DATA,1)=" " DATA=$E(DATA,2) Q
ORGCC ;Org/Cost Cntr
 I DBNAME="MXORGCOD" S COST=$E(DATA,1,4),$P(^PRSPC(IEN,0),U,18)=COST
 S CCORG=$E(DATA,1,4)_":"_$E(DATA,5,8)
 I '$D(^PRSP(454,1,"ORG","B",CCORG)) K DD,DO S DIC="^PRSP(454,1,""ORG"",",DIC(0)="L",DLAYGO=454,X=CCORG D FILE^DICN S ^TMP($J,"ORG",CCORG)=""
 K COST,CCORG,DIC,DLAYGO,X Q
PVAE ;Prior VA Exp
 F ABC=1:1:$L(DATA) S PV=$E(DATA,ABC),PIECE=$S(PV="A":1,PV="B":2,PV="C":3,PV="D":4,PV="E":5,PV="F":6,PV="G":7,PV="H":8,PV="I":9,PV="J":10,PV="K":11,PV="L":12,PV="M":13,PV=0:ABC,1:"") S:PIECE'="" $P(^PRSPC(IEN,NODE),U,PIECE)=PV
 K ABC,PV Q
ZIP ;Zip
 I +DATA=0 S DATA="" Q
 I $E(DATA,6,9)="0000" S DATA=$E(DATA,1,5) Q
 S DATA=$E(DATA,1,5)_"-"_$E(DATA,6,9) Q
NPLWOP ;Nonpay & LWOP Hrs
 S LVGRP=$P(^PRSPC(IEN,0),U,15)
 S NPLWOP=$S((LVGRP=4)!(LVGRP=5):$J((DATA/14)*80,1,0),1:DATA)
 I DBNAME="ANONPATIME" S $P(^PRSPC(IEN,1),U,43)=NPLWOP S:TYPE="P" $P(^PRST(459,PPIEN,"P",IEN,6),U,5)=NPLWOP
 I DBNAME="ALWOPUSED" S $P(^PRSPC(IEN,"LWOP"),U,11)=NPLWOP S:TYPE="P" $P(^PRST(459,PPIEN,"P",IEN,4),U,9)=NPLWOP
 K LVGRP,NPLWOP Q
NEWSSN ;New SSN
 I $L(DATA)<9 S L=9 D LZ
 Q
COMP ;0 out comp time bal
 I DATA="",$E(^PRSPC(IEN,"COMP"),1,7)="^^^^^^^",$P(^PRSPC(IEN,"COMP"),U,9)'="" F ABC=9:1:17 S $P(^PRSPC(IEN,"COMP"),U,ABC)=""
 Q
OST ;Occupation Series & Title Output Transform
 S OSC=Y,OSC14=$E(Y,1,4),OSC15=$E(Y,1,5),LD=$E(Y,6)
 G:LD?1N OSTOT
 I OSC14<2200 S NLD=$S((LD="A")!(LD="J"):1,(LD="B")!(LD="K"):2,(LD="C")!(LD="L"):3,(LD="D")!(LD="M"):4,(LD="E")!(LD="N"):5,(LD="F")!(LD="O"):6,(LD="G")!(LD="P"):7,(LD="H")!(LD="Q"):8,(LD="I")!(LD="R"):9,1:LD) S Y=OSC15_NLD
 I OSC14>2600,LD'?1N S Y=OSC15_"0"
OSTOT S SUB454="OCC" D OT^PRSDUTIL K SUB454
 I OSC14<2200,(LD="A")!(LD="B")!(LD="C")!(LD="D")!(LD="E")!(LD="F")!(LD="G")!(LD="H")!(LD="I") S:(Y'["OFFICER")!(Y="POLICE OFFICER") Y="SUPERVISORY "_Y G OSTEX
 I OSC14<2200,(LD="J")!(LD="K")!(LD="L")!(LD="M")!(LD="N")!(LD="O")!(LD="P")!(LD="Q")!(LD="R") S Y="LEAD "_Y G OSTEX
 I OSC14>2600,(LD="F")!(LD="G")!(LD="H")!(LD="L")!(LD="S") S SUF=$S(LD="H":" HELPER",LD="L":" LEADER",LD="F":" FOREMAN",LD="G":" GENERAL FOREMAN",LD="S":" SUPERVISOR",1:LD),Y=Y_SUF
OSTEX K OSC,OSC14,OSC15,LD,NLD,SUF
 Q
 ;
LD ; Set Labor Distribution fields into Multiple.
 N PRSTMP
 S PRSTMP=DATA,DATA=$E(DATA,1,4)
 D LD^PRSDSET
 S DATA=PRSTMP
 Q
 ;==============================================================
PATCH32 ;Subprograms LOOP450 and DTCMP are post-installation routines 
 ;for patch PRS*4*32.  They have no other intended use.
 ;Convert fields that have received year 2000 dates from Austin.
 ;Loop thru all employee records.  Within employee records loop thru
 ;the 9 nodes (see ND variable) in each record that contain potential 
 ;problem dates.  Traverse the up arrow delimited data in each node, 
 ;but only check the pieces defined in the CHECK array nodes.
 ;Convert dates in those fields that fall between jan 01, 1900 and
 ;DEC 31, 1910 inclusively.  The conversion will only change the
 ;century to the 21st.
 ;
 ;
 Q
 ;==============================================================
LOOP450 ;
 ;
 ;****Keep post-installation from running on subsequent patch installs
 I $$PATCH^XPDUTL("PRS*4.0*32") D MSSG(0) Q
 ;
 D MSSG(1)
 N CHECK,ND,REC,PIECES,XPDIDTOT,DIV,%
 S CHECK(0)="51^"
 S CHECK(1)="30^"
 S CHECK(2)="2^3^4^5^6^7^8^9^10^11^12^13^14^15^16^17^18^20^22^23^24^25^26^27^28^29^30^31^32^"
 S CHECK(3)="1^2^3^4^5^6^7^8^9^10^11^12^13^14^15^16^19^20^21^22^"
 S CHECK(4)="1^2^3^4^5^6^7^8^9^10^11^12^13^14^15^16^17^18^19^20^"
 S CHECK("PCD")="4^"
 S CHECK("MSD2")="9^"
 S CHECK("BOND1")="12^"
 S CHECK("BOND2")="11^"
 S CHECK("TSP1")="5^12^14^"
 ;
 S XPDIDTOT=$P($G(^PRSPC(0)),"^",4)
 S DIV=XPDIDTOT\20
 S %=0
 S REC=0 F  S REC=$O(^PRSPC(REC))  Q:REC'>0  D
 . S %=%+1
 . I '(%#DIV) D UPDATE^XPDID(%)
 . S ND=""
 . F  S ND=$O(CHECK(ND)) Q:ND=""  D
 ..   I $G(^PRSPC(REC,ND))'="" D
 ...     S PIECES=CHECK(ND)
 ...     D DTCMP(REC,ND,$G(^PRSPC(REC,ND)),PIECES)
 Q
 ;==============================================================
DTCMP(IEN,NODE,DATANODE,PIECES) ;
 ;Look at all PEICES in a single DATANODE of an employee's record
 ;and convert dates from 1900-1910 to respective dates in 2000-2010.
 N PIECE,NEXT,NEWDATE,DATA
 F NEXT=1:1 S PIECE=$P(PIECES,"^",NEXT)  Q:PIECE=""  D
 .  S DATA=$P(DATANODE,"^",PIECE)
 .  I (DATA<2110101),(DATA>1991231) D
 ..   S NEWDATE="3"_$E(DATA,2,7)
 ..   S $P(^PRSPC(IEN,NODE),"^",PIECE)=NEWDATE
 Q
 ;==============================================================
MSSG(FLAG) ;OUT PUT POST INSTALLATION MESSAGE.
 N MSSG
 I FLAG S MSSG="Checking date fields in File 450."
 E  S MSSG="Date fields not checked.  Checked during previous install of PRS*4*32"
 D MES^XPDUTL(MSSG)
 Q
 ;==============================================================

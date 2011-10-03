XUSESIG1 ;SF/RWF - More E-Sig functions. ;10/10/96  09:42
 ;;8.0;KERNEL;**14,55**;Jul 10, 1995
 W !,"NO ENTRY FROM THE TOP." Q
 ;
ESBLOCK(IEN) ;EF. Return the E-SIG block data.
 N X S:'$D(IEN) IEN=DUZ
 S X=$G(^VA(200,IEN,20)) Q:$P(X,U,2)="" ""
 Q $P(X,U,2)_U_$P($G(^VA(200,IEN,3.1)),U,6)_U_$P(X,U,3)_U_$$NOW^XLFDT()
 ;
CHKSUM(ROOT,FLAG) ;EF. Retuern a CHECKSUM of a sub-tree.
 ;ROOT is a $NA value, FLAG un-used at this time.
 N SUM,IX,IX2,XU1,Y
 Q:$D(@ROOT)=0 0
A ;Type A
 S SUM=0,IX=0,XU1=ROOT,ROOT=$E(ROOT,1,$L(ROOT)-1)
 F  S Y=$G(@XU1) D  S XU1=$Q(@XU1) Q:XU1'[ROOT
 . F IX2=1:1:$L(Y) S IX=IX+1,SUM=($A(Y,IX2)-31*IX)+SUM
 Q SUM_"A"
EN(CHKSUM,ESBLK) ;EF. Return encoded ESBLOCK.
 ;Get the ESBLOCK first.
 N X,X1,X2 I '$D(ESBLK) S ESBLK=$$ESBLOCK()
 S X=ESBLK,X1=+CHKSUM,X2=1 D EN^XUSHSHP
 Q X
DE(CHKSUM,ESBLK) ;EF. Return decoded ESBLOCK
 N X,X1,X2
 S X=ESBLK,X1=+CHKSUM,X2=1 D DE^XUSHSHP
 Q X
CMP(CHKSUM,ROOT) ;EF. Compair. Return 1 for match, 0 no match.
 ;ROOT is a $NA value.
 N FLAG,NEWSUM
 S FLAG=$E(CHKSUM,$L(CHKSUM)),NEWSUM=$$CHKSUM(ROOT,FLAG)
 Q NEWSUM=CHKSUM

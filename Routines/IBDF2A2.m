IBDF2A2 ;ALB/CJM - ENCOUNTER FORM (IBDF2A continued);NOV 16,1992
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**38**;APR 24, 1997
 ;
WCMP ;write the compiled version
 N SUB,ND,WIDTH,STRING,LINES,ROW,FNAME,TYPE,UNIT,TYPENODE,ND2,SLCTN
 S SUB=0 F  S SUB=$O(^IBE(357.1,IBBLK,"S",SUB)) Q:'SUB  S ND=$G(^IBE(357.1,IBBLK,"S",SUB,0)) D DRWSTR^IBDFU(+$P(ND,"^"),+$P(ND,"^",2),$P(ND,"^",5,200),$P(ND,"^",3),$P(ND,"^",4))
 S SUB=0 F  S SUB=$O(^IBE(357.1,IBBLK,"V",SUB)) Q:'SUB  S ND=$G(^IBE(357.1,IBBLK,"V",SUB,0)) D DRWVLINE^IBDFU(+$P(ND,"^"),+$P(ND,"^",2),+$P(ND,"^",3),$P(ND,"^",4))
 ;
 ;bubbles
 S SUB=0 F  S SUB=$O(^IBE(357.1,IBBLK,"B",SUB)) Q:'SUB  D
 .S ND=$G(^IBE(357.1,IBBLK,"B",SUB,0))
 .S ND2=$G(^IBE(357.1,IBBLK,"B",SUB,2))
 .S SLCTN=$P($G(ND),"^",14)
 .S SUBHDR=$P($G(^IBE(357.1,IBBLK,"B",SUB,1)),"^") D
 ..D DRWBBL^IBDFM1(+$P(ND,"^"),+$P(ND,"^",2),+$P(ND,"^",3),$P(ND,"^",4),$P(ND,"^",5),$P(ND,"^",6),$P(ND,"^",7),$P(ND,"^",8),$P(ND,"^",9),$P(ND,"^",10),$P(ND,"^",11),$P(ND,"^",12),SUBHDR,$P(ND,"^",13),$G(ND2),$G(SLCTN))
 ;
 ;handprint
 S SUB=0 F  S SUB=$O(^IBE(357.1,IBBLK,"H",SUB)) Q:'SUB  S ND=$G(^IBE(357.1,IBBLK,"H",SUB,0)) D
 .D DRWHAND^IBDFM1(+ND,+$P(ND,"^",2),+$P(ND,"^",3),$P(ND,"^",4),$P(ND,"^",6),$P(ND,"^",7),$P(ND,"^",8),$P(ND,"^",9),$P(ND,"^",10),$P(ND,"^",12),$P(ND,"^",14),$P(ND,"^",15),$P(ND,"^",17))
 Q
 ;
SAVE(ARRAY,VAR) ;saves one array to the string=VAR, pass by reference
 N SUB,I
 S I=1,SUB="" F  S SUB=$O(ARRAY(SUB)) Q:SUB=""  S $P(VAR,"^",I)=ARRAY(SUB),I=I+1
 Q
RESTORE(ARRAY,VAR) ;restores the array from the string=VAR, pass by reference
 N SUB,I
 S I=1,SUB="" F  S SUB=$O(ARRAY(SUB)) Q:SUB=""  S ARRAY(SUB)=$P(VAR,"^",I),I=I+1
 Q

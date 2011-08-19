PRCPDAPE ;WISC/RFJ-drug accountability/prime vendor (errors)        ;15 Mar 94
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
NONTYPE ;  check for order of buyer, seller, ship
 I NTYPE="" D ERROR("THE IDENTIFIER SEGMENT 'N1' NEEDS TO COME BEFORE THE '"_$P(DATA,"^")_"' SEGMENT")
 Q
 ;
 ;
ERROR(MSG)         ;  show error
 W !,DATA
 K X S X(1)=MSG D DISPLAY^PRCPUX2(1,79,.X)
 S PRCPFLAG=1
 Q
 ;
 ;
ORDER ;  check order of code sheets
 ;  isa   <--------------+
 ;    gs    <----------+ |
 ;      st    <------+ | |
 ;      | big        | | |
 ;      | it1   <--+ | | |
 ;      | ...      | | | |--repeats
 ;      | it1   <--+ | | |
 ;      | ctt        | | |
 ;      se    <------+ | |
 ;    ge    <----------+ |
 ;  iea   <--------------+
 S NEXTSEG=$P(DATA,"^")
 I LASTSEG="",NEXTSEG'="ISA" D ORDERROR("",NEXTSEG,"ISA") Q
 I LASTSEG="GE",NEXTSEG="GS" Q
 I LASTSEG="GE",NEXTSEG'="IEA" D ORDERROR("GE",NEXTSEG,"IEA") Q
 ;
 I LASTSEG="ISA",NEXTSEG'="GS" D ORDERROR("ISA",NEXTSEG,"GS") Q
 I LASTSEG="SE",NEXTSEG="ST" Q
 I LASTSEG="SE",NEXTSEG'="GE" D ORDERROR("SE",NEXTSEG,"GE") Q
 ;
 I LASTSEG="GS",NEXTSEG'="ST" D ORDERROR("GS",NEXTSEG,"ST") Q
 I LASTSEG="CTT",NEXTSEG'="SE" D ORDERROR("CTT",NEXTSEG,"SE") Q
 ;
 I LASTSEG="ST",NEXTSEG'="BIG" D ORDERROR("ST",NEXTSEG,"BIG") Q
 ;
 I LASTSEG="IT1",NEXTSEG="IT1" Q
 I LASTSEG="IT1",NEXTSEG'="CTT" D ORDERROR("IT1",NEXTSEG,"CTT") Q
 Q
 ;
 ;
ORDERROR(LAST,NEW,EXPECT) ;  segments out of order
 ;  isa segment should be first
 I LAST="" D ERROR("SEGMENTS OUT OF ORDER, THE STARTING SEGMENT SHOULD BE 'ISA', NOT '"_NEW_"'") Q
 ;  segments other than isa
 D ERROR("SEGMENTS OUT OF ORDER, THE SEGMENT FOLLOWING '"_LAST_"' SHOULD BE '"_EXPECT_"', NOT '"_NEW_"'") Q
 Q

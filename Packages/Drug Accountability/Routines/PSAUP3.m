PSAUP3 ;BIR/JMB-Upload and Process Prime Vendor Invoice Data - CONT'D ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;; 10/24/97
 ;This routine checks for correct X12 formating.
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
 S PSANEXT=$P(PSADATA,"^")
 ;
 I PSALAST="GE",PSANEXT="GS" Q
 I PSALAST="GE",PSANEXT'="IEA" D ORDERROR("GE",PSANEXT,"IEA") Q
 ;
 I PSALAST="ISA",PSANEXT'="GS" D ORDERROR("ISA",PSANEXT,"GS") Q
 ;
 I PSALAST="SE",PSANEXT="ST" Q
 I PSALAST="SE",PSANEXT'="GE" D ORDERROR("SE",PSANEXT,"GE") Q
 ;
 I PSALAST="GS",PSANEXT'="ST" D ORDERROR("GS",PSANEXT,"ST") Q
 ;
 I PSALAST="CTT",PSANEXT'="SE" D ORDERROR("CTT",PSANEXT,"SE") Q
 ;
 I PSALAST="ST",PSANEXT'="BIG" D ORDERROR("ST",PSANEXT,"BIG") Q
 ;
 I PSALAST="IT1",PSANEXT="IT1" Q
 I PSALAST="IT1",PSANEXT'="CTT"&(PSANEXT'="TDS") D ORDERROR("IT1",PSANEXT,"CTT") Q
 Q
 ;
ORDERROR(PSALAST,PSANEW,PSAEXPEC) ;Segments out of order
 ;ISA segment should be first
 I PSALAST="" S PSASEG="ORDER1" D MSG^PSAUTL2 Q
 ;Segments other than ISA
 S PSASEG="ORDER2" D MSG^PSAUTL2
 Q

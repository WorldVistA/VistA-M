PSODSRC ;BHAM ISC/XAK,MJK - help text for source of supply field in drug file ; 08/20/92 9:04
 ;;7.0;OUTPATIENT PHARMACY;;DEC 1997
P W @IOF,!,"A two or three position code identifies the source of supply and whether",!,"the drug is stocked by the station supply division.  The first"
 W !,"position of the code identifies source of supply.  The codes are:",!
 F I=0:1:10 W !?10,I,?20,$E($T(D+I+1),4,99)
 W !,"The second position of the code indicates whether the item is",!,"or is not available from supply warehouse stock.  The codes are:",!
 W !?10,"P",?20,"POSTED STOCK",!?10,"U",?20,"UNPOSTED",!?10,"M",?20,"BULK COMPOUND"
 W !,"*  USE CODE 0 ONLY WITH SECOND POSITION M."
D ;;DESCRIPTION MEANINGS
 ;;BULK COMPOUND ITEMS *
 ;;VA SERVICING SUPPLY DEPOT
 ;;OPEN MARKET
 ;;GSA STORES DEPOT
 ;;VA DECENTRALIZED CONTRACTS
 ;;FEDERAL PRISON INDUSTRIES, INC.
 ;;FEDERAL SUPPLY SCHEDULES
 ;;VA SUPPLY DEPOT, HINES
 ;;VA SUPPLY DEPOT, SOMERVILLE
 ;;APPROPRIATE MARKETING DIVISION
 ;;VA SUPPLY DEPOT, BELL

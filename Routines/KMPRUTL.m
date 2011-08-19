KMPRUTL ;OAK/KAK/RAK - Resource Usage Monitor Utilities ;11/19/04  10:32
 ;;2.0;CAPACITY MANAGEMENT - RUM;**1**;May 28, 2003
 ;
GRPHMSG ;-- graph message.
 N TXT
 S TXT(1)="This option displays data in a graphical format.  Please make"
 S TXT(2)="note that this output is intended for comparison/trends only,"
 S TXT(3)="and should not be used for detailed analysis."
 S TXT(1,"F")="!?9",TXT(2,"F")="!?9",TXT(3,"F")="!?9"
 D EN^DDIOL(.TXT)
 Q
 ;
ID(KMPRIEN) ;-- display - called from ^DD(8971.1,0,"ID","W")
 ;-----------------------------------------------------------------------
 ; KMPRIEN... Ien for file #8971.1 (RESOURCE USAGE MONITOR).
 ;-----------------------------------------------------------------------
 Q:'$G(KMPRIEN)
 Q:'$D(^KMPR(8971.1,+KMPRIEN,0))
 N DATA,TXT
 S DATA=$G(^KMPR(8971.1,+KMPRIEN,0))
 ; sent to cm national database.
 S TXT(1)=$S($P(DATA,U,2):"sent",1:"not sent")
 S TXT(1)=TXT(1)_$J(" ",10-$L(TXT(1)))
 ; node.
 S TXT(1)=TXT(1)_$P(DATA,U,3)
 S TXT(1)=TXT(1)_$J(" ",22-$L(TXT(1)))
 ; option.
 I $P(DATA,U,4)]"" S TXT(1)=TXT(1)_"option: "_$P(DATA,U,4)
 ; rpc.
 E  I $P(DATA,U,7)]"" S TXT(1)=TXT(1)_"   rpc: "_$P(DATA,U,7)
 S TXT(1,"F")="?16"
 ; if protocol
 I $P(DATA,U,5)'="" D 
 .S TXT(2)="protocol: "_$E($P(DATA,U,5),1,40) ;_" (protocol)"
 .S TXT(2,"F")="!?"_$S($G(DDSDIW):40,1:42)
 ; display TXT() array.
 D EN^DDIOL(.TXT)
 Q
 ;
NODEARRY(KMPRARRY) ;-- put nodes into array.
 ;-----------------------------------------------------------------------
 ; KMPRARRY.. Array to contain nodes in format:
 ;            KMPRARRY(NODENAME)=""
 ;-----------------------------------------------------------------------
 ;
 K @KMPRARRY
 ;
 N NODE S NODE=""
 F  S NODE=$O(^KMPR(8971.1,"ANODE",NODE)) Q:NODE=""  S @KMPRARRY@(NODE)=""
 Q
 ;
RUMDATES(KMPRDATE) ;-- get RUM date ranges from file 8971.1
 ;---------------------------------------------------------------------
 ; KMPRDATE... Return value (access by reference) in format:
 ;             StartDate^EndDate^ExtStartDate^ExtEndDate
 ;             2981101^2981104^Nov 1, 1998^Nov 4, 1998
 ;---------------------------------------------------------------------
 ;
 S KMPRDATE=""
 N END,START
 ; determine start date from file 8971.1
 S START=$O(^KMPR(8971.1,"B",0))
 ; determine end date from file 8971.1
 S END=$O(^KMPR(8971.1,"B","A"),-1)
 D DATERNG^KMPRUTL1(.KMPRDATE,START,END)
 ;
 Q
 ;
VERSION() ;-- extrinsic - return current version
 ;
 Q $P($T(+2^KMPRUTL),";",3)_"^"_$P($T(+2^KMPRUTL),";",5)
 ;
ELEARRY(KMPRARRY) ;-- set elements data into KMPRARRY.
 ;-----------------------------------------------------------------------
 ; KMPRARRY... Array to contain elements data.
 ;             Format: ElementName^DataPiece
 ;                     KMPRARRY(1)=CPU Time^1
 ;                     KMPRARRY(2)=Elapsed Time^7
 ;                     KMPRARRY(...)=...
 ;-----------------------------------------------------------------------
 ;
 Q:$G(KMPRARRY)=""
 ;
 N DATA,I
 F I=1:1 Q:$P($T(ELEMENTS+I),";",3)=""  D 
 .S DATA=$T(ELEMENTS+I)
 .S @KMPRARRY@(I)=$P(DATA,";",3)_"^"_$P(DATA,";",4)
 Q
 ;
ELEMENT(KMPUVAR) ;-- select RUM data element.
 ; Output Variable:
 ;   KMPUVAR    = Number of Data Piece
 ;              = '^' if DTOUT or DUOUT
 ;   KMPUVAR(0) = Set of Code's Verbiage
 ;
 N DIR,DTOUT,DUOUT,I,X,Y
 S KMPUVAR=""
 S DIR(0)="SXO^"
 F I=1:1 Q:$P($T(ELEMENTS+I),";",3)=""  D 
 .S DIR(0)=DIR(0)_I_":"_$P($T(ELEMENTS+I),";",3)_";"
 S DIR("A")="Enter Key Data Element for Searching RUM Data"
 D ^DIR I $D(DTOUT)!$D(DUOUT)!(Y="") S KMPUVAR="^",KMPUVAR(0)="" Q
 S KMPUVAR=$TR(Y,"12345678^","17562348^"),KMPUVAR(0)=Y(0)
 Q
 ;
ELEMENTS ;-- ;;Element Name;data piece in file 8971.1
 ;;CPU Time;1
 ;;Elapsed Time;7
 ;;M Commands;5
 ;;GLO References;6
 ;;DIO References;2
 ;;BIO References;3
 ;;Page Faults;4
 ;;Occurrences;8
 ;;
PTCHINFO ; -- patch information: routine name ^ current version ^ current patch(es)
 ;;KMPRBD01^2.0^**1**
 ;;KMPRBD02^2.0^
 ;;KMPRBD03^2.0^
 ;;KMPRP1^2.0^**1**
 ;;KMPRP2^2.0^**1**
 ;;KMPRPG01^2.0^**1**
 ;;KMPRPG02^2.0^**1**
 ;;KMPRPN03^2.0^**1**
 ;;KMPRPOST^2.0^**1**
 ;;KMPRSS^2.0^**1**
 ;;KMPRSSA^2.0^**1**
 ;;KMPRSSB^2.0^**1**
 ;;KMPRUTL^2.0^**1**
 ;;KMPRUTL1^2.0^**1**
 ;;KMPRUTL2^2.0^
 ;;KMPRUTL3^2.0^
 ;;%ZOSVKR^8.0^**90,94,107,122,143,186**
 ;;

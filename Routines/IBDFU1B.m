IBDFU1B ;ALB/CJM - ENCOUNTER FORM ;NOV 16,1992
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;utilities
BLKDESCR(IBBLK) ;parses the block record pointed to by IBBLK and puts the
 ;descripition in IBBLK array - should be called by reference
 ;returns 1 if block description is too incomplete to print block
 Q:'$G(IBBLK) 1
 N NODE0
 S NODE0=$G(^IBE(357.1,IBBLK,0))
 S IBBLK("NAME")=$P(NODE0,"^",1)
 S IBBLK("Y")=$P(NODE0,"^",4)
 S IBBLK("X")=$P(NODE0,"^",5)
 S IBBLK("W")=$P(NODE0,"^",6)
 S IBBLK("H")=$P(NODE0,"^",7)
 S IBBLK("BOX")=$P(NODE0,"^",10)
 S IBBLK("HDR")=$P(NODE0,"^",11)
 S IBBLK("HDISP")=$P(NODE0,"^",12)
 S IBBLK("S")=$P(NODE0,"^",3)
 S IBBLK("PAGE")=1+(IBBLK("Y")\IBFORM("PAGE_HT"))
 Q:NODE0="" 1
 Q 0
 ;
RTNDSCR(RTN) ;RTN should be a pointer to the Package Interface file
 ;RTN should be passed by reference
 ;
 N NODE
 S NODE="",RTN=+$G(RTN)
 S:RTN NODE=$G(^IBE(357.6,RTN,0))
 S RTN("ACTION")=$P(NODE,"^",6)
 ;
 ;for input interfaces (mapping)
 I RTN("ACTION")=1 D  Q
 .S RTN("AVAIL")=$P(NODE,"^",9)
 .Q
 ;
 ;for output interfaces
 I RTN("ACTION")=2 D  Q
 .N NODFN
 .S NODFN=$P(NODE,"^",15)
 .S RTN("NAME")=$P(NODE,"^",1)
 .S RTN("RTN")=$P(NODE,"^",2,3)
 .S RTN("CHANGES")=$P(NODE,"^",5)
 .S RTN("DATATYPE")=$P(NODE,"^",7)
 .S RTN("FULL")=$P(NODE,"^",8)
 .S RTN("AVAIL")=$P(NODE,"^",9)
 .S RTN("ENTRY")=$S(RTN:$G(^IBE(357.6,RTN,4)),1:"")
 .S RTN("EXIT")=$S(RTN:$G(^IBE(357.6,RTN,5)),1:"")
 .;determine where the interface should put the data
 .I NODFN S RTN("DATA_LOCATION")="^TMP(""IB"",$J,""INTERFACES"","""_RTN("NAME")_""")"
 .I 'NODFN S RTN("DATA_LOCATION")="^TMP(""IB"",$J,""INTERFACES"",+$G(DFN),"""_RTN("NAME")_""")"
 ;
 ;for selection interfaces
 I RTN("ACTION")=3 D  Q
 .S RTN("NAME")=$P(NODE,"^",1)
 .S RTN("RTN")=$P(NODE,"^",2,3)
 .S RTN("FULL")=$P(NODE,"^",8)
 .S RTN("AVAIL")=$P(NODE,"^",9)
 .S RTN("DYNAMIC")=$P(NODE,"^",14)
 .S RTN("ENTRY")=$S(RTN:$G(^IBE(357.6,RTN,4)),1:"")
 .S RTN("EXIT")=$S(RTN:$G(^IBE(357.6,RTN,5)),1:"")
 .S RTN("DATA_LOCATION")="^TMP(""IB"",$J,""INTERFACES"","""_RTN("NAME")_""")"
 .S RTN("NAME",1)=$$DATANAME(RTN,1),RTN("WIDTH",1)=$$DATANODE(RTN,1)
 .S RTN("INPUT_RTN")=$P(NODE,"^",13)
 ;
 ;for reports
 I RTN("ACTION")=4 D  Q
 .S RTN("RTN")=$P(NODE,"^",2,3)
 .S RTN("AVAIL")=$P(NODE,"^",9)
 .S RTN("HSMRY?")=$P(NODE,"^",10)
 .S RTN("HSMRY")=$P(NODE,"^",11)
 .S RTN("ENTRY")=$S(RTN:$G(^IBE(357.6,RTN,4)),1:"")
 .S RTN("EXIT")=$S(RTN:$G(^IBE(357.6,RTN,5)),1:"")
 ;
 ;in case the action type is not defined
 S RTN("NAME")=$P(NODE,"^",1)
 S RTN("RTN")=$P(NODE,"^",2,3)
 S RTN("CHANGES")=$P(NODE,"^",5)
 S RTN("DATATYPE")=$P(NODE,"^",7)
 S RTN("FULL")=$P(NODE,"^",8)
 S RTN("AVAIL")=$P(NODE,"^",9)
 S RTN("DYNAMIC")=$P(NODE,"^",14)
 S RTN("ENTRY")=$S(RTN:$G(^IBE(357.6,RTN,4)),1:"")
 S RTN("EXIT")=$S(RTN:$G(^IBE(357.6,RTN,5)),1:"")
 ;
 ;I FULL,RTN S IEN=0 F  S IEN=$O(^IBE(357.6,RTN,15,IEN)) Q:'IEN  S NODE=$G(^IBE(357.6,RTN,15,IEN,0)) D
 ;.S I=$P(NODE,"^",3)
 ;.Q:'I
 ;.S RTN("NODE",I)=$P(NODE,"^",4),RTN("NAME",I)=$P(NODE,"^")
 Q
 ;
WARNING(OBJECT) ; displays a warning
 S:'$D(OBJECT) OBJECT="object"
 W !,"WARNING! The "_OBJECT_" is partially outside the block."
 D PAUSE^IBDFU5
 Q
 ; ** The following routines assume BLKDESCR has been called and the IBBLK array is defined
 ;
MINX() ;the smallest X a block element can begin at
 Q $S((IBBLK("BOX")=1):1,1:0)
 ;
MAXX() ;the largest X a block element can begin at
 Q (IBBLK("W")-(1+$S(IBBLK("BOX")=1:1,1:0)))
 ;
MINY() ;the smallest Y a block element can begin at
 Q $S(IBBLK("BOX")=1:1,1:0)
 ;
MAXY() ;the largest Y a block element can begin at
 Q (IBBLK("H")-(1+$S((IBBLK("BOX")=1):1,1:0)))
 ;
DORTN(IBRTN) ;calls the rtn specified by the pkg interface if ok
 ;IBRTN is an array containing data from the package interface in format returned by RTNDESCR and MUST be passed by reference
 ;returns 0 if not successful, 1 otherwise
 N QUIT,VARIABLE,VARIEN,IBARY
 S QUIT=0
 ;
 ;set IBARY to node where the interface should return the data
 I (IBRTN("ACTION")=2)!(IBRTN("ACTION")=3) D
 .S IBARY=IBRTN("DATA_LOCATION")
 .K @IBARY
 ;
 Q:IBRTN("AVAIL")'=1 0
 ;
 ;verify that required variables exist
 S VARIEN=0 F  S VARIEN=$O(^IBE(357.6,IBRTN,7,VARIEN)) Q:'VARIEN  S VARIABLE=$P($G(^IBE(357.6,IBRTN,7,VARIEN,0)),"^") I '$D(@VARIABLE) S QUIT=1 Q
 Q:QUIT 0
 ;
 ;new protected variables
 S VARIEN=0 F  S VARIEN=$O(^IBE(357.6,IBRTN,6,VARIEN)) Q:'VARIEN  S VARIABLE=$P($G(^IBE(357.6,IBRTN,6,VARIEN,0)),"^")  N @VARIABLE
 ;
 ;make sure the entry point is known
 Q:$G(IBRTN("RTN"))="" 0
 ;
 ;make sure the entry point exists
 Q:$P(IBRTN("RTN"),"^",2)="" 0
 I $P(IBRTN("RTN"),"^")'="" Q:'$L($T(@$P(IBRTN("RTN"),"^")^@$P($P(IBRTN("RTN"),"^",2),"("))) 0
 I $P(IBRTN("RTN"),"^")="" Q:'$L($T(^@$P($P(IBRTN("RTN"),"^",2),"("))) 0
 ;
 ;call the interface routine,xecute the entry and exit actions
 X IBRTN("ENTRY")
 D @IBRTN("RTN")
 X IBRTN("EXIT")
 Q 1
 ;
DATANAME(RTN,PIECE) ;returns the name of the data for field=piece
 Q:'RTN!'PIECE ""
 I PIECE=1 Q $P($G(^IBE(357.6,RTN,2)),"^")
 N NODE,IEN
 S IEN=$O(^IBE(357.6,RTN,15,"C",PIECE,0))
 Q:'IEN ""
 Q $P($G(^IBE(357.6,RTN,15,IEN,0)),"^")
 ;
DATANODE(RTN,PIECE) ;returns the node that the field=piece is on
 Q:'RTN!'PIECE ""
 I PIECE=1 Q ""
 S IEN=$O(^IBE(357.6,RTN,15,"C",PIECE,0))
 Q:'IEN ""
 Q $P($G(^IBE(357.6,RTN,15,IEN,0)),"^",4)
 ;
DATATYPE(TYPE) ;returns the description of the datatype=TYPE
 ;TYPE must be passed by reference
 ;
 N NODE
 S NODE=""
 I $G(TYPE) S NODE=$G(^IBE(359.1,TYPE,0))
 S TYPE("SPACE")=$P(NODE,"^",6)
 S TYPE("MAX_INPUT")=$P(NODE,"^",2)
 S TYPE("FORMAT")=$P(NODE,"^",5)
 Q

IBDFU1A ;ALB/CJM - ENCOUNTER FORM (read data field description);NOV 16,1992
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;utilities
FLDDESCR(IBFLD) ;IBFLD should be a pointer to the IB DATA FIELD file
 ;parses the 0 NODE and returns the fields
 ;returns 1 if the field description is not found
 N NODE
 Q:'$G(IBFLD) 0
 S:$G(IBFLD) NODE=$G(^IBE(357.5,IBFLD,0))
 Q:NODE="" 0
 S FLDNAME=$P(NODE,"^",1)
 S BLK=$P(NODE,"^",2)
 S RTN=$P(NODE,"^",3)
 S LASTITEM=$P(NODE,"^",4)
 S ITEM=+$P(NODE,"^",5)
 S LABEL=$P(NODE,"^",6)
 S DISPLAY=$P(NODE,"^",7)
 S XIO=+$P(NODE,"^",10)
 S YIO=+$P(NODE,"^",11)
 S HIO=+$P(NODE,"^",12)
 S SPACING=$P(NODE,"^",13)
 S WIO=+$P(NODE,"^",14)
 Q 1
SFLDDSCR(IBFLD,LAST) ;gets the next subfield - LAST is the last subfield processed, IBFLD  is the field
 ;outputs - LABEL,XIO,YIO,WIO,XLAB,YLAB,PIECE,LENGTH,LAST
 ;returns 0 if no more subfields, LAST otherwise
 ;
 N NODE
 F  S LAST=$O(^IBE(357.5,IBFLD,2,LAST)) Q:'LAST  S NODE=$G(^IBE(357.5,IBFLD,2,LAST,0)) I NODE'="" D  Q
 .S LABEL=$P(NODE,"^",1),DISPLAY=$P(NODE,"^",3),XLAB=$P(NODE,"^",4),YLAB=$P(NODE,"^",5),YIO=$P(NODE,"^",6),XIO=$P(NODE,"^",7),WIO=$P(NODE,"^",8),PIECE=$P(NODE,"^",9)
 Q LAST

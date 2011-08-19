IBDF18A1 ;ALB/CJM/AAS - ENCOUNTER FORM - utilities for PCE ;12-AUG-94
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**34,38**;APR 24, 1997
 ;
COPYLIST(LIST,ARY,COUNT) ;
 ; -- copies the entries from LIST to @ARY, starting subscript at COUNT+1
 ;
 N SLCTN,NODE,NODE1,NODE2,TSUBCOL,GROUP,ORDER,HDR,PRNT
 ;
 D SUBCOL(LIST,.TSUBCOL) ;find the subcolumn containing the text
 ;
 S PRNT=""
 F  S PRNT=$O(^IBE(357.4,"APO",LIST,PRNT)) Q:PRNT=""  D
 . S GROUP=""
 . F  S GROUP=$O(^IBE(357.4,"APO",LIST,PRNT,GROUP)) Q:GROUP=""  D
 .. S HDR=$P($G(^IBE(357.4,GROUP,0)),"^")
 .. I HDR="BLANK" S HDR=""
 .. S COUNT=COUNT+1,@ARY@(COUNT)="^"_HDR
 .. S ORDER=""
 .. F  S ORDER=$O(^IBE(357.3,"APO",LIST,GROUP,ORDER)) Q:ORDER=""  D
 ... S SLCTN=0
 ... F  S SLCTN=$O(^IBE(357.3,"APO",LIST,GROUP,ORDER,SLCTN)) Q:'SLCTN  D
 .... S NODE=$G(^IBE(357.3,SLCTN,0))
 .... S NODE2=$G(^IBE(357.3,SLCTN,2))
 .... S NODE1=$G(^IBE(357.3,SLCTN,1,+$O(^IBE(357.3,SLCTN,1,"B",+TSUBCOL,0)),0))
 .... ; -- return placeholders as headers when use as subheader
 .... ;    is yes and quit
 .... I $P(NODE,"^",2),$P(NODE,"^",7)=1 D  Q
 ..... S COUNT=COUNT+1,@ARY@(COUNT)="^"_$P(NODE,"^",6)
 .... ;
 .... I $P(NODE1,"^")=TSUBCOL,$L($P(NODE1,"^",2)) S COUNT=COUNT+1,@ARY@(COUNT)=$P(NODE,"^")_"^"_$P(NODE1,"^",2)_"^^^^"_$P(NODE2,"^")_"^"_$P(NODE2,"^",3)_"^"_$P(NODE2,"^",4)_"^"_$P(NODE2,"^",2)
 .... D MODLIST
 Q
 ;
SUBCOL(LIST,TSUBCOL) ; -- finds the subcolumn containing the text
 ; -- TSUBCOL passed by reference - used to return the subcolumn
 ;    LIST is the selection list to search
 ;
 ; -- refering to the data returned by the package interface,
 ;    piece 2 is usually the description
 ;
 N PI,SC
 S TSUBCOL="",SC=0
 S PI=$P($G(^IBE(357.6,+$P($G(^IBE(357.2,+LIST,0)),"^",11),0)),"^")
 ;
 F  S SC=$O(^IBE(357.2,LIST,2,SC)) Q:'SC  D
 .Q:$P($G(^IBE(357.2,LIST,2,SC,0)),"^",4)=2  ;is a marking area
 .I $P($G(^IBE(357.2,LIST,2,SC,0)),"^",5)=2 S TSUBCOL=$P(^(0),"^") Q
 .I TSUBCOL="",$P($G(^IBE(357.2,LIST,2,SC,0)),"^",5)>2 S TSUBCOL=$P(^(0),"^") Q  ; -- see if other than data piece two is text subcolumn
 .;
 .; -- utility for selecting blanks is exception
 .I TSUBCOL="",PI="IBDF UTILITY FOR SELECTING BLANKS",$P($G(^IBE(357.2,LIST,2,SC,0)),"^",5)=1 S TSUBCOL=$P(^(0),"^") Q
 Q
 ;
F2(ARY) ; -- filter cpt code array to find only codes beginning with 992 and asssicated headers
 ; -- Copy filtered array to from ibdtmp( to @ary@(
 ;
 N NODE,IBQUIT,COUNT
 S (COUNT,IBQUIT)=0
 ;
 ;I INTRFACE'="DG SELECT CPT PROCEDURE CODES" S @ARY=IBDTMP K IBDTMP
 ;
 S NODE="" F  S NODE=$O(IBDTMP(NODE),-1) Q:NODE=""  I $E(IBDTMP(NODE),1,3)=992 D  ;Q:IBQUIT  ;comment out the q:ibquit if want from more than 1 list
 .;
 .S @ARY@(NODE)=IBDTMP(NODE),COUNT=COUNT+1 ;this is bottom of list
 .;
 .; -- process from bottom of list to header
 .F  S NODE=$O(IBDTMP(NODE),-1) Q:NODE=""  D  Q:IBQUIT
 ..S IBQUIT=0
 ..I $E(IBDTMP(NODE),1,3)=992 S @ARY@(NODE)=IBDTMP(NODE),COUNT=COUNT+1
 ..I $P(IBDTMP(NODE),"^",1)="" S @ARY@(NODE)=IBDTMP(NODE),IBQUIT=1,COUNT=COUNT+1
 I COUNT S @ARY@(0)=COUNT
 Q
 ;
URH ; -- UnReferenced Headers (removal)
 ;    if a header doesn't have any data under it, then remove the header
 N X,HDR
 S X=0 F  S X=$O(@ARY@(X)) Q:'X  D
 .I '$D(HDR),$P(@ARY@(X),"^",1)="" S HDR=X Q  ;find a header
 .I $P(@ARY@(X),"^",1)="" K HDR Q  ; is item under header
 .; -- patch 34 check if piece one below = null instead of positive
 .I $D(HDR),$P(@ARY@(X),"^",1)="" K @ARY@(HDR) S COUNT=COUNT-1,HDR=X ;hdr doesn't have any items, kill hdr node and reset header to next header
 .;I $D(HDR),$P(@ARY@(X),"^",1) K @ARY@(HDR) S COUNT=COUNT-1,HDR=X ;hdr doesn't have any items, kill hdr node and reset header to next header
 I $D(HDR) S X=$O(@ARY@(""),-1) I $P(@ARY@(X),"^",1)="" K @ARY@(X) S COUNT=COUNT-1,HDR=X ;last item in list is a header
 Q
MODLIST ; return all CPT Modifiers if defined
 ;
 Q:$G(MODIFIER)'=1
 N MCOUNT,MOD
 Q:'$D(^IBE(357.3,SLCTN,3))
 S MCOUNT=0
 F MOD=0:0 S MOD=$O(^IBE(357.3,SLCTN,3,MOD)) Q:'MOD  D
 . S MCOUNT=MCOUNT+1
 . S @ARY@(COUNT,"MODIFIER",MCOUNT)=$G(^IBE(357.3,SLCTN,3,MOD,0))
 S:MCOUNT>0 @ARY@(COUNT,"MODIFIER",0)=MCOUNT
 Q

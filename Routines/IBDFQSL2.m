IBDFQSL2 ;ALB/CJM/AAS/MAF - ENCOUNTER FORM - Quick selection edit (cont.);12-Jun-95
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**34**;APR 24, 1997
 ;
GETLST(FORM,BLOCK,LIST,INTRFACE,ARY,FILTER,COUNT) ; -- returns any specified selection list for a clinic
 ; -- input    FORM = ien of entry in 357
 ;            BLOCK = ien of entry in 357.1
 ;             LIST = ien of entry in 357.2
 ;         INTRFACE = name of selection list in package interface file
 ;              ARY = name of array to return list in
 ;           FILTER = predefined filters (optional, default = 1)
 ;                                       1 = must be selection list
 ;                                       2 = only visit cpts on list
 ;
 ; -- output  The format of the returned array is as follows
 ;         @ARY@(0) = count of array element (0 of nothing found)
 ;         @ARY@(1) = ^group header
 ;         @ARY@(2) = problem ien or cpt or icd code^user defined text
 ;         @ARY@(3) = problem ien or cpt or icd code^used defined text
 ;         @ARY@(k) = ^next group header
 ;       @ARY@(k+1) = problem ien or cpt or icd code^user define text
 ;
 Q:'FORM!('BLOCK)!('LIST)!('INTRFACE)
 N OLDARY,IBDTMP
 S COUNT=$G(COUNT,0)
 I $G(FILTER)<1 S FILTER=1 ;default value=1
 I FILTER>1 S OLDARY=ARY,ARY="IBDTMP"
 S @ARY@(0)=+$G(@ARY@(0))
 D COPYLIST(LIST,ARY,.COUNT)
 S @ARY@(0)=COUNT
 I FILTER=2 D F2^IBDF18A1(OLDARY)
 Q
 ;
COPYLIST(LIST,ARY,COUNT) ;copies the entries from LIST to @ARY, starting subscript at COUNT+1
 ;
 N SLCTN,SUBCOL,TEXT,IEN,NODE,TSUBCOL,NODE,GROUP,ORDER,HDR,GRPORDR
 ;
 D SUBCOL^IBDF18A1(LIST,.TSUBCOL) ;find the subcolumn containing the text
 ;
 S GRPORDR=""
 F  S GRPORDR=$O(^IBE(357.4,"APO",LIST,GRPORDR)) Q:GRPORDR=""  D
 .S GROUP=0
 .F  S GROUP=$O(^IBE(357.4,"APO",LIST,GRPORDR,GROUP)) Q:'GROUP  D
 ..S HDR=$P($G(^IBE(357.4,GROUP,0)),"^") ;I HDR="BLANK" S HDR=""  If don't want to print BLANK group
 ..S COUNT=COUNT+1,@ARY@(COUNT)="^"_HDR_"^^^"_GROUP_"^"_GRPORDR
 ..S ORDER=""
 ..F  S ORDER=$O(^IBE(357.3,"APO",LIST,GROUP,ORDER)) Q:ORDER=""  D
 ...S SLCTN=0
 ...F  S SLCTN=$O(^IBE(357.3,"APO",LIST,GROUP,ORDER,SLCTN)) Q:'SLCTN  D
 ....S NODE=$G(^IBE(357.3,SLCTN,0))
 ....S IEN=$P(NODE,"^")
 ....S SUBCOL=$O(^IBE(357.3,SLCTN,1,"B",+TSUBCOL,0))
 ....;
 ....I 'SUBCOL D  Q  ;placeholders
 .....S TEXT=$S($P(NODE,"^",6)?1E.E:$P(NODE,"^",6),1:"BLANK")
 .....S COUNT=COUNT+1
 .....S @ARY@(COUNT)=" "_"^"_TEXT_"^"_LIST_"^"_SLCTN_"^"_GROUP_"^"_ORDER Q
 ....;
 ....S NODE=$G(^IBE(357.3,SLCTN,1,SUBCOL,0))
 ....S:$P(NODE,"^")=TSUBCOL TEXT=$P(NODE,"^",2)
 ....;
 ....I $L(TEXT) S COUNT=COUNT+1,@ARY@(COUNT)=IEN_"^"_TEXT_"^"_LIST_"^"_SLCTN_"^"_GROUP_"^"_ORDER Q
 Q

IBDFN11 ;ALB/CMR - ENCOUNTER FORM - (entry points for reprint of dynamic data) ;5/21/93
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
REPRINT(IBPFID,LIST,ARY) ; -- returns dynamic lists previously printed on a form
 ; -- input    IBPFID = ien of forms tracking file
 ;             LIST = ien of selection list file
 ;             ARY = name of array to return list in
 ;
 ; -- output   The format of the returned array is as follows:
 ;            @ARY(0) = count of array element (0 if nothing found)
 ;            @ARY(1) = provider ien^provider
 ;         or @ARY(1) = problem ien^problem text^ICD code
 ;         or @ARY(1) = classification question
 ;
 Q:'IBPFID!('LIST)
 N FID,ITEM,IBDIEN,NODE,COUNT
 ; -- initialize counter
 S COUNT=0
 ; -- clean out storage area
 K @ARY
 ; -- get field ids associated with this list
 S FID="S"_LIST
 S XREF=$S($O(^IBD(357.96,IBPFID,"AD",FID))[LIST:"AD",$O(^IBD(357.96,IBPFID,"AC",FID))[LIST:"AC",1:"") Q:XREF']""
 S FID=$O(^IBD(357.96,IBPFID,XREF,FID)) Q:FID'[LIST  D
 .; -- get all items for the field id
 .S ITEM=0 F  S ITEM=$O(^IBD(357.96,IBPFID,XREF,FID,ITEM)) Q:'ITEM  D
 ..; -- get ien for dynamic data entry
 ..S IBDIEN=0 F  S IBDIEN=$O(^IBD(357.96,IBPFID,XREF,FID,ITEM,IBDIEN)) Q:'IBDIEN  S NODE=$S(XREF="AD":$G(^IBD(357.96,IBPFID,2,IBDIEN,0)),1:$G(^IBD(357.96,IBPFID,1,IBDIEN,0))) I NODE]"" D
 ...; -- set output array with dynamic data previously printed
 ...S COUNT=COUNT+1
 ...S @ARY@(COUNT)=$P(NODE,"^",4)_"^"_$P(NODE,"^",8)_"^"_$S(ARY["GMP SELECT PATIENT ACTIVE PROBLEMS":$P($G(^ICD9(+$G(^AUPNPROB(+$P(NODE,"^",4),0)),0)),"^"),1:"")
 S @ARY@(0)=COUNT
 Q

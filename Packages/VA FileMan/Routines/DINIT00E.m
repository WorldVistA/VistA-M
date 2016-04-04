DINIT00E ; SFISC/TKW-DIALOG & LANGUAGE FILE INITS ;29JAN2004
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1004**
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,3051,1,0)
 ;;=^^2^2^2931129^^^^
 ;;^UTILITY(U,$J,.84,3051,1,1,0)
 ;;=The block has no 0 node in the Block file or was not found in the "B"
 ;;^UTILITY(U,$J,.84,3051,1,2,0)
 ;;=index.
 ;;^UTILITY(U,$J,.84,3051,2,0)
 ;;=^^1^1^2931129^^^
 ;;^UTILITY(U,$J,.84,3051,2,1,0)
 ;;=Block |1| does not exist in the Block file.
 ;;^UTILITY(U,$J,.84,3051,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,3051,3,1,0)
 ;;=1^Block number or name
 ;;^UTILITY(U,$J,.84,3053,0)
 ;;=3053^1^y^5
 ;;^UTILITY(U,$J,.84,3053,1,0)
 ;;=^^4^4^2931129^
 ;;^UTILITY(U,$J,.84,3053,1,1,0)
 ;;=The specified block was not found on the page.  For example, it was not
 ;;^UTILITY(U,$J,.84,3053,1,2,0)
 ;;=found in the "AC" or "B" index in the block multiple of the page multiple
 ;;^UTILITY(U,$J,.84,3053,1,3,0)
 ;;=of the Form file, or the 0 node of the block in the block multiple is
 ;;^UTILITY(U,$J,.84,3053,1,4,0)
 ;;=missing.
 ;;^UTILITY(U,$J,.84,3053,2,0)
 ;;=^^1^1^2931129^^
 ;;^UTILITY(U,$J,.84,3053,2,1,0)
 ;;=Block |1| was not found on page |2|.
 ;;^UTILITY(U,$J,.84,3053,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,3053,3,1,0)
 ;;=1^Block order, name, or number
 ;;^UTILITY(U,$J,.84,3053,3,2,0)
 ;;=2^Page number and/or name
 ;;^UTILITY(U,$J,.84,3055,0)
 ;;=3055^1^y^5
 ;;^UTILITY(U,$J,.84,3055,1,0)
 ;;=^^1^1^2931129^^^
 ;;^UTILITY(U,$J,.84,3055,1,1,0)
 ;;=There are no blocks defined on the page.
 ;;^UTILITY(U,$J,.84,3055,2,0)
 ;;=^^1^1^2931129^^^
 ;;^UTILITY(U,$J,.84,3055,2,1,0)
 ;;=There are no blocks defined on page |1|.
 ;;^UTILITY(U,$J,.84,3055,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,3055,3,1,0)
 ;;=1^Page name and/or number
 ;;^UTILITY(U,$J,.84,3071,0)
 ;;=3071^1^y^5
 ;;^UTILITY(U,$J,.84,3071,1,0)
 ;;=^^1^1^2931129^^^
 ;;^UTILITY(U,$J,.84,3071,1,1,0)
 ;;=The specified block has no fields on it.
 ;;^UTILITY(U,$J,.84,3071,2,0)
 ;;=^^1^1^2931129^^
 ;;^UTILITY(U,$J,.84,3071,2,1,0)
 ;;=There are no fields defined on block |1|.
 ;;^UTILITY(U,$J,.84,3071,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,3071,3,1,0)
 ;;=1^Block name
 ;;^UTILITY(U,$J,.84,3072,0)
 ;;=3072^1^y^5
 ;;^UTILITY(U,$J,.84,3072,1,0)
 ;;=^^1^1^2931129^
 ;;^UTILITY(U,$J,.84,3072,1,1,0)
 ;;=The specified field was not found on the block.
 ;;^UTILITY(U,$J,.84,3072,2,0)
 ;;=^^1^1^2931129^
 ;;^UTILITY(U,$J,.84,3072,2,1,0)
 ;;=Field |1| was not found on block |2|.
 ;;^UTILITY(U,$J,.84,3072,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,3072,3,1,0)
 ;;=1^Field order, number, caption, or unique name
 ;;^UTILITY(U,$J,.84,3072,3,2,0)
 ;;=2^Block name
 ;;^UTILITY(U,$J,.84,3081,0)
 ;;=3081^1^^5
 ;;^UTILITY(U,$J,.84,3081,1,0)
 ;;=^^2^2^2931201^^
 ;;^UTILITY(U,$J,.84,3081,1,1,0)
 ;;=The field specified by FO(field) in the pointer link or computed expression
 ;;^UTILITY(U,$J,.84,3081,1,2,0)
 ;;=is not a form only field.
 ;;^UTILITY(U,$J,.84,3081,2,0)
 ;;=^^1^1^2931201^^
 ;;^UTILITY(U,$J,.84,3081,2,1,0)
 ;;=The specified field is not a form-only field.
 ;;^UTILITY(U,$J,.84,3082,0)
 ;;=3082^1^^5
 ;;^UTILITY(U,$J,.84,3082,1,0)
 ;;=^^3^3^2931203^
 ;;^UTILITY(U,$J,.84,3082,1,1,0)
 ;;=The field, block, and/or page is missing or invalid in the expression
 ;;^UTILITY(U,$J,.84,3082,1,2,0)
 ;;=FO(field,block,page), used in the pointer link, parent field, or computed
 ;;^UTILITY(U,$J,.84,3082,1,3,0)
 ;;=expression.
 ;;^UTILITY(U,$J,.84,3082,2,0)
 ;;=^^1^1^2931203^
 ;;^UTILITY(U,$J,.84,3082,2,1,0)
 ;;=Parameters are missing or invalid in an FO() expression.
 ;;^UTILITY(U,$J,.84,3083,0)
 ;;=3083^1^^5
 ;;^UTILITY(U,$J,.84,3083,1,0)
 ;;=^^1^1^2931203^^
 ;;^UTILITY(U,$J,.84,3083,1,1,0)
 ;;=The relational expression is incomplete.
 ;;^UTILITY(U,$J,.84,3083,2,0)
 ;;=^^1^1^2931203^^
 ;;^UTILITY(U,$J,.84,3083,2,1,0)
 ;;=The relational expression is incomplete.
 ;;^UTILITY(U,$J,.84,3084,0)
 ;;=3084^1^^5
 ;;^UTILITY(U,$J,.84,3084,1,0)
 ;;=^^3^3^2931203^^
 ;;^UTILITY(U,$J,.84,3084,1,1,0)
 ;;=In a computed expression, a form-only field should be referenced as
 ;;^UTILITY(U,$J,.84,3084,1,2,0)
 ;;={FO(field,block)} or {FO(field)}.  The page parameter should not be
 ;;^UTILITY(U,$J,.84,3084,1,3,0)
 ;;=included.
 ;;^UTILITY(U,$J,.84,3084,2,0)
 ;;=^^1^1^2931203^^
 ;;^UTILITY(U,$J,.84,3084,2,1,0)
 ;;=The FO() expression should not contain a page parameter.
 ;;^UTILITY(U,$J,.84,3085,0)
 ;;=3085^1^^5
 ;;^UTILITY(U,$J,.84,3085,1,0)
 ;;=^^3^3^2931203^
 ;;^UTILITY(U,$J,.84,3085,1,1,0)
 ;;=In a computed expression, a form-only field should be referenced as
 ;;^UTILITY(U,$J,.84,3085,1,2,0)
 ;;={FO(field,block)} or {FO(field)}.  The block parameter should be
 ;;^UTILITY(U,$J,.84,3085,1,3,0)
 ;;=either the block name or `block number.  It should not be a block order.
 ;;^UTILITY(U,$J,.84,3085,2,0)
 ;;=^^1^1^2931203^^
 ;;^UTILITY(U,$J,.84,3085,2,1,0)
 ;;=The FO() expression should not use block order to specify a block.
 ;;^UTILITY(U,$J,.84,3086,0)
 ;;=3086^1^^5
 ;;^UTILITY(U,$J,.84,3086,1,0)
 ;;=^^2^2^2940708^^
 ;;^UTILITY(U,$J,.84,3086,1,1,0)
 ;;=Reject calls to PUT^DDSVAL which attempt to set the .01 field of a file to
 ;;^UTILITY(U,$J,.84,3086,1,2,0)
 ;;="" or "@".
 ;;^UTILITY(U,$J,.84,3086,2,0)
 ;;=^^1^1^2940708^^^
 ;;^UTILITY(U,$J,.84,3086,2,1,0)
 ;;=PUT^DDSVAL cannot be used to delete an entry.
 ;;^UTILITY(U,$J,.84,3091,0)
 ;;=3091^1^^5
 ;;^UTILITY(U,$J,.84,3091,1,0)
 ;;=^^1^1^2930722^
 ;;^UTILITY(U,$J,.84,3091,1,1,0)
 ;;=The data could not be filed.
 ;;^UTILITY(U,$J,.84,3091,2,0)
 ;;=^^1^1^2931202^^
 ;;^UTILITY(U,$J,.84,3091,2,1,0)
 ;;=THE DATA COULD NOT BE FILED.
 ;;^UTILITY(U,$J,.84,3092,0)
 ;;=3092^1^y^5
 ;;^UTILITY(U,$J,.84,3092,1,0)
 ;;=^^1^1^2940713^^^^
 ;;^UTILITY(U,$J,.84,3092,1,1,0)
 ;;=The given field is required and its current value is null.
 ;;^UTILITY(U,$J,.84,3092,2,0)
 ;;=^^1^1^2940713^^^
 ;;^UTILITY(U,$J,.84,3092,2,1,0)
 ;;=On |1|, |2| is a required field |3|
 ;;^UTILITY(U,$J,.84,3092,3,0)
 ;;=^.845^3^3
 ;;^UTILITY(U,$J,.84,3092,3,1,0)
 ;;=1^Page name
 ;;^UTILITY(U,$J,.84,3092,3,2,0)
 ;;=2^Caption
 ;;^UTILITY(U,$J,.84,3092,3,3,0)
 ;;=3^Subrecord name in parentheses
 ;;^UTILITY(U,$J,.84,7001,0)
 ;;=7001^2^^5
 ;;^UTILITY(U,$J,.84,7001,1,0)
 ;;=^^1^1^2940314^^^
 ;;^UTILITY(U,$J,.84,7001,1,1,0)
 ;;=This is the general Yes/No Prompt
 ;;^UTILITY(U,$J,.84,7001,2,0)
 ;;=^^1^1^2940314^^^
 ;;^UTILITY(U,$J,.84,7001,2,1,0)
 ;;=Yes^No
 ;;^UTILITY(U,$J,.84,7002,0)
 ;;=7002^2^^5
 ;;^UTILITY(U,$J,.84,7002,1,0)
 ;;=^^1^1^2940314^^^
 ;;^UTILITY(U,$J,.84,7002,1,1,0)
 ;;=Insert/Replace Switch
 ;;^UTILITY(U,$J,.84,7002,2,0)
 ;;=^^1^1^2940314^^
 ;;^UTILITY(U,$J,.84,7002,2,1,0)
 ;;=Insert ^Replace

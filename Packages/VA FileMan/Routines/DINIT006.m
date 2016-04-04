DINIT006 ; SFISC/TKW-DIALOG & LANGUAGE FILE INITS ; 3/30/99  10:41:48
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,308,2,0)
 ;;=^^1^1^2941018^
 ;;^UTILITY(U,$J,.84,308,2,1,0)
 ;;=The IENS '|IENS|' is syntactically incorrect.
 ;;^UTILITY(U,$J,.84,308,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,308,3,1,0)
 ;;=IENS^IENS.
 ;;^UTILITY(U,$J,.84,309,0)
 ;;=309^1^^5
 ;;^UTILITY(U,$J,.84,309,1,0)
 ;;=^^2^2^2931109^
 ;;^UTILITY(U,$J,.84,309,1,1,0)
 ;;=A multiple field is involved.  Either the root of the multiple or the 
 ;;^UTILITY(U,$J,.84,309,1,2,0)
 ;;=necessary entry numbers are missing.
 ;;^UTILITY(U,$J,.84,309,2,0)
 ;;=^^1^1^2931109^
 ;;^UTILITY(U,$J,.84,309,2,1,0)
 ;;=There is insufficient information to identify an entry in a subfile.
 ;;^UTILITY(U,$J,.84,310,0)
 ;;=310^1^y^5
 ;;^UTILITY(U,$J,.84,310,1,0)
 ;;=^^6^6^2940629^
 ;;^UTILITY(U,$J,.84,310,1,1,0)
 ;;=Some of the IENS subscripts in this FDA conflict with each other. For
 ;;^UTILITY(U,$J,.84,310,1,2,0)
 ;;=example, one IENS may use the sequence number ?1 while another uses +1.
 ;;^UTILITY(U,$J,.84,310,1,3,0)
 ;;=This would be illegal because the sequence number 1 is being used to
 ;;^UTILITY(U,$J,.84,310,1,4,0)
 ;;=represent two different operations. Consult your documentation for an
 ;;^UTILITY(U,$J,.84,310,1,5,0)
 ;;=explanation of the various conflicts possible. The IENS returned with this
 ;;^UTILITY(U,$J,.84,310,1,6,0)
 ;;=error happens to be one of the IENS values in conflict.
 ;;^UTILITY(U,$J,.84,310,2,0)
 ;;=^^1^1^2941018^
 ;;^UTILITY(U,$J,.84,310,2,1,0)
 ;;=The IENS '|IENS|' conflicts with the rest of the FDA.
 ;;^UTILITY(U,$J,.84,310,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,310,3,1,0)
 ;;=IENS^IENS.
 ;;^UTILITY(U,$J,.84,311,0)
 ;;=311^1^y^5
 ;;^UTILITY(U,$J,.84,311,1,0)
 ;;=^^3^3^2940629^
 ;;^UTILITY(U,$J,.84,311,1,1,0)
 ;;=Adding an entry to a file without including all required identifiers
 ;;^UTILITY(U,$J,.84,311,1,2,0)
 ;;=violates database integrity. The entry identified by this IENS lacks some
 ;;^UTILITY(U,$J,.84,311,1,3,0)
 ;;=of its required identifiers in the passed FDA.
 ;;^UTILITY(U,$J,.84,311,2,0)
 ;;=^^1^1^2941018^
 ;;^UTILITY(U,$J,.84,311,2,1,0)
 ;;=The new record '|IENS|' lacks some required identifiers.
 ;;^UTILITY(U,$J,.84,311,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,311,3,1,0)
 ;;=IENS^IENS.
 ;;^UTILITY(U,$J,.84,312,0)
 ;;=312^1^y
 ;;^UTILITY(U,$J,.84,312,1,0)
 ;;=^^2^2^2950317^
 ;;^UTILITY(U,$J,.84,312,1,1,0)
 ;;=All required identifiers must be present for a new entry to be filed.
 ;;^UTILITY(U,$J,.84,312,1,2,0)
 ;;=One or more of those fields is missing for the (sub)file.
 ;;^UTILITY(U,$J,.84,312,2,0)
 ;;=^^1^1^2950317^
 ;;^UTILITY(U,$J,.84,312,2,1,0)
 ;;=The list of fields is missing a required identifier for File #|FILE|.
 ;;^UTILITY(U,$J,.84,312,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,312,3,1,0)
 ;;=FILE^File or subfile #.
 ;;^UTILITY(U,$J,.84,313,0)
 ;;=313^1^^5
 ;;^UTILITY(U,$J,.84,313,1,0)
 ;;=^^2^2^2960306^
 ;;^UTILITY(U,$J,.84,313,1,1,0)
 ;;=The arrays that hold internal and external values must have different roots,
 ;;^UTILITY(U,$J,.84,313,1,2,0)
 ;;=but both FDAs have the same root.
 ;;^UTILITY(U,$J,.84,313,2,0)
 ;;=^^1^1^2960306^
 ;;^UTILITY(U,$J,.84,313,2,1,0)
 ;;=The FDA root for external values is the same as the one for internal values.
 ;;^UTILITY(U,$J,.84,330,0)
 ;;=330^1^y^5
 ;;^UTILITY(U,$J,.84,330,1,0)
 ;;=^^2^2^2941123^
 ;;^UTILITY(U,$J,.84,330,1,1,0)
 ;;=The value passed by the calling application should be a certain data type,
 ;;^UTILITY(U,$J,.84,330,1,2,0)
 ;;=but according to our checks it is not.
 ;;^UTILITY(U,$J,.84,330,2,0)
 ;;=^^1^1^2941123^
 ;;^UTILITY(U,$J,.84,330,2,1,0)
 ;;=The value '|1|' is not a valid |2|.
 ;;^UTILITY(U,$J,.84,330,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,330,3,1,0)
 ;;=1^Passed Value.
 ;;^UTILITY(U,$J,.84,330,3,2,0)
 ;;=2^Data Type.
 ;;^UTILITY(U,$J,.84,348,0)
 ;;=348^1^y^5
 ;;^UTILITY(U,$J,.84,348,1,0)
 ;;=^^2^2^2940214^
 ;;^UTILITY(U,$J,.84,348,1,1,0)
 ;;=The calling application passed us a variable pointer value. That value
 ;;^UTILITY(U,$J,.84,348,1,2,0)
 ;;=points to a file that does not exist, or that lacks a Header Node.
 ;;^UTILITY(U,$J,.84,348,2,0)
 ;;=^^2^2^2940214^
 ;;^UTILITY(U,$J,.84,348,2,1,0)
 ;;=The passed value '|1|' points to a file that does not exist or lacks a
 ;;^UTILITY(U,$J,.84,348,2,2,0)
 ;;=Header Node.
 ;;^UTILITY(U,$J,.84,348,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,348,3,1,0)
 ;;=1^Passed Value.
 ;;^UTILITY(U,$J,.84,349,0)
 ;;=349^2^y^5
 ;;^UTILITY(U,$J,.84,349,1,0)
 ;;=^^2^2^2940310^^^
 ;;^UTILITY(U,$J,.84,349,1,1,0)
 ;;=Text used by the Replace...With editor
 ;;^UTILITY(U,$J,.84,349,1,2,0)
 ;;=Note: Dialog will be used with $$EZBLD^DIALOG call, only one text line!!
 ;;^UTILITY(U,$J,.84,349,2,0)
 ;;=^^1^1^2940310^^
 ;;^UTILITY(U,$J,.84,349,2,1,0)
 ;;= String too long by |1| character(s)!
 ;;^UTILITY(U,$J,.84,349,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,349,3,1,0)
 ;;=1^Number of characters over the limit.
 ;;^UTILITY(U,$J,.84,350,0)
 ;;=350^2^^5
 ;;^UTILITY(U,$J,.84,350,1,0)
 ;;=^^1^1^2940310^
 ;;^UTILITY(U,$J,.84,350,1,1,0)
 ;;=Message from the Replace...With editor.
 ;;^UTILITY(U,$J,.84,350,2,0)
 ;;=^^1^1^2940310^
 ;;^UTILITY(U,$J,.84,350,2,1,0)
 ;;= String too long! '^' to quit.
 ;;^UTILITY(U,$J,.84,351,0)
 ;;=351^1^y^5
 ;;^UTILITY(U,$J,.84,351,1,0)
 ;;=^^4^4^2941021^
 ;;^UTILITY(U,$J,.84,351,1,1,0)
 ;;=When passing an FDA to the Updater, any entries intended as Finding or
 ;;^UTILITY(U,$J,.84,351,1,2,0)
 ;;=LAYGO Finding nodes must include a .01 node that has the lookup value.
 ;;^UTILITY(U,$J,.84,351,1,3,0)
 ;;=This value need not be a legitimate .01 field value, but it must be a
 ;;^UTILITY(U,$J,.84,351,1,4,0)
 ;;=valid and unambiguous lookup value for the file.
 ;;^UTILITY(U,$J,.84,351,2,0)
 ;;=^^1^1^2941021^
 ;;^UTILITY(U,$J,.84,351,2,1,0)
 ;;=FDA nodes for lookup '|IENS|' omit a .01 node with a lookup value.
 ;;^UTILITY(U,$J,.84,351,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,351,3,1,0)
 ;;=FILE^File #.
 ;;^UTILITY(U,$J,.84,351,3,2,0)
 ;;=IENS^IENS Subscript for Finding or LAYGO Finding node.
 ;;^UTILITY(U,$J,.84,352,0)
 ;;=352^1^y^5
 ;;^UTILITY(U,$J,.84,352,1,0)
 ;;=^^3^3^2980415^
 ;;^UTILITY(U,$J,.84,352,1,1,0)
 ;;=When passing an FDA to the Updater, any entries intended as LAYGO or LAYGO
 ;;^UTILITY(U,$J,.84,352,1,2,0)
 ;;=Findings nodes must include a .01 node. Every new entry must have a value
 ;;^UTILITY(U,$J,.84,352,1,3,0)
 ;;=for the .01 field.
 ;;^UTILITY(U,$J,.84,352,2,0)
 ;;=^^1^1^2980415^
 ;;^UTILITY(U,$J,.84,352,2,1,0)
 ;;=The new record '|IENS|' for file #|FILE| lacks a .01 field.

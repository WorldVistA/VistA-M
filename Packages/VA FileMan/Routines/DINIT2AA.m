DINIT2AA ;SFISC/MKO-DATA FOR KEY AND INDEX FILES ;10:50 AM  30 Mar 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(ENTRY+I) G:X="" ^DINIT2AB S Y=$E($T(ENTRY+I+1),5,999),X=$E(X,4,999),@X=Y
 Q
ENTRY ;
 ;;^DD("IX",.001,0)
 ;;=0^ADEL^Delete Keys and Indexes associated with a deleted field.^MU^^F^R^I^0^^^^^A
 ;;^DD("IX",.001,1)
 ;;=Q
 ;;^DD("IX",.001,2)
 ;;=D:'$D(DICATTED)&'$D(DIU) DELXRF^DICATT4(DA(1),DA)
 ;;^DD("IX",.1101,0)
 ;;=.11^BB^The uniqueness index for the primary key of the Index file^R^^R^IR^I^.11^^^^^LS
 ;;^DD("IX",.1101,.1,0)
 ;;=^^3^3^2980611^
 ;;^DD("IX",.1101,.1,1,0)
 ;;=The BB index, on the key of the Index file, lets FileMan test potential
 ;;^DD("IX",.1101,.1,2,0)
 ;;=key values for uniqueness. It is a regular compound index with two fields,
 ;;^DD("IX",.1101,.1,3,0)
 ;;=the .01 (File) and .02 (Index Name).
 ;;^DD("IX",.1101,1)
 ;;=S ^DD("IX","BB",X(1),X(2),DA)=""
 ;;^DD("IX",.1101,2)
 ;;=K ^DD("IX","BB",X(1),X(2),DA)
 ;;^DD("IX",.1101,2.5)
 ;;=K ^DD("IX","BB")
 ;;^DD("IX",.1101,11.1,0)
 ;;=^.114^2^2
 ;;^DD("IX",.1101,11.1,1,0)
 ;;=1^F^.11^.01^^1
 ;;^DD("IX",.1101,11.1,2,0)
 ;;=2^F^.11^.02^^2
 ;;^DD("IX",.1102,0)
 ;;=.11^IX^Allows user to look up Indexes by Name.^R^^F^IR^I^.11^^^^^LS
 ;;^DD("IX",.1102,.1,0)
 ;;=^^2^2^2990303^
 ;;^DD("IX",.1102,.1,1,0)
 ;;=This 'Regular' index on the Name field (#.02) allows users to select an
 ;;^DD("IX",.1102,.1,2,0)
 ;;=index by its name.
 ;;^DD("IX",.1102,1)
 ;;=S ^DD("IX","IX",$E(X,1,30),DA)=""
 ;;^DD("IX",.1102,2)
 ;;=K ^DD("IX","IX",$E(X,1,30),DA)
 ;;^DD("IX",.1102,2.5)
 ;;=K ^DD("IX","IX")
 ;;^DD("IX",.1102,11.1,0)
 ;;=^.114IA^1^1
 ;;^DD("IX",.1102,11.1,1,0)
 ;;=1^F^.11^.02^30^1^F
 ;;^DD("IX",.11401,0)
 ;;=.114^BB^The uniqueness index of the Cross-Reference Values multiple of the Index file^R^^F^IR^I^.114^^^^^LS
 ;;^DD("IX",.11401,1)
 ;;=S ^DD("IX",DA(1),11.1,"BB",X,DA)=""
 ;;^DD("IX",.11401,2)
 ;;=K ^DD("IX",DA(1),11.1,"BB",X,DA)
 ;;^DD("IX",.11401,2.5)
 ;;=K ^DD("IX",DA(1),11.1,"BB")
 ;;^DD("IX",.11401,11.1,0)
 ;;=^.114IA^1^1
 ;;^DD("IX",.11401,11.1,1,0)
 ;;=1^F^.114^.01^^1
 ;;^DD("IX",.11402,0)
 ;;=.114^AC^Lets FileMan find cross reference values by subscript^R^^F^IR^I^.114^^^^^S
 ;;^DD("IX",.11402,1)
 ;;=S ^DD("IX",DA(1),11.1,"AC",X,DA)=""
 ;;^DD("IX",.11402,2)
 ;;=K ^DD("IX",DA(1),11.1,"AC",X,DA)
 ;;^DD("IX",.11402,2.5)
 ;;=K ^DD("IX",DA(1),11.1,"AC")
 ;;^DD("IX",.11402,11.1,0)
 ;;=^.114IA^1^1
 ;;^DD("IX",.11402,11.1,1,0)
 ;;=1^F^.114^.5^^1^F
 ;;^DD("IX",.11403,0)
 ;;=.11^F^Lets FileMan find the indexes affected when a field changes^R^^R^IR^W^.114^^^^^LS
 ;;^DD("IX",.11403,.1,0)
 ;;=^^6^6^2970303^^
 ;;^DD("IX",.11403,.1,1,0)
 ;;=The F index, is a whole file compound cross-reference on two fields in the
 ;;^DD("IX",.11403,.1,2,0)
 ;;=Cross-Reference Values multiple: File (#2) and Field (#3). It lets FileMan
 ;;^DD("IX",.11403,.1,3,0)
 ;;=identify the indexes that might be affected when a field value changes.
 ;;^DD("IX",.11403,.1,4,0)
 ;;=The checking of this index is an essential step during field level
 ;;^DD("IX",.11403,.1,5,0)
 ;;=transactions in building the list of record level cross-references that
 ;;^DD("IX",.11403,.1,6,0)
 ;;=must be fired after user-driven changes to the record are finished.
 ;;^DD("IX",.11403,1)
 ;;=S ^DD("IX","F",X(1),X(2),DA(1),DA)=""
 ;;^DD("IX",.11403,2)
 ;;=K ^DD("IX","F",X(1),X(2),DA(1),DA)
 ;;^DD("IX",.11403,2.5)
 ;;=K ^DD("IX","F")
 ;;^DD("IX",.11403,11.1,0)
 ;;=^.114^2^2
 ;;^DD("IX",.11403,11.1,1,0)
 ;;=1^F^.114^2^^1
 ;;^DD("IX",.11403,11.1,2,0)
 ;;=2^F^.114^3^^2
 ;;^DD("IX",.3101,0)
 ;;=.31^BB^The uniqueness index for the Key file^R^^R^IR^I^.31^^^^^LS
 ;;^DD("IX",.3101,.1,0)
 ;;=^^3^3^2970314^^^^
 ;;^DD("IX",.3101,.1,1,0)
 ;;=The BB index, the uniqueness index for the Key file's key, lets FileMan
 ;;^DD("IX",.3101,.1,2,0)
 ;;=test potential key values for uniqueness. It is a regular compound index
 ;;^DD("IX",.3101,.1,3,0)
 ;;=with two fields, the .01 (File) and .02 (Key Name).
 ;;^DD("IX",.3101,1)
 ;;=S ^DD("KEY","BB",X(1),X(2),DA)=""
 ;;^DD("IX",.3101,2)
 ;;=K ^DD("KEY","BB",X(1),X(2),DA)
 ;;^DD("IX",.3101,2.5)
 ;;=K ^DD("KEY","BB")
 ;;^DD("IX",.3101,11.1,0)
 ;;=^.114^2^2
 ;;^DD("IX",.3101,11.1,1,0)
 ;;=1^F^.31^.01^^1
 ;;^DD("IX",.3101,11.1,2,0)
 ;;=2^F^.31^.02^^2
 ;;^DD("IX",.3102,0)
 ;;=.31^AP^Lets FileMan determine the primary key of a file^R^^R^IR^I^.31^^^^^S
 ;;^DD("IX",.3102,1)
 ;;=S ^DD("KEY","AP",X(1),X(2),DA)=""
 ;;^DD("IX",.3102,1.4)
 ;;=S X=X(2)="P"
 ;;^DD("IX",.3102,2)
 ;;=K ^DD("KEY","AP",X(1),X(2),DA)
 ;;^DD("IX",.3102,2.4)
 ;;=S X=X(2)="P"
 ;;^DD("IX",.3102,2.5)
 ;;=K ^DD("KEY","AP")
 ;;^DD("IX",.3102,11.1,0)
 ;;=^.114I^2^2
 ;;^DD("IX",.3102,11.1,1,0)
 ;;=1^F^.31^.01^^1
 ;;^DD("IX",.3102,11.1,2,0)
 ;;=2^F^.31^1^^2
 ;;^DD("IX",.3103,0)
 ;;=.31^AU^Lets FileMan determine whether an index is a uniqueness index for a key^R^^F^IR^I^.31^^^^^S
 ;;^DD("IX",.3103,1)
 ;;=S ^DD("KEY","AU",X,DA)=""
 ;;^DD("IX",.3103,2)
 ;;=K ^DD("KEY","AU",X,DA)
 ;;^DD("IX",.3103,2.5)
 ;;=K ^DD("KEY","AU")
 ;;^DD("IX",.3103,11.1,0)
 ;;=^.114IA^1^1
 ;;^DD("IX",.3103,11.1,1,0)
 ;;=1^F^.31^3^^1^F
 ;;^DD("IX",.31201,0)
 ;;=.312^BB^The uniqueness index for Field multiple of the Key file.^R^^R^IR^I^.312^^^^^LS
 ;;^DD("IX",.31201,.1,0)
 ;;=^^3^3^2970203^^
 ;;^DD("IX",.31201,.1,1,0)
 ;;=The BB index, on the key of the Field multiple of the Key file, lets
 ;;^DD("IX",.31201,.1,2,0)
 ;;=FileMan test potential key values for uniqueness. It is a regular compound
 ;;^DD("IX",.31201,.1,3,0)
 ;;=index with two fields, the .01 (Field) and .02 (File).
 ;;^DD("IX",.31201,1)
 ;;=S ^DD("KEY",DA(1),2,"BB",X(1),X(2),DA)=""
 ;;^DD("IX",.31201,2)
 ;;=K ^DD("KEY",DA(1),2,"BB",X(1),X(2),DA)
 ;;^DD("IX",.31201,2.5)
 ;;=K ^DD("KEY",DA(1),2,"BB")
 ;;^DD("IX",.31201,11.1,0)
 ;;=^.114^2^2
 ;;^DD("IX",.31201,11.1,1,0)
 ;;=1^F^.312^.01^^1
 ;;^DD("IX",.31201,11.1,2,0)
 ;;=2^F^.312^.02^^2
 ;;^DD("IX",.31202,0)
 ;;=.31^F^Lets FileMan find the Keys that include each field^R^^R^IR^W^.312^^^^^LS
 ;;^DD("IX",.31202,.1,0)
 ;;=^^4^4^2980911^
 ;;^DD("IX",.31202,.1,1,0)
 ;;=The F index, a whole file compound cross-reference on the key of the
 ;;^DD("IX",.31202,.1,2,0)
 ;;=Fields multiple of the Key file, lets FileMan determine the keys a field
 ;;^DD("IX",.31202,.1,3,0)
 ;;=is part of. This is essential for identifying the key value uniqueness
 ;;^DD("IX",.31202,.1,4,0)
 ;;=tests that must be done when a field value changes.
 ;;^DD("IX",.31202,1)
 ;;=S ^DD("KEY","F",X(1),X(2),DA(1),DA)=""
 ;;^DD("IX",.31202,2)
 ;;=K ^DD("KEY","F",X(1),X(2),DA(1),DA)
 ;;^DD("IX",.31202,2.5)
 ;;=K ^DD("KEY","F")
 ;;^DD("IX",.31202,11.1,0)
 ;;=^.114^2^2
 ;;^DD("IX",.31202,11.1,1,0)
 ;;=1^F^.312^.02^^1
 ;;^DD("IX",.31202,11.1,2,0)
 ;;=2^F^.312^.01^^2

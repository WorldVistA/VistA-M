DMLAC000 ; VEN/SMH - Convert DSS's Language file to FM 22.2 Lang File; 18-DEC-2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 D DTNOLF^DICRW ; Init ST
 K ^UTILITY("DIT",$J) ; Bye bye
 D ^DMLAC001,^DMLAC002,^DMLAC003,^DMLAC004,^DMLAC005 ; Load conversion tables in ^UTILITY("DIT")
 ; ZEXCEPT: IOP
 S IOP="0;P-OTHER;80;9999999"
 D P^DITP ; Repoint
 QUIT
 ;
 ;
 ;
PRIVATE ; Code to create DMLAC data routines for conversion. Run on a VXVISTA system.
 ; Create arrays for P^DITP.
 S U="^"
 N OV,NV ; Old value, new value for IENS
 K ^UTILITY("DIT",$J)
 N FOREIGN S FOREIGN="/home/sam/emptyENV2/g/mumps.gld" ; This database contains the new codes.
 ;
 ; Create conversion table using 3 letter code as lookup key (D Index).
 N I S I=""
 F  S I=$O(^DI(.85,"D",I)) Q:I=""  S OV=$O(^(I,"")),NV=$O(^|FOREIGN|DI(.85,"D",I,"")) D 
 . W I,?5,^DI(.85,OV,0) W:NV ?60,^|FOREIGN|DI(.85,NV,0) W ! ; NV is conditional b/c we don't have a value for QAA-QZZ
 . S ^UTILITY("DIT",$J,OV)=NV ; IEN form for regular pointers
 . S ^UTILITY("DIT",$J,OV_";DI(.85,")=NV_";DI(.85," ; VP form for variable pointers
 ;
 ; Create Pointings array
 ; S ^UTILITY("DIT",$J,0,n)=(sub)file#^pointing_field#^2nd piece of 0 node from DD for the field.
 N I S I=""
 F  S I=$O(^DD(.85,0,"PT",I)) Q:'I  D
 . N FILE S FILE=I
 . N FLD S FLD=$O(^(I,""))
 . N DD02 S DD02=$P(^DD(FILE,FLD,0),"^",2)
 . S ^UTILITY("DIT",$J,0,I)=FILE_U_FLD_U_DD02
 ;
 ; Rest is for generating the routines containing the data using DIFROM
 S DH=" F I=1:2 S X=$T(Q+I) Q:X=""""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y" ; 1st code line
 N DL S DL=0 ; Line number
 N GREF S GREF=$NA(^UTILITY("DIT",$J)) ; Global reference for $Q                                                                    
 N LREF S LREF=$E(GREF,1,$L(GREF)-1)  ; Last reference -- w/o the comma.
 F  S GREF=$Q(@GREF) Q:GREF'[LREF  D  ; Loop until the Global doesn't match itself.
 . S DL=DL+1                     ; next line
 . N REF2STORE S REF2STORE=GREF  ; We need to change the stored reference for the destination system.
 . S $P(REF2STORE,",",2)="$J"    ; Remove our job number, and just put $J. Destination system will resolve it.
 . S ^UTILITY($J,DL,0)=REF2STORE ; Store ref
 . S DL=DL+1                     ; next line
 . S ^UTILITY($J,DL,0)="="_@GREF ; store the value.
 ;
 N DRN S DRN=1 ; Routine Number
 N DN S DN="DMLAC" ; Routine Prefix
 N DILN2 S DILN2=" ;;22.2T2;VA FILEMAN;;Dec 03, 2012" ; Second Line
 N DIFRM S DIFRM=^DD("ROU") ; Max rou size
 D FILE^DIFROM3 ; Save code - Creates routines DMLAC001 and forward
 QUIT

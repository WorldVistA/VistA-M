DINIT271 ;SFISC/DPC-LOAD OF FOREIGN FORMAT DD (END) ;9/9/94  12:56
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) G ^DINIT27A:X="" S Y=$E($T(Q+I+1),5,999),X=$E(X,4,999),@X=Y
Q Q
 ;;^DIC(.44,"%D",0)
 ;;=^^3^3^2940908^
 ;;^DIC(.44,"%D",1,0)
 ;;=This file stores the characteristics of various file export formats,
 ;;^DIC(.44,"%D",2,0)
 ;;=which are used by the Export tool in building Export Templates to send
 ;;^DIC(.44,"%D",3,0)
 ;;=data to non-M systems.
 ;;^DD(.44,11,0)
 ;;=SUBSTITUTE FOR NULL^F^^0;13^K:$L(X)>15!($L(X)<1) X
 ;;^DD(.44,11,3)
 ;;=Answer must be 1-15 characters in length.
 ;;^DD(.44,11,21,0)
 ;;=^^5^5^2930107^
 ;;^DD(.44,11,21,1,0)
 ;;=This field only affects numeric values exported in a delimited format.
 ;;^DD(.44,11,21,2,0)
 ;;=If nothing is entered in this field, data values of null will cause
 ;;^DD(.44,11,21,3,0)
 ;;=nothing to be exported for that field in the particular record.  If you
 ;;^DD(.44,11,21,4,0)
 ;;=want something to be exported when the data value is null, enter the
 ;;^DD(.44,11,21,5,0)
 ;;=character or characters in this field.
 ;;^DD(.44,11,"DT")
 ;;=2930107
 ;;^DD(.44,40,0)
 ;;=FORMAT USED?^S^0:NO;1:YES;^0;9^Q
 ;;^DD(.44,40,21,0)
 ;;=^^2^2^2920925^
 ;;^DD(.44,40,21,1,0)
 ;;=When set to YES, this field means that this Foriegn Format entry has been
 ;;^DD(.44,40,21,2,0)
 ;;=used to create an Export Template.
 ;;^DD(.44,40,"DT")
 ;;=2920925
 ;;^DD(.44,50,0)
 ;;=OTHER NAME FOR FORMAT^.441^^5;0
 ;;^DD(.441,0)
 ;;=OTHER NAME FOR FORMAT SUB-FIELD^^1^2
 ;;^DD(.441,0,"DT")
 ;;=2920914
 ;;^DD(.441,0,"IX","B",.441,.01)
 ;;=
 ;;^DD(.441,0,"NM","OTHER NAME FOR FORMAT")
 ;;=
 ;;^DD(.441,0,"UP")
 ;;=.44
 ;;^DD(.441,.01,0)
 ;;=OTHER NAME FOR FORMAT^MF^^0;1^K:X[""""!($A(X)=45) X I $D(X) K:$L(X)>30!($L(X)<3) X
 ;;^DD(.441,.01,1,0)
 ;;=^.1
 ;;^DD(.441,.01,1,1,0)
 ;;=.441^B
 ;;^DD(.441,.01,1,1,1)
 ;;=S ^DIST(.44,DA(1),5,"B",$E(X,1,30),DA)=""
 ;;^DD(.441,.01,1,1,2)
 ;;=K ^DIST(.44,DA(1),5,"B",$E(X,1,30),DA)
 ;;^DD(.441,.01,1,2,0)
 ;;=.44^C
 ;;^DD(.441,.01,1,2,1)
 ;;=S ^DIST(.44,"C",$E(X,1,30),DA(1),DA)=""
 ;;^DD(.441,.01,1,2,2)
 ;;=K ^DIST(.44,"C",$E(X,1,30),DA(1),DA)
 ;;^DD(.441,.01,1,2,"%D",0)
 ;;=^^1^1^2920917^
 ;;^DD(.441,.01,1,2,"%D",1,0)
 ;;=This cross reference allows look-up of formats based on OTHER NAMES.
 ;;^DD(.441,.01,1,2,"DT")
 ;;=2920917
 ;;^DD(.441,.01,3)
 ;;=Answer must be 3-30 characters in length.
 ;;^DD(.441,.01,21,0)
 ;;=^^2^2^2920917^
 ;;^DD(.441,.01,21,1,0)
 ;;=Another name by which the foreign format might be known.  This name can be
 ;;^DD(.441,.01,21,2,0)
 ;;=used to access the format.
 ;;^DD(.441,.01,"DT")
 ;;=2920917
 ;;^DD(.441,1,0)
 ;;=DESCRIPTION FOR OTHER NAME^.4411^^1;0
 ;;^DD(.441,1,21,0)
 ;;=^^1^1^2920917^
 ;;^DD(.441,1,21,1,0)
 ;;=Description and information about the format's other name.
 ;;^DD(.4411,0)
 ;;=DESCRIPTION FOR OTHER NAME SUB-FIELD^^.01^1
 ;;^DD(.4411,0,"DT")
 ;;=2920914
 ;;^DD(.4411,0,"NM","DESCRIPTION FOR OTHER NAME")
 ;;=
 ;;^DD(.4411,0,"UP")
 ;;=.441
 ;;^DD(.4411,.01,0)
 ;;=DESCRIPTION FOR OTHER NAME^W^^0;1^Q
 ;;^DD(.4411,.01,"DT")
 ;;=2920914
 ;;^DD(.447,0)
 ;;=DESCRIPTION SUB-FIELD^^.01^1
 ;;^DD(.447,0,"DT")
 ;;=2920914
 ;;^DD(.447,0,"NM","DESCRIPTION")
 ;;=
 ;;^DD(.447,0,"UP")
 ;;=.44
 ;;^DD(.447,.01,0)
 ;;=DESCRIPTION^W^^0;1^Q
 ;;^DD(.447,.01,"DT")
 ;;=2920914
 ;;^DD(.448,0)
 ;;=USAGE NOTES SUB-FIELD^^.01^1
 ;;^DD(.448,0,"DT")
 ;;=2920914
 ;;^DD(.448,0,"NM","USAGE NOTES")
 ;;=
 ;;^DD(.448,0,"UP")
 ;;=.44
 ;;^DD(.448,.01,0)
 ;;=USAGE NOTES^W^^0;1^Q
 ;;^DD(.448,.01,"DT")
 ;;=2920914

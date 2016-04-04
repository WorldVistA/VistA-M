DIPKI004 ;VEN/TOAD-PACKAGE FILE INIT ; 04-JAN-2015
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 Q:'DIFQ(9.4)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DD(9.44,222.9,21,3,0)
 ;;=he does not get the ability to change from merge to overwrite or
 ;;^DD(9.44,222.9,21,4,0)
 ;;=from overwrite to merge.
 ;;^DD(9.44,222.9,21,5,0)
 ;;= 
 ;;^DD(9.44,222.9,21,6,0)
 ;;=No means that the developer of the INIT will control whether the data
 ;;^DD(9.44,222.9,21,7,0)
 ;;=will be installed at the target site.
 ;;^DD(9.44,222.9,"DT")
 ;;=2940502
 ;;^DD(9.44,223,0)
 ;;=SCREEN TO DETERMINE DD UPDATE^KX^^223;E1,245^K:$L(X)>240 X I $D(X) D ^DIM
 ;;^DD(9.44,223,3)
 ;;=This is Standard MUMPS code from 1 to 240 characters in length.
 ;;^DD(9.44,223,9)
 ;;=@
 ;;^DD(9.44,223,21,0)
 ;;=^^7^7^2920513^^
 ;;^DD(9.44,223,21,1,0)
 ;;=This field contains standard MUMPS code which is used to determine
 ;;^DD(9.44,223,21,2,0)
 ;;=whether or not a data dictionary should be updated.  This code must
 ;;^DD(9.44,223,21,3,0)
 ;;=set $T.  If $T=1, the DD will be updated.  If $T=0, it will not.
 ;;^DD(9.44,223,21,4,0)
 ;;= 
 ;;^DD(9.44,223,21,5,0)
 ;;=This code will be executed within VA FileMan which may be being called
 ;;^DD(9.44,223,21,6,0)
 ;;=from within MailMan which is being called from within MenuMan.
 ;;^DD(9.44,223,21,7,0)
 ;;=Namespace your variables.
 ;;^DD(9.44,223,"DT")
 ;;=2890927
 ;;^DD(9.45,0)
 ;;=FIELD SUB-FIELD^NL^.01^1
 ;;^DD(9.45,0,"IX","B",9.45,.01)
 ;;=
 ;;^DD(9.45,0,"NM","FIELD")
 ;;=
 ;;^DD(9.45,0,"UP")
 ;;=9.44
 ;;^DD(9.45,.01,0)
 ;;=FIELD^MFX^^0;1^S %=+^DIC(9.4,DA(2),4,DA(1),0),X=$S($L(X)>30:X,$D(^DD(%,"B",X)):X,X'?.NP:0,'$D(^DD(%,X,0)):0,1:$P(^(0),U,1)) K:X=0 X
 ;;^DD(9.45,.01,.1)
 ;;=FIELDS REQUIRED FOR THE PACKAGE
 ;;^DD(9.45,.01,1,0)
 ;;=^.1
 ;;^DD(9.45,.01,1,1,0)
 ;;=9.45^B
 ;;^DD(9.45,.01,1,1,1)
 ;;=S ^DIC(9.4,DA(2),4,DA(1),1,"B",X,DA)=""
 ;;^DD(9.45,.01,1,1,2)
 ;;=K ^DIC(9.4,DA(2),4,DA(1),1,"B",X,DA)
 ;;^DD(9.45,.01,3)
 ;;=Please enter the name of a field.
 ;;^DD(9.45,.01,21,0)
 ;;=^^4^4^2920513^^^^
 ;;^DD(9.45,.01,21,1,0)
 ;;=The name of a FileMan field required by this Package.  This field is
 ;;^DD(9.45,.01,21,2,0)
 ;;=only to be filled in if you wish to send only selected fields in
 ;;^DD(9.45,.01,21,3,0)
 ;;=an INIT of this file, instead of the full data dictionary. (i.e.,
 ;;^DD(9.45,.01,21,4,0)
 ;;=a partial DD).
 ;;^DD(9.45,.01,"DT")
 ;;=2840302
 ;;^DD(9.46,0)
 ;;=PRINT TEMPLATE SUB-FIELD^NL^2^2
 ;;^DD(9.46,0,"NM","PRINT TEMPLATE")
 ;;=
 ;;^DD(9.46,0,"UP")
 ;;=9.4
 ;;^DD(9.46,.01,0)
 ;;=PRINT TEMPLATE^MF^^0;1^K:$L(X)>50!($L(X)<2) X
 ;;^DD(9.46,.01,1,0)
 ;;=^.1^^0
 ;;^DD(9.46,.01,3)
 ;;=Please enter the name of a Print Template (2-50 characters).
 ;;^DD(9.46,.01,21,0)
 ;;=^^5^5^2921202^
 ;;^DD(9.46,.01,21,1,0)
 ;;=The name of a Print Template being sent with this Package.
 ;;^DD(9.46,.01,21,2,0)
 ;;=This multiple is used to send non-namespaced templates in an INIT.
 ;;^DD(9.46,.01,21,3,0)
 ;;=Namespaced templates are sent automatically and need not be listed
 ;;^DD(9.46,.01,21,4,0)
 ;;=separately.  Selected Fields for Export and Export templates cannot be
 ;;^DD(9.46,.01,21,5,0)
 ;;=sent; entering their names here will have no effect.
 ;;^DD(9.46,.01,"DT")
 ;;=2821117
 ;;^DD(9.46,2,0)
 ;;=FILE^RP1'^DIC(^0;2^Q
 ;;^DD(9.46,2,21,0)
 ;;=^^1^1^2920513^^
 ;;^DD(9.46,2,21,1,0)
 ;;=The FileMan file for this Print Template.
 ;;^DD(9.46,2,"DT")
 ;;=2821126
 ;;^DD(9.47,0)
 ;;=INPUT TEMPLATE SUB-FIELD^NL^2^2
 ;;^DD(9.47,0,"ID",2)
 ;;=W "   FILE #"_$P(^(0),U,2)
 ;;^DD(9.47,0,"NM","INPUT TEMPLATE")
 ;;=
 ;;^DD(9.47,0,"UP")
 ;;=9.4
 ;;^DD(9.47,.01,0)
 ;;=INPUT TEMPLATE^MF^^0;1^K:$L(X)>50!($L(X)<2) X
 ;;^DD(9.47,.01,1,0)
 ;;=^.1^^0
 ;;^DD(9.47,.01,3)
 ;;=Please enter the name of an Input Template (2-50 characters).
 ;;^DD(9.47,.01,21,0)
 ;;=^^4^4^2920513^^^
 ;;^DD(9.47,.01,21,1,0)
 ;;=The name of an Input Template being sent with this Package.
 ;;^DD(9.47,.01,21,2,0)
 ;;=This multiple is used to send non-namespaced templates in an INIT.
 ;;^DD(9.47,.01,21,3,0)
 ;;=Namespaced templates are sent automatically and need not be listed
 ;;^DD(9.47,.01,21,4,0)
 ;;=separately.
 ;;^DD(9.47,.01,"DT")
 ;;=2821117
 ;;^DD(9.47,2,0)
 ;;=FILE^RP1'^DIC(^0;2^Q
 ;;^DD(9.47,2,21,0)
 ;;=^^1^1^2920513^^
 ;;^DD(9.47,2,21,1,0)
 ;;=The name of the FileMan file for this Input Template.
 ;;^DD(9.47,2,"DT")
 ;;=2821126
 ;;^DD(9.48,0)
 ;;=SORT TEMPLATE SUB-FIELD^NL^2^2
 ;;^DD(9.48,0,"NM","SORT TEMPLATE")
 ;;=
 ;;^DD(9.48,0,"UP")
 ;;=9.4
 ;;^DD(9.48,.01,0)
 ;;=SORT TEMPLATE^MF^^0;1^K:$L(X)>50!($L(X)<2) X
 ;;^DD(9.48,.01,1,0)
 ;;=^.1^^0
 ;;^DD(9.48,.01,3)
 ;;=Please enter the name of a Sort Template (2-50 characters).
 ;;^DD(9.48,.01,21,0)
 ;;=^^4^4^2920513^^^
 ;;^DD(9.48,.01,21,1,0)
 ;;=The name of a Sort Template being sent with this Package.
 ;;^DD(9.48,.01,21,2,0)
 ;;=This multiple is used to send non-namespaced templates in an INIT.
 ;;^DD(9.48,.01,21,3,0)
 ;;=Namespaced templates are sent automatically and need not be listed
 ;;^DD(9.48,.01,21,4,0)
 ;;=separately.
 ;;^DD(9.48,.01,"DT")
 ;;=2821117
 ;;^DD(9.48,2,0)
 ;;=FILE^RP1'^DIC(^0;2^Q
 ;;^DD(9.48,2,21,0)
 ;;=^^1^1^2920513^^
 ;;^DD(9.48,2,21,1,0)
 ;;=The FileMan file for this Sort Template.
 ;;^DD(9.485,0)
 ;;=SCREEN TEMPLATE (FORM) SUB-FIELD^^2^2
 ;;^DD(9.485,0,"DT")
 ;;=2910320
 ;;^DD(9.485,0,"NM","SCREEN TEMPLATE (FORM)")
 ;;=
 ;;^DD(9.485,0,"UP")
 ;;=9.4
 ;;^DD(9.485,.01,0)
 ;;=SCREEN TEMPLATE (FORM)^MF^^0;1^K:$L(X)>50!($L(X)<2) X
 ;;^DD(9.485,.01,1,0)
 ;;=^.1^^0
 ;;^DD(9.485,.01,3)
 ;;=Please enter the name of a Screen Template (Form), (2-50 characters).
 ;;^DD(9.485,.01,21,0)
 ;;=^^2^2^2920513^^^^
 ;;^DD(9.485,.01,21,1,0)
 ;;=The name of a Screen Template (from the FORM file) associated with
 ;;^DD(9.485,.01,21,2,0)
 ;;=this Package.
 ;;^DD(9.485,.01,23,0)
 ;;=^^3^3^2910320^^^^
 ;;^DD(9.485,.01,23,1,0)
 ;;=This list is originally created by the user for building an INIT, and allows
 ;;^DD(9.485,.01,23,2,0)
 ;;=the user to send FORMS on an INIT that are outside the Package namespace.
 ;;^DD(9.485,.01,23,3,0)
 ;;=All BLOCKS associated with the FORMS are also sent automatically.
 ;;^DD(9.485,.01,"DT")
 ;;=2910320
 ;;^DD(9.485,2,0)
 ;;=FILE^RP1'^DIC(^0;2^Q
 ;;^DD(9.485,2,21,0)
 ;;=^^1^1^2920513^^
 ;;^DD(9.485,2,21,1,0)
 ;;=The name of the FileMan file for this Screen Template (FORM).
 ;;^DD(9.485,2,23,0)
 ;;=^^1^1^2910320^
 ;;^DD(9.485,2,23,1,0)
 ;;=This field must match the PRIMARY FILE field on the FORM file.
 ;;^DD(9.485,2,"DT")
 ;;=2910320
 ;;^DD(9.49,0)
 ;;=VERSION SUB-FIELD^NL^1105^6
 ;;^DD(9.49,0,"DT")
 ;;=2940607
 ;;^DD(9.49,0,"ID",1)
 ;;=W:$D(^("0")) "   ",$E($P(^("0"),U,2),4,5)_"-"_$E($P(^("0"),U,2),6,7)_"-"_$E($P(^("0"),U,2),2,3)
 ;;^DD(9.49,0,"IX","B",9.49,.01)
 ;;=
 ;;^DD(9.49,0,"NM","VERSION")
 ;;=
 ;;^DD(9.49,0,"UP")
 ;;=9.4
 ;;^DD(9.49,.01,0)
 ;;=VERSION^FX^^0;1^K:'(X?1.3N.1".".2N.1A.2N)!(X>999)!(X'>0) X
 ;;^DD(9.49,.01,1,0)
 ;;=^.1
 ;;^DD(9.49,.01,1,1,0)
 ;;=9.49^B
 ;;^DD(9.49,.01,1,1,1)
 ;;=S ^DIC(9.4,DA(1),22,"B",$E(X,1,30),DA)=""
 ;;^DD(9.49,.01,1,1,2)
 ;;=K ^DIC(9.4,DA(1),22,"B",$E(X,1,30),DA)
 ;;^DD(9.49,.01,3)
 ;;=Please enter the Version Number of this release.  This can be either the old method (1.0, 16.04, etc.) or the new (17T1, 6.0V2, etc.).
 ;;^DD(9.49,.01,21,0)
 ;;=^^2^2^2930415^^^^
 ;;^DD(9.49,.01,21,1,0)
 ;;=The version number of this Package.  This number is updated automatically
 ;;^DD(9.49,.01,21,2,0)
 ;;=when an INIT is built for this package.
 ;;^DD(9.49,.01,"DT")
 ;;=2910322
 ;;^DD(9.49,1,0)
 ;;=DATE DISTRIBUTED^D^^0;2^S %DT="E" D ^%DT S X=Y K:Y<1 X
 ;;^DD(9.49,1,21,0)
 ;;=^^2^2^2911209^^^
 ;;^DD(9.49,1,21,1,0)
 ;;=The date this release was distributed.  This field is updated automatically
 ;;^DD(9.49,1,21,2,0)
 ;;=when an INIT is built for this package.
 ;;^DD(9.49,1,"DT")
 ;;=2840227
 ;;^DD(9.49,2,0)
 ;;=DATE INSTALLED AT THIS SITE^D^^0;3^S %DT="ET" D ^%DT S X=Y K:Y<1 X
 ;;^DD(9.49,2,21,0)
 ;;=^^2^2^2911209^^^
 ;;^DD(9.49,2,21,1,0)
 ;;=The date this release was installed at this site.  This field is updated
 ;;^DD(9.49,2,21,2,0)
 ;;=automatically when an INIT is installed for this package.
 ;;^DD(9.49,2,"DT")
 ;;=2840302
 ;;^DD(9.49,3,0)
 ;;=INSTALLED BY^P200'^VA(200,^0;4^Q
 ;;^DD(9.49,3,21,0)
 ;;=^^1^1^2940607^
 ;;^DD(9.49,3,21,1,0)
 ;;=This is the person who installed this version at this site.
 ;;^DD(9.49,3,"DT")
 ;;=2940607
 ;;^DD(9.49,41,0)
 ;;=DESCRIPTION OF ENHANCEMENTS^9.54^^1;0
 ;;^DD(9.49,41,21,0)
 ;;=^^2^2^2851008^^
 ;;^DD(9.49,41,21,1,0)
 ;;=This is a description of the enhancements being distributed with this
 ;;^DD(9.49,41,21,2,0)
 ;;=release.
 ;;^DD(9.49,1105,0)
 ;;=PATCH APPLICATION HISTORY^9.4901^^PAH;0
 ;;^DD(9.4901,0)
 ;;=PATCH APPLICATION HISTORY SUB-FIELD^^1^4
 ;;^DD(9.4901,0,"DT")
 ;;=2940603
 ;;^DD(9.4901,0,"IX","B",9.4901,.01)
 ;;=
 ;;^DD(9.4901,0,"NM","PATCH APPLICATION HISTORY")
 ;;=
 ;;^DD(9.4901,0,"UP")
 ;;=9.49
 ;;^DD(9.4901,.01,0)
 ;;=PATCH APPLICATION HISTORY^MF^^0;1^K:$L(X)>15!($L(X)<8) X
 ;;^DD(9.4901,.01,1,0)
 ;;=^.1
 ;;^DD(9.4901,.01,1,1,0)
 ;;=9.4901^B
 ;;^DD(9.4901,.01,1,1,1)
 ;;=S ^DIC(9.4,DA(2),22,DA(1),"PAH","B",$E(X,1,30),DA)=""
 ;;^DD(9.4901,.01,1,1,2)
 ;;=K ^DIC(9.4,DA(2),22,DA(1),"PAH","B",$E(X,1,30),DA)
 ;;^DD(9.4901,.01,3)
 ;;=Answer must be 8-15 characters in length.
 ;;^DD(9.4901,.01,"DT")
 ;;=2890426
 ;;^DD(9.4901,.02,0)
 ;;=DATE APPLIED^D^^0;2^S %DT="ESTX" D ^%DT S X=Y K:Y<1 X

DINIT0FB ;SFISC/MKO-DATA FOR FORM AND BLOCK FILES ;8:34 AM  18 Jan 2000
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**20**
 ;
 F I=1:2 S X=$T(ENTRY+I) G:X="" ^DINIT0FC S Y=$E($T(ENTRY+I+1),5,999),X=$E(X,4,999),@X=Y
 Q
ENTRY ;
 ;;^DIST(.404,.110107,40,4,14)
 ;;=I $G(DUZ(0))'="@" S DDSERROR=1 D HLP^DDSUTL($C(7)_"Only programmers are allowed to edit the Transform for Storage.")
 ;;^DIST(.404,.110107,40,5,0)
 ;;=7^Maximum Length^3
 ;;^DIST(.404,.110107,40,5,1)
 ;;=6
 ;;^DIST(.404,.110107,40,5,2)
 ;;=7,18^3^7,2
 ;;^DIST(.404,.110107,40,5,13)
 ;;=S:$$GET^DDSVAL(.114,.DA,.5) DIKCCRV=1
 ;;^DIST(.404,.110107,40,6,0)
 ;;=8^Collation^3
 ;;^DIST(.404,.110107,40,6,1)
 ;;=7
 ;;^DIST(.404,.110107,40,6,2)
 ;;=7,58^9^7,47
 ;;^DIST(.404,.110107,40,6,3)
 ;;=forwards
 ;;^DIST(.404,.110107,40,7,0)
 ;;=9^Lookup Prompt^3
 ;;^DIST(.404,.110107,40,7,1)
 ;;=8
 ;;^DIST(.404,.110107,40,7,2)
 ;;=8,18^30^8,3
 ;;^DIST(.404,.110107,40,8,0)
 ;;=5^File^3
 ;;^DIST(.404,.110107,40,8,1)
 ;;=2
 ;;^DIST(.404,.110107,40,8,2)
 ;;=4,58^20^4,52
 ;;^DIST(.404,.110107,40,8,3)
 ;;=!M
 ;;^DIST(.404,.110107,40,8,3.1)
 ;;=S Y=$$GET^DDSVAL(.11,DA(1),.51)
 ;;^DIST(.404,.110107,40,8,4)
 ;;=1^^^1
 ;;^DIST(.404,.110107,40,8,14)
 ;;=N RF S RF=$$GET^DDSVAL(.11,DA(1),.51) I X'=RF S DDSERROR=1 D HLP^DDSUTL("This File number must equal the Root File number: "_RF_".")
 ;;^DIST(.404,.110107,40,9,0)
 ;;=4^Field^3^^FIELD
 ;;^DIST(.404,.110107,40,9,1)
 ;;=3
 ;;^DIST(.404,.110107,40,9,2)
 ;;=4,18^20^4,11
 ;;^DIST(.404,.110107,40,9,4)
 ;;=1
 ;;^DIST(.404,.110107,40,9,13)
 ;;=S:X=""!(DDSOLD="") DIKCCRV=1 I $$GET^DDSVAL(.114,.DA,.5) N DIKCTYPE S DIKCTYPE=$P($G(^DD($$GET^DDSVAL(.114,.DA,2),+X,0)),U,2) D PUT^DDSVAL(.114,.DA,6,$S(DIKCTYPE["F"!(DIKCTYPE["K"):30,1:""),"","I")
 ;;^DIST(.404,.110107,40,10,0)
 ;;=6^Field Name^4
 ;;^DIST(.404,.110107,40,10,2)
 ;;=5,18^60^5,6
 ;;^DIST(.404,.110107,40,10,30)
 ;;=N DIKCFIL,DIKCFLD S Y="",DIKCFIL=+{FILE},DIKCFLD=+{FIELD} I DIKCFIL,DIKCFLD S Y=$P($G(^DD(DIKCFIL,DIKCFLD,0)),U) S:$L(Y)>60 Y=$E(Y,1,57)_"..."
 ;;^DIST(.404,.110107,40,11,0)
 ;;=12^Transform for Display^3^^TRANSFORM FOR DISPLAY
 ;;^DIST(.404,.110107,40,11,1)
 ;;=5.5
 ;;^DIST(.404,.110107,40,11,2)
 ;;=11,25^53^11,2
 ;;^DIST(.404,.110107,40,11,14)
 ;;=I $G(DUZ(0))'="@" S DDSERROR=1 D HLP^DDSUTL($C(7)_"Only programmers are allowed to edit the Transform for Display.")
 ;;^DIST(.404,.110107,40,12,0)
 ;;=11^Transform for Lookup^3
 ;;^DIST(.404,.110107,40,12,1)
 ;;=5.3
 ;;^DIST(.404,.110107,40,12,2)
 ;;=10,25^53^10,3
 ;;^DIST(.404,.110107,40,12,14)
 ;;=I $G(DUZ(0))'="@" S DDSERROR=1 D HLP^DDSUTL($C(7)_"Only programmers are allowed to edit the Transform for Lookup.")
 ;;^DIST(.404,.110108,0)
 ;;=DIKC EDIT COMPUTED CRV^.114
 ;;^DIST(.404,.110108,40,0)
 ;;=^.4044I^8^7
 ;;^DIST(.404,.110108,40,1,0)
 ;;=1^ Computed-Type Cross Reference Value ^1
 ;;^DIST(.404,.110108,40,1,2)
 ;;=^^1,21
 ;;^DIST(.404,.110108,40,2,0)
 ;;=2^Order Number^3
 ;;^DIST(.404,.110108,40,2,1)
 ;;=.01
 ;;^DIST(.404,.110108,40,2,2)
 ;;=3,21^3^3,7
 ;;^DIST(.404,.110108,40,2,13)
 ;;=S:$$GET^DDSVAL(.114,.DA,.5) DIKCCRV=1
 ;;^DIST(.404,.110108,40,3,0)
 ;;=3^Subscript Number^3
 ;;^DIST(.404,.110108,40,3,1)
 ;;=.5
 ;;^DIST(.404,.110108,40,3,2)
 ;;=4,21^3^4,3
 ;;^DIST(.404,.110108,40,3,13)
 ;;=S:X=""!(DDSOLD="") DIKCCRV=1
 ;;^DIST(.404,.110108,40,4,0)
 ;;=5^Maximum Length^3
 ;;^DIST(.404,.110108,40,4,1)
 ;;=6
 ;;^DIST(.404,.110108,40,4,2)
 ;;=5,21^3^5,5
 ;;^DIST(.404,.110108,40,4,13)
 ;;=S:$$GET^DDSVAL(.114,.DA,.5) DIKCCRV=1
 ;;^DIST(.404,.110108,40,5,0)
 ;;=4^Lookup Prompt^3
 ;;^DIST(.404,.110108,40,5,1)
 ;;=8
 ;;^DIST(.404,.110108,40,5,2)
 ;;=4,48^30^4,33
 ;;^DIST(.404,.110108,40,6,0)
 ;;=6^Collation^3
 ;;^DIST(.404,.110108,40,6,1)
 ;;=7
 ;;^DIST(.404,.110108,40,6,2)
 ;;=5,48^9^5,37
 ;;^DIST(.404,.110108,40,8,0)
 ;;=7^Computed Code^3
 ;;^DIST(.404,.110108,40,8,1)
 ;;=4.5
 ;;^DIST(.404,.110108,40,8,2)
 ;;=7,18^60^7,3
 ;;^DIST(.404,.110108,40,8,4)
 ;;=1
 ;;^DIST(.404,.110108,40,8,14)
 ;;=I $G(DUZ(0))'="@" S DDSERROR=1 D HLP^DDSUTL($C(7)_"Only programmers are allowed to edit the Computed Code.")
 ;;^DIST(.404,.11021,0)
 ;;=DIKC EDIT UI MAIN^.11
 ;;^DIST(.404,.11021,40,0)
 ;;=^.4044I^9^9
 ;;^DIST(.404,.11021,40,1,0)
 ;;=1^File^3
 ;;^DIST(.404,.11021,40,1,1)
 ;;=.01
 ;;^DIST(.404,.11021,40,1,2)
 ;;=1,15^20^1,9
 ;;^DIST(.404,.11021,40,1,13)
 ;;=D BLDLOG^DIKCFORM(DA)
 ;;^DIST(.404,.11021,40,1,14)
 ;;=D VALFILE^DIKCFORM
 ;;^DIST(.404,.11021,40,2,0)
 ;;=2^Root File^3
 ;;^DIST(.404,.11021,40,2,1)
 ;;=.51
 ;;^DIST(.404,.11021,40,2,2)
 ;;=1,60^20^1,49
 ;;^DIST(.404,.11021,40,2,4)
 ;;=^^^1
 ;;^DIST(.404,.11021,40,3,0)
 ;;=3^Index Name^3
 ;;^DIST(.404,.11021,40,3,1)
 ;;=.02
 ;;^DIST(.404,.11021,40,3,2)
 ;;=2,15^30^2,3
 ;;^DIST(.404,.11021,40,3,13)
 ;;=D NAMECHG^DIKCFORM
 ;;^DIST(.404,.11021,40,3,14)
 ;;=D NAMEVAL^DIKCFORM
 ;;^DIST(.404,.11021,40,4,0)
 ;;=4^Root Type^3
 ;;^DIST(.404,.11021,40,4,1)
 ;;=.5
 ;;^DIST(.404,.11021,40,4,2)
 ;;=2,60^16^2,49
 ;;^DIST(.404,.11021,40,4,4)
 ;;=^^^1
 ;;^DIST(.404,.11021,40,5,0)
 ;;=5^Short Description^3
 ;;^DIST(.404,.11021,40,5,1)
 ;;=.11
 ;;^DIST(.404,.11021,40,5,2)
 ;;=4,20^60^4,1
 ;;^DIST(.404,.11021,40,5,11)
 ;;=D HLP^DDSUTL(X)
 ;;^DIST(.404,.11021,40,6,0)
 ;;=6^Description (wp)^3
 ;;^DIST(.404,.11021,40,6,1)
 ;;=.1
 ;;^DIST(.404,.11021,40,6,2)
 ;;=5,20^1^5,2
 ;;^DIST(.404,.11021,40,7,0)
 ;;=7^!M^1
 ;;^DIST(.404,.11021,40,7,.1)
 ;;=N WPROOT S WPROOT=$$GET^DDSVAL(.11,.DA,.1),Y=$S(WPROOT]"":$G(@WPROOT@(1,0)),1:""),Y=$S(Y]"":"["_$E(Y,1,56)_"]",1:"(empty)")
 ;;^DIST(.404,.11021,40,7,2)
 ;;=^^5,23
 ;;^DIST(.404,.11021,40,8,0)
 ;;=8^Set Logic^3
 ;;^DIST(.404,.11021,40,8,1)
 ;;=1.1
 ;;^DIST(.404,.11021,40,8,2)
 ;;=14,13^67^14,2
 ;;^DIST(.404,.11021,40,8,4)
 ;;=^^^2
 ;;^DIST(.404,.11021,40,8,11)
 ;;=D HLP^DDSUTL(X)
 ;;^DIST(.404,.11021,40,9,0)
 ;;=9^Kill Logic^3
 ;;^DIST(.404,.11021,40,9,1)
 ;;=2.1
 ;;^DIST(.404,.11021,40,9,2)
 ;;=15,13^67^15,1
 ;;^DIST(.404,.11021,40,9,4)
 ;;=^^^2
 ;;^DIST(.404,.11021,40,9,11)
 ;;=D HLP^DDSUTL(X)
 ;;^DIST(.404,.11022,0)
 ;;=DIKC EDIT UI HDR^.11
 ;;^DIST(.404,.11022,40,0)
 ;;=^.4044I^4^4
 ;;^DIST(.404,.11022,40,1,0)
 ;;=1^Number^4
 ;;^DIST(.404,.11022,40,1,2)
 ;;=1,9^15^1,1
 ;;^DIST(.404,.11022,40,1,30)
 ;;=S Y=DA
 ;;^DIST(.404,.11022,40,2,0)
 ;;=2^EDIT A UNIQUENESS INDEX^1
 ;;^DIST(.404,.11022,40,2,2)
 ;;=^^1,30
 ;;^DIST(.404,.11022,40,3,0)
 ;;=3^Page 1 of 1^1
 ;;^DIST(.404,.11022,40,3,2)
 ;;=^^1,69
 ;;^DIST(.404,.11022,40,4,0)
 ;;=4^-------------------------------------------------------------------------------^1
 ;;^DIST(.404,.11022,40,4,2)
 ;;=^^2,1
 ;;^DIST(.404,.11023,0)
 ;;=DIKC EDIT UI CRV^.114
 ;;^DIST(.404,.11023,40,0)
 ;;=^.4044I^4^4
 ;;^DIST(.404,.11023,40,1,0)
 ;;=1^^3^^ORDER
 ;;^DIST(.404,.11023,40,1,1)
 ;;=.01
 ;;^DIST(.404,.11023,40,1,2)
 ;;=1,3^3
 ;;^DIST(.404,.11023,40,1,4)
 ;;=^^^2
 ;;^DIST(.404,.11023,40,1,14)
 ;;=I X="" D HLP^DDSUTL($C(7)_"Deletion not allowed.") S DDSERROR=1
 ;;^DIST(.404,.11023,40,2,0)
 ;;=2^^3^^SUBSCRIPT
 ;;^DIST(.404,.11023,40,2,1)
 ;;=.5
 ;;^DIST(.404,.11023,40,2,2)
 ;;=1,12^3
 ;;^DIST(.404,.11023,40,2,4)
 ;;=^^^1
 ;;^DIST(.404,.11023,40,3,0)
 ;;=3^^3^^LENGTH

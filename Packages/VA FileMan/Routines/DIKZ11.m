DIKZ11 ;SFISC/DCM-XREF COMPILER ;9/3/93  13:44
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
OVFL ;
 S ^UTILITY($J,"OVFL",1)=DNM_0_" ; DRIVER FOR COMPILED XREFS FOR FILE !"_DH(1)_" (cont); "_$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3),^(2)=" ; "
 S ^UTILITY($J,0,7)=" I $D(DIKKS) D:DIKZ1=DH(1) "_$P(DIKGO,",")_" S DA=DIKUP D:DIKZ1=DH(1) "_$P(DIKGO,",",2)_" D:DIKZ1'=DH(1) KILL D:DIKZ1'=DH(1) DA D:DIKZ1'=DH(1) SET"_U_DNM_0_" D DA Q"
 S ^UTILITY($J,0,9)=" I $D(DIKST) D:DIKZ1=DH(1) "_$P(DIKGO,",",2)_" D:DIKZ1'=DH(1) SET"_U_DNM_0_" D DA Q"
 S ^UTILITY($J,0,17)=" S (DIKY,DA)=$O(^(DA)) G C:$P($G(^(DA,0)),U)']"""" S DU=1,DCNT=DCNT+1 S:DA="""" (DIKY,DA)=-1 D:DIKZ1=DH(1) "_$P(DIKGO,",",2)_" D:DIKZ1'=DH(1) SET"_U_DNM_0_" D:DIKZ1'=DH(1) DA K DB(0) S DA=DIKY G C"
 F DIKZZ=0:0 S DIKZZ=$O(^UTILITY($J,0,DIKZZ)) Q:DIKZZ=""  S %=^(DIKZZ) I $E(%,1,4)="SET " D OVFL1 Q
 Q
OVFL1 S DIKZZ1=4,^UTILITY($J,"OVFL",DIKZZ1)=% K ^UTILITY($J,0,DIKZZ)
 F  S DIKZZ=$O(^UTILITY($J,0,DIKZZ)) Q:DIKZZ=""  S %=^(DIKZZ) Q:$E(%,1,5)="KIL1 "  S DIKZZ1=DIKZZ1+1,^UTILITY($J,"OVFL",DIKZZ1)=% K ^UTILITY($J,0,DIKZZ)
 Q

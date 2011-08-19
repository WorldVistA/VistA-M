ESPXREF ;DALISC/CKA - SOUNDEX;10/92
 ;;1.0;POLICE & SECURITY;;Mar 31, 1994
 S ESPSOUN=$$SOUN^ESPSOUN($P(X,","))_$$SOUN^ESPSOUN($E($P(X,",",2),1,3))
 QUIT
LAYGO ;Called from ^DD(910,.01,"LAYGO",1,0);extracted from Kernel routine XUA4A7
 Q:DIC(0)'["E"
 W !,"Checking SOUNDEX for matches."
 N XU1,XU2,XU3 S XU3=X
 S X=$$SOUN^ESPSOUN($P(XU3,","))_$$SOUN^ESPSOUN($E($P(XU3,",",2),1,3)),XU2=0 ;D ^ESPSOUN
 F XU1=0:0 S XU1=$O(^ESP(910,"SOUN",X,XU1)) Q:XU1'>0  W !?5,$P($G(^ESP(910,XU1,0)),"^") S XU2=XU2+1
 I 'XU2 W !,"No matches found." S XU2=1 G L3
L2 R !,"Do you still want to add this entry: NO//",XU2:DTIME S:'$T ESPOUT=1  S XU2=$TR($E(XU2_"N"),"NnYy^?","00110?")
 I "01"'[XU2 W !?4,"Answer NO to stop the addition of ",XU3," as a new master name index person.",!?4,"Answer YES to add, a '^' will be taken as a NO." G L2
L3 S X=XU2
 QUIT

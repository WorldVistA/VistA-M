RGUTIN ;CAIRO/DKM - Platform specific inits;04-Sep-1998 11:26;DKM
 ;;2.1;RUN TIME LIBRARY;;Mar 22, 1999
 ;=================================================================
 N RGOS,RGD,RGH,X
 S U="^",X="ERROR^RGUTIN",@^%ZOSF("TRAP"),RGOS=$P(^%ZOSF("OS"),U,2)
 I 'RGOS D
 .D HOME^%ZIS,TITLE^RGUT("RTL Platform-specific Inits",1.6)
 .S RGD(1)="$$TEST^RGUTIN(""RGUTIN""_%S)"
 .S RGH(1)="Enter the name of this MUMPS environment for the RG-namespace"
 .S RGH(2)="platform-specific initialization process."
 .S RGOS=$$ENTRY^RGMSCLKP("^DD(""OS"")","UX","Operating System: ","B","*","RGD","",0,5,"","","HELP(.RGH)")
 .W !!
 D:RGOS>0 INIT(RGOS)
 Q
INIT(RGOS) ;
 N I,X,Y,Z
 S X="RGUTIN"_RGOS,I=0
 I '$$TEST(X) D  Q
 .X "ZL RGUTOS1 ZS RGUTOS"
 .W !!,"Init not found for specified OS. Will use generic init.",!!
 K ^TMP($J)
 F Z=0,RGOS F X=$S(Z:3,1:1):1 S Y=$T(+X^@("RGUTIN"_Z)) Q:Y=""  S I=I+1,^TMP($J,I)=Y
 S $P(^TMP($J,1),";")="RGUTOS "
 X "ZR  F Z=1:1:I ZI ^TMP($J,Z) ZS:Z=I RGUTOS"
 W !!,"Initialization completed for "_$P(^DD("OS",RGOS,0),"^")_" operating system.",!!
 K ^TMP($J)
 Q
TEST(X) X ^%ZOSF("TEST")
 Q $T
ERROR W !!,"An error has occurred during initialization.",!
 Q

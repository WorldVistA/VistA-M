ECX314PT ;ALB/JAP - PATCH ECX*3*14 Post-Install ; October 26, 1998
 ;;3.0;DSS EXTRACTS;**14**;Dec 22, 1997
 ;
POST ;Entry point
 N FILE,SPACE,BLANK,LAST
 ;get rid of index junk on file #727.826
 K ^ECX(727.826,"B"),^DD(727.826,.01,1,1),^DD(727.826,0,"IX","B",727.826,.01)
 K ^ECX(727.826,"AINV"),^DD(727.826,.01,1,2),^DD(727.826,0,"IX","AINV",727.826,.01)
 K ^DD(727.826,0,"IX","AG1",727.826,8),^DD(727.826,0,"IX","AG2",727.826,14),^DD(727.826,0,"IX","AG3",727.826,32)
 K ^DD(727.826,8,1,1),^DD(727.826,14,1,1),^DD(727.826,32,1,1)
 ;remove the ainv index on extract files #727.802-#727.825
 F I=.802,.803,.804,.805,.806,.808,.809,.81,.811,.813,.814,.815,.817,.819,.823,.824,.825 D
 .S FILE=727+I
 .W !!,"Deleting ""AINV"" index on file #"_FILE_"."
 .K ^DD(FILE,0,"IX","AINV",FILE,.01)
 .K ^DD(FILE,.01,1,1)
 .K ^ECX(FILE,"AINV")
 ;update each file description on all extract files
 F I=.802,.803,.804,.805,.806,.808,.809,.81,.811,.813,.814,.815,.817,.819,.823,.824,.825,.826 D
 .S FILE=727+I
 .W !!,"Updating Description for File #"_FILE_"."
 .S BLANK=0,LAST=$O(^DIC(FILE,"%D",""),-1)
 .F N=1:1:LAST I $D(^DIC(FILE,"%D",N))  D  Q:BLANK>0
 ..S X=^DIC(FILE,"%D",N,0),XX=$L(X),SPACE=0
 ..F J=1:1:XX S CHAR=$E(X,J) S:$A(CHAR)'=32 SPACE=SPACE+1
 ..I SPACE=0 S BLANK=N
 .F N=BLANK+1:1:LAST K ^DIC(FILE,"%D",N,0)
 .S N=BLANK
 .F ECX=1:1 S ECXX=$P($T(ALL+ECX),";;",2) Q:ECXX="QUIT"  D
 ..S N=N+1,^DIC(FILE,"%D",N,0)=ECXX
 .S $P(^DIC(FILE,"%D",0),U,3)=N,$P(^DIC(FILE,"%D",0),U,4)=N,$P(^DIC(FILE,"%D",0),U,5)=DT
 Q
 ;
ALL ;update file description for all files 
 ;;Since validation techniques will be determined by the local site, it is
 ;;intended that the site add whatever cross references deemed necessary.
 ;;However, this file contains one nationally determined cross reference,
 ;;the "AC" cross reference on the EXTRACT NUMBER field (#2).  This cross
 ;;reference is used by the DSS Extracts software package as an essential
 ;;feature for managing and purging data in this file and should not be
 ;;modified.
 ;;  
 ;;This file should NOT be modified directly using VA FileMan.  
 ;;QUIT

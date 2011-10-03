RA95PST ;Hines OI/SWM - Post-init, patch 95 ;09/29/08 09:45
 ;;5.0;Radiology/Nuclear Medicine;**95**;Mar 16, 1998;Build 7
 Q
EN ;Clean up "ASTF" and "ARES" from deleted reports that are caused
 ;by patch 56
 N A,I,I1,J,RA,RAPS,RAPR,RASS,RASR,X
 D EN^DDIOL("Searching deleted reports' left-over ""ASTF"" and ""ARES"" xrefs...",,"!,?6")
 D EN^DDIOL("",,"!")
 S (I,J)=0
 F  S I=$O(^RARPT("ASTAT","X",I)) Q:'I  D
 .Q:$P(^RARPT(I,0),"^",5)'="X"  ;quit if report status isn't "X"
 .S X=$O(^RARPT(I,"L",""),-1) Q:'X
 .S RA=^RARPT(I,"L",X,0) Q:RA=""
 .S RAPS=$P(RA,"^",7) ;Primary Staff
 .S RAPR=$P(RA,"^",9) ;Primary Resident
 .S A=$NA(^RARPT("ASTF",+RAPS,I)) D CHECK
 .S A=$NA(^RARPT("ARES",+RAPR,I)) D CHECK
 .I $O(^RARPT(I,"L",X,"DELSTF",0)) S I1=0 D  ;Secondary Staff
 ..F  S I1=$O(^RARPT(I,"L",X,"DELSTF","B",I1)) Q:'I1  D
 ...S A=$NA(^RARPT("ASTF",I1,I)) D CHECK
 ...Q
 ..Q
 .I $O(^RARPT(I,"L",X,"DELRES",0)) S I1=0 D  ;Secondary Residents
 ..F  S I1=$O(^RARPT(I,"L",X,"DELRES","B",I1)) Q:'I1  D
 ...S A=$NA(^RARPT("ARES",I1,I)) D CHECK
 ...Q
 ..Q
 .Q
 I 'J D EN^DDIOL("No left-over ""ASTF"" and ""ARES"" to delete",,"!!,?6")
 D EN^DDIOL("",,"!")
 Q
CHECK ; If xref exists, then kill it
 I $D(@A)#2 K @A D DISPLAY S J=J+1
 Q
DISPLAY ;
 D EN^DDIOL(A_" erased from database",,"!,?6")
 Q

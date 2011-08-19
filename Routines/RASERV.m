RASERV ;HISC/CAH,FPT,GJC AISC/MJK,DMK-Finds Service, Ward, Bedsection of Inpatient ;9/12/94  11:48
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 Q:'$D(RADFN)  S DFN=RADFN,VA200=1 I $D(RADTE),RADTE S VAIP("D")=RADTE
 D IN5^VADPT G Q:VAIP(1)=""
 S RASER=$P(VAIP(8),"^",2),RAWD=""
 S RATS=+$P(VAIP(8),"^"),RAWARD=$P(VAIP(5),"^",2)
 I VAIP(5)]"" S RAWD=^DIC(42,+VAIP(5),0)
 I '$D(^DIC(45.7,RATS,0)) D SER G Q
 S RATS=^DIC(45.7,RATS,0) S RASER=$S($D(^DIC(49,+$P(RATS,"^",4),0)):$P(^(0),"^"),1:"Unknown") S:$D(^DIC(42.4,+$P(RATS,"^",2),0)) RABED=$P(^(0),"^")
Q K RADMI,RAWD,RADM,RANOW,RATRN,RATS,RATSD,RATSI,VA200,VAERR,VAIP
 Q
SER ; Define Service/Section
 S X=$$EXTERNAL^DILFD(42,.03,"",$P(RAWD,"^",3)) S:X']"" X="UNKNOWN"
 S X=$O(^DIC(49,"B",X,0)),RASER=$S($D(^DIC(49,+X,0)):$P(^(0),"^"),1:"Unknown")
 Q

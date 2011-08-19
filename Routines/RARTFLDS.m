RARTFLDS ;HISC/CAH,FPT,GJC AISC/MJK-Computed fields on Reports(#74) file ;4/19/96  08:44
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
1 S X="" Q:'$D(D0)!('$D(^RARPT(D0,0)))  S RAX=^(0),RARPT=D0,RADFN=$P(RAX,"^",2),RADTI=9999999.9999-$P(RAX,"^",3),RACN=$P(RAX,"^",4) G Q:RACN']"" S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P","B",RACN,0)) G Q:RACNI'>0
 S RAX=$S($D(^RADPT(RADFN,"DT",RADTI,0)):^(0),1:0) G Q:'RAX
 S RAY3=$S($D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)):^(0),1:0) G Q:'RAY3
 N RA1 S RA1=$O(^RARPT(D0,1,"B",""))
 G @RAEXFLD
 ;
ALL S X=RAY3 G Q
PROC S X=$S($D(^RAMIS(71,+$P(RAY3,"^",2),0)):$P(^(0),"^"),1:"") D MEMSET G Q
EXAM S X=$S($D(^RA(72,+$P(RAY3,"^",3),0)):$P(^(0),"^"),1:"") D MEMSET G Q
CAT S X=$S($P(RAY3,"^",4)']"":"",1:$P($P(^DD(70.03,4,0),$P(RAY3,"^",4)_":",2),";")) G Q
WARD S X=$S($D(^DIC(42,+$P(RAY3,"^",6),0)):$P(^(0),"^"),1:"") G Q
SERV S X=$S($D(^DIC(49,+$P(RAY3,"^",7),0)):$P(^(0),"^"),1:"") G Q
CLINIC S X=$S($D(^SC(+$P(RAY3,"^",8),0)):$P(^(0),"^"),1:"") G Q
CONT S X=$S($D(^DIC(34,+$P(RAY3,"^",9),0)):$P(^(0),"^"),1:"") G Q
RSCH S X=$S($D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"R")):^("R"),1:"") G Q
RES S X=$S($D(^VA(200,+$P(RAY3,"^",12),0)):$P(^(0),"^"),1:"") D MEMSET G Q
DIAG S X=$S($D(^RA(78.3,+$P(RAY3,"^",13),0)):$P(^(0),"^"),1:"") D MEMSET G Q
PHY S X=$S($D(^VA(200,+$P(RAY3,"^",14),0)):$P(^(0),"^"),1:"") G Q
STAFF S X=$S($D(^VA(200,+$P(RAY3,"^",15),0)):$P(^(0),"^"),1:"") D MEMSET G Q
COMP S X=$S($D(^RA(78.1,+$P(RAY3,"^",16),0)):$P(^(0),"^"),1:"") D MEMSET G Q
EXRM S X=$S($D(^RA(78.6,+$P(RAY3,"^",18),0)):$P(^(0),"^"),1:"") G Q
BED S X=$S($D(^DIC(42.4,+$P(RAY3,"^",19),0)):$P(^(0),"^"),1:"") G Q
TECH S X="" I $O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"TC",0))>0,$D(^VA(200,+^($O(^(0)),0),0)) S X=$P(^(0),"^")
 G Q
LOC S X=$S('$D(^RA(79.1,+$P(RAX,"^",4),0)):"",$D(^SC(+^(0),0)):$P(^(0),"^"),1:"") G Q
DIV S X=$S($D(^DIC(4,+$P(RAX,"^",3),0)):$P(^(0),"^"),1:"") G Q
 ;
Q K RADFN,RADTI,RACNI,RAX,RAY3 Q
 ;
FLD(D0,RAEXFLD) ; 
 N RACN,RACNI,RADFN,RADTI,RARPT,RAX,RAY3,X
 D RARTFLDS
 Q X
MEMSET ;insert  +   infront of value if this record is a member of a print set
 S:RA1]"" X="+"_X Q

AXVRTN ;10N20/MAH ; Routine checker ; 11/12/2004
 ;;1.0;AXVRTN - VISN20 APPLICATION;**1**;11/16/2004
 ;Cache Objects and Classes
 ;class for apps
 ;##class(visn.vApps)
 ;properties - AppsName
 ;hold the national application names
 ;class for routine
 ;##class(visn.vRoutine)
 ;properties - RtnApps
 ;properties - RtnName
 ;properties - RtnPatch
 ;Properties - RtnVersion
 ;Properties - RntCksum
 ;Properties - RntSize
 ;hold the national/local routines within vista
CLN N X
 ;S X=0 F  S X=$O(^visn.vRoutineD(X)) Q:X'>0  D ##CLASS(visn.vRoutine).%DeleteId(X)
 K X
 ;S ##CLASS(visn.vRoutine).%New(1)=""
STR ;Clean up globel than run the build
 S SL=0
 N APP,RN,PAT,VERION,X,SIZE,CLSUM,APPID
 S RNT="B"
 F  S RNT=$O(^ROUTINE(""_RNT_"")) Q:RNT=""  D
 .Q:'($E(RNT)?1U)
 .I $D(^ROUTINE(RNT,0,2)) S SL=$P($G(^ROUTINE(RNT,0,2)),"^",1) I SL'[";;" Q
 .I $D(^ROUTINE(RNT,0,"SIZE")) S SIZE=$P($G(^ROUTINE(RNT,0,"SIZE")),"^",1)
 .S RSUM="ZL @X S Y=0 F %=1,3:1 S %1=$T(+%),%3=$F(%1,"" "") Q:'%3  S %3=$S($E(%1,%3)'="";"":$L(%1),$E(%1,%3+1)="";"":$L(%1),1:%3-2) F %2=1:1:%3 S Y=$A(%1,%2)*(%2+%)+Y"
 .S X=RNT X RSUM S CLSUM=Y K X
 .S VERSION=$P(SL,";",3)
 .S PACKAGE=$P(SL,";",4) I PACKAGE="" S PACKAGE="UNKNOWN"
 .S PACKAGE=($TR(PACKAGE,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ"))
 .S PAT=$P(SL,";",5)
 .S PAT=$TR(PAT,"**","")
 .S SL=0
 .;S RNTID=$O(^visn.vRoutineI("RtnNameIndex",RNT,0))
 .;I RNTID'>0 S RN=##CLASS(visn.vRoutine).%New()  ; add new record because it isn't there 
 .;E  S RN=##CLASS(visn.vRoutine).%OpenId(RNTID)  ;it here so your bring into memory
 .;S RN.RtnName=RNT
 .;S RN.RtnVersion=VERSION
 .;S RN.RtnPatch=PAT
 .;S RN.RtnCksum=CLSUM
 .;S RN.RtnSize=SIZE
 .;S RN.RtnApplication=PACKAGE
 .;Do RN.%Save()
 .;Do RN.%Close()
 .W !,RNT_"^"_VERSION_"^"_PAT_"^"_CLSUM_"^"_PACKAGE
 .K RN
 .Q
EXIT K SIZE,SL,RNT,VERSION,PACKAGE,PAT,RN,APP,CLSUM,RSUM,Y
 Q

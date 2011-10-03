XUMF333 ;OIFO-OAK/RAM - Add HCS data types ;02/21/02
 ;;8.0;KERNEL;**335**;Jul 10, 1995
 ;
 Q
 ;
 ;
POST ; -- post installation XU*8*333
 ;
 N XUMF,IENS,IEN,FDA,I,HCS,XXX
 ;
 S XUMF=1
 ;
 D KM,KM1,KM2,KM3,STUFF
 ;
 Q
 ;
KM ; -- add XUMF IMF EDIT STATUS to XUKERNEL
 ;
 N X,Y
 ;
 S X=$$FIND1^DIC(19,,"B","XUKERNEL")
 S Y="?+1,"
 ;
 S IENS=Y_X_","
 S FDA(19,"?1,",.01)="XUKERNEL"
 S FDA(19.01,"?+2,?1,",.01)="XUMF IMF EDIT STATUS"
 D UPDATE^DIE("","FDA")
 ;
 Q
 ;
KM1 ; -- add XUMF IMF EDIT STATUS to XUKERNEL
 ;
 N X,Y
 ;
 S X=$$FIND1^DIC(19,,"B","XUKERNEL")
 S Y="?+1,"
 ;
 S IENS=Y_X_","
 S FDA(19,"?1,",.01)="XUKERNEL"
 S FDA(19.01,"?+3,?1,",.01)="XUMF LOAD INSTITUTION"
 D UPDATE^DIE("","FDA")
 ;
 Q
 ;
KM2 ; -- add XUMF IMF EDIT STATUS to XUKERNEL
 ;
 N X,Y
 ;
 S X=$$FIND1^DIC(19,,"B","XUKERNEL")
 S Y="?+1,"
 ;
 S IENS=Y_X_","
 S FDA(19,"?1,",.01)="XUKERNEL"
 S FDA(19.01,"?+3,?1,",.01)="Patch XU*8*335 clean 4.1 and 4"
 D UPDATE^DIE("","FDA")
 ;
 Q
 ;
KM3 ; -- remove XUMF333 clean 4.1 and 4 if present
 ;
 N X,IENS,FDA
 ;
 S X=$$FIND1^DIC(19,,"B","XUMF333 clean 4.1 and 4")
 ;
 Q:'X
 ;
 S IENS=X_","
 S FDA(19,IENS,.01)="@"
 D UPDATE^DIE("","FDA")
 ;
 Q
 ;
STUFF ;
 ;
 S IEN=$O(^DIC(4.1,"B","HCS",0))
 S IENS=$S(IEN:IEN_",",1:"+1,")
 K FDA
 S FDA(4.1,IENS,.01)="HCS"
 S FDA(4.1,IENS,1)="HEALTH CARE SYSTEM"
 S FDA(4.1,IENS,3)="LOCAL"
 D UPDATE^DIE("E","FDA")
 ;
 S HCS=""
 F XXX=1:1 D  Q:HCS=""
 .S HCS=$P($T(HCS+XXX),";;",2)
 .S IEN=$S(HCS="":0,1:$O(^DIC(4,"B",HCS,0)))
 .S IENS=$S(IEN:IEN_",",1:"+1,")
 .;
 .K FDA
 .S FDA(4,IENS,.01)=HCS
 .S FDA(4,IENS,11)="LOCAL"
 .S FDA(4,IENS,13)="HCS"
 .D UPDATE^DIE("E","FDA")
 ;
 Q
 ;
HCS ;
 ;;VA GREATER LOS ANGELES (691)
 ;;VA HEARTLAND-EAST VISN15 (657)
 ;;VA HEARTLAND-WEST VISN15 (589)
 ;;VA CHICAGO HSC (537)
 ;;CENTRAL PLAINS NETWORK (636)
 ;;MONTANA HCS (436)
 ;;VA PACIFIC ISLANDS HCS (459)
 ;;NEW MEXICO HCS (501)
 ;;AMARILLO HCS (504)
 ;;MARYLAND HCS (512)
 ;;WEST TEXAS HCS (519)
 ;;BOSTON HCS (523)
 ;;UPSTATE NEW YORK HCS (528)
 ;;NORTH TEXAS HCS (549)
 ;;EASTERN COLORADO HCS (554)
 ;;NEW JERSEY HCS (561)
 ;;BLACK HILLS HCS (568)
 ;;CENTRAL CALIFORNIA HCS (570)
 ;;N FLORIDA/S GEORGIA HCS (573)
 ;;GREATER NEBRASKA HCS (597)
 ;;CENTRAL ARKANSAS HCS (598)
 ;;LONG BEACH HCS (600)
 ;;CENTRAL ALABAMA HCS (619)
 ;;HUDSON VALLEY HCS VAMC (620)
 ;;TENNESSEE VALLEY HCS (626)
 ;;PALO ALTO HCS (640)
 ;;PITTSBURGH HCS (646)
 ;;ROSEBURG HCS (653)
 ;;SIERRA NEVADA HCS (654)
 ;;SALT LAKE CITY HCS (660)
 ;;PUGET SOUND HCS (663)
 ;;SAN DIEGO HCS (664)
 ;;SOUTH TEXAS HCS (671)
 ;;CENTRAL TEXAS HCS (674)
 ;;EASTERN KANSAS HCS (677)
 ;;SOUTHERN ARIZONA VA HCS (678)
 ;;CONNECTICUT HCS (689)
 ;;EL PASO VA HCS (756)
 ;;NEW YORK HHS (630)
 ;
 ; do not include
 ;;EASTERN COLORADO HCS (554A4)
 ;;SOUTHERN COLORADO HCS
 ;;CENTRAL IOWA HCS (555)
 ;;ILLIANA HCS (550)
 ;;NORTHERN CALIFORNIA HCS (612)
 ;;SOUTHERN NEVADA HCS (593)
 ;;NORTHERN ARIZONA HCS (649)
 ;
 Q
 ;
CHK ; -- check site updating required
 ;
 N STA,IEN,FLAG,CHK
 ;
 S STA=$$STA^XUAF4(+$G(DUZ(2)))
 ;
 I STA="" W !!,"DUZ not defined.  Please log on." Q
 ;
 W @IOF,!,STA," ",$P($$NS^XUAF4(+DUZ(2)),U)
 ;
 S CHK=$$INST^XUMF333(+DUZ(2),.ERR)
 I CHK=1 D
 .W !!?5,"MISSING DATA - please fix",!
 .S I=0 F  S I=$O(ERR("FATAL",I)) Q:'I  D
 ..W !?5,ERR("FATAL",I)
 I CHK'=1 W " is okay"
 ;
 S STA=STA_"A"
 F  S STA=$O(^DIC(4,"D",STA)) Q:STA=""  D  Q:$G(FLAG)
 .I $E($$STA^XUAF4(DUZ(2)),1,3)'=$E(STA,1,3) S FLAG=1 Q
 .S IEN=$$IEN^XUAF4(STA)
 .S CHK=$$INST^XUMF333(+IEN,.ERR)
 .W !!,STA," ",$P($$NS^XUAF4(+IEN),U)
 .I CHK'=1 W " is okay" Q
 .I CHK=1 D
 ..W " is MISSING DATA - please fix",!
 ..S I=0 F  S I=$O(ERR("FATAL",I)) Q:'I  D
 ...W !?5,ERR("FATAL",I)
 .K ERR
 ;
 ;
 Q
 ;
INST(IEN,ERR) ; -- validate Institution entry FALSE=valid
 ;
 Q:'$G(IEN) "IEN null"
 ;
 S CNT=1
 ;
 D ZERO(IEN,.ERR,.CNT)
 D ADD1(IEN,.ERR,.CNT)
 D ADD2(IEN,.ERR,.CNT)
 D FTYP(IEN,.ERR,.CNT)
 D ND99(IEN,.ERR,.CNT)
 ;
 Q $S($D(ERR("FATAL")):1,$D(ERR("WARNING")):2,1:0)
 ;
ZERO(IEN,ERR,CNT) ; -- zero node
 ;
 N X
 ;
 S CNT=$G(CNT) S:'CNT CNT=1
 ;
 S X=$G(^DIC(4,+IEN,0))
 I $P(X,U,2)="" D
 .S ERR("FATAL",CNT)="STATE is missing",CNT=CNT+1
 ;
 Q
 ;
ADD1(IEN,ERR,CNT) ; -- address node
 ;
 N X,I
 ;
 S CNT=$G(CNT) S:'CNT CNT=1
 ;
 S X=$G(^DIC(4,+IEN,1))
 I $P(X,U,1)="" D
 .S ERR("FATAL",CNT)="Physical address St. line 1 missing"
 .S CNT=CNT+1
 I $P(X,U,3)="" D
 .S ERR("FATAL",CNT)="Physical address City missing"
 .S CNT=CNT+1
 I $P(X,U,4)="" D
 .S ERR("FATAL",CNT)="Physical address ZIP missing"
 .S CNT=CNT+1
 I $P(X,U,2)="" D
 .S ERR("WARNING",CNT)="Physical address St. line 2 missing"
 .S CNT=CNT+1
 ;
 Q
 ;
ADD2(IEN,ERR,CNT) ; -- mailing address node
 ;
 N X,I
 ;
 S CNT=$G(CNT) S:'CNT CNT=1
 ;
 S X=$G(^DIC(4,+IEN,4))
 I $P(X,U,1)="" D
 .S ERR("FATAL",CNT)="Mailing address St. line 1 missing"
 .S CNT=CNT+1
 I $P(X,U,3)="" D
 .S ERR("FATAL",CNT)="Mailing address City missing"
 .S CNT=CNT+1
 I $P(X,U,4)="" D
 .S ERR("FATAL",CNT)="Mailing address State missing"
 .S CNT=CNT+1
 I $P(X,U,5)="" D
 .S ERR("FATAL",CNT)="Mailing address ZIP missing"
 .S CNT=CNT+1
 I $P(X,U,2)="" D
 .S ERR("WARNING",CNT)="Mailing address St. line 2 missing"
 .S CNT=CNT+1
 ;
 Q
 ;
FTYP(IEN,ERR,CNT) ; -- facility type node
 ;
 N X
 ;
 S CNT=$G(CNT) S:'CNT CNT=1
 ;
 S X=$G(^DIC(4,+IEN,3))
 I 'X D
 .S ERR("FATAL",CNT)="FACILITY TYPE is missing",CNT=CNT+1
 I $P($G(^DIC(4.1,+X,0)),U,4)'="N" D
 .S ERR("FATAL",CNT)="FACILITY TYPE is not NATIONAL",CNT=CNT+1
 ;
 Q
 ;
ND99(IEN,ERR,CNT) ; -- 99 node
 ;
 N X
 ;
 S CNT=$G(CNT) S:'CNT CNT=1
 ;
 S X=$G(^DIC(4,+IEN,99))
 I $P(X,U,3)="" D
 .S ERR("FATAL",CNT)="OFFICIAL VA NAME is missing",CNT=CNT+1
 I ($P(X,U,4))&($E($$NS^XUAF4(+IEN),1,2)'="ZZ") D
 .S ERR("FATAL",CNT)="Inactive facility NAME not ZZ'd",CNT=CNT+1
 ;
 Q
 ;
C4 ; -- clean up Institution file
 ;
 D RIP,CFTYP,GET
 ;
 Q
 ;
RIP ; -- remove from all inactive and local the associations visn & parent
 ;
 N IEN
 ;
 S IEN=0
 F  S IEN=$O(^DIC(4,IEN)) Q:'IEN  D
 .I $P($G(^DIC(4,+IEN,0)),U,11)="N",'$P($G(^DIC(4,+IEN,99)),U,4) Q
 .D IFF^XUMF333(IEN)
 ;
 Q
 ;
IFF(IEN) ; -- inactive facility remove VISN and parent association
 ;
 N FDA,IENS,XUMF
 ;
 S XUMF=1
 ;
 S IENS="1,"_IEN_","
 S FDA(4.014,IENS,.01)="@"
 S IENS="2,"_IEN_","
 S FDA(4.014,IENS,.01)="@"
 D FILE^DIE("E","FDA")
 ;
 Q
 ;
CFTYP ; - clean 4.1
 ;
 N FDA,IENS,XUMF,IEN
 ;
 M ^TMP("XUMF 4.1",$J)=^DIC(4.1)
 ;
 S XUMF=1
 ;
 S IEN=0
 F  S IEN=$O(^DIC(4.1,IEN)) Q:'IEN  D
 .S IENS=IEN_","
 .K FDA
 .S FDA(4.1,IENS,.01)="@"
 .D FILE^DIE("E","FDA")
 ;
 S IEN=0
 F  S IEN=$O(^DIC(4,IEN)) Q:'IEN  D
 .S IENS=IEN_","
 .K FDA
 .S FDA(4,IENS,13)="@"
 .D FILE^DIE("E","FDA")
 ;
 Q
 ;
GET ; -- get Institution Master File (IMF) and Facility Types
 ;
 W !!,"...getting Facility Types - wait please 5 min..."
 D LOAD^XUMF(4.1)
 W !!,"...getting Institutions - wait please 10 min..."
 D LOAD^XUMF(4)
 ;
 Q
 ;
SCN(IEN,XUMF) ; screen out HCS entries
 ;
 ; IEN = Institution Internal Entry Number to check
 ;
 S XUMF=$G(XUMF) Q:XUMF 1
 ;
 I $O(^DIC(4.1,"B","HCS",0))=+$G(^DIC(4,+IEN,3)) Q 0
 ;
 Q 1
 ;

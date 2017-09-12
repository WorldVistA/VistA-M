IBY232PR ;ALB/TMK - IB*2*232 PRE-INSTALL ;12-AUG-03
 ;;2.0;INTEGRATED BILLING;**232**;21-MAR-94
 ;
 N DIC,DIK,DA,Y,X,IBY
 D BMES^XPDUTL("Pre-Installation Updates")
 ;
COPY ; BUILD SWITCH BACK GLOBAL TO CHANGE BACK TO OLD FORMAT
 ;
 ; ^XTMP("P232",DIR,INC,NODE,...
 ; DIR = ONLY 1 NOW
 ; INC = INCREMENT OF INSTALL
 ;
 ; D PRECOPY^IBY232PO
 ;
 ; Delete local ov-rides
 D BMES^XPDUTL("Removing local fields that reference changed EDI fields")
 D DELLOC^IBY232PO
 ; Chk for MCH domain
 D BMES^XPDUTL("CHECKING FOR REQUIRED DOMAIN")
 I $$PROD^IBCORC D  Q:$G(XPDABORT)
 . S X="Q-MCH.DOMAIN.EXT",DIC="^DIC(4.2,",DIC(0)="Z" D ^DIC ; DBIA 3779
 . M IBY=Y
 . I IBY>0 D
 .. S X="`"_$P(IBY(0),U,3),DIC="^DIC(4.2,",DIC(0)="Z" D ^DIC
 .. S $P(IBY(0),U,3)=$P(Y,U,2)
 . I $S(IBY'>0:1,1:$P(IBY(0),U,2)'="S"!($P(IBY(0),U,3)'="FOC-AUSTIN.DOMAIN.EXT")) D
 .. D BMES^XPDUTL("Q-MCH.DOMAIN.EXT DOMAIN MISSING/INVALID - ADD/CORRECT ENTRY AND RESTART INSTALL")
 .. D BMES^XPDUTL("REFERENCE MAILMAN PATCH XM*DBA*162 FOR ENTRY SET UP DETAILS")
 .. S XPDABORT=1
 ;
 ; REMOVE OLD ENTRIES WE CHANGED TO PREVENT REPLICATION
 N IB01,TAG,Z1,LVL,DIK,DIE,DR,DA,X,Y
 S IB01="N-ALL CUR/OTH PROVIDER INFO"
 I $P($G(^IBA(364.5,312,0)),U)'=IB01 S DA=312,DIE="^IBA(364.5,",DR=".01////^S X=IB01" D ^DIE
 I '$D(^IBA(364.6,"ASEQ",8,177,1,10)) D
 . N Z,Z0,DA,DIE,DR,DIK,X,Y
 . I $O(^IBA(364.6,"ASEQ",8,177,1,1.9,0)) S Z0=+$O(^(0)) D
 .. I $O(^IBA(364.7,"B",Z0,0)) S DA=+$O(^(0)),DIK="^IBA(364.7," D ^DIK
 .. S DA=Z0,DIK="^IBA(364.6," D ^DIK
 . S Z="" F  S Z=$O(^IBA(364.6,"ASEQ",8,177,1,Z),-1) Q:Z<2  S DA=+$O(^IBA(364.6,"ASEQ",8,177,1,Z,0)) I DA S DIE="^IBA(364.6,",DR=".08////"_(Z+1) D ^DIE D
 .. S Z0=+$O(^IBA(364.7,"B",DA,0)) I Z0 S DIE="^IBA(364.7,",DA=+Z0,DR=".03////312" D ^DIE
 ;
 ;DELETE 364.X ENTRIES IN BLD
 N LVL
 F LVL=5:1:7 D
 . F Z=2:1 S TAG="ENT"_LVL_"+"_Z Q:$P($T(@TAG),";;",2)=""  D
 . . S Z0=$P($T(@TAG),";;",2) D
 . . . F Z1=2:1:$L(Z0,U)-1 D
 . . . . S DA=$P(Z0,U,Z1)
 . . . . S DIK="^IBA(364."_LVL_","
 . . . . I DA,$D(^IBA("364."_LVL,DA,0)) D ^DIK
 ;
 N DIK,DA,DIE,DR,X,Y,FILE,Z,CT,IBINS
 D BMES^XPDUTL("Prepare entries in file 364.5 for changes")
 I $D(^IBA(364.5,269)) S DIK="^IBA(364.5,",DA=269 D ^DIK
 D BMES^XPDUTL("Prepare entries in file 364.6 for changes")
 I $D(^IBA(364.6,94,0)) S DIE="^IBA(364.6,",DA=94,DR=".1////DIAGNOSIS CODE 1" D ^DIE
 ;
 D BMES^XPDUTL("Delete entry IB315 from IB ERROR file")
 S X="IB315",DIC(0)="",DIC="^IBE(350.8," D ^DIC
 I Y>0 S DA=+Y,DIK="^IBE(350.8," D ^DIK
 D BMES^XPDUTL("Delete old cross references and data for fields changed in file 36")
 I '$$FLDNUM^DILFD(36,"DELETE 2006 4.04") D  ; Only do this on initial install
 . S Z=0 F  S Z=$O(^DIC(36,Z)) Q:'Z  S DR="4.01///@;4.02///@;4.03///@;4.04///@;4.05///@;4.06///@;4.07///@;4.08///@;4.1///@;4.11///@",DIE="^DIC(36,",DA=Z D ^DIE
 . ;
 . F DA=4.01,4.02,4.03 S DIK="^DD(36,",DA(1)=36 I $$VFIELD^DILFD(36,DA) D ^DIK
 ;
 D BMES^XPDUTL("Delete fields that were modified by this patch in file 399")
 S DA=232,DIK="^DD(399,",DA(1)=399 I $$VFIELD^DILFD(399,232) D ^DIK
 F DA=.02,.05,.06,.07,.09,.1,.11,.12,.13,.14,1.01,1.02,1.03 S DIK="^DD(399.0222,",DA(1)=399.0222 I $$VFIELD^DILFD(399.0222,DA) D ^DIK
 D BMES^XPDUTL("Delete ids for deleted insurance companies")
 S CT=0 F FILE=355.9,355.91 S Z=0 F  S Z=$O(^IBA(FILE,Z)) Q:'Z  S IBINS=+$P($G(^(Z,0)),U,$S(FILE[".91":1,1:2)) I IBINS,$G(^DIC(36,IBINS,0))="" S DIK="^IBA("_FILE_",",DA=Z D ^DIK S CT=CT+1
 F FILE=355.95,355.96 S Z=0 F  S Z=$O(^IBA(FILE,Z)) Q:'Z  S IBINS=+$P($G(^(Z,0)),U,3) I IBINS,$G(^DIC(36,IBINS,0))="" S DIK="^IBA("_FILE_",",DA=Z D ^DIK S CT=CT+1
 I CT D BMES^XPDUTL(CT_" IDs deleted for deleted insurance companies")
 ;
355 ;PUT PROPER MODIFIER INTO PC 3 OF ^IBE(355.97
 ;
 N X,INS
 S X=0
 F  S X=$O(^IBE(355.97,X)) Q:+X=0  D
 . Q:'$D(^IBE(355.97,X,0))
 . S INS=$P(^IBE(355.97,X,0),"^",1)
 . Q:INS=""
 . I INS["CROSS" S $P(^IBE(355.97,X,0),"^",3)="1A"
 . I INS["SHIELD" S $P(^IBE(355.97,X,0),"^",3)="1B"
 . I INS["CHAMPUS" S $P(^IBE(355.97,X,0),"^",3)="1H",DA=X,DR=".01////TRICARE ID",DIE="^IBE(355.97," D ^DIE
 . I INS["COMMER" S $P(^IBE(355.97,X,0),"^",3)="G2"
 . I INS["CLIA" S $P(^IBE(355.97,X,0),"^",3)="X4"
 . I INS["MEDICARE" S $P(^IBE(355.97,X,0),"^",3)="1C"
 . I INS["TAX" S $P(^IBE(355.97,X,0),"^",3)="24"
 . I INS["NETWORK" S $P(^IBE(355.97,X,0),"^",3)="N5"
 . I INS["UPIN" S $P(^IBE(355.97,X,0),"^",3)="1G",$P(^(0),U,2)=0
 . I INS["PPO" S $P(^IBE(355.97,X,0),"^",3)="B3"
 . I INS["HMO" S $P(^IBE(355.97,X,0),"^",3)="BQ"
 . I INS["SOCIAL" S $P(^IBE(355.97,X,0),"^",3)="SY"
 . I INS["STATE" S $P(^IBE(355.97,X,0),"^",3)="0B"
 ;
 D END
 Q
 ;
INCLUDE(FILE,Y) ;CODE TO DECIDE WHICH FILE ENTRIES CAN BE INCLUDED IN BUILD
 ;FILE = FILE LIST WE SHOULD USE 5=364.5,6=364.6,7=364.7, Y = GLOBAL IEN
 ;
 N IBOUT,Z,Z0,LINE,TAG
 I Y>9999 S IBOUT=0 G INCQ1
 F LINE=2:1  S TAG="ENT"_FILE_"+"_LINE Q:$P($T(@TAG),";;",2)=""  I $P($T(@TAG),";;",2)[(U_+Y_U) S IBOUT=1 Q
INCQ1 Q +$G(IBOUT)
 ;
ENT5 ;ENTRIES IN 364.5 WE NEED
 ;
 ;;^101^218^234^268^269^271^272^298^299^300^301^303^304^305^306^307^308^309^310^311^312^313^314^315^316^317^318^
 ;;
 ;
ENT6 ;ENTRIES IN 364.6 WE NEED
 ;
 ;;^1^3^5^8^19^22^26^28^30^31^33^35^36^41^42^44^51^52^53^92^112^113^114^
 ;;^115^116^117^118^119^120^121^122^123^124^125^126^127^128^129^130^131^
 ;;^132^133^134^135^136^137^138^156^168^169^175^177^178^179^180^181^182^
 ;;^184^185^186^187^188^192^194^196^210^251^252^253^479^483^488^579^580^
 ;;^581^610^792^793^794^859^860^861^862^863^864^865^866^867^868^869^
 ;;^870^871^872^873^874^875^876^877^878^879^880^881^882^883^885^907^908^
 ;;^909^910^911^912^913^914^915^916^917^918^919^920^921^935^936^937^938^
 ;;^939^940^941^942^943^944^945^946^947^948^949^950^958^960^968^951^973^
 ;;^974^975^976^977^978^979^980^981^982^983^984^985^986^989^990^991^992^
 ;;^993^994^1004^1006^1007^1009^1010^1011^1012^1013^1014^1015^1016^1017^
 ;;^1018^1019^
 ;;^1020^1021^1022^1023^1024^1025^1026^1027^1028^1029^1030^1031^1032^
 ;;^1033^1034^1035^1036^1037^1038^1039^1040^1041^1042^1043^1044^1045^
 ;;^1046^1047^1048^1049^1050^1056^1057^1058^1059^1060^1061^1062^1063^
 ;;^1065^1066^1067^1068^1069^1071^1072^1073^1074^1075^1076^1077^1078^
 ;;^1080^1081^1082^1083^1084^1085^1086^1087^1088^1089^1090^1091^1092^
 ;;^1094^1095^1096^1097^1098^1099^1100^1101^1102^1103^1104^1106^1107^
 ;;^1108^1110^1111^1112^1113^1114^1115^1116^1117^1118^1119^1120^1121^
 ;;^1122^1123^1124^1126^1127^1128^1129^1130^1131^1132^1133^1134^1135^
 ;;^1136^1137^1138^1139^1140^1141^1142^1143^1144^1145^1146^
 ;;^1147^1148^1150^1151^1152^1153^1154^1155^1156^1157^1158^1159^1160^
 ;;^1161^1162^1163^1164^1165^1166^1167^1168^1169^1170^1171^1172^1173^
 ;;^1174^1175^1176^1177^1178^1179^1180^1181^1182^1183^1184^1185^1186^
 ;;^1187^1188^1189^1190^1191^1192^1194^1195^1196^1197^1198^1199^1200^
 ;;^1201^1202^1203^1204^1205^1206^1207^1209^1210^1211^1212^1213^1214^
 ;;^1215^1216^1217^1218^1219^1220^1221^1222^1223^1224^1225^1226^1227^
 ;;^1228^1229^1230^1231^1232^1233^1234^1235^1236^1237^1238^1239^1240^
 ;;^1241^1242^1243^1244^1245^1246^1247^1248^1249^1250^1251^1252^1253^
 ;;^1254^1255^1256^1257^1258^1259^1260^1261^1262^1263^1277^1278^1279^
 ;;^1280^1281^1282^1283^1284^1285^1286^1287^1288^1289^1290^1291^1292^
 ;;^1293^1294^1295^1296^1297^1298^1299^1300^1301^1302^1303^1304^1305^
 ;;^1306^1308^1309^1310^1311^1312^1313^1314^1315^1316^1317^1318^1319^
 ;;^1320^
 ;;
 ;
ENT7 ;ENTRIES IN 364.7 WE NEED
 ;
 ;;^1^5^6^7^12^13^14^17^18^25^27^28^53^79^80^88^89^110^112^134^135^141^
 ;;^144^151^152^153^154^156^157^186^187^192^193^195^196^197^198^203^204^
 ;;^205^206^207^208^209^211^212^213^214^215^220^224^228^229^230^232^237^
 ;;^244^245^246^247^249^256^302^316^324^325^420^440^441^443^
 ;;^532^642^644^646^648^650^652^654^655^656^657^658^659^660^661^662^
 ;;^326^333^334^358^359^360^361^362^363^364^365^366^367^368^369^370^
 ;;^371^372^373^374^375^376^377^378^379^380^381^382^383^384^385^386^
 ;;^387^388^389^391^392^393^394^395^396^397^398^399^400^401^402^403^
 ;;^404^405^406^407^408^409^410^411^412^413^414^416^417^418^419^420^
 ;;^421^422^423^424^425^426^427^428^429^430^431^432^433^434^435^436^
 ;;^437^438^439^441^443^444^445^446^447^448^449^450^451^452^453^454^
 ;;^455^456^457^458^459^460^461^462^463^464^465^466^467^468^469^470^
 ;;^471^487^531^535^537^538^540^541^542^543^544^545^546^547^548^549^
 ;;^550^551^552^553^554^555^556^557^558^559^560^561^562^563^564^565^
 ;;^566^567^568^570^571^572^573^574^575^576^577^578^579^580^581^582^
 ;;^583^584^585^586^587^588^589^590^591^592^593^594^595^596^597^598^
 ;;^599^600^601^602^603^604^605^614^640^641^644^645^646^647^648^649^650^
 ;;^651^652^653^663^664^798^800^806^807^830^893^896^897^901^902^914^915^
 ;;^916^917^918^919^920^921^922^923^934^945^948^949^950^969^986^987^988^
 ;;^991^992^993^994^995^996^1005^1006^1008^1010^1012^1015^1016^1017^1018^
 ;;^1019^1020^1021^1022^1023^1024^1025^1026^1027^1028^1029^1030^1031^
 ;;^1032^1033^1011^1034^1035^1036^1037^1038^
 ;;
 ;
ENT97 ;ENTRIES IN 355.97 WE NEED
 ;
 ;;^24^25^26^27^28^29^
 ;;
 ;
END ;
 D BMES^XPDUTL("Step complete")
 ;
 D BMES^XPDUTL("Pre-install complete")
 Q
 ;
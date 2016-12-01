A5PLIST ;SLC/RJS-Display Due and Overdue patches in account from imported data; 12/10/2015
 ;class3
S ;
 ;
 K ^TMP($J)
 S TODAY=$$DAYS(DT)
 S NMSP=^%ZOSF("PROD")
 ;
 ;
 ;
 W !!," Scanning Install File for installed patches... "
 ;
 S D0=0 F  S D0=$O(^XPD(9.7,D0)) Q:'D0  D
 .S PNAME=$P($G(^XPD(9.7,D0,0)),"^",1)
 .Q:'(PNAME["*")
 .S INDATE=$P($G(^XPD(9.7,D0,1)),"^",3)
 .S INUSER=$P($G(^XPD(9.7,D0,0)),"^",11)
 .S COMMENT=$G(^XPD(9.7,D0,2))
 .Q:'(COMMENT["SEQ")
 .S SEQ="SEQ"_$P(COMMENT,"SEQ",2)
 .S PNAME=$$UPCASE(PNAME)
 .S ^TMP($J,"INSTALL",PNAME,+INDATE)=INUSER
 ;
 W !!," Scanning Package File for installed patches..."
 ;
 S D0=0 F  S D0=$O(^DIC(9.4,D0)) Q:'D0  D
 .S PACK=$P($G(^DIC(9.4,D0,0)),"^",2) Q:'$L(PACK)
 .S D1=0 F  S D1=$O(^DIC(9.4,D0,22,D1)) Q:'D1  D
 ..S VERS=$P($G(^DIC(9.4,D0,22,D1,0)),"^",1) Q:'$L(VERS)
 ..S D2=0 F  S D2=$O(^DIC(9.4,D0,22,D1,"PAH",D2)) Q:'D2  D
 ...S NODE0=$G(^DIC(9.4,D0,22,D1,"PAH",D2,0))
 ...S PATCH=$$UPCASE(PACK_"*"_VERS_"*"_$P(NODE0,"^",1))
 ...S PATCH=$P(PATCH," ",1)
 ...Q:$O(^TMP($J,"INSTALL",PATCH,0))
 ...S DATE=$P(NODE0,"^",2) Q:'DATE
 ...I '(DATE[".") S DATE=DATE+.0001
 ...S USER=$P(NODE0,"^",3)
 ...S ^TMP($J,"INSTALL",PATCH,DATE)=USER
 ;
 ;
 W !!," Build Uninstalled Patch list by release date.. "
 ;
 S D0=0 F  S D0=$O(^A5PATCH("EXLIST",D0)) Q:'D0  D
 .S REC=$G(^A5PATCH("EXLIST",D0))
 .Q:'$L(REC)
 .S PATCH=$P(REC,"^",1)
 .S SEQ=$P(REC,"^",5)
 .S PNAME=$P(REC,"^",8)
 .S ^TMP($J,"PLIST",PNAME)=1
 .S RELEASE=$P(REC,"^",2)
 .S INSTALL=$O(^TMP($J,"INSTALL",PNAME,RELEASE))
 .Q:INSTALL
 .S ^TMP($J,"PREL",RELEASE,$P(PNAME,"*",1),+SEQ,PNAME)=REC
 ;
 S D0=0 F  S D0=$O(^XPD(9.9,D0)) Q:'D0  D
 .S REC=$G(^XPD(9.9,D0,0))
 .Q:'$L(REC)
 .S PATCH=$P(REC,"^",1)
 .S SEQ=$P(REC,"^",5)
 .S PNAME=$P(REC,"^",8)
 .Q:$G(^TMP($J,"PLIST",PNAME))
 .S RELEASE=$P(REC,"^",2)	
 .S INSTALL=$P(REC,"^",11,12)
 .Q:INSTALL
 .S INSTALL=$O(^TMP($J,"INSTALL",PNAME,RELEASE))
 .Q:INSTALL
 .S ^TMP($J,"PREL",RELEASE,$P(PNAME,"*",1),+SEQ,PNAME)=REC
 ;
 ;     Print Report
 ;
 S D0="" F  S D0=$O(^TMP($J,"PREL",D0)) Q:'$L(D0)  D
 .W !!,$$DATE(D0),!
 .S D1="" F  S D1=$O(^TMP($J,"PREL",D0,D1)) Q:'$L(D1)  D
 ..S D2="" F  S D2=$O(^TMP($J,"PREL",D0,D1,D2)) Q:'$L(D2)  D
 ...S D3="" F  S D3=$O(^TMP($J,"PREL",D0,D1,D2,D3)) Q:'$L(D3)  D
 ....S REC=$G(^TMP($J,"PREL",D0,D1,D2,D3))
 ....Q:'$L(REC)
 ....S PATCH=$P(REC,"^",1)
 ....S SEQ=$P(REC,"^",5)
 ....S DESC=$P(REC,"^",7)
 ....S PNAME=$P(REC,"^",8)
 ....S RELEASE=$P(REC,"^",2)
 ....S COMPLY=$P(REC,"^",9)
 ....S INSTALL=$P(REC,"^",11,12)
 ....W !,?5,PNAME,$$PAD(12-$L(PNAME))," SEQ# ",SEQ,?30,DESC
 ;
 Q
 ;
EXPORT ;
 ;
 K ^TMP($J)
 S TODAY=$$DAYS(DT)
 S NMSP=^%ZOSF("PROD")
 ;
 W !,"K ^A5PATCH(""EXLIST"")"
 ;
 S D0=0 F  S D0=$O(^XPD(9.9,D0)) Q:'D0  U $I:132 D
 .S REC=$G(^XPD(9.9,D0,0))
 .Q:'$L(REC)
 .S RELEASE=$P(REC,"^",2)
 .;Q:(RELEASE<3150101)
 .S $P(REC,"^",4)=""
 .S $P(REC,"^",11)=""
 .S $P(REC,"^",12)=""
 .U $I:130 W !,"S ^A5PATCH(""EXLIST"","_D0_")="""_REC_""""
 Q
 ;
PAD(X) ;
 N Y,Z
 S Y=""
 F Z=1:1:X S Y=Y_" "
 Q Y
 ;
INSTALL(X) ;
 ;
 N INSTALL,TIME,USER
 S INSTALL=""
 I X D
 .S TIME=$$DATE($P(X,"^",1))
 .S USER=$$USER(+$P(X,"^",2))
 .S INSTALL=$J(TIME,10)_"     "_USER
 Q INSTALL
 ;
USER(X) ;
 ;
 N USER
 S USER=$P($G(^VA(200,X,0)),"^",1)
 S:'$L(USER) USER="  Unknown"
 ;
 Q USER
 ;
DAYS(X) Q ($E(X,1,3)*365)+($E(X,4,5)*30)+($E(X,6,7))
 ;
DATE(X) ;
 N DAY,TIME
 Q:'X ""
 S DAY=$P(X,".",1)
 S DAY=$E(DAY,4,5)_"/"_$E(DAY,6,7)_"/"_($E(DAY,1,3)+1700)
 S TIME=$P(X,".",2)
 I TIME S TIME=$E(TIME_"000000",1,6),TIME=$E(TIME,1,2)_":"_$E(TIME,3,4)_"."_$E(TIME,5,6)
 Q DAY
 ;
UPCASE(X) Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
ZP ;
 ;
 W !!
 S TEXT="" F LINE=1:1:9999 D  Q:'$L(TEXT)
 .S TEXT=$T(+LINE)
 .W !,$P(TEXT," ",1)_$C(126)_$P(TEXT," ",2,$L(TEXT," "))
 Q
 ;

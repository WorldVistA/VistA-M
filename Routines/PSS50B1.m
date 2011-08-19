PSS50B1 ;BIR/LDT - API FOR INFORMATION FROM FILE 50; 5 Sep 03
 ;;1.0;PHARMACY DATA MANAGEMENT;**85**;9/30/97
 ;
LOOP ;
 N PSS50DD5,PSS50ER5,PSS501NX D FIELD^DID(50.1,1,"Z","POINTER","PSS50DD5","PSS50ER5") S PSS501NX=$G(PSS50DD5("POINTER"))
 N PSSENCT
 S PSSENCT=0
 S PSS(1)=0 F  S PSS(1)=$O(^PSDRUG(PSS(1))) Q:'PSS(1)  D
 .I $P($G(^PSDRUG(PSS(1),0)),"^")="" Q
 .I $G(PSSFL),$P($G(^PSDRUG(PSS(1),"I")),"^"),$P($G(^("I")),"^")'>PSSFL Q
 .I $G(PSSRTOI)=1,'$P($G(^PSDRUG(PSS(1),2)),"^") Q
 .;Naked reference below refers to ^PSDRUG(PSS(1),2)
 .I $G(PSSPK)]"" N PSSZ5,PSSZ6 S PSSZ5=0 F PSSZ6=1:1:$L(PSSPK) Q:PSSZ5  I $P($G(^(2)),"^",3)[$E(PSSPK,PSSZ6) S PSSZ5=1
 .I $G(PSSPK)]"",'PSSZ5 Q
 .D SETSUB1^PSS50AQM(PSS(1)),SETSUB4^PSS50AQM(PSS(1))
 .D SETINV,SETSYN2,SETIFC
 .S PSSENCT=PSSENCT+1
 S ^TMP($J,LIST,0)=$S($G(PSSENCT):$G(PSSENCT),1:"-1^NO DATA FOUND")
 Q
SETINV ;
 N PSSZNODE,PSS660,PSS6601
 S PSSZNODE=$G(^PSDRUG(PSS(1),0)),PSS660=$G(^(660)),PSS6601=$G(^(660.1))
 S ^TMP($J,LIST,+PSS(1),.01)=$P(PSSZNODE,"^")
 S ^TMP($J,LIST,"B",$P(PSSZNODE,"^"),+PSS(1))=""
 S ^TMP($J,LIST,+PSS(1),11)=$P(PSS660,"^")
 S ^TMP($J,LIST,+PSS(1),12)=$S($P(PSS660,"^",2):$P(PSS660,"^",2)_"^"_$P($G(^DIC(51.5,+$P(PSS660,"^",2),0)),"^")_"^"_$P($G(^(0)),"^",2),1:"")
 S ^TMP($J,LIST,+PSS(1),13)=$P(PSS660,"^",3)
 S ^TMP($J,LIST,+PSS(1),14)=$P(PSS660,"^",4)
 S ^TMP($J,LIST,+PSS(1),15)=$P(PSS660,"^",5)
 S ^TMP($J,LIST,+PSS(1),16)=$P(PSS660,"^",6)
 S ^TMP($J,LIST,+PSS(1),17)=$P(PSS660,"^",7)
 S ^TMP($J,LIST,+PSS(1),14.5)=$P(PSS660,"^",8)
 N Y S Y=$P(PSS660,"^",9) D
 .I Y S ^TMP($J,LIST,+PSS(1),17.1)=$G(Y) X ^DD("DD") S ^TMP($J,LIST,+PSS(1),17.1)=^TMP($J,LIST,+PSS(1),17.1)_"^"_$G(Y) Q
 .S ^TMP($J,LIST,+PSS(1),17.1)=""
 S ^TMP($J,LIST,+PSS(1),50)=$P(PSS6601,"^")
 Q
SETSYN2 ;
 N PSS501C S PSS501C=0
 I $O(^PSDRUG(PSS(1),1,0)) N PSS501,PSS501ND  D
 .F PSS501=0:0 S PSS501=$O(^PSDRUG(PSS(1),1,PSS501)) Q:'PSS501  D
 ..S PSS501ND=$G(^PSDRUG(PSS(1),1,PSS501,0)) I $P(PSS501ND,"^")'="" S PSS501C=PSS501C+1 D
 ...S ^TMP($J,LIST,+PSS(1),"SYN",PSS501,.01)=$P(PSS501ND,"^")
 ...N PSS501NN S PSS501NN=$P(PSS501ND,"^",3)  D
 ....I PSS501NN'="",PSS501NX'="",PSS501NX[(PSS501NN_":") S ^TMP($J,LIST,+PSS(1),"SYN",PSS501,1)=PSS501NN_"^"_$P($E(PSS501NX,$F(PSS501NX,(PSS501NN_":")),999),";") Q
 ....S ^TMP($J,LIST,+PSS(1),"SYN",PSS501,1)=""
 ...S ^TMP($J,LIST,+PSS(1),"SYN",PSS501,2)=$P(PSS501ND,"^",2)
 ...S ^TMP($J,LIST,+PSS(1),"SYN",PSS501,400)=$P(PSS501ND,"^",4)
 ...S ^TMP($J,LIST,+PSS(1),"SYN",PSS501,401)=$S($P(PSS501ND,"^",5):$P(PSS501ND,"^",5)_"^"_$P($G(^DIC(51.5,+$P(PSS501ND,"^",5),0)),"^")_"^"_$P($G(^(0)),"^",2),1:"")
 ...S ^TMP($J,LIST,+PSS(1),"SYN",PSS501,402)=$P(PSS501ND,"^",6)
 ...S ^TMP($J,LIST,+PSS(1),"SYN",PSS501,403)=$P(PSS501ND,"^",7)
 ...S ^TMP($J,LIST,+PSS(1),"SYN",PSS501,404)=$P(PSS501ND,"^",8)
 ...S ^TMP($J,LIST,+PSS(1),"SYN",PSS501,405)=$P(PSS501ND,"^",9)
 S ^TMP($J,LIST,+PSS(1),"SYN",0)=$S(PSS501C:PSS501C,1:"-1^NO DATA FOUND")
 Q
SETIFC ;
 N PSS441C S PSS441C=0
 I $O(^PSDRUG(PSS(1),441,0)) N PSS441,PSS441ND  D
 .F PSS441=0:0 S PSS441=$O(^PSDRUG(PSS(1),441,PSS441)) Q:'PSS441  D
 ..S PSS441ND=$G(^PSDRUG(PSS(1),441,PSS441,0)) I $P(PSS441ND,"^")'="" S PSS441C=PSS441C+1 D
 ...S ^TMP($J,LIST,+PSS(1),"IFC",PSS441,.01)=$P(PSS441ND,"^")
 S ^TMP($J,LIST,+PSS(1),"IFC",0)=$S(PSS441C:PSS441C,1:"-1^NO DATA FOUND")
 Q
 ;
AVSN ;
 ;PSSVAL - ITEM NUMBER sub-field (#.01) of the IFCAP ITEM NUMBER multiple of the DRUG file (#50)
 ;PSSFL - Inactive flag - "" - All entries
 ;                        FileMan Date - Only entries with no Inactive Date or an Inactive Date greater than this date.
 ;PSSPK - Application Package's Use - "" - All entries
 ;                                         Alphabetic codes that represent the DHCP packages that consider this drug to be
 ;                                         part of their formulary.
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the Field Number of the data
 ;       piece being returned.
 ;Returns zero node of 50
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I +$G(PSSVAL)'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 N PSS,CNT,PSSIEN  S (CNT,PSS)=0 F  S PSS=$O(^PSDRUG("AVSN",+PSSVAL,PSS)) Q:'PSS  D
 .N INODE,NODE2 S NODE2=$G(^PSDRUG(+PSS,2)),INODE=$G(^("I"))
 .I +$G(PSSFL)>0,+INODE>0,+INODE'>PSSFL Q
 .;Naked reference below refers to ^PSDRUG(+Y,2)
 .I $G(PSSPK)]"" N PSSZ5,PSSZ6 S PSSZ5=0 F PSSZ6=1:1:$L(PSSPK) Q:PSSZ5  I $P($G(^(2)),"^",3)[$E(PSSPK,PSSZ6) S PSSZ5=1
 .I $G(PSSPK)]"",'PSSZ5 Q
 .K ^TMP($J,"PSS50") D GETS^DIQ(50,+PSS,".01;9*","IE","^TMP($J,""PSS50""") D
 ..S PSS(1)=0 F  S PSS(1)=$O(^TMP($J,"PSS50",50,PSS(1))) Q:'PSS(1)  D
 ...S ^TMP($J,LIST,+PSS(1),.01)=$G(^TMP($J,"PSS50",50,PSS(1),.01,"I")),CNT=CNT+1
 ...S ^TMP($J,LIST,"AVSN",$G(^TMP($J,"PSS50",50,PSS(1),.01,"I")),+PSS(1))="",PSSIEN=+PSS(1)
 ..S (CNT(1),PSS(2))=0 F  S PSS(2)=$O(^TMP($J,"PSS50",50.1,PSS(2))) Q:'PSS(2)  D
 ...S ^TMP($J,LIST,+PSSIEN,"SYN",+PSS(2),.01)=$G(^TMP($J,"PSS50",50.1,PSS(2),.01,"I")),CNT(1)=CNT(1)+1
 ...S ^TMP($J,LIST,+PSSIEN,"SYN",+PSS(2),2)=$G(^TMP($J,"PSS50",50.1,PSS(2),2,"I"))
 ...S ^TMP($J,LIST,+PSSIEN,"SYN",+PSS(2),1)=$S($G(^TMP($J,"PSS50",50.1,PSS(2),1,"I"))="":"",1:$G(^TMP($J,"PSS50",50.1,PSS(2),1,"I"))_"^"_$G(^TMP($J,"PSS50",50.1,PSS(2),1,"E")))
 ...S ^TMP($J,LIST,+PSSIEN,"SYN",+PSS(2),400)=$G(^TMP($J,"PSS50",50.1,PSS(2),400,"I"))
 ...S ^TMP($J,LIST,+PSSIEN,"SYN",+PSS(2),401)=$S($G(^TMP($J,"PSS50",50.1,PSS(2),401,"I"))="":"",1:$G(^TMP($J,"PSS50",50.1,PSS(2),401,"I"))_"^"_$G(^TMP($J,"PSS50",50.1,PSS(2),401,"E")))
 ...S ^TMP($J,LIST,+PSSIEN,"SYN",+PSS(2),402)=$G(^TMP($J,"PSS50",50.1,PSS(2),402,"I"))
 ...S ^TMP($J,LIST,+PSSIEN,"SYN",+PSS(2),403)=$G(^TMP($J,"PSS50",50.1,PSS(2),403,"I"))
 ...S ^TMP($J,LIST,+PSSIEN,"SYN",+PSS(2),404)=$G(^TMP($J,"PSS50",50.1,PSS(2),404,"I"))
 ...S ^TMP($J,LIST,+PSSIEN,"SYN",+PSS(2),405)=$G(^TMP($J,"PSS50",50.1,PSS(2),405,"I"))
 ..S ^TMP($J,LIST,+PSSIEN,"SYN",0)=$S(CNT(1)>0:CNT(1),1:"-1^NO DATA FOUND")
 S ^TMP($J,LIST,0)=$S(CNT>0:CNT,1:"-1^NO DATA FOUND")
 K ^TMP($J,"PSS50")
 Q
 ;
AQ1 ;
 ;PSSVAL - ITEM NUMBER sub-field (#.01) of the IFCAP ITEM NUMBER multiple of the DRUG file (#50)
 ;PSSFL - Inactive flag - "" - All entries
 ;                        FileMan Date - Only entries with no Inactive Date or an Inactive Date greater than this date.
 ;PSSPK - Application Package's Use - "" - All entries
 ;                                         Alphabetic codes that represent the DHCP packages that consider this drug to be
 ;                                         part of their formulary.
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the Field Number of the data
 ;       piece being returned.
 ;Returns zero node of 50
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I $G(PSSVAL)']"" S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 N PSS,CNT S (CNT,PSS)=0 F  S PSS=$O(^PSDRUG("AQ1",PSSVAL,PSS)) Q:'PSS  D
 .N INODE,NODE2,ZNODE S NODE2=$G(^PSDRUG(+PSS,2)),INODE=$G(^("I")),ZNODE=$G(^(0))
 .I +$G(PSSFL)>0,+INODE>0,+INODE'>PSSFL Q
 .;Naked reference below refers to ^PSDRUG(+PSS,2)
 .I $G(PSSPK)]"" N PSSZ5,PSSZ6 S PSSZ5=0 F PSSZ6=1:1:$L(PSSPK) Q:PSSZ5  I $P($G(^(2)),"^",3)[$E(PSSPK,PSSZ6) S PSSZ5=1
 .I $G(PSSPK)]"",'PSSZ5 Q
 .S ^TMP($J,LIST,+PSS,.01)=$P(ZNODE,"^"),CNT=CNT+1
 .S ^TMP($J,LIST,"AQ1",$P(ZNODE,"^"),+PSS)=""
 S ^TMP($J,LIST,0)=$S(CNT>0:CNT,1:"-1^NO DATA FOUND")
 Q
 ;
AIU ;
 ;PSSFT - NAME field (#.01) of the DRUG file (#50)
 ;PSSPK - Application Package's Use - "" - All entries
 ;                                         Alphabetic codes that represent the DHCP packages that consider this drug to be
 ;                                         part of their formulary.
 ;PSSFL - Inactive flag - "" - All entries
 ;                        FileMan Date - Only entries with no Inactive Date or an Inactive Date greater than this date.
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the Field Number of the data
 ;       piece being returned.
 ;Returns NAME field (#.01) of DRUG file (#50).
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I $G(PSSFT)']"" S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I $G(PSSPK)']"" S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 N PSS,CNT S CNT=0,PSS="" F  S PSS=$O(^PSDRUG("AIU"_PSSPK,PSS)) Q:PSS=""  S PSS(1)=0 F  S PSS(1)=$O(^PSDRUG("AIU"_PSSPK,PSS,PSS(1))) Q:'PSS(1)  D
 .N INODE,NODE2,ZNODE S NODE2=$G(^PSDRUG(+PSS(1),2)),INODE=$G(^("I")),ZNODE=$G(^(0))
 .I +$G(PSSFL)>0,+INODE>0,+INODE'>PSSFL Q
 .I $E(PSS,1,$L(PSSFT))'[PSSFT Q
 .S ^TMP($J,LIST,+PSS(1),.01)=$P(ZNODE,"^"),CNT=CNT+1
 .S ^TMP($J,LIST,"AIU",$P(ZNODE,"^"),+PSS(1))=""
 S ^TMP($J,LIST,0)=$S(CNT>0:CNT,1:"-1^NO DATA FOUND")
 Q
 ;
IU ;
 ;PSSFL - Inactive flag - "" - All entries
 ;                        FileMan Date - Only entries with no Inactive Date or an Inactive Date greater than this date.
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the Field Number of the data
 ;       piece being returned.
 ;Returns NAME field (#.01) of DRUG file (#50).
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 N PSS,CNT
 S CNT=0,PSS="" F  S PSS=$O(^PSDRUG("IU",PSS)) Q:PSS=""  I PSS'["O"&(PSS'["U")&(PSS'["I")&(PSS'["N") S PSS(1)=0 F  S PSS(1)=$O(^PSDRUG("IU",PSS,PSS(1))) Q:'PSS(1)  D
 .N INODE,ZNODE S ZNODE=$G(^PSDRUG(+PSS(1),0)),INODE=$G(^("I"))
 .I +$G(PSSFL)>0,+INODE>0,+INODE'>PSSFL Q
 .S ^TMP($J,LIST,+PSS(1),.01)=$P(ZNODE,"^"),CNT=CNT+1
 .S ^TMP($J,LIST,"IU",$P(ZNODE,"^"),+PSS(1))=""
 S ^TMP($J,LIST,0)=$S(CNT>0:CNT,1:"-1^NO DATA FOUND")
 Q

PSS50C ;BIR/LDT - API FOR INFORMATION FROM FILE 50; 5 Sep 03
 ;;1.0;PHARMACY DATA MANAGEMENT;**85**;9/30/97
 ;
WS ;
 ;PSSIEN - IEN of entry in 50
 ;PSSFT - Free Text name in 50
 ;PSSFL - Inactive flag - "" - All entries
 ;                        FileMan Date - Only entries with no Inactive Date or an Inactive Date greater than this date.
 ;PSSPK - Application Package's Use - "" - All entries
 ;                                         Alphabetic codes that represent the DHCP packages that consider this drug to be
 ;                                         part of their formulary.
 ;PSSRTOI - Orderable Item - return only entries matched to a Pharmacy Orderable Item
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the Field Number of the data
 ;       piece being returned.
 ;Returns PSG node of 50
 N DIERR,ZZERR,PSSP50,SCR,PSS,PSSMLCT
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I +$G(PSSIEN)'>0,($G(PSSFT)']"") S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 S SCR("S")=""
 I +$G(PSSFL)>0!($G(PSSPK)]"")!($G(PSSRTOI)=1) N PSS5ND,PSSZ3,PSSZ4 D SETSCRN^PSS50A
 I +$G(PSSIEN)>0 N PSSIEN2 S PSSIEN2=$$FIND1^DIC(50,"","A","`"_PSSIEN,,SCR("S"),"") D  K ^TMP("PSSP50",$J) Q
 .K ^TMP("DIERR",$J)
 .I +PSSIEN2'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .S ^TMP($J,LIST,0)=1
 .K ^TMP("PSSP50",$J) D GETS^DIQ(50,+PSSIEN2,".01;300:302","IE","^TMP(""PSSP50"",$J)") S PSS(1)=0
 .F  S PSS(1)=$O(^TMP("PSSP50",$J,50,PSS(1))) Q:'PSS(1)  D SETWS^PSS50C1
 I $G(PSSIEN)'="" S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I $G(PSSFT)]"" D
 .I PSSFT["??" D LOOP^PSS50C1 Q
 .K ^TMP("DILIST",$J)
 .D FIND^DIC(50,,"@;.01","QP",PSSFT,,"B",SCR("S"),,"")
 .I +$G(^TMP("DILIST",$J,0))=0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .I +^TMP("DILIST",$J,0)>0 S ^TMP($J,LIST,0)=+^TMP("DILIST",$J,0) N PSSXX S PSSXX=0 F  S PSSXX=$O(^TMP("DILIST",$J,PSSXX)) Q:'PSSXX  D
 ..S PSSIEN=+^TMP("DILIST",$J,PSSXX,0)
 ..K ^TMP("PSSP50",$J) D GETS^DIQ(50,+PSSIEN,".01;300:302","IE","^TMP(""PSSP50"",$J)") S PSS(1)=0
 ..F  S PSS(1)=$O(^TMP("PSSP50",$J,50,PSS(1))) Q:'PSS(1)  D SETWS^PSS50C1
 K ^TMP("DILIST",$J),^TMP("PSSP50",$J)
 Q
 ;
MRTN ;
 ;PSSIEN - IEN of entry in 50
 ;PSSFT - Free Text name in 50
 ;PSSFL - Inactive flag - "" - All entries
 ;                        FileMan Date - Only entries with no Inactive Date or an Inactive Date greater than this date.
 ;PSSPK - Application Package's Use - "" - All entries
 ;                                         Alphabetic codes that represent the DHCP packages that consider this drug to be
 ;                                         part of their formulary.
 ;PSSRTOI - Orderable Item - return only entries matched to a Pharmacy Orderable Item
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the Field Number of the data
 ;       piece being returned.
 ;Returns GENERIC NAME (#.01),LAB TEST MONITOR (#17.2),MONITOR ROUTINE (#17.5), and NDC (#31)
 N DIERR,ZZERR,PSSP50,SCR,PSS,PSSMLCT
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I +$G(PSSIEN)'>0,($G(PSSFT)']"") S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 S SCR("S")=""
 I +$G(PSSFL)>0!($G(PSSPK)]"")!($G(PSSRTOI)=1) N PSS5ND,PSSZ3,PSSZ4 D SETSCRN^PSS50A
 I +$G(PSSIEN)>0 N PSSIEN2 S PSSIEN2=$$FIND1^DIC(50,"","A","`"_PSSIEN,,SCR("S"),"") D  K ^TMP("PSSP50",$J) Q
 .K ^TMP("DIERR",$J)
 .I +PSSIEN2'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .S ^TMP($J,LIST,0)=1
 .K ^TMP("PSSP50",$J) D GETS^DIQ(50,+PSSIEN2,".01;17.2;17.5;31","IE","^TMP(""PSSP50"",$J)") S PSS(1)=0
 .F  S PSS(1)=$O(^TMP("PSSP50",$J,50,PSS(1))) Q:'PSS(1)  D SETMRTN^PSS50C1
 I $G(PSSIEN)'="" S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I $G(PSSFT)]"" D
 .I PSSFT["??" D LOOPMR^PSS50C1 Q
 .K ^TMP("DILIST",$J)
 .D FIND^DIC(50,,"@;.01","QP",PSSFT,,"B",SCR("S"),,"")
 .I +$G(^TMP("DILIST",$J,0))=0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .I +^TMP("DILIST",$J,0)>0 S ^TMP($J,LIST,0)=+^TMP("DILIST",$J,0) N PSSXX S PSSXX=0 F  S PSSXX=$O(^TMP("DILIST",$J,PSSXX)) Q:'PSSXX  D
 ..S PSSIEN=+^TMP("DILIST",$J,PSSXX,0)
 ..K ^TMP("PSSP50",$J) D GETS^DIQ(50,+PSSIEN,".01;17.2;17.5;31","IE","^TMP(""PSSP50"",$J)") S PSS(1)=0
 ..F  S PSS(1)=$O(^TMP("PSSP50",$J,50,PSS(1))) Q:'PSS(1)  D SETMRTN^PSS50C1
 K ^TMP("DILIST",$J),^TMP("PSSP50",$J)
 Q
 ;
ZERO ;
 ;PSSIEN - IEN of entry in 50
 ;PSSFT - Free Text name in 50
 ;PSSFL - Inactive flag - "" - All entries
 ;                        FileMan Date - Only entries with no Inactive Date or an Inactive Date greater than this date.
 ;PSSPK - Application Package's Use - "" - All entries
 ;                                         Alphabetic codes that represent the DHCP packages that consider this drug to be
 ;                                         part of their formulary.
 ;PSSRTOI - Orderable Item - return only entries matched to a Pharmacy Orderable Item
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the Field Number of the data
 ;       piece being returned.
 ;Returns zero node of 50
 N DIERR,ZZERR,PSSP50,SCR,PSS,PSSMLCT
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I +$G(PSSIEN)'>0,($G(PSSFT)']"") S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 S SCR("S")=""
 I +$G(PSSFL)>0!($G(PSSPK)]"")!($G(PSSRTOI)=1) N PSS5ND,PSSZ3,PSSZ4 D SETSCRN^PSS50A
 I +$G(PSSIEN)>0 N PSSIEN2 S PSSIEN2=$$FIND1^DIC(50,"","A","`"_PSSIEN,,SCR("S"),"") D  K ^TMP("PSSP50",$J) Q
 .K ^TMP("DIERR",$J)
 .I +PSSIEN2'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .S ^TMP($J,LIST,0)=1
 .K ^TMP("PSSP50",$J) D GETS^DIQ(50,+PSSIEN2,".01;2:8;51:52;101","IE","^TMP(""PSSP50"",$J)") S PSS(1)=0
 .F  S PSS(1)=$O(^TMP("PSSP50",$J,50,PSS(1))) Q:'PSS(1)  D SETZRO^PSS50C1
 I $G(PSSIEN)'="" S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I $G(PSSFT)]"" D
 .I PSSFT["??" D LOOPZR^PSS50C1 Q
 .K ^TMP("DILIST",$J)
 .D FIND^DIC(50,,"@;.01","QP",PSSFT,,"B",SCR("S"),,"")
 .I +$G(^TMP("DILIST",$J,0))=0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .I +^TMP("DILIST",$J,0)>0 S ^TMP($J,LIST,0)=+^TMP("DILIST",$J,0) N PSSXX S PSSXX=0 F  S PSSXX=$O(^TMP("DILIST",$J,PSSXX)) Q:'PSSXX  D
 ..S PSSIEN=+^TMP("DILIST",$J,PSSXX,0)
 ..K ^TMP("PSSP50",$J) D GETS^DIQ(50,+PSSIEN,".01;2:8;51:52;101","IE","^TMP(""PSSP50"",$J)") S PSS(1)=0
 ..F  S PSS(1)=$O(^TMP("PSSP50",$J,50,PSS(1))) Q:'PSS(1)  D SETZRO^PSS50C1
 K ^TMP("DILIST",$J),^TMP("PSSP50",$J)
 Q
 ;
NOCMOP(PSSIEN2,PSSFL2) ;
 ;PSSIEN - IEN of entry in 50
 ;PSSFL - 1 check ^PSDRUG(D0,3)=1
 ;        0 or "" check ^PSDRUG(D0,3)=0 or ""
 I +$G(PSSIEN2)'>0 Q 0
 N NDNODE,INODE,NODE2,NODE3,ZNODE
 S NDNODE=$G(^PSDRUG(+PSSIEN2,"ND")),INODE=$G(^("I")),NODE3=$G(^(3)),NODE2=$G(^(2)),ZNODE=$G(^(0))
 I $P(NODE2,"^",3)["O",$P(NDNODE,"^",2)]"",INODE="",$S($G(PSSFL2)=1:NODE3=0,1:'$D(^PSDRUG(+PSSIEN2,3))) Q 1
 Q 0
 ;
MSG ;
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the Field Number of the data
 ;       piece being returned.
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 N ZNODE,NODE5,INODE
 S ^TMP($J,LIST,0)=0
 S PSS(1)=0 F  S PSS(1)=$O(^PSDRUG(PSS(1))) Q:'PSS(1)  D
 .S ZNODE=$G(^PSDRUG(+PSS(1),0)),NODE5=$G(^(5)),INODE=$G(^("I"))
 .I NODE5]"" S ^TMP($J,LIST,0)=^TMP($J,LIST,0)+1,^TMP($J,LIST,+PSS(1),.01)=$P(ZNODE,"^") D
 ..S ^TMP($J,LIST,"B",$P(ZNODE,"^"),+PSS(1))=""
 ..I INODE]"" S Y=INODE D DD^%DT S INODE=INODE_"^"_Y
 ..S ^TMP($J,LIST,+PSS(1),100)=INODE
 Q
 ;
IEN ;
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the Field Number of the data
 ;       piece being returned.
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 N NDNODE,INODE,ZNODE
 S ^TMP($J,LIST,0)=0
 S PSS(1)="" F  S PSS(1)=$O(^PSDRUG("IU",PSS(1))) Q:PSS(1)=""  D
 .Q:PSS(1)'["O"  S PSS(2)=0 F  S PSS(2)=$O(^PSDRUG("IU",PSS(1),PSS(2))) Q:'PSS(2)  D
 ..S NDNODE=$G(^PSDRUG(PSS(2),"ND")),INODE=$G(^("I")),ZNODE=$G(^(0))
 ..I $P(NDNODE,"^",2)]"",INODE="" D
 ...S ^TMP($J,LIST,0)=^TMP($J,LIST,0)+1,^TMP($J,LIST,+PSS(2),.01)=$P(ZNODE,"^")
 ...S ^TMP($J,LIST,"IU",$P(ZNODE,"^"),+PSS(2))=""
 Q
 ;
AB ;
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
 N PSS,CNT,PSSIEN  S (CNT,PSS)=0 F  S PSS=$O(^PSDRUG("AB",+PSSVAL,PSS)) Q:'PSS  D
 .N INODE,NODE2 S NODE2=$G(^PSDRUG(+PSS,2)),INODE=$G(^("I"))
 .I +$G(PSSFL)>0,+INODE>0,+INODE'>PSSFL Q
 .I $G(PSSPK)]"" N PSSZ5,PSSZ6 S PSSZ5=0 F PSSZ6=1:1:$L(PSSPK) Q:PSSZ5  I $P($G(^(2)),"^",3)[$E(PSSPK,PSSZ6) S PSSZ5=1
 .I $G(PSSPK)]"",'PSSZ5 Q
 .K ^TMP($J,"PSS50") D GETS^DIQ(50,+PSS,".01;441*","IE","^TMP($J,""PSS50""") D
 ..S PSS(1)=0 F  S PSS(1)=$O(^TMP($J,"PSS50",50,PSS(1))) Q:'PSS(1)  D
 ...S ^TMP($J,LIST,+PSS(1),.01)=$G(^TMP($J,"PSS50",50,PSS(1),.01,"I")),CNT=CNT+1
 ...S ^TMP($J,LIST,"AB",$G(^TMP($J,"PSS50",50,PSS(1),.01,"I")),+PSS(1))="",PSSIEN=+PSS(1)
 ..S (CNT(1),PSS(2))=0 F  S PSS(2)=$O(^TMP($J,"PSS50",50.0441,PSS(2))) Q:'PSS(2)  D
 ...S ^TMP($J,LIST,+PSSIEN,"IFC",+PSS(2),.01)=$G(^TMP($J,"PSS50",50.0441,PSS(2),.01,"I")),CNT(1)=CNT(1)+1
 ..S ^TMP($J,LIST,+PSSIEN,"IFC",0)=$S(CNT(1)>0:CNT(1),1:"-1^NO DATA FOUND")
 S ^TMP($J,LIST,0)=$S(CNT>0:CNT,1:"-1^NO DATA FOUND")
 K ^TMP($J,"PSS50")
 Q

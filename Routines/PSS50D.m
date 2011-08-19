PSS50D ;BIR/LDT - API FOR INFORMATION FROM FILE 50; 5 Sep 03
 ;;1.0;PHARMACY DATA MANAGEMENT;**85,105**;9/30/97
 ;
B ;
 ;PSSFT - Free Text name in 50
 ;PSSFL - Inactive flag - "" - All entries
 ;                        FileMan Date - Only entries with no Inactive Date or an Inactive Date greater than this date.
 ;PSSPK - Application Package's Use - "" - All entries
 ;                                         Alphabetic codes that represent the DHCP packages that consider this drug to be
 ;                                         part of their formulary.
 ;PSSRTOI - Orderable Item - return only entries matched to a Pharmacy Orderable Item
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the Field Number of the data
 ;       piece being returned.
 ;Returns list of drugs meeting input criteria
 N DIERR,ZZERR,PSSP50,SCR,PSSIEN
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I $G(PSSFT)']"" S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 S SCR("S")=""
 I +$G(PSSFL)>0!($G(PSSPK)]"")!($G(PSSRTOI)=1) N PSS5ND,PSSZ3,PSSZ4 D SETSCRN^PSS50A
 I $G(PSSFT)]"" D
 .I PSSFT["??" D LOOPB^PSS50C1 Q
 .K ^TMP("DILIST",$J)
 .D FIND^DIC(50,,"@;.01","QP",PSSFT,,"B",SCR("S"),,"")
 .I +$G(^TMP("DILIST",$J,0))=0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .I +^TMP("DILIST",$J,0)>0 S ^TMP($J,LIST,0)=+^TMP("DILIST",$J,0) N PSSXX S PSSXX=0 F  S PSSXX=$O(^TMP("DILIST",$J,PSSXX)) Q:'PSSXX  D
 ..S PSSIEN=+$G(^TMP("DILIST",$J,PSSXX,0)) I PSSIEN,$P($G(^TMP("DILIST",$J,PSSXX,0)),"^",2)'="" D
 ...S ^TMP($J,LIST,PSSIEN,.01)=$P(^TMP("DILIST",$J,PSSXX,0),"^",2)
 ...S ^TMP($J,LIST,"B",$P(^TMP("DILIST",$J,PSSXX,0),"^",2),PSSIEN)=""
 K ^TMP("DILIST",$J)
 Q
 ;
VAC ;
 ;PSSVAL - NATIONAL DRUG CLASS field (#25) of the DRUG file (#50)
 ;PSSFL - Inactive flag - "" - All entries
 ;                        FileMan Date - Only entries with no Inactive Date or an Inactive Date greater than this date.
 ;PSSPK - Application Package's Use - "" - All entries
 ;                                         Alphabetic codes that represent the DHCP packages that consider this drug to be
 ;                                         part of their formulary.
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the Field Number of the data
 ;       piece being returned.
 ;Returns list of drugs meeting input criteria
 N DIERR,ZZERR,PSSP50,SCR,PSSIEN
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I ($G(PSSVAL)']"") S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 S SCR("S")="I $P($G(^PSDRUG(+Y,""ND"")),""^"",6)=PSSVAL"
 I +$G(PSSFL)>0!($G(PSSPK)]"") N PSS5ND,PSSZ3,PSSZ4 D SETSCRN^PSS50C1
 I $G(PSSVAL)]"" D
 .K ^TMP("DILIST",$J)
 .D FIND^DIC(50,,"@;.01","QP",PSSVAL,,"VAC",SCR("S"),,"")
 .I +$G(^TMP("DILIST",$J,0))=0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .I +^TMP("DILIST",$J,0)>0 S ^TMP($J,LIST,0)=+^TMP("DILIST",$J,0) N PSSXX S PSSXX=0 F  S PSSXX=$O(^TMP("DILIST",$J,PSSXX)) Q:'PSSXX  D
 ..S PSSIEN=+$G(^TMP("DILIST",$J,PSSXX,0)) I PSSIEN,$P($G(^TMP("DILIST",$J,PSSXX,0)),"^",2)'="" D
 ...S ^TMP($J,LIST,PSSIEN,.01)=$P(^TMP("DILIST",$J,PSSXX,0),"^",2)
 ...S ^TMP($J,LIST,"VAC",$P(^TMP("DILIST",$J,PSSXX,0),"^",2),PSSIEN)=""
 K ^TMP("DILIST",$J)
 Q
 ;
NDC ;
 ;PSSVAL - NDC field (#31) of the DRUG file (#50)
 ;PSSFL - Inactive flag - "" - All entries
 ;                        FileMan Date - Only entries with no Inactive Date or an Inactive Date greater than this date.
 ;PSSPK - Application Package's Use - "" - All entries
 ;                                         Alphabetic codes that represent the DHCP packages that consider this drug to be
 ;                                         part of their formulary.
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the Field Number of the data
 ;       piece being returned.
 ;Returns list of drugs meeting input criteria
 ; 
 ; Must change to look directly at the NDC cross reference
 N PSSNDC,PSSNDC1,PSSNDC2
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I ($G(PSSVAL)']"") S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 S PSSNDC=0 F PSSNDC1=0:0 S PSSNDC1=$O(^PSDRUG("NDC",PSSVAL,PSSNDC1)) Q:'PSSNDC1  D
 .S PSSNDC2=$P($G(^PSDRUG(PSSNDC1,0)),"^")
 .I PSSNDC2="" Q
 .I $G(PSSFL),$P($G(^PSDRUG(PSSNDC1,"I")),"^"),$P($G(^("I")),"^")'>PSSFL Q
 .;Naked reference below refers to ^PSDRUG(PSSNDC1,"I"), or ^PSDRUG(PSSNDC1,0)
 .I $G(PSSPK)]"" N PSSZ5,PSSZ6 S PSSZ5=0 F PSSZ6=1:1:$L(PSSPK) Q:PSSZ5  I $P($G(^(2)),"^",3)[$E(PSSPK,PSSZ6) S PSSZ5=1
 .I $G(PSSPK)]"",'PSSZ5 Q
 .S ^TMP($J,LIST,PSSNDC1,.01)=PSSNDC2
 .S ^TMP($J,LIST,"NDC",PSSNDC2,PSSNDC1)=""
 .S PSSNDC=PSSNDC+1
 S ^TMP($J,LIST,0)=$S($G(PSSNDC):$G(PSSNDC),1:"-1^NO DATA FOUND")
 Q
 ;
ASP ;
 ;PSSVAL - PHARMACY ORDERABLE ITEM field (#2.1) of the DRUG file (#50)
 ;PSSFL - Inactive flag - "" - All entries
 ;                        FileMan Date - Only entries with no Inactive Date or an Inactive Date greater than this date.
 ;PSSPK - Application Package's Use - "" - All entries
 ;                                         Alphabetic codes that represent the DHCP packages that consider this drug to be
 ;                                         part of their formulary.
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the Field Number of the data
 ;       piece being returned.
 ;Returns list of drugs meeting input criteria
 N DIERR,ZZERR,PSSP50,SCR,PSSIEN
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I ($G(PSSVAL)']"") S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 S SCR("S")=""
 I +$G(PSSFL)>0!($G(PSSPK)]"") N PSS5ND,PSSZ3,PSSZ4 D SETSCRN^PSS50A
 S SCR("S")=SCR("S")_" I +$G(^PSDRUG(+Y,2))=PSSVAL"
 I $G(PSSVAL)]"" D
 .D FIND^DIC(50,,"@;.01","QP",PSSVAL,,"ASP",SCR("S"),,"")
 .I +$G(^TMP("DILIST",$J,0))=0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .I +^TMP("DILIST",$J,0)>0 S ^TMP($J,LIST,0)=+^TMP("DILIST",$J,0) N XX S XX=0 F  S XX=$O(^TMP("DILIST",$J,XX)) Q:'XX  D
 ..S PSSIEN=+^TMP("DILIST",$J,XX,0),^TMP($J,LIST,PSSIEN,.01)=$P(^TMP("DILIST",$J,XX,0),"^",2)
 ..S ^TMP($J,LIST,"ASP",$P(^TMP("DILIST",$J,XX,0),"^",2),PSSIEN)=""
 K ^TMP("DILIST",$J)
 Q
 ;
AND ;
 ;PSSVAL -NATIONAL DRUG FILE ENTRY field (#20) of the DRUG file (#50)
 ;PSSFL - Inactive flag - "" - All entries
 ;                        FileMan Date - Only entries with no Inactive Date or an Inactive Date greater than this date.
 ;PSSPK - Application Package's Use - "" - All entries
 ;                                         Alphabetic codes that represent the DHCP packages that consider this drug to be
 ;                                         part of their formulary.
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the Field Number of the data
 ;       piece being returned.
 ;Returns list of drugs meeting input criteria
 N DIERR,ZZERR,PSSP50,SCR,PSSIEN,CNT
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I ($G(PSSVAL)']"") S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 S SCR("S")=""
 I +$G(PSSFL)>0!($G(PSSPK)]"") N PSS5ND,PSSZ3,PSSZ4 D SETSCRN^PSS50A
 I $G(PSSVAL)]"" D
 .S CNT=0
 .D FIND^DIC(50,,"@;.01","QP",PSSVAL,,"AND",SCR("S"),,"")
 .I +$G(^TMP("DILIST",$J,0))=0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .I +^TMP("DILIST",$J,0)>0 N PSSXX S PSSXX=0 F  S PSSXX=$O(^TMP("DILIST",$J,PSSXX)) Q:'PSSXX  D
 ..S PSSIEN=+^TMP("DILIST",$J,PSSXX,0) K PSS50 D GETS^DIQ(50,+PSSIEN,".01;20","IE","PSS50") S PSS(1)=0
 ..F  S PSS(1)=$O(PSS50(50,PSS(1))) Q:'PSS(1)  D
 ...Q:PSS50(50,PSS(1),20,"I")'=PSSVAL
 ...S ^TMP($J,LIST,PSSIEN,.01)=$G(PSS50(50,PSS(1),.01,"E")),CNT=CNT+1
 ...S ^TMP($J,LIST,"AND",$G(PSS50(50,PSS(1),.01,"E")),PSSIEN)=""
 ..S ^TMP($J,LIST,0)=$S(CNT>0:CNT,1:"-1^NO DATA FOUND")
 K ^TMP("DILIST",$J),PSS50
 Q
 ;
AP ;
 ;PSSVAL - PRIMARY DRUG field (#64) of the DRUG file (#50)
 ;PSSFL - Inactive flag - "" - All entries
 ;                        FileMan Date - Only entries with no Inactive Date or an Inactive Date greater than this date.
 ;PSSPK - Application Package's Use - "" - All entries
 ;                                         Alphabetic codes that represent the DHCP packages that consider this drug to be
 ;                                         part of their formulary.
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the Field Number of the data
 ;       piece being returned.
 ;Returns list of drugs meeting input criteria
 N DIERR,ZZERR,PSSP50,SCR,PSSIEN
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I ($G(PSSVAL)']"") S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 S SCR("S")=""
 I +$G(PSSFL)>0!($G(PSSPK)]"") N PSS5ND,PSSZ3,PSSZ4 D SETSCRN^PSS50A
 S SCR("S")=SCR("S")_" I +$P($G(^PSDRUG(+Y,2)),""^"",6)=PSSVAL"
 I $G(PSSVAL)]"" D
 .D FIND^DIC(50,,"@;.01","QP",PSSVAL,,"AP",SCR("S"),,"")
 .I +$G(^TMP("DILIST",$J,0))=0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .I +^TMP("DILIST",$J,0)>0 S ^TMP($J,LIST,0)=+^TMP("DILIST",$J,0) N XX S XX=0 F  S XX=$O(^TMP("DILIST",$J,XX)) Q:'XX  D
 ..S PSSIEN=+^TMP("DILIST",$J,XX,0),^TMP($J,LIST,PSSIEN,.01)=$P(^TMP("DILIST",$J,XX,0),"^",2)
 ..S ^TMP($J,LIST,"AP",$P(^TMP("DILIST",$J,XX,0),"^",2),PSSIEN)=""
 K ^TMP("DILIST",$J)
 Q

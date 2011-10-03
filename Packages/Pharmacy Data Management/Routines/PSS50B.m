PSS50B ;BIR/LDT - API FOR INFORMATION FROM FILE 50; 5 Sep 03
 ;;1.0;PHARMACY DATA MANAGEMENT;**85**;9/30/97
 ;
INV ;
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
 N DIERR,ZZERR,SCR,PSS,PSSMLCT,PSSP50
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I +$G(PSSIEN)'>0,($G(PSSFT)']"") S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 S SCR("S")=""
 I +$G(PSSFL)>0!($G(PSSPK)]"")!($G(PSSRTOI)=1) N PSS5ND,PSSZ3,PSSZ4 D SETSCRN^PSS50A
 I +$G(PSSIEN)>0 N PSSIEN2 S PSSIEN2=$$FIND1^DIC(50,"","A","`"_PSSIEN,,SCR("S"),"") D  K ^TMP("PSSP50",$J) Q
 .K ^TMP("DIERR",$J)
 .I +PSSIEN2'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .S ^TMP($J,LIST,0)=1
 .D SETSUB1^PSS50AQM(+PSSIEN2),SETSUB4^PSS50AQM(+PSSIEN2)
 .K ^TMP("PSSP50",$J) D GETS^DIQ(50,+PSSIEN2,".01;9*;11:17.1;50;441*","IE","^TMP(""PSSP50"",$J)") S PSS(1)=0
 .F  S PSS(1)=$O(^TMP("PSSP50",$J,50,PSS(1))) Q:'PSS(1)  D SETINV^PSS50ATC D
 ..S (PSS(2),PSSMLCT)=0 F  S PSS(2)=$O(^TMP("PSSP50",$J,50.1,PSS(2))) Q:'PSS(2)  S PSSMLCT=PSSMLCT+1 D SETSYN2^PSS50ATC
 ..S ^TMP($J,LIST,+PSS(1),"SYN",0)=$S($G(PSSMLCT):PSSMLCT,1:"-1^NO DATA FOUND")
 ..S (PSS(2),PSSMLCT)=0 F  S PSS(2)=$O(^TMP("PSSP50",$J,50.0441,PSS(2))) Q:'PSS(2)  S PSSMLCT=PSSMLCT+1 D SETIFC^PSS50ATC
 ..S ^TMP($J,LIST,+PSS(1),"IFC",0)=$S($G(PSSMLCT):PSSMLCT,1:"-1^NO DATA FOUND")
 I $G(PSSIEN)'="" S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I $G(PSSFT)]"" D
 .I PSSFT["??" D LOOP^PSS50B1 Q
 .K ^TMP("DILIST",$J)
 .D FIND^DIC(50,,"@;.01","QP",PSSFT,,"B",SCR("S"),,"")
 .I +$G(^TMP("DILIST",$J,0))=0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .I +^TMP("DILIST",$J,0)>0 S ^TMP($J,LIST,0)=+^TMP("DILIST",$J,0) N PSSXX S PSSXX=0 F  S PSSXX=$O(^TMP("DILIST",$J,PSSXX)) Q:'PSSXX  D
 ..S PSSIEN=+^TMP("DILIST",$J,PSSXX,0)
 ..D SETSUB1^PSS50AQM(PSSIEN),SETSUB4^PSS50AQM(PSSIEN) K ^TMP("PSSP50",$J) D GETS^DIQ(50,+PSSIEN,".01;9*;11:17.1;50;441*","IE","^TMP(""PSSP50"",$J)") S PSS(1)=0
 ..F  S PSS(1)=$O(^TMP("PSSP50",$J,50,PSS(1))) Q:'PSS(1)  D SETINV^PSS50ATC D
 ...S (PSS(2),PSSMLCT)=0 F  S PSS(2)=$O(^TMP("PSSP50",$J,50.1,PSS(2))) Q:'PSS(2)  S PSSMLCT=PSSMLCT+1 D SETSYN2^PSS50ATC
 ...S ^TMP($J,LIST,+PSS(1),"SYN",0)=$S($G(PSSMLCT):PSSMLCT,1:"-1^NO DATA FOUND")
 ...S (PSS(2),PSSMLCT)=0 F  S PSS(2)=$O(^TMP("PSSP50",$J,50.0441,PSS(2))) Q:'PSS(2)  S PSSMLCT=PSSMLCT+1 D SETIFC^PSS50ATC
 ...S ^TMP($J,LIST,+PSS(1),"IFC",0)=$S($G(PSSMLCT):PSSMLCT,1:"-1^NO DATA FOUND")
 K ^TMP("DILIST",$J),^TMP("PSSP50",$J)
 Q
 ;
NDF ;
 ;PSSIEN - IEN of entry in 50
 ;PSSFT - Free Text name in 50
 ;PSSFL - Inactive flag - "" - All entries
 ;                        FileMan Date - Only entries with no Inactive Date or an Inactive Date greater than this date.
 ;PSSPK - Application Package's Use - "" - All entries
 ;                                         Alphabetic codes that represent the DHCP packages that consider this drug to be
 ;                                         part of their formulary.
 ;;PSSRTOI - Orderable Item - return only entries matched to a Pharmacy Orderable Item
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the Field Number of the data
 ;       piece being returned.
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
 .K ^TMP("PSSP50",$J) D GETS^DIQ(50,+PSSIEN2,".01;20:25;27;29","IE","^TMP(""PSSP50"",$J)") S PSS(1)=0
 .F  S PSS(1)=$O(^TMP("PSSP50",$J,50,PSS(1))) Q:'PSS(1)  D SETND^PSS50NDF
 I $G(PSSIEN)'="" S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I $G(PSSFT)]"" D
 .I PSSFT["??" D LOOP^PSS50NDF Q
 .K ^TMP("DILIST",$J)
 .D FIND^DIC(50,,"@;.01","QP",PSSFT,,"B",SCR("S"),,"")
 .I +$G(^TMP("DILIST",$J,0))=0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .I +^TMP("DILIST",$J,0)>0 S ^TMP($J,LIST,0)=+^TMP("DILIST",$J,0) N PSSXX S PSSXX=0 F  S PSSXX=$O(^TMP("DILIST",$J,PSSXX)) Q:'PSSXX  D
 ..S PSSIEN=+^TMP("DILIST",$J,PSSXX,0)
 ..K ^TMP("PSSP50",$J) D GETS^DIQ(50,+PSSIEN,".01;20:25;27;29","IE","^TMP(""PSSP50"",$J)") S PSS(1)=0
 ..F  S PSS(1)=$O(^TMP("PSSP50",$J,50,PSS(1))) Q:'PSS(1)  D SETND^PSS50NDF
 K ^TMP("DILIST",$J),^TMP("PSSP50",$J)
 Q
 ;
DOSE ;
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
 N DIERR,ZZERR,PSSP50,SCR,PSSMLCT,PSS
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I +$G(PSSIEN)'>0,($G(PSSFT)']"") S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 S SCR("S")=""
 I +$G(PSSFL)>0!($G(PSSPK)]"")!($G(PSSRTOI)=1) N PSS5ND,PSSZ3,PSSZ4 D SETSCRN^PSS50A
 I +$G(PSSIEN)>0 N PSSIEN2 S PSSIEN2=$$FIND1^DIC(50,"","A","`"_PSSIEN,,SCR("S"),"") D  K ^TMP("PSSP50",$J) Q
 .K ^TMP("DIERR",$J)
 .I +PSSIEN2'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .S ^TMP($J,LIST,0)=1
 .D SETSUB7^PSS50AQM(+PSSIEN2),SETSUB8^PSS50AQM(+PSSIEN2)
 .K ^TMP("PSSP50",$J) D GETS^DIQ(50,+PSSIEN2,".01;901;902;903*;904*","IE","^TMP(""PSSP50"",$J)") S PSS(1)=0
 .F  S PSS(1)=$O(^TMP("PSSP50",$J,50,PSS(1))) Q:'PSS(1)  D SDOSE^PSS50DOS D
 ..S (PSS(2),PSSMLCT)=0 F  S PSS(2)=$O(^TMP("PSSP50",$J,50.0903,PSS(2))) Q:'PSS(2)  S PSSMLCT=PSSMLCT+1 D SDOSE2^PSS50DOS
 ..S ^TMP($J,LIST,+PSS(1),"POS",0)=$S($G(PSSMLCT):PSSMLCT,1:"-1^NO DATA FOUND")
 ..S (PSS(2),PSSMLCT)=0 F  S PSS(2)=$O(^TMP("PSSP50",$J,50.0904,PSS(2))) Q:'PSS(2)  S PSSMLCT=PSSMLCT+1 D SDOSE3^PSS50DOS
 ..S ^TMP($J,LIST,+PSS(1),"LOC",0)=$S($G(PSSMLCT):PSSMLCT,1:"-1^NO DATA FOUND")
 I $G(PSSIEN)'="" S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I $G(PSSFT)]"" D
 .I PSSFT["??" D LOOP^PSS50DOS Q
 .K ^TMP("DILIST",$J)
 .D FIND^DIC(50,,"@;.01","QP",PSSFT,,"B",SCR("S"),,"")
 .I +$G(^TMP("DILIST",$J,0))=0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .I +^TMP("DILIST",$J,0)>0 S ^TMP($J,LIST,0)=+^TMP("DILIST",$J,0) N PSSXX S PSSXX=0 F  S PSSXX=$O(^TMP("DILIST",$J,PSSXX)) Q:'PSSXX  D
 ..S PSSIEN=+^TMP("DILIST",$J,PSSXX,0)
 ..D SETSUB7^PSS50AQM(PSSIEN),SETSUB8^PSS50AQM(PSSIEN) K ^TMP("PSSP50",$J) D GETS^DIQ(50,+PSSIEN,".01;901;902;903*;904*","IE","^TMP(""PSSP50"",$J)") S PSS(1)=0
 ..F  S PSS(1)=$O(^TMP("PSSP50",$J,50,PSS(1))) Q:'PSS(1)  D SDOSE^PSS50DOS D
 ...S (PSS(2),PSSMLCT)=0 F  S PSS(2)=$O(^TMP("PSSP50",$J,50.0903,PSS(2))) Q:'PSS(2)  S PSSMLCT=PSSMLCT+1 D SDOSE2^PSS50DOS
 ...S ^TMP($J,LIST,+PSS(1),"POS",0)=$S($G(PSSMLCT):PSSMLCT,1:"-1^NO DATA FOUND")
 ...S (PSS(2),PSSMLCT)=0 F  S PSS(2)=$O(^TMP("PSSP50",$J,50.0904,PSS(2))) Q:'PSS(2)  S PSSMLCT=PSSMLCT+1 D SDOSE3^PSS50DOS
 ...S ^TMP($J,LIST,+PSS(1),"LOC",0)=$S($G(PSSMLCT):PSSMLCT,1:"-1^NO DATA FOUND")
 K ^TMP("DILIST",$J),^TMP("PSSP50",$J)
 Q

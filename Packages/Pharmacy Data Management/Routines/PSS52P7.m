PSS52P7 ;BIR/LDT - API FOR INFORMATION FROM FILE 52.7; 5 Sep 03
 ;;1.0;PHARMACY DATA MANAGEMENT;**85**;9/30/97
 ;
ZERO(PSSIEN,PSSFT,PSSFL,LIST) ;
 ;PSSIEN - IEN of entry in IV SOLUTIONS file (#52.7).
 ;PSSFT - Free Text name in IV SOLUTIONS file (#52.7).
 ;PSSFL - Inactive flag - 0 or "" - All entries
 ;        FileMan Date - Only entries with no Inactive Date or an Inactive Date greater than this date.
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the
 ;       Field Number of the data piece being returned.
 ;Returns PRINT NAME field (#.01), PRINT NAME {2} field (#.02), GENERIC DRUG field (#1), VOLUME field (#2),
 ;AVERAGE DRUG COST PER UNIT field (#7), INACTIVATION DATE field (#8), PHARMACY ORDERABLE ITEM field (#9),
 ;USED IN IV FLUID ORDER ENTRY field (#17), ELECTROLYTES multiple (#4), ELECTROLYTES field (#.01),
 ;CONCENTRATION (#1) of IV SOLUTIONS file (#52.7).
 N DIERR,ZZERR,PSS52P7,SCR,PSS,CNT2
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I +$G(PSSIEN)'>0,($G(PSSFT)']"") S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I $G(PSSIEN)]"",+$G(PSSIEN)'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 S SCR("S")=""
 I +$G(PSSFL)>0 N ND D SETSCRN
 I +$G(PSSIEN)>0 N PSSIEN2 S PSSIEN2=$$FIND1^DIC(52.7,"","A","`"_PSSIEN,,SCR("S"),"") D
 .I +PSSIEN2'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .S ^TMP($J,LIST,0)=1
 .D GETS^DIQ(52.7,+PSSIEN,".01;1;2;.02;7;8;9;17","IE","PSS52P7") S PSS(1)=0
 .F  S PSS(1)=$O(PSS52P7(52.7,PSS(1))) Q:'PSS(1)  D SETZERO^PSS52P7A,GETS^DIQ(52.7,+PSSIEN,"4*","IE","PSS52P7") S (PSS(2),CNT2)=0
 .F  S PSS(2)=$O(PSS52P7(52.702,PSS(2))) Q:'PSS(2)  D SETLTS^PSS52P7A S CNT2=CNT2+1
 .S ^TMP($J,LIST,+PSSIEN,"ELYTES",0)=$S(CNT2>0:CNT2,1:"-1^NO DATA FOUND")
 I +$G(PSSIEN)'>0,$G(PSSFT)]"" D
 .I PSSFT["??" D LOOP^PSS52P7A(1) Q
 .D FIND^DIC(52.7,,"@;.01;2","QP",PSSFT,,"B",SCR("S"),,"")
 .I +$G(^TMP("DILIST",$J,0))=0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .I +^TMP("DILIST",$J,0)>0 S ^TMP($J,LIST,0)=+^TMP("DILIST",$J,0) N PSSXX S PSSXX=0 F  S PSSXX=$O(^TMP("DILIST",$J,PSSXX)) Q:'PSSXX  D
 ..S PSSIEN=+^TMP("DILIST",$J,PSSXX,0) K PSS52P7 D GETS^DIQ(52.7,+PSSIEN,".01;1;2;.02;7;8;9;17","IE","PSS52P7") S PSS(1)=0
 ..F  S PSS(1)=$O(PSS52P7(52.7,PSS(1))) Q:'PSS(1)  D SETZERO^PSS52P7A  K PSS52P7 D GETS^DIQ(52.7,+PSSIEN,"4*","IE","PSS52P7") S (PSS(2),CNT2)=0
 ..F  S PSS(2)=$O(PSS52P7(52.702,PSS(2))) Q:'PSS(2)  D SETLTS^PSS52P7A S CNT2=CNT2+1
 ..S ^TMP($J,LIST,+PSSIEN,"ELYTES",0)=$S(CNT2>0:CNT2,1:"-1^NO DATA FOUND")
 K ^TMP("DILIST",$J)
 Q
 ;
DRGIEN(PSS50,PSSFL,LIST) ;
 ;PSS50 - IEN of entry in DRUG file (#50).
 ;PSSFL - Inactive flag - 0 or "" - All entries
 ;        FileMan Date - Only entries with no Inactive Date or an Inactive Date greater than this date.
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the
 ;       Field Number of the data piece being returned.
 ;Returns PRINT NAME field (#.01) and VOLUME field (#2) of IV SOLUTIONS file (#52.7).
 N DIERR,ZZERR,PSS52P7,SCR
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I +$G(PSS50)'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 S SCR("S")=""
 I +$G(PSSFL)>0 N ND D SETSCRN
 I +$G(PSS50)>0 D FIND^DIC(52.7,,"@;.01;2","QPX",PSS50,,"AC",SCR("S"),,"PSS52P7")
 I +PSS52P7("DILIST",0)=0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I +PSS52P7("DILIST",0)>0 S ^TMP($J,LIST,0)=+PSS52P7("DILIST",0) N PSSXX S PSSXX=0 F  S PSSXX=$O(PSS52P7("DILIST",PSSXX)) Q:'PSSXX  D
 .S ^TMP($J,LIST,+PSS52P7("DILIST",PSSXX,0),.01)=$P($G(PSS52P7("DILIST",PSSXX,0)),"^",2)
 .S ^TMP($J,LIST,"AC",$P($G(PSS52P7("DILIST",PSSXX,0)),"^",2),+PSS52P7("DILIST",PSSXX,0))=""
 .S ^TMP($J,LIST,+PSS52P7("DILIST",PSSXX,0),2)=$P($G(PSS52P7("DILIST",PSSXX,0)),"^",3)
 Q
 ;
INACTDT(PSSIEN) ;
 ;PSSIEN - IEN of entry in IV SOLUTIONS file (#52.7).
 ;Returns INACTIVATION DATE field (#8) of IV SOLUTIONS file (#52.7).
 N DIERR,ZZERR,PSS52P7,PSS
 I +$G(PSSIEN)'>0 Q ""
 I +$G(PSSIEN)>0 D GETS^DIQ(52.7,+PSSIEN,"8","I","PSS52P7") S PSS(1)=0 D
 .I '$D(PSS52P7) S PSSINACT="" Q
 .F  S PSS(1)=$O(PSS52P7(52.7,PSS(1))) Q:'PSS(1)  S PSSINACT=$G(PSS52P7(52.7,PSS(1),8,"I"))
 Q PSSINACT
 ;
LOOKUP(PSSFT,LIST) ;
 ;PSSFT - Free Text name in IV SOLUTIONS file (#52.7).
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the
 ;       Field Number of the data piece being returned.
 ;Returns PRINT NAME field (#.01), VOLUME field (#2), and PRINT NAME {2} field (#.02) of IV SOLUTIONS file (#52.7).
 N DIERR,ZZERR,PSS52P7,PSS
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I $G(PSSFT)']"" S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I PSSFT["??" D LOOP^PSS52P7A(2) Q
 D FIND^DIC(52.7,,"@;.01;","QP",PSSFT,,"B",,,"")
 I +$G(^TMP("DILIST",$J,0))=0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I +^TMP("DILIST",$J,0)>0 S ^TMP($J,LIST,0)=+^TMP("DILIST",$J,0) N PSSXX S PSSXX=0 F  S PSSXX=$O(^TMP("DILIST",$J,PSSXX)) Q:'PSSXX  D
 .S PSSIEN=+^TMP("DILIST",$J,PSSXX,0) K PSS52P7 D GETS^DIQ(52.7,+PSSIEN,".01;2;.02","IE","PSS52P7") S PSS(1)=0
 .F  S PSS(1)=$O(PSS52P7(52.7,PSS(1))) Q:'PSS(1)  D SETLOOK^PSS52P7A
 K ^TMP("DILIST",$J)
 Q
 ;
POICHK(PSSIEN) ;
 ;PSSIEN - IEN of entry in IV SOLUTIONS file (#52.7).
 ;Returns PHARMACY ORDERABLE ITEM field (#9) PHARMACY ORDERABLE ITEM of IV SOLUTIONS file (#52.7).
 N DIERR,ZZERR,PSS52P7,PSS
 I +$G(PSSIEN)'>0 Q 0
 I +$G(PSSIEN)>0 D GETS^DIQ(52.7,+PSSIEN,"9","I","PSS52P7") S PSS(1)=0 D
 .I '$D(PSS52P7) S PSSOI=0
 .F  S PSS(1)=$O(PSS52P7(52.7,PSS(1))) Q:'PSS(1)  S PSSOI=+$G(PSS52P7(52.7,PSS(1),9,"I"))
 Q PSSOI
 ;
POI(PSSOI,PSSFL,LIST) ;
 ;PSSOI - IEN of entry in the PHARMACY ORDERABLE ITEM file (#50.7) [required].
 ;PSSFL - Inactive flag - 0 or "" - All entries
 ;        FileMan Date - Only entries with no Inactive Date or an Inactive Date greater than this date.
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the
 ;       Field Number of the data piece being returned.
 ;Returns PRINT NAME field (#.01) and VOLUME field (#2) of IV SOLUTIONS file (#52.7).
 N DIERR,ZZERR,PSS52P7,SCR
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I +$G(PSSOI)'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 S SCR("S")=""
 I +$G(PSSFL)>0 N ND D SETSCRN
 D FIND^DIC(52.7,,"@;.01;2","QPX",PSSOI,,"AOI",SCR("S"),,"")
 I +$G(^TMP("DILIST",$J,0))=0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I +^TMP("DILIST",$J,0)>0 S ^TMP($J,LIST,0)=+^TMP("DILIST",$J,0) N PSSXX S PSSXX=0 F  S PSSXX=$O(^TMP("DILIST",$J,PSSXX)) Q:'PSSXX  D
 .S PSSIEN=+^TMP("DILIST",$J,PSSXX,0)
 .S ^TMP($J,LIST,+PSSIEN,.01)=$P($G(^TMP("DILIST",$J,PSSXX,0)),"^",2)
 .S ^TMP($J,LIST,"AOI",$P($G(^TMP("DILIST",$J,PSSXX,0)),"^",2),+PSSIEN)=""
 .S ^TMP($J,LIST,+PSSIEN,2)=$P($G(^TMP("DILIST",$J,PSSXX,0)),"^",3)
 K ^TMP("DILIST",$J)
 Q
 ;
ACTSOL(PSSFL,LIST) ;
 ;PSSFL - Inactive flag - 0 or "" - All entries
 ;        FileMan Date - Only entries with no Inactive Date or an Inactive Date greater than this date.
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the
 ;       Field Number of the data piece being returned.
 ;Returns PRINT NAME field (#.01) and VOLUME field (#2) of IV SOLUTIONS file (#52.7).
 N DIERR,ZZERR,PSSIEN,CNT,SCR
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 S SCR("S")=""
 I +$G(PSSFL)>0 N ND D SETSCRN
 ;Naked reference below refers to ^PS(52.7,+Y,"I")
 I +$G(PSSFL)'>0 S SCR("S")="S ND=$P($G(^(""I"")),U) I ND=""""!(ND>DT)"
 N PSSIEN S (CNT,PSSIEN)=0 F  S PSSIEN=$O(^PS(52.7,PSSIEN)) Q:'PSSIEN  D
 .D FIND^DIC(52.7,,"@;.01;2","QP","`"_PSSIEN,,"B",SCR("S"),,"")
 .I ^TMP("DILIST",$J,0)>0  S CNT=CNT+1 D
 ..S ^TMP($J,LIST,+PSSIEN,.01)=$P($G(^TMP("DILIST",$J,1,0)),"^",2)
 ..S ^TMP($J,LIST,"B",$P($G(^TMP("DILIST",$J,1,0)),"^",2),+PSSIEN)=""
 ..S ^TMP($J,LIST,+PSSIEN,2)=$P($G(^TMP("DILIST",$J,1,0)),"^",3)
 S ^TMP($J,LIST,0)=$S(CNT>0:CNT,1:-1_"^"_"NO DATA FOUND")
 K ^TMP("DILIST",$J)
 Q
 ;
SETSCRN ;Set Screen for inactive Solutions
 ;Naked reference below refers to ^PS(52.7,+Y,"I")
 S SCR("S")="S ND=$P($G(^(""I"")),U) I ND=""""!(ND>PSSFL)"
 Q

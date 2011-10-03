PSS50P7 ;BIR/LDT - API FOR INFORMATION FROM FILE 50.7; 5 Sep 03
 ;;1.0;PHARMACY DATA MANAGEMENT;**85,91**;9/30/97
 ;
ZERO(PSSIEN,PSSFT,PSSFL,LIST) ;
 ;PSSIEN - IEN of entry in PHARMACY ORDERABLE ITEM file (#50.7).
 ;PSSFT - Free Text name in PHARMACY ORDERABLE ITEM file (#50.7).
 ;PSSFL - Inactive flag - "" - All entries.
 ;        FileMan Date - Only entries with no Inactive Date or an Inactive Date greater than this date.
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the
 ;Field Number of the data piece being returned.
 ;Returns NAME field (#.01), DOSAGE FORM field (#.02), IV FLAG field (#.03), INACTIVE DATE field (#.04),
 ;DAY (nD) OR DOSE (nL) LIMIT field (#.05), MED ROUTE field (#.06), SCHEDULE TYPE fiedl (#.07),
 ;SCHEDULE field (#.08), SUPPLY field (#.09), FORMULARY STATUS field (#5), and NON-VA MED field (#8) of
 ;PHARMACY ORDERABLE ITEM file (#50.7).
 N DIERR,ZZERR,PSS50P7,SCR,PSS
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I +$G(PSSIEN)'>0,($G(PSSFT)']"") S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I $G(PSSIEN)]"",+$G(PSSIEN)'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 S SCR("S")=""
 I +$G(PSSFL)>0 N ND D SETSCRN
 I +$G(PSSIEN)>0 N PSSIEN2 S PSSIEN2=$$FIND1^DIC(50.7,"","A","`"_PSSIEN,,SCR("S"),"") D
 .I +PSSIEN2'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .S ^TMP($J,LIST,0)=1
 .D GETS^DIQ(50.7,+PSSIEN2,".01;.02;.03;.04;.05;.06;.07;.08;.09;8;5","IE","PSS50P7") S PSS(1)=0
 .F  S PSS(1)=$O(PSS50P7(50.7,PSS(1))) Q:'PSS(1)  D SETZRO^PSS50P7A
 I +$G(PSSIEN)'>0,$G(PSSFT)]"" D
 .I PSSFT["??" D LOOP^PSS50P7A(1) Q
 .D FIND^DIC(50.7,,"@;.01;.02","QP",PSSFT,,"B",SCR("S"),,"")
 .I +$G(^TMP("DILIST",$J,0))=0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .I +^TMP("DILIST",$J,0)>0 S ^TMP($J,LIST,0)=+^TMP("DILIST",$J,0) N PSSXX S PSSXX=0 F  S PSSXX=$O(^TMP("DILIST",$J,PSSXX)) Q:'PSSXX  D
 ..S PSSIEN=+^TMP("DILIST",$J,PSSXX,0) K PSS50P7 D GETS^DIQ(50.7,+PSSIEN,".01;.02;.03;.04;.05;.06;.07;.08;.09;8;5","IE","PSS50P7") S PSS(1)=0
 ..F  S PSS(1)=$O(PSS50P7(50.7,PSS(1))) Q:'PSS(1)  D SETZRO^PSS50P7A
 K ^TMP("DILIST",$J)
 Q
 ;
SYNONYM(PSSIEN,PSSFT,PSSFL,LIST) ;
 ;PSSIEN - IEN of entry in PHARMACY ORDERABLE ITEM file (#50.7).
 ;PSSFT - Free Text name in PHARMACY ORDERABLE ITEM file (#50.7).
 ;PSSFL - Inactive flag - 0 or "" - All entries.
 ;        FileMan Date - Only entries with no Inactive Date or an Inactive Date greater than this date.
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the
 ;Field Number of the data piece being returned.
 ;Returns NAME field (#.01), DOSAGE FORM field (#.02), SYNONYM subfile (#50.72), and SYNONYM field (#.01)
 ;of PHARMACY ORDERABLE ITEM file (#50.7).
 N DIERR,ZZERR,PSS50P7,SCR,PSS,CNT
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I +$G(PSSIEN)'>0,($G(PSSFT)']"") S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I $G(PSSIEN)]"",+$G(PSSIEN)'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 S SCR("S")=""
 I +$G(PSSFL)>0 N ND D SETSCRN
 I +$G(PSSIEN)>0 N PSSIEN2 S PSSIEN2=$$FIND1^DIC(50.7,"","A","`"_PSSIEN,,SCR("S"),"") D
 .I +PSSIEN2'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .S ^TMP($J,LIST,0)=1
 .D GETS^DIQ(50.7,+PSSIEN2,".01;.02;2*","IE","PSS50P7") S PSS(1)=0
 .S CNT=0 F  S PSS(1)=$O(PSS50P7(50.72,PSS(1))) Q:'PSS(1)  D SETSYN^PSS50P7A S CNT=CNT+1
 .S ^TMP($J,LIST,+PSSIEN2,"SYN",0)=$S(CNT>0:CNT,1:"-1^NO DATA FOUND")
 .S PSS(2)=0 F  S PSS(2)=$O(PSS50P7(50.7,PSS(2))) Q:'PSS(2)  D SETZR2^PSS50P7A
 I +$G(PSSIEN)'>0,$G(PSSFT)]"" D
 .I PSSFT["??" D LOOP^PSS50P7A(2) Q
 .D FIND^DIC(50.7,,"@;.01","QP",PSSFT,,"B",SCR("S"),,"")
 .I +$G(^TMP("DILIST",$J,0))=0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .I +^TMP("DILIST",$J,0)>0 S ^TMP($J,LIST,0)=+^TMP("DILIST",$J,0) N PSSXX S PSSXX=0 F  S PSSXX=$O(^TMP("DILIST",$J,PSSXX)) Q:'PSSXX  D
 ..S PSSIEN=+^TMP("DILIST",$J,PSSXX,0) K PSS50P7(50.72) K PSS50P7 D GETS^DIQ(50.7,+PSSIEN,".01;.02;2*","IE","PSS50P7") S PSS(1)=0
 ..S CNT=0 F  S PSS(1)=$O(PSS50P7(50.72,PSS(1))) Q:'PSS(1)  D SETSYN^PSS50P7A  S CNT=CNT+1
 ..S ^TMP($J,LIST,+PSSIEN,"SYN",0)=$S(CNT>0:CNT,1:"-1^NO DATA FOUND")
 ..S PSS(2)=0 F  S PSS(2)=$O(PSS50P7(50.7,PSS(2))) Q:'PSS(2)  D SETZR2^PSS50P7A
 K ^TMP("DILIST",$J)
 Q
 ;
NAME(PSSIEN) ;
 ;PSSIEN - IEN of entry in PHARMACY ORDERABLE ITEM file (#50.7).
 ;Returns NAME field (#.01) of PHARMACY ORDERABLE ITEM file (#50.7) and DOSAGE FORM name in external form.
 N DIERR,ZZERR,PSS50P7,PSS
 I +$G(PSSIEN)'>0 Q ""
 D GETS^DIQ(50.7,+PSSIEN,".01;.02","E","PSS50P7")
 I '$D(PSS50P7) Q ""
 Q $G(PSS50P7(50.7,PSSIEN_",",.01,"E"))_" "_$G(PSS50P7(50.7,PSSIEN_",",.02,"E"))
 ;
INSTR(PSSIEN,PSSFT,PSSFL,LIST) ;
 ;PSSIEN - IEN of entry in PHARMACY ORDERABLE ITEM file (#50.7).
 ;PSSFT - Free Text name in PHARMACY ORDERABLE ITEM file (#50.7).
 ;PSSFL - Inactive flag - "" - All entries.
 ;        FileMan Date - Only entries with no Inactive Date or an Inactive Date greater than this date.
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the
 ;Field Number of the data piece being returned.
 ;Returns INS and INS1 nodes of PHARMACY ORDERABLE ITEM file (#50.7).
 N DIERR,ZZERR,PSS50P7,SCR,PSS
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I +$G(PSSIEN)'>0,($G(PSSFT)']"") S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I $G(PSSIEN)]"",+$G(PSSIEN)'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 S SCR("S")=""
 I +$G(PSSFL)>0 N ND D SETSCRN
 I +$G(PSSIEN)>0 N PSSIEN2 S PSSIEN2=$$FIND1^DIC(50.7,"","A","`"_PSSIEN,,SCR("S"),"") D
 .I +PSSIEN2'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .S ^TMP($J,LIST,0)=1
 .D GETS^DIQ(50.7,+PSSIEN2,".01;.02;7;7.1","IE","PSS50P7") S PSS(1)=0
 .F  S PSS(1)=$O(PSS50P7(50.7,PSS(1))) Q:'PSS(1)  D SETPTI^PSS50P7A
 I +$G(PSSIEN)'>0,$G(PSSFT)]"" D
 .I PSSFT["??" D LOOP^PSS50P7A(3) Q
 .D FIND^DIC(50.7,,"@;.01","QP",PSSFT,,"B",SCR("S"),,"")
 .I +$G(^TMP("DILIST",$J,0))=0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .I +^TMP("DILIST",$J,0)>0 S ^TMP($J,LIST,0)=+^TMP("DILIST",$J,0) N PSSXX S PSSXX=0 F  S PSSXX=$O(^TMP("DILIST",$J,PSSXX)) Q:'PSSXX  D
 ..S PSSIEN=+^TMP("DILIST",$J,PSSXX,0) K PSS50P7 D GETS^DIQ(50.7,+PSSIEN,".01;.02;7;7.1","IE","PSS50P7") S PSS(1)=0
 ..F  S PSS(1)=$O(PSS50P7(50.7,PSS(1))) Q:'PSS(1)  D SETPTI^PSS50P7A
 K ^TMP("DILIST",$J)
 Q
 ;
DRGIEN(PSSIEN,PSSFL,LIST) ;
 ;PSSIEN - IEN of entry in PHARMACY ORDERABLE ITEM file (#50.7).
 ;PSSFL - Inactive flag - "" - All entries.
 ;        FileMan Date - Only entries with no Inactive Date or an Inactive Date greater than this date.
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the
 ;Field Number of the data piece being returned.
 ;Returns entries from DRUG file (#50) linked to the Pharmacy Orderable Item IEN passed, GENERIC NAME field (#.01),
 ;DEA, SPECIAL HDLG field (#3), APPLICATION PACKAGES' USE field (#63), and the INACTIVE DATE field (#100)
 ;of DRUG file (#50).
 N DIERR,ZZERR,PSS50P7,SCR,PSS
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I +$G(PSSIEN)'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 S SCR("S")="I +Y'=$G(PSSIEN)"
 ;Naked reference below refers to ^PSDRUG(+Y,"I")
 I +$G(PSSFL)>0 S SCR("S")="S ND=$G(^(""I"")) I ((ND="""")&(+Y'=$G(PSSIEN)))!((ND>PSSFL)&(+Y'=$G(PSSIEN)))"
 I +$G(PSSIEN)>0 D FIND^DIC(50,,"@;.01","QX",PSSIEN,,"ASP",SCR("S"),,"PSS50P7")
 I +PSS50P7("DILIST",0)'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 S ^TMP($J,LIST,0)=+PSS50P7("DILIST",0) S PSS(1)=0 D
 .F  S PSS(1)=$O(PSS50P7("DILIST",PSS(1))) Q:'PSS(1)  S PSS(2)=0 F  S PSS(2)=$O(PSS50P7("DILIST",PSS(1),PSS(2))) Q:'PSS(2)  S ^TMP($J,LIST,+PSS50P7("DILIST",PSS(1),PSS(2)))=""
 Q
 ;
IEN(PSSFT,PSSFL,LIST) ;
 ;PSSFT - Free Text name in PHARMACY ORDERABLE ITEM file (#50.7).
 ;PSSFL - Inactive flag - "" - All entries.
 ;        FileMan Date - Only entries with no Inactive Date or an Inactive Date greater than this date.
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the
 ;Field Number of the data piece being returned.
 ;Returns NAME field (#.01), and DOSAGE FORM field (#.02) of PHARMACY ORDERABLE ITEM file (#50.7).
 N DIERR,ZZERR,PSS50P7,SCR,PSS
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I $G(PSSFT)']"" S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 S SCR("S")=""
 I +$G(PSSFL)>0 D SETSCRN
 I PSSFT["??" D LOOP^PSS50P7A(4) Q
 I $G(PSSFT)]"" D FIND^DIC(50.7,,"@;.01;.02IE","QP",PSSFT,,"B",SCR("S"),,"")
 I +$G(^TMP("DILIST",$J,0))'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 S ^TMP($J,LIST,0)=+^TMP("DILIST",$J,0) S PSS(2)=0 D
 .F  S PSS(2)=$O(^TMP("DILIST",$J,PSS(2))) Q:'PSS(2)  D
 ..S ^TMP($J,LIST,+^TMP("DILIST",$J,PSS(2),0),.01)=$P(^TMP("DILIST",$J,PSS(2),0),"^",2)
 ..S ^TMP($J,LIST,"B",$P(^TMP("DILIST",$J,PSS(2),0),"^",2),+^TMP("DILIST",$J,PSS(2),0))=""
 ..S ^TMP($J,LIST,+^TMP("DILIST",$J,PSS(2),0),.02)=$S($P($G(^TMP("DILIST",$J,PSS(2),0)),"^",3)]"":$P(^TMP("DILIST",$J,PSS(2),0),"^",3,4),1:"")
 K ^TMP("DILIST",$J)
 Q
 ;
LOOKUP(PSSFT,PSSD,PSSS,LIST) ;
 ;PSSFT - Free Text name in PHARMACY ORDERABLE ITEM file (#50.7)
 ;PSSD - Index being traversed.
 ;PSSS - Screening information as defined in DIC("S").
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the
 ;Field Number of the data piece being returned.
 ;Returns NAME field (#.01), DOSAGE FORM field (#.02), and INACTIVE DATE field (#.04) of
 ;PHARMACY ORDERABLE ITEM file (#50.7).
 N DIERR,ZZERR,PSS50P7,SCR,PSS
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I $G(PSSFT)']"" S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 D LOOKUP^PSS50P7A
 Q
 ;
SETSCRN ;Set Screen for inactive entries in PHARMACY ORDERABLE ITEM file (#50.7).
 ;Naked reference below refers to ^PS(50.7,+Y,0)
 S SCR("S")="S ND=$P($G(^(0)),U,4) I ND=""""!(ND>PSSFL)"
 Q

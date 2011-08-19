PSS52P6 ;BIR/LDT - API FOR INFORMATION FROM FILE 52.6; 5 Sep 03
 ;;1.0;PHARMACY DATA MANAGEMENT;**85**;9/30/97
 ;
ZERO(PSSIEN,PSSFT,PSSFL,LIST) ;
 ;PSSIEN - IEN of entry in IV ADDITIVES file (#52.6).
 ;PSSFT - Free Text name in IV ADDITIVES file (#52.6).
 ;PSSFL - Inactive flag - "" - All entries.
 ;        FileMan Date - Only entries with no Inactive Date or an Inactive Date greater than this date.
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the
 ;       Field Number of the data piece being returned.
 ;Returns PRINT NAME field (#.01), GENERIC DRUG field (#1), DRUG UNIT field (#2),
 ;NUMBER OF DAYS FOR IV ORDER field (#3), USUAL IV SCHEDULE field (#4), ADMINISTRATION TIMES field (#5),
 ;AVERAGE DRUG COST PER UNIT field (#7), INACTIVATION DATE field (#12), CONCENTRATION field (#13),
 ;MESSAGES field (#14), PHARMACY ORDERABLE ITEM field (#15), and USED IN IV FLUID ORDER ENTRY FIELD (#17)
 ;of IV ADDITIVES file (#52.6).
 N DIERR,ZZERR,PSS52P6,SCR,PSS
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I +$G(PSSIEN)'>0,($G(PSSFT)']"") S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I $G(PSSIEN)]"",+$G(PSSIEN)'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 S SCR("S")=""
 I +$G(PSSFL)>0 N ND D SETSCRN^PSS52P6A
 I +$G(PSSIEN)>0 N PSSIEN2 S PSSIEN2=$$FIND1^DIC(52.6,"","A","`"_PSSIEN,,SCR("S"),"") D
 .I +PSSIEN2'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .S ^TMP($J,LIST,0)=1
 .D GETS^DIQ(52.6,+PSSIEN2,".01;1;2;3;4;5;7;12;13;14;15;17","IE","PSS52P6") S PSS(1)=0
 .F  S PSS(1)=$O(PSS52P6(52.6,PSS(1))) Q:'PSS(1)  D SETZRO^PSS52P6A
 I +$G(PSSIEN)'>0,$G(PSSFT)]"" D
 .I PSSFT["??" D LOOP^PSS52P6A(1) Q
 .D FIND^DIC(52.6,,"@;.01;2","QP",PSSFT,,"B",SCR("S"),,"")
 .I +$G(^TMP("DILIST",$J,0))=0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .I +^TMP("DILIST",$J,0)>0 S ^TMP($J,LIST,0)=+^TMP("DILIST",$J,0) N PSSXX S PSSXX=0 F  S PSSXX=$O(^TMP("DILIST",$J,PSSXX)) Q:'PSSXX  D
 ..S PSSIEN=+^TMP("DILIST",$J,PSSXX,0) K PSS52P6 D GETS^DIQ(52.6,+PSSIEN,".01;1;2;3;4;5;7;12;13;14;15;17","IE","PSS52P6") S PSS(1)=0
 ..F  S PSS(1)=$O(PSS52P6(52.6,PSS(1))) Q:'PSS(1)  D SETZRO^PSS52P6A
 K ^TMP("DILIST",$J)
 Q
 ;
QCODE(PSSIEN,PSSFT,PSSFL,LIST) ;
 ;PSSIEN - IEN of entry in IV ADDITIVES file (#52.6).
 ;PSSFT - Free Text name in IV ADDITIVES file (#52.6).
 ;PSSFL - Inactive flag - 0 or "" - All entries.
 ;        FileMan Date - Only entries with no Inactive Date or an Inactive Date greater than this date.
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the
 ;       Field Number of the data piece being returned.
 ;Returns PRINT NAME field (#.01), QUICK CODE subfile (#52.61), QUICK CODE field (#.01), STRENGTH field (#1),
 ;USUAL INFUSION RATE field (#2), OTHER PRINT INFO field (#3), USUAL IV SCHEDULE field (#4), ADMINISTRATION TIMES
 ;field (#5), USUAL IV SOLUTION field (#6), and MED ROUTE field (#7) of IV ADDITIVES file (#52.6).
 N DIERR,ZZERR,SCR,PSS
 I $G(LIST)']"" Q
 K ^TMP($J,LIST),^TMP("PSS52P6",$J)
 I +$G(PSSIEN)'>0,($G(PSSFT)']"") S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I $G(PSSIEN)]"",+$G(PSSIEN)'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 D QCODE^PSS52P6A
 Q
 ;
ELYTES(PSSIEN,PSSFT,PSSFL,LIST) ;
 ;PSSIEN - IEN of entry in IV ADDITIVES file (#52.6).
 ;PSSFT - Free Text name in IV ADDITIVES file (#52.6).
 ;PSSFL - Inactive flag - 0 or "" - All entries.
 ;        FileMan Date - Only entries with no Inactive Date or an Inactive Date greater than this date.
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the
 ;       Field Number of the data piece being returned.
 ;Returns PRINT NAME field (#.01), ELECTROLYTES subfile (#52.62), ELECTROLYTE field (#.01),
 ;and CONCENTRATION field (#1) of IV ADDITIVES file (#52.6).
 N DIERR,ZZERR,SCR,PSS
 I $G(LIST)']"" Q
 K ^TMP($J,LIST),^TMP("PSS52P6",$J)
 I +$G(PSSIEN)'>0,($G(PSSFT)']"") S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I $G(PSSIEN)]"",+$G(PSSIEN)'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 D ELYTES^PSS52P6B
 Q
 ;
SYNONYM(PSSIEN,PSSFT,PSSFL,LIST) ;
 ;PSSIEN - IEN of entry in IV ADDITIVES file (#52.6).
 ;PSSFT - Free Text name in IV ADDITIVES file (#52.6).
 ;PSSFL - Inactive flag - 0 or "" - All entries.
 ;        FileMan Date - Only entries with no Inactive Date or an Inactive Date greater than this date.
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the
 ;       Field Number of the data piece being returned.
 ;Returns PRINT NAME field (#.01), SYNONYM subfile (#52.63), SYNONYM field (#.01) of IV ADDITIVES file (#52.6).
 N DIERR,ZZERR,SCR,PSS
 I $G(LIST)']"" Q
 K ^TMP($J,LIST),^TMP("PSS52P6",$J)
 I +$G(PSSIEN)'>0,($G(PSSFT)']"") S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I $G(PSSIEN)]"",+$G(PSSIEN)'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 D SYNONYM^PSS52P6B
 Q
 ;
INACTDT(PSSIEN) ;
 ;PSSIEN - IEN of entry in IV ADDITIVES file (#52.6).
 ;Returns INACTIVATION DATE field (#12) of IV ADDITIVES file (#52.6).
 N DIERR,ZZERR,PSS52P6,PSS
 I +$G(PSSIEN)'>0 Q -1_"^"_"NO DATA FOUND"
 I +$G(PSSIEN)>0 D GETS^DIQ(52.6,+PSSIEN,"12","I","PSS52P6") S PSS(1)=0 D
 .I '$D(PSS52P6) S PSSINACT=-1_"^"_"NO DATA FOUND" Q
 .F  S PSS(1)=$O(PSS52P6(52.6,PSS(1))) Q:'PSS(1)  S PSSINACT=PSS52P6(52.6,PSS(1),12,"I")
 Q PSSINACT
 ;
DRGINFO(PSSIEN,PSSFT,PSSFL,LIST) ;
 ;PSSIEN - IEN of entry in IV ADDITIVES file (#52.6).
 ;PSSFT - Free Text name in IV ADDITIVES file (#52.6).
 ;PSSFL - Inactive flag - 0 or "" - All entries.
 ;        FileMan Date - Only entries with no Inactive Date or an Inactive Date greater than this date.
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the
 ;       Field Number of the data piece being returned.
 ;Returns PRINT NAME field (#.01), DRUG INFORMATION subfile (#52.64), DRUG INFORMATION field (#.01)
 ;of IV ADDITIVES file (#52.6).
 N DIERR,ZZERR,PSS52P6,SCR,PSS
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I +$G(PSSIEN)'>0,($G(PSSFT)']"") S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I $G(PSSIEN)]"",+$G(PSSIEN)'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 D DRGINFO^PSS52P6B
 Q
 ;
DRGIEN(PSS50,PSSFL,LIST) ;
 ;PSS50 - IEN of entry in the DRUG file (#50) [required].
 ;PSSFL - Inactive flag - 0 or "" - All entries.
 ;        FileMan Date - Only entries with no Inactive Date or an Inactive Date greater than this date.
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the
 ;       Field Number of the data piece being returned.
 ;Returns PRINT NAME field (#.01) of IV ADDITIVES file (#52.6).
 N DIERR,ZZERR,PSS52P6,SCR,PSS
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I +$G(PSS50)'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 D DRGIEN^PSS52P6B
 Q
 ;
LOOKUP(PSS50P7,PSSFL,LIST) ;
 ;PSS50P7 - IEN of entry in PHARMACY ORDERABLE ITEM file (#50.7).
 ;PSSFL - Inactive flag - 0 or "" - All entries.
 ;        FileMan Date - Only entries with no Inactive Date or an Inactive Date greater than this date.
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the
 ;       Field Number of the data piece being returned.
 ;Returns PRINT NAME field (#.01), MESSAGES field (#14), QUICK CODE subfile (#52.61), QUICK CODE field (#.01),
 ;STRENGTH field (#1), USUAL INFUSION RATE field (#2), OTHER PRINT INFO field (#3), USUAL IV SCHEDULE field (#4),
 ;ADMINISTRATION TIMES field (#5), USUAL IV SOLUTION field (#6), MED ROUTE field (#7), SYNONYM subfile (#52.63),
 ;SYNONYM field (#.01) of IV ADDITIVES file (#52.6).
 N DIERR,ZZERR,PSS52P6,SCR
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I +$G(PSS50P7)'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 D LOOKUP^PSS52P6B
 Q
 ;
POI(PSSOI,PSSFL,LIST) ;
 ;PSSOI - IEN of entry in the PHARMACY ORDERABLE ITEM file (#50.7) [required].
 ;PSSFL - Inactive flag - 0 or "" - All entries.
 ;        FileMan Date - Only entries with no Inactive Date or an Inactive Date greater than this date.
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the
 ;       Field Number of the data piece being returned.
 ;Returns PRINT NAME field (#.01) of IV ADDITIVES file (#52.6).
 N DIERR,ZZERR,PSS52P6,SCR,PSS
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I +$G(PSSOI)'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 D POI^PSS52P6B
 Q
C(PSSQCODE,PSSIEN) ;
 ;PSSQCODE - Text name of QUICKCODE [required].
 ;PSSIEN - IEN of entry in the IV ADDITIVES file (#52.6) [required].
 ;Returns 1 if there's an entry in the C x-ref, otherwise a 0.
 I $G(PSSQCODE)']"" Q 0
 I +$G(PSSIEN)'>0 Q 0
 I $D(^PS(52.6,"C",PSSQCODE,PSSIEN)) Q 1
 Q 0

PSS54 ;BIR/LDT - API FOR INFORMATION FROM FILE 54; 5 Sep 03
 ;;1.0;PHARMACY DATA MANAGEMENT;**85**;9/30/97
 ;
ALL(PSSIEN,PSSFT,LIST) ;
 ;PSSIEN - IEN of entry in RX CONSULT file (#54).
 ;PSSFT - Free Text name in RX CONSULT file (#54).
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the
 ;       Field Number of the data piece being returned.
 ;Returns NAME field (#.01) and TEXT field (#1) of RX CONSULT file (#54).
 N DIERR,ZZERR,PSS54,PSS
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I +$G(PSSIEN)'>0,($G(PSSFT)']"") S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I $G(PSSIEN)]"",+$G(PSSIEN)'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I +$G(PSSIEN)>0 N PSSIEN2 S PSSIEN2=$$FIND1^DIC(54,"","A","`"_PSSIEN,,,"") D
 .I +PSSIEN2'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .S ^TMP($J,LIST,0)=1
 .D GETS^DIQ(54,+PSSIEN2,".01;1*","I","PSS54") S PSS(1)=0
 .F  S PSS(1)=$O(PSS54(54,PSS(1))) Q:'PSS(1)  D SETZRO S PSS(2)=0,^TMP($J,LIST,+PSSIEN,"TXT",0)=0 D
 ..F  S PSS(2)=$O(PSS54(54.1,PSS(2))) Q:'PSS(2)  S ^TMP($J,LIST,+PSSIEN,"TXT",0)=^TMP($J,LIST,+PSSIEN,"TXT",0)+1 D SETTXT
 I +$G(PSSIEN)'>0,$G(PSSFT)]"" D
 .I PSSFT["??" D LOOP Q
 .D FIND^DIC(54,,"@;.01","QP",PSSFT,,"B",,,"")
 .I +$G(^TMP("DILIST",$J,0))=0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .S ^TMP($J,LIST,0)=+^TMP("DILIST",$J,0) N PSSXX S PSSXX=0 F  S PSSXX=$O(^TMP("DILIST",$J,PSSXX)) Q:'PSSXX  D
 ..S PSSIEN=+^TMP("DILIST",$J,PSSXX,0)  K PSS54 D GETS^DIQ(54,+PSSIEN,".01;1*","I","PSS54") S PSS(1)=0
 ..F  S PSS(1)=$O(PSS54(54,PSS(1))) Q:'PSS(1)  D SETZRO S PSS(2)=0,^TMP($J,LIST,+PSSIEN,"TXT",0)=0 D
 ...F  S PSS(2)=$O(PSS54(54.1,PSS(2))) Q:'PSS(2)  S ^TMP($J,LIST,+PSSIEN,"TXT",0)=^TMP($J,LIST,+PSSIEN,"TXT",0)+1 D SETTXT
 K ^TMP("DILIST",$J)
 Q
 ;
LOOKUP(PSSSRCH,LIST) ;
 ;PSSSRCH - IEN of entry in RX CONSULT file (#54).
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the
 ;       Field Number of the data piece being returned.
 ;Returns NAME field (#.01) of RX CONSULT file (#54).
 N DIERR,ZZERR
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I $G(PSSSRCH)']"" S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 D FIND^DIC(54,,"@;.01;","QP",PSSSRCH,,"B",,,"")
 I +$G(^TMP("DILIST",$J,0))=0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 S ^TMP($J,LIST,0)=+^TMP("DILIST",$J,0) N PSSXX S PSSXX=0 F  S PSSXX=$O(^TMP("DILIST",$J,PSSXX)) Q:'PSSXX  D
 .S ^TMP($J,LIST,+^TMP("DILIST",$J,PSSXX,0),.01)=$P($G(^TMP("DILIST",$J,PSSXX,0)),U,2)
 .S ^TMP($J,LIST,"B",$P($G(^TMP("DILIST",$J,PSSXX,0)),U,2),+^TMP("DILIST",$J,PSSXX,0))=""
 K ^TMP("DILIST",$J)
 Q
 ;
SETZRO ;
 S ^TMP($J,LIST,+PSS(1),.01)=$G(PSS54(54,PSS(1),.01,"I"))
 S ^TMP($J,LIST,"B",$G(PSS54(54,PSS(1),.01,"I")),+PSS(1))=""
 Q
 ;
SETTXT ;
 S ^TMP($J,LIST,+PSSIEN,"TXT",+PSS(2),.01)=$G(PSS54(54.1,PSS(2),.01,"I"))
 Q
 ;
LOOP ;
 N PSSIEN,CNT
 S (PSSIEN,CNT)=0 F  S PSSIEN=$O(^PS(54,PSSIEN)) Q:'PSSIEN  D
 .K PSS54 D GETS^DIQ(54,+PSSIEN,".01;1*","I","PSS54") S PSS(1)=0,CNT=CNT+1
 .F  S PSS(1)=$O(PSS54(54,PSS(1))) Q:'PSS(1)  D SETZRO S PSS(2)=0,^TMP($J,LIST,+PSSIEN,"TXT",0)=0 D
 ..F  S PSS(2)=$O(PSS54(54.1,PSS(2))) Q:'PSS(2)  S ^TMP($J,LIST,+PSSIEN,"TXT",0)=^TMP($J,LIST,+PSSIEN,"TXT",0)+1 D SETTXT
 S ^TMP($J,LIST,0)=$S(CNT>0:CNT,1:"-1^NO DATA FOUND")
 Q

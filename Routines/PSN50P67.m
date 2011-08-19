PSN50P67 ;BIR/LDT - API FOR INFORMATION FROM FILE 50.607; 5 Sep 03
 ;;4.0; NATIONAL DRUG FILE;**80**; 30 Oct 98
 ;
ALL(PSNIEN,PSNFT,PSNFL,LIST) ;
 ;PSNIEN - IEN of entry in DRUG UNITS file (#50.607).
 ;PSNFT - Free Text name in DRUG UNITS file (#50.607).
 ;PSNFL - Inactive flag - "" - All entries.
 ;        FileMan Date - Only entries with no Inactive Date or an Inactive Date greater than this date.
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where
 ;       Field Number is the Field Number of the data piece being returned.
 ;Returns NAME field (#.01), and INACTIVATION DATE field (#1) of DRUG UNITS file (#50.607).
 N DIERR,ZZERR,PSN50P67,PSN,SCR
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I $G(PSNIEN)']"",($G(PSNFT)']"") S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I $G(PSNIEN)]"",(+$G(PSNIEN)'>0) S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 S SCR("S")=""
 I +$G(PSNFL)>0 N ND D SETSCRN
 I $G(PSNIEN)]"" N PSNIEN2 S PSNIEN2=$$FIND1^DIC(50.607,"","B","`"_PSNIEN,,SCR("S"),"") D
 .I +PSNIEN2'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .S ^TMP($J,LIST,0)=1
 .D GETS^DIQ(50.607,+PSNIEN2,".01;1","IE","PSN50P67") S PSN(1)=0
 .F  S PSN(1)=$O(PSN50P67(50.607,PSN(1))) Q:'PSN(1)  D SETZRO
 I $G(PSNIEN)="",$G(PSNFT)]"" D
 .I PSNFT["??" D LOOP Q
 .D FIND^DIC(50.607,,"@;.01;1","QP",PSNFT,,"B",SCR("S"),,"")
 .I +$G(^TMP("DILIST",$J,0))=0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .I +^TMP("DILIST",$J,0)>0 S ^TMP($J,LIST,0)=+^TMP("DILIST",$J,0) N PSNXX S PSNXX=0 F  S PSNXX=$O(^TMP("DILIST",$J,PSNXX)) Q:'PSNXX  D
 ..S PSNIEN=+^TMP("DILIST",$J,PSNXX,0) K PSN50P67 D GETS^DIQ(50.607,+PSNIEN,".01;1","IE","PSN50P67") S PSN(1)=0
 ..F  S PSN(1)=$O(PSN50P67(50.607,PSN(1))) Q:'PSN(1)  D SETZRO
 K ^TMP("DILIST",$J)
 Q
 ;
SETZRO ;
 S ^TMP($J,LIST,+PSN(1),.01)=$G(PSN50P67(50.607,PSN(1),.01,"I"))
 S ^TMP($J,LIST,"B",$G(PSN50P67(50.607,PSN(1),.01,"I")),+PSN(1))=""
 S ^TMP($J,LIST,+PSN(1),1)=$S($G(PSN50P67(50.607,PSN(1),1,"I"))="":"",1:PSN50P67(50.607,PSN(1),1,"I")_"^"_PSN50P67(50.607,PSN(1),1,"E"))
 Q
 ;
LOOP ;
 N PSNIEN
 S ^TMP($J,LIST,0)=0,PSNIEN=0 F  S PSNIEN=$O(^PS(50.607,PSNIEN)) Q:'PSNIEN  D
 .I +$G(PSNFL)>0,$P($G(^PS(50.607,PSNIEN,0)),"^",2)]"",$P($G(^(0)),"^",2)'>PSNFL Q
 .K PSN50P67 D GETS^DIQ(50.607,+PSNIEN,".01;1","IE","PSN50P67") S PSN(1)=0 D
 ..F  S PSN(1)=$O(PSN50P67(50.607,PSN(1))) Q:'PSN(1)   D SETZRO S ^TMP($J,LIST,0)=^TMP($J,LIST,0)+1
 Q
 ;
SETSCRN ;
 S SCR("S")="S ND=$P($G(^PS(50.607,+Y,0)),""^"",2) I ND=""""!(ND>PSNFL)"
 Q

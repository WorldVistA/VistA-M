PSN50P6 ;BIR/LDT - API FOR INFORMATION FROM FILE 50.6; 5 Sep 03
 ;;4.0; NATIONAL DRUG FILE;**80**; 30 Oct 98
 ;
ZERO(PSNIEN,PSNFT,PSNFL,PSNX,LIST) ;
 ;PSNIEN - IEN of entry in VA GENERIC file (#50.6).
 ;PSNFT - Free Text name in VA GENERIC file (#50.6).
 ;PSNFL - Inactive flag - "" - All entries
 ;                        FileMan Date - Only entries with no Inactive Date or an Inactive Date
 ;                        greater than this date.
 ;PSNX - exact match flag 1 - exact match wanted                        
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the
 ;       Field Number of the data piece being returned.
 ;Returns NAME field (#.01), and INACTIVE DATE field (#1) of VA GENERIC file (#50.6).
 N DIERR,ZZERR,PSNP50P6,SCR,PSN
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I $G(PSNIEN)']"",($G(PSNFT)']"") S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I $G(PSNIEN)]"",(+$G(PSNIEN)'>0) S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 S SCR("S")=""
 I +$G(PSNFL)>0 N ND D SETSCRN
 I $G(PSNIEN)]"" N PSNIEN2 S PSNIEN2=$$FIND1^DIC(50.6,"","A","`"_PSNIEN,,SCR("S"),"") D
 .I +PSNIEN2'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .S ^TMP($J,LIST,0)=1
 .D GETS^DIQ(50.6,+PSNIEN2,".01;1","IE","PSNP50P6") S PSN(1)=0
 .F  S PSN(1)=$O(PSNP50P6(50.6,PSN(1))) Q:'PSN(1)  D SETALL
 I $G(PSNIEN)="",$G(PSNFT)]"" D
 .I PSNFT["??" D LOOP Q
 .D FIND^DIC(50.6,,"@;.01;","QP"_$S($G(PSNX)=1:"X",1:""),PSNFT,,"B",SCR("S"),,"")
 .I +$G(^TMP("DILIST",$J,0))=0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .I +^TMP("DILIST",$J,0)>0 S ^TMP($J,LIST,0)=+^TMP("DILIST",$J,0) N PSNXX S PSNXX=0 F  S PSNXX=$O(^TMP("DILIST",$J,PSNXX)) Q:'PSNXX  D
 ..S PSNIEN=+^TMP("DILIST",$J,PSNXX,0) K PSNP50P6 D GETS^DIQ(50.6,+PSNIEN,".01;1","IE","PSNP50P6") S PSN(1)=0
 ..F  S PSN(1)=$O(PSNP50P6(50.6,PSN(1))) Q:'PSN(1)   D SETALL
 K ^TMP("DILIST",$J)
 Q
 ;
ROOT() ;
 ;get version dependent NDF reference
 I $$VERSION^XPDUTL("PSN")<4 Q "^PSNDF("
 Q "^PSNDF(50.6," ; new reference for ver 4.0
 ;
SETALL ;
 S ^TMP($J,LIST,+PSN(1),.01)=$G(PSNP50P6(50.6,PSN(1),.01,"I"))
 S ^TMP($J,LIST,"B",$G(PSNP50P6(50.6,PSN(1),.01,"I")),+PSN(1))=""
 S ^TMP($J,LIST,+PSN(1),1)=$S($G(PSNP50P6(50.6,PSN(1),1,"I"))="":"",1:PSNP50P6(50.6,PSN(1),1,"I")_"^"_PSNP50P6(50.6,PSN(1),1,"E"))
 Q
 ;
SETSCRN ;Set Screen for inactive VA Generic
 ;Naked reference below refers to ^PS(50.6,+Y,0)
 S SCR("S")="S ND=$P($G(^(0)),U,2) I ND=""""!(ND>PSNFL)"
 Q
 ;
LOOP ;
 N PSNIEN,CNT S CNT=0
 S PSNIEN=0 F  S PSNIEN=$O(^PSNDF(50.6,PSNIEN)) Q:'PSNIEN  D
 .I $G(PSNFL),$P($G(^PSNDF(50.6,PSNIEN,0)),"^",2),$P($G(^(0)),"^",2)'>PSNFL Q 
 .K PSNP50P6 D GETS^DIQ(50.6,+PSNIEN,".01;1","IE","PSNP50P6") S PSN(1)=0 D
 ..F  S PSN(1)=$O(PSNP50P6(50.6,PSN(1))) Q:'PSN(1)   D SETALL S CNT=CNT+1
 S ^TMP($J,LIST,0)=+CNT
 Q

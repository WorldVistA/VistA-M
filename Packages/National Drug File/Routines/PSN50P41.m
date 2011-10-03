PSN50P41 ;BIR/LDT - API FOR INFORMATION FROM FILE 50.416; 5 Sep 03
 ;;4.0; NATIONAL DRUG FILE;**80**; 30 Oct 98
 ;
B() ;RETURNS THE GLOBAL ROOT OF THE "B" CROSSREFERENCE IN ^PS(50.416
 Q "^PS(50.416,""B"")"
 ;
ZERO(PSNIEN,PSNFT,PSNFL,LIST) ;
 ;PSNIEN - IEN of entry in DRUG INGREDIENTS file (#50.416).
 ;PSNFT - Free Text name in DRUG INGREDIENTS file (#50.416).
 ;PSNFL - Inactive flag - "" - All entries.
 ;        FileMan Date - Only entries with no Inactive Date or an Inactive Date greater than this date.
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the
 ;       Field Number of the data piece being returned.
 ;Returns NAME field (#.01), PRIMARY INGREDIENT field (#2), and INACTIVATION DATE field (#3)
 ;of DRUG INGREDIENTS file (#50.416).
 N DIERR,ZZERR,PSN50P41,SCR,PSN
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I $G(PSNIEN)']"",($G(PSNFT)']"") S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I $G(PSNIEN)]"",(+$G(PSNIEN)'>0) S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 S SCR("S")=""
 I +$G(PSNFL)>0 D SETSCRN^PSN50P4A
 I $G(PSNIEN)]"" N PSNIEN2 S PSNIEN2=$$FIND1^DIC(50.416,"","A","`"_PSNIEN,,SCR("S"),"") D
 .I +PSNIEN2'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .S ^TMP($J,LIST,0)=1
 .D GETS^DIQ(50.416,+PSNIEN2,".01;2;3","IE","PSN50P41") S PSN(1)=0
 .F  S PSN(1)=$O(PSN50P41(50.416,PSN(1))) Q:'PSN(1)  D SETALL^PSN50P4A
 I $G(PSNIEN)="",$G(PSNFT)]"" D
 .I PSNFT["??" D LOOP^PSN50P4A(1) Q
 .D FIND^DIC(50.416,,"@;.01;","QP",PSNFT,,"B",SCR("S"),,"")
 .I +$G(^TMP("DILIST",$J,0))=0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .I +^TMP("DILIST",$J,0)>0 S ^TMP($J,LIST,0)=+^TMP("DILIST",$J,0) N PSNXX S PSNXX=0 F  S PSNXX=$O(^TMP("DILIST",$J,PSNXX)) Q:'PSNXX  D
 ..S PSNIEN=+^TMP("DILIST",$J,PSNXX,0) K PSN50P41 D GETS^DIQ(50.416,+PSNIEN,".01;2;3","IE","PSN50P41") S PSN(1)=0
 ..F  S PSN(1)=$O(PSN50P41(50.416,PSN(1))) Q:'PSN(1)   D SETALL^PSN50P4A K PSN50P41
 K ^TMP("DILIST",$J)
 Q
 ;
NAME(PSNFT,LIST) ;
 ;PSNFT - Free Text name in DRUG INGREDIENTS file (#50.416).
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the
 ;       Field Number of the data piece being returned.
 ;Returns NAME field (#.01), and PRIMARY INGREDIENT field (#2) of DRUG INGREDIENTS file (#50.416).
 N DIERR,ZZERR,PSN50P41,PSN
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I ($G(PSNFT)']"") S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I PSNFT["??" D LOOP2^PSN50P4A Q
 D FIND^DIC(50.416,,"@;.01;","QP",PSNFT,,"P",,,"")
 I +$G(^TMP("DILIST",$J,0))=0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I +^TMP("DILIST",$J,0)>0 S ^TMP($J,LIST,0)=+^TMP("DILIST",$J,0) N PSNXX S PSNXX=0 F  S PSNXX=$O(^TMP("DILIST",$J,PSNXX)) Q:'PSNXX  D
 .S PSNIEN=+^TMP("DILIST",$J,PSNXX,0) K PSN50P41 D GETS^DIQ(50.416,+PSNIEN,".01;2;","IE","PSN50P41") S PSN(1)=0
 .F  S PSN(1)=$O(PSN50P41(50.416,PSN(1))) Q:'PSN(1)   D SETALL2^PSN50P4A K PSN50P41
 K ^TMP("DILIST",$J)
 Q
 ;
ID(PSNIEN,PSNFT,LIST) ;
 ;PSNIEN - IEN of entry in DRUG INGREDIENTS file (#50.416).
 ;PSNFT - Free Text name in DRUG INGREDIENTS file (#50.416).
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the
 ;       Field Number of the data piece being returned.
 ;Returns DRUG IDENTIFIER field (#.01) of the DRUG IDENTIFIER multiple (#50.4161) of DRUG INGREDIENTS file (#50.416).
 N DIERR,ZZERR,PSN50P41,PSN
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I +$G(PSNIEN)'>0,($G(PSNFT)']"") S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I $G(PSNIEN)]"",(+$G(PSNIEN)'>0) S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I +$G(PSNIEN)>0 N PSNIEN2 S PSNIEN2=$$FIND1^DIC(50.416,"","A","`"_PSNIEN,,,"") D
 .I +PSNIEN2'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .S ^TMP($J,LIST,0)=1
 .S PSNIEN=PSNIEN2 I $O(^PS(50.416,+PSNIEN,1,0)),'$D(^PS(50.416,+PSNIEN,1,0)) D SETHDR^PSN50P4A
 .D GETS^DIQ(50.416,+PSNIEN2,".01;1*","IE","^TMP(""PSNAPD"",$J)") S PSN(1)=0
 .F  S PSN(1)=$O(^TMP("PSNAPD",$J,50.416,PSN(1))) Q:'PSN(1)  D
 ..S ^TMP($J,LIST,+PSN(1),.01)=$G(^TMP("PSNAPD",$J,50.416,PSN(1),.01,"I"))
 ..S ^TMP($J,LIST,"B",$G(^TMP("PSNAPD",$J,50.416,PSN(1),.01,"I")),+PSN(1))=""
 ..S (CNT,PSN(2))=0 F  S PSN(2)=$O(^TMP("PSNAPD",$J,50.4161,PSN(2))) Q:'PSN(2)  D
 ...S ^TMP($J,LIST,+PSN(1),"ID",+PSN(2),.01)=$G(^TMP("PSNAPD",$J,50.4161,PSN(2),.01,"I")),CNT=CNT+1
 ..S ^TMP($J,LIST,+PSN(1),"ID",0)=$S($G(CNT)>0:CNT,1:"-1^NO DATA FOUND")
 I $G(PSNIEN)="",$G(PSNFT)]"" D
 .I PSNFT["??" D LOOP^PSN50P4A(2) Q
 .D FIND^DIC(50.416,,"@;.01;","QP",PSNFT,,"B",,,"")
 .I +$G(^TMP("DILIST",$J,0))=0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .I +^TMP("DILIST",$J,0)>0 S ^TMP($J,LIST,0)=+^TMP("DILIST",$J,0) N PSNXX S PSNXX=0 F  S PSNXX=$O(^TMP("DILIST",$J,PSNXX)) Q:'PSNXX  D
 ..S PSNIEN=+^TMP("DILIST",$J,PSNXX,0)
 ..I $O(^PS(50.416,+PSNIEN,1,0)),'$D(^PS(50.416,+PSNIEN,1,0)) D SETHDR^PSN50P4A
 ..K ^TMP("PSNAPD",$J) D GETS^DIQ(50.416,+PSNIEN,".01;1*","IE","^TMP(""PSNAPD"",$J)") S PSN(1)=0
 ..F  S PSN(1)=$O(^TMP("PSNAPD",$J,50.416,PSN(1))) Q:'PSN(1)   D  K PSN50P41
 ...S ^TMP($J,LIST,+PSN(1),.01)=$G(^TMP("PSNAPD",$J,50.416,PSN(1),.01,"I"))
 ...S ^TMP($J,LIST,"B",$G(^TMP("PSNAPD",$J,50.416,PSN(1),.01,"I")),+PSN(1))=""
 ...S (CNT,PSN(2))=0 F  S PSN(2)=$O(^TMP("PSNAPD",$J,50.4161,PSN(2))) Q:'PSN(2)  D
 ....S ^TMP($J,LIST,+PSN(1),"ID",+PSN(2),.01)=$G(^TMP("PSNAPD",$J,50.4161,PSN(2),.01,"I")),CNT=CNT+1
 ...S ^TMP($J,LIST,+PSN(1),"ID",0)=$S($G(CNT)>0:CNT,1:"-1^NO DATA FOUND")
 K ^TMP("DILIST",$J),^TMP("PSNAPD",$J)
 Q
 ;
APS(PSNPI,LIST) ;
 ;PSNPI - PRIMARY INGREDIENT field (#2) of the DRUG INGREDIENTS file (#50.416)
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the
 ;       Field Number of the data piece being returned.
 ;Returns DRUG IDENTIFIER field (#.01) of the DRUG IDENTIFIER multiple (#50.4161) of DRUG INGREDIENTS file (#50.416).
 N DIERR,ZZERR,PSN50P41,PSN,CNT
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I +$G(PSNPI)'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 ;Naked reference below refers to ^PS(50.416,+Y,0)
 S SCR("S")="S ND=$G(^(0)) I $P(ND,""^"",2)=PSNPI"
 I +$G(PSNPI)>0 D FIND^DIC(50.416,,"@;.01","QP",PSNPI,,"APS",SCR("S"),"")
 I +^TMP("DILIST",$J,0)'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 S ^TMP($J,LIST,0)=+^TMP("DILIST",$J,0)
 S PSN(1)=0 F  S PSN(1)=$O(^TMP("DILIST",$J,PSN(1)))  Q:'PSN(1)  D
 .S PSNIEN=+^TMP("DILIST",$J,PSN(1),0)
 .I $O(^PS(50.416,+PSNIEN,1,0)),'$D(^PS(50.416,+PSNIEN,1,0)) D SETHDR^PSN50P4A
 .K ^TMP("PSNAPS",$J) D GETS^DIQ(50.416,+PSNIEN,".01;1*","IE","^TMP(""PSNAPS"",$J)") S PSN(2)=0
 .F  S PSN(2)=$O(^TMP("PSNAPS",$J,50.416,PSN(2))) Q:'PSN(2)  D
 ..S ^TMP($J,LIST,+PSN(2),.01)=$G(^TMP("PSNAPS",$J,50.416,PSN(2),.01,"I"))
 ..S ^TMP($J,LIST,"APS",$G(^TMP("PSNAPS",$J,50.416,PSN(2),.01,"I")),+PSN(2))=""
 ..S (CNT,PSN(3))=0 F  S PSN(3)=$O(^TMP("PSNAPS",$J,50.4161,PSN(3))) Q:'PSN(3)  D
 ...S ^TMP($J,LIST,+PSN(2),"ID",+PSN(3),.01)=$G(^TMP("PSNAPS",$J,50.4161,PSN(3),.01,"I")),CNT=CNT+1
 ...S ^TMP($J,LIST,+PSN(2),"ID",0)=$S($G(CNT)>0:CNT,1:"-1^NO DATA FOUND")
 K ^TMP("DILIST",$J),^TMP("PSNAPS",$J)
 Q
 ;
APD(PSNID,LIST) ;
 ;PSNID - DRUG IDENTIFIER field (#.01) of the DRUG IDENTIFIER multiple of the DRUG INGREDIENTS file (#50.416) 
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the
 ;       Field Number of the data piece being returned.
 ;Returns NAME field (#.01), PRIMARY INGREDIENTS field (#2), and DRUG IDENTIFIER field (#.01)
 ;of the DRUG IDENTIFIER multiple (#50.4161) of DRUG INGREDIENTS file (#50.416).
 N DIERR,ZZERR,PSN,CNT,CNT1
 I $G(LIST)']"" Q
 K ^TMP($J,LIST),^TMP("PSNAPD",$J)
 I $G(PSNID)']"" S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I $L(PSNID)>30!($L(PSNID)<3)!'(PSNID?1.N1"A"1.N) S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 D FIND^DIC(50.416,,"@;.01","QP",PSNID,,"APD",,,"")
 I +^TMP("DILIST",$J,0)'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 ;S ^TMP($J,LIST,0)=+^TMP("DILIST",$J,0)
 S (CNT1,PSN(1))=0 F  S PSN(1)=$O(^TMP("DILIST",$J,PSN(1))) Q:'PSN(1)  D
 .S PSNIEN=+^TMP("DILIST",$J,PSN(1),0)
 .I $O(^PS(50.416,+PSNIEN,1,0)),'$D(^PS(50.416,+PSNIEN,1,0)) D SETHDR^PSN50P4A
 .K ^TMP("PSNAPD",$J) D GETS^DIQ(50.416,+PSNIEN,".01;2;1*","IE","^TMP(""PSNAPD"",$J)") D
 ..Q:'$D(^PS(50.416,"APD",PSNID,+PSNIEN))
 ..S CNT1=CNT1+1
 ..S (CNT,PSN(2))=0 F  S PSN(2)=$O(^TMP("PSNAPD",$J,50.4161,PSN(2))) Q:'PSN(2)  D
 ...S ^TMP($J,LIST,+PSNIEN,"ID",+PSN(2),.01)=$G(^TMP("PSNAPD",$J,50.4161,PSN(2),.01,"I")),CNT=CNT+1
 ..S ^TMP($J,LIST,+PSNIEN,"ID",0)=$S($G(CNT)>0:CNT,1:"-1^NO DATA FOUND")
 ..S PSN(3)=0 F  S PSN(3)=$O(^TMP("PSNAPD",$J,50.416,PSN(3))) Q:'PSN(3)  D
 ...S ^TMP($J,LIST,+PSN(3),.01)=$G(^TMP("PSNAPD",$J,50.416,PSN(3),.01,"I"))
 ...S ^TMP($J,LIST,"APD",$G(^TMP("PSNAPD",$J,50.416,PSN(3),.01,"I")),+PSN(3))=""
 ...S ^TMP($J,LIST,+PSN(3),2)=$S($G(^TMP("PSNAPD",$J,50.416,PSN(3),2,"I"))="":"",1:^TMP("PSNAPD",$J,50.416,PSN(3),2,"I")_"^"_^TMP("PSNAPD",$J,50.416,PSN(3),2,"E"))
 S ^TMP($J,LIST,0)=$S(CNT1>0:CNT1,1:"-1^NO DATA FOUND")
 K ^TMP("DILIST",$J),^TMP("PSNAPD",$J)
 Q

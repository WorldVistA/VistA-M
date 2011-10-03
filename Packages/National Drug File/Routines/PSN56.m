PSN56 ;BIR/LDT - API FOR INFORMATION FROM FILE 56; 5 Sep 03
 ;;4.0; NATIONAL DRUG FILE;**80**; 30 Oct 98
 ;
ALL(PSNIEN,PSNFT,LIST) ;
 ;PSNIEN - IEN of entry in DRUG INTERACTION file (#56).
 ;PSNFT - Free Text name in DRUG INTERACTION file (#56).
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the
 ;               Field Number of the data piece being returned.
 ;Returns NAME field (#.01), INGREDIENT field (#1), INGREDIENT2 field (#2), SEVERITY field (#3),
 ;NATIONALLY ENTERED field (#4), TOTAL INDEXES field (#5), LOACLLY EDITED field (#6), and
 ;INACTIVATION DATE field (#7) of DRUG INTERACTION file (#56).
 N DIERR,ZZERR,PSNP56,PSN
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I $G(PSNIEN)']"",($G(PSNFT)']"") S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I $G(PSNIEN)]"",(+$G(PSNIEN)'>0) S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I $G(PSNIEN)]"" N PSNIEN2 S PSNIEN2=$$FIND1^DIC(56,"","A","`"_PSNIEN,,,"") D
 .I +PSNIEN2'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .S ^TMP($J,LIST,0)=1
 .D GETS^DIQ(56,+PSNIEN2,".01;1;2;3;4;5;6;7","IE","PSNP56") S PSN(1)=0
 .F  S PSN(1)=$O(PSNP56(56,PSN(1))) Q:'PSN(1)  D SETALL
 I $G(PSNIEN)="",$G(PSNFT)]"" D
 .I PSNFT["??" D LOOP Q
 .D FIND^DIC(56,,"@;.01;","QP",PSNFT,,"B",,,"")
 .I +$G(^TMP("DILIST",$J,0))=0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .S ^TMP($J,LIST,0)=+^TMP("DILIST",$J,0)
 .I +^TMP("DILIST",$J,0)>0 N PSNXX S PSNXX=0 F  S PSNXX=$O(^TMP("DILIST",$J,PSNXX)) Q:'PSNXX  D
 ..S PSNIEN=+^TMP("DILIST",$J,PSNXX,0) K PSNP56 D GETS^DIQ(56,+PSNIEN,".01;1;2;3;4;5;6;7","IE","PSNP56") S PSN(1)=0
 ..F  S PSN(1)=$O(PSNP56(56,PSN(1))) Q:'PSN(1)   D SETALL
 K ^TMP("DILIST",$J)
 Q
 ;
SETALL ;
 S ^TMP($J,LIST,+PSN(1),.01)=$G(PSNP56(56,PSN(1),.01,"I"))
 S ^TMP($J,LIST,"B",$G(PSNP56(56,PSN(1),.01,"I")),+PSN(1))=""
 S ^TMP($J,LIST,+PSN(1),1)=$S($G(PSNP56(56,PSN(1),1,"I"))="":"",1:PSNP56(56,PSN(1),1,"I")_"^"_PSNP56(56,PSN(1),1,"E"))
 S ^TMP($J,LIST,+PSN(1),2)=$S($G(PSNP56(56,PSN(1),2,"I"))="":"",1:PSNP56(56,PSN(1),2,"I")_"^"_PSNP56(56,PSN(1),2,"E"))
 S ^TMP($J,LIST,+PSN(1),3)=$S($G(PSNP56(56,PSN(1),3,"I"))="":"",1:PSNP56(56,PSN(1),3,"I")_"^"_PSNP56(56,PSN(1),3,"E"))
 S ^TMP($J,LIST,+PSN(1),4)=$S($G(PSNP56(56,PSN(1),4,"I"))="":"",1:PSNP56(56,PSN(1),4,"I")_"^"_PSNP56(56,PSN(1),4,"E"))
 S ^TMP($J,LIST,+PSN(1),5)=$G(PSNP56(56,PSN(1),5,"I"))
 S ^TMP($J,LIST,+PSN(1),7)=$S($G(PSNP56(56,PSN(1),7,"I"))="":"",1:PSNP56(56,PSN(1),7,"I")_"^"_PSNP56(56,PSN(1),7,"E"))
 S ^TMP($J,LIST,+PSN(1),6)=$S($G(PSNP56(56,PSN(1),6,"I"))="":"",1:PSNP56(56,PSN(1),6,"I")_"^"_PSNP56(56,PSN(1),6,"E"))
 Q
 ;
SETING ;
 S ^TMP($J,LIST,+PSN(1),.01)=$G(PSNP56(56,PSN(1),.01,"I"))
 S ^TMP($J,LIST,"APD",$G(PSNP56(56,PSN(1),.01,"I")),+PSN(1))=""
 S ^TMP($J,LIST,+PSN(1),1)=$S($G(PSNP56(56,PSN(1),1,"I"))="":"",1:PSNP56(56,PSN(1),1,"I")_"^"_PSNP56(56,PSN(1),1,"E"))
 S ^TMP($J,LIST,+PSN(1),2)=$S($G(PSNP56(56,PSN(1),2,"I"))="":"",1:PSNP56(56,PSN(1),2,"I")_"^"_PSNP56(56,PSN(1),2,"E"))
 S ^TMP($J,LIST,+PSN(1),3)=$S($G(PSNP56(56,PSN(1),3,"I"))="":"",1:PSNP56(56,PSN(1),3,"I")_"^"_PSNP56(56,PSN(1),3,"E"))
 S ^TMP($J,LIST,+PSN(1),7)=$S($G(PSNP56(56,PSN(1),7,"I"))="":"",1:PSNP56(56,PSN(1),7,"I")_"^"_PSNP56(56,PSN(1),7,"E"))
 Q
 ;
LOOP ;
 S PSNIEN=0,^TMP($J,LIST,0)=0 F  S PSNIEN=$O(^PS(56,PSNIEN)) Q:'PSNIEN  D
 .K PSNP56 D GETS^DIQ(56,+PSNIEN,".01;1;2;3;4;5;6;7","IE","PSNP56") S ^TMP($J,LIST,0)=^TMP($J,LIST,0)+1,PSN(1)=0 D
 ..F  S PSN(1)=$O(PSNP56(56,PSN(1))) Q:'PSN(1)   D SETALL
 Q
 ;
IEN(PSNING1,PSNING2,PSNFL,LIST) ;
 ;PSNING1 - Drug Identifier for Ingredient 1.
 ;PSNING2 - Drug Identifier for Ingredient 2.
 ;PSNFL   - Inactive flag - "" - All entries
 ;          FileMan Date - Only entries with no Inactive Date or an Inactive Date greater than this date.
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the
 ;       Field Number of the data piece being returned.
 ;Returns NAME field (#.01), INGREDIENT field (#1), INGREDIENT2 field (#2), and INACTIVATION DATE field (#7)
 ;of DRUG INTERACTION file (#56).
 N PSNNXX,PSNXTOT,PSNXNODE,PSNP56,PSN
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I $G(PSNING1)']""!($G(PSNING2)']"") S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 S PSNXTOT=0
 F PSNNXX=0:0 S PSNNXX=$O(^PS(56,"APD",PSNING1,PSNING2,PSNNXX)) Q:'PSNNXX  D
 .I '$D(^PS(56,PSNNXX,0)) Q
 .S PSNXNODE=$G(^PS(56,PSNNXX,0)) I $P(PSNXNODE,"^")="" Q
 .I $G(PSNFL),$P(PSNXNODE,"^",7),$P(PSNXNODE,"^",7)'>PSNFL Q
 .K PSNP56 D GETS^DIQ(56,+PSNNXX,".01;1;2;3;7","IE","PSNP56")  S PSN(1)=0 D
 ..F  S PSN(1)=$O(PSNP56(56,PSN(1))) Q:'PSN(1)   D SETING S PSNXTOT=PSNXTOT+1
 S ^TMP($J,LIST,0)=$S(+$G(PSNXTOT)>0:PSNXTOT,1:-1_"^"_"NO DATA FOUND")
 Q

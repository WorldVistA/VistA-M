PSS50F ;BIR/LDT - API FOR INFORMATION FROM FILE 50; 5 Sep 03
 ;;1.0;PHARMACY DATA MANAGEMENT;**85,91**;9/30/97
 ;External reference to DD(50,0,"IX" supported by DBIA 4323
 ;External reference to PRC(441 is supported by DBIA 214
 ;
OLDNM ;
 ;PSSIEN - IEN of entry in 50
 ;PSSFT - Free Text name in 50
 ;PSSFL - Inactive flag - "" - All entries
 ;                        FileMan Date - Only entries with no Inactive Date or an Inactive Date greater than this date.
 ;PSSPK - Application Package's Use - "" - All entries
 ;                                         Alphabetic codes that represent the DHCP packages that consider this drug to be
 ;                                         part of their formulary.
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the Field Number of the data
 ;       piece being returned.
 N DIERR,ZZERR,PSSP50,SCR,PSS,CNT
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I +$G(PSSIEN)'>0,($G(PSSFT)']"") S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I $G(PSSIEN)]"",+$G(PSSIEN)'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 S SCR("S")="",CNT=0
 I +$G(PSSFL)>0!($G(PSSPK)]"") N PSS5ND,PSSZ3,PSSZ4 D SETSCRN^PSS50A
 I $G(PSSIEN)]"" N PSSIEN2 S PSSIEN2=$$FIND1^DIC(50,"","A","`"_PSSIEN,,SCR("S"),"") D
 .I +PSSIEN2'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .S ^TMP($J,LIST,0)=1
 .K ^TMP($J,"PSS50") D GETS^DIQ(50,+PSSIEN2,".01;900*","IE","^TMP($J,""PSS50""") S PSS(1)=0
 .F  S PSS(1)=$O(^TMP($J,"PSS50",50,PSS(1))) Q:'PSS(1)  D
 ..S ^TMP($J,LIST,+PSS(1),.01)=^TMP($J,"PSS50",50,PSS(1),.01,"I")
 ..S ^TMP($J,LIST,"B",^TMP($J,"PSS50",50,PSS(1),.01,"I"),+PSS(1))=""
 ..S PSS(2)=0 F  S PSS(2)=$O(^TMP($J,"PSS50",50.01,PSS(2))) Q:'PSS(2)  D SETOLDNM S CNT=CNT+1
 ..S ^TMP($J,LIST,+PSS(1),"OLD",0)=$S(CNT>0:CNT,1:"-1^NO DATA FOUND")
 I +$G(PSSIEN)'>0,$G(PSSFT)]"" D
 .I PSSFT["??" D LOOP(1) Q
 .D FIND^DIC(50,,"@;.01","QP",PSSFT,,"B",SCR("S"),,"")
 .I +$G(^TMP("DILIST",$J,0))=0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .I +^TMP("DILIST",$J,0)>0 S ^TMP($J,LIST,0)=+^TMP("DILIST",$J,0) N PSSXX S PSSXX=0 F  S PSSXX=$O(^TMP("DILIST",$J,PSSXX)) Q:'PSSXX  D
 ..S PSSIEN=+^TMP("DILIST",$J,PSSXX,0) K ^TMP($J,"PSS50") S CNT=0 D GETS^DIQ(50,+PSSIEN,".01;900*","IE","^TMP($J,""PSS50""") S PSS(1)=0
 ..F  S PSS(1)=$O(^TMP($J,"PSS50",50,PSS(1))) Q:'PSS(1)  D 
 ...S ^TMP($J,LIST,+PSS(1),.01)=^TMP($J,"PSS50",50,PSS(1),.01,"I")
 ...S ^TMP($J,LIST,"B",^TMP($J,"PSS50",50,PSS(1),.01,"I"),+PSS(1))=""
 ...S PSS(2)=0 F  S PSS(2)=$O(^TMP($J,"PSS50",50.01,PSS(2))) Q:'PSS(2)  D SETOLDNM S CNT=CNT+1
 ...S ^TMP($J,LIST,+PSS(1),"OLD",0)=$S(CNT>0:CNT,1:"-1^NO DATA FOUND")
 K ^TMP("DILIST",$J),^TMP($J,"PSS50")
 Q
 ;
LOOP(PSS) ;
 N CNT,PSSIEN S CNT=0
 S PSSIEN=0 F  S PSSIEN=$O(^PSDRUG(PSSIEN)) Q:'PSSIEN  D
 .I $P($G(^PSDRUG(PSSIEN,0)),"^")="" Q
 .I $G(PSSFL),$P($G(^PSDRUG(PSSIEN,"I")),"^"),$P($G(^("I")),"^")'>PSSFL Q
 .I $G(PSSRTOI)=1,'$P($G(^PSDRUG(PSSIEN,2)),"^") Q
 .;Naked reference below refers to ^PSDRUG(PSSIEN,2)
 .I $G(PSSPK)]"" N PSSZ5,PSSZ6 S PSSZ5=0 F PSSZ6=1:1:$L(PSSPK) Q:PSSZ5  I $P($G(^(2)),"^",3)[$E(PSSPK,PSSZ6) S PSSZ5=1
 .I $G(PSSPK)]"",'PSSZ5 Q
 .D @PSS
 S ^TMP($J,LIST,0)=$S(CNT>0:CNT,1:"-1^NO DATA FOUND")
 Q
 ;
SETOLDNM ;
 S ^TMP($J,LIST,+PSS(1),"OLD",+PSS(2),.01)=^TMP($J,"PSS50",50.01,PSS(2),.01,"I")
 S ^TMP($J,LIST,+PSS(1),"OLD",+PSS(2),.02)=$S($G(^TMP($J,"PSS50",50.01,PSS(2),.02,"I"))="":"",1:^TMP($J,"PSS50",50.01,PSS(2),.02,"I")_"^"_^TMP($J,"PSS50",50.01,PSS(2),.02,"E"))
 Q
 ;
SETLIST ;
 S ^TMP($J,LIST,+PSS(1),.01)=^TMP($J,"PSS50",50,PSS(1),.01,"I")
 S ^TMP($J,LIST,$S($G(PSSD)]"":$P(PSSD,"^"),1:"B"),^TMP($J,"PSS50",50,PSS(1),.01,"I"),+PSS(1))=""
 S ^TMP($J,LIST,+PSS(1),2.1)=$S($G(^TMP($J,"PSS50",50,PSS(1),2.1,"I"))="":"",1:^TMP($J,"PSS50",50,PSS(1),2.1,"I")_"^"_^TMP($J,"PSS50",50,PSS(1),2.1,"E"))
 S ^TMP($J,LIST,+PSS(1),100)=$S($G(^TMP($J,"PSS50",50,PSS(1),100,"I"))="":"",1:^TMP($J,"PSS50",50,PSS(1),100,"I")_"^"_^TMP($J,"PSS50",50,PSS(1),100,"E"))
 Q
 ;
SETLOOK ;
 S ^TMP($J,LIST,+PSS(2),.01)=PSS50(50,PSS(2),.01,"I")
 S ^TMP($J,LIST,$S($G(PSSCRFL)]"":$P(PSSCRFL,"^"),1:"B"),PSS50(50,PSS(2),.01,"I"),+PSS(2))=""
 S ^TMP($J,LIST,+PSS(2),2.1)=$S($G(PSS50(50,PSS(2),25,"I"))="":"",1:PSS50(50,PSS(2),25,"I")_"^"_PSS50(50,PSS(2),25,"E"))
 S ^TMP($J,LIST,+PSS(2),100)=$S($G(PSS50(50,PSS(2),100,"I"))="":"",1:PSS50(50,PSS(2),100,"I")_"^"_PSS50(50,PSS(2),100,"E"))
 S ^TMP($J,LIST,+PSS(2),101)=$S($G(PSS50(50,PSS(2),101,"I"))="":"",1:PSS50(50,PSS(2),101,"I")_"^"_PSS50(50,PSS(2),101,"E"))
 Q
 ;
ADDOLDNM(PSSIEN2,PSSONM2,PSSDT2) ;
 ;PSSIEN2 - IEN of entry in DRUG file (#50).
 ;PSSONM2 - Text of the old name.
 ;PSSDT2 - Date changed in FileMan format. 
 ;0 (zero)is returned if ADD was unsuccessful.  1 (one) will indicate successful ADD.
 ;Adding new entry to OLD NAME multiple (#50.01) of the DRUG file (#50).
 I (+$G(PSSIEN2)'>0)!($G(PSSONM2)']"") Q 0
 S:+$G(PSSDT2)'>0 PSSDT2=DT
 N PSS,QFLG
 N PSSIEN4 S PSSIEN4=$$FIND1^DIC(50,"","A","`"_PSSIEN2,,,"")
 I +PSSIEN4'>0 Q 0
 D LIST^DIC(50.01,","_PSSIEN2_",","@;.01IE;.02IE","P",,,,,,,)
 I +^TMP("DILIST",$J,0)'>0 D
 .S PSS(1,50.01,"+2,"_PSSIEN2_",",.01)=$G(PSSONM2)
 .S PSS(1,50.01,"+2,"_PSSIEN2_",",.02)=$G(PSSDT2)
 I +^TMP("DILIST",$J,0)>0 S (QFLG,PSS)=0 F  S PSS=$O(^TMP("DILIST",$J,PSS)) Q:'PSS  Q:QFLG  D
 .I $P($G(^TMP("DILIST",$J,PSS,0)),"^",2)=PSSONM2,($P($G(^(0)),"^",4)=PSSDT2) S QFLG=1 Q
 .S PSS(1,50.01,"+2,"_PSSIEN2_",",.01)=$G(PSSONM2)
 .S PSS(1,50.01,"+2,"_PSSIEN2_",",.02)=$G(PSSDT2)
 I $G(QFLG) Q 0
 D UPDATE^DIE("","PSS(1)") Q 1
 Q
EDTIFCAP(PSSIEN2,PSSVAL2) ;
 ;PSSIEN2 - IEN of entry in DRUG file (#50).
 ;PSSVAL2 - IFCAP ITEM NUMBER to be added.
 ;0 (zero)is returned if ADD was unsuccessful.  1 (one) will indicate successful ADD.
 ;Adding new entry to IFCAP ITEM NUMBER multiple (#50.01) of the DRUG file (#50).
 I (+$G(PSSIEN2)'>0)!+($G(PSSVAL2)'>0) Q 0
 N PSS,QFLG
 N PSSIEN3 S PSSIEN3=$$FIND1^DIC(441,"","A","`"_PSSVAL2,,,"")
 I +PSSIEN3'>0 Q 0
 N PSSIEN4 S PSSIEN4=$$FIND1^DIC(50,"","A","`"_PSSIEN2,,,"")
 I +PSSIEN4'>0 Q 0
 D LIST^DIC(50.0441,","_PSSIEN2_",","@;.01IE","P",,,,,,,)
 I +^TMP("DILIST",$J,0)'>0 D
 .S PSS(1,50.0441,"+2,"_PSSIEN2_",",.01)=$G(PSSVAL2)
 I +^TMP("DILIST",$J,0)>0 S (QFLG,PSS)=0 F  S PSS=$O(^TMP("DILIST",$J,PSS)) Q:'PSS  Q:QFLG  D
 .I $P($G(^TMP("DILIST",$J,PSS,0)),"^",2)=PSSVAL2 S QFLG=1 Q
 .I $O(^PSDRUG("AB",PSSVAL2,"")) S QFLG=1 Q
 .S PSS(1,50.0441,"+2,"_PSSIEN2_",",.01)=$G(PSSVAL2)
 I $G(QFLG) Q 0
 D UPDATE^DIE("","PSS(1)") Q 1
 Q
1 ;
 N CNT2 S CNT2=0
 K ^TMP($J,"PSS50") D GETS^DIQ(50,+PSSIEN,".01;900*","IE","^TMP($J,""PSS50""") S PSS(1)=0
 F  S PSS(1)=$O(^TMP($J,"PSS50",50,PSS(1))) Q:'PSS(1)  D
 .S ^TMP($J,LIST,+PSS(1),.01)=^TMP($J,"PSS50",50,PSS(1),.01,"I"),CNT=CNT+1
 .S ^TMP($J,LIST,"B",^TMP($J,"PSS50",50,PSS(1),.01,"I"),+PSS(1))=""
 .S (PSS(2),CNT2)=0 F  S PSS(2)=$O(^TMP($J,"PSS50",50.01,PSS(2))) Q:'PSS(2)  D SETOLDNM S CNT2=CNT2+1
 .S ^TMP($J,LIST,+PSS(1),"OLD",0)=$S(CNT2>0:CNT2,1:"-1^NO DATA FOUND")
 K ^TMP($J,"PSS50")
 Q
2 ;
 K ^TMP($J,"PSS50") D GETS^DIQ(50,+PSSIEN,".01;100;2.1","IE","^TMP($J,""PSS50""") S PSS(1)=0
 F  S PSS(1)=$O(^TMP($J,"PSS50",50,PSS(1))) Q:'PSS(1)  D SETLIST S CNT=CNT+1
 K ^TMP($J,"PSS50")
 Q
PARSE(PSSLUP) ; Create array of cross references, piece 2 of the array =1 for pointer fields, else 0
 I $G(PSSLUP)="" Q
 N PSSLUPA,PSSLUP1,PSSLUP2,PSSLUP3,PSSLUP4,PSSLUP5,PSSDTYPE,PSSPTER
 I $E(PSSLUP)="^" S PSSLUP=$E(PSSLUP,2,$L(PSSLUP))
 S PSSLUP1=0 F PSSLUP2=1:1:$L(PSSLUP) I $E(PSSLUP,PSSLUP2)="^" S PSSLUP1=PSSLUP1+1
 S PSSLUP1=PSSLUP1+1
 S PSSLUP4=1 F PSSLUP3=1:1:PSSLUP1 S PSSLUP5=$P(PSSLUP,"^",PSSLUP3) I PSSLUP5'="" D  S PSSLUPAR(PSSLUP4)=PSSLUP5_"^"_$G(PSSPTER),PSSLUP4=PSSLUP4+1
 .N PSSCRX,PSSCRX1 S PSSPTER=0
 .S PSSCRX="" F  S PSSCRX=$O(^DD(50,0,"IX",PSSLUP5,PSSCRX)) Q:PSSCRX=""  S PSSCRX1="" F  S PSSCRX1=$O(^DD(50,0,"IX",PSSLUP5,PSSCRX,PSSCRX1)) Q:PSSCRX1=""  D
 ..K PSSDTYPE D FIELD^DID(PSSCRX,PSSCRX1,,"TYPE","PSSDTYPE") I $G(PSSDTYPE("TYPE"))="POINTER" S PSSPTER=1
 Q

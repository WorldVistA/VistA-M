PSS50B2 ;BIR/LDT - API FOR INFORMATION FROM FILE 50; 5 Sep 03
 ;;1.0;PHARMACY DATA MANAGEMENT;**85**;9/30/97
 ;
CLOZ ;
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
 I $G(PSSIEN)]"",+$G(PSSIEN)'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 S SCR("S")=""
 I +$G(PSSFL)>0!($G(PSSPK)]"")!($G(PSSRTOI)=1) N PSS5ND,PSSZ3,PSSZ4 D SETSCRN^PSS50A
 I +$G(PSSIEN)>0 N PSSIEN2 S PSSIEN2=$$FIND1^DIC(50,"","A","`"_PSSIEN,,SCR("S"),"") D  K ^TMP("PSSP50",$J) Q
 .K ^TMP("DIERR",$J)
 .I +PSSIEN2'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .S ^TMP($J,LIST,0)=1
 .D SETSUB6^PSS50AQM(+PSSIEN2)
 .K ^TMP("PSSP50",$J) D GETS^DIQ(50,+PSSIEN2,".01;17.7*","IE","^TMP(""PSSP50"",$J)") S PSS(1)=0
 .F  S PSS(1)=$O(^TMP("PSSP50",$J,50,PSS(1))) Q:'PSS(1)  D SCLOZ D
 ..S (PSS(2),PSSMLCT)=0 F  S PSS(2)=$O(^TMP("PSSP50",$J,50.02,PSS(2))) Q:'PSS(2)  S PSSMLCT=PSSMLCT+1 D SCLOZM
 ..S ^TMP($J,LIST,+PSS(1),"CLOZ",0)=$S($G(PSSMLCT):PSSMLCT,1:"-1^NO DATA FOUND")
 I $G(PSSIEN)'="" S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I $G(PSSFT)]"" D
 .I PSSFT["??" D LOOP Q
 .K ^TMP("DILIST",$J)
 .D FIND^DIC(50,,"@;.01","QP",PSSFT,,"B",SCR("S"),,"")
 .I +$G(^TMP("DILIST",$J,0))=0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .I +^TMP("DILIST",$J,0)>0 S ^TMP($J,LIST,0)=+^TMP("DILIST",$J,0) N PSSXX S PSSXX=0 F  S PSSXX=$O(^TMP("DILIST",$J,PSSXX)) Q:'PSSXX  D
 ..S PSSIEN=+^TMP("DILIST",$J,PSSXX,0)
 ..D SETSUB6^PSS50AQM(PSSIEN) K ^TMP("PSSP50",$J) D GETS^DIQ(50,+PSSIEN,".01;17.7*","IE","^TMP(""PSSP50"",$J)") S PSS(1)=0
 ..F  S PSS(1)=$O(^TMP("PSSP50",$J,50,PSS(1))) Q:'PSS(1)  D SCLOZ D
 ...S (PSS(2),PSSMLCT)=0 F  S PSS(2)=$O(^TMP("PSSP50",$J,50.02,PSS(2))) Q:'PSS(2)  S PSSMLCT=PSSMLCT+1 D SCLOZM
 ...S ^TMP($J,LIST,+PSS(1),"CLOZ",0)=$S($G(PSSMLCT):PSSMLCT,1:"-1^NO DATA FOUND")
 K ^TMP("DILIST",$J),^TMP("PSSP50",$J)
 Q
 ;
FRMALT ;
 ;PSSIEN - IEN of entry in 50
 ;PSSFT - Free Text name in 50
 ;PSSFL - Inactive flag - "" - All entries
 ;                        FileMan Date - Only entries with no Inactive Date or an Inactive Date greater than this date.
 ;PSSPK - Application Package's Use - "" - All entries
 ;                                         Alphabetic codes that represent the DHCP packages that consider this drug to be
 ;                                         part of their formulary.                                       
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the Field Number of the data
 ;       piece being returned.
 N DIERR,ZZERR,PSS50,SCR,PSSFRCT,PSS
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I +$G(PSSIEN)'>0,($G(PSSFT)']"") S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I $G(PSSIEN)]"",+$G(PSSIEN)'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 S SCR("S")=""
 I +$G(PSSFL)>0!($G(PSSPK)]"") N PSS5ND,PSSZ3,PSSZ4 D SETSCRN^PSS50A
 I +$G(PSSIEN)>0 N PSSIEN2 S PSSIEN2=$$FIND1^DIC(50,"","A","`"_PSSIEN,,SCR("S"),"") D  K ^TMP("PSS50",$J) Q
 .K ^TMP("DIERR",$J)
 .I +PSSIEN2'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .S ^TMP($J,LIST,0)=1
 .K ^TMP("PSSP50",$J) D GETS^DIQ(50,+PSSIEN2,".01;25;100;101;65*","IE","^TMP(""PSS50"",$J)") S PSS(1)=0
 .F  S PSS(1)=$O(^TMP("PSS50",$J,50,PSS(1))) Q:'PSS(1)  D SFRM D
 ..S (PSS(2),PSSFRCT)=0 F  S PSS(2)=$O(^TMP("PSS50",$J,50.065,PSS(2))) Q:'PSS(2)  S PSSFRCT=PSSFRCT+1 D SFRMA
 ..S ^TMP($J,LIST,+PSS(1),"FRM",0)=$S($G(PSSFRCT):PSSFRCT,1:"-1^NO DATA FOUND")
 I $G(PSSIEN)'="" S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I $G(PSSFT)]"" D
 .I PSSFT["??" D LOOP2 Q
 .K ^TMP("DILIST",$J)
 .D FIND^DIC(50,,"@;.01","QP",PSSFT,,"B",SCR("S"),,"")
 .I +$G(^TMP("DILIST",$J,0))=0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .I +^TMP("DILIST",$J,0)>0 S ^TMP($J,LIST,0)=+^TMP("DILIST",$J,0) N PSSXX S PSSXX=0 F  S PSSXX=$O(^TMP("DILIST",$J,PSSXX)) Q:'PSSXX  D
 ..S PSSIEN=+^TMP("DILIST",$J,PSSXX,0)
 ..K ^TMP("PSS50",$J) D GETS^DIQ(50,+PSSIEN,".01;25;100;101;65*","IE","^TMP(""PSS50"",$J)") S PSS(1)=0
 ..F  S PSS(1)=$O(^TMP("PSS50",$J,50,PSS(1))) Q:'PSS(1)  D SFRM D
 ...S (PSS(2),PSSFRCT)=0 F  S PSS(2)=$O(^TMP("PSS50",$J,50.065,PSS(2))) Q:'PSS(2)  S PSSFRCT=PSSFRCT+1 D SFRMA
 ...S ^TMP($J,LIST,+PSS(1),"FRM",0)=$S($G(PSSFRCT):PSSFRCT,1:"-1^NO DATA FOUND")
 K ^TMP("DILIST",$J),^TMP("PSS50",$J)
 Q
 ;
SCLOZ ;
 S ^TMP($J,LIST,+PSS(1),.01)=$G(^TMP("PSSP50",$J,50,PSS(1),.01,"I"))
 S ^TMP($J,LIST,"B",$G(^TMP("PSSP50",$J,50,PSS(1),.01,"I")),+PSS(1))=""
 Q
SCLOZM ; 
 S ^TMP($J,LIST,+PSS(1),"CLOZ",+PSS(2),.01)=$S($G(^TMP("PSSP50",$J,50.02,PSS(2),.01,"I"))="":"",1:$G(^TMP("PSSP50",$J,50.02,PSS(2),.01,"I"))_"^"_$G(^TMP("PSSP50",$J,50.02,PSS(2),.01,"E")))
 S ^TMP($J,LIST,+PSS(1),"CLOZ",+PSS(2),1)=$G(^TMP("PSSP50",$J,50.02,PSS(2),1,"I"))
 S ^TMP($J,LIST,+PSS(1),"CLOZ",+PSS(2),2)=$S($G(^TMP("PSSP50",$J,50.02,PSS(2),2,"I"))="":"",1:$G(^TMP("PSSP50",$J,50.02,PSS(2),2,"I"))_"^"_$G(^TMP("PSSP50",$J,50.02,PSS(2),2,"E")))
 S ^TMP($J,LIST,+PSS(1),"CLOZ",+PSS(2),3)=$S($G(^TMP("PSSP50",$J,50.02,PSS(2),3,"I"))="":"",1:$G(^TMP("PSSP50",$J,50.02,PSS(2),3,"I"))_"^"_$G(^TMP("PSSP50",$J,50.02,PSS(2),3,"E")))
 Q
SFRM ;
 S ^TMP($J,LIST,+PSS(1),.01)=$G(^TMP("PSS50",$J,50,PSS(1),.01,"I"))
 S ^TMP($J,LIST,"B",$G(^TMP("PSS50",$J,50,PSS(1),.01,"I")),+PSS(1))=""
 S ^TMP($J,LIST,+PSS(1),25)=$G(^TMP("PSS50",$J,50,PSS(1),25,"I"))
 S ^TMP($J,LIST,+PSS(1),100)=$S($G(^TMP("PSS50",$J,50,PSS(1),100,"I"))="":"",1:$G(^TMP("PSS50",$J,50,PSS(1),100,"I"))_"^"_$G(^TMP("PSS50",$J,50,PSS(1),100,"E")))
 S ^TMP($J,LIST,+PSS(1),101)=$G(^TMP("PSS50",$J,50,PSS(1),101,"I"))
 Q
SFRMA ;
 S ^TMP($J,LIST,+PSS(1),"FRM",+PSS(2),.01)=$S($G(^TMP("PSS50",$J,50.065,PSS(2),.01,"I"))="":"",1:$G(^TMP("PSS50",$J,50.065,PSS(2),.01,"I"))_"^"_$G(^TMP("PSS50",$J,50.065,PSS(2),.01,"E")))
 Q
LOOP ;
 N PSSENCT
 S PSSENCT=0
 S PSS(1)=0 F  S PSS(1)=$O(^PSDRUG(PSS(1))) Q:'PSS(1)  D
 .I $P($G(^PSDRUG(PSS(1),0)),"^")="" Q
 .I $G(PSSFL),$P($G(^PSDRUG(PSS(1),"I")),"^"),$P($G(^("I")),"^")'>PSSFL Q
 .I $G(PSSRTOI)=1,'$P($G(^PSDRUG(PSS(1),2)),"^") Q
 .;Naked reference below refers to ^PSDRUG(PSS(1),2)
 .I $G(PSSPK)]"" N PSSZ5,PSSZ6 S PSSZ5=0 F PSSZ6=1:1:$L(PSSPK) Q:PSSZ5  I $P($G(^(2)),"^",3)[$E(PSSPK,PSSZ6) S PSSZ5=1
 .I $G(PSSPK)]"",'PSSZ5 Q
 .D SETSUB6^PSS50AQM(PSS(1))
 .D SCLOZ1
 .S PSSENCT=PSSENCT+1
 S ^TMP($J,LIST,0)=$S($G(PSSENCT):$G(PSSENCT),1:"-1^NO DATA FOUND")
 Q
SCLOZ1 ;
 N PSSZNODE
 S PSSZNODE=$G(^PSDRUG(PSS(1),0))
 S ^TMP($J,LIST,+PSS(1),.01)=$P(PSSZNODE,"^")
 S ^TMP($J,LIST,"B",$P(PSSZNODE,"^"),PSS(1))=""
 ;Set CLOZ2 multiple information
 N PSSCZPC S PSSCZPC=0
 I $O(^PSDRUG(PSS(1),"CLOZ2",0)) N PSSCZP,PSSCZP1 D
 .F PSSCZP=0:0 S PSSCZP=$O(^PSDRUG(PSS(1),"CLOZ2",PSSCZP)) Q:'PSSCZP  D
 ..S PSSCZP1=$G(^PSDRUG(PSS(1),"CLOZ2",PSSCZP,0)) I $P(PSSCZP1,"^")'="" S PSSCZPC=PSSCZPC+1 D
 ...N PSSCARZ,DA,DR,DIC,DIQ K PSSCARZ S DIC=50,DR="17.7",DA=PSS(1),DR(50.02)=".01;1;2;3",DA(50.02)=PSSCZP,DIQ="PSSCARZ",DIQ(0)="IE" D EN^DIQ1
 ...S ^TMP($J,LIST,+PSS(1),"CLOZ",PSSCZP,.01)=$S($G(PSSCARZ(50.02,PSSCZP,.01,"I"))="":"",1:$G(PSSCARZ(50.02,PSSCZP,.01,"I"))_"^"_$G(PSSCARZ(50.02,PSSCZP,.01,"E")))
 ...S ^TMP($J,LIST,+PSS(1),"CLOZ",PSSCZP,1)=$G(PSSCARZ(50.02,PSSCZP,1,"I"))
 ...S ^TMP($J,LIST,+PSS(1),"CLOZ",PSSCZP,2)=$S($G(PSSCARZ(50.02,PSSCZP,2,"I"))="":"",1:$G(PSSCARZ(50.02,PSSCZP,2,"I"))_"^"_$G(PSSCARZ(50.02,PSSCZP,2,"E")))
 ...S ^TMP($J,LIST,+PSS(1),"CLOZ",PSSCZP,3)=$S($G(PSSCARZ(50.02,PSSCZP,3,"I"))="":"",1:$G(PSSCARZ(50.02,PSSCZP,3,"I"))_"^"_$G(PSSCARZ(50.02,PSSCZP,3,"E")))
 S ^TMP($J,LIST,+PSS(1),"CLOZ",0)=$S(PSSCZPC:PSSCZPC,1:"-1^NO DATA FOUND")
 Q
LOOP2 ;
 N PSSENCT,PSSIEN
 S PSSENCT=0
 S PSSIEN=0 F  S PSSIEN=$O(^PSDRUG(PSSIEN)) Q:'PSSIEN  D
 .I $P($G(^PSDRUG(PSSIEN,0)),"^")="" Q
 .I $G(PSSFL),$P($G(^PSDRUG(PSSIEN,"I")),"^"),$P($G(^("I")),"^")'>PSSFL Q
 .;Naked reference below refers to ^PSDRUG(PSSIEN,2)
 .I $G(PSSPK)]"" N PSSZ5,PSSZ6 S PSSZ5=0 F PSSZ6=1:1:$L(PSSPK) Q:PSSZ5  I $P($G(^(2)),"^",3)[$E(PSSPK,PSSZ6) S PSSZ5=1
 .I $G(PSSPK)]"",'PSSZ5 Q
 .K ^TMP("PSS50",$J) D GETS^DIQ(50,+PSSIEN,".01;25;100;101;65*","IE","^TMP(""PSS50"",$J)") S PSS(1)=0
 .F  S PSS(1)=$O(^TMP("PSS50",$J,50,PSS(1))) Q:'PSS(1)  D SFRM D
 ..S (PSS(2),PSSFRCT)=0 F  S PSS(2)=$O(^TMP("PSS50",$J,50.065,PSS(2))) Q:'PSS(2)  S PSSFRCT=PSSFRCT+1 D SFRMA
 ..S ^TMP($J,LIST,+PSS(1),"FRM",0)=$S($G(PSSFRCT):PSSFRCT,1:"-1^NO DATA FOUND")
 .S PSSENCT=PSSENCT+1
 S ^TMP($J,LIST,0)=$S($G(PSSENCT):$G(PSSENCT),1:"-1^NO DATA FOUND")
 K ^TMP("PSS50",$J)
 Q

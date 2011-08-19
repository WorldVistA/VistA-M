PSS50LAB ;BIR/LDT - API FOR LAB INFORMATION FROM FILE 50; 5 Sep 03
 ;;1.0;PHARMACY DATA MANAGEMENT;**85**;9/30/97
 ;
LAB ;
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
 N DIERR,ZZERR,PSSP50,SCR,PSS,PSSMLCT
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I +$G(PSSIEN)'>0,($G(PSSFT)']"") S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 S SCR("S")=""
 I +$G(PSSFL)>0!($G(PSSPK)]"")!($G(PSSRTOI)=1) N PSS5ND,PSSZ3,PSSZ4 D SETSCRN^PSS50A
 I +$G(PSSIEN)>0 N PSSIEN2 S PSSIEN2=$$FIND1^DIC(50,"","A","`"_PSSIEN,,SCR("S"),"") D  K ^TMP("PSSP50",$J) Q
 .K ^TMP("DIERR",$J)
 .I +PSSIEN2'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .S ^TMP($J,LIST,0)=1
 .K ^TMP("PSSP50",$J) D GETS^DIQ(50,+PSSIEN2,".01;17.2:17.6","IE","^TMP(""PSSP50"",$J)") S PSS(1)=0
 .F  S PSS(1)=$O(^TMP("PSSP50",$J,50,PSS(1))) Q:'PSS(1)  D SETLAB
 I $G(PSSIEN)'="" S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I $G(PSSFT)]"" D
 .I PSSFT["??" D LOOP Q
 .K ^TMP("DILIST",$J)
 .D FIND^DIC(50,,"@;.01","QP",PSSFT,,"B",SCR("S"),,"")
 .I +$G(^TMP("DILIST",$J,0))=0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .I +^TMP("DILIST",$J,0)>0 S ^TMP($J,LIST,0)=+^TMP("DILIST",$J,0) N PSSXX S PSSXX=0 F  S PSSXX=$O(^TMP("DILIST",$J,PSSXX)) Q:'PSSXX  D
 ..S PSSIEN=+^TMP("DILIST",$J,PSSXX,0)
 ..K ^TMP("PSSP50",$J) D GETS^DIQ(50,+PSSIEN,".01;17.2:17.6","IE","^TMP(""PSSP50"",$J)") S PSS(1)=0
 ..F  S PSS(1)=$O(^TMP("PSSP50",$J,50,PSS(1))) Q:'PSS(1)  D SETLAB
 K ^TMP("DILIST",$J),^TMP("PSSP50",$J)
 Q
 ;
SETLAB ;
 S ^TMP($J,LIST,+PSS(1),.01)=$G(^TMP("PSSP50",$J,50,PSS(1),.01,"I"))
 S ^TMP($J,LIST,"B",$G(^TMP("PSSP50",$J,50,PSS(1),.01,"I")),+PSS(1))=""
 S ^TMP($J,LIST,+PSS(1),17.2)=$S($G(^TMP("PSSP50",$J,50,PSS(1),17.2,"I"))="":"",1:$G(^TMP("PSSP50",$J,50,PSS(1),17.2,"I"))_"^"_$G(^TMP("PSSP50",$J,50,PSS(1),17.2,"E")))
 S ^TMP($J,LIST,+PSS(1),17.3)=$G(^TMP("PSSP50",$J,50,PSS(1),17.3,"I"))
 S ^TMP($J,LIST,+PSS(1),17.4)=$S($G(^TMP("PSSP50",$J,50,PSS(1),17.4,"I"))="":"",1:$G(^TMP("PSSP50",$J,50,PSS(1),17.4,"I"))_"^"_$G(^TMP("PSSP50",$J,50,PSS(1),17.4,"E")))
 S ^TMP($J,LIST,+PSS(1),17.5)=$G(^TMP("PSSP50",$J,50,PSS(1),17.5,"I"))
 S ^TMP($J,LIST,+PSS(1),17.6)=$S($G(^TMP("PSSP50",$J,50,PSS(1),17.6,"I"))="":"",1:$G(^TMP("PSSP50",$J,50,PSS(1),17.6,"I"))_"^"_$G(^TMP("PSSP50",$J,50,PSS(1),17.6,"E")))
 Q
 ;
LOOP ;
 N PSS50D12,PSS50E12,PSS176D D FIELD^DID(50,17.6,"Z","POINTER","PSS50D12","PSS50E12") S PSS176D=$G(PSS50D12("POINTER"))
 N PSSENCT
 S PSSENCT=0
 S PSS(1)=0 F  S PSS(1)=$O(^PSDRUG(PSS(1))) Q:'PSS(1)  D
 .I $P($G(^PSDRUG(PSS(1),0)),"^")="" Q
 .I $G(PSSFL),$P($G(^PSDRUG(PSS(1),"I")),"^"),$P($G(^("I")),"^")'>PSSFL Q
 .I $G(PSSRTOI)=1,'$P($G(^PSDRUG(PSS(1),2)),"^") Q
 .;Naked reference below refers to ^PSDRUG(PSS(1),2)
 .I $G(PSSPK)]"" N PSSZ5,PSSZ6 S PSSZ5=0 F PSSZ6=1:1:$L(PSSPK) Q:PSSZ5  I $P($G(^(2)),"^",3)[$E(PSSPK,PSSZ6) S PSSZ5=1
 .I $G(PSSPK)]"",'PSSZ5 Q
 .D SETLABL
 .S PSSENCT=PSSENCT+1
 S ^TMP($J,LIST,0)=$S($G(PSSENCT):$G(PSSENCT),1:"-1^NO DATA FOUND")
 Q
SETLABL ;
 N PSSZNODE,PSS50CL,PSS50CL1
 S PSSZNODE=$G(^PSDRUG(PSS(1),0)),PSS50CL=$G(^("CLOZ")),PSS50CL1=$G(^("CLOZ1"))
 S ^TMP($J,LIST,+PSS(1),.01)=$P(PSSZNODE,"^")
 S ^TMP($J,LIST,"B",$P(PSSZNODE,"^"),+PSS(1))=""
 N PSSCLZAR D GETS^DIQ(50,+PSS(1),"17.2;17.4","IE","PSSCLZAR")
 S ^TMP($J,LIST,+PSS(1),17.2)=$S($G(PSSCLZAR(50,+PSS(1)_",",17.2,"I"))="":"",1:$G(PSSCLZAR(50,+PSS(1)_",",17.2,"I"))_"^"_$G(PSSCLZAR(50,+PSS(1)_",",17.2,"E")))
 S ^TMP($J,LIST,+PSS(1),17.3)=$P(PSS50CL,"^",2)
 S ^TMP($J,LIST,+PSS(1),17.4)=$S($G(PSSCLZAR(50,+PSS(1)_",",17.4,"I"))="":"",1:$G(PSSCLZAR(50,+PSS(1)_",",17.4,"I"))_"^"_$G(PSSCLZAR(50,+PSS(1)_",",17.4,"E")))
 S ^TMP($J,LIST,+PSS(1),17.5)=$P(PSS50CL1,"^")
 N PSS176 S PSS176=$P(PSS50CL1,"^",2)  D
 .I PSS176'="",PSS176D'="",PSS176D[(PSS176_":") S ^TMP($J,LIST,+PSS(1),17.6)=PSS176_"^"_$P($E(PSS176D,$F(PSS176D,(PSS176_":")),999),";") Q
 .S ^TMP($J,LIST,+PSS(1),17.6)=""
 Q

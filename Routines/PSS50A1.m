PSS50A1 ;BIR/LDT - CONTINUATION OF API FOR INFORMATION FROM FILE 50; 5 Sep 03
 ;;1.0;PHARMACY DATA MANAGEMENT;**85**;9/30/97
 ;External reference to DD(50 supported by DBIA 999
 ;External reference to PS(50.605 supported by DBIA 2138
 ;
SETDRG ;
 S ^TMP($J,LIST,+PSS(1),.01)=$G(^TMP("PSSP50",$J,50,PSS(1),.01,"I"))
 S ^TMP($J,LIST,"B",$G(^TMP("PSSP50",$J,50,PSS(1),.01,"I")),+PSS(1))=""
 S ^TMP($J,LIST,+PSS(1),62.01)=$G(^TMP("PSSP50",$J,50,PSS(1),62.01,"I"))
 S ^TMP($J,LIST,+PSS(1),62.02)=$S($G(^TMP("PSSP50",$J,50,PSS(1),62.02,"I"))="":"",1:$G(^TMP("PSSP50",$J,50,PSS(1),62.02,"I"))_"^"_$G(^TMP("PSSP50",$J,50,PSS(1),62.02,"E")))
 S ^TMP($J,LIST,+PSS(1),62.03)=$S($G(^TMP("PSSP50",$J,50,PSS(1),62.03,"I"))="":"",1:$G(^TMP("PSSP50",$J,50,PSS(1),62.03,"I"))_"^"_$G(^TMP("PSSP50",$J,50,PSS(1),62.03,"E")))
 S ^TMP($J,LIST,+PSS(1),62.04)=$G(^TMP("PSSP50",$J,50,PSS(1),62.04,"I"))
 S ^TMP($J,LIST,+PSS(1),62.05)=$S($G(^TMP("PSSP50",$J,50,PSS(1),62.05,"I"))="":"",1:$G(^TMP("PSSP50",$J,50,PSS(1),62.05,"I"))_"^"_$G(^TMP("PSSP50",$J,50,PSS(1),62.05,"E")))
 S ^TMP($J,LIST,+PSS(1),905)=$S($G(^TMP("PSSP50",$J,50,PSS(1),905,"I"))="":"",1:$G(^TMP("PSSP50",$J,50,PSS(1),905,"I"))_"^"_$G(^TMP("PSSP50",$J,50,PSS(1),905,"E")))
 Q
LOOP ;
 N PSS50DD,PSS50ERR,PSS8UDS D FIELD^DID(50,62.03,"Z","POINTER","PSS50DD","PSS50ERR") S PSS8UDS=$G(PSS50DD("POINTER"))
 N PSSENCT
 S PSSENCT=0
 S PSS(1)=0 F  S PSS(1)=$O(^PSDRUG(PSS(1))) Q:'PSS(1)  D
 .I $P($G(^PSDRUG(PSS(1),0)),"^")="" Q
 .I $G(PSSFL),$P($G(^PSDRUG(PSS(1),"I")),"^"),$P($G(^("I")),"^")'>PSSFL Q
 .I $G(PSSRTOI)=1,'$P($G(^PSDRUG(PSS(1),2)),"^") Q
 .;Naked reference below refers to ^PSDRUG(PSS(1),2)
 .I $G(PSSPK)]"" N PSSZ5,PSSZ6 S PSSZ5=0 F PSSZ6=1:1:$L(PSSPK) Q:PSSZ5  I $P($G(^(2)),"^",3)[$E(PSSPK,PSSZ6) S PSSZ5=1
 .I $G(PSSPK)]"",'PSSZ5 Q
 .D SETDRGL
 .S PSSENCT=PSSENCT+1
 S ^TMP($J,LIST,0)=$S($G(PSSENCT):$G(PSSENCT),1:"-1^NO DATA FOUND")
 Q
SETDRGL ;
 N PSSZNODE,PSS8ND
 S PSSZNODE=$G(^PSDRUG(PSS(1),0)),PSS8ND=$G(^(8))
 S ^TMP($J,LIST,+PSS(1),.01)=$P(PSSZNODE,"^")
 S ^TMP($J,LIST,"B",$P(PSSZNODE,"^"),+PSS(1))=""
 S ^TMP($J,LIST,+PSS(1),62.01)=$P(PSS8ND,"^")
 S ^TMP($J,LIST,+PSS(1),62.02)=$S($P(PSS8ND,"^",2):$P(PSS8ND,"^",2)_"^"_$P($G(^PS(51.2,+$P(PSS8ND,"^",2),0)),"^"),1:"")
 N PSS8UD S PSS8UD=$P(PSS8ND,"^",3)  D
 .I PSS8UD'="",PSS8UDS'="",PSS8UDS[(PSS8UD_":") S ^TMP($J,LIST,+PSS(1),62.03)=PSS8UD_"^"_$P($E(PSS8UDS,$F(PSS8UDS,(PSS8UD_":")),999),";") Q
 .S ^TMP($J,LIST,+PSS(1),62.03)=""
 S ^TMP($J,LIST,+PSS(1),62.04)=$P(PSS8ND,"^",4)
 S ^TMP($J,LIST,+PSS(1),62.05)=$S($P(PSS8ND,"^",5):$P(PSS8ND,"^",5)_"^"_$P($G(^PSDRUG(+$P(PSS8ND,"^",5),0)),"^"),1:"")
 S ^TMP($J,LIST,+PSS(1),905)=$S($P(PSS8ND,"^",6):$P(PSS8ND,"^",6)_"^"_$P($G(^PSDRUG(+$P(PSS8ND,"^",6),0)),"^"),1:"")
 Q
LABEL ;
 ;PSSIEN - IEN of entry in 50                                        
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the Field Number of the data
 ;       piece being returned.
 N DIERR,ZZERR,SCR,PSS,PSSMLCT,PSSP50
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I +$G(PSSIEN)'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I +$G(PSSIEN)>0 N PSSIEN2 S PSSIEN2=$$FIND1^DIC(50,"","A","`"_PSSIEN,,,"") D
 .K ^TMP("DIERR",$J)
 .I +PSSIEN2'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .S ^TMP($J,LIST,0)=1
 .K PSS50 D GETS^DIQ(50,+PSSIEN2,".01;25;51;100;101;102","IE","PSS50") S PSS(1)=0
 .F  S PSS(1)=$O(PSS50(50,PSS(1))) Q:'PSS(1)  D SLABEL
 K ^TMP("DILIST",$J)
 Q
SLABEL ;
 S ^TMP($J,LIST,+PSS(1),.01)=$G(PSS50(50,PSS(1),.01,"I"))
 S ^TMP($J,LIST,"B",$G(PSS50(50,PSS(1),.01,"I")),+PSS(1))=""
 S ^TMP($J,LIST,+PSS(1),25)=$S($G(PSS50(50,PSS(1),25,"I"))="":"",1:$G(PSS50(50,PSS(1),25,"I"))_"^"_$G(PSS50(50,PSS(1),25,"E"))_"^"_$P($G(^PS(50.605,+PSS50(50,PSS(1),25,"I"),0)),"^",2))
 S ^TMP($J,LIST,+PSS(1),51)=$S($G(PSS50(50,PSS(1),51,"I"))="":"",1:$G(PSS50(50,PSS(1),51,"I"))_"^"_$G(PSS50(50,PSS(1),51,"E")))
 S ^TMP($J,LIST,+PSS(1),100)=$S($G(PSS50(50,PSS(1),100,"I"))="":"",1:$G(PSS50(50,PSS(1),100,"I"))_"^"_$G(PSS50(50,PSS(1),100,"E")))
 S ^TMP($J,LIST,+PSS(1),101)=$G(PSS50(50,PSS(1),101,"E"))
 S ^TMP($J,LIST,+PSS(1),102)=$G(PSS50(50,PSS(1),102,"E"))
 Q
SORT ;
 ;PSSIEN - IEN of entry in 50                                        
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,NAME field (#.01),IEN)=""
 N DIERR,ZZERR,SCR,PSS,PSSMLCT,PSSP50
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I +$G(PSSIEN)'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I +$G(PSSIEN)>0 N PSSIEN2 S PSSIEN2=$$FIND1^DIC(50,"","A","`"_PSSIEN,,,"") D
 .K ^TMP("DIERR",$J)
 .I +PSSIEN2'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .S ^TMP($J,LIST,0)=1
 .K PSS50 D GETS^DIQ(50,+PSSIEN2,".01","IE","PSS50") S PSS(1)=0
 .F  S PSS(1)=$O(PSS50(50,PSS(1))) Q:'PSS(1)  D
 ..S ^TMP($J,LIST,$G(PSS50(50,PSS(1),.01,"I")),+PSS(1))=""
 K ^TMP("DILIST",$J)
 Q

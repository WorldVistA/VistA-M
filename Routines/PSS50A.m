PSS50A ;BIR/LDT - CONTINUATION OF API FOR INFORMATION FROM FILE 50 ;5 Sep 03
 ;;1.0;PHARMACY DATA MANAGEMENT;**85,91,92**;9/30/97
 ;External reference to PS(50.605 supported by DBIA 2138
 ;
SETSCRN ;Set Screen for inactive Drugs
 ;Naked reference below refers to ^PSDRUG(+Y,"I")
 I +$G(PSSFL)>0 S SCR("S")="S PSS5ND=$P($G(^(""I"")),""^"") I PSS5ND=""""!(PSS5ND>PSSFL)"
 I $G(PSSRTOI)=1 D
 .;Naked reference below refers to ^PSDRUG(+Y,2)
 .I SCR("S")]"" S SCR("S")=SCR("S")_" I $P($G(^(2)),""^"")" Q
 .;Naked reference below refers to ^PSDRUG(+Y,2)
 .S SCR("S")="I $P($G(^(2)),""^"")"
 I $G(PSSPK)]"" D
 .;Naked reference below refers to ^PSDRUG(+Y,2)
 .I SCR("S")]"" S SCR("S")=SCR("S")_" S PSSZ3=0 F PSSZ4=1:1:$L(PSSPK) Q:PSSZ3  I $P($G(^(2)),""^"",3)[$E(PSSPK,PSSZ4) S PSSZ3=1" Q
 .;Naked reference below refers to ^PSDRUG(+Y,2)
 .S SCR("S")="S PSSZ3=0 F PSSZ4=1:1:$L(PSSPK) Q:PSSZ3  I $P($G(^(2)),""^"",3)[$E(PSSPK,PSSZ4) S PSSZ3=1"
 ;I $G(PSSPK)]"" S SCR("S")=$S(SCR("S")]"":SCR("S")_" I $G(^PSDRUG(+Y,2)),$P($G(^PSDRUG(+Y,2)),""^"",3)[PSSPK",1:"I $G(^PSDRUG(+Y,2)),$P($G(^PSDRUG(+Y,2)),""^"",3)[PSSPK")
 Q
 ;
SETALL ;
 S ^TMP($J,LIST,+PSS(1),.01)=$G(^TMP("PSSP50",$J,50,PSS(1),.01,"I"))
 S ^TMP($J,LIST,"B",$G(^TMP("PSSP50",$J,50,PSS(1),.01,"I")),+PSS(1))=""
 S ^TMP($J,LIST,+PSS(1),2)=$G(^TMP("PSSP50",$J,50,PSS(1),2,"I"))
 S ^TMP($J,LIST,+PSS(1),2.1)=$S($G(^TMP("PSSP50",$J,50,PSS(1),2.1,"I"))="":"",1:$G(^TMP("PSSP50",$J,50,PSS(1),2.1,"I"))_"^"_$G(^TMP("PSSP50",$J,50,PSS(1),2.1,"E")))
 I $P($G(^TMP($J,LIST,+PSS(1),2.1)),"^") D
 .N PSSADDF S PSSADDF=$$SETDF^PSS50AQM($P(^TMP($J,LIST,+PSS(1),2.1),"^")) S ^TMP($J,LIST,+PSS(1),2.1)=^TMP($J,LIST,+PSS(1),2.1)_$S($P($G(PSSADDF),"^")>0:"^"_$P($G(PSSADDF),"^",3)_"^"_$P($G(PSSADDF),"^",4),1:"")
 S ^TMP($J,LIST,+PSS(1),3)=$G(^TMP("PSSP50",$J,50,PSS(1),3,"I"))
 S ^TMP($J,LIST,+PSS(1),4)=$G(^TMP("PSSP50",$J,50,PSS(1),4,"I"))
 S ^TMP($J,LIST,+PSS(1),5)=$G(^TMP("PSSP50",$J,50,PSS(1),5,"I"))
 S ^TMP($J,LIST,+PSS(1),6)=$G(^TMP("PSSP50",$J,50,PSS(1),6,"I"))
 S ^TMP($J,LIST,+PSS(1),8)=$G(^TMP("PSSP50",$J,50,PSS(1),8,"I"))
 N PSSUTN S PSSUTN=$G(^TMP("PSSP50",$J,50,PSS(1),12,"I"))
 S ^TMP($J,LIST,+PSS(1),12)=$S($G(PSSUTN)="":"",1:$G(^TMP("PSSP50",$J,50,PSS(1),12,"I"))_"^"_$G(^TMP("PSSP50",$J,50,PSS(1),12,"E")))
 I PSSUTN'="" S ^TMP($J,LIST,+PSS(1),12)=^TMP($J,LIST,+PSS(1),12)_"^"_$P($G(^DIC(51.5,PSSUTN,0)),"^",2)
 S ^TMP($J,LIST,+PSS(1),13)=$G(^TMP("PSSP50",$J,50,PSS(1),13,"I"))
 S ^TMP($J,LIST,+PSS(1),14.5)=$G(^TMP("PSSP50",$J,50,PSS(1),14.5,"I"))
 S ^TMP($J,LIST,+PSS(1),15)=$G(^TMP("PSSP50",$J,50,PSS(1),15,"I"))
 S ^TMP($J,LIST,+PSS(1),16)=$G(^TMP("PSSP50",$J,50,PSS(1),16,"I"))
 S ^TMP($J,LIST,+PSS(1),20)=$S($G(^TMP("PSSP50",$J,50,PSS(1),20,"I"))="":"",1:$G(^TMP("PSSP50",$J,50,PSS(1),20,"I"))_"^"_$G(^TMP("PSSP50",$J,50,PSS(1),20,"E")))
 S ^TMP($J,LIST,+PSS(1),21)=$G(^TMP("PSSP50",$J,50,PSS(1),21,"I"))
 S ^TMP($J,LIST,+PSS(1),22)=$S($G(^TMP("PSSP50",$J,50,PSS(1),22,"I"))="":"",1:$G(^TMP("PSSP50",$J,50,PSS(1),22,"I"))_"^"_$G(^TMP("PSSP50",$J,50,PSS(1),22,"E")))
 S ^TMP($J,LIST,+PSS(1),25)=$S($G(^TMP("PSSP50",$J,50,PSS(1),25,"I"))="":"",1:$G(^TMP("PSSP50",$J,50,PSS(1),25,"I"))_"^"_$G(^TMP("PSSP50",$J,50,PSS(1),25,"E"))_"^"_$P($G(^PS(50.605,+^TMP("PSSP50",$J,50,PSS(1),25,"I"),0)),"^",2))
 S ^TMP($J,LIST,+PSS(1),27)=$G(^TMP("PSSP50",$J,50,PSS(1),27,"I"))
 S ^TMP($J,LIST,+PSS(1),31)=$G(^TMP("PSSP50",$J,50,PSS(1),31,"I"))
 S ^TMP($J,LIST,+PSS(1),40)=$G(^TMP("PSSP50",$J,50,PSS(1),40,"I"))
 S ^TMP($J,LIST,+PSS(1),51)=$S($G(^TMP("PSSP50",$J,50,PSS(1),51,"I"))="":"",1:$G(^TMP("PSSP50",$J,50,PSS(1),51,"I"))_"^"_$G(^TMP("PSSP50",$J,50,PSS(1),51,"E")))
 S ^TMP($J,LIST,+PSS(1),52)=$S($G(^TMP("PSSP50",$J,50,PSS(1),52,"I"))="":"",1:$G(^TMP("PSSP50",$J,50,PSS(1),52,"I"))_"^"_$G(^TMP("PSSP50",$J,50,PSS(1),52,"E")))
 S ^TMP($J,LIST,+PSS(1),63)=$G(^TMP("PSSP50",$J,50,PSS(1),63,"I"))
 S ^TMP($J,LIST,+PSS(1),64)=$S('$P($G(^TMP("PSSP50",$J,50,PSS(1),64,"I")),"^"):"",1:$P($G(^TMP("PSSP50",$J,50,PSS(1),64,"I")),"^")_"^"_$P($G(^TMP("PSSP50",$J,50,PSS(1),64,"E")),"^"))
 S ^TMP($J,LIST,+PSS(1),100)=$S($G(^TMP("PSSP50",$J,50,PSS(1),100,"I"))="":"",1:$G(^TMP("PSSP50",$J,50,PSS(1),100,"I"))_"^"_$G(^TMP("PSSP50",$J,50,PSS(1),100,"E")))
 S ^TMP($J,LIST,+PSS(1),101)=$G(^TMP("PSSP50",$J,50,PSS(1),101,"I"))
 S ^TMP($J,LIST,+PSS(1),102)=$G(^TMP("PSSP50",$J,50,PSS(1),102,"I"))
 S ^TMP($J,LIST,+PSS(1),301)=$S($G(^TMP("PSSP50",$J,50,PSS(1),301,"I"))="":"",1:$G(^TMP("PSSP50",$J,50,PSS(1),301,"I"))_"^"_$G(^TMP("PSSP50",$J,50,PSS(1),301,"E")))
 S ^TMP($J,LIST,+PSS(1),302)=$G(^TMP("PSSP50",$J,50,PSS(1),302,"I"))
 D SRVCODE
 Q
 ;
SETSYN ;
 S ^TMP($J,LIST,+PSS(1),"SYN",+PSS(2),.01)=$G(^TMP("PSSP50",$J,50.1,PSS(2),.01,"I"))
 S ^TMP($J,LIST,+PSS(1),"SYN",+PSS(2),1)=$S($G(^TMP("PSSP50",$J,50.1,PSS(2),1,"I"))="":"",1:^TMP("PSSP50",$J,50.1,PSS(2),1,"I")_"^"_^TMP("PSSP50",$J,50.1,PSS(2),1,"E"))
 S ^TMP($J,LIST,+PSS(1),"SYN",+PSS(2),2)=$G(^TMP("PSSP50",$J,50.1,PSS(2),2,"I"))
 S ^TMP($J,LIST,+PSS(1),"SYN",+PSS(2),403)=$G(^TMP("PSSP50",$J,50.1,PSS(2),403,"I"))
 Q
 ;
SETFMA ;
 S ^TMP($J,LIST,+PSS(1),"FRM",+PSS(2),.01)=$S($G(^TMP("PSSP50",$J,50.065,PSS(2),.01,"I"))="":"",1:^TMP("PSSP50",$J,50.065,PSS(2),.01,"I")_"^"_^TMP("PSSP50",$J,50.065,PSS(2),.01,"E"))
 Q
 ;
SETOLD ;
 S ^TMP($J,LIST,+PSS(1),"OLD",+PSS(2),.01)=$G(^TMP("PSSP50",$J,50.01,PSS(2),.01,"I"))
 S ^TMP($J,LIST,+PSS(1),"OLD",+PSS(2),.02)=$S($G(^TMP("PSSP50",$J,50.01,PSS(2),.02,"I"))="":"",1:^TMP("PSSP50",$J,50.01,PSS(2),.02,"I")_"^"_^TMP("PSSP50",$J,50.01,PSS(2),.02,"E"))
 Q
 ;
SRVCODE ;
 ;PFSS retrieve correct service code from file #50.68/#50 or set to 600000
 S ^TMP($J,LIST,+PSS(1),400)=$G(^TMP("PSSP50",$J,50,PSS(1),400,"I"))
 N PSSNDSC S PSSNDSC=$$GET1^DIQ(50,PSSIEN_",","22:2000","I")
 S:PSSNDSC ^TMP($J,LIST,+PSS(1),400)=PSSNDSC
 I '+$G(^TMP($J,LIST,+PSS(1),400)) S ^TMP($J,LIST,+PSS(1),400)=600000
 Q

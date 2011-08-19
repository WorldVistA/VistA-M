PSS50F1 ;BIR/RTR - API FOR INFORMATION FROM FILE 50
 ;;1.0;PHARMACY DATA MANAGEMENT;**85**;9/30/97
 ;
 ;Reference to ^PS(50.605 is supported by DBIA #2138
 ;
LIST ;
 ;PSSFT - Free Text name in 50
 ;PSSFL - Inactive flag - "" - All entries
 ;                        FileMan Date - Only entries with no Inactive Date or an Inactive Date greater than this date.
 ;PSSD - Index used in the lookup in the format B^C
 ;PSSPK - Application Package's Use - "" - All entries
 ;                                         Alphabetic codes that represent the DHCP packages that consider this drug to be
 ;                                         part of their formulary.
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the Field Number of the data
 ;       piece being returned.
 N DIERR,ZZERR,PSSP50,SCR,PSS,CNT,PSSXSUB,PSSLUPAR,PSSLUPP,PSSSCRN,PSSENCT
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I $G(PSSFT)']"" S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 S SCR("S")=""
 S PSSXSUB="" D SETXSUB
 S PSSENCT=0
 I +$G(PSSFL)>0!($G(PSSPK)]"") N PSS5ND,PSSZ3,PSSZ4 D SETSCRN^PSS50A
 I $G(PSSFT)]"" D
 .I PSSFT["??" D LOOP Q
 .K ^TMP("DILIST",$J),^TMP($J,"PSSLDONE")
 .S PSSSCRN=$G(SCR("S")) S:$G(PSSD)="" PSSD="B" D PARSE^PSS50F(PSSD) I '$O(PSSLUPAR(0)) Q
 .S PSSLUPP=0 F  S PSSLUPP=$O(PSSLUPAR(PSSLUPP)) Q:'PSSLUPP  D
 ..S SCR("S")=$G(PSSSCRN)
 ..D FIND^DIC(50,,"@;.01","QPB"_$S($P(PSSLUPAR(PSSLUPP),"^",2):"X",1:""),PSSFT,,PSSLUPAR(PSSLUPP),SCR("S"),,"")
 ..I +$G(^TMP("DILIST",$J,0))=0 Q
 ..I +^TMP("DILIST",$J,0)>0 N PSSXX S PSSXX=0 F  S PSSXX=$O(^TMP("DILIST",$J,PSSXX)) Q:'PSSXX  D
 ...S PSSIEN=+^TMP("DILIST",$J,PSSXX,0) I '$D(^TMP($J,"PSSLDONE",PSSIEN)) S ^TMP($J,"PSSLDONE",PSSIEN)="" D
 ....K ^TMP("PSSP50",$J) D GETS^DIQ(50,+PSSIEN,".01;100;2.1","IE","^TMP(""PSSP50"",$J)") S PSS(1)=0
 ....F  S PSS(1)=$O(^TMP("PSSP50",$J,50,PSS(1))) Q:'PSS(1)  D SETLIST
 S ^TMP($J,LIST,0)=$S($G(PSSENCT):$G(PSSENCT),1:"-1^NO DATA FOUND")
 K ^TMP("DILIST",$J),^TMP("PSSP50",$J),^TMP($J,"PSSLDONE")
 Q
SETLIST ;
 S PSSENCT=PSSENCT+1
 S ^TMP($J,LIST,+PSS(1),.01)=$G(^TMP("PSSP50",$J,50,PSS(1),.01,"I"))
 ;S ^TMP($J,LIST,"B",$G(^TMP("PSSP50",$J,50,PSS(1),.01,"I")),+PSS(1))=""
 ;S ^TMP($J,LIST,$S($G(PSSD)]"":$P(PSSD,"^"),1:"B"),^TMP("PSSP50",$J,50,PSS(1),.01,"I"),+PSS(1))=""
 S ^TMP($J,LIST,$S($G(PSSXSUB)'="":$G(PSSXSUB),1:"B"),^TMP("PSSP50",$J,50,PSS(1),.01,"I"),+PSS(1))=""
 S ^TMP($J,LIST,+PSS(1),2.1)=$S($G(^TMP("PSSP50",$J,50,PSS(1),2.1,"I"))="":"",1:$G(^TMP("PSSP50",$J,50,PSS(1),2.1,"I"))_"^"_$G(^TMP("PSSP50",$J,50,PSS(1),2.1,"E")))
 I $P($G(^TMP($J,LIST,+PSS(1),2.1)),"^") D
 .N PSSADDF S PSSADDF=$$SETDF^PSS50AQM($P(^TMP($J,LIST,+PSS(1),2.1),"^")) S ^TMP($J,LIST,+PSS(1),2.1)=^TMP($J,LIST,+PSS(1),2.1)_$S($P($G(PSSADDF),"^")>0:"^"_$P($G(PSSADDF),"^",3)_"^"_$P($G(PSSADDF),"^",4),1:"")
 S ^TMP($J,LIST,+PSS(1),100)=$S($G(^TMP("PSSP50",$J,50,PSS(1),100,"I"))="":"",1:$G(^TMP("PSSP50",$J,50,PSS(1),100,"I"))_"^"_$G(^TMP("PSSP50",$J,50,PSS(1),100,"E")))
 Q
LOOP ;
 S PSS(1)=0 F  S PSS(1)=$O(^PSDRUG(PSS(1))) Q:'PSS(1)  D
 .I $P($G(^PSDRUG(PSS(1),0)),"^")="" Q
 .I $G(PSSFL),$P($G(^PSDRUG(PSS(1),"I")),"^"),$P($G(^("I")),"^")'>PSSFL Q
 .;I $G(PSSRTOI)=1,'$P($G(^PSDRUG(PSS(1),2)),"^") Q
 .;Naked reference below refers to ^PSDRUG(PSS(1),2)
 .I $G(PSSPK)]"" N PSSZ5,PSSZ6 S PSSZ5=0 F PSSZ6=1:1:$L(PSSPK) Q:PSSZ5  I $P($G(^(2)),"^",3)[$E(PSSPK,PSSZ6) S PSSZ5=1
 .I $G(PSSPK)]"",'PSSZ5 Q
 .D SETLISTL
 .S PSSENCT=PSSENCT+1
 Q
SETLISTL ;
 N PSSZNODE,PSS2NODE S PSSZNODE=$G(^PSDRUG(PSS(1),0)),PSS2NODE=$G(^(2))
 S ^TMP($J,LIST,+PSS(1),.01)=$P(PSSZNODE,"^")
 S ^TMP($J,LIST,"B",$P(PSSZNODE,"^"),+PSS(1))=""
 S ^TMP($J,LIST,+PSS(1),2.1)=$S('$P(PSS2NODE,"^"):"",1:$P(PSS2NODE,"^")_"^"_$P($G(^PS(50.7,+$P(PSS2NODE,"^"),0)),"^"))
 N PSSADDF S PSSADDF=$P($G(^PS(50.7,+$P($G(^TMP($J,LIST,+PSS(1),2.1)),"^"),0)),"^",2) I PSSADDF>0 D
 .S ^TMP($J,LIST,+PSS(1),2.1)=^TMP($J,LIST,+PSS(1),2.1)_"^"_PSSADDF_"^"_$P($G(^PS(50.606,PSSADDF,0)),"^")
 N Y S Y=$P($G(^PSDRUG(PSS(1),"I")),"^") D
 .I Y S ^TMP($J,LIST,+PSS(1),100)=$G(Y) X ^DD("DD") S ^TMP($J,LIST,+PSS(1),100)=^TMP($J,LIST,+PSS(1),100)_"^"_$G(Y) Q
 .S ^TMP($J,LIST,+PSS(1),100)=""
 Q
SETXSUB ;
 Q:$G(PSSD)=""
 N PSSLSX,PSSLSXCT,PSSLCNT,PSSDSUB
 S PSSLSXCT=0
 F PSSLSX=1:1:$L(PSSD) I $E(PSSD,PSSLSX)="^" S PSSLSXCT=PSSLSXCT+1
 S PSSLSXCT=PSSLSXCT+1
 S PSSLCNT=0 F PSSLSX=1:1:PSSLSXCT S PSSDSUB=$P(PSSD,"^",PSSLSX) Q:PSSLCNT>1  S PSSXSUB=$S(PSSDSUB'="":PSSDSUB,PSSXSUB'="":PSSXSUB,1:"") S:PSSDSUB'="" PSSLCNT=PSSLCNT+1
 I PSSLCNT>1 S PSSXSUB=""
 Q
LOOKUP ;
 ;PSSFT - Free Text value that could be the NAME field (#.01), IEN, VA PRODUCT NAME field (#21), NATIONAL DRUG CLASS field (#25),
 ;        or SYNONYM (#.01) mutiple of the DRUG file (#50).
 ;PSSFL - Inactive flag - "" - All entries
 ;                        FileMan Date - Only entries with no Inactive Date or an Inactive Date greater than this date.
 ;PSSPK - Application Package's Use - "" - All entries
 ;                                         Alphabetic codes that represent the DHCP packages that consider this drug to be
 ;                                         part of their formulary.
 ;PSSRTOI - 1 - only drugs with data in the PHARMACY ORDERABLE ITEM field (#2.1) will be returned.
 ;PSSIFCAP - 1 - only drugs with no data in the IFCAP ITEM NUMBER multiple (#441) will be returned.
 ;PSSCMOP         - 1 - only drugs with no data in the CMOP ID field (#27) will be returned.
 ;PSSD - Index used in the lookup in the format B^C.
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the Field Number of the data
 ;       piece being returned.
 N PSSLKIEN,PSSLKSUB,PSSENCT,SCR,PSSXSUB,CNT,PSS,DIERR
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I $G(PSSFT)']"" S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 S PSSENCT=0
 I PSSFT["??" D LOOPLK Q
 S SCR("S")=""
 I $G(PSSCMOP)=1 D
 .S SCR("S")="I $P($G(^(""ND"")),""^"",10)=""""" Q
 I $G(PSSIFCAP)=1 D
 .I SCR("S")="" S SCR("S")="I '$O(^PSDRUG(+Y,441,0))" Q
 .S SCR("S")=SCR("S")_" I '$O(^PSDRUG(+Y,441,0))"
 I +$G(PSSFL)>0!($G(PSSPK)]"")!($G(PSSRTOI)=1) N PSS5ND,PSSZ3,PSSZ4 D SETSCRN
 I PSSFT'="",PSSFT?1"`"1N.N D  S ^TMP($J,LIST,0)=$S($G(PSSENCT):$G(PSSENCT),1:"-1^NO DATA FOUND") Q
 .N PSSIEN2 S PSSIEN2=$$FIND1^DIC(50,"","A",PSSFT,,SCR("S"),"")
 .K ^TMP("DIERR",$J)
 .I +PSSIEN2'>0 Q
 .I $P($G(^PSDRUG(+PSSIEN2,0)),"^")="" Q
 .S PSSLKIEN=+PSSIEN2,PSSLKSUB="B"
 .D LOOKSET
 I $G(PSSFT)]"" D
 .N PSSLUPAR,PSSLUPP,PSSSCRN
 .S PSSXSUB="" D SETXSUB S PSSLKSUB=$S($G(PSSXSUB)'="":$G(PSSXSUB),1:"B")
 .K ^TMP("DILIST",$J),^TMP($J,"PSSLDONE")
 .S PSSSCRN=$G(SCR("S")) S:$G(PSSD)="" PSSD="B" D PARSE^PSS50F(PSSD) I '$O(PSSLUPAR(0)) Q
 .S PSSLUPP=0 F  S PSSLUPP=$O(PSSLUPAR(PSSLUPP)) Q:'PSSLUPP  D
 ..S SCR("S")=PSSSCRN
 ..D FIND^DIC(50,,"@;.01","QPB"_$S($P(PSSLUPAR(PSSLUPP),"^",2):"X",1:""),PSSFT,,PSSLUPAR(PSSLUPP),SCR("S"),,"")
 ..I +$G(^TMP("DILIST",$J,0))=0 Q
 ..I +^TMP("DILIST",$J,0)>0 N PSSXX S PSSXX=0 F  S PSSXX=$O(^TMP("DILIST",$J,PSSXX)) Q:'PSSXX  D
 ...S PSSLKIEN=+^TMP("DILIST",$J,PSSXX,0) I $P($G(^PSDRUG(PSSLKIEN,0)),"^")'="",'$D(^TMP($J,"PSSLDONE",PSSLKIEN)) S ^TMP($J,"PSSLDONE",PSSLKIEN)="" D LOOKSET
 S ^TMP($J,LIST,0)=$S($G(PSSENCT):$G(PSSENCT),1:"-1^NO DATA FOUND")
 K ^TMP("DILIST",$J),^TMP($J,"PSSLDONE")
 Q
LOOKSET ;
 ;PSSLKIEN = ien from File 50
 ;PSSLKSUB = Subscript for the cross reference return
 N PSSLKNAM,PSSLKND,PSSLKZER
 S PSSLKNAM=$P($G(^PSDRUG(PSSLKIEN,0)),"^"),PSSLKND=$G(^("ND")),PSSLKZER=$G(^(0)) Q:PSSLKNAM=""
 S ^TMP($J,LIST,PSSLKIEN,.01)=PSSLKNAM
 S ^TMP($J,LIST,PSSLKSUB,PSSLKNAM,PSSLKIEN)=""
 S PSSENCT=PSSENCT+1
 S ^TMP($J,LIST,PSSLKIEN,25)=$S($P(PSSLKND,"^",6):$P(PSSLKND,"^",6)_"^"_$P($G(^PS(50.605,+$P(PSSLKND,"^",6),0)),"^")_"^"_$P($G(^(0)),"^",2),1:"")
 N Y S Y=$P($G(^PSDRUG(PSSLKIEN,"I")),"^") D
 .I Y S ^TMP($J,LIST,PSSLKIEN,100)=$G(Y) X ^DD("DD") S ^TMP($J,LIST,PSSLKIEN,100)=^TMP($J,LIST,PSSLKIEN,100)_"^"_$G(Y) Q
 .S ^TMP($J,LIST,PSSLKIEN,100)=""
 S ^TMP($J,LIST,PSSLKIEN,101)=$P(PSSLKZER,"^",10)
 Q
LOOPLK ;
 S PSSLKSUB="B"
 S PSSLKIEN=0 F  S PSSLKIEN=$O(^PSDRUG(PSSLKIEN)) Q:'PSSLKIEN  D
 .I $P($G(^PSDRUG(PSSLKIEN,0)),"^")="" Q
 .I $G(PSSCMOP)=1,$P($G(^PSDRUG(PSSLKIEN,"ND")),"^",10)'="" Q
 .I $G(PSSIFCAP)=1,$O(^PSDRUG(PSSLKIEN,441,0)) Q
 .I $G(PSSFL),$P($G(^PSDRUG(PSSLKIEN,"I")),"^"),$P($G(^("I")),"^")'>PSSFL Q
 .I $G(PSSRTOI)=1,'$P($G(^PSDRUG(PSSLKIEN,2)),"^") Q
 .I $G(PSSPK)]"" N PSSZ5,PSSZ6 S PSSZ5=0 F PSSZ6=1:1:$L(PSSPK) Q:PSSZ5  I $P($G(^PSDRUG(PSSLKIEN,2)),"^",3)[$E(PSSPK,PSSZ6) S PSSZ5=1
 .I $G(PSSPK)]"",'PSSZ5 Q
 .D LOOKSET
 S ^TMP($J,LIST,0)=$S($G(PSSENCT):$G(PSSENCT),1:"-1^NO DATA FOUND")
 Q
 ;
SETSCRN ;Set Screen
 I +$G(PSSFL)>0 D
 .I SCR("S")]"" S SCR("S")=SCR("S")_" S PSS5ND=$P($G(^PSDRUG(+Y,""I"")),""^"") I PSS5ND=""""!(PSS5ND>PSSFL)" Q
 .S SCR("S")="S PSS5ND=$P($G(^PSDRUG(+Y,""I"")),""^"") I PSS5ND=""""!(PSS5ND>PSSFL)"
 I $G(PSSRTOI)=1 D
 .I SCR("S")]"" S SCR("S")=SCR("S")_" I $P($G(^PSDRUG(+Y,2)),""^"")" Q
 .S SCR("S")="I $P($G(^PSDRUG(+Y,2)),""^"")"
 I $G(PSSPK)]"" D
 .I SCR("S")]"" S SCR("S")=SCR("S")_" S PSSZ3=0 F PSSZ4=1:1:$L(PSSPK) Q:PSSZ3  I $P($G(^PSDRUG(+Y,2)),""^"",3)[$E(PSSPK,PSSZ4) S PSSZ3=1" Q
 .S SCR("S")="S PSSZ3=0 F PSSZ4=1:1:$L(PSSPK) Q:PSSZ3  I $P($G(^PSDRUG(+Y,2)),""^"",3)[$E(PSSPK,PSSZ4) S PSSZ3=1"
 ;I $G(PSSPK)]"" S SCR("S")=$S(SCR("S")]"":SCR("S")_" I $G(^PSDRUG(+Y,2)),$P($G(^PSDRUG(+Y,2)),""^"",3)[PSSPK",1:"I $G(^PSDRUG(+Y,2)),$P($G(^PSDRUG(+Y,2)),""^"",3)[PSSPK")
 Q

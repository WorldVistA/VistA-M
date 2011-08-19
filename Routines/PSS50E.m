PSS50E ;BIR/LDT - API FOR INFORMATION FROM FILE 50; 5 Sep 03
 ;;1.0;PHARMACY DATA MANAGEMENT;**85,104**;9/30/97
 ;
SKB(PSSIEN2,PSSFL2) ;
 ;PSSIEN2 - IEN of entry in 50
 ;PSSFL2 - action flag - S to set the "B" cross-reference or
 ;                      K to kill the "B" cross-reference.
 ;
 I +$G(PSSIEN2)'>0 Q 0
 I "SK"'[$G(PSSFL2) Q 0
 I PSSFL2="S",$G(^PSDRUG(+PSSIEN2,0))]"" S ^PSDRUG("B",$E($P($G(^PSDRUG(+PSSIEN2,0)),"^"),1,40),+PSSIEN2)="" Q 1
 I PSSFL2="K",$G(^PSDRUG(+PSSIEN2,0))]"" K ^PSDRUG("B",$E($P($G(^PSDRUG(+PSSIEN2,0)),"^"),1,40),+PSSIEN2) Q 1
 Q 0
 ;
 I $A(PSSVAL)'=34 S PSSVAL=$C(34)_PSSVAL_$C(34)
AOC ;
 ;PSSVAL - VA CLASSIFICATION field (#2) of the DRUG file (#50)
 ;PSSFL - Inactive flag - "" - All entries
 ;                        FileMan Date - Only entries with no Inactive Date or an Inactive Date greater than this date.
 ;PSSPK - Application Package's Use - "" - All entries
 ;                                         Alphabetic codes that represent the DHCP packages that consider this drug to be
 ;                                         part of their formulary.
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the Field Number of the data
 ;       piece being returned.
 ;
 N PSS
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I $G(PSSVAL)']"" S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 S ^TMP($J,LIST,0)=0
 S PSS(1)=0  F  S PSS(1)=$O(^PSDRUG("AOC",PSS(1))) Q:'PSS(1)  S PSS(2)="" F  S PSS(2)=$O(^PSDRUG("AOC",PSS(1),PSS(2))) Q:PSS(2)=""  D
 .Q:PSS(2)'=PSSVAL  S PSS(3)=0 F  S PSS(3)=$O(^PSDRUG("AOC",PSS(1),PSS(2),PSS(3))) Q:'PSS(3)  D
 ..N ZNODE,NODE2,INODE S ZNODE=$G(^PSDRUG(+PSS(3),0)),NODE2=$G(^(2)),INODE=$G(^("I"))
 ..I +$G(PSSFL)>0,+INODE>0,+INODE'>PSSFL Q
 ..;Naked reference below refers to ^PSDRUG(+PSS(3),2)
 ..I $G(PSSPK)]"" N PSSZ5,PSSZ6 S PSSZ5=0 F PSSZ6=1:1:$L(PSSPK) Q:PSSZ5  I $P($G(^(2)),"^",3)[$E(PSSPK,PSSZ6) S PSSZ5=1
 ..I $G(PSSPK)]"",'PSSZ5 Q
 ..S ^TMP($J,LIST,0)=^TMP($J,LIST,0)+1,^TMP($J,LIST,+PSS(3),.01)=$P(ZNODE,"^")
 ..S ^TMP($J,LIST,"AOC",$P(ZNODE,"^"),+PSS(3))=""
 I ^TMP($J,LIST,0)'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND"
 Q
 ;
C ;
 ;PSSVAL - SYNONYM sub-field (#9) of the DRUG file (#50)
 ;PSSFL - Inactive flag - "" - All entries
 ;                        FileMan Date - Only entries with no Inactive Date or an Inactive Date greater than this date.
 ;PSSPK - Application Package's Use - "" - All entries
 ;                                         Alphabetic codes that represent the DHCP packages that consider this drug to be
 ;                                         part of their formulary.
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the Field Number of the data
 ;       piece being returned.
 ;       
 N DIERR,ZZERR,PSS,PSSP50
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I $G(PSSVAL)']"" S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 S ^TMP($J,LIST,0)=0
 S PSS(1)=""  F  S PSS(1)=$O(^PSDRUG("C",PSS(1))) Q:PSS(1)=""  S PSS(2)="" F  S PSS(2)=$O(^PSDRUG("C",PSS(1),PSS(2))) Q:PSS(2)=""  D
 .Q:PSS(1)'=PSSVAL  D
 ..N ZNODE,NODE2,INODE S ZNODE=$G(^PSDRUG(+PSS(2),0)),NODE2=$G(^(2)),INODE=$P($G(^("I")),"^")
 ..I +$G(PSSFL)>0,+INODE>0,+INODE'>PSSFL Q
 ..;Naked reference below refers to ^PSDRUG(+PSS(2),2)
 ..I $G(PSSPK)]"" N PSSZ5,PSSZ6 S PSSZ5=0 F PSSZ6=1:1:$L(PSSPK) Q:PSSZ5  I $P($G(^(2)),"^",3)[$E(PSSPK,PSSZ6) S PSSZ5=1
 ..I $G(PSSPK)]"",'PSSZ5 Q 
 ..S ^TMP($J,LIST,0)=^TMP($J,LIST,0)+1,^TMP($J,LIST,+PSS(2),.01)=$P(ZNODE,"^"),^TMP($J,LIST,"C",$P(ZNODE,"^"),+PSS(2))="" D
 ...K PSSP50 D GETS^DIQ(50,+PSS(2),"9*","IE","PSSP50") S PSS(3)=0
 ...F  S PSS(3)=$O(PSSP50(50.1,PSS(3))) Q:'PSS(3)  D
 ....S ^TMP($J,LIST,+PSS(2),+PSS(3),.01)=$G(PSSP50(50.1,PSS(3),.01,"I"))
 ....S ^TMP($J,LIST,+PSS(2),+PSS(3),2)=$G(PSSP50(50.1,PSS(3),2,"I"))
 ....S ^TMP($J,LIST,+PSS(2),+PSS(3),1)=$S($G(PSSP50(50.1,PSS(3),1,"I"))="":"",1:PSSP50(50.1,PSS(3),1,"I")_"^"_PSSP50(50.1,PSS(3),1,"E"))
 ....S ^TMP($J,LIST,+PSS(2),+PSS(3),400)=$G(PSSP50(50.1,PSS(3),400,"I"))
 ....S ^TMP($J,LIST,+PSS(2),+PSS(3),401)=$S($G(PSSP50(50.1,PSS(3),401,"I"))="":"",1:PSSP50(50.1,PSS(3),401,"I")_"^"_PSSP50(50.1,PSS(3),401,"E"))
 ....S ^TMP($J,LIST,+PSS(2),+PSS(3),402)=$G(PSSP50(50.1,PSS(3),402,"I"))
 ....S ^TMP($J,LIST,+PSS(2),+PSS(3),403)=$G(PSSP50(50.1,PSS(3),403,"I"))
 ....S ^TMP($J,LIST,+PSS(2),+PSS(3),404)=$G(PSSP50(50.1,PSS(3),404,"I"))
 ....S ^TMP($J,LIST,+PSS(2),+PSS(3),405)=$G(PSSP50(50.1,PSS(3),405,"I"))
 I ^TMP($J,LIST,0)'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND"
 K PSSP50
 Q
 ;
SKAQ(PSSIEN2,PSSFL2) ;
 ;PSSIEN2 - IEN of entry in 50
 ;PSSFL2 - action flag - S to set the "AQ" cross-reference or
 ;                       K to kill the "AQ" cross-reference.
 ;
 I +$G(PSSIEN2)'>0 Q 0
 I "SK"'[$G(PSSFL2) Q 0
 I PSSFL2="S",$G(^PSDRUG(+PSSIEN2,3))=1 S ^PSDRUG("AQ",+PSSIEN2)="" Q 1
 I PSSFL2="K",+$G(^PSDRUG(+PSSIEN2,3))=0 K ^PSDRUG("AQ",+PSSIEN2) Q 1
 Q 0
 ;
SKAQ1(PSSIEN2) ;
 ;PSSIEN2 - IEN of entry in 50
 I +$G(PSSIEN2)'>0 Q 0
 N PSS,QFLG S PSS="" F  S PSS=$O(^PSDRUG("AQ1",PSS)) Q:PSS=""  D
 .K ^PSDRUG("AQ1",PSS,+PSSIEN2) S QFLG=1
 .I $P($G(^PSDRUG(+PSSIEN2,"ND")),"^",10)]"" S ^PSDRUG("AQ1",$E($P($G(^PSDRUG(+PSSIEN2,"ND")),"^",10),1,30),+PSSIEN2)="" S QFLG=1
 I $D(QFLG) Q 1
 Q 0
A526 ;
 ;PSSIEN - IEN of entry in 50
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST, of the data
 ;       being returned.
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I +$G(PSSIEN)'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 N PSS,CNT S (PSS,CNT)=0 F  S PSS=$O(^PSDRUG("A526",+PSSIEN,PSS)) Q:'PSS  D
 .S ^TMP($J,LIST,+PSS,.01)=$P($G(^PS(52.6,+PSS,0)),"^"),CNT=CNT+1
 .S ^TMP($J,LIST,"A526",$P($G(^PS(52.6,+PSS,0)),"^"),+PSS)=""
 S ^TMP($J,LIST,0)=$S(CNT>0:CNT,1:"-1^NO DATA FOUND")
 Q
A527 ;
 ;PSSIEN - IEN of entry in 50
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST, of the data
 ;       being returned.
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I +$G(PSSIEN)'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 N PSS,CNT S (PSS,CNT)=0 F  S PSS=$O(^PSDRUG("A527",+PSSIEN,PSS)) Q:'PSS  D
 .S ^TMP($J,LIST,+PSS,.01)=$P($G(^PS(52.7,+PSS,0)),"^"),CNT=CNT+1
 .S ^TMP($J,LIST,"A527",$P($G(^PS(52.7,+PSS,0)),"^"),+PSS)=""
 S ^TMP($J,LIST,0)=$S(CNT>0:CNT,1:"-1^NO DATA FOUND")
 Q
SKAIU(PSSIEN2,PSSFL2) ;
 ;PSSIEN2 - IEN of entry in 50
 ;PSSFL2 - action flag - S to set the "AIU" cross-reference or
 ;                       K to kill the "AIU" cross-reference
 ;
 I +$G(PSSIEN2)'>0 Q 0
 I "SK"'[$G(PSSFL2) Q 0
 N PSS,PSS2,PSSNM,PSSPK2,QFLG,PSSPK3
 S PSSPK3="INOSUWX"
 S PSSPK2=$P($G(^PSDRUG(+PSSIEN2,2)),"^",3),PSSNM=$P($G(^PSDRUG(+PSSIEN2,0)),"^")
 I PSSNM']"" Q 0
 I PSSNM]"" S PSS="" F PSS2=1:1:$L(PSSPK3) S PSS=$O(^PSDRUG("AIU"_$E(PSSPK3,PSS2))) Q:PSS=""  D
 .K ^PSDRUG("AIU"_$E(PSSPK3,PSS2),PSSNM,+PSSIEN2) S:$G(PSSFL2)="K" QFLG=1
 I PSSPK2]"" F PSS=1:1:$L(PSSPK2) S ^PSDRUG("AIU"_$E(PSSPK2,PSS),PSSNM,PSSIEN2)="" S:$G(PSSFL2)="S" QFLG=1
 I $D(QFLG) Q 1
 Q 0
SKIU(PSSIEN2) ;
 ;PSSIEN2 - IEN of entry in 50
 I +$G(PSSIEN2)'>0 Q 0
 N PSS,PSSPK2,QFLG S PSS="" F  S PSS=$O(^PSDRUG("IU",PSS)) Q:PSS=""  D
 .K ^PSDRUG("IU",PSS,+PSSIEN2) S QFLG=1
 .S PSSPK2=$P($G(^PSDRUG(+PSSIEN2,2)),"^",3)
 .I PSSPK2]"" S ^PSDRUG("IU",PSSPK2,+PSSIEN2)="" S QFLG=1
 I $D(QFLG) Q 1
 Q 0
FNAME(PSSFNO2,PSSFILE2) ;
 I +$G(PSSFNO2)'>0!(+$G(PSSFILE2)'>0) Q ""
 N PSSNAME,PSSFFIND,PSSFILEZ,PSSFNUMB
 S PSSFILEZ=0
 I +$G(PSSFILE2)<60,+$G(PSSFILE2)'<50 S PSSFILEZ=1
 I 'PSSFILEZ F PSSFFIND=1:1 S PSSFNUMB=$P($T(FLIST+PSSFFIND),";;",2) Q:PSSFILEZ!(PSSFNUMB="")  I PSSFNUMB=+$G(PSSFILE2) S PSSFILEZ=1
 I PSSFILEZ D FIELD^DID(+$G(PSSFILE2),PSSFNO2,"","LABEL","PSSNAME",)
 Q $G(PSSNAME("LABEL"))
 ;
FLIST ;
 ;;550
 ;;550.04
 ;;550.07
 ;;550.08
 ;;550.09
 ;;550.1
 ;;550.11
 ;;550.1101
 ;;550.2
 ;;550.215
 ;;550.216
 ;;1020.1
 ;;1020.2
 ;;1020.3
 ;;1020.4
 ;;1020.5
 ;;1020.51
 ;;1020.6
 ;;1020.7
 ;;1020.8
 ;;9009032.3
 ;;9009032.4
 ;;9009032.411
 ;;9009032.412
 ;;9009032.413
 ;;9009032.414
 ;;9009032.415
 ;;9009032.416
 ;;9009032.5
 Q

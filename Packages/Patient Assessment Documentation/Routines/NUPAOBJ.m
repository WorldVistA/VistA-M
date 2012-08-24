NUPAOBJ ;PHOENIX/KLD; 6/23/09; PULL PATIENT INFO; 1/11/12  8:38 AM
 ;;1.0;NUPA;;;Build 105
 ;;Object code taken from my R1TIOB package
 ;;IAs used: 2400, 3800, 4477
ST Q
 ;
MAR() ;Marital status
 Q $$FLD("MARITAL STATUS^.05")
 ;
RELIG() ;Patient's Religious preference
 Q $$FLD("RELIGION^.08")
 ;
FLD(Z) N X S X=$$GET1^DIQ(2,DFN,$P(Z,U,2)) Q $P(Z,U)_" - "_$S(X="":"NONE FOUND",1:X)
 ;
NVA(T) ;Active Non-VA Meds  T=Time period^Condensed Version (0 for No or 1 for Yes)
 N NUPA,X,X1,X2,Y D K,NONE("ACTIVE NON-VA MEDS"),AGO^NUPAOBJ1
 S X1=NUPA("ED"),X2=-365 D C^%DTC S NUPA("ED",1)=X
 S $P(NUPA("SP")," ",50)="",NUPA("C")=0
 ;Go back an additonal year in the next call to capture RXs dispensed then,
 ;who's days of supply would then extend into the proper time period.
 D OCL^PSOORRL(DFN,NUPA("ED",1),DT,0) ;IA 2400
 F NUPA("I")=0:0 S NUPA("I")=$O(^TMP("PS",$J,NUPA("I"))) Q:'NUPA("I")  D
 .S NUPA("TYPE")=$P(^TMP("PS",$J,NUPA("I"),0),U)
 .Q:NUPA("TYPE")'["N;O"  Q:$P(^TMP("PS",$J,NUPA("I"),0),U,9)'="ACTIVE"  ;Non-VA Meds
 .Q:$P(^TMP("PS",$J,NUPA("I"),0),U,2)["OTHER"
 .S NUPA("ORD")=$P(^TMP("PS",$J,NUPA("I"),0),U,8)
 .Q:$$GET1^DIQ(100,NUPA("ORD"),4,"I")<NUPA("ED")  ;Order entered
 .I $D(APGKAUTH) Q:$$GET1^DIQ(100,NUPA("ORD"),1,"I")'=DUZ
 .I $D(APGKTODY) Q:$$GET1^DIQ(100,NUPA("ORD"),4,"I")'=DT  ;Order entered
 .S NUPA("C")=NUPA("C")+1
 .S ^TMP("NUPA",$J,"SORT","N",$P(^TMP("PS",$J,NUPA("I"),0),U,2),NUPA("C"))=NUPA("ORD")_U_^TMP("PS",$J,NUPA("I"),"SIG",1,0)
 S (NUPA("C"),NUPA("C",1))=0,NUPA("RX")=""
 D:$D(^TMP("NUPA",$J,"SORT","N")) SET("***  NON-VA MEDS  ***")
 F  S NUPA("RX")=$O(^TMP("NUPA",$J,"SORT","N",NUPA("RX"))) Q:NUPA("RX")=""  D
 .F NUPA("I")=0:0 S NUPA("I")=$O(^TMP("NUPA",$J,"SORT","N",NUPA("RX"),NUPA("I"))) Q:'NUPA("I")  D
 ..S NUPA("C",1)=NUPA("C",1)+1 D SET($J(NUPA("C",1),2)_")  "_NUPA("RX"))
 ..D SET("       "_$P(^TMP("NUPA",$J,"SORT","N",NUPA("RX"),NUPA("I")),U,2))
 ..S NUPA("ORD")=+^TMP("NUPA",$J,"SORT","N",NUPA("RX"),NUPA("I"))
 ..S NUPA("STATE")=0 S:'$P(T,U,2) NUPA("STATE")=$O(^OR(100,NUPA("ORD"),4.5,"ID","STATEMENTS",0))
 ..D:NUPA("STATE")
 ...F NUPA("II")=0:0 S NUPA("II")=$O(^OR(100,NUPA("ORD"),4.5,NUPA("STATE"),2,NUPA("II"))) Q:'NUPA("II")  D
 ....D SET(^OR(100,NUPA("ORD"),4.5,NUPA("STATE"),2,NUPA("II"),0))
 ..D SET("")
 K ^TMP("NUPA",$J,"SORT"),^TMP("PS",$J),APGKAUTH,APGKTODY
 Q "~@^TMP(""NUPA"","_$J_")"
 ;
TO() ;Today's orders.  Yesterday's also if desired (S NUPAYEST=""), or
 ;all orders (S NUPAALL="")
 N A,C,ED,I,II,ORD,SD,SIG,SP,X S X="ORDERS TODAY"
 S:$D(NUPAYEST) X="ORDERS YESTERDAY & TODAY" D K,NONE(X)
 S $P(SP," ",30)="",A=DFN_";DPT(",C=2
 S SD=$S($D(NUPAALL):1,1:(9999999-DT-1)) ;Inverse date for 1/1/1900 for all orders
 S ED=$S($D(NUPAALL):9999999,1:(SD+1))
 S:$D(NUPAYEST) ED=SD+2
 F I=SD:0 S I=$O(^OR(100,"AC",A,I)) Q:'I!(I>ED)  D
 .F ORD=1:0 S ORD=$O(^OR(100,"AC",A,I,ORD)) Q:'ORD  D
 ..Q:$$GET1^DIQ(100,ORD,2)["ALLERGY ENTER/EDIT"
 ..I $D(NUPAAUTH) Q:$$GET1^DIQ(100,ORD,1,"I")'=DUZ
 ..I $G(PKG) Q:$$GET1^DIQ(100,ORD,12,"I")'=PKG
 ..I $G(STAT) Q:$$GET1^DIQ(100,ORD,5)'=STAT
 ..;next IF is for text orders with no orderable items
 ..;IA 3800 allows direct global reads of ^OR(100,D0,.1
 ..I '$D(^OR(100,ORD,.1)) D TEXTORD
 ..F II=0:0 S II=$O(^OR(100,ORD,.1,II)) Q:'II  D
 ...S X=$E($E($$GET1^DIQ(101.43,+^OR(100,ORD,.1,II,0),.01),1,22)_SP,1,25)
 ...S X=$E(X_$$D($P($$GET1^DIQ(100,ORD,21,"I"),"."))_SP,1,40)
 ...S X=X_$$D($P($$GET1^DIQ(100,ORD,22,"I"),"."))
 ...S X=$E(X_SP,1,55)_$$GET1^DIQ(100,ORD,4) D SET(X)
 ...I $D(NUPASIG) D  ;Only display Sigs for Meds
 ....S X(1)=$$GET1^DIQ(100,ORD,23,"I")
 ....Q:$$GET1^DIQ(100.98,X(1),.01)'["MEDICATIONS"
 ....D SIG(ORD),SET("  Sig: "_SIG)
 I C>2 S X=$E("  Item Ordered"_SP,1,25) D
 .S C=0,X=$E(X_"START DATE"_SP,1,40)_"STOP DATE"
 .S X=$E(X_SP,1,58)_"ENTERED" D SET(X),SET("")
 K NUPAALL,NUPAAUTH,NUPASIG,NUPAYEST,PKG,STAT
 Q "~@^TMP(""NUPA"","_$J_")"
TEXTORD N I,II,III,WP,X
 F I=0:0 S I=$O(^OR(100,ORD,8,I)) Q:'I  D
 .S WP=$$GET1^DIQ(100.008,I_","_ORD,.1,"","WP")
 .F II=0:0 S II=$O(WP(II)) Q:'II  D
 ..S:II=1 X="Text Order: "
 ..I $L(WP(II))<64 D SET(X_WP(II)) S X="" Q
 ..F III=(75-$L(X)):-1:0 Q:$E(WP(II),III)=" "
 ..D SET(X_$E(WP(II),1,III)) S X=$E(WP(II),III+1,999)
 ..S:$E(X,$L(X))'=" " X=X_" "
 D:$G(X)]"" SET(X) Q
 ;
SIG(N) N NUPAWP S NUPA("SIG")="None listed" S:N NUPA("SIG")=$O(^OR(100,N,4.5,"ID","SIG",0))
 S NUPAWP=$$GET1^DIQ(100.045,NUPA("SIG")_","_N,2,"","NUPAWP")
 S NUPA("SIG",1)=$G(NUPAWP(2)) S:NUPAWP(1)]"" NUPA("SIG")=NUPAWP(1)
 I NUPA("SIG")="",N S NUPA("SIG")=$O(^OR(100,N,4.5,"ID","COMMENT",0)) D
 .S NUPAWP=$$GET1^DIQ(100.045,NUPA("SIG")_","_N,2,"","NUPAWP")
 .S NUPA("SIG",1)=$G(NUPAWP(2)) S:NUPAWP(1)]"" NUPA("SIG")=NUPAWP(1)
 Q:NUPA("SIG")]""  S NUPA("SIG")=$O(^PSRX("APL",N,0)) Q:'NUPA("SIG")
 S SIG=$$GET1^DIQ(52,NUPA("SIG"),10) Q
 ;
LADM(Z) ;Z=0 - |LAST ADMISSION DATE|  Z=1 - |LAST ADMISSION|
 ;Z=2 - Return fileman date of admission
 ;Z=3 - Return fileman date of next to last admission
 N NUPA,DA,X S X="LAST ADMISSION - NONE FOUND" Q:'$G(DFN) X
 S NUPA("ADM")=$O(^DGPM("ATID1",DFN,0)) I 'NUPA("ADM") D NONE("LAST ADMISSION") Q $S(Z=2:0,1:X)
 S DA=$O(^DGPM("ATID1",DFN,NUPA("ADM"),0)),NUPA("DIS")=$O(^DGPM("ATID3",DFN,0))
 I Z=3 S DA="",NUPA("ADM")=$O(^DGPM("ATID1",DFN,NUPA("ADM"))) S:NUPA("ADM") DA=$O(^DGPM("ATID1",DFN,NUPA("ADM"),0))
 S NUPA("ADM")=9999999.999999-NUPA("ADM") S:NUPA("DIS") NUPA("DIS")=9999999.999999-NUPA("DIS")
 S X=$S(Z<2:"Last admission: "_$$D(NUPA("ADM")),1:NUPA("ADM"))
 I Z=1 S X=X_"  DX: "_$$GET1^DIQ(405,DA,.1) S:NUPA("DIS")>NUPA("ADM") X=X_"  **  DISCHARGED  **"
 N X1,X2
 I 23[Z S NUPA=X_U_DA,X1=DT,X2=$$GET1^DIQ(405,DA,.01,"I") D ^%DTC S X=NUPA_U_X_U_$$GET1^DIQ(405,DA,.1)
 S:23[Z&(X["NONE FOUND") X=0 Q X
 ;
EC() ;Emergency Contact
 N C,X S C=0 D K
 D GETS^DIQ(2,DFN,".331;.332:.339;.33011","","X")
 D SET("     Contact: "_$G(X(2,DFN_",",.331)))
 D SET("Relationship: "_$G(X(2,DFN_",",.332)))
 D SET("     Address: "_$G(X(2,DFN_",",.333)))
 S X=$G(X(2,DFN_",",.334)) D:X]"" SET("              "_X)
 S X=$G(X(2,DFN_",",.335)) D:X]"" SET("              "_X)
 S X=$$GET1^DIQ(2,DFN,".337:1")
 D SET("              "_$G(X(2,DFN_",",.336))_", "_X_"  "_$G(X(2,DFN_",",.338)))
 D SET("       Phone: "_$G(X(2,DFN_",",.339)))
 D SET("  Work Phone: "_$G(X(2,DFN_",",.33011)))
 Q "~@^TMP(""NUPA"","_$J_")"
 ;
LN(N,T) ;Last note.  N=Note Title (or ANY), T=Time period
 ;IA 4477 - read C xref of file 8925
 N C,DIC,ED,NUPA,NUPAWP,X S (C,NUPA("C"),NUPA("I",1),NUPA("NOTEDATE"))=0
 D K,NONE("LAST NOTE ("_N_")"),AGO^NUPAOBJ1 G LNQ:'$G(DFN)
 S NUPA("TITLE")=N I N'="ANY" S DIC="^TIU(8925.1,",DIC(0)="M",X=N D ^DIC S NUPA("TITLE")=+Y
 I NUPA("TITLE")="" D SET(N_": INVALID NOTE TITLE") G LNQ
 F NUPA("I")=9E9:0 S NUPA("I")=$O(^TIU(8925,"C",DFN,NUPA("I")),-1) Q:'NUPA("I")!(NUPA("NOTEDATE"))  D
 .I NUPA("TITLE")'="ANY" Q:$$GET1^DIQ(8925,NUPA("I"),.01,"I")'=NUPA("TITLE")
 .S NUPA("NOTEDATE")=$$GET1^DIQ(8925,NUPA("I"),1201,"I") Q:+NUPA("NOTEDATE")<ED
 .S:N="ANY" N="NOTE ("_$$GET1^DIQ(8925,NUPA("I"),.01)_")" S NUPA("I",1)=NUPA("I")
 S:'NUPA("NOTEDATE") NUPA("NOTEDATE")="NONE" S:NUPA("NOTEDATE") NUPA("NOTEDATE")=$$D(NUPA("NOTEDATE"))
 D SET("LAST "_N_": "_NUPA("NOTEDATE")_"  (#"_NUPA("I",1)_")"),SET("")
 I '$D(NUPANOTX) D:'$G(NUPA("I",1)) SET("NO TEXT FOUND") I $G(NUPA("I",1)) D
 .S NUPAWP=$$GET1^DIQ(8925,NUPA("I",1),2,"","NUPAWP")
 .F NUPA("II")=0:0 S NUPA("II")=$O(NUPAWP(NUPA("II"))) Q:'NUPA("II")  D SET(NUPAWP(NUPA("II")))
LNQ K NUPANOTX Q "~@^TMP(""NUPA"","_$J_")"
 ;
K K ^TMP("NUPA",$J) Q
NONE(X) S ^TMP("NUPA",$J,1,0)=X_" - NONE FOUND" Q
SET(X) S:$G(C)&('$G(NUPA("C"))) NUPA("C")=C S NUPA("C")=$G(NUPA("C"))+1,^TMP("NUPA",$J,NUPA("C"),0)=X Q
D(Y) D DD^%DT Q Y
D1(Y) Q +$E(Y,4,5)_"/"_+$E(Y,6,7)_"/"_$E(Y,2,3)_" @ "_$E($P(Y,".",2)_"0000",1,4)

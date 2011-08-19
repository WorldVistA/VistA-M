ORDV01 ; slc/dcm - OE/RR Report Extracts ;10/8/03  11:18
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**109,160,180,208,215,274**;Dec 17, 1997;Build 20
HSQUERY(ROOT,ORDFN,ID,ORALPHA,OROMEGA,ORDTRNG,REMOTE,ORMAX,ORFHIE) ; -- Query to Health Summary Reports
 N OUT,ORDBEG,ORDEND,OREXT
 Q:'$L($G(ID))
 I '$L($P(ID,";",2)),$P(ID,";",3),$L($T(HSTYPE^ORWRP1))&($L($T(GCPR^OMGCOAS1))),$L($G(ORFHIE)) D  Q  ;Call if FHIE station 200
 . D GCPR^OMGCOAS1(DFN,ORFHIE,ORALPHA,OROMEGA,$G(ORMAX,100))
 . S ROOT=$NA(^TMP("ORDATA",$J))
 I '$L($P(ID,";",2)),$P(ID,";",3),$L($T(HSTYPE^ORWRP1)) D HSTYPE^ORWRP1(ROOT,ORDFN,$P(ID,";",3),.ORALPHA,.OROMEGA,.ORDTRNG,.REMOTE) Q
 Q:'$L($P(ID,";",2))
 S OUT=$P(ID,";")_"^"_$P(ID,";",2),OREXT=$S($L($P(ID,";",8)):$P(ID,";",7,9),1:"")
 Q:'$L($T(@OUT))
 S:'$G(ORALPHA) ORALPHA=$$FMADD^XLFDT(DT,-2000) S:'$G(OROMEGA) OROMEGA=$$FMADD^XLFDT(DT,1)
 I $E(OROMEGA,8)'="." S OROMEGA=OROMEGA_".235959"
 S OROMEGA=9999999-OROMEGA,ORALPHA=9999999-ORALPHA
 S ORDBEG=$S(ORALPHA=9999999:1,1:9999999-ORALPHA)
 S ORDEND=$S(OROMEGA=6666666:9999999,$P(OROMEGA,".",2)="01":$P(9999999-OROMEGA,".")_".235959",1:9999999-OROMEGA)
 S:'$G(ORMAX) ORMAX=100
 S OUT=OUT_"(.ROOT,ORALPHA,OROMEGA,ORMAX,ORDBEG,ORDEND,OREXT)"
 D @OUT
 Q
ADR(ROOT,ORALPHA,OROMEGA,ORMAX,ORDBEG,ORDEND,OREXT) ;adverse/reaction allergies
 ;External calls to ^GMRADPT, file 120.8
 ;Date ranges and Max Occurances are not supported by ^GMTADPT, but Max Occ is enforced in following FOR loop
 ;
 I $L($T(GCPR^OMGCOAS1)) D  Q  ; Call if FHIE station 200
 . ;D GCPR^OMGCOAS1(DFN,"ALRG",ORDBEG,ORDEND,ORMAX) ;Next 2 lines for HDRHX CHANGE
 . I $E($P(OREXT,";",3),1,8)="OR_HDRX_",$L($T(HX^OMGCOAS1)) D HX^OMGCOAS1(DFN,$P(OREXT,";",3),ORDBEG,ORDEND,ORMAX)
 . I $E($P(OREXT,";",3),1,8)'="OR_HDRX_"  D GCPR^OMGCOAS1(DFN,"ALRG",ORDBEG,ORDEND,ORMAX)
 . S ROOT=$NA(^TMP("ORDATA",$J))
 ;
 N I,ORI,D0,ARR,GMRA,GMRAL,ALLRG,ORSITE,SITE,GO,DIC,DIQ,DR,DA,C1,C2,LINE,LINE1,CDT,CTR,X
 Q:'$L(OREXT)
 S GO=$P(OREXT,";")_"^"_$P(OREXT,";",2)
 Q:'$L($T(@GO))
 S GMRA="0^0^111",ORSITE=$$SITE^VASITE,ORSITE=$P(ORSITE,"^",2)_";"_$P(ORSITE,"^",3)
 K ^TMP("ORDATA",$J)
 D @GO
 I GMRAL=""!(GMRAL=0) S ^TMP("ORDATA",$J,1,"WP",1)="1^"_ORSITE,^(2)="2^"_$S(GMRAL="":"Not Assessed",1:"NKA")
 S D0=0
 F ORI=1:1 S D0=$O(GMRAL(D0)) Q:'D0  D
 . S SITE=$S($L($G(GMRAL(D0,"facility"))):GMRAL(D0,"facility"),1:ORSITE)
 . K ARR,LINE,LINE1
 . S DIC=120.8,DA=D0,DR="3.1;.02;20;6",DIQ="ARR" D EN^DIQ1
 . S DIQ=$E(DIQ,1,$L(DIQ)-1)
 . S ^TMP("ORDATA",$J,ORI,"WP",1)="1^"_SITE ;Station ID
 . S ^TMP("ORDATA",$J,ORI,"WP",2)="2^"_@DIQ@(120.8,DA,.02) ;Allergy Reactant
 . S ^TMP("ORDATA",$J,ORI,"WP",3)="3^"_@DIQ@(120.8,DA,3.1) ;Allergy Type
 . S ^TMP("ORDATA",$J,ORI,"WP",4)="4^"_$$DATEMMM^ORDVU(@DIQ@(120.8,DA,20)) ;Verification Date/Time
 . S ^TMP("ORDATA",$J,ORI,"WP",5)="5^"_@DIQ@(120.8,DA,6) ;Observed/Historical
 . S ^TMP("ORDATA",$J,ORI,"WP",7)="7^"_DA ;Allergy IEN
 . S C1="",CTR=0
 . F I=1:1:10 K ARAY,ERR S CDT=$$GET1^DIQ(120.826,I_","_DA_",",".01","I") I $L(CDT) D
 .. S LINE(CDT)=$$GET1^DIQ(120.826,I_","_DA_",","1")_"^"_$$GET1^DIQ(120.826,I_","_DA_",","1.5")
 .. S X=$$GET1^DIQ(120.826,I_","_DA_",","2","","ARAY","ERR") I $L(X),'$D(ERR) D
 ... S C1="" F  S C1=$O(ARAY(C1)) Q:C1=""  S LINE(CDT,"C",C1)=ARAY(C1)
 . S C1="" F  S C1=$O(LINE(C1)) Q:C1=""  S X=LINE(C1) D
 .. S CTR=CTR+1,LINE1("C",CTR)=" "_$TR($$FMTE^XLFDT(C1,"5ZM"),"@"," ")_" by "_$P(X,"^")_" ("_$P(X,"^",2)_")",C2=""
 .. F  S C2=$O(LINE(C1,"C",C2)) Q:C2=""  S CTR=CTR+1,LINE1("C",CTR)="  "_LINE(C1,"C",C2)
 . D SPMRG^ORDVU("LINE1(""C"")","^TMP(""ORDATA"","_$J_","_ORI_",""WP"",6)",6) ;Comment
 S ROOT=$NA(^TMP("ORDATA",$J))
 Q
ADRZ(ROOT,ORALPHA,OROMEGA,ORMAX,ORDBEG,ORDEND,OREXT) ;adverse/reaction allergies (Old extract - not used)
 ;External calls to ^GMTADPT, file 120.8
 ;Date ranges and Max Occurances are not supported by ^GMTADPT, but Max Occ is enforced in following FOR loop
 N ORI,D0,ARR,GMRA,GMRAL,ALLRG,ORSITE,SITE,GO
 Q:'$L(OREXT)
 S GO=$P(OREXT,";")_"^"_$P(OREXT,";",2)
 Q:'$L($T(@GO))
 S GMRA="0^0^111",ORSITE=$$SITE^VASITE,ORSITE=$P(ORSITE,"^",2)_";"_$P(ORSITE,"^",3)
 K ^TMP("ORHSADR",$J)
 D @GO
 I GMRAL="" Q
 S D0=0
 F ORI=1:1 S D0=$O(GMRAL(D0)) Q:'D0  D
 . S SITE=$S($L($G(GMRAL(D0,"facility"))):GMRAL(D0,"facility"),1:ORSITE)
 . K ARR
 . S DIC=120.8,DA=D0,DR="3.1;.02;20;6",DIQ="ARR" D EN^DIQ1
 . S DIQ=$E(DIQ,1,$L(DIQ)-1)
 . S ^TMP("ORHSADR",$J,ORI)=SITE_U_U_@DIQ@(120.8,DA,3.1)_U_@DIQ@(120.8,DA,.02)_U_$$DATEMMM^ORDVU(@DIQ@(120.8,DA,20))_U_@DIQ@(120.8,DA,6)
 S ROOT=$NA(^TMP("ORHSADR",$J))
 Q

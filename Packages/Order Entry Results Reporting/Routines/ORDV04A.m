ORDV04A ; SLC/DAN/dcm - OE/RR ;7/30/01  14:33
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**109,243**;Dec 17,1997;Build 242
 ;
 Q
ENSR ; Entry point for component
 ;External calls to ^GMTSROB, ^DIQ, ^GMTSORC, ^DIWP
 ;External references to ^SRF, ^DD, ^ICPT
 N GMIDT,GMN,SURG
 I '$D(^SRF("B",DFN)) Q
 S GMN=0 F  S GMN=$O(^SRF("B",DFN,GMN)) Q:GMN'>0  D SORT
 I '$D(SURG) Q
 S GMIDT=0 F  S GMIDT=$O(SURG(GMIDT)) Q:GMIDT'>0!(ORCNT'<ORMAX)  S GMN=SURG(GMIDT) D EXTRCT
 Q
 ;
SORT ; Sort surgeries by inverted date
 N GMDT
 S GMDT=$P(^SRF(GMN,0),U,9) I GMDT>ORDBEG&(GMDT<ORDEND) D
 . F  Q:'$D(SURG(9999999-GMDT))  S GMDT=GMDT+.0001
 . S SURG(9999999-GMDT)=GMN
 Q
EXTRCT ; Extract surgical case record
 N X,GMI,GMDT,OPPRC,POSDX,PREDX,SPEC,STATUS,SURGEON,VER
 N DCTDTM,TRSDTM,Y,C,DIWL,DIWF,ORSITE,ORMORE,SITE
 S ORCNT=ORCNT+1,ORMORE=0
 S GMDT=$$DATE^ORDVU($P(^SRF(GMN,0),U,9))
 D STATUS^GMTSROB S:'$D(STATUS) STATUS="UNKNOWN"
 S X=$P(^SRF(GMN,0),U,4) I X>0 S Y=X,C=$P(^DD(130,.04,0),U,2) D Y^DIQ S SPEC=Y K Y
 I $D(^SRF(GMN,.1)) S X=$P(^SRF(GMN,.1),U,4) I X>0 S Y=X,C=$P(^DD(130,.14,0),U,2) D Y^DIQ S SURGEON=Y K Y
 S VER=$S($G(^SRF(GMN,"VER"))'="Y":"(Unverified)",1:"")
 S PREDX(0)=$S($G(^SRF(GMN,33))]"":$P(^(33),U),1:"") S GMI=0 F  S GMI=$O(^SRF(GMN,14,GMI)) Q:GMI'>0  S PREDX(GMI)=$P(^SRF(GMN,14,GMI,0),U)
 S POSDX(0)=$S($G(^SRF(GMN,34))]"":$P(^(34),U),1:"") S GMI=0 F  S GMI=$O(^SRF(GMN,15,GMI)) Q:GMI'>0  S POSDX(GMI)=$P(^SRF(GMN,15,GMI,0),U)
 S OPPRC(0)=$P($G(^SRF(GMN,"OP")),U,1,2) S:$P(OPPRC(0),U,2)]"" $P(OPPRC(0),U,2)=$P($$CPT^ICPTCOD($P($G(^SRF(GMN,"OP")),U,2)),U,3) D
 . S GMI=0 F  S GMI=$O(^SRF(GMN,13,GMI)) Q:GMI'>0  S OPPRC(GMI)=$P($G(^SRF(GMN,13,GMI,0)),U)_U_$G(^SRF(GMN,13,GMI,2)) S:$P(OPPRC(GMI),U,2)]"" $P(OPPRC(GMI),U,2)=$P($$CPT^ICPTCOD($P($G(^SRF(GMN,13,GMI,2)),U)),U,3)
 S X=$P($G(^SRF(GMN,31)),U,6) S:X>0 DCTDTM=$$DATE^ORDVU(X)
 S X=$P($G(^SRF(GMN,31)),U,7) S:X>0 TRSDTM=$$DATE^ORDVU(X)
 S DIWL=0,DIWF="N",ORSITE=$$SITE^VASITE,ORSITE=$P(ORSITE,"^",2)_";"_$P(ORSITE,"^",3)
 K ^UTILITY($J,"W")
 I $D(^SRF(GMN,12)) F GMI=1:1:$P(^SRF(GMN,12,0),U,4) S X=^SRF(GMN,12,GMI,0) D ^DIWP
 S SITE=ORSITE
 S ^TMP("ORDATA",$J,GMIDT,"WP",1)="1^"_SITE ;Station ID
 S ^TMP("ORDATA",$J,GMIDT,"WP",2)="2^"_GMDT ; date
 ;
 ; Operative Procedure(s)
 S GMI="" F  S GMI=$O(OPPRC(GMI)) Q:GMI=""  D  S:GMI ORMORE=1
 . S ^TMP("ORDATA",$J,GMIDT,"WP",3,GMI)="3^"_$P(OPPRC(GMI),U)_$S($P(OPPRC(GMI),U,2)]"":" - "_$P(OPPRC(GMI),U,2),1:"")
 ;
 S ^TMP("ORDATA",$J,GMIDT,"WP",4)="4^"_$G(SPEC) ;surgical specialty
 ;
 S ^TMP("ORDATA",$J,GMIDT,"WP",5)="5^"_$G(SURGEON) ; surgeon
 S ^TMP("ORDATA",$J,GMIDT,"WP",6)="6^"_$G(STATUS) ; op status
 ;
 ; Pre-operative diagnosis
 S GMI="" F  S GMI=$O(PREDX(GMI)) Q:GMI=""  D  S:GMI ORMORE=1
 . S ^TMP("ORDATA",$J,GMIDT,"WP",7,GMI)="7^"_PREDX(GMI)
 ;
 ; Post-operative diagnosis
 S GMI="" F  S GMI=$O(POSDX(GMI)) Q:GMI=""  D  S:GMI ORMORE=1
 . S ^TMP("ORDATA",$J,GMIDT,"WP",8,GMI)="8^"_POSDX(GMI)
 ;
 ; Lab work? Y/N
 S ^TMP("ORDATA",$J,GMIDT,"WP",9)="9^"_$S($O(^SRF(GMN,9,0)):"Yes",1:"No")
 S ^TMP("ORDATA",$J,GMIDT,"WP",10)="10^"_$G(DCTDTM) ; dictation time
 S ^TMP("ORDATA",$J,GMIDT,"WP",11)="11^"_$G(TRSDTM) ; transcription time
 ;
 ; surgeon's dictation
 I $D(^UTILITY($J,"W")) D  S ORMORE=1
 . K ^TMP("ORHSSRT",$J)
 . F GMI=1:1:^UTILITY($J,"W",DIWL) D
 .. S ^TMP("ORHSSRT",$J,GMIDT,"WP",GMI)=^UTILITY($J,"W",DIWL,GMI,0)
 . D SPMRG^ORDVU($NA(^TMP("ORHSSRT",$J,GMIDT,"WP")),$NA(^TMP("ORDATA",$J,GMIDT,"WP",12)),12)
 . K ^UTILITY($J,"W")
 . K ^TMP("ORHSSRT",$J)
 I ORMORE S ^TMP("ORDATA",$J,GMIDT,"WP",13)="13^[+]" ;flag for detail
 Q
VS ;Continuation of Vitals Extract (from ORDV04)
 ;Calls GMRVUT0
 I $L($T(GCPR^OMGCOAS1)) D  Q  ; OMGCOAS1 routine only on Station 200
 . D GCPR^OMGCOAS1(DFN,"VIT",ORDBEG,ORDEND,ORMAX)
 . S ROOT=$NA(^TMP("ORDATA",$J))
 N ORDT,I,TYPE,IEN,GMRVSTR,ORSITE,SITE,PLACE,GO,X,QUALIF,NODE,UNITS,UCNT,QCNT,ORI
 Q:'$L(OREXT)
 S GO=$P(OREXT,";")_"^"_$P(OREXT,";",2)
 Q:'$L($T(@GO))
 K ^UTILITY($J,"GMRVD"),^TMP("ORDATA",$J)
 S GMRVSTR="T;P;R;BP;HT;WT;PN;PO2;CVP;CG",GMRVSTR(0)=ORDBEG_"^"_ORDEND_"^"_ORMAX_"^"_1
 S ORSITE=$$SITE^VASITE,ORSITE=$P(ORSITE,"^",2)_";"_$P(ORSITE,"^",3)
 D @GO
 S ORDT=0
 F I=1:1 S ORDT=$O(^UTILITY($J,"GMRVD",ORDT)) Q:'+ORDT!(I>ORMAX)  D  ;DBIA 4791
 . S SITE=$S($L($G(^TMP("GMRVD",$J,ORDT,"facility"))):^("facility"),1:ORSITE)
 . S ^TMP("ORDATA",$J,"WP",ORDT,1)="1^"_SITE
 . S ^TMP("ORDATA",$J,"WP",ORDT,2)="2^"_$$DATE^ORDVU(9999999-ORDT) ;date vitals taken
 . K UNITS,QUALIF
 . S TYPE="",(UCNT,QCNT)=1,UNITS(UCNT)="",QUALIF(QCNT)="",QUALIF=""
 . F  S TYPE=$O(^UTILITY($J,"GMRVD",ORDT,TYPE)) Q:TYPE=""  D
 .. S IEN=$O(^UTILITY($J,"GMRVD",ORDT,TYPE,0)) Q:'IEN  S NODE=$G(^(IEN))
 .. S PLACE=$S(TYPE="T":3,TYPE="P":4,TYPE="R":5,TYPE="BP":6,TYPE="HT":7,TYPE="WT":8,TYPE="PN":9,TYPE="PO2":10,TYPE="CVP":11,TYPE="CG":12,1:0)
 .. I PLACE S ^TMP("ORDATA",$J,"WP",ORDT,PLACE)=PLACE_"^"_$P(NODE,"^",8) ;Get value of vitals from global
 .. S X=$$UNITMAP(TYPE) S:$L(UNITS(UCNT))>60 UCNT=UCNT+1,UNITS(UCNT)="" S UNITS(UCNT)=$S($L(UNITS(UCNT)):UNITS(UCNT)_","_$$MAP(TYPE)_":",1:$$MAP(TYPE)_":")_X ;Units
 .. I TYPE="PO2" D
 ... I $L($P(NODE,"^",15)) S ^TMP("ORDATA",$J,"WP",ORDT,13)=13_"^"_$P($G(^UTILITY($J,"GMRVD",ORDT,TYPE,IEN)),"^",15) ; Flow Rate
 ... I $L($P(NODE,"^",16)) S ^TMP("ORDATA",$J,"WP",ORDT,14)=14_"^"_$P($G(^UTILITY($J,"GMRVD",ORDT,TYPE,IEN)),"^",16) ; O2 Concentration
 .. I $L($P(NODE,"^",17)) S X=$P(NODE,"^",17)  D
 ... I QUALIF'[($$MAP(TYPE)_":"_X) D
 .... S QUALIF=$S($L(QUALIF):QUALIF_" , "_$$MAP(TYPE)_":",1:$$MAP(TYPE)_":")_X ; Qualifier
 .... S:$L(QUALIF(QCNT))>60 QCNT=QCNT+1,QUALIF(QCNT)=""
 .... S QUALIF(QCNT)=$S($L(QUALIF(QCNT)):QUALIF(QCNT)_" , "_$$MAP(TYPE)_":",1:$$MAP(TYPE)_":")_X ; Qualifier
 .. I TYPE="WT",$L($P(NODE,"^",14)) D
 ... S ^TMP("ORDATA",$J,"WP",ORDT,16)=16_"^"_$P(NODE,"^",14) ; BMI
 . I $O(QUALIF(0)) D
 .. S ORI=0 F  S ORI=$O(QUALIF(ORI)) Q:'ORI  D
 ... S ^TMP("ORDATA",$J,"WP",ORDT,15,ORI)="15^"_QUALIF(ORI)
 . I $O(UNITS(0)) D
 .. S ORI=0 F  S ORI=$O(UNITS(ORI)) Q:'ORI  D
 ... S ^TMP("ORDATA",$J,"WP",ORDT,17,ORI)="17^"_UNITS(ORI)
 K ^UTILITY($J,"GMRVD")
 S ROOT=$NA(^TMP("ORDATA",$J))
 Q
MAP(TEXT) ;Map test code to abbreviation
 Q:'$L($G(TEXT)) ""
 I TEXT="T" Q "TEMP"
 I TEXT="P" Q "PULSE"
 I TEXT="R" Q "RESP"
 I TEXT="BP" Q "BP"
 I TEXT="HT" Q "HT"
 I TEXT="WT" Q "WT"
 I TEXT="PN" Q "PAIN"
 I TEXT="PO2" Q "POx"
 I TEXT="CVP" Q "CVP"
 I TEXT="CG" Q "C/G"
 Q TEXT
UNITMAP(TEXT) ;Map units to abbreviation
 Q:'$L($G(TEXT)) ""
 I TEXT="T" Q "F"
 I TEXT="P" Q "/min"
 I TEXT="R" Q " /min"
 I TEXT="BP" Q "mmHg"
 I TEXT="HT" Q "in"
 I TEXT="WT" Q "lb"
 I TEXT="PN" Q ""
 I TEXT="PO2" Q "%SpO2"
 I TEXT="CVP" Q "cmH2O"
 I TEXT="CG" Q " in"
 Q ""

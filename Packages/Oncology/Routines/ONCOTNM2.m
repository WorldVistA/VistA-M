ONCOTNM2 ;Hines OIFO/RTK - TNM Codes input transform & help ;9/29/16  15:38
 ;;2.2;ONCOLOGY;**6**;Jul 31, 2013;Build 10
 ;
 ;New input transform and help -- NAACCR Vol II V16
 ; This will replace all the codes specific to Topography & Histology
 ;
 ; make sure case is correct
INPUT ;
 S DATEDX=$P($G(^ONCO(165.5,D0,0)),"^",16)
 S X=$TR(X,"abcdilmopsuvx","ABCDILMOPSUVX")
 I $E(X)="C" S X="c"_$E(X,2,8) W "   ",X
 I $E(X)="P" S X="p"_$E(X,2,8) W "   ",X
 I ONCOX="T",STGIND="C" D TCLIN Q
 I ONCOX="N",STGIND="C" D NCLIN Q
 I ONCOX="M",STGIND="C" D MCLIN Q
 I ONCOX="T",STGIND="P" D TPATH Q
 I ONCOX="N",STGIND="P" D NPATH Q
 I ONCOX="M",STGIND="P" D MPATH Q
 Q
 ;
TCLIN ;
 I X="cX"!(X="c0")!(X="pA")!(X="pIS")!(X="pISU")!(X="pISD") Q
 I X="c1MI"!(X="c1")!(X="c1A")!(X="c1A1")!(X="c1A2")!(X="c1B") Q
 I X="c1B1"!(X="c1B2")!(X="c1C")!(X="c1D")!(X="c2")!(X="c2A") Q
 I X="c2A1"!(X="c2A2")!(X="c2B")!(X="c2C")!(X="c2D")!(X="c3") Q
 I X="c3A"!(X="c3B")!(X="c3C")!(X="c3D")!(X="c4")!(X="c4A") Q
 I X="c4B"!(X="c4C")!(X="c4D")!(X="c4E")!(X=88) Q
 K X Q
 ;
NCLIN ;
 I X="cX"!(X="c0")!(X="c0A")!(X="c0B")!(X="c1")!(X="c1A") Q
 I X="c1B"!(X="c1C")!(X="c2")!(X="c2A")!(X="c2B")!(X="c2C") Q
 I X="c3"!(X="c3A")!(X="c3B")!(X="c3C")!(X="c4")!(X=88) Q
 K X Q
 ;
MCLIN ;
 I X="c0"!(X="c0I+")!(X="c1")!(X="c1A")!(X="c1B") Q
 I X="c1C"!(X="c1D")!(X="c1E")!(X="p1")!(X="p1A") Q
 I X="p1B"!(X="p1C")!(X="p1D")!(X="p1E")!(X=88) Q
 I DATEDX<3100101,X="cX" Q
 K X Q
 ;
TPATH ;
 I X="pX"!(X="p0")!(X="pA")!(X="pIS")!(X="pISU")!(X="pISD") Q
 I X="p1MI"!(X="p1")!(X="p1A")!(X="p1A1")!(X="p1A2")!(X="p1B") Q
 I X="p1B1"!(X="p1B2")!(X="p1C")!(X="p1D")!(X="p2")!(X="p2A") Q
 I X="p2A1"!(X="p2A2")!(X="p2B")!(X="p2C")!(X="p2D")!(X="p3") Q
 I X="p3A"!(X="p3B")!(X="p3C")!(X="p3D")!(X="p4")!(X="p4A") Q
 I X="p4B"!(X="p4C")!(X="p4D")!(X="p4E")!(X=88) Q
 K X Q
 ;
NPATH ;
 I X="pX"!(X="c0")!(X="p0")!(X="p0I-")!(X="p0I+")!(X="p0M-") Q
 I X="p0M+"!(X="p1MI")!(X="p0A")!(X="p0B")!(X="p1")!(X="p1A") Q
 I X="p1B"!(X="p1C")!(X="p2")!(X="p2A")!(X="p2B") Q
 I X="p2C"!(X="p3")!(X="p3A")!(X="p3B")!(X="p3C")!(X="p4")!(X=88) Q
 I DATEDX<3020101,(X="p1BI")!(X="p1BII")!(X="p1BIII")!(X="p1BIV") Q
 K X Q
 ;
MPATH ;
 I X="c0"!(X="c0I+")!(X="p1")!(X="p1A")!(X="p1B") Q
 I X="p1C"!(X="p1D")!(X="p1E")!(X="c1")!(X="c1A") Q
 I X="c1B"!(X="c1C")!(X="c1D")!(X="c1E")!(X=88) Q
 I DATEDX<3100101,X="pX" Q
 K X Q
 ;
HELP ;
 S DATEDX=$P($G(^ONCO(165.5,D0,0)),"^",16)
 I ONCOX="T",STGIND="C" D TCLINHP Q
 I ONCOX="N",STGIND="C" D NCLINHP Q
 I ONCOX="M",STGIND="C" D MCLINHP Q
 I ONCOX="T",STGIND="P" D TPATHHP Q
 I ONCOX="N",STGIND="P" D NPATHHP Q
 I ONCOX="M",STGIND="P" D MPATHHP Q
 Q
TCLINHP ;
 W !?5,"PLEASE SELECT FROM THE FOLLOWING CODES FOR CLINICAL T"
 W !?8,"cX",?16,"c0",?24,"pA",?32,"pIS",?40,"pISU",?48,"pISD",?56,"c1MI"
 W !?8,"c1",?16,"c1A",?24,"c1A1",?32,"c1A2",?40,"c1B",?48,"c1B1",?56,"c1B2"
 W !?8,"c1C",?16,"c1D",?24,"c2",?32,"c2A",?40,"c2A1",?48,"c2A2",?56,"c2B"
 W !?8,"c2C",?16,"c2D",?24,"c3",?32,"c3A",?40,"c3B",?48,"c3C",?56,"c3D"
 W !?8,"c4",?16,"c4A",?24,"c4B",?32,"c4C",?40,"c4D",?48,"c4E",?56,88,!
 Q
NCLINHP ;
 W !?5,"PLEASE SELECT FROM THE FOLLOWING CODES FOR CLINICAL N"
 W !?8,"cX",?16,"c0",?24,"c0A",?32,"c0B",?40,"c1",?48,"c1A"
 W !?8,"c1B",?16,"c1C",?24,"c2",?32,"c2A",?40,"c2B",?48,"c2C"
 W !?8,"c3",?16,"c3A",?24,"c3B",?32,"c3C",?40,"c4",?48,88,!
 Q
MCLINHP ;
 W !?5,"PLEASE SELECT FROM THE FOLLOWING CODES FOR CLINICAL M"
 W !?8,"c0",?16,"c0I+",?24,"c1",?32,"c1A",?40,"c1B"
 W !?8,"c1C",?16,"c1D",?24,"c1E",?32,"p1",?40,"p1A"
 W !?8,"p1B",?16,"p1C",?24,"p1D",?32,"p1E",?40,88
 I DATEDX<3100101 W ?48,"cX"
 W ! Q
TPATHHP ;
 W !?5,"PLEASE SELECT FROM THE FOLLOWING CODES FOR PATHOLOGIC T"
 W !?8,"pX",?16,"p0",?24,"pA",?32,"pIS",?40,"pISU",?48,"pISD"
 W !?8,"p1MI",?16,"p1",?24,"p1A",?32,"p1A1",?40,"p1A2",?48,"p1B"
 W !?8,"p1B1",?16,"p1B2",?24,"p1C",?32,"p1D",?40,"p2",?48,"p2A"
 W !?8,"p2A1",?16,"p2A2",?24,"p2B",?32,"p2C",?40,"p2D",?48,"p3"
 W !?8,"p3A",?16,"p3B",?24,"p3C",?32,"p3D",?40,"p4",?48,"p4A"
 W !?8,"p4B",?16,"p4C",?24,"p4D",?32,"p4E",?40,88,!
 Q
NPATHHP ;
 W !?5,"PLEASE SELECT FROM THE FOLLOWING CODES FOR PATHOLOGIC N"
 W !?8,"pX",?16,"c0",?24,"p0",?32,"p0I-",?40,"p0I+"
 W !?8,"p0M-",?16,"p0M+",?24,"p1MI",?32,"p0A",?40,"p0B"
 W !?8,"p1",?16,"p1A",?24,"p1B",?32,"p1C",?40,"p2"
 W !?8,"p2A",?16,"p2B",?24,"p2C",?32,"p3",?40,"p3A"
 W !?8,"p3B",?16,"p3C",?24,"p4",?32,88
 I DATEDX<3020101 W !?8,"p1BI",?16,"p1BII",?24,"p1BIII",?32,"p1BIV"
 W ! Q
MPATHHP ;
 W !?8,"c0",?16,"c0I+",?24,"p1",?32,"p1A",?40,"p1B"
 W !?8,"p1C",?16,"p1D",?24,"p1E",?32,"c1",?40,"c1A"
 W !?8,"c1B",?16,"c1C",?24,"c1D",?32,"c1E",?40,88
 I DATEDX<3100101 W ?48,"pX"
 W ! Q
 ;
VALID ;check the validity of the Clinical and Pathologic TNM data values
 ; after the Patch 6 converion for NAACCR Vol II v16
 N X,EX K ^TMP($J,"ONCINV") S NN=0,EX=""
 ;loop through and check if any of the 6 TNM fields have bad data
 F IEN=0:0 S IEN=$O(^ONCO(165.5,IEN)) Q:IEN'>0  D
 .S DATEDX=$P($G(^ONCO(165.5,IEN,0)),"^",16)
 .S CLINT=$P($G(^ONCO(165.5,IEN,2)),U,25) S X=CLINT I X=""!(X=88) Q
 .D TCLIN I '$D(X) D GETPTV S ^TMP($J,"ONCINV",ZZPTNM,IEN,"CLINICAL T")=ZZACSQ_U_CLINT
 .S CLINN=$P($G(^ONCO(165.5,IEN,2)),U,26) S X=CLINN I X=""!(X=88) Q
 .D NCLIN I '$D(X) D GETPTV S ^TMP($J,"ONCINV",ZZPTNM,IEN,"CLINICAL N")=ZZACSQ_U_CLINN
 .S CLINM=$P($G(^ONCO(165.5,IEN,2)),U,27) S X=CLINM I X=""!(X=88) Q
 .D MCLIN I '$D(X) D GETPTV S ^TMP($J,"ONCINV",ZZPTNM,IEN,"CLINICAL M")=ZZACSQ_U_CLINM
 .S PATHT=$P($G(^ONCO(165.5,IEN,2.1)),U,1) S X=PATHT I X=""!(X=88) Q
 .D TPATH I '$D(X) D GETPTV S ^TMP($J,"ONCINV",ZZPTNM,IEN,"PATHOLOGIC T")=ZZACSQ_U_PATHT
 .S PATHN=$P($G(^ONCO(165.5,IEN,2.1)),U,2) S X=PATHN I X=""!(X=88) Q
 .D NPATH I '$D(X) D GETPTV S ^TMP($J,"ONCINV",ZZPTNM,IEN,"PATHOLOGIC N")=ZZACSQ_U_PATHN
 .S PATHM=$P($G(^ONCO(165.5,IEN,2.1)),U,3) S X=PATHM I X=""!(X=88) Q
 .D MPATH I '$D(X) D GETPTV S ^TMP($J,"ONCINV",ZZPTNM,IEN,"PATHOLOGIC M")=ZZACSQ_U_PATHM
 W !
 ;display the invalid data, if any
 I '$D(^TMP($J,"ONCINV")) W !?3,"All Clinical and Pathologic TNM data is valid!",! K CLINT,CLINN,CLINM,PATHT,PATHN,PATHM,IEN,NN,TNMFLD,ZZ160,ZZVRPT,ZZPTNM,ZZACSQ,^TMP($J,"ONCINV") Q
 W @IOF,!!!,"Display list of patients with invalid data in"
 W !,"the Clinical or Pathologic TNM fields",!
 S ZZPTNM="" F  S ZZPTNM=$O(^TMP($J,"ONCINV",ZZPTNM)) Q:ZZPTNM=""!(EX=U)  D
 .F IEN=0:0 S IEN=$O(^TMP($J,"ONCINV",ZZPTNM,IEN)) Q:IEN'>0!(EX=U)  D
 ..S NN=NN+1 W !!,"Patient Name: ",ZZPTNM
 ..S TNMFLD="" F  S TNMFLD=$O(^TMP($J,"ONCINV",ZZPTNM,IEN,TNMFLD)) Q:TNMFLD=""!(EX=U)  D
 ...W !,"  Acc/Seq #: ",$P(^TMP($J,"ONCINV",ZZPTNM,IEN,TNMFLD),"^",1),"  ",TNMFLD," invalid value = ",$P(^TMP($J,"ONCINV",ZZPTNM,IEN,TNMFLD),"^",2)
 ...I $Y>(IOSL-4) D PG I EX=U Q
 ..Q
 .Q
 I EX'=U W !!?9,NN," total patient records with invalid TNM data...",! D PG I EX=U Q
 K CLINT,CLINN,CLINM,PATHT,PATHN,PATHM,IEN,NN,TNMFLD,ZZ160,ZZVRPT,ZZPTNM,ZZACSQ    ;,^TMP($J,"ONCINV") Q
 Q
 ;
GETPTV ;
 S ZZ160=$P($G(^ONCO(165.5,IEN,0)),"^",2)
 S ZZVRPT=$P($G(^ONCO(160,ZZ160,0)),"^",1)
 I ZZVRPT[";DPT" S ZZPTNM=$P($G(^DPT($P(ZZVRPT,";",1),0)),"^",1)
 I ZZVRPT[";LRT" S ZZPTNM=$P($G(^LRT(67,$P(ZZVRPT,";",1),0)),"^",1)
 S ZZACSQ=$E($P($G(^ONCO(165.5,IEN,0)),"^",5),1,4)_"-"_$E($P($G(^ONCO(165.5,IEN,0)),"^",5),5,9)_"/"_$P($G(^ONCO(165.5,IEN,0)),"^",6)
 Q
 ;
PG ;
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR I 'Y S EX=U Q
 W @IOF Q

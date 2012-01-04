ECXSCX1 ;ALB/JAP,BIR/DMA-Clinic Extract Message ;9/29/10  17:26
 ;;3.0;DSS EXTRACTS;**8,28,24,27,29,30,31,33,84,92,105,127,132**;Dec 22, 1997;Build 18
EN ;entry point from ecxscx
 N ECX
 ;send missing clinic message
 S ECX=$O(^TMP($J,"ECXS","MISS",0)) D
 .Q:ECX=""
 .S XMSUB="MISSING CLINICS in File #728.44",XMDUZ="DSS SYSTEM"
 .K XMY S XMY("G.DSS-"_ECGRP_"@"_^XMB("NETNAME"))=""
 .F ECX=1:1:5 S ^TMP($J,"ECXS","MISS",ECX,0)=$P($T(MSG+ECX),";;",2)
 .S XMTEXT="^TMP($J,""ECXS"",""MISS""," D ^XMD
 ;send no division message
 S ECX=$O(^TMP($J,"ECXS","DIV",0)) D
 .Q:ECX=""
 .S XMSUB="CLINICS w/o DIVISION Data",XMDUZ="DSS SYSTEM"
 .K XMY S XMY("G.DSS-"_ECGRP_"@"_^XMB("NETNAME"))=""
 .F ECX=1:1:5 S ^TMP($J,"ECXS","DIV",ECX,0)=$P($T(MSG2+ECX),";;",2)
 .S XMTEXT="^TMP($J,""ECXS"",""DIV""," D ^XMD
 ;cleanup
 K ^TMP($J,"ECXS")
 Q
MSG ;text for missing clinic
 ;;The following clinics have not been entered into the CLINIC AND
 ;;STOP CODES file (#728.44).  If any listed clinic is currently
 ;;active, please use the options 'Create DSS Clinic Stop Code File'
 ;;and 'Enter/Edit DSS Stop Codes for Clinics' to update this file.
 ;;  
 ;
MSG2 ;text for missing division
 ;;The following clinics in the HOSPITAL LOCATION file (#44) have not
 ;;been assigned to a division from the MEDICAL CENTER DIVISION file 
 ;;(#40.8).  CLI extract records associated with these clinics have
 ;;been given a default Division identifier of "1".
 ;;
 ;
MISS ;load ^tmp if clinic missing from #728.44
 N DAT,ID,RD
 S (ID,RD)=""
 S DAT=$G(^SC(SC,"I")) I DAT]"" S ID=+DAT,RD=$P(DAT,U,2)
 ;ignore inactive clinics
 I ID,ID<DT I 'RD!(RD>DT) Q
 I '$D(^TMP($J,"ECXS","ECXMISS")) S ^TMP($J,"ECXS","ECXMISS")=10
 S ECXMISS=^TMP($J,"ECXS","ECXMISS")
 S ^TMP($J,"ECXS","MISS",ECXMISS,0)=$J(SC,6)_"    "_$$LJ^XLFSTR($P(^SC(SC,0),U),40)_ECSC_"/"_ECCSC
 S ^TMP($J,"ECXS","ECXMISS")=ECXMISS+1
 Q
 ;
NODIV ;load ^tmp if clinic w/o division
 N DAT,ID,RD
 S (ID,RD)=""
 S DAT=$G(^SC(SC,"I")) I DAT]"" S ID=+DAT,RD=$P(DAT,U,2)
 ;ignore inactive clinics
 I ID,ID<DT I 'RD!(RD>DT) Q
 I '$D(^TMP($J,"ECXS","ECXMISS")) S ^TMP($J,"ECXS","ECXMISS")=10
 S ECXMISS=^TMP($J,"ECXS","ECXMISS")
 S ^TMP($J,"ECXS","DIV",ECXMISS,0)=$J(SC,6)_"    "_$$LJ^XLFSTR($P(^SC(SC,0),U),40)
 S ^TMP($J,"ECXS","ECXMISS")=ECXMISS+1
 Q
 ;
FEEDER(ECXSC,ECXSD,ECXP1,ECXP2,ECXP3,ECXSEND,ECXDIV) ;get transmission style and feeder key variables
 ;feeder key = primary stop code_secondary stop code_length of appointment_national clinic code_noshow indicator
 ;   input
 ;   ECXSC = ien of clinic in file #44 (required)
 ;   ECXSD  = start date of extract date range (required)
 ;   ECXP1,ECXP2,ECXP3,ECXSEND passed by reference (required)
 ;   output (passed-by-reference variables)
 ;   ECXP1  = primary stop code
 ;   ECXP2  = secondary stop code
 ;   ECXP3  = field #7 of file #728.44
 ;   ECXSEND = field #5 of file #728.44
 ;   ECXDIV  = field #3.5 of file #44
 N ECSC,ECCSC,ECSD1,ECXNC,ECXMISS,CLIN,SC
 S (ECXP1,ECXP2)="000",ECXP3="0000"
 S ECXSEND=1,ECXDIV=0
 Q:+ECXSC=0
 ;get needed data from ^tmp
 I $D(^TMP($J,"ECXS","SC",ECXSC)) D
 .S CLIN=^TMP($J,"ECXS","SC",ECXSC)
 .S ECXP1=$P(CLIN,U),ECXP2=$P(CLIN,U,2),ECXP3=$P(CLIN,U,3),ECXSEND=$P(CLIN,U,4),ECXDIV=$P(CLIN,U,5)
 .S ECXDIV=+$P($G(^TMP($J,"ECXCL",ECXSC)),U,4) S:ECXDIV=0 ECXDIV=1
 ;otherwise, set needed data in ^tmp
 I '$D(^TMP($J,"ECXS","SC",ECXSC)) D
 .;get division or send no division msg
 .S ECXDIV=+$P($G(^TMP($J,"ECXCL",ECXSC)),U,4)
 .I ECXDIV=0 S SC=ECXSC D NODIV S ECXDIV=1
 .;get other data from file #44 if no #727.44 record; send missing clinic msg
 .I '$D(^ECX(728.44,ECXSC,0)) D
 ..S ECSC=+$P($G(^SC(ECXSC,0)),U,7),ECCSC=+$P(^(0),U,18)
 ..S SC=ECXSC,ECSD1=ECXSD D MISS
 ..S:ECSC ECXP1=$P($G(^DIC(40.7,ECSC,0)),U,2),ECXP1=$$RJ^XLFSTR(+ECXP1,3,0)
 .;otherwise get other data from file #728.44
 .S EC=$G(^ECX(728.44,ECXSC,0)) D
 ..Q:EC=""
 ..S ECXSEND=$P(EC,U,6)
 ..Q:ECXSEND=6
 ..S ECSC=+$P(EC,U,4),ECCSC=+$P(EC,U,5)
 ..I 'ECSC S ECSC=+$P(EC,U,2),ECCSC=+$P(EC,U,3)
 ..I ECSC S ECXP1=$$RJ^XLFSTR(ECSC,3,0),ECXP2=$$RJ^XLFSTR(ECCSC,3,0)
 ..;if primary stop not valid, use file #44 record
 ..I 'ECSC S ECSC=+$P($G(^SC(ECXSC,0)),U,7),ECCSC=+$P($G(^(0)),U,18) I ECSC D
 ...S ECXP1=+$P($G(^DIC(40.7,ECSC,0)),U,2)
 ...S:ECCSC ECXP2=+$P($G(^DIC(40.7,ECCSC,0)),U,2)
 ...S ECXP1=$$RJ^XLFSTR(ECXP1,3,0),ECXP2=$$RJ^XLFSTR(ECXP2,3,0)
 .;for action code=1, secondary stop code is always "000"
 .I ECXSEND=1 S ECXP2="000"
 .;action code of 2 or 3 should not be used, but continue to follow v2t11 logic
 .I ECXSEND=2 S ECXP1=ECXP2,ECXP2="000"
 .;for action code=4, need to get national clinic code
 .I ECXSEND=4 D
 ..S ECXNC=+$P($G(^ECX(728.44,ECXSC,0)),U,8)
 ..I ECXNC S ECXNC=$P($G(^ECX(728.441,ECXNC,0)),U),ECXP3=$$RJ^XLFSTR(ECXNC,4,0)
 .;set data in ^tmp
 .S ^TMP($J,"ECXS","SC",ECXSC)=ECXP1_U_ECXP2_U_ECXP3_U_ECXSEND
 Q
 ;
VISIT(ECXDFN,ECXVISIT,ECXVIST,ECXERR) ;get visit specific data
 ;input  ECXVISIT  = pointer to file #9000010
 ;       ECXSVC  = sc percentage
 ;output ECXVSIT = data array
 ;       ECXERR  = 1 indicates error; otherwise, 0
 N AO,ARRAY,CM,CNT,CPT,DA,DATE,DA,DIQ,ICD,ICD9,IR,LEN,M,MOD,MST,NUM,NOD1,NODE
 N PROV,PROVPC,REC,VAL,VISIT,X,Y,HNC,PGE,CV,SHAD
 S ECXERR=0,VISIT=ECXVISIT
 S (ECXVIST("AO"),ECXVIST("IR"),ECXVIST("PGE"),ECXVIST("HNC"))=""
 S (ECXVIST("MST"),ECXVIST("CV"),ECXVIST("SHAD"))=""
 ;MRY-2/4/2010, extracts don't seem to use encounter (visit) "CV".
 ;extracts use eligibility API for some reason.  Added "CV" anyway.
 S (ECXVIST("PROV"),ECXVIST("PROV CLASS"))=""
 S (ECXVIST("PROV NPI"),ECXVIST("SOURCE"))=""
 F I="P",1,2,3,4 S ECXVIST("ICD9"_I)=""
 F I=1:1:8 S ECXVIST("CPT"_I)=""
 D ENCEVENT^PXAPI(VISIT)
 I $O(^TMP("PXKENC",$J,VISIT,""))']"" K ECXVIST S ECXERR=1
 Q:ECXERR
 S DATE=$P($P(^TMP("PXKENC",$J,VISIT,"VST",VISIT,0),U,1),".",1)
 S ECXVIST("SOURCE")=$P($G(^TMP("PXKENC",$J,VISIT,"VST",VISIT,812)),U,3)
 ;get icd9 codes upto 5; else use 799.9
 K ARY S ICD("P")=0,ICD("S")=0,(ARY,REC)=""
 F  S REC=$O(^TMP("PXKENC",$J,VISIT,"POV",REC)) Q:REC=""  D
 .S VAL=^TMP("PXKENC",$J,VISIT,"POV",REC,0) Q:'VAL
 .I $P(VAL,U,12)="P" D
 ..S:'$D(ARY("P",+VAL)) CNT=ICD("P")+1,ICD("P",CNT)=+VAL,ICD("P")=CNT
 ..S ARY("P",+VAL)=""
 .I $P(VAL,U,12)'="P" D
 ..S:'$D(ARY("S",+VAL)) CNT=ICD("S")+1,ICD("S",CNT)=+VAL,ICD("S")=CNT
 ..S ARY("S",+VAL)=""
 S CNT=0,ECXVIST("ICD9P")=$P($G(^ICD9(+$G(ICD("P",1),0),0)),U)
 F I=2:1 Q:'$D(ICD("P",I))  D  Q:CNT>4
 .S CNT=CNT+1,ECXVIST("ICD9"_CNT)=$P($G(^ICD9(ICD("P",I),0)),U)
 I CNT<4 F I=1:1:8 Q:'$D(ICD("S",I))  D  Q:CNT>4
 .I '$D(ARY("P",ICD("S",I))) D
 ..S CNT=CNT+1,ECXVIST("ICD9"_CNT)=$P($G(^ICD9(ICD("S",I),0)),U)
 ;get first provider designated as primary
 ;if no primary, then get first physician provider
 ;if no physician, then get first provider
 S (PROV,PROVPC)=""
 I $O(^TMP("PXKENC",$J,VISIT,"PRV",0)) D
 .S (REC,VAL)=0 D
 ..F  S REC=$O(^TMP("PXKENC",$J,VISIT,"PRV",REC)) Q:('REC)!(VAL)  D
 ...S:($P(^(REC,0),U,4)="P") VAL=+^(0)
 ...S PROV=VAL,PROVPC=$$PRVCLASS^ECXUTL(PROV,DATE)
 .I 'VAL S (REC,VAL)=0 D
 ..F  S REC=$O(^TMP("PXKENC",$J,VISIT,"PRV",REC)) Q:('REC)!(VAL)  D
 ...S (PROV,VAL)=+^(REC,0)
 ...S PROVPC=$$PRVCLASS^ECXUTL(PROV,DATE) Q:PROVPC=""
 ...S NUM=$E(PROVPC,2,7) S:(NUM<110000)!(NUM>119999) VAL=0,PROVPC=""
 .I 'VAL D
 ..S REC=$O(^TMP("PXKENC",$J,VISIT,"PRV",0)) Q:('REC)!(VAL)
 ..S VAL=+^(REC,0),PROV=VAL,PROVPC=$$PRVCLASS^ECXUTL(PROV,DATE)
 .S:PROV]"" PROV="2"_PROV
 S ECXVIST("PROV")=PROV,ECXVIST("PROV CLASS")=PROVPC
 S ECXVIST("PROV NPI")=""
 ;get 1-5 secondary physicians
 F I=1:1:5 S ECXVIST("PROVS"_I)=""
 I $O(^TMP("PXKENC",$J,VISIT,"PRV",0)) D
 .S (REC,VAL,COUNTS)=0 D
 ..F  S REC=$O(^TMP("PXKENC",$J,VISIT,"PRV",REC)) Q:('REC)  D
 ...Q:$P(^(REC,0),U,4)'="S"
 ...S VAL=+^(0) I $E(PROV,2,99)=VAL Q  ;don't process, primary
 ...S COUNTS=COUNTS+1 Q:(COUNTS>5)
 ...S PROVS=VAL,PROVSPC=$$PRVCLASS^ECXUTL(PROVS,DATE)
 ...S PROVSNPI=$$NPI^XUSNPI("Individual_ID",PROVS,DATE)
 ...S:+PROVSNPI'>0 PROVSNPI="" S PROVSNPI=$P(PROVSNPI,U)
 ...S ECXVIST("PROVS"_COUNTS)="2"_PROVS_U_PROVSPC_U_PROVSNPI
 ;get cpt codes upto 8 & modifiers upto 5
 S CNT=1,PROV=$E(PROV,2,99)
 D:$O(^TMP("PXKENC",$J,VISIT,"CPT",0))
 .S REC=0 D:PROV]""
 ..F  S REC=$O(^TMP("PXKENC",$J,VISIT,"CPT",REC)) Q:'REC  D  Q:CNT>8
 ...S CPT="",NODE=$G(^TMP("PXKENC",$J,VISIT,"CPT",REC,12))
 ...Q:NODE=""
 ...S NOD1=$S($P(NODE,U,4)=PROV:^TMP("PXKENC",$J,VISIT,"CPT",REC,0),1:"")
 ...Q:$P(NOD1,U)=""
 ...S Q="00"_+$P(NOD1,U,16),Q=$S(+Q:$E(Q,$L(Q)-1,$L(Q)),1:"01")
 ...S CPT=$P(NOD1,U),M=0,MOD=""
 ...F I=1:1:5 S M=$O(^TMP("PXKENC",$J,VISIT,"CPT",REC,1,M)) Q:'M  D
 ....S MOD=MOD_$S(MOD'="":";",1:"")
 ....S MOD=MOD_$P(^TMP("PXKENC",$J,VISIT,"CPT",REC,1,M,0),U)
 ...S ECXVIST("CPT"_CNT)=$$CPT^ECXUTL3(CPT,MOD,Q),CNT=CNT+1
 ...K ^TMP("PXKENC",$J,VISIT,"CPT",REC)
 ..Q:CNT>8
 .Q:CNT>8  S REC=0
 .F  S REC=$O(^TMP("PXKENC",$J,VISIT,"CPT",REC)) Q:'REC  D  Q:CNT>8
 ..S CPT="",NOD1=$G(^TMP("PXKENC",$J,VISIT,"CPT",REC,0))
 ..Q:$P(NOD1,U)=""
 ..S Q="00"_+$P(NOD1,U,16),Q=$S(+Q:$E(Q,$L(Q)-1,$L(Q)),1:"01")
 ..S CPT=$P(NOD1,U),M=0,MOD=""
 ..F I=1:1:5 S M=$O(^TMP("PXKENC",$J,VISIT,"CPT",REC,1,M)) Q:'M  D
 ...S MOD=MOD_$S(MOD'="":";",1:"")
 ...S MOD=MOD_$P(^TMP("PXKENC",$J,VISIT,"CPT",REC,1,M,0),U)
 ..S ECXVIST("CPT"_CNT)=$$CPT^ECXUTL3(CPT,MOD,Q),CNT=CNT+1
 ..K ^TMP("PXKENC",$J,VISIT,"CPT",REC)
 ..Q:CNT>8
 S:ECXVIST("CPT1")="" ECXVIST("CPT1")=9919901
 ;ao, ir, mst, pge, hnc, cv, shad
 S (AO,IR,MST,PGE,HNC,CV,SHAD)=""
 I $D(^TMP("PXKENC",$J,VISIT,"VST",VISIT,800)) D
 .S AO=$P(^TMP("PXKENC",$J,VISIT,"VST",VISIT,800),U,2)
 .S IR=$P(^TMP("PXKENC",$J,VISIT,"VST",VISIT,800),U,3),MST=$P(^(800),U,5)
 .S PGE=$P(^TMP("PXKENC",$J,VISIT,"VST",VISIT,800),U,4),HNC=$P(^(800),U,6)
 .S CV=$P(^TMP("PXKENC",$J,VISIT,"VST",VISIT,800),U,7),SHAD=$P(^(800),U,8)
 .S ECXVIST("AO")=$S(AO=0:"N",AO=1:"Y",1:"")
 .S ECXVIST("IR")=$S(IR=0:"N",IR=1:"Y",1:"")
 .S ECXVIST("MST")=$S(MST=0:"N",MST=1:"Y",1:"")
 .S ECXVIST("PGE")=$S(PGE=0:"N",PGE=1:"Y",1:"")
 .S ECXVIST("HNC")=$S(HNC=0:"N",HNC=1:"Y",1:"")
 .S ECXVIST("CV")=$S(CV=0:"N",CV=1:"Y",1:"")
 .S ECXVIST("SHAD")=$S(SHAD=0:"N",SHAD=1:"Y",1:"")
 Q

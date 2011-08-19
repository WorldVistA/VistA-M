PSJDSS ;ALB/JRC-REGENERATE DSS EXTRACT DATA FILE (#728.113) & (728.904) ; 10/8/08 1:53pm
 ;;5.0; INPATIENT MEDICATIONS ;**210**;16 DEC 97;Build 27
 Q
 ;
 ;This routine was written to regenerate lost IV or UD data that is
 ;normally stored in DSS intermediate files (#728.113) and (#728.904).
 ;When this routine is invoked the users are prompted for a date range
 ;The routine then loops thru the "AIV" xref in the case of IV or the
 ;"AUS" xref in the  case of UD, validates the orders and regenerates
 ;the records.
 ;
 ;Important Note: If the entries for a given range are not cleared the
 ;                file is going to end with duplicates, so a check is
 ;                done on file (#728.113) or (#728.904)  to see if any
 ;                entries exist, if they do, the program quits.
 ;
 ;               Input:   EXTRACT = "IV" or "UD"
 ;
EN ;Entry Point
 ;Check input
 Q:'$G(EXTRACT)=""
 N STDATE,ENDDATE
 ;Get start and stop dates
 Q:'$$DATE()
 Q:'$$CHECK(EXTRACT)
 S ZTDESC=EXTRACT_" EXTRACT DATA FILE: "_STDATE_" TO "_ENDDATE_" RECOMPILE",ZTRTN="START^PSJDSS",ZTIO=""
 F I="EXTRACT","STDATE","ENDDATE" S ZTSAVE(I)=""
 D ^%ZTLOAD
 I $D(ZTSK) D
 .W !,"Request queued as Task #",ZTSK,".",!
 Q
START ;Start recompile after queue
 N COUNT
 ;Process records and update intermediate file
 D @EXTRACT
 ;Send completion message
 D MSG
 ;verify ^tmp global is deleted
 K ^TMP($J)
 Q
 ;
DATE() ;Prompt user for start date
 N DIR,X,Y,DIRUT
 S DIR(0)="D"
 S DIR("A")="Enter Start Date"
 D ^DIR
 I $D(DIRUT) Q 0
 S STDATE=Y
 ;Prompt user for end date
 K DIR,X,Y
 S DIR(0)="D"
 S DIR("A")="Enter Stop Date"
 D ^DIR
 I $D(DIRUT) Q 0
 S ENDDATE=Y
 Q 1
 ;
CHECK(X) ;Check intermediate file for existing entries in selected time frame
 ;if entries exist quit.
 N FILE S FILE=""
 S FILE=$S(X="IV":728.113,1:728.904)
 I $O(^ECX(FILE,"A",STDATE-.001))&($O(^(STDATE-.001))'>ENDDATE) D  Q 0
 .W !!!,?3,"******* Entries in file "_$S(X="IV":"(#728.113)",1:"(#728.904)")_" exist for selected time frame ******  "
 .W !,?10,"****** Please purge entries before proceeding!!!! *****  "
 Q 1
 ;
IV ;Process iv records to be recreated for intermediate file
 ;init variables
 N DATE,DFN,ON,PSIVNOW,PSIVI,PSIVQTY,PSIVC,LABN
 ;$order thru ^PS(55,"AIV",dtorder,dfn,on) to regenerate data
 S DATE=STDATE-.001,ENDDATE=ENDDATE_.9999
 S DATE=0 F  S DATE=$O(^PS(55,"AIV",DATE)) Q:'DATE  D
 .S DFN=0 F  S DFN=$O(^PS(55,"AIV",DATE,DFN)) Q:'DFN  D
 ..S ON=0 F  S ON=$O(^PS(55,"AIV",DATE,DFN,ON)) Q:'ON  D
 ...S LABN=0 F  S LABN=$O(^PS(55,DFN,"IV",ON,"LAB",LABN)) Q:'LABN  D
 ....S PSIVC=$P($G(^PS(55,DFN,"IV",ON,"LAB",LABN,0)),U,3)
 ....S PSIVNOW=$P($G(^PS(55,DFN,"IV",ON,"LAB",LABN,0)),U,2)
 ....Q:PSIVNOW<STDATE!(PSIVNOW>ENDDATE)
 ....S PSIVQTY=$P($G(^PS(55,DFN,"IV",ON,"LAB",LABN,0)),U,5) I +PSIVQTY=0 S PSIVQTY=1
 ....F PSIVI=1:1:PSIVQTY D IVUPDATE
 Q
 ;
UD ;Process ud records to be recreated for intermediate file
 ;init variables
 N DATE,DFN,ON,DISP,NODE,DRUG,QTY,COST,WARD,PROVIDER,HOW,PSGSTRT,DDATE
 ;$order thru ^PS(55,5,"AUS",stop date/time,on) to regenerate data
 S DATE=STDATE-.001,ENDDATE=ENDDATE_.9999,(DFN,COUNT)=0
 F  S DFN=$O(^PS(55,DFN)) Q:'DFN  D
 .S DATE=0
 .F  S DATE=$O(^PS(55,DFN,5,"AUS",DATE)) Q:'DATE  D
 ..S ON=0 F  S ON=$O(^PS(55,DFN,5,"AUS",DATE,ON)) Q:ON'>0  D
 ...;Look at dispense log multiple 55.0611 check disp field (#.01)
 ...S DISP=0  F  S DISP=$O(^PS(55,DFN,5,ON,11,DISP)) Q:DISP'>0  D
 ....S NODE=$G(^PS(55,DFN,5,ON,11,DISP,0)) Q:NODE=""
 ....S PSGSTRT=$P($G(^PS(55,DFN,5,ON,2)),"^",2)
 ....S DDATE=$P(NODE,U),DRUG=+$P(NODE,U,2),QTY=$P(NODE,U,3),COST=$P(NODE,U,4),WARD=$P(NODE,U,7),PROVIDER=$P(NODE,U,8),HOW=$P(NODE,5)
 ....Q:DDATE<STDATE!(DDATE>ENDDATE)
 ....D UDUPDATE
 Q
 ;
IVUPDATE ;Update dss intermediate file (#728.113)
 S X="ECXPIV1" X ^%ZOSF("TEST") Q:'$T
 N X,PROV,TYP,START,A,IVROOM,B,DSDATE,DRGTYP,DRG,ND,ADSTR,ADUNITS,SOLSTR,DDRG,DCST,Y,ECUD
 K ^TMP($J)
 S X=$G(^PS(55,DFN,"IV",+ON,0)),PROV=$P(X,U,6),TYP=$P(X,U,4),START=$P(X,U,2)
 S A=$G(^PS(55,DFN,"IV",+ON,2)),IVROOM=$P(A,"^",2),B=$G(^PS(55,DFN,"IV",+ON,4)),DSDATE=$S($P(B,"^",2)]"":$P(B,"^",2),1:$P(A,"^"))
 F DRGTYP="AD","SOL" F DRG=0:0 S DRG=$O(^PS(55,DFN,"IV",+ON,DRGTYP,DRG)) Q:'DRG  D
 .S ND=$G(^PS(55,DFN,"IV",+ON,DRGTYP,DRG,0)),(ADSTR,ADUNITS,SOLSTR)=""
 .S @(DRGTYP_"STR")=$P(ND,U,2),ND=$G(^PS($S(DRGTYP="AD":52.6,1:52.7),+ND,0)),DDRG=$P(ND,U,2),DCST=$P(ND,U,7)
 .I DRGTYP="AD" S Y=$P(ND,U,3) I Y S Y=$$CODES^PSIVUTL(Y,52.6,2) S ADUNITS=Y
 .S ECUD=DFN_U_+ON_U_DDRG_U_PSIVNOW_U_PSIVC_U_ADSTR_U_ADUNITS_U_+SOLSTR_U_PROV_U_TYP_U_DCST
 .S ECUD=ECUD_U_$P($G(^PS(55,DFN,"IV",+ON,"DSS")),"^")_U_START_U_IVROOM_U_DSDATE S ^TMP($J,DFN,ON,DDRG)=ECUD D ^ECXPIV1 S COUNT=$G(COUNT)+1
 Q
 ;
UDUPDATE ;Update unit dose extract data file (#728.904)
 S X="ECXUD1" X ^%ZOSF("TEST") Q:'$T
 S ECUD=DFN_"^"_DDATE_"^"_DRUG_"^"_QTY_"^"_WARD_"^"_PROVIDER_";200^"_COST_"^"_PSGSTRT_"^"_ON D ^ECXUD1 S COUNT=$G(COUNT)+1
 Q
 ;
MSG ; send message to mail group 'DSS-ECGRP'
 N XMSUB,XMDUZ,XMY,ECMSG,XMTEXT,ECGRP
 S XMSUB=EXTRACT_" INTERMEDIATE DATA FOR DSS"
 S XMDUZ="DSS SYSTEM",ECGRP=$S(EXTRACT="IV":"IV",1:"UD")
 K XMY S XMY("G.DSS-"_ECGRP)=""
 S ECMSG(1,0)="The "_EXTRACT_" information has been successfully regenerated"
 S ECMSG(2,0)="from "_$$FMTE^XLFDT(STDATE)_" to "_$$FMTE^XLFDT(ENDDATE)
 S ECMSG(3,0)=" "
 S ECMSG(4,0)="A total of "_COUNT_" records were written."
 S ECMSG(5,0)=" "
 S XMTEXT="ECMSG("
 D ^XMD
 Q

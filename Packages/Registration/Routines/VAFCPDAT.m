VAFCPDAT ;BIR/CML/ALS-DISPLAY MPI/PD INFORMATION FOR SELECTED PATIENT ; 7/12/16 11:11am
 ;;5.3;Registration;**333,414,474,505,707,712,837,863,876,902,926,937,950,1059,1071**;Aug 13, 1993;Build 4
 ;Registration has IA #3299 for MPI/PD to call START^VAFCPDAT
 ;
 ;variable DFN is not NEWed or KILLed in this routine as that variable is passed in
 ;
MAIN ; Entry point with device call
 S NOTRPC=1
 K ZTSAVE S ZTSAVE("DFN")=""
 D EN^XUTMDEVQ("START^VAFCPDAT","Print MPI/PD Patient Data",.ZTSAVE)
 K NOTRPC
 Q
 ;
START ;Entry point without device call, used for RPC calls
 N X S X="MPIF001" X ^%ZOSF("TEST") I '$T W !,"MPI not installed." G QUIT  ;**863 - MVI_2351 (ptd)
 S $P(LN,"=",80)="",$P(LN2,"=",60)="",QFLG=0
 D NOW^%DTC S HDT=$$FMTE^XLFDT($E(%,1,12))
 S SITE=$$SITE^VASITE(),SITENAM=$P(SITE,"^",2),SITENUM=$P(SITE,"^",3),SITEIEN=$P(SITE,"^")
 I +DFN<0 D  Q
 .I $D(NOTRPC) W @IOF,!," "
 .W !,"ICN ",$G(ICN)," does not exist at ",SITENAM,"."
 .W !,"Search date: ",HDT,!,LN
 S DIC=2,DR=".01;.02;.03;.09;.111;.112;.113;.114;.115;.1112;.131;.132;.134;.313;.351;994;.0907;.0906;.121;.1171;.1172;.1173;"
 S DR=DR_".024;.352;.353;.354;.355;.357;.358;.2405;.025;.0251;.2406;.24061;991.11;.1151;.1152;.1153;.1154;.1155;.1156;.11571;.11572;.11573"
 S DA=DFN,DIQ(0)="EI",DIQ="DNODE" D EN^DIQ1 K DIC,DR,DA,DIQ  ;**707,712,863,876;1059
 N NAME,SSN,DOB,SEX,CLAIM,DOD,ICN,STR1,STR2,STR3,CTY,ST,ZIP,PHN,WPHN,CPHN,MBI,SSNVER,PREAS,BAI,TIN,FIN,COUNTRY,CCODE,CNAME,PROVINCE,POSTCODE,SIGEN ;**707,712,837,863,876
 N DODD,DODENTBY,DODSRC,DODLUPD,DODLEBY,DODOPT,REST1,REST2,REST3,RESCTY,RESST,RESZP,RESP,RESPC,RESCN,ITIN,SXOD,SXO,PRN,PRND,EN,RCCODE,RCNAME ;**926 Story 323009 (ckn) **1059 VAMPI-11114,VAMPI-11118,VAMPI-11120, VAMPI-11121
 S NAME=$G(DNODE(2,DFN,.01,"E")),SSN=$G(DNODE(2,DFN,.09,"E")),SSNVER=$G(DNODE(2,DFN,.0907,"E"))  ;**707
 S DOB=$$FMTE^XLFDT($G(DNODE(2,DFN,.03,"I")))
 S MBI=$G(DNODE(2,DFN,994,"I")),MBI=$S(MBI="Y":"YES",MBI="N":"NO",1:"NULL")  ;**707
 S SEX=$G(DNODE(2,DFN,.02,"E")),SIGEN=$G(DNODE(2,DFN,.024,"E")),DOD=$G(DNODE(2,DFN,.351,"E"))  ;**876 - MVI_3432 (cml)
 S CLAIM=$G(DNODE(2,DFN,.313,"E")) S:CLAIM="" CLAIM="None"
 S BAI=$G(DNODE(2,DFN,.121,"E"))  ;**712
 S STR1=$G(DNODE(2,DFN,.111,"E")),STR2=$G(DNODE(2,DFN,.112,"E")),STR3=$G(DNODE(2,DFN,.113,"E"))
 S CTY=$G(DNODE(2,DFN,.114,"E")),ST=$G(DNODE(2,DFN,.115,"E")),ZIP=$G(DNODE(2,DFN,.1112,"E"))
 S COUNTRY=$G(DNODE(2,DFN,.1173,"I")),(CCODE,CNAME)="" I COUNTRY]"" S CCODE=$$GET1^DIQ(779.004,+COUNTRY_",",.01),CNAME=$$GET1^DIQ(779.004,+COUNTRY_",",1.3)  ;**863 - MVI_1902 (ptd)
 S PROVINCE=$G(DNODE(2,DFN,.1171,"E")),POSTCODE=$G(DNODE(2,DFN,.1172,"E"))
 ;**1071 Story 13802 (jfw) - Retrieve/Display WorkPhone (.132) and CellPhone (.134)
 S PHN=$G(DNODE(2,DFN,.131,"E")),WPHN=$G(DNODE(2,DFN,.132,"E")),CPHN=$G(DNODE(2,DFN,.134,"E")),PREAS=$G(DNODE(2,DFN,.0906,"E"))  ;**707
 S MNODE=$$MPINODE^MPIFAPI(DFN) I +MNODE=-1 S MNODE="^^^^^^^^"
 S (ICN,SCN,SCORE,SCRDT,DIFF,TIN,FIN)=""   ;**837, MVI_883
 S ICN=$$GETICN^MPIF001(DFN) S:(+ICN=-1) ICN="None" ;**863 - MVI_2351 (ptd)
 ;**926 - Story 323009 (ckn): DOD fields
 I DOD'="" D
 .;Date of Death Entered By ;Date of Death Source of Notification ;Date of Death Last Updated ;Date of Death Last Edited By ;Date of Death Supporting Document Type ;Date of Death Option Used
 . S DODENTBY=$G(DNODE(2,DFN,.352,"E")),DODSRC=$G(DNODE(2,DFN,.353,"E")),DODLUPD=$G(DNODE(2,DFN,.354,"E")),DODLEBY=$G(DNODE(2,DFN,.355,"E"))
 . S DODD=$G(DNODE(2,DFN,.357,"E")),DODOPT=$G(DNODE(2,DFN,.358,"E"))
 ;S CMOR=$$GET1^DIQ(4,+$P($G(MNODE),"^",3)_",",.01) S:CMOR="" CMOR="None"    ;removed for **837, MVI_918
 I $E(ICN,1,3)=SITENUM S GOT=0 I $P($G(MNODE),"^",4)=""!('$D(^DPT("AICNL",1,DFN))) S ICN=ICN_"**"
 S TIN=$P($G(MNODE),"^",8),FIN=$P($G(MNODE),"^",9) ;**837, MVI_883
 ;**1059 VAMPI-11114,VAMPI-11118,VAMPI-11120, VAMPI-11121
 S REST1=$G(DNODE(2,DFN,.1151,"E")),REST2=$G(DNODE(2,DFN,.1152,"E")),REST3=$G(DNODE(2,DFN,.1153,"E")),RESCTY=$G(DNODE(2,DFN,.1154,"E")),RESST=$G(DNODE(2,DFN,.1155,"E"))
 S RESZP=$G(DNODE(2,DFN,.1156,"E")),RESP=$G(DNODE(2,DFN,.11571,"E")),RESPC=$G(DNODE(2,DFN,.11572,"E"))
 S RESCN=$G(DNODE(2,DFN,.11573,"I")),(RCCODE,RCNAME)="" I RESCN]"" S RCCODE=$$GET1^DIQ(779.004,+RESCN_",",.01),RCNAME=$$GET1^DIQ(779.004,+RESCN_",",1.3)
 S ITIN=$G(DNODE(2,DFN,991.11,"E")),SXOD=$G(DNODE(2,DFN,.0251,"E")),PRND=$G(DNODE(2,DFN,.24061,"E"))
 ;
 I $D(NOTRPC) W @IOF,!
 W !,"MPI/PD Data for: ",NAME,"  (DFN #",DFN,")"
 ; check for patient sensitivity and user security
 N RESULT,RGSENS,SENSTV,DA,DR,DIC,DIQ,VAFCSEN
 D PTSEC^DGSEC4(.RESULT,DFN,0,"MPI/PD Patient Inquiry^MPI/PD Patient Inquiry")
 I RESULT(1)=-1 W !!,"Access denied: Required parameters not defined" G QUIT
 I RESULT(1)>0 W ?50,"***PATIENT MARKED SENSITIVE***"
 I RESULT(1)=3 W !!,"Access not allowed on your own PATIENT (#2) file entry" G QUIT
 I RESULT(1)=4 W !!,"Access denied: Your SSN is not defined" G QUIT
 I RESULT(1)<3 D
 . I RESULT(1)=1 D NOTICE^DGSEC4(.VAFCSEN,DFN,"RPC - VAFC REMOTE PDAT FROM THE MPI^MPI/PD Patient Inquiry (Remote)",2) ;IA #3027
 . I RESULT(1)=2 D NOTICE^DGSEC4(.VAFCSEN,DFN,"RPC - VAFC REMOTE PDAT FROM THE MPI^MPI/PD Patient Inquiry (Remote)",3) ;IA #3027
 W !,"Printed ",HDT," at ",SITENAM,!,LN
 S $Y=$Y+1
 ;next 7 lines modified for **707
 W !,"ICN : ",ICN  ;CMOR removed  **837, MVI_918
 W !,"SSN : ",SSN
 I SSNVER'="" W !?9,"SSN Verification Status: ",SSNVER
 I PREAS'="" W !?9,"Pseudo SSN Reason: ",PREAS
 I ITIN'="" W !?9,"Individual Tax ID: ",ITIN ;**1059 VAMPI-11114,VAMPI-11118,VAMPI-11120, VAMPI-11121
 ; Story 603957 (elz) change sex to birth sex, lined up with DOB and DOD at the same time
 W !,"Birth Sex    :  ",SEX
 ;**1059 VAMPI-11114,VAMPI-11118,VAMPI-11120, VAMPI-11121
 ;**1071 VAMPI-13755 (jfw) - Display additional SO Info
 ;SEXUAL ORIENTATION
 I $O(^DPT(DFN,.025,0))'="" W !,"Sexual Orientation: " D
 .S EN=0 F  S EN=$O(^DPT(DFN,.025,EN)) Q:'EN  D
 ..N VAFCSOI D GETS^DIQ(2.025,EN_","_DFN,"*",,"VAFCSOI")
 ..W ?20,VAFCSOI(2.025,EN_","_DFN_",",.01)_" ("_VAFCSOI(2.025,EN_","_DFN_",",.02)_")"
 ..W !?25,"Date Created: ",?44,VAFCSOI(2.025,EN_","_DFN_",",.03)
 ..W !?25,"Date Last Updated: "_VAFCSOI(2.025,EN_","_DFN_",",.04)
 ..W:(+$O(^DPT(DFN,.025,EN))) !
 I SXOD'="" W !,"Sexual Orientation Description: ",SXOD
 ;PRONOUN
 I $O(^DPT(DFN,.2406,0))'="" W !,"Pronoun: " D
 .S EN=0 F  S EN=$O(^DPT(DFN,.2406,EN)) Q:'EN  D
 ..S PRN=$G(^DPT(DFN,.2406,EN,0))
 ..W ?20,$P($G(^DG(47.78,PRN,0)),"^") W:(+$O(^DPT(DFN,.2406,EN))) !
 I PRND'="" W !,"Pronoun Description: ",PRND
 I SIGEN'="" W !,"Self-Identified Gender Identity: ",SIGEN  ;**876 - MVI_3432 (cml)  **902 - MVI_4730 (cml) MOVED HERE IN 1059
 W !,"Claim #      :  ",CLAIM
 W !,"Date of Birth:  ",DOB
 ;**926 - Story 323009 (ckn): DOD fields
 I DOD]"" D
 . W !,"Date of Death:  ",DOD
 . I DODENTBY]"" W !,?15,"Entered By: ",?42,DODENTBY
 . I DODSRC]"" W !,?15,"Source of Notification: ",?42,DODSRC
 . I DODLUPD]"" W !,?15,"Last Updated: ",?42,DODLUPD
 . I DODLEBY]"" W !,?15,"Last Edited By: ",?42,DODLEBY
 . I DODD]"" W !,?15,"Supporting Document Type: ",?42,DODD
 . I DODOPT]"" W !,?15,"Option Used: ",?42,DODOPT
 I MBI]"" W !,"Multiple Birth Indicator: ",MBI  ;**707
 I TIN]"" W !,"DoD Temporary ID Number : ",TIN  ;**837, MVI_883
 I FIN]"" W !,"DoD Foreign ID Number   : ",FIN  ;**837, MVI_883
 W !,"Correspondence Address:" I BAI'="" W " (Bad Address Indicator: ",BAI,")" ;**1059 VAMPI-11114,VAMPI-11118,VAMPI-11120, VAMPI-11121
 I STR1'="" W !?9,STR1
 I STR2'="" W !?9,STR2
 I STR3'="" W !?9,STR3
 I COUNTRY=""!(CCODE="USA") D   ;USA Address  **863 - MVI_1902 (ptd)
 .I CTY]"" W !?9,$E(CTY,1,20)_", "_$G(ST)_" "_$G(ZIP)
 I COUNTRY]"",CCODE'="USA" D   ;Foreign Address
 .I CTY]""!(PROVINCE]"")!(POSTCODE]"") D
 ..I PROVINCE]"" W !?9,CTY_", "_PROVINCE_" ("_CNAME_")  "_POSTCODE
 ..I PROVINCE="" W !?9,CTY_", "_"("_CNAME_")  "_POSTCODE
 W !,"Residential Address: "
 I REST1'="" W !?9,REST1
 I REST2'="" W !?9,REST2
 I REST3'="" W !?9,REST3
 I $G(RESCN)=""!($G(RCCODE)="USA") I RESCTY]"" W !?9,$E(RESCTY,1,20)_", "_$G(RESST)_" "_$G(RESZP)
 I RESCN'="",$G(RCCODE)'="USA" D   ;Foreign Address
 .I RESCTY]""!(RESP]"")!(RESPC]"") D
 ..I RESP]"" W !?9,RESCTY_", "_RESP_" ("_RCNAME_")  "_RESPC
 ..I RESP="" W !?9,RESCTY_", "_"("_RCNAME_")  "_RESPC
 I PHN'="" W !,"Phone #: ",PHN
 ;**1071 Story 13802 (jfw) - Retrieve/Display WorkPhone (.132) and CellPhone (.134)
 I WPHN'="" W !,"Work  #: ",WPHN
 I CPHN'="" W !,"Cell  #: ",CPHN
 I $G(IOSL)<30&($E(IOST,1,2)="C-") D
 .I $Y>23 D
 ..S DIR(0)="E" D  D ^DIR K DIR I 'Y S QFLG=1
 ...S SS=22-$Y F JJ=1:1:SS W !
 ..S $Y=0
 I QFLG=1 G QUIT
 ;
TF ;List Treating Facilities for this patient
 D TFHDR
 K TFARR
 S TF=0 F  S TF=$O(^DGCN(391.91,"APAT",DFN,TF)) Q:'TF  D
 .S TFIEN=$O(^DGCN(391.91,"APAT",DFN,TF,0))
 . S DIC="^DGCN(391.91,",DR=".02;.03;.07",DA=TFIEN,DIQ(0)="EI",DIQ="TFDATA"
 . D EN^DIQ1 K DIC,DA,DR,DIQ
 . S INST="",STATION=""
 . S INST=$G(TFDATA(391.91,TFIEN,.02,"I"))
 . I INST'="" D
 .. S DIC=4,DR="99",DA=INST,DIQ(0)="E",DIQ="STA"
 .. D EN^DIQ1 K DIC,DA,DR,DIQ
 .. S STATION=$G(STA(4,INST,99,"E"))
 . S TFNM=$G(TFDATA(391.91,TFIEN,.02,"E"))
 . S LSTDT=$G(TFDATA(391.91,TFIEN,.03,"I")) S:LSTDT="" LSTDT="none found"
 . S LSTSORT=9999999
 . I +LSTDT S LSTSORT=9999999-LSTDT,LSTDT=$$FMTE^XLFDT($E(LSTDT,1,12))
 . S REACODE=$G(TFDATA(391.91,TFIEN,.07,"E")) S REASON="none found"
 . I REACODE'="" D
 .. S DIC="^VAT(391.72,",DIC(0)="Z",X=REACODE D ^DIC K DIC,X
 .. S REASON=$P($G(Y(0)),"^",4)
 . S TFARR(LSTSORT,TFNM)=TFIEN_"^"_REASON_"^"_$G(STATION)_"^"_LSTDT
 I '$D(TFARR) W !,"No Treating Facilities found." G SUB
 S LSTSORT=0 F  S LSTSORT=$O(TFARR(LSTSORT)) Q:'LSTSORT  D  G:QFLG QUIT
 .S TFNM="" F  S TFNM=$O(TFARR(LSTSORT,TFNM)) Q:TFNM=""  D  Q:QFLG
 ..S REASON=$P(TFARR(LSTSORT,TFNM),"^",2)
 ..S STATION=$P(TFARR(LSTSORT,TFNM),"^",3)
 ..S LSTDT=$P(TFARR(LSTSORT,TFNM),"^",4)
 ..I $Y+3>IOSL&($E(IOST,1,2)="C-") D  Q:QFLG
 ...S LNQ=22 D SS Q:QFLG
 ...W @IOF,!,"MPI/PD data for: ",NAME,"  (DFN #",DFN,")",!,LN2 D TFHDR
 ..W !,$E(TFNM,1,20),?22,$G(STATION),?32,LSTDT,?54,REASON
SUB ;removed listing of subscribers for RG*1.0*23
HIS ;find ICN history
 I '$O(^DPT(DFN,"MPIFHIS",0)) G CONT
 ;
 I $Y+4>IOSL&($E(IOST,1,2)="C-") D  G:QFLG QUIT
 .S LNQ=22 D SS Q:QFLG
 .W @IOF,!,"MPI/PD data for: ",NAME,"  (DFN #",DFN,")",!,LN2
 D ICNHDR
 S HIS=0 F  S HIS=$O(^DPT(DFN,"MPIFHIS",HIS)) Q:'HIS  D  G:QFLG QUIT
 .S DIC=2,DR="992",DR(2.0992)=".01;1;3",DA=DFN,DA(2.0992)=HIS ;**863 - MVI_2351 (ptd)
 .S DIQ(0)="E",DIQ="HISNODE"
 .D EN^DIQ1 K DIC,DA,DR,DIQ
 .S HISICN=$G(HISNODE(2.0992,HIS,.01,"E"))
 .S HISCHK=$G(HISNODE(2.0992,HIS,1,"E")) ;**863 - MVI_2351 (ptd) history checksum
 .S HFULLICN=HISICN_$S(HISCHK]"":"V"_HISCHK,1:"") ;**863 - MVI_2351 (ptd) History full ICN
 .S HISDT=$G(HISNODE(2.0992,HIS,3,"E"))
 .I $Y+3>IOSL&($E(IOST,1,2)="C-") D  Q:QFLG
 ..S LNQ=22 D SS Q:QFLG
 ..W @IOF,!,"MPI/PD data for: ",NAME,"  (DFN #",DFN,")",!,LN2 D ICNHDR
 .W !,HFULLICN I HISDT]"" W "  - changed ",HISDT ;**863 - MVI_2351 (ptd)
 ;
CONT ;Continue to VAFCPDT2 for extended data
 ;D CMORHIS^VAFCPDT2  ;CMOR History removed, called changed to EXT^VAFCPDT2  **837, MVI_918
 D EXT^VAFCPDT2
DONE ;
 I QFLG G QUIT
 I ($E(IOST,1,2)="C-") S LNQ=24 D SS
 ;
QUIT ;
 K %,CMOR,DIC,DIR,DIRUT,DNODE,GOT,HDT,HFULLICN,HIS,HISCHK,HISDT,HISICN,JJ,LIEN
 K LINST,LN,LSTDT,MNODE,REACODE,REASON,SCN,SCORE,SITE,SITEIEN,SITENAM,SITENUM
 K SS,SUBN,SUBARR,TERM,TERMDT,TF,TFARR,TFDATA,TFIEN,TFNM,Y,D,CHG,CHGNODE
 K HISNODE,DIFF,INST,RGDFN,SCRDT,STATION,STA,LN2,NAME,LSTSORT,LNQ,QFLG,MBI
 Q
TFHDR ;
 W !!,"Treating Facilities:",?22,"Station:",?32,"DT Last Treated",?54,"Event Reason"
 W !,"--------------------",?22,"--------",?32,"---------------",?54,"------------"
 Q
ICNHDR W !!,"ICN History:",!,"------------"
 Q
 ;
SS S DIR(0)="E" D  D ^DIR K DIR I 'Y S QFLG=1
 .S SS=LNQ-$Y F JJ=1:1:SS W !
 Q

VAFCPDAT ;BIR/CML/ALS-DISPLAY MPI/PD INFORMATION FOR SELECTED PATIENT ;10/24/02  13:13
 ;;5.3;Registration;**333,414,474,505,707,712,837**;Aug 13, 1993;Build 5
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
 S $P(LN,"=",80)="",$P(LN2,"=",60)="",QFLG=0
 D NOW^%DTC S HDT=$$FMTE^XLFDT($E(%,1,12))
 S SITE=$$SITE^VASITE(),SITENAM=$P(SITE,"^",2),SITENUM=$P(SITE,"^",3),SITEIEN=$P(SITE,"^")
 I +DFN<0 D  Q
 .I $D(NOTRPC) W @IOF,!," "
 .W !,"ICN ",$G(ICN)," does not exist at ",SITENAM,"."
 .W !,"Search date: ",HDT,!,LN
 S DIC=2,DR=".01;.02;.03;.09;.111;.112;.113;.114;.115;.1112;.131;.313;.351;994;.0907;.0906;.121",DA=DFN,DIQ(0)="EI",DIQ="DNODE"  ;**707,712
 N NAME,SSN,DOB,SEX,CLAIM,DOD,ICN,STR1,STR2,STR3,CTY,ST,ZIP,PHN,MBI,SSNVER,PREAS,BAI,TIN,FIN  ;**707,712,837
 D EN^DIQ1 K DIC,DR,DA,DIQ
 S NAME=$G(DNODE(2,DFN,.01,"E")),SSN=$G(DNODE(2,DFN,.09,"E"))
 S DOB=$$FMTE^XLFDT($G(DNODE(2,DFN,.03,"I")))
 S MBI=$G(DNODE(2,DFN,994,"I")),MBI=$S(MBI="Y":"YES",MBI="N":"NO",1:"NULL")  ;**707
 S SEX=$G(DNODE(2,DFN,.02,"E")),DOD=$G(DNODE(2,DFN,.351,"E"))
 S CLAIM=$G(DNODE(2,DFN,.313,"E")) S:CLAIM="" CLAIM="None"
 S BAI=$G(DNODE(2,DFN,.121,"E"))  ;**712
 S STR1=$G(DNODE(2,DFN,.111,"E")),STR2=$G(DNODE(2,DFN,.112,"E")),STR3=$G(DNODE(2,DFN,.113,"E"))
 S CTY=$G(DNODE(2,DFN,.114,"E")),ST=$G(DNODE(2,DFN,.115,"E")),ZIP=$G(DNODE(2,DFN,.1112,"E"))
 S PHN=$G(DNODE(2,DFN,.131,"E"))
 S SSNVER=$G(DNODE(2,DFN,.0907,"E"))  ;**707
 S PREAS=$G(DNODE(2,DFN,.0906,"E"))  ;**707
 S MNODE=$$MPINODE^MPIFAPI(DFN) I +MNODE=-1 S MNODE="^^^^^^^^"
 S (ICN,SCN,SCORE,SCRDT,DIFF,TIN,FIN)=""   ;**837, MVI_883
 S ICN=$P($G(MNODE),"^") S:ICN="" ICN="None"
 ;S CMOR=$$GET1^DIQ(4,+$P($G(MNODE),"^",3)_",",.01) S:CMOR="" CMOR="None"    ;removed for **837, MVI_918
 I $E(ICN,1,3)=SITENUM S GOT=0 D
 . I $P($G(MNODE),"^",4)=""!('$D(^DPT("AICNL",1,DFN))) S ICN=ICN_"**"
 S TIN=$P($G(MNODE),"^",8),FIN=$P($G(MNODE),"^",9)   ;**837, MVI_883
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
 W !,"ICN    : ",ICN  ;CMOR removed  **837, MVI_918
 W !,"SSN    : ",SSN
 I SSNVER]"" W !?9,"SSN Verification Status: ",SSNVER
 I SSNVER="",PREAS]"" W !?9,"Pseudo SSN Reason: ",PREAS
 I SSNVER]"",PREAS]"" W !?9,"Pseudo SSN Reason      : ",PREAS
 W !,"Sex    : ",SEX
 W !,"Claim #: ",CLAIM
 W !,"Date of Birth: ",DOB
 I DOD]"" W !,"Date of Death: ",DOD
 I MBI]"" W !,"Multiple Birth Indicator: ",MBI  ;**707
 I TIN]"" W !,"DoD Temporary ID Number : ",TIN  ;**837, MVI_883
 I FIN]"" W !,"DoD Foreign ID Number   : ",FIN  ;**837, MVI_883
 W !,"Address:" I BAI'="" W " (Bad Address Indicator: ",BAI,")"
 I STR1'="" W !?9,STR1
 I STR2'="" W !?9,STR2
 I STR3'="" W !?9,STR3
 I CTY'="" W !?9,$E(CTY,1,20)_", "_$G(ST)_" "_$G(ZIP)
 I PHN'="" W !,"Phone #: ",PHN
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
 .S DIC=2,DR="992",DR(2.0992)=".01;3",DA=DFN,DA(2.0992)=HIS
 .S DIQ(0)="E",DIQ="HISNODE"
 .D EN^DIQ1 K DIC,DA,DR,DIQ
 .S HISICN=$G(HISNODE(2.0992,HIS,.01,"E"))
 .S HISDT=$G(HISNODE(2.0992,HIS,3,"E"))
 .I $Y+3>IOSL&($E(IOST,1,2)="C-") D  Q:QFLG
 ..S LNQ=22 D SS Q:QFLG
 ..W @IOF,!,"MPI/PD data for: ",NAME,"  (DFN #",DFN,")",!,LN2 D ICNHDR
 .W !,HISICN I HISDT]"" W "  - changed ",HISDT
 ;
CONT ;Continue to VAFCPDT2 for extended data
 ;D CMORHIS^VAFCPDT2  
 ;CMOR History removed, called changed to EXT^VAFCPDT2  **837, MVI_918
 D EXT^VAFCPDT2
DONE ;
 I QFLG G QUIT
 I ($E(IOST,1,2)="C-") S LNQ=24 D SS
 ;
QUIT ;
 K %,CMOR,DIC,DIR,DIRUT,DNODE,GOT,HDT,HIS,HISDT,HISICN,JJ,LIEN,LINST
 K LN,LSTDT,MNODE,REACODE,REASON,SCN,SCORE,SITE,SITEIEN,SITENAM,SITENUM
 K SS,SUBN,SUBARR,TERM,TERMDT,TF,TFARR,TFDATA,TFIEN,TFNM,Y,D,CHG,CHGNODE
 K HISNODE,DIFF,INST,RGDFN,SCRDT,STATION,STA,LN2,NAME,LSTSORT,LNQ,QFLG,MBI
 Q
TFHDR ;
 W !!,"Treating Facilities:",?22,"Station:",?32,"DT Last Treated",?54,"Event Reason"
 W !,"--------------------",?22,"--------",?32,"---------------",?54,"------------"
 Q
ICNHDR  W !!,"ICN History:",!,"------------"
 Q
 ;
SS S DIR(0)="E" D  D ^DIR K DIR I 'Y S QFLG=1
 .S SS=LNQ-$Y F JJ=1:1:SS W !
 Q

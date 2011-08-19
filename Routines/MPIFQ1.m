MPIFQ1 ;ALB/RJS-CIRN QUERY HANDLER ;JUN 30, 1997
 ;;1.0; MASTER PATIENT INDEX VISTA ;**1,8,12,16,17,21,23,24,28,31,33,35**;30 Apr 99
 ;
 ; Integration Agreements Utilized:
 ;   EXC, START, STOP^RGHLLOG - #2796
 ;   FILE^VAFCTFU - #2988
 ;   ^DPT("AICN" - #2070
 ;   NAME^VAFCPID2 - #3492
 ;   EN1^XWB2HL7 - #3144
 ;   RTNDATA^XWBDRPC - #3149
 ;   VAFC REMOTE PDAT (RPC) - #3496
 ;
INIT ;Entry point for List Manager Template - MPIF REAL-TIME QUERY
 Q
HDR ;Header code for List Manager Template - MPIF REAL-TIME QUERY
 N SSN,DOB,MPIFQ1,NAME1,SEX
 D GETDATA^MPIFQ0("^DPT(",DFN,"MPIFQ1",".01;.03;.09;.02","EI")
 S NAME1=$G(MPIFQ1(2,DFN,.01,"E")),SSN=$G(MPIFQ1(2,DFN,.09,"E"))
 S DOB=$G(MPIFQ1(2,DFN,.03,"I")),SEX=$G(MPIFQ1(2,DFN,.02,"E"))
 I DOB]"" S DOB=$TR($$FMTE^XLFDT(DOB,"5D"),"/","-")
 S VALMHDR(1)=" Possible MPI Matches for Patient: "_IOINHI_NAME1_IOINORM
 S VALMHDR(2)="                              SSN: "_IOINHI_SSN_IOINORM
 S VALMHDR(3)="                              DOB: "_IOINHI_DOB_IOINORM
 S VALMHDR(4)="                              SEX: "_IOINHI_SEX_IOINORM,VALMHDR(5)=" "
 Q
START(INDEX) ;Starting entry point for envoking the List Manager Template MPIF Real-time query
 S VALMCNT=INDEX
 D EN^VALM("MPIF REAL-TIME QUERY")
 Q
SELECT N VALMY
 D EN^VALM2(XQORNOD(0),"OS")
 I '$D(VALMY) Q
 N DATA,INDEX,ICN,CHKSUM,NODE2
 S INDEX=$O(VALMY(0)),DATA=^TMP("MPIFVQQ",$J,INDEX,"DATA")
 S NODE2=$G(^TMP("MPIFVQQ",$J,INDEX,"INDICATOR"))
 S DATA(.01)=$P(DATA,"^",1) I $E(DATA(.01),$L(DATA(.01)))=" " S DATA(.01)=$E(DATA(.01),1,$L(DATA(.01))-1) ;NAME
 S DATA(.03)=$P(DATA,"^",4),DATA(.09)=$P(DATA,"^",3),DATA(.02)=$P(DATA,"^",11) ;DOB, SSN, SEX
 S ICN=$P(DATA,"^",6),CHKSUM=$P(ICN,"V",2),ICN=$P(ICN,"V",1),DATA(991.01)=ICN,DATA(991.02)=CHKSUM,DATA(991.03)=$$LKUP^XUAF4($P(DATA,"^",5))
 ;If NODE2["*" we have a pt in our list whose ICN is already at this site
 I NODE2["*",$O(^DPT("AICN",ICN,""))'=DFN D  Q
 .D CLEAR^VALM1,MSG1^MPIFQ3
 .N DFN2 S DFN2=$O(^DPT("AICN",ICN,""))
 .D TWODFNS^MPIF002(DFN2,DFN,ICN)
 .W !!,"Assigning Local ICN" D LOCAL^MPIFQ3(DFN),PROMPT^MPIFQ3 S MPIFRTN="CONTINUE"
 ;User selected from list, does SSN & Name match?  no-ask if sure
 N SSN,NAME,SEX
 D GETDATA^MPIFQ0("^DPT(",DFN,"MPIFQ1",".01;.09;.02","EI")
 S SSN=$G(MPIFQ1(2,DFN,.09,"E")),NAME=$G(MPIFQ1(2,DFN,.01,"E")),SEX=$G(MPIFQ1(2,DFN,.02,"I"))
 ; if sex doesn't match -- not allowed to update ICN
 I DATA(.02)'=SEX W !!,"Sex for these two patients doesn't match -- Can't select this patient until",!,"Sex matches between the MPI and your site.  No action will be taken." D PROMPT^MPIFQ3 S VALMBCK="R" Q
 I SSN["P" S SSN=""
 I DATA(.09)'=SSN W !!,"SSN for these two patients doesn't match -- Can't select this patient until",!,"SSN matches between the MPI and your site.  No action will be taken." D PROMPT^MPIFQ3 S VALMBCK="R" Q
 D NAME^VAFCPID2(0,.NAME,0) ;reformat name into DG 149 format
 N NAME3 S NAME3=DATA(.01) D NAME^VAFCPID2(0,.NAME3,0) S DATA(.01)=NAME3 ;reformat name into DG 149 format
 N EXACT
 ; check if Last, First MATCH if so is it a middle name vs middle initial
 I $P(DATA(.01),",")=$P(NAME,",")&($P($P(NAME,",",2)," ")=$P($P(DATA(.01),",",2)," ")) D
 .N MPIMID,NMMN S MPIMID=$P($P(DATA(.01),",",2)," ",2)
 .S NMMN=$P($P(NAME,",",2)," ",2)
 .I $L(NMMN)>1&($L(MPIMID)=1),($E(NMMN,1)=MPIMID) S EXACT=1
 .I $L(MPIMID)>1&($L(NMMN)=1),($E(MPIMID,1)=NMMN) S EXACT=1
 I DATA(.01)=NAME!($D(EXACT)) K DATA(.09),DATA(.01),DATA(.03) D EDIT^MPIFQED(DFN,"DATA") D MSG3^MPIFQ3,PROMPT^MPIFQ3,TF^MPIFQ3(DFN,.DATA) Q
 ; \/ Name doesn't match exactly - ask if sure
 D CLEAR^VALM1,MSG2^MPIFQ3,MSG^MPIFQ3(SSN,NAME,DATA(.09),DATA(.01))
 N ANS S ANS=$$PROMPT1^MPIFQ3()
 I ANS K DATA(.09),DATA(.01),DATA(.03) D EDIT^MPIFQED(DFN,"DATA") S MPIFRTN="CONTINUE" W !!,"ICN and CMOR Updated" D PROMPT^MPIFQ3,TF^MPIFQ3(DFN,.DATA) Q
 D MSG5^MPIFQ3,PROMPT^MPIFQ3 S VALMBCK="R"
 Q
ADD ;Add (MPIF REAL-TIME QUERY (ADD PATIENT)) add pt to MPI Austin.
 D A28^MPIFQ3(DFN),PROMPT^MPIFQ3 S MPIFRTN="CONTINUE"
 Q
MPIPD ; MPI PDAT CALL
 N VALMY,CNT,Y
 D EN^VALM2(XQORNOD(0),"OS")
 I '$D(VALMY) Q
 N DATA,INDEX,ICN,CHKSUM,CMOR,CASE,CMOR3,TTF,ALIAS,POW,TAL,TMP
 S INDEX=$O(VALMY(0)),Y="" D CLEAR^VALM1
 S DATA=^TMP("MPIFVQQ",$J,INDEX,"DATA")
 S CMOR=$P(DATA,"^",5),CMOR3=CMOR,CMOR=$P($$NS^XUAF4($$LKUP^XUAF4(CMOR)),"^")
 W !,"MPI Data:",!!!,?3,"ICN: ",+$P(DATA,"^",6),?30,"CMOR: ",CMOR," (",CMOR3,")"
 W !,?2,"NAME: ",$P(DATA,"^")
 W !,?3,"SSN: ",$P(DATA,"^",3),?30,"SEX: ",$P(DATA,"^",11)
 W !,?3,"DOB: ",$P(DATA,"^",4)
 W ?30,"DOD: ",$P(DATA,"^",9)
 I $P(DATA,"^",20)="Y" W !?3,"Multiple Birth Indicator:  Yes"
 I ($P(DATA,"^",12)='"")&($P(DATA,"^",13)'="") W !,?2,"PLACE OF BIRTH: ",$P(DATA,"^",12),", ",$P(DATA,"^",13)
 I $P(DATA,"^",12)=""!($P(DATA,"^",13)="") W !,?2,"PLACE OF BIRTH: ",$P(DATA,"^",12)," ",$P(DATA,"^",13)
 W !,?2,"MOTHER'S MAIDEN NAME: ",$P(DATA,"^",16)
 W !,?2,"CLAIM NUMBER: ",$P(DATA,"^",17)
 S POW=$P(DATA,"^",19) I POW'="" W !,?2,"POW STATUS: ",POW
 S CASE=$P(DATA,"^",18)
 I CASE'="" W !,?2,"Open Data Management Case",!,?5,"CASE#: ",$P(CASE,"/")_"   NOIS#: ",$P(CASE,"/",2),!,?5,"CASE WORKER: ",$P(CASE,"/",3)
 I $D(^TMP("MPIFVQQ",$J,INDEX,"ALIAS")) W !,?2,"Alias(es): " D
 .N XX S XX=0 F  S XX=$O(^TMP("MPIFVQQ",$J,INDEX,"ALIAS",XX)) Q:'XX  W !?10,^(XX)
 I $D(^TMP("MPIFVQQ",$J,INDEX,"TF"))&($O(^TMP("MPIFVQQ",$J,INDEX,"TF",1))'="") D
 .W !,?2,"TREATING FACILITY LIST:"
 .N XX S XX=0 F  S XX=$O(^TMP("MPIFVQQ",$J,INDEX,"TF",XX)) Q:'XX  S TMP=$P($G(^(XX)),MPICOMP) I TMP'=CMOR3 W !?10,"Treating Facility: ",$P($$NS^XUAF4($$LKUP^XUAF4(TMP)),"^")," (",TMP,")"
 D PROMPT^MPIFQ3
 S VALMBCK="R"
 Q
CMOR ; CMOR PDAT CALL
 N VALMY,DATA,INDEX,ICN,CHKSUM,CMOR
 D EN^VALM2(XQORNOD(0),"OS")
 I '$D(VALMY) Q
 S INDEX=$O(VALMY(0)),DATA=^TMP("MPIFVQQ",$J,INDEX,"DATA")
 S ICN=$P(DATA,"^",6),CHKSUM=$P(ICN,"V",2),ICN=$P(ICN,"V",1),CMOR=$P(DATA,"^",5)
 I CMOR=$P($$SITE^VASITE(),"^",3) W !!,"CMOR is your site" G END
 W !,"Please be patient while the data is being retrieved from the CMOR."
 D EN1^XWB2HL7(.RETURN,CMOR,"VAFC REMOTE PDAT",1,ICN,"")  ; Request 
 S ^XTMP("MPIFPDAT"_ICN,0)=$$FMADD^XLFDT(DT,2)_"^"_DT_"^"_"REMOTE PDAT QUERY",^XTMP("MPIFPDAT"_ICN,1)=RETURN(0)_"^"_$$NOW^XLFDT
 S CNT=0
AGAIN1 H 2 K RES1 D RTNDATA^XWBDRPC(.RES1,RETURN(0)) S CNT=CNT+1
 I +RES1(0)=-1&(RES1(0)["Not DONE") I CNT<11 G AGAIN1
 I +RES1(0)=-1&(RES1(0)["Not DONE") I CNT>10 W !,"Unable to get data" G END
 I RES1(0)="0^New" I CNT<11 G AGAIN1
 I RES1(0)="0^New" I CNT>10 W !,"Unable to get data" G END
 I +RES1(0)=-1 W !!,$P(RES1(0),"^",2) G END
 I RES1'="" I CNT<11 G AGAIN1
 I RES1'="" I CNT>10 W !,"Unable to get data" Q
 D CLEAR^VALM1
 N NUM S NUM="",CNT=0
 F  S NUM=$O(RES1(NUM)) Q:NUM=""  D
 .I CNT>20 D PROMPT^MPIFQ3,CLEAR^VALM1 S CNT=0
 .I RES1(NUM)["Additional" W !! S CNT=CNT+2
 .I CNT<21 W !,RES1(NUM) S CNT=CNT+1
END D PROMPT^MPIFQ3 S VALMBCK="R" K CNT,RETURN,RES1
 Q
HELP ; Help List Manager Action (MPIF REAL-TIME QUERY (HELP))
 D CLEAR^VALM1,MSG4^MPIFQ3,PROMPT^MPIFQ3 S VALMBCK="R"
 Q
EXIT ;Exit for List Manager Template MPIF REAL-TIME QUERY
 K VALMBCK,VALMCNT,VALMHDR
 Q

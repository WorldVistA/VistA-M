PRCFFU19 ;WISC/SJG-OBLIGATION PROCESSING UTILITIES ;1/12/95  5:33 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 QUIT
 ; .1  - P.O. Date
 ; .07 - Primary 2237
 ; .03 - Special FCP
 ; 17  - Validation Date for PA Esig
 ; PRCFA("BBFY") - BBFY as stored in file 442,field 26
 ; PRC("BBFY")   - BBFY based on station #, doc FY, FCP
 ;
BBFYCHK(PO) ; Check BBFY at Obligation
 N BBFY,BBFYCHK,FY2,FY4,FYI,N0,N1,PODT,PRIMREQ,REV,SFCP
 I '$D(PRCFA("OBLDATE")) D NOW^%DTC S PRCFA("OBLDATE")=X K X
 D GENDIQ^PRCFFU7(442,PO,".1;.07;.03;17","IEN","")
 S N0=$$NODE^PRC0B("^PRC(442,"_PO_",",0)
 S N1=$$NODE^PRC0B("^PRC(442,"_PO_",",1)
 S PODT=$G(PRCTMP(442,PO,.1,"I"))
 I PODT="" D DATE S PODT=$P(N1,U,15)
 S PRIMREQ=$G(PRCTMP(442,PO,.07,"I"))
 I PRIMREQ>0 D  G T1
 .S FYI=$$NP^PRC0B("^PRCS(410,"_PRIMREQ_",",3,11)
 .I FYI]"" S (FY4,PRC("BBFY"))=$P($$DATE^PRC0C(FYI,"I"),U) Q
 .I FYI="" D  Q
 ..N TXN
 ..S TXN=$$NP^PRC0B("^PRCS(410,"_PRIMREQ_",",0,1)
 ..S FY2=$P(TXN,"-",2),(FY4,PRC("BBFY"))=$P($$YEAR^PRC0C(FY2),U)
 ..Q
 S FY2=$E(PRCFA("OBLDATE"),2,3)+$E(PRCFA("OBLDATE"),4)
 D GETBBFY S (FY4,PRC("BBFY"))=BBFY
T1 I PRC("BBFY")'=PRCFA("BBFY") D  Q
 .S BBFYCHK=$P($$DATE^PRC0C(PRCFA("OBLDATE"),"I"),U)
 .S FY4=BBFYCHK D EDIT
 QUIT
 ;
DATE ; Determine P.O. Date
 K OK D DATE1 Q:$D(OK)
 D ESIG
 Q
DATE1 ; Get date of obligation from first node in Obligation Data
 N OBND,OBDT
 S OBND=$O(^PRC(442,PO,10,0)) I +OBND D  Q:$D(OK)
 .S OBDT=$P($G(^PRC(442,PO,10,OBND,0)),U,6) I $E(OBDT,1,7)?7N D SET(OBDT) Q
 Q
ESIG ; Use Purchasing Agent Esig Date or Current Date
 N CURDT,ESIGDT
 S ESIGDT=$G(PRCTMP(442,PO,17,"I"))
 I ESIGDT]"" S ESIGDT=$P(ESIGDT,".") I ESIGDT?7N D SET(ESIGDT) Q:$D(OK)
 S CURDT=DT D SET(CURDT)
 Q
SET(DATE) ; Set P.O. Date Field
 N DIE,DR,DA
 S DATE=$E(DATE,1,7),$P(N1,U,15)=DATE
 S DIE="^PRC(442,",DR=".1////^S X=DATE",DA=PO D ^DIE S OK=1
 Q
EDIT ; Edit BBFY field in File 442
 N DIE,DR,DA,APPR
 S APPR=$P($$ACC^PRC0C(PRC("SITE"),+PCP_U_PRC("FY")_U_PRC("BBFY")),U,11)
 S DIE="^PRC(442,",DA=PO,DR="1.4///^S X=APPR;26///^S X=FY4" D ^DIE
 S PRCFA("BBFY")=$$BBFY^PRCFFU5(PO)
 Q
GETBBFY ; Get BBFY based on station, 2-digit FY, and FCP
 S BBFY=$$BBFY^PRCSUT(+N0,FY2,+$P(N0,U,3))
 Q

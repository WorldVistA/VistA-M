SPNRPCI ;SD/WDE - Returns PHARMACY RX'S WITH A SPECIFIC NDC;DEC 17, 2009
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ;      INTEGRATION REFERENCE DBIA90-B
 ;      INTEGRATION REFERENCE 4820
 ;      INTEGRATION REFERENCE 4533
 ;                       
 ;      
 ;      
 ;      
 ;      
 ;      NOTE  this routine will find prescriptions based on the
 ;       WHOLE VALUE of the NATIONAL DRUG CLASS
 ;          ie IN160, AM80
 ;     NOTE   To find prescriptions based on the first two characters
 ;             of the NATIONAL DRUG CLASS USE SPNRPCH
 ;Parm values;
 ;     ICN is ICN of the pt
 ;     cutdate is the date to start collection data from
 ;     root is the sorted data in latest date of test first
 ;     type will be for the drug class
 ;       1 is anti-viral medications
 ;       2 is NSAID analgesics
 ;       3 is Influenza Virus Vaccine Inj 0.5 ml
 ;       4 is anticonvulsants
 ;       5 is tricyclic antidepressants
 ;       6 is opioid analgesics
 ;       7 is local anesthetics
 ;       8 is other medications
 ;       9 is Pneumococcal Vaccination Pharmaceuticals (IM100)
 ;      10 is Pneumonia Medications
 ;
 ;Returns:
 ;TMP($J,x) sorted by most recent rx
 ;VA CLASS ^ ITEM DESCRIPTION ^ DATE DISPENSED ^ PSRX(IEN
 ;
COL(ROOT,ICN,CUTDATE,TYPE) ;
 S X=CUTDATE S %DT="T" D ^%DT S CUTDATE=Y
 K ^TMP($J)
 S ROOT=$NA(^TMP($J))
 ;***************************
 Q:$G(ICN)=""
 S DFN=$$FLIP^SPNRPCIC(ICN)
 Q:DFN=""
 ;*****************************
 D @TYPE
BLDUTIL ;
 Q:$D(^PS(55,DFN))=0
 S SPNCNT=0
 Q:DFN=""
 D RX^PSO52API(DFN,"SPNSCRPT",,,0,2650101)
 Q:$G(^TMP($J,"SPNSCRPT",DFN,0))'>0
 ;RETURNS                                                              
 ;^TMP($J,"SPNSCRPT",4570,2367165,.01)=800085513                     
 ;          1)=2990514^MAY 14, 1999                                    
 ;          6)=5721^OXYCODONE 5MG/ACETAMINOPHEN 325MG TA               
 S RXNUM=0
 Q:DFN=""
 F  S RXNUM=$O(^TMP($J,"SPNSCRPT",DFN,RXNUM)) Q:RXNUM'>0  D
 .S SPNDRIEN=$P($G(^TMP($J,"SPNSCRPT",DFN,RXNUM,6)),U,1)  ;DRUG IEN
 .Q:SPNDRIEN=""
 .S SPNDRNA=$P($G(^TMP($J,"SPNSCRPT",DFN,RXNUM,6)),U,2)  ;DRUG NAME
 .Q:SPNDRNA=""
 .S SPNDISP=$P($G(^TMP($J,"SPNSCRPT",DFN,RXNUM,1)),U,1)  ;DISPENSE DATE
 .Q:SPNDISP=""
 .K ^TMP($J,"SPNPRE")
 .;--------------------------------------------------------------------
 .D ZERO^PSS50(,SPNDRIEN,,,,"SPNPRE")
 .;^TMP($J,"SPNPRE",5721,.01)=OXYCODONE 5MG/ACETAMINOPHEN 325MG TAB
 .;                      2)=CN101
 .;-----------------------------------------------------------------------
 .S SPNCLA=$P($G(^TMP($J,"SPNPRE",SPNDRIEN,2)),U,1)
 .;JAS - DEFECT 1183 - Check to quit if drug is missing VA Class
 .Q:SPNCLA=""
 .I $G(TESTVAL(SPNCLA))'="" D
 ..Q:SPNDISP<CUTDATE
 ..S SPNCNT=SPNCNT+1
 ..S SPNREV=9999999-SPNDISP
 ..S Y=SPNDISP D DD^%DT S SPNDISP=Y K Y
 ..S ^TMP($J,"KEEP",SPNREV,SPNCNT)=SPNCLA_U_SPNDRNA_U_SPNDISP_"^PSRX("_RXNUM
 ;---------------------------------------------------------------------------------------
RESORT ;
 ;^TMP($J,"KEEP",7018890,359)
 S SPNCNT=0
 S SPNREV=0
 F  S SPNREV=$O(^TMP($J,"KEEP",SPNREV)) Q:(SPNREV="")!('+SPNREV)  S SPNX=0 F  S SPNX=$O(^TMP($J,"KEEP",SPNREV,SPNX)) Q:(SPNX="")!('+SPNX)  D
 .S SPNCNT=SPNCNT+1
 .S ^TMP($J,SPNCNT)=$G(^TMP($J,"KEEP",SPNREV,SPNX))_"^EOL999"
 .Q
 K SPNTMP,SPZZ,SPNDFN
 K ^TMP($J,"SPNSCRPT")
 K ^TMP($J,"UTIL")
 K ^TMP($J,"KEEP")
 K ^TMP($J,"SPNPRE")
 K TESTVAL
 K CNT,RXORD,RXNUM,VACLASS,VACLASNA,COL,VACLASDS,DESPDT,REVDT,TESTVAL
 K %DT,DFN,RXX,SHOWDT,X,Y,SPNREV,SPNX,SPNDISP,SPNDRNA,SPNCLA,SPNREV,CUTDATE,SPNCNT,SPNDRIEN
 Q
 ;-----------------------------------------------------------------------------------------
 ;JAS 03/26/2008 DEFECT 190 - ADD/REMOVE MEDS BEING RETRIEVED FOR REPORTING
1 ;anti-viral medications / influenza diagnoses and treatment report
 S TESTVAL("AM800")="AM800"
 S TESTVAL("IN160")="IN160"
 Q
2 ;nsaids analgesics / pain assessment and treatment report
 ;S TESTVAL("CN101")="CN101"
 ;S TESTVAL("CN102")="CN102"
 S TESTVAL("CN103")="CN103"
 ;S TESTVAL("MS102")="MS102"
 S TESTVAL("CN104")="CN104"
 S TESTVAL("CN100")="CN100"
 Q
 ;
3 ;Influenza Virus Vaccine Inj 0.5 ml Influenza immunization report
 S TESTVAL("IM700")="IM700"
 Q
 ;
4 ;anticonvulsants / pain assessment and treatment report
 S TESTVAL("CN400")="CN400"
 Q
 ;
5 ;is tricyclic antidepressants
 S TESTVAL("CN601")="CN601"
 Q
 ;
6 ;is opioid analgesics
 S TESTVAL("CN101")="CN101"
 Q
 ;
7 ;is local anesthetics
 S TESTVAL("CN204")="CN204"
 S TESTVAL("CN205")="CN205"
 S TESTVAL("DE650")="DE650"
 S TESTVAL("DE700")="DE700"
 Q
8 ;is other medications
 ;Note that this is a mixed group of class and have very specific 
 ;reason for being grouped like this
 S TESTVAL("CN900")="CN900"
 ;S TESTVAL("GA700")="GA700"
 S TESTVAL("IN500")="IN500"
 S TESTVAL("IN510")="IN510"
 S TESTVAL("GA605")="GA605"
 Q
9 ;is Pneumococcal Vaccination Pharmaceuticals (IM100)
 S TESTVAL("IM100")="IM100"
 Q
 ;
10 ;Pneumonia Medications
 S TESTVAL("IN970")="IN970"
 S TESTVAL("TN000")="TN000"
 S TESTVAL("TN200")="TN200"
 S TESTVAL("TN300")="TN300"
 S TESTVAL("TN900")="TN900"
 S TESTVAL("XA700")="XA700"
 S TESTVAL("XA701")="XA701"
 S TESTVAL("XA702")="XA702"
 S TESTVAL("XA703")="XA703"
 S TESTVAL("XA799")="XA799"
 Q

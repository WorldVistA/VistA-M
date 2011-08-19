PSUAR2 ;BIR/PDW - ASSEMBLE AR/WS RECORDS FOR TRANSMISSION ;10 JUL 1999
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ; DBIA(s)
 ; Reference to file #50 supported by DBIA 221
 ;
EN ;EP Build ("RECORDS") from scan of ^XTMP(PSUARSUB,"DIV_DRUG",Drug,Div)=Total
 S PSUDRDA=0,PSULC=0,PSUDIVDA=0
 K ^XTMP(PSUARSUB,"RECORDS")
 K ^XTMP(PSUARSUB,"DRUG_TOTAL")
 F  S PSUDIVDA=$O(^XTMP(PSUARSUB,"DIV_DRUG",PSUDIVDA)) Q:PSUDIVDA=""  D DRUGSCAN
 Q
 ;
DRUGSCAN ;EP Scan for Drugs within division
 S PSUDDRDA=0,PSULC=0 ;**1
 F  S PSUDRDA=$O(^XTMP(PSUARSUB,"DIV_DRUG",PSUDIVDA,PSUDRDA)) Q:PSUDRDA'>0  S PSUTOT=^(PSUDRDA) D
 . S PSULC=PSULC+1
 . S ^XTMP(PSUARSUB,"RECORDS",PSUDIVDA,PSULC)=$$RECORD(PSUDRDA,PSUDIVDA,PSUTOT)
 . S X=$G(^XTMP(PSUARSUB,"DRUG_TOTAL",PSUDRDA))
 . S ^XTMP(PSUARSUB,"DRUG_TOTAL",PSUDRDA)=X+PSUTOT
 Q
 ;
RECORD(PSUDRDA,PSUDIV,PSUTOT) ;EP Return record assembled
 ;
 ; @x@(Fld) holds the appropriate field values from the drug file 50
 ;
 N PSU,PSUP,PSUSEND,PSUDIVH
 I '$D(^XTMP(PSUARSUB,"PSUDRUG_DET",PSUDRDA)) D DRUG(PSUDRDA)
 S X="^XTMP(PSUARSUB,""PSUDRUG_DET"",PSUDRDA)"
 ; piece  = value  @X@(field from file 50)
 ;   Process for sender being division or site 
 S PSUSEND=PSUDIV,PSUDIVH=""
 I PSUDIV["_0H" S PSUSEND=$G(PSUSNDR),PSUDIVH="H"
 S PSU(2)=PSUSEND
 S PSU(3)=PSUDIVH
 S PSU(4)=$G(PSUMON)
 S PSU(5)=@X@(21)
 S PSU(6)=@X@(2)
 S PSU(7)=@X@(31)
 S PSU(8)=@X@(.01)
 S PSU(9)=@X@(51)
 S PSU(10)=@X@(99999.17) ;indicator for National Formulary
 S PSU(11)=@X@(99999.18) ;Indicator for National Formulary Restriction
 S PSU(12)=@X@(14.5)
 S PSU(13)=@X@(16)
 S PSU(14)=@X@(301)
 S PSU(15)=@X@(302)
 S PSU(16)=$G(PSUTOT)
 S PSU(17)=@X@(52)
 S PSU(18)=@X@(3)
 S PSU(19)=$G(PSUTDSP(PSUDIVDA,PSUDRDA))    ;Quantity Dispensed
 S PSU(20)=$G(PSUTRET(PSUDIVDA,PSUDRDA))    ;Quantity Returned
 S PSUP=0
 F  S PSUP=$O(PSU(PSUP)) Q:PSUP'>0  S PSU(PSUP)=$TR(PSU(PSUP),"^","'")
 S PSUP=0
 F  S PSUP=$O(PSU(PSUP)) Q:PSUP'>0  S $P(PSU,"^",PSUP)=PSU(PSUP)
 S PSU=PSU_"^"
 Q PSU
 ;
DRUG(PSUDRDA) ;EP assemble from file 50+ needed fields
 ;    PSUDRDA is da for the DRUG in file 50 from (58.52,.01)
 ;    Store the fields in ^XTMP(PSUARSUB,"PSUDRUG_DET",PSUDDA,Field)=value
 N PSUDRUG,PSUNDF
 D GETS^PSUTL(50,PSUDRDA,".01;2;14.5;15;16;20;21;22;25;31;51;301;302;52;3","PSUDRUG","I")
 ;    Move PSUDRUG(Field,"I") value to PSUDRUG(Field) nodes
 D MOVEI^PSUTL("PSUDRUG")
 ;
PROCESS ;Further process field values into their final values
 ;
 S PSUDRUG(51)=$$VAL^PSUTL(50,PSUDRDA,51)
 I PSUDRUG(31)="" S PSUDRUG(31)="No NDC"
 I PSUDRUG(21)="" S PSUDRUG(21)="Unknown VA Product Name"
 I PSUDRUG(.01)="" S PSUDRUG(.01)="Unknown Generic Name"
 S X=+PSUDRUG(301)
 S PSUDRUG(301)=$S(X=0:"03 or 04",X=1:"06 or 07",2:"17",3:"22",1:X)
 I PSUDRUG(52) S PSUDRUG(52)="N/F"
 ;
 ;    Process VA DRUG CLASS
 ;    Test for new NDF software s PSUNDF=1 if yes
 S PSUNDF=0
 I $$VERSION^XPDUTL("PSN")'<4 S PSUNDF=1
 ;
 ;    Process for National Formulary Indicator & Restrictions
 ;    Put into node 99999.17  for file(50.68,17)
 ;    Put into node 99999.18  for file(50.68,18)
 ;    test to see if file 50.68 exists (comes in with V4 of NDF)
 S PSUDRUG(99999.17)=""
 S PSUDRUG(99999.18)=""
 I 'PSUNDF G STORE
 ;    Process for National Formulary Indicator from VA Product Name file
 S PSUVPNDA=PSUDRUG(22)
 I PSUNDF S PSUDRUG(99999.17)=$$FORMI^PSNAPIS(PSUDRUG(20),PSUDRUG(22))
 ;    Process for National Formulary Restriction
 I PSUNDF S PSUDRUG(99999.18)=$$FORMR^PSNAPIS(PSUDRUG(20),PSUDRUG(22))
 K PSUNFR
 ;
STORE ;Store the processed values into ^TMP
 M ^XTMP(PSUARSUB,"PSUDRUG_DET",PSUDRDA)=PSUDRUG
 Q
 ;
REC ;EP Move PSUAR_RECORDS to PSUAREC)
 M ^XTMP(PSUARSUB,"PSUAREC")=^XTMP(PSUARSUB,"RECORDS",$J)
 Q

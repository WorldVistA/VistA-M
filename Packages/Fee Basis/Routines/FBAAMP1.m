FBAAMP1 ;AISC/CMR - MULTIPLE PAYMENT ENTRY ;7/6/2003
 ;;3.5;FEE BASIS;**4,55,61,77,139,158**;JAN 30, 1995;Build 94
 ;;Per VA Directive 6402, this routine should not be modified.
SUSP ;enter suspense data
 N FBX
 ;S DIR(0)="162.5,9",DIR("A")="Amount Suspended: $",DIR("B")=FBJ-FBK,DIR("?")="Press Return if $ "_(FBJ-FBK)_" is Amount Suspended, otherwise enter correct suspension amount" D ^DIR K DIR
 ;I $D(DIRUT) W !!,"Invalid entry, enter a number between .01 and 999999" G SUSP
 ;S FBAAAS=+Y
 ;I +Y'=(FBJ-FBK) S FBAAAS=+Y W ! S DIR("A")="Is $"_FBAAAS_" correct for Amount Suspended",DIR("B")="Yes",DIR(0)="Y" D ^DIR K DIR I $D(DIRUT) S FBAAOUT=1 Q
 ;G SUSP:'Y
 ;W !! S DIC="^FBAA(161.27,",DIC(0)="AEQ" D ^DIC I X["^" S FBAAOUT=1 Q
 ;S FBAASC=+Y
 S FBX=$$ADJ^FBUTL2(FBJ-FBK,.FBADJ,5,,,,.FBRRMK,1)
 I FBX=0 S FBAAOUT=1
 Q
SUSP1 I FBAASC=4 K ^TMP($J,"FBWP") W !!,"Suspension Description: " S DIC="^TMP($J,""FBWP"",",DWLW=80,DWPK=1 D EN^DIWE K DIC,DWLW,DWPK I '$O(^TMP($J,"FBWP",0)) W !!,*7,"Description of Suspense is required." G SUSP1
 Q
HCFA N ICDMDE S ICDMDE=10
 I FBMPDT<$$IMPDATE^LEXU("10D") S ICDMDE=9 N XX1 ;FB*3.5*139-JLG-ICD10 REMEDIATION
 F FBSI=28,30,31,32 S FBHCFA(FBSI)=""
 W ! F FBSI=28,30,31 D  Q:$G(FBAAOUT)
 . ;DEM/JLG/JAS FB*3.5*139-JLG-ICD10 REMEDIATION
 . I (FBSI=28)&(ICDMDE=10) F  D  Q:($G(FBAAOUT))!(XX1>0)
 . . S XX1=$$ASKICD10(FBMPDT) S:XX1=-3 FBAAOUT=1
 . . Q:XX1<0
 . . S FBHCFA(28)=XX1
 . . Q
 . Q:($G(FBAAOUT))!((ICDMDE=10)&(FBSI=28))
 . I (FBSI=28)&(ICDMDE=9) F  D  Q:($G(FBAAOUT))!(XX1>0)
 . . S XX1=$$ASKICD9(FBMPDT) S:XX1="^" FBAAOUT=1
 . . Q:XX1<0
 . . S FBHCFA(28)=XX1
 . . Q
 . Q:($G(FBAAOUT))!((ICDMDE=9)&(FBSI=28))
 . ;END 139
 . N ICDVDT S ICDVDT=$G(FBMPDT)
 . ;JAS - 08/23/13 - FB*3.5*139 (ICD10 REMEDIATION) - Modified next line for ICD-10.
 . F  S DIR(0)="P"_$S(FBSI=30:"^353.1",FBSI=31:"O^353.2")_":EMZ" D HCFA1 Q:$G(FBAAOUT)  Q
 Q:$G(FBAAOUT)
 W !
 I $$EXTPV^FBAAUTL5(FBPOV)'="01" D
 . S FBSI=32,DIR(0)="Y",DIR("A")="Service connected condition"
 . S DIR("?")="^W !!,""Respond by answering 'Yes' or 'No'."",! I $G(DFN) W !?1,*7,""Patient:  "",$$NAME^FBCHREQ2(DFN) D DIS^DGRPDB W !!"
 . D HCFA1 I $D(DIRUT) S FBAAOUT=1 Q
 Q
 ;
ASKICD9(FBINDT) ;JAS - 08/23/13 - FB*3.5*139 (ICD10 REMEDIATION)
 N FBDX,EDATE,XSP
 S EDATE=FBINDT ; edate is the date of interest for ICD9 diagnosis code lookup
 S XSP="ICD DIAGNOSIS"
 S FBDX=$$ENICD9^FBICD9(EDATE,XSP,"Y")
 K EDATE,FBINDT
 Q +FBDX
 ; 
ASKICD10(FBINDT) ; FB*3.5*139-JLG-ICD10 REMEDIATION
 N FBDX,EDATE,DA,DP
 S EDATE=FBINDT ; edate is the date of interest for ICD10 diagnosis code lookup
 S DA=DFN,DP=162.03 ; these must be defined prior to calling $$ASKICD10
 S FBDX=-1 S FBDX=$$ASKICD10^FBASF("PRIMARY DIAGNOSIS","","Y") ; returns -1 or ien of icd10 diagnosis code
 K EDATE,FBINDT
 Q FBDX
 ;
HCFA1 D ^DIR I $D(DTOUT)!($D(DUOUT)) S FBAAOUT=1 Q
 I Y'=-1 D
 .I DIR(0)["P" S FBHCFA(FBSI)=$P(Y,"^")
 .I DIR(0)="Y" S FBHCFA(FBSI)=$S(Y=1:"Y",1:"N")
 K DIR Q
DESC N FBJ
 I FBAASC=4,$D(^TMP($J,"FBWP",0)) S ^FBAAC(DFN,1,FBV,1,FBSDI,1,FBAACPI,1,0)=^(0) F FBJ=1:1 Q:'$D(^TMP($J,"FBWP",FBJ,0))  S ^FBAAC(DFN,1,FBV,1,FBSDI,1,FBAACPI,1,FBJ,0)=^(0)
 Q

PSSNDCUT2 ;AITC/PD - NDC Utilities 2;6/1/21
 ;;1.0;PHARMACY DATA MANAGEMENT;**252**;9/30/97;Build 17
 ;
 Q
 ;
 ; Allow user to edit LAST LOCAL NDC and LAST CMOP NDC
 ; of the NDC BY OUTPATIENT SITE subfile (#50.032)
 ; An audit trail of any edits will be captured
 ;
 ; Input: PSS50 - Drug File (#50) IEN
 ;
OPS(PSS50) ; Outpatient Site
OPS1 ;
 N DIR,DIRUT,NDC,NDC1PRE,NDC2PRE,NDCAR,NDCSITE,QUIT,X,Y
 S DIR(0)="PO^PSDRUG("_PSS50_",""NDCOP"",:QE"
 S DIR("A")="Select OUTPATIENT SITE"
 D ^DIR
 I $D(DIRUT)!(Y=-1) Q
 S NDCSITE=+Y
 ; Capture value of Local and CMOP NDCs before any edits
 S NDC1PRE=$$GET1^DIQ(50.032,NDCSITE_","_PSS50,1)
 S NDC2PRE=$$GET1^DIQ(50.032,NDCSITE_","_PSS50,2)
 ;
 ; Build array of valid NDCs
 D NDCARRAY
 I '$D(NDCAR) D  Q
 . W !!,"No valid NDCs found for "_$$GET1^DIQ(50,PSS50,.01)
 ;
 ; Last LOCAL NDC
 D ASKNDC(1)
 I $G(QUIT) Q
 I (NDC'=""),(NDC1PRE'=NDC) D FILENDC(1)
 ;
 ; Last CMOP NDC
 D ASKNDC(2)
 I $G(QUIT) D AUDIT Q
 I (NDC'=""),(NDC2PRE'=NDC) D FILENDC(2)
 ;
 D AUDIT
 G OPS1
 Q
 ;
 ; FLG: 1 = Last LOCAL NDC
 ;      2 = Last CMOP NDC
ASKNDC(FLG) ; Prompt for NDC
ASKNDC1 ; 
 ;
 N DEFLT,DELETE,DIR,DIRUT,PRMPT,X,Y
 S NDC=""
 ;
 I FLG=1 D
 . S PRMPT="LOCAL"
 . S DEFLT=NDC1PRE
 I FLG=2 D
 . S PRMPT="CMOP"
 . S DEFLT=NDC2PRE
 ;
 S DIR(0)="FAO^1:15"
 S DIR("A")="  LAST "_PRMPT_" NDC: "
 S DIR("B")=$G(DEFLT)
 S DIR("?")="^D NDCHLP^PSSNDCUT2"
 D ^DIR
 ;
 I $D(DIRUT),X'="@",Y'="" S QUIT=1 Q
 I $D(DIRUT),X'="@",Y="" S QUIT=0 Q
 ;
 I X="@" S DELETE=$$DELETE()
 I X="@",DELETE S NDC="@" Q
 I X="@",'DELETE G ASKNDC1
 ;
 I Y'?.N S NDC=Y I '$D(NDCAR(1,NDC)) D NDCHLP2 G ASKNDC1
 I Y?.N D  I NDC="" D NDCHLP2 G ASKNDC1
 . I $L(Y)=11 S NDC=$$NDCFMT^PSSNDCUT(Y) D  Q
 . . I NDC'="",'$D(NDCAR(1,NDC)) S NDC=""
 . S NDC=$G(NDCAR(2,+Y))
 W "  ",NDC
 Q
 ;
FILENDC(FLG) ; Save NDC
 ;
 N ARRAY
 S ARRAY(50.032,NDCSITE_","_PSS50_",",FLG)=NDC
 D FILE^DIE("","ARRAY")
 Q
 ;
 ; Build array of valid NDCs for the specific drug selected.
 ; Valid values include:
 ; Field 31 of DRUG file (#50) - NDC
 ; Field 2 of SYNONYM subfile (#50.1) - NDC CODE
 ; Fields 1 and 2 of NDC BY OUTPATIENT SITE subfile (#50.032)
 ;    1 = LAST LOCAL NDC
 ;    2 = LAST CMOP NDC
NDCARRAY ;
 K NDCAR
 N CNT,NDC,NDCI
 ; Field 31 - NDC
 S NDC=$$NDCFMT^PSSNDCUT($$GET1^DIQ(50,PSS50,31))
 I NDC'="" S NDCAR(1,NDC)=""
 ; Loop through SYNONYM multiple
 S NDCI=0
 F  S NDCI=$O(^PSDRUG(PSS50,1,NDCI)) Q:'NDCI  D
 . ; Field 2 - NDC CODE
 . S NDC=$$NDCFMT^PSSNDCUT($$GET1^DIQ(50.1,NDCI_","_PSS50_",",2))
 . I NDC'="" S NDCAR(1,NDC)=""
 ; Loop through NDC BY OUTPATIENT SITE multiple
 S NDCI=0
 F  S NDCI=$O(^PSDRUG(PSS50,"NDCOP",NDCI)) Q:'NDCI  D
 . ; Field 1 - LAST LOCAL NDC
 . S NDC=$$NDCFMT^PSSNDCUT($$GET1^DIQ(50.032,NDCI_","_PSS50_",",1))
 . I NDC'="" S NDCAR(1,NDC)=""
 . ; Field 2 - LAST CMOP NDC
 . S NDC=$$NDCFMT^PSSNDCUT($$GET1^DIQ(50.032,NDCI_","_PSS50_",",2))
 . I NDC'="" S NDCAR(1,NDC)=""
 ;
 S CNT=0
 S NDC=""
 F  S NDC=$O(NDCAR(1,NDC)) Q:NDC=""  D
 . S CNT=CNT+1
 . S NDCAR(1,NDC)=CNT
 . S NDCAR(2,CNT)=NDC
 ;
 Q
 ;
 ; Capture Date/Time and User of the edit
 ; Audit record will show before/after of each field
 ; If neither LAST LOCAL NDC or LAST CMOP NDC did not change, an
 ; audit record will not be created
AUDIT ; Audit Trail
 N FILE,IEN,NDC1POST,NDC2POST,NDCAUD,NDCIEN,PSSNO2,PSSNOW
 K NDCAR
 ;
 S NDC1POST=$$GET1^DIQ(50.032,NDCSITE_","_PSS50,1)
 S NDC2POST=$$GET1^DIQ(50.032,NDCSITE_","_PSS50,2)
 ;
 ; No changes to LOCAL or CMOP NDC - Audit subfile entry not necessary
 I (NDC1PRE=NDC1POST)&(NDC2PRE=NDC2POST) Q
 ;
 ; Create NDC BY OUTPATIENT SITE AUDIT subfile entry
 S PSSNOW=$$NOW^XLFDT
 S FILE=50.0321
 S NDCAR(1,FILE,"+1,"_NDCSITE_","_PSS50_",",.01)=PSSNOW
 D UPDATE^DIE("","NDCAR(1)")
 K NDCAR
 ;
 I NDC1PRE="" S NDC1PRE="<blank>"
 I NDC1POST="" S NDC1POST="<blank>"
 I NDC2PRE="" S NDC2PRE="<blank>"
 I NDC2POST="" S NDC2POST="<blank>"
 ;
 ; Populate fields in the new subfile entry
 S NDCAUD=$O(^PSDRUG(PSS50,"NDCOP",NDCSITE,1,"B",PSSNOW,""))
 S NDCIEN=NDCAUD_","_NDCSITE_","_PSS50_","
 S NDCAR(FILE,NDCIEN,1)=DUZ
 ; Only populate fields for which the NDC value changed
 I NDC1PRE'=NDC1POST D
 . S NDCAR(FILE,NDCIEN,2)=NDC1PRE
 . S NDCAR(FILE,NDCIEN,3)=NDC1POST
 I NDC2PRE'=NDC2POST D
 . S NDCAR(FILE,NDCIEN,4)=NDC2PRE
 . S NDCAR(FILE,NDCIEN,5)=NDC2POST
 D FILE^DIE(,"NDCAR")
 ;
 K NDCAR
 ;
 Q
 ;
NDCHLP2 ; Invalid NDC entry
 ;
 W !!,"NDC is not valid."
 ;
NDCHLP ; Display list of valid NDCs
 ;
 S PSSI=""
 W !,"Select from one of the following valid NDC(s) or enter ^ to exit:",!
 F  S PSSI=$O(NDCAR(2,PSSI)) Q:PSSI=""  D
 . W !?3,PSSI_" - "_NDCAR(2,PSSI)
 Q
 ;
DELETE() ; Confirm Deletion of NDC
 ;
 N DIR,DIRUT,X,Y
 S DIR(0)="Y"
 S DIR("A")="  SURE YOU WANT TO DELETE"
 S DIR("B")="YES"
 D ^DIR
 I $D(DIRUT) Q 0
 Q Y

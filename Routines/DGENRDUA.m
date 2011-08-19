DGENRDUA ;ALB/TDM - ENROLLMENT RATED DISABILITY UPLOAD AUDIT file (#390) APIs ; 11/14/07 3:11pm
 ;;5.3;REGISTRATION;**763**;Aug 13,1993;Build 9
 ;
 Q
 ;
RDCHG(DFN,FDT,TDT) ; API to return Rated Disability changes for Veterans
 ;****************************************************************
 ; NOTE:  It is the responsibility of the calling application to
 ;        kill the ^TMP($J,"RDCHG") global reference prior to
 ;        calling this api and also after the calling routine is
 ;        done with the global reference.
 ;****************************************************************
 ;  Input
 ;    DFN    - Patients DFN (Optional, If not passed return all vets)
 ;    FDT    - Beginning Date Range (Optional)
 ;    TDT    - Ending Date Range (Optional)
 ;
 ;  Output
 ;    DFN = Pointer to PATIENT file (#2)
 ;    OCC = Single occurrence of a Rated Disability change for Veteran
 ;
 ;    ^TMP($J,"RDCHG",DFN,OCC)=P1^P2^P3^...etc
 ;       Where:  P1 = DATE/TIME OF CHANGE (fileman format)
 ;               P2 = RATED DISABILITIES CODE (external value)
 ;               P3 = RATED DISABILITIES NAME (external value)
 ;               P4 = DISABILITY % (numeric value)
 ;               P5 = EXTREMITY AFFECTED (internal code)
 ;               P6 = EXTREMITY AFFECTED (external code)
 ;               P7 = ORIGINAL EFFECTIVE DATE (fileman format)
 ;               P8 = CURRENT EFFECTIVE DATE (fileman format)
 ;
 N XDT,IEN
 K ^TMP($J,"RDCHG")
 S DFN=$G(DFN),IEN=""
 S:$G(FDT)="" FDT=$$FMADD^XLFDT(DT,-365)
 S:$G(TDT)="" TDT=DT
 S XDT=$$FMADD^XLFDT(FDT,-1),XDT=XDT_".999999"
 S TDT=$$FMADD^XLFDT(TDT,1),TDT=TDT_".000001"
 I DFN D  Q
 .F  S XDT=$O(^DGRDUA(390,"APTDATE",DFN,XDT)) Q:((XDT<1)!(XDT>TDT))  D
 ..F  S IEN=$O(^DGRDUA(390,"APTDATE",DFN,XDT,IEN)) Q:IEN=""  D
 ...D BLDTMP(IEN)
 I 'DFN D  Q
 .F  S XDT=$O(^DGRDUA(390,"ADATEPT",XDT)) Q:((XDT<1)!(XDT>TDT))  D
 ..F  S DFN=$O(^DGRDUA(390,"ADATEPT",XDT,DFN)) Q:DFN=""  D
 ...F  S IEN=$O(^DGRDUA(390,"ADATEPT",XDT,DFN,IEN)) Q:IEN=""  D
 ....D BLDTMP(IEN)
 Q
 ;
BLDTMP(IEN) ; Build ^TMP global containing data for calling routine.
 Q:$G(IEN)=""
 N RDFN,OCC,DISCOD,RETURN,RETARY
 D GETS^DIQ(390,IEN,"*","IE","RETARY")
 S RDFN=$G(RETARY(390,IEN_",",2,"I")) Q:RDFN=""
 S OCC=$O(^TMP($J,"RDCHG",RDFN,""),-1)+1
 S DISCOD=$G(RETARY(390,IEN_",",3,"I"))_","
 S RETURN=$G(RETARY(390,IEN_",",.01,"I"))
 S $P(RETURN,U,2)=$$GET1^DIQ(31,DISCOD,.001)
 S $P(RETURN,U,3)=$$GET1^DIQ(31,DISCOD,.01)
 S $P(RETURN,U,4)=$G(RETARY(390,IEN_",",4,"E"))
 S $P(RETURN,U,5)=$G(RETARY(390,IEN_",",5,"I"))
 S $P(RETURN,U,6)=$G(RETARY(390,IEN_",",5,"E"))
 S $P(RETURN,U,7)=$G(RETARY(390,IEN_",",6,"I"))
 S $P(RETURN,U,8)=$G(RETARY(390,IEN_",",7,"I"))
 S ^TMP($J,"RDCHG",RDFN,OCC)=RETURN
 Q
 ;
PURGE ; Purge entries in file #390 that are over 365 days old.
 N PDT,DA,EDT,DIK
 S (PDT,DA)=0,EDT=$$FMADD^XLFDT(DT,-366)_".999999",DIK="^DGRDUA(390,"
 F  S PDT=$O(^DGRDUA(390,"B",PDT)) Q:((PDT="")!(PDT>EDT))  D
 .F  S DA=$O(^DGRDUA(390,"B",PDT,DA)) Q:DA=""  D
 ..D ^DIK
 Q

PSUHL ;BIR/RDC - DYNAMIC CAPTURE OF PATIENT DEMOGRAPHICS ;05 MAR 2004
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;**5**;MARCH, 2005;Build 22
 ;
 ;DBIA's
 ; Reference to file 55      supported by DBIA 3502
 ; Reference to file 2 (for protocol PSU PATIENT DEMOGRAPHIC CHANGE)
 ;                           supported by DBIA 3344
 ;
CHNG ; THIS TAG WILL EXECUTE UPON ANY MODIFICATION TO THE PATIENT FILE #2
 ; CHANGES TO ANY FIELDS OTHER THAN THOSE INHERANT TO THE 
 ; PATIENT DEMOGRAPHIC EXTRACT (^PSUDEM1) WILL BE IGNORED
 ; SUCCESSFUL EXECUTION OF THIS TAG WILL RESULT IN THE DATE AND
 ; DFN BEING LOGGED IN THE PBM PATIENT DEMOGRAPHICS file #59.9
 ;
 N FIELD
 ;                               ; ** loop thru pertinent fields **
 ;
 I DGFILE=2 F FIELD=.351,.03,.02,.361,.14,27.01,.09,991.01,.104,.097,2.02,2.06 I $G(DGFIELD)=FIELD D LOGDFN(DGDA) Q      ; flag if one of our fields changes
 I DGFILE=2.02,$G(DGFIELD)=.01 D LOGDFN(DGDA(1))
 I DGFILE=2.06,$G(DGFIELD)=.01 D LOGDFN(DGDA(1))
 ;
 Q
 ;
LOGDFN(DFN)            ; This tag will log the date & dfn to file #59.9
 ;
 Q:+$G(DFN)=0                    ; no patient pointer to log ***
 Q:$D(^PSUDEM("C",DFN,DT))       ; patient already logged for today
 N PSSDA
 S PSSDA(59.9,"+1,",.01)=DT
 S PSSDA(59.9,"+1,",.02)=DFN
 D UPDATE^DIE("","PSSDA")
 Q
 ; 
PHARM ;
 ; THIS TAG IS TRIGGERED BY A CROSS REFERENCE ON THE 
 ; PHARMACY PATIENT FILE (#55); FIRST SERVICE DATE (#.07)
 ;
 D LOGDFN(DA)              ;log change of patient demographics
 Q
 ;
CLEANUP ;  THIS TAG CLEANS UP DATA IN ^PSUDEM >75 DAYS
 ;
 N MIN,DAY,DFN,DIK,X1,X2,X
 S X1=DT,X2=-75
 D C^%DTC S MIN=X                                      ;today-75 days
 S DIK="^PSUDEM("                                 ;file root to kill
 S DAY=""
 F  S DAY=$O(^PSUDEM("B",DAY)) Q:DAY=""  Q:DAY>MIN  D  ;loop thru days
 . S DFN=""                                       ;older than 75 days
 . F  S DFN=$O(^PSUDEM("B",DAY,DFN)) Q:DFN=""  D  ;get the dfn
 .. S DA=DFN D ^DIK                     ; and have Fileman kill the dfn
 ;
 Q
 ;

DGHBPUTL ;ALB/PWC - Health Benefit Plan Utility Routine ;5/22/13 11:50am
 ;;5.3;Registration;**871**;08/13/93;Build 84
 ;
 ;
GETHBP(DFN) ;Return all records in HBP sub-file #25.01 in HBP array
 ; returns current information in HBP("CUR",PLAN NAME)=ENTIRE DATA FROM 25.01 DA
 ; returns current information in HBP("CUR",PLAN NAME,"IEN")=PLAN CODE
 ; returns history information in HBP("HIS",DA,DTTM)=PLAN NAME^ENTIRE DATA FROM 25.02 DA
 I '$G(DFN) Q
 N SDT,HBDATA,HBCODE,HBNAME K HBP("CUR"),HBP("HIS")
 S SDT=0,(HBDATA,HBCODE)=""
 F  S SDT=$O(^DPT(DFN,"HBP",SDT)) Q:SDT<1  D
 . S HBDATA=$G(^DPT(DFN,"HBP",SDT,0)),HBCODE=$P(HBDATA,"^",1)
 . S HBNAME=$P($G(^DGHBP(25.11,HBCODE,0)),"^",1) Q:HBNAME=""
 . S HBP("CUR",HBNAME)=HBDATA
 . S HBP("CUR",HBNAME,"IEN")=HBCODE
HBP1 S SDT=0,(HBDATA,HBCODE)=""
 F  S SDT=$O(^DPT(DFN,"HBP1",SDT)) Q:SDT<1  D
 . S HBDATA=$G(^DPT(DFN,"HBP1",SDT,0)),HBCODE=$P(HBDATA,"^",2)
 . S HBNAME=$P($G(^DGHBP(25.11,HBCODE,0)),"^",1) Q:HBNAME=""
 . S HBP("HIS",SDT,$P(HBDATA,"^",1))=HBNAME_"^"_$P(HBDATA,"^",2,99)
 Q
 ;
GETDETL(HBPNUM) ;Return detail for each HBP in an array for display purposes
 I $G(HBPNUM)="" Q 
 N DATA,CNT,LAST K HBP("DETAIL")
 S HBP("DETAIL",0)=$G(^DGHBP(25.11,HBPNUM,2,0))
 I HBP("DETAIL",0)="" S HBP("DETAIL",0)="0^No Detail Available." Q
 S LAST=$P(HBP("DETAIL",0),"^",4)
 M DATA=^DGHBP(25.11,HBPNUM,2)
 F CNT=1:1:LAST S HBP("DETAIL",HBPNUM,CNT)=DATA(CNT,0)
 Q
 ;
GETPLAN ; Return all Health Benefit Plans from file #25.11 in array
 N HBPLAN,HBIEN,PLAN S HBPLAN="" K HBP("PLAN")
 F  S HBPLAN=$O(^DGHBP(25.11,"B",HBPLAN)) Q:HBPLAN=""  D
 . S HBIEN=$O(^DGHBP(25.11,"B",HBPLAN,0)) Q:HBIEN=""  D
 . S PLAN=$P(^DGHBP(25.11,HBIEN,0),"^",1)
 . S HBP("PLAN",PLAN)=HBIEN
 Q
 ;
SETPLAN(DFN,PLAN,SITE) ;Set Health Benefit Plan and History into file 25.01 and 25.02 for input DFN
 ; Current data plans will also be filed into the history so that history will contain all
 ; additions and deletions for the patient
 ;
 N DATETIME,DGENDA,DATA,SUCCESS
 ; Gather and save DATETIME for both files
 D NOW^%DTC S DATETIME=%
 S DGENDA(1)=DFN
 S DATA(.01)=PLAN                                            ;Current HBP Code
 S DATA(1)=DATETIME                                          ;Assigned Date/Time
 S DATA(2)=DUZ                                               ;Assigned Entered By
 S DATA(3)=$S($G(SITE)="":$P($$SITE^VASITE(),"^",1),1:SITE)  ;Assigned Entered Site
 S DATA(4)=$S($G(SITE)="":"V",1:"E")                         ;Current Source
 ; Update Current Health Benefit Plan into DB
 S SUCCESS=$$ADD^DGENDBS(2.2511,.DGENDA,.DATA)               ;DG*5.3*871 modified 25.01 to 2.511
 I SUCCESS D EVENT^IVMPLOG(DFN)                              ;trigger for HL7
 ;
 ; Reset Data for History - DGENDA remains unchanged
 N DGENDA,DATA,SUCCESS
 S DGENDA(1)=DFN
 S DATA(.01)=DATETIME                                        ;History HBP Date/Time
 S DATA(1)=PLAN                                              ;History HBP Code
 S DATA(2)=DUZ                                               ;Assigned Entered By
 S DATA(3)=$S($G(SITE)="":$P($$SITE^VASITE(),"^",1),1:SITE)  ;Assigned Entered Site
 S DATA(4)="A"                                               ;History Assignment
 S DATA(5)=$S($G(SITE)="":"V",1:"E")                         ;History Source
 ; Update History into DB
 S SUCCESS=$$ADD^DGENDBS(2.2512,.DGENDA,.DATA)               ;DG*5.3*871 modified 25.02 to 2.512
 Q
 ;
DELPLAN(DFN,PLAN,SITE) ;Delete Health Benefit Plan and set History into file 25.01 and 25.02 for input DFN
 N DATETIME,DGENDA,DA,DIK,DATA,SUCCESS
 ; Gather and save DATETIME for both files
 D NOW^%DTC S DATETIME=%
 S (DGENDA(1),DA(1))=DFN
 S DA=$O(^DPT(DA(1),"HBP","B",PLAN,""))
 ; Delete Health Benefit Plan from DB
 S DIK="^DPT("_DA(1)_","_"""HBP"""_","
 D ^DIK K DIK
 ;
 ; Reset Data for History - DGENDA remains unchanged
 S DATA(.01)=DATETIME                                        ;History HBP Date/Time
 S DATA(1)=PLAN                                              ;History HBP Code
 S DATA(2)=DUZ                                               ;History Entered By
 S DATA(3)=$S($G(SITE)="":$P($$SITE^VASITE(),"^",1),1:SITE)  ;History Entered Site
 S DATA(4)="U"                                               ;History Assignment - CCR 13614 - Change D to U
 S DATA(5)=$S($G(SITE)="":"V",1:"E")                         ;History Source
 ; Update History into DB
 ; DG*5.3*871
 S SUCCESS=$$ADD^DGENDBS(2.2512,.DGENDA,.DATA)               ;DG*5.3*871 modified 25.02 to 2.512
 Q
 ;
HL7UPD(DFN,DGHBP,MSHDATE) ; Store HL7 Health Benefit Plan (HBP) data in PATIENT file (#2)
 N OCC,HBPNOD,HL7DATA,ADDHBP
 ;
 ; Build an array of HBP codes to be added or retained in VistA - saving the date/time for storage
 S OCC=0 F  S OCC=$O(DGHBP(OCC)) Q:OCC=""  S ADDHBP($P(DGHBP(OCC),U,1))=""
 ;
 S OCC=0 F  S OCC=$O(^DPT(DFN,"HBP",OCC)) Q:OCC<1  D
 . S HBPNOD=$G(^DPT(DFN,"HBP",OCC,0))
 . ; If HBP code exists on Z11 and VistA, Source to "E", and do not delete or store history
 . I $D(ADDHBP($P(HBPNOD,U,1))) S $P(^DPT(DFN,"HBP",OCC,0),U,5)="E" Q
 . ; Change Date/Time for deletion History to MSHDATE
 . I $G(MSHDATE)'="" S $P(HBPNOD,U,2)=$$FMDATE^HLFNC(MSHDATE)
 . D STORHIS(DFN,HBPNOD,"U")                                 ;CCR 13614 - Change D to U (delete to unassigned)            
 . D DELCUR(DFN,$P(HBPNOD,U))
 ;
 ; Add Z11 HBP data to PATIENT file (#2)
 I $D(DGHBP) D
 . S OCC=0 F  S OCC=$O(DGHBP(OCC)) Q:OCC=""  D
 . . S HL7DATA=DGHBP(OCC)
 . . ; Quit if the HBP Code is already set for patient (would have been set by loop above)
 . . I $D(^DPT(DFN,"HBP","B",$P(HL7DATA,U,1))) Q
 . . D STORCUR(DFN,HL7DATA)
 . . D STORHIS(DFN,HL7DATA,"A")
 Q
 ;
STORCUR(DFN,STORDATA) ; Store Current data
 N DGENDA,DATA,SUCCESS
 S DGENDA(1)=DFN                               ;Patient DFN
 S DATA(.01)=$P(STORDATA,U)                    ;Current HBP Code
 S DATA(1)=$P(STORDATA,U,2)                    ;Assigned Date/Time
 S DATA(2)=$P(STORDATA,U,3)                    ;Assigned Entered By
 S DATA(3)=$P(STORDATA,U,4)                    ;Assigned Entered Site
 S DATA(4)=$P(STORDATA,U,5)                    ;Current Source
 S SUCCESS=$$ADD^DGENDBS(2.2511,.DGENDA,.DATA) ;DG*5.3*871 modified 25.01 to 2.511
 Q
 ;
STORHIS(DFN,STORDATA,ACTION) ; Store History data
 N DGENDA,DATA,SUCCESS
 S DGENDA(1)=DFN                               ;Patient DFN
 S DATA(.01)=$P(STORDATA,U,2)                  ;History HBP Date/Time
 S DATA(1)=$P(STORDATA,U)                      ;History HBP Code
 S DATA(2)=$P(STORDATA,U,3)                    ;History Entered By
 S DATA(3)=$P(STORDATA,U,4)                    ;History Entered Site
 S DATA(4)=$G(ACTION)                          ;History Assignment
 S DATA(5)=$P(STORDATA,U,5)                    ;History Source
 S SUCCESS=$$ADD^DGENDBS(2.2512,.DGENDA,.DATA) ;DG*5.3*871 modified 25.02 to 2.512
 Q
 ;
DELCUR(DFN,HBPCODE) ; Delete entry from Current data
 N DGENDA,DA,DIK
 S (DGENDA(1),DA(1))=DFN
 S DA=$O(^DPT(DA(1),"HBP","B",HBPCODE,""))
 S DIK="^DPT("_DA(1)_","_"""HBP"""_","
 D ^DIK K DIK
 Q

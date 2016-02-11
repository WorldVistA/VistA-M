ECUTL1 ;ALB/ESD - Event Capture Classification Utilities ;7/30/15  15:44
 ;;2.0;EVENT CAPTURE;**10,13,17,42,54,76,107,122,126,130**;8 May 96;Build 1
 ;
ASKCLASS(DFN,ECANS,ERR,ECTOPCE,ECPATST,ECHDA) ;  Ask classification questions
 ; (Agent Orange, Ionizing Radiation, Environmental Contaminants/South 
 ; West Asia Conditions, Service Connected, Military Sexual Trauma, 
 ; Head/Neck Cancer, Combat Veteran, Project 112/SHAD)
 ;
 ;   Input:
 ;      DFN     - IEN of Patient file (#2)
 ;      ECTOPCE - Variable which indicates if DSS Unit is sending to PCE
 ;      ECPATST - Inpatient/outpatient status
 ;      ECHDA   - IEN in file #721 if editing existing record [optional]
 ;
 ;  Output:
 ;      ECANS - array subscripted by classification abbreviation
 ;              (i.e. ECANS("AO")) and passed by reference containing:
 ;                 field # of class from EC Patient file (#721)^answer
 ;      ERR   - Error indicator if user uparrows or times out (set to 1)
 ;
 ;      Function value - 1 if successful, 0 otherwise
 ;
 N ANS,DIR,ECCL,ECCLFLD,SUCCESS,ECVST,ECVSTDT,ECPXB,PXBDATA,ECNT,ECOLD,ECPIECE,ECXX
 S (ECANS,ECCL)=""
 S ERR=0
 S SUCCESS=1
 S DFN=+$G(DFN)
 S ECTOPCE=$G(ECTOPCE)
 I ECTOPCE["~" S ECTOPCE=$P(ECTOPCE,"~",2)
 S ECPATST=$G(ECPATST)
 ;- Drop out if invalid condition found OR if DSS Unit not sending to
 ;  PCE or patient is an inpatient
 I ('DFN)!(ECTOPCE="")!(ECPATST="")!(ECTOPCE="N")!(ECPATST="I") S SUCCESS=0 Q SUCCESS
 D NOW^%DTC S ECVSTDT=$S(+$G(ECDT):ECDT,1:%),ECVST="" ;modified to use event date;JAM/11/24/03
 ;- If editing an existing record, get visit data & display classification
 I $G(ECHDA) D
 .S ECVSTDT=$P($G(^ECH(ECHDA,0)),U,3)
 .S ECVST=$P($G(^ECH(ECHDA,0)),U,21)
 .F ECCL="AO","IR","EC","SC","MST","HNC","CV","SHAD" D
 ..S ECPIECE=$S(ECCL="AO":3,ECCL="IR":4,ECCL="EC":5,ECCL="SC":6,ECCL="MST":9,ECCL="HNC":10,ECCL="CV":11,1:12)
 ..S ECCLFLD=$P("^^Agent Orange^Ionizing Radiation^South West Asia Conditions^Service Connected^^^Military Sexual Trauma^Head/Neck Cancer^Combat Veteran^Project 112/SHAD","^",ECPIECE)
 ..S ECXX=$P($G(^ECH(ECHDA,"P")),U,ECPIECE),ECXX=$S(ECXX="Y":"YES",ECXX="N":"NO",1:"")
 ..I ECXX]"" S ECOLD(ECCL)=ECCLFLD_": "_ECXX
 .I $D(ECOLD) D
 ..W !,"*** Current encounter classification ***",!
 ..F ECCL="SC","CV","AO","IR","EC","MST","HNC","SHAD" D
 ...I $D(ECOLD(ECCL)) W !?4,ECOLD(ECCL)
 ;- Ask user classification question
 D CLASS^PXBAPI21("",DFN,ECVSTDT,1,ECVST) W !
 ;- Check error; exit if error condition
 I $D(PXBDATA("ERR")) D  I ERR S SUCCESS=0 Q SUCCESS
 .F ECPXB=1:1:4 I $D(PXBDATA("ERR",ECPXB)) D
 ..I (PXBDATA("ERR",ECPXB)=1)!(PXBDATA("ERR",ECPXB)=4) S ERR=1
 ;- Otherwise, continue to setup ecans array, i.e., new classification data
 F ECCL="AO","IR","SC","EC","MST","HNC","CV","SHAD" D
 .S ECCLFLD=$S(ECCL="AO":21,ECCL="IR":22,ECCL="EC":23,ECCL="SC":24,ECCL="MST":35,ECCL="HNC":39,ECCL="CV":40,1:41)
 .S ECPXB=$S(ECCL="AO":1,ECCL="IR":2,ECCL="EC":4,ECCL="SC":3,ECCL="MST":5,ECCL="CV":7,ECCL="SHAD":8,1:6)
 .S ANS=$P($G(PXBDATA(ECPXB)),U,2),ANS=$S(ANS=1:"Y",ANS=0:"N",1:"")
 .S ECANS(ECCL)=ECCLFLD_"^"_ANS
 ;- Delete old data if it exists
 I $G(ECHDA) D DELCLASS(ECHDA)
 Q SUCCESS
 ;
 ;
EDCLASS(ECIEN,ECANS) ;  Edit classifications fields in EC Patient
 ;                  file (#721)
 ;
 ;   Input:
 ;      ECIEN - EC Patient record (#721) IEN
 ;      ECANS - Array of answers to classification questions asked
 ;
 ;  Output:
 ;      Classification fields 21,22,23,24,35,39,40,41 edited in file #721
 ;
 N DA,DIE,DR,ECCL
 S (DR,ECCL)=""
 ;
 ;- Drops out if invalid condition found
 D
 . I '$G(ECIEN)!('$D(ECANS)) Q
 . ;
 . ;- Lock main node
 . I '$$LOCK(ECIEN) Q
 . S DA=ECIEN
 . S DIE="^ECH("
 . ;
 . ;- Edit classification fields (AO, IR, EC, SC, MST, HNC, CV, SHAD)
 . F  S ECCL=$O(ECANS(ECCL)) Q:ECCL=""  S DR=DR_+$P($G(ECANS(ECCL)),"^")_"////"_$P($G(ECANS(ECCL)),"^",2)_";"
 . ;
 . ;- Remove last ";" from DR string before editing
 . S DR=$E(DR,1,($L(DR)-1))
 . D ^DIE
 ;
 ;- Unlock main node
 D UNLOCK(ECIEN)
 ;
 Q
 ;
 ;
SETCLASS(ECANS) ;  Set answers to classification questions in EC variables
 ;          (used in EC data entry options when filing EC Patient record)
 ;
 ;   Input:
 ;      ECANS - array of answers to class questions asked containing:
 ;                 field number of class ques from file #721^answer
 ;
 ;  Output:
 ;      EC classification var - ECAO,ECIR,ECZEC,ECSC,ECMST,ECHNC,ECCV,
 ;                              ECSHAD
 ;
 N ECCL,ECCLFLD
 S (ECCL,ECAO,ECIR,ECZEC,ECSC,ECMST,ECHNC,ECCV,ECSHAD)=""
 ;
 ;- Drops out if invalid condition found
 D
 . ;
 . ;- If array containing class flds^answers is not created, exit
 . I '$D(ECANS) Q
 . F  S ECCL=$O(ECANS(ECCL)) Q:ECCL=""  D
 .. ;
 .. ;- Get field number of classification
 .. S ECCLFLD=+$P($G(ECANS(ECCL)),"^")
 .. ;
 .. ;- Agent Orange variable
 .. S:ECCLFLD=21 ECAO=$P(ECANS(ECCL),"^",2)
 .. ;
 .. ;- Ionizing Radiation variable
 .. S:ECCLFLD=22 ECIR=$P(ECANS(ECCL),"^",2)
 .. ;
 .. ;- Environmental Contaminants/South West Asia Conditions variable
 .. S:ECCLFLD=23 ECZEC=$P(ECANS(ECCL),"^",2)
 .. ;
 .. ;- Service Connected variable
 .. S:ECCLFLD=24 ECSC=$P(ECANS(ECCL),"^",2)
 .. ;
 .. ;- Military Sexual Trauma variable
 .. S:ECCLFLD=35 ECMST=$P(ECANS(ECCL),"^",2)
 .. ;
 .. ;- Head/Neck Cancer
 .. S:ECCLFLD=39 ECHNC=$P(ECANS(ECCL),"^",2)
 .. ;
 .. ;- Combat Veteran
 .. S:ECCLFLD=40 ECCV=$P(ECANS(ECCL),"^",2)
 .. ;
 .. ;- Project 112/SHAD (Shipboard Hazard and Defense)
 .. S:ECCLFLD=41 ECSHAD=$P(ECANS(ECCL),"^",2)
 Q
 ;
 ;
DELCLASS(ECIEN) ;  Delete classification fields in EC Patient file (#721)
 ;
 ;   Input:
 ;      ECIEN - EC Patient record (#721) IEN
 ;
 ;  Output:
 ;      Classification fields 21,22,23,24,35,39,40,41 deleted in file#721
 ;
 N DA,DIE,DR,ECCL
 S DR=""
 ;
 ;- Drops out if invalid condition found
 D
 . I '$G(ECIEN) Q
 . ;
 . ;- Lock main node
 . I '$$LOCK(ECIEN) Q
 . S DA=ECIEN
 . S DIE="^ECH("
 . ;
 . ;- Delete classification fields (AO, IR, EC, SC, MST, HNC, CV, SHAD)
 . F ECCL=21:1:24,35,39,40,41 S DR=DR_ECCL_"////@;"
 . ;
 . ;- Remove last ";" from DR string before editing
 . S DR=$E(DR,1,($L(DR)-1))
 . D ^DIE
 ;
 ;- Unlock main node
 D UNLOCK(ECIEN)
 ;
 Q
 ;
 ;
LOCK(ECIEN) ;  Lock EC Patient record
 ;
 ;   Input:
 ;      ECIEN - EC Patient record IEN
 ;
 ;  Output:
 ;      Function Value - 1 if record can be locked, 0 otherwise
 ;
 I $G(ECIEN) L +^ECH(ECIEN):5
 Q $T
 ;
 ;
UNLOCK(ECIEN) ;  Unlock EC Patient record
 ;
 ;   Input:
 ;      ECIEN - EC Patient record IEN
 ;
 ;  Output:
 ;      EC Patient record unlocked
 ;
 I $G(ECIEN) L -^ECH(ECIEN)
 Q
RCNTVST(RESULT,ECARY) ;126 Changed parameter name from DFN to ECARY
 ;
 ;This call uses the Patient and Visit file to return a list of recent
 ;visits. It returns the most recent 20 visits using both files but does 
 ;not return future visits from the Patient file.  It also filters out 
 ;canceled, rescheduled or no-show appts.  For the Patient file it uses 
 ;a start date of "" and an end date of "NOW". For the selected visit
 ;call, it only passes in and uses the DFN.
 ;
 ;126 Updated code so that it filters visit by selected location.
 ;Only visits/appts with clinics in the location will be shown.
 ;API 1905
 ;Calls    
 ;  SELECTED^VSIT(DFN,SDT,EDT,HOSLOC,ENCTPE,NNCTPE,SRVCAT,NSRVCAT,LASTN) 
 ;  See API for detailed documentation
 ;
 ;API 3859
 ;Calls    GETAPPT^SDAMA201(DFN,SDFIELDS,SDAPSTAT,SDT,EDT,SDCNT)
 ;         See API for detailed documentation
 ;
 ;IA 10040 - This is a supported IA and is used to filter/screen
 ;           non clinics visits from being included in API 1905
 ;           not needed in 3859 as it contains a filter for clinics
 ;
 N ARR,CNT,DATE,NUM,PARAMS,P1,P1DT,P2,PDT,VDT,VIEN,X,X1,X2,Y,SDRESULT,DFN,LOC ;122,126
 S DFN=$P(ECARY,U),LOC=$P(ECARY,U,2) ;126
 D NOW^%DTC S DATE=%,Y=DATE
 S VDT=3050101
 S X1=DT,X2=(-15) D C^%DTC S PDT=X    ;get appts within last 15 days
 S RESULT(0)=0
 I '$G(DFN) Q
 K ^TMP("VSIT",$J)
 K ^TMP($J,"SDAMA201","GETAPPT")
 D SELECTED^VSIT(DFN,VDT,"","","","","","HE",30) ;126 Changed call to filter out hospitalization and event (historical) categories
 D GETAPPT^SDAMA201(DFN,"1;2","R;NT",PDT,DATE,.SDRESULT)
 S VIEN=0
 F  S VIEN=$O(^TMP("VSIT",$J,VIEN)) Q:VIEN=""  S NUM=0 D
 .F  S NUM=$O(^TMP("VSIT",$J,VIEN,NUM)) Q:NUM=""  D
 ..S PARAMS=$G(^TMP("VSIT",$J,VIEN,NUM))
 ..;make sure location is a clinic
 ..I $$GET1^DIQ(44,$P($P(PARAMS,U,2),";"),2,"I")'="C" Q
 ..I $G(LOC) I LOC'=$$GET1^DIQ(44,$P($P(PARAMS,U,2),";"),"3.5:.07","I") Q  ;126,130 If location sent, filter out any visits whose clinic isn't in the location
 ..S P1DT=$P(PARAMS,U,1),P1=$$FMTE^XLFDT(P1DT,"9M"),P2=$P($P(PARAMS,U,2),";",2)
 ..I '$G(P1DT)!($G(P2)="") Q
 ..I $D(ARR(P1DT,P2))=1 Q
 ..;;cntrl array, filter visits from PT file
 ..S ARR(P1DT,P2)=P1DT_U_$$LJ^XLFSTR(P1,25)_$$LJ^XLFSTR(P2,30)_U_P1_U_P2_U
 S VIEN=0
 F  S VIEN=$O(^TMP($J,"SDAMA201","GETAPPT",VIEN)) Q:VIEN=""  D
 .I $D(^TMP($J,"SDAMA201","GETAPPT","ERROR")) Q
 .S P1DT=$G(^TMP($J,"SDAMA201","GETAPPT",VIEN,1))
 .S P1=$$FMTE^XLFDT(P1DT,"9M")
 .S P2=$P($G(^TMP($J,"SDAMA201","GETAPPT",VIEN,2)),U,2)
 .I $G(LOC) I LOC'=$$GET1^DIQ(44,$P($G(^TMP($J,"SDAMA201","GETAPPT",VIEN,2)),U),"3.5:.07","I") Q  ;126,130 If location sent, filter out any appts whose clinic isn't in the location
 .I '$G(P1DT)!($G(P2)="") Q
 .I $D(ARR(P1DT,P2))=1 Q
 .;;cntrl array, filter visits from PT file
 .S ARR(P1DT,P2)=P1DT_U_$$LJ^XLFSTR(P1,25)_$$LJ^XLFSTR(P2,30)_U_P1_U_P2_U
 S VIEN=9999999999,CNT=1
 F  S VIEN=$O(ARR(VIEN),-1) Q:((VIEN="")!(CNT>20))  D
 .S NUM=0 F  S NUM=$O(ARR(VIEN,NUM)) Q:NUM=""  D
 ..S RESULT(CNT)=ARR(VIEN,NUM),CNT=CNT+1
 I $D(ARR) S RESULT(0)=CNT
 K ^TMP("VSIT",$J)
 K ^TMP($J,"SDAMA201","GETAPPT")
 Q

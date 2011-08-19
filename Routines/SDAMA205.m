SDAMA205 ;BPOIFO/ACS-Scheduling Replacement APIs ; 12/13/04 3:17pm
 ;;5.3;Scheduling;**347**;13 Aug 1993
 ;
 ;*****************************************************************
 ;              CHANGE LOG
 ;
 ;  DATE      PATCH       DESCRIPTION
 ;--------  ----------    -----------------------------------------
 ;07/21/04  SD*5.3*347    CALLED FROM GETAPPT^SDAMA201.
 ;
 ;*****************************************************************
GETAPPT(SDPATIEN,SDFIELDS,SDAPSTAT,SDSTART,SDEND,SDRESULT,SDIOSTAT) ;
 ;*****************************************************************
 ;
 ;               GET APPOINTMENTS FOR PATIENT
 ;
 ;INPUT
 ;  SDPATIEN     Patient IEN (required)
 ;  SDFIELDS     Fields requested (optional)
 ;  SDAPSTAT     Appointment Status Filter (optional)
 ;  SDSTART      Start date/time (optional)
 ;  SDEND        End date/time (optional)
 ;  SDRESULT     Record count returned here (optional)
 ;  SDIOSTAT     Patient Status filter (optional)
 ;  
 ;OUTPUT
 ;  ^TMP($J,"SDAMA201","GETAPPT",X,Y)=FieldYdata
 ;  where "X" is an incremental appointment counter and
 ;  "Y" is the field number requested
 ;  
 ;*****************************************************************
 N SDAPDT,SDAPINAM,SDARRAY,SDRTNNAM,SDAPNUM,SDCNVRT,SDDATA,SDX,SDY,SDZ
 S SDAPINAM="GETAPPT",SDRTNNAM="SDAMA201",SDRESULT=0
 K ^TMP($J,SDRTNNAM,SDAPINAM)
 S SDRESULT=$$VALIDATE^SDAMA200(.SDPATIEN,.SDFIELDS,.SDAPSTAT,.SDSTART,.SDEND,SDAPINAM,SDRTNNAM,.SDIOSTAT)
 I SDRESULT=-1 Q
 ;
 ;CONVERT INPUT VALUES TO SDAPI FILTER VALUES
 S SDARRAY("SORT")="P"
 S SDARRAY(4)=SDPATIEN
 I $G(SDSTART)>0!($G(SDEND)>0) S SDARRAY(1)=$G(SDSTART)_";"_$G(SDEND)
 ;convert Field List
 S SDARRAY("FLDS")=""
 F SDX=1:1 S SDY=$P(SDFIELDS,";",SDX) Q:SDY=""  D
 .I SDY=12,SDFIELDS[3 Q  ; Patient Status not needed if Appt. Stat. exists.
 .I SDY=12 S SDY=3 ; Patient Status and Appointment Status are the same here.
 .S SDARRAY("FLDS")=SDARRAY("FLDS")_SDY_";"
 I '$L(SDFIELDS) S SDARRAY("FLDS")="1;2;3;4;5;6;7;8;9;10;11"
 ;convert Appt. List
 S SDZ=""
 ;IO Status has been validated by SDAMA200 to be I or O
 I $L($G(SDIOSTAT))=1 S SDZ=$S(SDIOSTAT="I":"I;",SDIOSTAT="O":SDAPSTAT_";")
 I $L($G(SDIOSTAT))'=1,$L($G(SDAPSTAT)) D
 .F SDX=1:1:$L(SDAPSTAT,";") S SDY=$P(SDAPSTAT,";",SDX)  D
 ..S SDZ=SDZ_$S(SDY="R":"R;I;",SDY="N":"NS;NSR;",SDY="C":"CC;CP;CCR;CPR;",1:SDY_";")
 E  S SDZ="R;I;CC;CP;CCR;CPR;NS;NSR;NT;"
 I $L(SDZ) S SDARRAY(3)=$E(SDZ,1,$L(SDZ)-1)
 ;
 ;CALL SDAPI TO RETRIEVE APPOINTMENT INFO
 S SDRESULT=$$SDAPI^SDAMA301(.SDARRAY)
 I SDRESULT=0 Q  ; No Appointment info returned.
 ;
 I SDRESULT=-1 D  Q  ; Error(s) Encountered.
 .S SDX=$O(^TMP($J,"SDAMA301",""))
 .S SDX=$S(SDX=101:101,SDX=115:114,SDX=116:114,1:117)
 .D ERROR^SDAMA200(SDX,"GETAPPT",0,"SDAMA201")
 .K ^TMP($J,"SDAMA301")
 ;
 ; Convert Appt. Info Returned from SDAPI to GETAPPT Format.
 F SDX=1,5,7,9,11,12 S SDCNVRT(SDX)=""
 F SDX=2,4,8,10 S SDCNVRT(SDX)="S SDDATA=$TR(SDDATA,"";"",""^"")"
 S SDCNVRT(3)="S SDDATA=$P(SDDATA,"";""),SDDATA=$S(SDDATA=""R"":SDDATA,SDDATA=""I"":""R"",$E(SDDATA,1)=""C"":""C"",$E(SDDATA,1,2)=""NS"":""N"",1:""NT"")"
 S SDCNVRT(6)="S SDDATA=$G(^TMP($J,""SDAMA301"",SDPATIEN,SDAPDT,""C""))"
 ;
 S SDAPNUM=0,SDAPDT=""
 ;Loop through returned appointments from SDAPI
 F  S SDAPDT=$O(^TMP($J,"SDAMA301",SDPATIEN,SDAPDT)) Q:SDAPDT=""  S SDX=^(SDAPDT) D
 .S SDAPNUM=SDAPNUM+1
 .;Loop through requested fields
 .F SDY=1:1 S SDZ=$P($G(SDFIELDS),";",SDY) Q:SDZ=""  D
 ..;Retrieve data for requested field
 ..S SDDATA=$P(SDX,"^",SDZ)
 ..;Convert Overbook to N if null value returned from SDAPI
 ..I SDZ=7,SDDATA="" S SDDATA="N"
 ..X SDCNVRT(SDZ) S ^TMP($J,"SDAMA201","GETAPPT",SDAPNUM,SDZ)=SDDATA
 .;Set Patient Status Value in output based on Appt Status
 .I $P($P(SDX,U,3),";")="I" S ^TMP($J,"SDAMA201","GETAPPT",SDAPNUM,12)="I"
 .I $S($P($P(SDX,U,3),";")="R":1,$P($P(SDX,U,3),";")="NT":1,1:0) S ^TMP($J,"SDAMA201","GETAPPT",SDAPNUM,12)="O"
 K ^TMP($J,"SDAMA301")
 Q
 ;

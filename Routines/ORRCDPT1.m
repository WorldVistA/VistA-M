ORRCDPT1 ;SLC/MKB - Patient List for Nursing Dashboard ; 19 Sept 2003  10:10 AM
 ;;1.0;CARE MANAGEMENT;**5**;Jul 15, 2003;Build 4
 ;
EN(ORY,ORUSR,ORLST) ; -- Return each patient in ORLSTs for ORUSR
 ; where ORLST(#) = <list-type>:<list-ID>:<clinic start>:<clinic stop>
 ; in @ORY@(#) = "Patient=<dfn>^<name>^<ssn>^<dob>^<age>"
 ;             = "Result=ORR:##^ORR:##^...^*ORR:##"
 ;             = "Task=TSK:##^TSK:##^...^*TSK:##"
 ;             = "Event=VST:ID^VST:ID^...^VST:ID"
 ;             = "Unverified=ORV:##^...^ORV:##"
 ;             = "Nursing=ORN:##^...^!ORN:##"
 ;             = "Vital=VIT:ID^...^*VIT:ID"
 ;             = "Error=^<error description>"
 ; RPC = ORRC NURS DASHBD PATIENTS
 ;
 ;
 K ^TMP($J,"ORRCPTS"),^TMP($J,"ORRCY")
 N ORI,ORX,X,ORID,ORBEG,OREND,ORTN,ORPAT,ORJ,PAT,ORDMIN,ORDMAX,ERRI
 N ORSRV,FROM
 S ORSRV=$G(^VA(200,DUZ,5)) I +ORSRV>0 S ORSRV=$P(ORSRV,U)
 S FROM=$$GET^XPAR("USR^SRV.`"_+$G(ORSRV),"ORLP DEFAULT LIST SOURCE",1,"Q")
 S ORUSR=+$G(ORUSR),ERRI=0 D PARAMS
 S ORI=0 F  S ORI=$O(ORLST(ORI)) Q:ORI<1  S ORX=$G(ORLST(ORI)) D
 . S X=$$UP^XLFSTR($P(ORX,":")),ORID=+$P(ORX,":",2) D  Q:'$G(ORPAT(1))
 .. I X="X" D DEFLIST^ORQPTQ11(.ORPAT) D:$G(FROM)="M"  Q
 ... S ORJ=0 F  S ORJ=$O(^TMP("OR",$J,"PATIENTS",ORJ)) Q:ORJ<1  S PAT=+$G(^(ORJ,0)),ORPAT(ORJ)=PAT
 .. I X="T" D TEAMPTS^ORQPTQ1(.ORPAT,ORID) Q
 .. S ORTN=$S(X="P":"PROV",X="S":"SPEC",X="W":"WARD",X="C":"CLIN",1:"") Q:'$L(ORTN)
 .. I X'="C" S ORTN=ORTN_"PTS^ORQPTQ2(.ORPAT,ORID)" D @ORTN Q
 .. S ORBEG=$P(ORX,":",3),OREND=$P(ORX,":",4)
 .. S ORTN=ORTN_"PTS^ORQPTQ2(.ORPAT,ORID,ORBEG,OREND)" D @ORTN
 .. I $D(ORPAT(1)),'+$G(ORPAT(1)),ORPAT(1)'="^No appointments." S ERRI=ERRI+1,^TMP($J,"ORRCDPT1_ERROR",ERRI)=ORPAT(1)
 . S ORJ=0 F  S ORJ=$O(ORPAT(ORJ)) Q:ORJ<1  S PAT=+$G(ORPAT(ORJ)) D
 .. Q:$D(^TMP($J,"ORRCY",PAT))  ;already processed
 .. ; build ^TMP($J,"ORRCY",DFN,"<type>",ID)=* or null:
 .. D RSLT,TASK,EVNT,UNVR,TEXT,VITL
 .. S ^TMP($J,"ORRCY",PAT)="" ;return all pts on list
 I $D(^TMP($J,"ORRCY")) D FORMAT
 I $D(^TMP($J,"ORRCDPT1_ERROR")) D ERROR(.ORY)
 K ^TMP($J,"ORRCY"),^TMP($J,"ORRCDPT1_ERROR")
 Q
 ;
ERROR(ORY)      ;Process errors to be returned
 N I,J S I=0,J=0
 I '$D(ORY) S ORY=$$GETRET
 F  S I=$O(@ORY@(I)) Q:I'>0  S J=I
 S I=0
 F  S I=$O(^TMP($J,"ORRCDPT1_ERROR",I)) Q:I'>0  S J=J+1,@ORY@(J)="Error="_^TMP($J,"ORRCDPT1_ERROR",I)
 Q
 ;
PARAMS ; -- Return date range parameters ORDMIN(type),ORDMAX(type) for ORUSR
 N SERV,ORX,X,Y,%DT S SERV=+$G(^VA(200,ORUSR,5))
 F ORX="RESULT","EVENT","TEXT ORDER","UNVERIFIED","VITALS" D
 . S X=$$GET^XPAR("ALL^USR.`"_ORUSR_"^SRV.`"_SERV,"ORRC NURSE "_ORX_" DATE MIN"),%DT="TX"
 . D ^%DT S ORDMIN(ORX)=$S(Y>0:Y,1:"")
 . S X=$$GET^XPAR("ALL^USR.`"_ORUSR_"^SRV.`"_SERV,"ORRC NURSE "_ORX_" DATE MAX"),%DT="TX"
 . D ^%DT S ORDMAX(ORX)=$S(Y>0:Y,1:"")
 Q
 ;
RSLT ; -- find PAT's results unack'd by ORUSR
 N ORACK,ORDBEG,ORDEND
 S ORDBEG=ORDMIN("RESULT"),ORDEND=ORDMAX("RESULT")
 D IDS^ORRCACK(.ORACK,PAT,ORUSR,ORDBEG,ORDEND)
 M ^TMP($J,"ORRCY",PAT,"R")=@ORACK@(PAT) K @ORACK
 Q
 ;
TASK ; -- find PAT's due tasks
 N ORTSK
 D IDS^ORRCTSK(.ORTSK,PAT)
 M ^TMP($J,"ORRCY",PAT,"T")=@ORTSK@(PAT) K @ORTSK
 Q
 ;
EVNT ; -- find PAT's appointments
 N OREVT,ORABEG,ORAEND
 S ORABEG=ORDMIN("EVENT"),ORAEND=ORDMAX("EVENT")
 D IDS^ORRCEVT(.OREVT,PAT,ORABEG,ORAEND)
 M ^TMP($J,"ORRCY",PAT,"E")=@OREVT@(PAT) K @OREVT
 Q
 ;
UNVR ; -- find PAT's unverified orders, by nursing
 N ORDER,ORDBEG,ORDEND
 S ORDBEG=ORDMIN("UNVERIFIED"),ORDEND=ORDMAX("UNVERIFIED")
 D IDS^ORRCOR(.ORDER,PAT,"ORV",ORDBEG,ORDEND)
 M ^TMP($J,"ORRCY",PAT,"U")=@ORDER@(PAT) K @ORDER
 Q
 ;
TEXT ; -- find patients with active generic text orders
 N ORDER,ORDBEG,ORDEND
 S ORDBEG=ORDMIN("TEXT ORDER"),ORDEND=ORDMAX("TEXT ORDER")
 D IDS^ORRCOR(.ORDER,PAT,"ORN",ORDBEG,ORDEND)
 M ^TMP($J,"ORRCY",PAT,"N")=@ORDER@(PAT) K @ORDER
 Q
 ;
VITL ; -- find patients with recent vitals
 N ORVIT,ORVBEG,ORVEND
 S ORVBEG=ORDMIN("VITALS"),ORVEND=ORDMAX("VITALS")
 D IDS^ORRCVIT(.ORVIT,PAT,ORVBEG,ORVEND)
 M ^TMP($J,"ORRCY",PAT,"V")=@ORVIT@(PAT) K @ORVIT
 Q
 ;
FORMAT ; -- Format return array ^TMP($J,"ORRCPTS") from temp array ^TMP($J,"ORRCY")
 N ORPT,ORN,DFN,VADM,VA,VAERR
 S ORY=$$GETRET
 S (ORPT,ORN)=0 F  S ORPT=$O(^TMP($J,"ORRCY",ORPT)) Q:ORPT<1  D
 . S DFN=ORPT D DEM^VADPT
 . S ORN=ORN+1,@ORY@(ORN)="Patient="_DFN_U_VADM(1)_U_VA("PID")_U_$$FMTHL7^XLFDT(+VADM(3))_U_VADM(4)
 . I $D(^TMP($J,"ORRCY",ORPT,"R")) D ADD("Result")
 . I $D(^TMP($J,"ORRCY",ORPT,"T")) D ADD("Task")
 . I $D(^TMP($J,"ORRCY",ORPT,"E")) D ADD("Event")
 . I $D(^TMP($J,"ORRCY",ORPT,"U")) D ADD("Unverified")
 . I $D(^TMP($J,"ORRCY",ORPT,"N")) D ADD("Nursing")
 . I $D(^TMP($J,"ORRCY",ORPT,"V")) D ADD("Vital")
 Q
 ;
ADD(TYPE) ; -- Add item IDs from ^TMP($J,"ORRCY",PAT,<TYPE>) into return array
 N ORX,ORSUB,ORID,X,ORU
 S ORX=TYPE_"=",ORSUB=$E(TYPE),ORID="",ORU=""
 F  S ORID=$O(^TMP($J,"ORRCY",ORPT,ORSUB,ORID)) Q:ORID=""  S X=$G(^(ORID))_ORID D
 . I $L(ORX)+$L(X)>254 S ORN=ORN+1,@ORY@(ORN)=ORX,ORX=TYPE_"=",ORU=""
 . S ORX=ORX_ORU_X,ORU=U
 S ORN=ORN+1,@ORY@(ORN)=ORX
 Q
 ;
GETRET()        ;Returns the return variable pointer
 Q $NA(^TMP($J,"ORRCPTS"))
 ;

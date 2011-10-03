ORRCDPT ;SLC/MKB - Patient List for Physician Dashboard ; 19 Sept 2003 10:09 AM
 ;;1.0;CARE MANAGEMENT;**5**;Jul 15, 2003;Build 4
 ;
MAIN(ORY,USER,TYPE,LIST) ; -- Return patient list for dashboard
 ; where USER    = pointer to #200
 ;       TYPE    = (C)linician or (N)urse view
 ;       LIST(#) = <list-type>:<list-ID>:<clinic start>:<clinic stop>
 ; RPC = ORRC DASHBOARD PATIENTS
 ;
 D EXPDATES(.LIST) ;expand dates
 S USER=+$G(USER),TYPE=$$UP^XLFSTR($G(TYPE))
 I TYPE="N" D EN^ORRCDPT1(.ORY,USER,.LIST) Q
 I $O(LIST(0)) D EN1(.ORY,USER,.LIST) Q
 D EN(.ORY,USER)
 Q
 ;
EN(ORY,ORUSR) ; -- Return each patient to list on dashboard for ORUSR
 ; in @ORY@(#) = "Patient=<dfn>^<name>^<ssn>^<dob>^<age>"
 ;             = "Result=ORR:##^ORR:##^...^*ORR:##"
 ;             = "Task=TSK:##^TSK:##^...^*TSK:##"
 ;             = "Event=VST:ID^VST:ID^...^VST:ID"
 ;             = "Unsigned=ORD:##^...^ORD:##^DOC:##^...^DOC:##"
 ;             = "Notifications=1"
 ; RPC = ORRC PHY DASHBD PATIENTS
 S ORUSR=+$G(ORUSR) K ^TMP($J,"ORRCPTS"),^TMP($J,"ORRCY"),^TMP($J,"ORRCLST")
 D RSLT,TASK,EVNT,SIGN ;build ^TMP($J,"ORRCY",DFN,"<type>",ID)=* or null
 I $D(^TMP($J,"ORRCY")) D FORMAT
 K ^TMP($J,"ORRCY")
 Q
 ;
EN1(ORY,ORUSR,ORLST) ; -- Return patients on ORLST for ORUSR's dashboard
 ; in @ORY@(#) = "Patient=<dfn>^<name>^<ssn>^<dob>^<age>"
 ;             = "Result=ORR:##^ORR:##^...^*ORR:##"
 ;             = "Task=TSK:##^TSK:##^...^*TSK:##"
 ;             = "Event=VST:ID^VST:ID^...^VST:ID"
 ;             = "Unsigned=ORD:##^...^ORD:##^DOC:##^...^DOC:##"
 ;             = "Error=^<error description>"
 N ORI,ORX,X,ORID,ORPAT,ORTN,ORBEG,OREND,ORJ,PAT,ERRI S ORUSR=+$G(ORUSR),ERRI=0
 K ^TMP($J,"ORRCY"),^TMP($J,"ORRCNOTF"),^TMP($J,"ORRCPTS")
 S ^TMP($J,"ORRCLST")=""
 N ORSRV,FROM
 S ORSRV=$G(^VA(200,DUZ,5)) I +ORSRV>0 S ORSRV=$P(ORSRV,U)
 S FROM=$$GET^XPAR("USR^SRV.`"_+$G(ORSRV),"ORLP DEFAULT LIST SOURCE",1,"Q")
 S ORI=0 F  S ORI=$O(ORLST(ORI)) Q:ORI<1  S ORX=$G(ORLST(ORI)) D
 . S X=$$UP^XLFSTR($P(ORX,":")),ORID=+$P(ORX,":",2) D  Q:'$G(ORPAT(1))
 .. I X="X" D DEFLIST^ORQPTQ11(.ORPAT) D:$G(FROM)="M"  Q
 ... S ORJ=0 F  S ORJ=$O(^TMP("OR",$J,"PATIENTS",ORJ)) Q:ORJ<1  S PAT=+$G(^(ORJ,0)),^TMP($J,"ORRCY",PAT)=""
 .. I X="T" D TEAMPTS^ORQPTQ1(.ORPAT,ORID) Q
 .. S ORTN=$S(X="P":"PROV",X="S":"SPEC",X="W":"WARD",X="C":"CLIN",1:"") Q:'$L(ORTN)
 .. I X'="C" S ORTN=ORTN_"PTS^ORQPTQ2(.ORPAT,ORID)" D @ORTN Q
 .. S ORBEG=$P(ORX,":",3),OREND=$P(ORX,":",4)
 .. D CLINPTS^ORQPTQ2(.ORPAT,ORID,ORBEG,OREND)
 .. I $D(ORPAT(1)),'+$G(ORPAT(1)),ORPAT(1)'="^No appointments." S ERRI=ERRI+1,^TMP($J,"ORRCDPT_ERROR",ERRI)=ORPAT(1)
 . S ORJ=0 F  S ORJ=$O(ORPAT(ORJ)) Q:ORJ<1  S PAT=+$G(ORPAT(ORJ)),^TMP($J,"ORRCY",PAT)=""
 I $D(^TMP($J,"ORRCY")) D  ;there are patients on selected list(s)
 . ; build ^TMP($J,"ORRCY",DFN,"<type>",ID)=* or null:
 . D RSLT,TASK,EVNT,SIGN,FORMAT
 D ERROR(.ORY)
 K ^TMP($J,"ORRCY"),^TMP($J,"ORRCNOTF"),^TMP($J,"ORRCLST"),^TMP($J,"ORRCDPT_ERROR")
 Q
 ;
ERROR(ORY)     ; -- process errors
 I '$D(^TMP($J,"ORRCDPT_ERROR")) Q
 N I,J S I=0,J=0
 I '$D(ORY) S ORY=$$GETRET
 F  S I=$O(@ORY@(I)) Q:I'>0  S J=I
 S I=0
 F  S I=$O(^TMP($J,"ORRCDPT_ERROR",I)) Q:I'>0  S J=J+1,@ORY@(J)="Error="_^TMP($J,"ORRCDPT_ERROR",I)
 Q
 ;
RSLT ; -- find patients with unack'd results for ORUSR's orders
 N ORACK,PAT
 D PATS^ORRCACK(.ORACK,ORUSR) S PAT=0
 F  S PAT=+$O(@ORACK@(PAT)) Q:PAT<1  M ^TMP($J,"ORRCY",PAT,"R")=@ORACK@(PAT)
 K @ORACK
 Q
 ;
TASK ; -- find patients with tasks not complete
 N ORTSK,PAT
 D PATS^ORRCTSK(.ORTSK,ORUSR) S PAT=0
 F  S PAT=+$O(@ORTSK@(PAT)) Q:PAT<1  M ^TMP($J,"ORRCY",PAT,"T")=@ORTSK@(PAT)
 K @ORTSK
 Q
 ;
EVNT ; -- find patients that ORUSR has outstanding ADT alerts for
 N OREVT,PAT
 D PATS^ORRCEVT(.OREVT,ORUSR) S PAT=0
 F  S PAT=+$O(@OREVT@(PAT)) Q:PAT<1  M ^TMP($J,"ORRCY",PAT,"E")=@OREVT@(PAT)
 K @OREVT
 Q
 ;
SIGN ; -- find patients that have orders or notes ORUSR needs to sign
 N ORDER,ORDOC,PAT
 ;D PTUNS^ORRCOR(.ORDER,ORUSR) S PAT=0
 ;F  S PAT=+$O(ORDER(PAT)) Q:PAT<1  M ^TMP($J,"ORRCY",PAT,"U")=ORDER(PAT)
 D GETPTUNS^ORRCTIU(.ORDOC,ORUSR) S PAT=0
 F  S PAT=+$O(@ORDOC@(PAT)) Q:PAT<1  M ^TMP($J,"ORRCY",PAT,"U")=@ORDOC@(PAT)
 K @ORDOC
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
 . I $D(^TMP($J,"ORRCY",ORPT,"U")) D ADD("Unsigned")
 . I $G(^TMP($J,"ORRCNOTF",ORPT)) S ORN=ORN+1,@ORY@(ORN)="Notifications=1"
 Q
 ;
GETRET()        ;Returns the return variable pointer
 Q $NA(^TMP($J,"ORRCPTS"))
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
EXPDATES(LIST)  ;Expand dates for clinic appointments, if they need to be expanded.  These would be a year or quarter indicators on clinic appt lists.
         ;Ex. YC = current year, YC-4 = current year - 4, etc.
 N I,RANGE S I=0
 F  S I=$O(LIST(I)) Q:I'>0  D
 .I $P(LIST(I),":",1)="c",$L(LIST(I),":")=3 D
 ..S RANGE=$$RNG2FM^ORRHCU($P(LIST(I),":",3))
 ..S $P(LIST(I),":",3)=$P(RANGE,":",1)
 ..S $P(LIST(I),":",4)=$P(RANGE,":",2)
 Q
 ;

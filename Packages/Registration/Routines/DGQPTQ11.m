DGQPTQ11 ; SLC/CLA - Functs which return patient lists and sources pt 1B ;12/15/97
 ;;5.3;Registration;**447**;Aug 13, 1993
 ;
 ; SLC/PKS - Modified to deal with "Combination" lists - 3/2000.
 ;
DEFSRC(Y) ; return current user's default list source
 Q:'$D(DUZ)
 N FROM,API,DGSRV
 S DGSRV=$G(^VA(200,DUZ,5)) I +DGSRV>0 S DGSRV=$P(DGSRV,U)
 S FROM=$$GET^XPAR("USR^SRV.`"_+$G(DGSRV),"DGLP DEFAULT LIST SOURCE",1,"Q")
 Q:'$L($G(FROM))
 I FROM="T" S Y=$$GET^XPAR("USR^SRV.`"_+$G(DGSRV),"DGLP DEFAULT TEAM",1,"B")_"^Team"
 I FROM="W" S Y=$$GET^XPAR("USR^SRV.`"_+$G(DGSRV),"DGLP DEFAULT WARD",1,"B")_"^Ward"
 I FROM="P" S Y=$$GET^XPAR("USR^SRV.`"_+$G(DGSRV),"DGLP DEFAULT PROVIDER",1,"B")_"^Primary Provider"
 I FROM="S" S Y=$$GET^XPAR("USR^SRV.`"_+$G(DGSRV),"DGLP DEFAULT SPECIALTY",1,"B")_"^Specialty"
 I FROM="C" D
 .S API="DGLP DEFAULT CLINIC "_$$UP^XLFSTR($$DOW^XLFDT(DT))
 .S Y=$$GET^XPAR("USR^SRV.`"_+$G(DGSRV),API,1,"B")_"^"_$$DOW^XLFDT(DT)_" Clinic"
 ; Next line added by PKS:
 I FROM="M" S Y="^Combination"
 Q
FDEFSRC(DGDUZ) ; extrinsic function return user's (DGDUZ) default list source
 Q:'$D(DGDUZ) "^^Error: No user identified"
 N FROM,API,RESULT,DGSRV
 S DGSRV=$G(^VA(200,DGDUZ,5)) I +DGSRV>0 S DGSRV=$P(DGSRV,U)
 S FROM=$$GET^XPAR("USR.`"_DGDUZ_"^SRV.`"_+$G(DGSRV),"DGLP DEFAULT LIST SOURCE",1,"Q")
 Q:'$L($G(FROM)) "^^No default list source specified"
 I FROM="T" S RESULT=$$GET^XPAR("USR.`"_DGDUZ_"^SRV.`"_+$G(DGSRV),"DGLP DEFAULT TEAM",1,"B")_"^Team"
 I FROM="W" S RESULT=$$GET^XPAR("USR.`"_DGDUZ_"^SRV.`"_+$G(DGSRV),"DGLP DEFAULT WARD",1,"B")_"^Ward"
 I FROM="P" S RESULT=$$GET^XPAR("USR.`"_DGDUZ_"^SRV.`"_+$G(DGSRV),"DGLP DEFAULT PROVIDER",1,"B")_"^Primary Provider"
 I FROM="S" S RESULT=$$GET^XPAR("USR.`"_ORDUZ_"^SRV.`"_+$G(ORSRV),"DGLP DEFAULT SPECIALTY",1,"B")_"^Specialty"
 I FROM="C" D
 .S API="DGLP DEFAULT CLINIC "_$$UP^XLFSTR($$DOW^XLFDT(DT))
 .S RESULT=$$GET^XPAR("USR.`"_DGDUZ_"^SRV.`"_+$G(DGSRV),API,1,"B")_"^"_$$DOW^XLFDT(DT)_" Clinic"
 ; Next line added by PKS - 3/2000:
 I FROM="M" S RESULT="^Combination"
 Q RESULT
LISTSRC(DGDUZ,TYPE) ; extrinsic function return user's (DGDUZ) list source
 ; for list type team, ward, primary provider, specialty, clinic, combination (TYPE)
 Q:'$D(DGDUZ) "^^Error: No user identified"
 Q:'$D(TYPE) "^^Error: No list type identified"
 N API,RESULT,DGSRV
 S DGSRV=$G(^VA(200,DGDUZ,5)) I +DGSRV>0 S DGSRV=$P(DGSRV,U)
 I TYPE="T" S RESULT=$$GET^XPAR("USR.`"_DGDUZ_"^SRV.`"_+$G(DGSRV),"DGLP DEFAULT TEAM",1,"B")_"^Team"
 I TYPE="W" S RESULT=$$GET^XPAR("USR.`"_DGDUZ_"^SRV.`"_+$G(DGSRV),"DGLP DEFAULT WARD",1,"B")_"^Ward"
 I TYPE="P" S RESULT=$$GET^XPAR("USR.`"_DGDUZ_"^SRV.`"_+$G(DGSRV),"DGLP DEFAULT PROVIDER",1,"B")_"^Primary Provider"
 I TYPE="S" S RESULT=$$GET^XPAR("USR.`"_DGDUZ_"^SRV.`"_+$G(DGSRV),"DGLP DEFAULT SPECIALTY",1,"B")_"^Specialty"
 I TYPE="C" D
 .S API="DGLP DEFAULT CLINIC "_$$UP^XLFSTR($$DOW^XLFDT(DT))
 .S RESULT=$$GET^XPAR("USR.`"_DGDUZ_"^SRV.`"_+$G(DGSRV),API,1,"B")_"^"_$$DOW^XLFDT(DT)_" Clinic"
 ; Next line added by PKS:
 I TYPE="M" S RESULT="Combination"
 I $P(RESULT,U)="" S RESULT=U_RESULT
 Q RESULT
DEFLIST(Y) ; return current user's default patient list
 I $$BROKER^XWBLIB S Y=$NA(^TMP("DG",$J,"PATIENTS")) ; GUI = global.
 I '$$BROKER^XWBLIB S ^TMP("DG",$J,"PATIENTS",0)=""
 Q:'$D(DUZ)
 N FROM,IEN,BEG,END,API,DGSRV,DGQDAT,DGQCNT,DGGUI
 S DGSRV=$G(^VA(200,DUZ,5)) I +DGSRV>0 S DGSRV=$P(DGSRV,U) ; Get S/S.
 S FROM=$$GET^XPAR("USR^SRV.`"_+$G(DGSRV),"DGLP DEFAULT LIST SOURCE",1,"Q")
 Q:'$L($G(FROM))
 I FROM="T" S IEN=$$GET^XPAR("USR^SRV.`"_+$G(DGSRV),"DGLP DEFAULT TEAM",1,"Q") D:+$G(IEN)>0 TEAMPTS^DGQPTQ1(.Y,IEN)
 I FROM="W" S IEN=$$GET^XPAR("USR^SRV.`"_+$G(DGSRV),"DGLP DEFAULT WARD",1,"Q") D:+$G(IEN)>0 WARDPTS^DGQPTQ2(.Y,IEN)
 I FROM="P" S IEN=$$GET^XPAR("USR^SRV.`"_+$G(DGSRV),"DGLP DEFAULT PROVIDER",1,"Q") D:+$G(IEN)>0 PROVPTS^DGQPTQ2(.Y,IEN)
 I FROM="S" S IEN=$$GET^XPAR("USR^SRV.`"_+$G(DGSRV),"DGLP DEFAULT SPECIALTY",1,"Q") D:+$G(IEN)>0 SPECPTS^DGQPTQ2(.Y,IEN)
 I FROM="C" D
 .S API="DGLP DEFAULT CLINIC "_$$UP^XLFSTR($$DOW^XLFDT(DT)),IEN=$$GET^XPAR("USR^SRV.`"_+$G(DGSRV),API,1,"Q") I +$G(IEN)>0 D
 ..S BEG=$$UP^XLFSTR($$GET^XPAR("USR^SRV.`"_+$G(DGSRV)_"^DIV^SYS^PKG","DGLP DEFAULT CLINIC START DATE",1,"E"))
 ..I BEG="T+0" S BEG=$$FMTE^XLFDT(DT,BEG)
 ..S END=$$UP^XLFSTR($$GET^XPAR("USR^SRV.`"_+$G(DGSRV)_"^DIV^SYS^PKG","DGLP DEFAULT CLINIC STOP DATE",1,"E"))
 ..I END="T+0" S END=$$FMTE^XLFDT(DT,END)
 ..D CLINPTS^DGQPTQ2(.Y,+$G(IEN),BEG,END)
 ; Next section added by PKS:
 I FROM="M" D
 .S IEN=$D(^OR(100.24,DUZ,0)) I +$G(IEN)>0 S IEN=DUZ D
 ..S BEG=$$UP^XLFSTR($$GET^XPAR("USR^SRV.`"_+$G(DGSRV)_"^DIV^SYS^PKG","DGLP DEFAULT CLINIC START DATE",1,"E"))
 ..I BEG="T+0" S BEG=$$FMTE^XLFDT(DT,BEG)
 ..S END=$$UP^XLFSTR($$GET^XPAR("USR^SRV.`"_+$G(DGSRV)_"^DIV^SYS^PKG","DGLP DEFAULT CLINIC STOP DATE",1,"E"))
 ..I END="T+0" S END=$$FMTE^XLFDT(DT,END)
 ..D COMBPTS^DGQPTQ6(0,+$G(IEN),BEG,END) ; "0"= GUI RPC call.
 ; Added by PKS - 3/2001, to write to global for GUI:
 I ($$BROKER^XWBLIB)&(FROM'="M") D  ; Combinations already written to global.
 .; Put list into a global:
 .S DGQDAT="",DGQCNT=1
 .F  S DGQDAT=$G(Y(DGQCNT)) Q:DGQDAT=""  D
 ..S ^TMP("DG",$J,"PATIENTS",DGQCNT,0)=DGQDAT
 ..S DGQCNT=DGQCNT+1
 I ('$$BROKER^XWBLIB) S Y=FROM_";"_+$G(IEN)_";"_$G(BEG)_";"_$G(END) ; MKB 10/13/95
 Q
DEFSORT(Y) ; Return user's default "sort" for patient selection lists.
 ; SLC/PKS - 4/6/2001
 ;
 N DGSORT,DGSECT,DGPARAM
 ;
 I ('$D(DUZ)) S Y="Unable to determine DUZ." Q
 ;
 ; Get user's current service/section:
 S DGSECT=$G(^VA(200,DUZ,5))
 I +DGSECT>0 S DGSECT=$P(DGSECT,U)
 ;
 ; Retrieve current sort parameter:
 S Y="A" ; Default of "Alpha" sort.
 S DGPARAM="DGLP DEFAULT LIST ORDER"
 S DGSORT=$$GET^XPAR("USR^SRV.`"_$G(DGSECT)_"^DIV^SYS^PKG",DGPARAM,1,"I")
 I (DGSORT'="") S Y=DGSORT
 ;
 Q
 ;

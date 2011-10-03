ORQPTQ11 ; SLC/CLA - Functs which return patient lists and sources pt 1B ;12/15/97 [ 08/04/97  3:32 PM ] [6/6/03 2:36pm]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**82,85,109,132,173,253**;Dec 17, 1997
 ;
 ; SLC/PKS - Modified to deal with "Combination" lists - 3/2000.
 ; SLC/PKS - Additions for "Restricted Pt. Lists" - 11/2001.
 ;
DEFSRC(Y) ; return current user's default list source
 Q:'$D(DUZ)
 N FROM,API,ORSRV
 S ORSRV=$G(^VA(200,DUZ,5)) I +ORSRV>0 S ORSRV=$P(ORSRV,U)
 S FROM=$$GET^XPAR("USR^SRV.`"_+$G(ORSRV),"ORLP DEFAULT LIST SOURCE",1,"Q")
 Q:'$L($G(FROM))
 I FROM="T" S Y=$$GET^XPAR("USR^SRV.`"_+$G(ORSRV),"ORLP DEFAULT TEAM",1,"B")_"^Team"
 I FROM="W" S Y=$$GET^XPAR("USR^SRV.`"_+$G(ORSRV),"ORLP DEFAULT WARD",1,"B")_"^Ward"
 I FROM="P" S Y=$$GET^XPAR("USR^SRV.`"_+$G(ORSRV),"ORLP DEFAULT PROVIDER",1,"B")_"^Primary Provider"
 I FROM="S" S Y=$$GET^XPAR("USR^SRV.`"_+$G(ORSRV),"ORLP DEFAULT SPECIALTY",1,"B")_"^Specialty"
 I FROM="C" D
 .S API="ORLP DEFAULT CLINIC "_$$UP^XLFSTR($$DOW^XLFDT(DT))
 .S Y=$$GET^XPAR("USR^SRV.`"_+$G(ORSRV),API,1,"B")_"^"_$$DOW^XLFDT(DT)_" Clinic"
 I FROM="M" S Y="^Combination"
 Q
FDEFSRC(ORDUZ) ; extrinsic function return user's (ORDUZ) default list source
 Q:'$D(ORDUZ) "^^Error: No user identified"
 N FROM,API,RESULT,ORSRV
 S ORSRV=$G(^VA(200,ORDUZ,5)) I +ORSRV>0 S ORSRV=$P(ORSRV,U)
 S FROM=$$GET^XPAR("USR.`"_ORDUZ_"^SRV.`"_+$G(ORSRV),"ORLP DEFAULT LIST SOURCE",1,"Q")
 Q:'$L($G(FROM)) "^^No default list source specified"
 I FROM="T" S RESULT=$$GET^XPAR("USR.`"_ORDUZ_"^SRV.`"_+$G(ORSRV),"ORLP DEFAULT TEAM",1,"B")_"^Team"
 I FROM="W" S RESULT=$$GET^XPAR("USR.`"_ORDUZ_"^SRV.`"_+$G(ORSRV),"ORLP DEFAULT WARD",1,"B")_"^Ward"
 I FROM="P" S RESULT=$$GET^XPAR("USR.`"_ORDUZ_"^SRV.`"_+$G(ORSRV),"ORLP DEFAULT PROVIDER",1,"B")_"^Primary Provider"
 I FROM="S" S RESULT=$$GET^XPAR("USR.`"_ORDUZ_"^SRV.`"_+$G(ORSRV),"ORLP DEFAULT SPECIALTY",1,"B")_"^Specialty"
 I FROM="C" D
 .S API="ORLP DEFAULT CLINIC "_$$UP^XLFSTR($$DOW^XLFDT(DT))
 .S RESULT=$$GET^XPAR("USR.`"_ORDUZ_"^SRV.`"_+$G(ORSRV),API,1,"B")_"^"_$$DOW^XLFDT(DT)_" Clinic"
 I FROM="M" S RESULT="^Combination"
 Q RESULT
LISTSRC(ORDUZ,TYPE) ; extrinsic function return user's (ORDUZ) list source
 ; for list type team, ward, primary provider, specialty, clinic, combination (TYPE)
 Q:'$D(ORDUZ) "^^Error: No user identified"
 Q:'$D(TYPE) "^^Error: No list type identified"
 N API,RESULT,ORSRV
 S ORSRV=$G(^VA(200,ORDUZ,5)) I +ORSRV>0 S ORSRV=$P(ORSRV,U)
 I TYPE="T" S RESULT=$$GET^XPAR("USR.`"_ORDUZ_"^SRV.`"_+$G(ORSRV),"ORLP DEFAULT TEAM",1,"B")_"^Team"
 I TYPE="W" S RESULT=$$GET^XPAR("USR.`"_ORDUZ_"^SRV.`"_+$G(ORSRV),"ORLP DEFAULT WARD",1,"B")_"^Ward"
 I TYPE="P" S RESULT=$$GET^XPAR("USR.`"_ORDUZ_"^SRV.`"_+$G(ORSRV),"ORLP DEFAULT PROVIDER",1,"B")_"^Primary Provider"
 I TYPE="S" S RESULT=$$GET^XPAR("USR.`"_ORDUZ_"^SRV.`"_+$G(ORSRV),"ORLP DEFAULT SPECIALTY",1,"B")_"^Specialty"
 I TYPE="C" D
 .S API="ORLP DEFAULT CLINIC "_$$UP^XLFSTR($$DOW^XLFDT(DT))
 .S RESULT=$$GET^XPAR("USR.`"_ORDUZ_"^SRV.`"_+$G(ORSRV),API,1,"B")_"^"_$$DOW^XLFDT(DT)_" Clinic"
 I TYPE="M" S RESULT="Combination"
 I $P(RESULT,U)="" S RESULT=U_RESULT
 Q RESULT
DEFLIST(Y) ; return current user's default patient list
 I $$BROKER^XWBLIB S Y=$NA(^TMP("OR",$J,"PATIENTS")) ; GUI = global.
 I '$$BROKER^XWBLIB S ^TMP("OR",$J,"PATIENTS",0)=""
 Q:'$D(DUZ)
 N FROM,IEN,BEG,END,API,ORSRV,ORQDAT,ORQCNT,ORGUI
 S ORSRV=$G(^VA(200,DUZ,5)) I +ORSRV>0 S ORSRV=$P(ORSRV,U) ; Get S/S.
 S FROM=$$GET^XPAR("USR^SRV.`"_+$G(ORSRV),"ORLP DEFAULT LIST SOURCE",1,"Q")
 Q:'$L($G(FROM))
 I FROM="T" S IEN=$$GET^XPAR("USR^SRV.`"_+$G(ORSRV),"ORLP DEFAULT TEAM",1,"Q") D:+$G(IEN)>0 TEAMPTS^ORQPTQ1(.Y,IEN)
 I FROM="W" S IEN=$$GET^XPAR("USR^SRV.`"_+$G(ORSRV),"ORLP DEFAULT WARD",1,"Q") D:+$G(IEN)>0 BYWARD^ORWPT(.Y,IEN)
 I FROM="P" S IEN=$$GET^XPAR("USR^SRV.`"_+$G(ORSRV),"ORLP DEFAULT PROVIDER",1,"Q") D:+$G(IEN)>0 PROVPTS^ORQPTQ2(.Y,IEN)
 I FROM="S" S IEN=$$GET^XPAR("USR^SRV.`"_+$G(ORSRV),"ORLP DEFAULT SPECIALTY",1,"Q") D:+$G(IEN)>0 SPECPTS^ORQPTQ2(.Y,IEN)
 I FROM="C" D
 .S API="ORLP DEFAULT CLINIC "_$$UP^XLFSTR($$DOW^XLFDT(DT)),IEN=$$GET^XPAR("USR^SRV.`"_+$G(ORSRV),API,1,"Q") I +$G(IEN)>0 D
 ..S BEG=$$UP^XLFSTR($$GET^XPAR("USR^SRV.`"_+$G(ORSRV)_"^DIV^SYS^PKG","ORLP DEFAULT CLINIC START DATE",1,"E"))
 ..I BEG="T+0" S BEG=$$FMTE^XLFDT(DT,BEG)
 ..S END=$$UP^XLFSTR($$GET^XPAR("USR^SRV.`"_+$G(ORSRV)_"^DIV^SYS^PKG","ORLP DEFAULT CLINIC STOP DATE",1,"E"))
 ..I END="T+0" S END=$$FMTE^XLFDT(DT,END)
 ..D CLINPTS^ORQPTQ2(.Y,+$G(IEN),BEG,END)
 I FROM="M" D
 .S IEN=$D(^OR(100.24,DUZ,0)) I +$G(IEN)>0 S IEN=DUZ D
 ..S BEG=$$UP^XLFSTR($$GET^XPAR("USR^SRV.`"_+$G(ORSRV)_"^DIV^SYS^PKG","ORLP DEFAULT CLINIC START DATE",1,"E"))
 ..I BEG="T+0" S BEG=$$FMTE^XLFDT(DT,BEG)
 ..S END=$$UP^XLFSTR($$GET^XPAR("USR^SRV.`"_+$G(ORSRV)_"^DIV^SYS^PKG","ORLP DEFAULT CLINIC STOP DATE",1,"E"))
 ..I END="T+0" S END=$$FMTE^XLFDT(DT,END)
 ..D COMBPTS^ORQPTQ6(0,+$G(IEN),BEG,END) ; "0"= GUI RPC call.
 I ($$BROKER^XWBLIB)&(FROM'="M") D  ; Combinations already written to global.
 .S ORQDAT="",ORQCNT=1
 .F  S ORQDAT=$G(Y(ORQCNT)) Q:ORQDAT=""  D
 ..S ^TMP("OR",$J,"PATIENTS",ORQCNT,0)=ORQDAT
 ..S ORQCNT=ORQCNT+1
 I ('$$BROKER^XWBLIB) S Y=FROM_";"_+$G(IEN)_";"_$G(BEG)_";"_$G(END) ; MKB 10/13/95
 Q
DEFSORT(Y) ; Return user's default sort.
 ; SLC/PKS - 4/6/2001
 ;
 N ORSORT,ORSECT,ORPARAM
 ;
 I ('$D(DUZ)) S Y="Unable to determine DUZ." Q
 S ORSECT=$G(^VA(200,DUZ,5))
 I +ORSECT>0 S ORSECT=$P(ORSECT,U)
 S Y="A" ; Default of "Alpha" sort.
 S ORPARAM="ORLP DEFAULT LIST ORDER"
 S ORSORT=$$GET^XPAR("USR^SRV.`"_$G(ORSECT)_"^DIV^SYS^PKG",ORPARAM,1,"I")
 I (ORSORT'="") S Y=ORSORT
 ;
 Q
 ;
PNAMWRIT(ORROOT,ORDFN) ; Write patient name to ^TMP global.
 ;
 ; Variables used:
 ;
 ;   ORDFN   = Passed patient DFN.
 ;   ORNAME  = Patient name.
 ;   ORROOT  = ^TMP root passed by calling code.
 ;   ORWRITE = Holder for ^TMP node for writing.
 ;
 N ORNAME,ORWRITE
 S ORROOT=ORROOT_","                       ; Add necessary comma.
 ;
 S ORNAME=""                               ; Initializae.
 S ORNAME=$G(^DPT(ORDFN,0))                ; Get zero node pt. data.
 S ORNAME=$P(ORNAME,U)                     ; Extract pt. name only.
 I ORNAME="" Q 0                           ; Problem - punt.
 ;
 ; Create naked reference string for writing to ^TMP:
 S ORWRITE=ORROOT_""""_ORNAME_""""_","_ORDFN_")"
 S @ORWRITE=ORDFN_U_ORNAME                 ; Write to ^TMP.
 ;
 Q 1
 ;
RPLMAKE(Y,ORTL) ; Make global restricted pt. array from Team List.
 ;
 ; Variables used:
 ;
 ;   ORDFN   = Holder for patient DFN.
 ;   ORJ     = Holds $J value.
 ;   ORREAD  = Holder for ^TMP root to kill.
 ;   ORRET   = Returned value from function call.
 ;   ORROOT  = ^TMP root to pass.
 ;   ORTL    = Team List IEN.
 ;   ORX     = Working variable used in $ORDER statement.
 ;   Y       = Returned value (same as ORJ).
 ;
 N ORDFN,ORJ,ORREAD,ORRET,ORROOT,ORX
 ;
 I ORTL="" S Y="" Q                        ; No Team List IEN passed.
 I $G(^OR(100.21,ORTL,0))="" S Y="" Q      ; No such Team List.
 ;
 S (ORJ,Y)=$J                              ; Assign returned value.
 S ORROOT="^TMP("_"""ORRPL"""_","          ; Initial setting.
 S ORROOT=ORROOT_ORJ_","_"""B"""           ; Add job number, "B."
 S ORREAD=ORROOT_")"                       ; Assign "kill" root.
 K @ORREAD                                 ; Kill old, if any.
 ;
 ; From Team List B x-ref, obtain patients, create new ^TMP entries:
 S ORX=""                                  ; Initialize.
 F  S ORX=$O(^OR(100.21,ORTL,10,"B",ORX)) Q:ORX=""  D
 .S ORDFN=$P(ORX,";")                      ; Extract patient DFN.
 .S ORRET=$$PNAMWRIT(ORROOT,ORDFN)         ; Call that writes to ^TMP.
 ;
 Q
 ;
RPLREAD(Y,ORJ,ORFROM,ORDIR) ; Read disk-based patient array from TMP.
 ;
 ; Variables used:
 ;
 ;   ORCNT   = Counter variable.
 ;   ORDIR   = Direction to move through list.
 ;   ORFROM  = Starting point from which to move through list.
 ;   ORI     = Counter variable.
 ;   ORIEN   = Record IEN holder.
 ;   ORJ     = Job number to use in ^TMP global root.
 ;   ORROOT  = ^TMP global file root.
 ;   ORZ     = Temporary value holder.
 ;   Y       = Returned array.
 ;
 N ORCNT,ORI,ORIEN,ORROOT,ORZ
 ;
 I $P(ORFROM,U,2)'="" S ORFROM=$P(ORFROM,U,2)
 ;
 S ORROOT="^TMP("_"""ORRPL"""_","_ORJ      ; Initial setting.
 S ORROOT=ORROOT_","_"""B"""               ; Add final text.
 ;
 ; Check for existence of data:
 I '$D(@(ORROOT_")")) S Y(0)="No data available." Q
 ;
 S ORROOT=ORROOT_","                       ; Add comma.
 S ORCNT=44                                ; Initialize to maximum.
 S ORI=0                                   ; Initialize.
 ;
 ; Loop through ^TMP entries for data to return:
 F  S ORFROM=$O(@(ORROOT_""""_ORFROM_""""_")"),ORDIR) Q:ORFROM=""  D  Q:ORI=ORCNT
 .;
 .; Sub-loop for entries up to ORCNT maximum:
 .S ORIEN=0                                ; Initialize.
 .F  S ORIEN=$O(@(ORROOT_""""_ORFROM_""""_","_ORIEN_")")) Q:'ORIEN  D  Q:ORI=ORCNT
 ..S ORI=ORI+1                             ; Increment counter.
 ..;
 ..; Assign return array:
 ..S Y(ORI)=@(ORROOT_""""_ORFROM_""""_","_ORIEN_")")
 ;
 Q
 ;
RPLCLEAN(Y,ORJ) ; Kill global data using passed global root value.
 ;
 ; Variables used:
 ;
 ;    ORJ    = Job number to use in ^TMP global root.
 ;    ORROOT = Root of ^TMP global to kill.
 ;    Y      = Returned RPC value.
 ;
 N ORROOT
 ;
 S Y=1                                     ; Initialize.
 S ORROOT="^TMP("_"""ORRPL"""_","          ; Initial setting.
 S ORROOT=ORROOT_ORJ_","_"""B"""_")"       ; Add rest.
 K @ORROOT                                 ; Kill global data.
 ;
 Q
 ;

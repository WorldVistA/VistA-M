ECMUTL1 ;ALB/ESD - Utilities for Multiple Dates/Mult Procs ;20 AUG 1997 13:56
 ;;2.0; EVENT CAPTURE ;**5,10,15,13,17,23,41,42,50,54,76**;8 May 96;Build 6
 ;
 ;
ASKPAT(ECPAT) ; Ask patient
 ;
 ;      Input:  ECPAT = patient DFN and name (passed by reference)
 ;
 ;     Output:      1 = successful
 ;                 -1 = unsuccessful (timed out or uparrowed)
 ;                 -2 = unsuccessful (returned out)
 ;
 N DIC,DUOUT,DTOUT,Y,YY,ECDUP,ECI,ECUP
SEL ;
 S (ECDUP,ECI)=0
 S DIC="^DPT(",DIC(0)="QEAMZ"
 S DIC("A")="Select Patient: "
 D ^DIC
 I Y=-1!($D(DUOUT))!($D(DTOUT)) G ASKPATQ
 ;
 ;- Create ECPLST local array to track duplicate names
 I $O(^TMP("ECPLST",$J,0)) D
 . F  S ECI=$O(^TMP("ECPLST",$J,ECI)) Q:'ECI  D
 .. I +$G(^TMP("ECPLST",$J,ECI))=+Y D
 ... S ECDUP=1
 ... W !!,"Patient already selected.  Please select another patient.",!
 I ECDUP G SEL
 I 'ECDUP D  I $G(ECUP)="^" G SEL
 . S ECPAT=+Y_"^"_$P(Y,"^",2)
 . S YY=Y,DFN=+Y,ECUP="" D 2^VADPT S Y=YY I +VADM(6) D  I ECUP="^" Q
 .. ;NOIS MWV-0603-21781: line below changed by VMP.
 .. W !!,"WARNING "_"[PATIENT DIED ON "_$P(VADM(6),U,2)_"] ",!!
 .. R "Press Return to Continue or ^ to Deselect: ",ECUP:DTIME
 . S ^TMP("ECPLST",$J,($S('$O(^TMP("ECPLST",$J,0)):1,1:$O(^TMP("ECPLST",$J,""),-1)+1)))=+Y_"^"_$P(Y,"^",2)
ASKPATQ Q $S((Y=-1)&($D(DUOUT)!$D(DTOUT)):-1,(Y=-1)&('$D(DUOUT))&('$D(DTOUT)):-2,1:1)
 ;
 ;
ASKORD() ; Ask ordering section
 ;
 ;      Input:   None
 ;
 ;     Output:   Ordering Section ien if successful
 ;               0 if not successful
 ;
 N DIR,DIRUT,Y,ECORD
 S ECORD=0
 S DIR(0)="721,11",DIR("A")="Ordering Section"
 D ^DIR
 I Y=""!($D(DIRUT)) G ASKORDQ
 S ECORD=+Y
ASKORDQ Q +ECORD
 ;
 ;
PCEDAT(ECUNIT,ECSCR,ECPCE) ;get needed PCE data
 ;
 ;   input
 ;   ECUNIT = ien of DSS unit in file #724 (required)
 ;   ECSCR = ien of event code screen in file #720.3 (required);
 ;           but may be null value
 ;   ECPCE  = array, passed by reference (required)
 ;
 ;   output
 ;   ECPCE("CLIN") = associated clinic ien in file #44^clinic name
 ;   ECPCE("DX")   = ien in file #80^icd code
 ;   ECPCE("DXS",) = array of multiple secondary diagnosis, where
 ;                 = ecpce("dxs",n)=v n=dx code and v=dx ien
 ;   ECPCE("AO")   = agent orange indicator
 ;   ECPCE("IR")   = ionizing radiation indicator
 ;   ECPCE("ENV")  = environmental contaminants indicator/south west asia
 ;   ECPCE("SC")   = service connected indicator (Y/N)
 ;   ECPCE("MST")  = military sexual trauma indicator (Y/N)
 ;   ECPCE("HNC")  = head/neck cancer indicator (Y/N)
 ;   ECPCE("CV")   = combat veteran indicator (Y/N)
 ;   ECPCE("SHAD") = P112/SHAD Shipboard Hazard and Defense) (Y/N)
 ;
 ;   returns
 ;   ECOUT  = if normal user input, then "0"
 ;            if user times-out, then "1"
 ;            if user up-arrows out, then "2"
 ;
 N SEND,ECOUT,EC4,EC4N,ECPCL,ECPCID,ECPCRD
 S ECOUT=0
 S ECSCR=+$G(ECSCR)
 S SEND=$P(^ECD(+ECUNIT,0),"^",14)
 I SEND="" S SEND="N"
 S ECPCE("CLIN")="",ECPCE("DX")="",ECPCE("AO")="",ECPCE("IR")=""
 S ECPCE("ENV")="",ECPCE("SC")="",ECPCE("MST")="",ECPCE("HNC")=""
 S ECPCE("CV")="",ECPCE("SHAD")=""
 K ECPCE("DXS")
 I "AO"[SEND D
 .;- Don't write message if Send to PCE = "O" and patient is an inpatient
 .I SEND="A"!(SEND="O"&(ECPCE("I/O")="O")) D
 ..W !!,?5,"Please Note: The following prompt(s) cannot be by-passed with"
 ..W !,?5,"<cr>, since the data is sent to PCE for workload reporting."
 ..W !,?5,"If data cannot be provided, respond with ""^"".  This will"
 ..W !,?5,"remove the current patient from the selected patient list.",!
 .D CLINIC I $G(ECOUT) D MSGCLN Q
 .D ASKDX I $G(ECOUT) D MSGDX Q
 .D VISIT I $G(ECOUT) D CLMSG Q
 I ECSCR,(ECPCE("CLIN")=""),('$G(ECOUT)) D
 .Q:'$D(^ECJ(ECSCR))
 .I ECUNIT'=$P($P(^ECJ(ECSCR,0),"^",1),"-",2) Q
 .S EC4=$P($G(^ECJ(ECSCR,"PRO")),"^",4) I +EC4 D
 ..S EC4N=$P($G(^SC(+EC4,0)),"^",1)
 ..D CLIN(EC4,.ECPCL)
 ..S:ECPCL ECPCE("CLIN")=EC4_"^"_EC4N
 ..S:'ECPCL ECPCE("CLIN")=""
 Q ECOUT
 ;
ASKDX ;ask dx
 N ECDX,ECDXN,DTOUT,DUOUT,DIRUT,DIR,Y,EC4,ECDXS
 S (ECDX,ECDXN)="",EC4=$P(ECPCE("CLIN"),U)
 D PDX^ECUTL2 I ECOUT Q
 S ECPCE("DX")=ECDX_"^"_ECDXN
 D SDX^ECUTL2 I ECOUT Q
 M ECPCE("DXS")=ECDXS
 Q
 ;
CLINIC ;get associated clinic
 N ECDATA,EC4,EC4N,ECID,ECPCL,DTOUT,DUOUT,DIRUT,DIR,Y
 Q:SEND="O"&(ECPCE("I/O")'="O")
 F  D  Q:$G(ECOUT)  Q:$G(ECPCL) 
 .K DA,DIR,DIRUT,DTOUT,DUOUT
 .S (EC4,ECPCL)=0,EC4N=""
 .S DIR(0)="721,26",DIR("A")="Associated Clinic",DIR("?")="An active clinic is required. Enter an active clinic or an ^ to exit"
 .D ^DIR
 .S:$D(DTOUT) ECOUT=1 S:$D(DUOUT) ECOUT=2
 .Q:$G(ECOUT)
 .I 'Y W !!?5,"You must enter an active clinic now.",! Q
 .I Y S EC4=+Y,ECDATA=$G(^SC(+EC4,0)),ECID=$P(ECDATA,"^",7),EC4N=$P(ECDATA,"^",1)
 .I $G(EC4) D CLIN(EC4,.ECPCL) I 'ECPCL D
 ..W !!,?5,"The clinic you selected is inactive."
 ..W !,?5,"Workload data cannot be sent to PCE for Event"
 ..W !,?5,"Capture procedures without an active clinic."
 .I 'ECPCL W !!?5,"You must enter an active clinic now.",!
 Q:'$G(ECPCL)
 S ECPCE("CLIN")=EC4_"^"_EC4N
 Q
 ;
 ;
VISIT ;ask visit info
 N ECFLG,ECCLFLDS,ECCLVAR,ECX,ECAO,ECIR,ECMST,ECSC,ECZEC,ECHNC,ECCV,ECMDT
 N ECY,ECMD,ECDT,ECSHAD
 Q:ECPCE("I/O")="I"
 S (ECAO,ECIR,ECSC,ECZEC,ECX,ECMST,ECHNC,ECCV,ECSHAD)="",ECY=0
 F  S ECY=$O(^TMP("ECMPIDX",$J,ECY)) Q:'ECY  S ECMD=^(ECY) I $P(ECMD,U,2) D
 .S ECMDT($P(ECMD,U,2))=""
 S ECDT=$O(ECMDT(0)) ;use earliest date to evaluate classifications
 ;
 ;- Ask classification questions applicable to patient and file in #721
 I $$ASKCLASS^ECUTL1(+$G(ECPAT),.ECCLFLDS,.ECOUT,SEND,ECPCE("I/O")),($O(ECCLFLDS(""))]"") D SETCLASS^ECUTL1(.ECCLFLDS)
 Q:+$G(ECOUT)
 ;
 ;- Store classification variables into ECPCE array
 F ECCLVAR="ECAO","ECIR","ECZEC","ECSC","ECMST","ECHNC","ECCV","ECSHAD" I @($G(ECCLVAR))]"" S ECPCE($S($E(ECCLVAR,3,$L(ECCLVAR))'="ZEC":$E(ECCLVAR,3,$L(ECCLVAR)),1:"ENV"))=@ECCLVAR
 Q
 ;
 ;
CLIN(EC4,ECPCL) ;check for active associated clinic
 N ECPCID,ECPCRD
 D CLIN^ECPCEU
 Q
 ;
 ;
MSGDX ;if ecout & essential data missing, display msg
 Q:SEND="N"  Q:SEND="O"&(ECPCE("I/O")'="O")
 I ECPCE("DX")="" D  Q
 .W !!,?5,"Please note that data cannot be sent to PCE"
 .W !,?5,"for workload reporting without an ICD-9 code.",!
 .D MSG1
 Q
 ;
MSGCLN ;if ecout & essential data missing, display msg
 Q:SEND="N"  Q:SEND="O"&(ECPCE("I/O")'="O")
 I ECPCE("CLIN")="" D  Q
 .W !!,?5,"Please note that data cannot be sent to PCE for workload"
 .W !,?5,"reporting without an active associated clinic.",!
 .D MSG1
 Q
 ;
CLMSG ; Display classification questions error message
 Q:SEND="N"  Q:ECPCE("I/O")'="O"
 W !!,?5,"Please note that data cannot be sent to PCE for workload reporting"
 W !,?5,"unless the classification questions are answered.",!
 D MSG1
 Q
 ;
 ;
MSG1 ;Error message display
 N DIR,Y
 S DIR(0)="E",DIR("A")="Press RETURN to continue"
 D ^DIR
 W !
 Q
 ;
 ;
INOUT(ECPTIEN,ECARRY) ; Determine inpatient/outpatient status
 ;
 N ECOUT
 S ECOUT=0
 S ECARRY=$G(ECARRY)
 S ECPTIEN=+$G(ECPTIEN)
 ;
 ; - If ECARRY not defined, use ^TMP("ECMPIDX",$J)
 S:(ECARRY="") ECARRY="^TMP(""ECMPIDX"",$J)"
 ;
 S ECPCE("I/O")=$$INOUTPT^ECUTL0(ECPTIEN,+$P(@ECARRY@(+$O(@ECARRY@(""),-1)),"^",2))
 I ECPCE("I/O")="" D INOUTERR^ECUTL0
 Q $S(+$G(ECOUT)=0:1,1:0)
 ;
 ;
ASKELIG(ECDSS,ECIO,ECPTIEN) ; Determine patient eligibility
 ;
 ;   Input:
 ;      ECDSS - DSS Unit IEN
 ;      ECIO - Inpatient or Outpatient
 ;      ECPTIEN - DFN of Patient file (#2)
 ;
 ;  Output:
 ;      ECPCE("ELIG") - containing patient eligibility
 ;
 N VAEL
 S ECDSS=+$G(ECDSS)
 S ECIO=$G(ECIO)
 S ECPTIEN=+$G(ECPTIEN)
 ;
 ;- Get elig if Send to PCE="A" or Send to PCE="O" and outpatient
 I $$CHKDSS^ECUTL0(+$G(ECDSS),ECIO) D
 . ;
 . ;- If dual elig, ask user to select otherwise use primary elig
 . I $$MULTELG^ECUTL0(+$G(ECPTIEN)) S ECPCE("ELIG")=+$$ELGLST^ECUTL0
 . E  S ECPCE("ELIG")=+$G(VAEL(1))
 Q
 ;
REMOVE(ECPAT) ; Remove patient from selected patient list because required data missing
 N DFN,ECI
 S DFN=+ECPAT,ECI=0
 F  S ECI=$O(^TMP("ECPLST",$J,ECI)) Q:'ECI  D
 .I +$G(^TMP("ECPLST",$J,ECI))=DFN D
 ..K ^TMP("ECPLST",$J,ECI),^TMP("ECMPTIDX",$J,ECI),^TMP("ECPAT",$J,DFN)
 ..W !?5,"Patient deselected because required data missing.",!
 ..D MSG1
 Q

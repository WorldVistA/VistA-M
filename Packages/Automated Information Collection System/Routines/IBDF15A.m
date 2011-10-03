IBDF15A ;ALB/CJM - AICS FORM USE BY DIVISION/CLINIC ; JUL 20,1993
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
 ; -- prints for each encounter form the clinics using it
 ;
PRINT ; -- Main print driver
 W:$E(IOST,1,2)="C-" @IOF
 S FORMNAM="" F  S FORMNAM=$O(^IBE(357,"B",FORMNAM)) Q:FORMNAM=""  S FORM=$O(^IBE(357,"B",FORMNAM,0)) Q:'FORM  D  Q:IBQUIT
 .Q:$P($G(^IBE(357,FORM,0)),"^",7)  ;exclude toolkit forms
 .D CLINIC(FORM,FORMNAM)
 D LIST
 I $E(IOST,1,2)="C-",'IBQUIT D PAUSE
 Q
 ;
CLINIC(FORM,FORMNAM) ;
 ; -- finds the list of clinics using FORM
 ;    ^TMP($J,"IBDCS",0) is number of clinics found
 ;    ^TMP($J,"IBDCS",divname, div pointer, form name, form pointer,
 ;                 clinic name)=clinic pointer := is list of clinics
 ;
 N CLINIC,SETUP,IDX,CLNAME,DIVIS,DIVNAM,CNT
 F IDX="C","D","E","F","G","H","I","J" D
 .S SETUP="" F  S SETUP=$O(^SD(409.95,IDX,FORM,SETUP)) Q:'SETUP  D
 ..S CLINIC=$P($G(^SD(409.95,SETUP,0)),"^",1)
 ..Q:'CLINIC
 ..S CLNAME=$P($G(^SC(CLINIC,0)),"^",1)
 ..Q:CLNAME=""
 ..S DIVIS=$P($G(^SC(CLINIC,0)),"^",15)
 ..I DIVIS="" S DIVIS=$S(MULTI=0:$$PRIM^VASITE,1:"Unknown")
 ..S DIVNAM=$P($G(^DG(40.8,+DIVIS,0)),"^")
 ..S:DIVNAM="" DIVNAM="Unknown"
 ..S CNT=$G(CNT)+1
 ..S ^TMP($J,"IBDCS",DIVNAM,+$G(DIVIS),FORMNAM,FORM,CLNAME)=CLINIC_"^"_IDX
 ..S ^TMP($J,"IBDCS",DIVNAM,+$G(DIVIS))=$G(^TMP($J,"IBDCS",DIVNAM,+$G(DIVIS)))+1
 S:$G(CNT)<1 ^TMP($J,"IBDCN",FORMNAM,FORM)="" ;forms not in use
 Q
 ;
LIST ; -- lists the clinics using FORM
 N DIVNAM,DIVIS,FORMNAM,FORM,CLNAME,CLINIC,NEWDIV,IBDONE,IDX
 ;
 ; -- list forms not in use
 S DIVNAM="",NEWDIV=0
 F  S DIVNAM=$O(^TMP($J,"IBDCS",DIVNAM)) Q:DIVNAM=""!(IBQUIT)  S DIVIS=+$O(^TMP($J,"IBDCS",DIVNAM,"")) I VAUTD=1!($D(VAUTD(DIVIS))) D
 .;
 .S NEWDIV=1
 .K IBDONE
 .S FORMNAM=""
 .F  S FORMNAM=$O(^TMP($J,"IBDCS",DIVNAM,DIVIS,FORMNAM)) Q:FORMNAM=""!(IBQUIT)  S FORM=$O(^TMP($J,"IBDCS",DIVNAM,DIVIS,FORMNAM,0)) D
 ..;
 ..S CLNAME=""
 ..F  S CLNAME=$O(^TMP($J,"IBDCS",DIVNAM,DIVIS,FORMNAM,FORM,CLNAME)) Q:CLNAME=""!(IBQUIT)  S CLINIC=+^(CLNAME),IDX=$P(^(CLNAME),"^",2) I '$D(IBDONE(FORM)) W ! D LINEONE,ALL(FORMNAM,CLNAME,DIVNAM)
 ;
 ; -- list forms not in use
 S FORMNAM="",NEWDIV=1,DIVNAM="FORMS NOT IN USE"
 F  S FORMNAM=$O(^TMP($J,"IBDCN",FORMNAM)) Q:FORMNAM=""!(IBQUIT)  S FORM=$O(^TMP($J,"IBDCN",FORMNAM,0)) D LINETWO
 Q
 ;
LINEONE ; -- print on report header, lines, etc.
 ;
 I NEWDIV D HEADER Q:IBQUIT  W !,?10,"Division: ",DIVNAM S NEWDIV=0
 I $Y>(IOSL-3) D HEADER Q:IBQUIT
 W !,FORMNAM,?32,$E(CLNAME,1,25),?59,$E(DIVNAM,1,20),?81,$$TYPE(IDX)
 I '$$ACLN^IBDFCNOF(CLINIC) W ?100,"  (Clinic Currently Inactive)"
 S IBDONE(FORM)=""
 Q
 ;
LINETWO ; -- print lines for forms not in use
 I NEWDIV D HEADER Q:IBQUIT  S NEWDIV=0
 I $Y>(IOSL-3) D HEADER Q:IBQUIT
 W !,FORMNAM,?32,"** NOT IN USE **"
 Q
 ;
LINETHR ; -- print lines for clinics in other divisions
 I $Y>(IOSL-3) D HEADER Q:IBQUIT
 W !,?32,CLNAME,?59,$E(DIVNAM,1,20),?81,$$TYPE(IDX)
 I '$$ACLN^IBDFCNOF(CLINIC) W ?100,"  (Clinic Currently Inactive)"
 Q
 ;
ALL(FORMNAM,CL1,DV1) ;
 ; -- find all clinics using for irregardless of division
 ;    stored in ^TMP($J,"IBDCS",DIVNAM,DIVIS,FORMNAM,FORM,CLNAME)
 ;
 N FORM,CLNAME,DIVNAM,DIVIS
 S DIVNAM=""
 F  S DIVNAM=$O(^TMP($J,"IBDCS",DIVNAM)) Q:DIVNAM=""!(IBQUIT)  S DIVIS=+$O(^TMP($J,"IBDCS",DIVNAM,"")) I VAUTD=1!($D(VAUTD(DIVIS))) D
 .S FORM=+$O(^TMP($J,"IBDCS",DIVNAM,DIVIS,FORMNAM,0))
 .S CLNAME="" F  S CLNAME=$O(^TMP($J,"IBDCS",DIVNAM,DIVIS,FORMNAM,FORM,CLNAME)) Q:CLNAME=""!(IBQUIT)  S CLINIC=+^(CLNAME) D
 ..Q:CL1=CLNAME&(DV1=DIVNAM)
 ..D LINETHR
 Q
 ;
 ;S FORM=$O(^TMP($J,"IBDCL",FORMNAM,0))
 ;S CLNAME="" F  S CLNAME=$O(^TMP($J,"IBDCL",FORMNAM,FORM,CLNAME)) Q:CLNAME=""!(IBQUIT)  D
 ;.S DIVNAM="" F  S DIVNAM=$O(^TMP($J,"IBDCL",FORMNAM,FORM,CLNAME,DIVNAM)) Q:DIVNAM=""!(IBQUIT)  D
 ;..Q:CL1=CLNAME&(DV1=DIVNAM)
 ;..D LINETHR
 Q
 ;
HEADER ; -- writes the report header
 I $E(IOST,1,2)="C-",$Y>1,PAGE>1 D PAUSE Q:IBQUIT
 I PAGE>1 W @IOF
 W !,"List of Encounter Forms and their Use by Clinics",?IOM-30,IBHDT,"  PAGE ",PAGE
 W !,"For Division: ",$G(DIVNAM)
 W !,"FORM NAME",?32,"CLINIC",?59,"DIVISION",?81,"FORM USAGE"
 W !,$TR($J(" ",IOM)," ","-")
 S PAGE=PAGE+1
 Q
 ;
PAUSE ; -- hold screen
 N DIR,X,Y
 F  Q:$Y>(IOSL-2)  W !
 S DIR(0)="E" D ^DIR S IBQUIT=$S(+Y:0,1:1)
 Q
 ;
TYPE(IDX) ;
 ; -- type of form
 ;    input cross reference from print Manager Clinic Setups (409.95)
 ;    output name of type of form
 ;    IDX="C","D","E","F","G","H","I","J"
 ;
 N X
 S IDX=$E(IDX,1)
 S X="" I IDX="" G TYPEQ
 S X=$S(IDX="C":"Basic Form",IDX="D":"Supplmntl form - Establshed Pt.",IDX="E":"Supplmntl Form - First Visit",IDX="F":"Form w/o Patient Data",IDX="G":"Supplmntl Form #1",1:"")
 I X="" S X=$S(IDX="H":"Reserved",IDX="I":"Supplmntl Form #2",IDX="J":"Supplmntl Form #3",1:"")
TYPEQ   Q X

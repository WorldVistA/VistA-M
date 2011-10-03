PRSEEMP4 ;WIRMFO/JAH-STUDENT TRAINING REPORT BY SERVICE ;7/2/97
 ;;4.0;PAID;**25**;Sep 21, 1995
 ;
 ;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SORT(PRDA) ;
 ;
 ;PRDA = ptr 2 file 200 from PAID EMPLOYEE file, (new person field).
 ;
 I $E(IOST,1,2)="C-" S CLOCK=$$HUMDRUM^PRSLIB00(CLOCK,1)
 ;
 ;convert PRDA 2 name in file 200
 S N1=$P($G(^VA(200,PRDA,0)),"^")
 I N1="" D
 .S N1="*"_EMPNAME,^TMP("EORM",$J,1)="* Names missing resolution from PAID EMPLOYEE file to the NEW PERSON file."
 ;
 ;create 0 node 4 everyone whether they have data or not
 S ^TMP($J,SERVIEN,CCORG,EMPIEN,0)="0^^"_N1
 S SSN=$P($G(^VA(200,+PRDA,1)),U,9)
 I SSN="" S $P(^TMP($J,SERVIEN,CCORG,EMPIEN,0),"^",2)=0
 Q:SSN=""
 S PRDA(1)=+$O(^PRSPC("SSN",SSN,0))
 ;
 ;get job code & find it's readable 4mat.
 S PRSETL=""
 ;job code = piece 17 of emp record or = 0 if no code is found.
 S JOBCODE=$S($P($G(^PRSPC(PRDA(1),0)),U,17)'="":$P($G(^(0)),U,17),1:0)
 ;store job code & readable 4mat 4 later output
 S PRSETL=$$EN12^PRSEUTL2(JOBCODE)
 S $P(^TMP($J,SERVIEN,CCORG,EMPIEN,0),"^",2)=JOBCODE
 I JOBCODE S ^TMP("JOBS",$J,JOBCODE)=PRSETL
 ;
 ;sort thru X-ref corresponding 2 training user asked 2 c.
 ;
 I PRSESEL="L" F PRSE="C","O","W" D SORT1(PRSE) ;all but mandatory
 ;all but hospital wide OR all
 I PRSESEL="H"!(PRSESEL="A") F PRSE="C","O","W","M" D SORT1(PRSE)
 I PRSESEL'="A",PRSESEL'="L",PRSESEL'="H" D
 . S PRSE=PRSESEL D SORT1(PRSE) ;single type
 Q
 ;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
HWLIST ;build list of classes that are hospital wide
 ;
 N SERV,MIIEN,CLSPTR,CLSMLT
 ;VARIABLES
 ;  HWIDE() - RETURNED:
 ;          = Subscripted by name of the class. Value is entry #s.
 ;  SERV = service name in file 454.1
 ;  MIEN   = IEN in Mandatory Training Group file
 ;  CLSPTR = Pointer to class file.
 ;  CLSMLT = IENs in mandatory class multiple.
 ;
 S MIEN=0
 F  S MIEN=$O(^PRSE(452.3,MIEN))  Q:MIEN'>0  D
 .  S SERV=$P($G(^PRSE(452.3,MIEN,0)),"^",2)
 .  I SERV'="",$P($G(^PRSP(454.1,SERV,0)),"^",1)="MISCELLANEOUS" D
 ..   S CLSMLT=0
 ..   F  S CLSMLT=$O(^PRSE(452.3,MIEN,1,CLSMLT))  Q:CLSMLT'>0  D
 ...     S CLSPTR=$G(^PRSE(452.3,MIEN,1,CLSMLT,0))
 ...     I CLSPTR'="" S HWIDE(CLSPTR)=$P($G(^PRSE(452.1,CLSPTR,0)),"^",1)
 Q
 ;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
HASHLIST ;Reverse array list 4 faster hashing in sort routine.
 ; i.e. change HWIDE(3)="DIVERSITY IN WP"... HWIDE("DIVERSITY IN WP")=3
 ;
 S NODE=""
 F  S NODE=$O(HWIDE(NODE))  Q:NODE'>0  D
 .  I HWIDE(NODE)'="" S HWIDE(HWIDE(NODE))=NODE
 .  K HWIDE(NODE)
 Q
 ;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SORT1(PRSE) ;Loop thru training data in AA x-ref & sort in2 ^TMP
 ;
 ;   VARIABLES
 ; COUNT      = # of classes, current type
 ; CRS        = Course Title
 ; CURR       = Current subtotl, all classes taken by employee
 ; NCD        = Regular FM date
 ; NCD1       = Inverse FileMan date
 ; PRDA       = Employee's IEN in file 200.  (built into AA x-ref)
 ; PRSE       = Type of training (mandatory, cont. educ)
 ; PRSECLS(0) = Ien of course in the PROGRAM CLASS file
 ; YRST,YREND = Start,end date range returned from DATSEL^PRSEUTL call.
 ;
 N CRS,COUNT,CURR S COUNT=0
 ;
 ;outer loop thru courses (CRS) of type PRSE taken by employee (PRDA)
 S CRS=""
 F  S CRS=$O(^PRSE(452,"AA",PRSE,PRDA,CRS))  Q:CRS=""  D
 .   Q:'$D(^PRSE(452,"AA",PRSE,PRDA,CRS))
 .;
 .   ;screen out hospital wide classes if user selected "H"
 .   I PRSESEL="H",$G(HWIDE(CRS))'="" Q
 .;
 .;  loop thru dates that student took this class
 .   F NCD1=0:0 S NCD1=$O(^PRSE(452,"AA",PRSE,PRDA,CRS,NCD1)) Q:NCD1'>0  D
 ..;   convert inverse FM date of class 2 FM date
 ..    S NCD=(9999999.0000-NCD1)
 ..;
 ..;   get ien of the entry in the student education file.
 ..    S DA(2)=$O(^PRSE(452,"AA",PRSE,PRDA,CRS,NCD1,0))
 ..    Q:DA(2)'>0
 ..    S:$G(NSORT)="" NSORT=1
 ..;   
 ..;   quit if the class is outside selected date range
 ..    I (NCD>YREND)!(NCD<YRST) Q
 ..;
 ..    N X
 ..    S PRDATA=$G(^PRSE(452,DA(2),0))
 ..    S X=$G(^TMP($J,SERVIEN,CCORG,EMPIEN,"L",CRS))
 ..    I X="" D
 ...     S X=NSORT,NSORT=NSORT+1
 ...     S ^TMP($J,SERVIEN,CCORG,EMPIEN,"L",CRS)=X
 ..;
 ..;   get ien of course in the PROGRAM CLASS file
 ..    S PRSECLS(0)=+$O(^PRSE(452.1,"B",CRS,0))
 ..;
 ..;
 ..    S ^TMP($J,SERVIEN,CCORG,EMPIEN,"L1",X,N1,NCD,DA(2))=$S(+$G(PRSECLS(0))>0:$P($G(^PRSE(452.1,PRSECLS(0),0)),U,3),1:$P(PRDATA,U,16))_U_$P(PRDATA,U,6)_U_$P(PRDATA,U,10)_U_$P(PRDATA,U,21)
 ..;
 ..;incremnt employee 0 node. Check later 2 c if no training occured.
 ..S COUNT=COUNT+1
 ;
 ;add class count to employees node
 S CURR=$P(^TMP($J,SERVIEN,CCORG,EMPIEN,0),"^")
 S $P(^TMP($J,SERVIEN,CCORG,EMPIEN,0),"^",1)=CURR+COUNT
 Q
 ;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 ;
OUTPUT(PRDA,POUT,JOBCODE,EMPNAME) ;
 ;routine loops thru tmp global, prints classes 4 1 employee.
 N PRHLOC S POUT=0
 ;
 ;If class counter for employee is 0, write message and quit
 I $P(^TMP($J,SERVIEN,CCORG,EMPIEN,0),"^",1)=0 D  Q
 .  D NHDR^PRSEEMP4(JOBCODE,.POUT)
 .  W !,"NO DATA FOR EMPLOYEE: ",EMPNAME
 .  W:$G(PRSECLS)]"" !,"CLASS: ",PRSECLS
 ;
 D NHDR^PRSEEMP4(JOBCODE,.POUT)
 ;
 S NIC=""
 F  S NIC=$O(^TMP($J,SERVIEN,CCORG,EMPIEN,"L",NIC)) Q:NIC=""!POUT  S NSORT=$G(^TMP($J,SERVIEN,CCORG,EMPIEN,"L",NIC)),HOLD=1 D:NSORT
 .;
 .  S N1=""
 .  F  S N1=$O(^TMP($J,SERVIEN,CCORG,EMPIEN,"L1",NSORT,N1)) Q:N1=""!POUT  D
 ..   S NCD=""
 ..   F  S NCD=$O(^TMP($J,SERVIEN,CCORG,EMPIEN,"L1",NSORT,N1,NCD)) Q:NCD=""!POUT  D
 ...    S DA=$O(^TMP($J,SERVIEN,CCORG,EMPIEN,"L1",NSORT,N1,NCD,0))
 ...    Q:DA'>0
 ...    I ('(NSW1>0)!($Y>(IOSL-7))) D NHDR(JOBCODE,.POUT) Q:POUT
 ...    S PCOUNT=PCOUNT+1
 ...    S PRDATA=$G(^TMP($J,SERVIEN,CCORG,EMPIEN,"L1",NSORT,N1,NCD,DA))
 ...    S PHRS=(PHRS+$P(PRDATA,U))
 ...    I $P(PRDATA,U,4)="C" D
 ....     S PHRS("CEU")=(PHRS("CEU")+$P(PRDATA,U,2))
 ....     S PHRS("CON")=(PHRS("CON")+$P(PRDATA,U,3))
 ...    I HOLD=1 D
 ....     W !,$S(PRSE132:NIC,1:$E(NIC,1,25))
 ....     W:$P($G(^PRSE(452,DA,6)),U,2)'="" ?$S(PRSE132:55,1:27),$E($P(^(6),U,2),1,25)
 ....     W ?$S(PRSE132:93,1:47),"Length: "
 ....     W $S($P(PRDATA,U)>0:$J($P(PRDATA,U),4,2),1:"")
 ....     S HOLD=0
 ...    S Y=$E(NCD,1,7) D:+Y D^DIQ W ?$S(PRSE132:114,1:67),$P(Y,"@"),!
 ...    I $P(PRDATA,U,4)="C" W ?1,"CEUs: ",+$P(PRDATA,U,2),?$S(PRSE132:88,1:42),"Contact HRS: ",$J($P(PRDATA,U,3),4,2)
 ...    Q
 .  S HOLD=1 Q
 ;
 Q:POUT
 W !,$$REPEAT^XLFSTR("-",$G(IOM))
 ;
 ;Output totals 4 1 employee.
 W !,?1,"Total Classes: ",PCOUNT,?$S(PRSE132:78,1:35)
 W "Total Length/Hours:",$J(PHRS,7,2)
 ;
 ;Display CEU totals if type of training sort criteria 
 ;contains CEU classes.
 I CEU D
 . W !,?4,"Total CEUs:",$J(PHRS("CEU"),6,2),?$S(PRSE132:77,1:34)
 . W "Total Contact Hours:",$J(PHRS("CON"),7,2)
 ;
 W !,$$REPEAT^XLFSTR("-",$G(IOM))
 ;
 Q
 ;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NHDR(JOBCODE,POUT) ;
 ;
 ;  NPC = page counter.
 ;
 S POUT=0
 N Z S Z=PRSESEL
 ;start a new page and a full header.
 I $E(IOST,1,2)="C-" S POUT=$$ASK^PRSLIB00() Q:POUT
 W @IOF S NPC=NPC+1
 S PTAB=IOM-9
 W $S(Z="L":"ALL BUT MANDATORY",Z="H":"ALL BUT HOSPITAL WIDE MANDATORY",Z="C":"C.E.",Z="M":"M.I.",Z="O":"OTHER",Z="W":"WARD",1:"COMPLETE")
 W " TRAINING REPORT FOR "
 W $S(TYP="C":"CY ",TYP="F":"FY ",1:" ")
 W $S(TYP="C"!(TYP="F"):$G(PYR),1:$G(YRST(1))_" - "_$G(YREND(1)))
 W ?PTAB,"PAGE: ",NPC
 W !
 W "Service: ",$S(PRSE132:SERVICE,1:$E(SERVICE,1,16))
 W "  Cost Ctr./Org.: ",$E(CCORG,1,4),":",$E(CCORG,5,8)
 S Y=REPDT D:+Y D^DIQ W ?(IOM-13),Y
 ;
 ;print employees name and title portion of header
 W !,"Name: ",$S(PRSE132:EMPNAME,1:$E(EMPNAME,1,20))
 W "  Title: "
 ;decipher job code from temporary table
 S PRSETL=$G(^TMP("JOBS",$J,JOBCODE))
 W $S(PRSETL="":"<Unknown>",1:$S(PRSE132:$E(PRSETL,1,40),1:$E(PRSETL,1,20)))
 I PRSE132 D
 .W !,"Class Name",?55,"Class Presenter",?114,"Date"
 E  D
 .W !,"Class Name",?30,"Class Presenter",?67,"Date"
 S NI="",$P(NI,"-",$S(PRSE132:133,1:81))=""
 W !,NI
 Q:$O(^TMP($J,SERVIEN,CCORG,EMPIEN,"L",""))=""
 S (HOLD,NSW1)=1
 Q
 ;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
EXIT K ^TMP($J),^TMP("JOBS",$J),^TMP("EORM",$J) D CLOSE^PRSEUTL,^PRSEKILL
 Q
 ;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

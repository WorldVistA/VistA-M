PRS8TL1 ;HISC/MRL-DECOMPOSITION, SELECTIVE T&L, CONT. ;2/26/93  14:35
 ;;4.0;PAID;;Sep 21, 1995
 ;
 ;This routine is a continuation of PRS8TL.  This portion of the
 ;routine actually loops through file 450 and locates the entries
 ;identified by the user.  If the user has decided to only show
 ;the information currently stored it is located in file 458 and
 ;displayed.  If decomposition has been selected and the record has
 ;not yet been transmitted the record will be decomposed and then
 ;the information (old and new) will be displayed.
 ;
 ;Called by Routines:  PRS8TL
 ;
 D TOP F TLU2=0:0 S NAME=$O(^PRSPC("ATL"_TLU,NAME)),DFN=0 Q:NAME=""!(PRS8("QUIT"))  D
 .F TLU3=0:0 S DFN=$O(^PRSPC("ATL"_TLU,NAME,DFN)) Q:'DFN!(PRS8("QUIT"))  D  W !
 ..S X=$G(IOSL) S:'X X=24 S X=X-8 I $Y>X,'PRS8("QUIT") D TOP
 ..Q:PRS8("QUIT")
 ..S X=$G(^PRST(458,+PY,"E",+DFN,0)) I X="" Q  ;no record for this pp
 ..W !,$E($P(NAME,",",1)_","_$E($P(NAME,",",2)),1,25)
 ..S X1=$P($G(^PRSPC(+DFN,0)),"^",9) I X1="" S X1="XXXXXXXXX"
 ..W ?30,$E(X1,1,3)_"-"_$E(X1,4,5)_"-"_$E(X1,6,9)
 ..S X1=$P(X,"^",2)
 ..W ?45,$S(X1="P":"Released to Payroll",X1="X":"Transmitted to Austin",1:"T&L still updating Record")
 ..I X1="" W !?6,"|OLD|  Record has not been released to Payroll...Cannot Decompose..." Q
 ..S VALUE=$G(^PRST(458,+PY,"E",+DFN,5))
 ..W !?6,"|OLD|  ",$S(VALUE'="":VALUE,1:"No Decomposition currently on File")
 ..Q:SHOW
 ..I X1="X"!(VALUE'=""&('DECOM)) W !?6,"|NEW|  " D  Q
 ...I X1="X" W "Record already Transmitted...Cannot update Decomposition..." Q
 ...W "Record already decomposed <see above>...Not updated per user..."
 ..D UP
 ..S VALUE(1)=$G(^PRST(458,+PY,"E",+DFN,5))
 ..W !?6,"|NEW| ",$S(VALUE(1)=VALUE:" ",1:"*"),VALUE(1)
 Q
 ;
UP ; --- decompose
 S PPI=PY
 N PRS8,SHOW,VALUE,PY
 S (SEE,SHOW)=0,SAVE=1
 D ONE^PRS8
 Q
 ;
TOP ; --- Top of Form
 S PRS8("PAGE")=PRS8("PAGE")+1
 I PRS8("PAGE")>1 D
 .F I=$Y:1:(IOSL)-6 W !
 .D BOT
 I PRS8("QUIT") Q
 W @IOF S X="Decomposition Report for T&L '"_TLU_"'" D CTR
 S X="Pay Period "_PY(0) D CTR
 W !!,"Employee Name",?30,"SSN",?45,"Current T&A Status",!
 S X="",$P(X,"-",(IOM-1))="" W X Q
 ;
BOT ; --- bottom of form
 I IOST["C-" D  Q
 .R !!,"Press <RETURN> to Continue, Enter '^' to QUIT:  ",X:DTIME
 .I X["^"!('$T) S PRS8("QUIT")=1
 S X="",$P(X,"=",(IOM-1))="" W !!,X
 W !,PRS8("WHO") S X="Page "_PRS8("PAGE") D CTR1
 W ?(IOM-($L(PRS8("DATE"))+2)),PRS8("DATE"),! Q
 ;
COVER ; --- cover page
 D NOW^%DTC S Y=% X ^DD("DD") S PRS8("DATE")=Y
 S X=$P($G(^VA(200,+$G(DUZ),0)),"^",1) ;user
 S PRS8("WHO")=$S(X'="":X,1:"REQUESTOR UNKNOWN")
 S (PRS8("PAGE"),PRS8("QUIT"))=0
 I IOST["C-" Q
 F I=1:1:10 W !
 S X="D E C O M P O S I T I O N    A C T I V I T Y   R E P O R T" D CTR
 F I=1:1:5 W !
 S X="Date/Time Started",X1=PRS8("DATE") D FORM
 S X="User Initiating Report",X1=PRS8("WHO") D FORM
 W !!! S X="S E A R C H   P A R A M E T E R S" D CTR
 W !! S X="Report is Run for Pay Period",X1=PY(0) D FORM
 S X="Decompose or Show Data",X1=$S(SHOW:"SHOW",1:"DECOMPOSE") D FORM
 I 'SHOW S X=$S(DECOM:"",1:"*")_"Decompose All Records",X1=$S(DECOM:"YES",1:"NO") D FORM
 S X="Process All Records",X1=$S($O(TLU(0))]"":"NO",1:"YES") D FORM
 I $O(TLU(0))]"" D
 .W ! S X="The following T&L's are processed in this Report:",X1="" D CTR
 .S X="",CT=0,J="" F I=0:0 S J=$O(TLU(J)) Q:J=""  D
 ..S CT=CT+1 I (CT*10)>(IOM-10)  S CT=1 D CTR S X=""
 ..S X=X_J_"       "
 .D CTR:X'=""
 W !! S X="",$P(X,80)="" D CTR
 S X="NOTE:  Records which have not been released to Payroll are never Decomposed." D CTR
 S X="Additionally, records which have been  Transmitted to Austin are not Decomposed." D CTR
 Q:DECOM!SHOW
 W ! S X="* You have chosen the  feature which will  not initiate a  decomposition run for" D CTR
 S X="any record already having been previously decomposed.                           " D CTR
 Q
 ;
FORM ; --- format X and X1 then fall into CTR (Center)
 S X=$E(X_"...............................",1,50)_" "
 S X1=$E(X1,1,20),X1=$J(X1,10),X=X_X1
 ;
CTR ; --- center
 W !
 ;
CTR1 ; --- center but don't write line feed
 W ?(IOM-$L(X)\2),X
 K X,X1 Q

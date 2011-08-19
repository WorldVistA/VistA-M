IVMUCHK5 ;ALB/CAW Edit Checks con't ; 9/29/94
 ;;2.0;INCOME VERIFICATION MATCH;**10**; 21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; This routine is a continuation of IVMUCHK.  It performs checks on incoming means test
 ; transmissions to ensure they are accurate prior to their upload into DHCP.
 ;
 ;
MT(STRING,INCOME) ; Calculate means test status
 ;
 N X,Y,ADJ,INC,NET,THRESH S STATUS="C"
 S X=$P(STRING,HLFS,3) I X'="A",(X'="C") S ERROR="Invalid Means Test Status" G MTQ
 ;
 S X=$E($P(STRING,HLFS,2),1,4),%DT="" D ^%DT S X=Y K %DT
 S THRESH=$G(^DG(43,1,"MT",X,0))
 S THRESHT=$P(THRESH,U,2) I $P(STRING,HLFS,12) S THRESHT=THRESHT+$P(THRESH,U,3)+(($P(STRING,HLFS,12)-1)*$P(THRESH,U,4))
 ;
 S CAT=$P(STRING,HLFS,3)
 S ADJ=$P(STRING,HLFS,6)
 S INC=$P(STRING,HLFS,4)-$P(STRING,HLFS,9)
 S NET=$P(STRING,HLFS,5)
 S THRESHA=$P(STRING,HLFS,8)
 I THRESHT'=THRESHA S ERROR="Threshold A value incorrect" G MTQ
 I INC'>THRESHA D  I ERROR]"" G MTQ
 . I NET']"" S ERROR="This veteran requires net worth" Q
 . I ((INC+NET)'>$P(THRESH,U,8))&(CAT="C") S ERROR="Income plus net worth not greater than threshold value-incorrect status" Q
 . I ((INC+NET)'<$P(THRESH,U,8))&(CAT="C"),'$P(STRING,HLFS,6) S ERROR="Patient should be adjudicated-no adjudicated date/time" Q
 I INC>THRESHA,CAT'="C" S ERROR="Incorrect means test status"
MTQ Q
 ;
INC ; gather income totals
 N DEBD,DEB,DEBT,DGX,EXCL,INC,NET,X,Y
 I $P(STRING,HLFS,4)']"" S ERROR="No Income transmitted"
 S INC=$P(ARRAY("ZIC"),HLFS,21),DEBT=$P(ARRAY("ZIC"),HLFS,22),NET=$P(ARRAY("ZIC"),HLFS,23)
 S DGX=0 F  S DGX=$O(ARRAY(DGX)) Q:'DGX  D
 .S INC=INC+($P(ARRAY(DGX,"ZIC"),HLFS,21))
 .S NET=NET+($P(ARRAY(DGX,"ZIC"),HLFS,23))
 .I $P(ARRAY(DGX,"ZDP"),U,6)'=2 D  Q
 ..S X=$E($P(ARRAY("ZMT"),U,2),1,4),%DT="" D ^%DT S INCYR=Y
 ..S EXCL=$P($G(^DG(43,1,"MT",INCYR,0)),U,17)
 ..S DEBD=($P(ARRAY(DGX,"ZIC"),HLFS,9)-EXCL-$P(ARRAY(DGX,"ZIC"),HLFS,15))
 ..S DEBD=$S(DEBD>0:DEBD,1:0)
 ..S DEB=($P(ARRAY(DGX,"ZIC"),HLFS,9)-DEBD)
 ..S DEBT=DEBT+DEB
 .S DEBT=DEBT+($P(ARRAY(DGX,"ZIC"),HLFS,22))
 I +INC'=+$P(STRING,HLFS,4) S ERROR="Income total does not match Income total on means test" G INCQ
 I +DEBT'=+$P(STRING,HLFS,9) S ERROR="Deductible Expenses total does not match Deductible Expenses total on means test" G INCQ
 I +NET'=+$P(STRING,HLFS,5) S ERROR="Net Worth total does not match Net Worth total on means test" G INCQ
INCQ Q
 ;
SIGN ; Date Veteran Signed/Refused to Sign
 I $P(STRING,HLFS,15)]"" D  G:ERROR]"" SIGNQ
 .S X=$P(STRING,HLFS,15) I $E(X,1,4)<1994!($E(X,1,4)>($E(DT,1,3)+1700)) S ERROR="Invalid Date Veteran Signed Test" Q
 .S X=$$FMDATE^HLFNC($P(STRING,HLFS,15)),%DT="X" D ^%DT I Y<0 S ERROR="Invalid Date Veteran Signed Test" Q
 .I $P(STRING,HLFS,20)]"" S ERROR="Veteran Signed Test, IVM Complete Date should be blank" Q
 I $P(STRING,HLFS,15)']"" D
 .I $P(STRING,HLFS,20)']"" S ERROR="Both Date Veteran Signed and IVM Complete Date are blank"
SIGNQ Q

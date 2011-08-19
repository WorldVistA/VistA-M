KMPDU ;OAK/RAK - CM Tools Utility ;2/17/04  09:47
 ;;2.0;CAPACITY MANAGEMENT TOOLS;**2**;Mar 22, 2002
 ;
GBLCHECK(GLOBAL) ;-- extrinsic function
 ;-----------------------------------------------------------------------
 ; GLOBAL.. Global name to be checked.  Must be either:
 ;              ^XTMP
 ;              ^TMP
 ;              ^UTILITY
 ;
 ; RESUTL: 0 - Does not pass.
 ;         1 - Passes.
 ;-----------------------------------------------------------------------
 Q:$G(GLOBAL)="" 0
 N GBL,I,RESULT
 S RESULT=0
 S GBL=GLOBAL
 ;-- remove '^'.
 S GBL=$E(GBL,2,$L(GBL))
 ;-- remove '('.
 S GBL=$P(GBL,"(")
 F I="XTMP","TMP","UTILITY" I GBL=I S RESULT=1 Q
 Q RESULT
 ;
FMDTI(Y,X) ;-- date/time in internal fileMan format.
 ;----------------------------------------------------------------------
 ;     X - User response ('T', '12/12/94', etc.)
 ;
 ; Return: Y(0)=InternalFilemanDate
 ;         Y(1)=ExternalFilemanDate
 ;----------------------------------------------------------------------
 K Y
 I $G(X)']"" S Y(0)="^" Q
 N %DT,DATETIME
 S %DT="ST" D ^%DT
 S DATETIME=$S(Y>0:Y,1:"^")
 K Y
 ;-- fm internal format.
 S Y(0)=DATETIME
 ;-- external format.
 S Y(1)=$$FMTE^XLFDT(DATETIME)
 Q
 ;
KILL(RESULT,VARIABLE) ;-- kill variables.
 ;-----------------------------------------------------------------------
 ;  VARIABLE... local or global variable to be killed.
 ;
 ; This subroutine kills variables (local or global).  It should be used
 ; mostly to kill global variables that have been set when components
 ; have been populated with long lists that were set into temporary
 ; globals.  If VARIABLE is a global variable, it must be either ^TMP or
 ; ^UTILITY to be killed.
 ;-----------------------------------------------------------------------
 K RESULT S RESULT=""
 I $G(VARIABLE)="" S RESULT="[No variable to kill]" Q
 I $E(VARIABLE)="^" D  Q:RESULT]""
 .I '$$GBLCHECK(VARIABLE) D 
 ..S RESULT="[Can only kill globals ^XTMP, ^TMP or ^UTILITY]"
 K @VARIABLE
 S RESULT="<"_VARIABLE_" killed>"
 Q
 ;
TIMEADD(KMPDTM,KMPDADD) ;-- extrinsic function - add time
 ;----------------------------------------------------------------------
 ; KMPDTM... Current time in dy hr:mn:sc format
 ; KMPDTM... Time to add to current time in dy hr:mn:sc format
 ;
 ; RETURN: total in dy hr:mn:sc format
 ;----------------------------------------------------------------------
 Q:$G(KMPDTM)="" ""
 Q:$G(KMPDADD)="" KMPDTM
 N DY,HR,MN,SC
 ; current time
 S DY(1)=+$P(KMPDTM," ")
 S HR(1)=+$P($P(KMPDTM," ",2),":")
 S MN(1)=+$P($P(KMPDTM," ",2),":",2)
 S SC(1)=+$P($P(KMPDTM," ",2),":",3)
 ; time to be added
 S DY(2)=+$P(KMPDADD," ")
 S HR(2)=+$P($P(KMPDADD," ",2),":")
 S MN(2)=+$P($P(KMPDADD," ",2),":",2)
 S SC(2)=+$P($P(KMPDADD," ",2),":",3)
 ; add seconds
 S SC(3)=SC(1)+SC(2)
 ; if greater than 59 seconds
 I SC(3)>59 S MN(3)=SC(3)\60,SC(3)=SC(3)-60
 ; add minutes
 S MN(3)=$G(MN(3))+MN(1)+MN(2)
 ; if greater than 59 minutes
 I MN(3)>59 S HR(3)=MN(3)\60,MN(3)=MN(3)-60
 ; add hours
 S HR(3)=$G(HR(3))+HR(1)+HR(2)
 ; if greater than 23 hours
 I HR(3)>23 S DY(3)=HR(3)\24,HR(3)=HR(3)-24
 ; days
 S DY(3)=$G(DY(3))+DY(1)+DY(2)
 ;
 Q DY(3)_" "_HR(3)_":"_MN(3)_":"_SC(3)

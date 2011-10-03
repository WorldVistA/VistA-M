SRHLVU ;B'HAM ISC/DLR - Surgery HL7 Utility routine ; [ 05/06/98   7:14 AM ]
 ;;3.0; Surgery ;**41**;24 Jun 93
 ; Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
DNAME(NAME) ;identifies an incoming CN data type to a record in file 200
 N X,CNT
 I '$D(NAME)!(($P(NAME,HLCOMP)="")&($P(NAME,HLCOMP,2="")!$P(NAME,HLCOMP,3=""))) Q ""
 I NAME="" Q ""
 I $P(NAME,HLCOMP)'="" S NAME=$O(^VA(200,"SSN",$P(NAME,HLCOMP),0)) I NAME'="" S NAME=$P(^VA(200,NAME,0),U)
 E  S X="",CNT=0 S NAME=$$FMNAME^HLFNC($P(NAME,HLCOMP,2,3)) F  S X=$O(^VA(200,"B",NAME,X)) Q:'X  S CNT=CNT+1 S NAME=$S(CNT=1:X,CNT>1:"")
 Q NAME
HNAME(IEN) ;converts an file 200 internal entry number into an HL7 CN data type
 I IEN="" Q ""
 I '$D(^VA(200,IEN,0)) W !,"Not a valid entry in file 200." Q ""
 Q $P(^VA(200,IEN,1),U,9)_HLCOMP_$P($P(^VA(200,IEN,0),U),",")_HLCOMP_$P($P(^VA(200,IEN,0),U),",",2)

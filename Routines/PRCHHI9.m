PRCHHI9 ;WISC/TGH-IFCAP SEGMENTS DE (CO) ;4/10/92  2:59 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
CO(A2,A3,VAR1,ITEM,NUM) ; Note:
 ; Comments and Descriptions are at two different levels
 ;
 ;  A2    = File node level eg A2=2 ! A2=4 ect
 ;  A3    = File node 'type' eg "CO" ! "DE"
 ;  VAR1  = Record Number (Ex. VAR1=99999550)
 ;  ITEM  = Item number or "" if doing comments
 ;  LEVEL = Subscript 'level' for storage in 423
 ;
 N CNT,CO,COM,DES,DESC,DDIWF,DIWL,DIWR,II,J,N,X,SUB
 S (CO,DES)=0,II=""
 S DIWR=60,DIWL=1,DIWF="" K ^UTILITY($J,"W")
 G:A3'="CO" DISC
 ;
COM ; Comments - '4' in 442
 S LEVEL=60,SUB="423.21A"
 S COM=$G(^PRC(442,VAR1,A2,0)) G:COM="" QUIT G:$P(COM,U,4)'>0 QUIT
 F  S CO=$O(^PRC(442,VAR1,A2,CO)) Q:CO'>0  S X=$G(^(CO,0)) D DIWP^PRCUTL($G(DA))
 G SET
DISC ; Item Descriptions - '2' in 442
 S LEVEL=22,SUB="423.0531A"
 S DESC=$G(^PRC(442,VAR1,A2,ITEM,1,0)) G:DESC="" QUIT
 G:$P(DESC,U,4)'>0 QUIT
 F  S DES=$O(^PRC(442,VAR1,A2,ITEM,1,DES)) Q:DES'>0  S X=$G(^(DES,0)) D DIWP^PRCUTL($G(DA))
SET S J=$G(^UTILITY($J,"W",1)) G:J'>0 QUIT
 S CNT=0 ;;$G(^PRCF(423,PRCFA("CSDA"),22,0)),CNT=$P(CNT,U,3)
 ;
 ;NOTE -- Need to verify CNT+II level does not already exist!!
 F II=1:1:J S N=$G(^UTILITY($J,"W",1,II,0)) D
  .;S ^PRCF(423,PRCFA("CSDA"),LEVEL,(CNT+II),0)=(CNT+II)_"^|"_A3_"^^"_N
  .;
  .S NUM=NUM+1,^TMP($J,"STRING",NUM)=A3_"^"_N_"^|"
  .Q
QUIT ;Set 'Top' level
 ;I $G(J)>0 S ^PRCF(423,PRCFA("CSDA"),LEVEL,0)="^"_SUB_"^"_(CNT+J)_"^"_(CNT+J)
 Q

PRCD3A ;WISC/PLT,DGL-Generate FUND FILE & REQUIRED TABLE for a new fical year ; [9/24/98 9:30am]
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;
EN N PRCA,PRCB,PRCC,PRCRI,PRCQT
 N A,B,C,X,Y,Z
 F  S PRCQT=1 D LG1 QUIT:PRCQT["^"  D:$P(PRCE,"^",2) LG2 QUIT
EXIT QUIT
LG1 S PRCD=1+$$DATE^PRC0C(+$H,"H"),$P(PRCD,"^",2)="NO"
 S PRCE=PRCD,$P(PRCE,"^",2)=0
Q1 S Y(1)="ENTER 4-DIGIT BEGINNING BUDGET FISCAL YEAR"
 D FT^PRC0A(.X,.Y,"For Beginning Budget Fiscal Year","O^4:4^I X'?4N K X",$P(PRCD,"^"))
 I X=""!(X["^")!'Y S PRCQT="^" G LG1X
 I PRCD-Y<-1 D EN^DDIOL("It is too early to generate fund/required table for this year.") G Q1
 I PRCD-Y>1 D EN^DDIOL("It is too late to generate fund/required table for this year.") G Q1
 S $P(PRCE,"^")=Y
Q2 S X(1)="Note: All ACTIVE SINGLE-YEAR FUND CONTROL POINTS will be initialized"
 S X(2)="       to enable the new fiscal year FMS/820 RECORDS to post correctly."
 D YN^PRC0A(.X,.Y,"Ready to Generate the fund code & Required Table for "_$P(PRCE,"^"),"O","NO")
 I X=""!(X["^")!'Y S PRCQT="^" G LG1X
 S $P(PRCE,"^",2)=Y
LG1X QUIT
 ;
LG2 ;
 D FUND($P(PRCE,"^"))
 S PRCRI(420)=0,PFLG=0
 F  S PRCRI(420)=$O(^PRC(420,PRCRI(420))) QUIT:'PRCRI(420)  I PRCRI(420) W !,"Station: ",PRCRI(420) D
 . S PRCRI(420.01)=0
 . F  S PRCRI(420.01)=$O(^PRC(420,PRCRI(420),1,PRCRI(420.01))) QUIT:PRCRI(420.01)>9998!'PRCRI(420.01)  D
 . . S X=$G(^PRC(420,PRCRI(420),1,PRCRI(420.01),0))
 . . I X="" W !,"** No zero node exists for IEN ",PRCRI(420.01) S PFLG=PFLG+1 QUIT
 . . I PRCRI(420.01)'=(X+0) W !,"** IEN ",PRCRI(420.01)," does not match FCP ",$P(X,U,1) S PFLG=PFLG+1 QUIT
 . . I '$P(X,U,19) W !,$P(^(0),"^") D FCP(PRCRI(420),$E(PRCE,3,4),PRCRI(420.01))
 . QUIT
 I PFLG>0 W !!,"** NOTE: There were ",PFLG," entries with errors.",!,"         Please contact IRM about these discrepancies.",!,"         See patch PRC*5*168 documentation for instructions.",!
 D EN^DDIOL("ALL DONE! ALL DONE! ALL DONE!")
 QUIT
 ;
FCP(PRCA,PRCB,PRCC) ;set entry in file 420.141
 ;prca=station #, prcb=fiscal year(2-digit), prcc=fcp #
 N PRCBBFY
 N A,B,C
 S PRCBBFY=$$BBFY^PRCSUT(PRCA,PRCB,PRCC,1)
 S C=$$ACC^PRC0C(PRCA,PRCC_"^"_PRCB_"^"_PRCBBFY)
 QUIT:$P(C,"^",6)'=$P(C,"^",7)
 S A=$$FMSACC^PRC0D(PRCA,C)
 S B=$$FIRST^PRC0B1("^PRCD(420.141,""B"","""_A_""",",0)
 I 'B S B=$$A420D141^PRC0F(A,PRCC) D EBAL^PRCSEZ(PRCA_"^"_PRCC_"^"_PRCB_"^1^0","C")
 QUIT
 ;
FUND(PRCA) ;PRCA = BEGINNING BUDGET FISCAL YEAR (4-DIGIT)
 N PRCRI,PRCLOCK,PRCFUND,PRCBBFY,PRCEBFY
 D ICLOCK^PRC0B("^PRCD(420.14,")
 S PRCBBFY=PRCA-1
 S PRCFUND="" F  S PRCFUND=$O(^PRCD(420.14,"UNQ",PRCFUND)) QUIT:PRCFUND=""  D
 . S PRCEBFY="" F  S PRCEBFY=$O(^PRCD(420.14,"UNQ",PRCFUND,PRCBBFY,PRCEBFY)) QUIT:'PRCEBFY  D
 .. S PRCRI("420.14A")=0
 .. F  S PRCRI("420.14A")=$O(^PRCD(420.14,"UNQ",PRCFUND,PRCBBFY,PRCEBFY,PRCRI("420.14A"))) QUIT:'PRCRI("420.14A")  D AFUND(PRCRI("420.14A"))
 .. QUIT
 . QUIT
  D DCLOCK^PRC0B("^PRCD(420.14,")
 QUIT
 ;
AFUND(PRCRI) ;ADD NEW FUND ENTRY
 N PRCA,PRCB
 N A,B,C
 S PRCA=^PRCD(420.14,PRCRI,0)
 ;fund with status 'O' not generated
 S A=$P(PRCA,"^",6),A=$G(^PRCD(420.1999,A,0)) QUIT:$P(A,"^",4)="O"
 S $P(PRCA,"^",3)=$P(PRCA,"^",3)+1,$P(PRCA,"^",4)=$P(PRCA,"^",4)+1
 S PRCRI(420.14)=$O(^PRCD(420.14,"UNQ",$P(PRCA,"^"),$P(PRCA,"^",3),$P(PRCA,"^",4),""))
 D:'PRCRI(420.14)
 . D EN^DDIOL(PRCRI_"  "_$P(PRCA,"^")_"  "_$P(PRCA,"^",2)_"   "_$P(PRCA,"^",3)_" - "_$P(PRCA,"^",4))
 . K X S X=$P(PRCA,"^")
 . S X("DR")="2///"_$P(PRCA,"^",3)_";3///"_$P(PRCA,"^",4)_";4.5///"_$P(PRCA,"^",7)_";4.7///"_$P(PRCA,"^",5)_";5///"_$P(PRCA,"^",6)_";1///"_$P(PRCA,"^",2)
 . S Y="" D ADD^PRC0B1(.X,.Y,"420.14;^PRCD(420.14,") W "   ",$P(Y,"^")
 . S PRCRI(420.14)=+Y
 . QUIT
 D:PRCRI(420.14)&PRCRI REQ(PRCRI,PRCRI(420.14))
 QUIT
 ;
REQ(PRCA,PRCB) ;copy fund required table from fund code RID# PRCA to PRCB
 N PRCRI,PRCC
 S PRCRI(420.18)=""
 F  S PRCRI(420.18)=$O(^PRCD(420.18,"B",PRCA,PRCRI(420.18))) QUIT:'PRCRI(420.18)  D
 . S PRCC=$G(^PRCD(420.18,PRCRI(420.18),0)) QUIT:'PRCC
 . QUIT:$O(^PRCD(420.18,"UNQ",PRCB,$P(PRCC,"^",2),$P(PRCC,"^",3),""))
 . W !,PRCC
 . S $P(PRCC,"^",1)=PRCB
 . W "    ***    ",PRCC
 . K X S X=PRCB
 . S X("DR")="1////"_$P(PRCC,"^",2)_";2////"_$P(PRCC,"^",3)_";3////"_$P(PRCC,"^",4)
 . S Y="" D ADD^PRC0B1(.X,.Y,"420.18;^PRCD(420.18,") W "    ",$P(Y,"^")
 . QUIT
 QUIT

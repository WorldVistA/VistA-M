PRCFFUD1 ;WISC/SJG-UTILITY FOR CARRY FORWARD ;3/27/96  15:14
 ;;5.1;IFCAP;**58**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 QUIT
 ; This utility will determine the date that is to be used for the
 ; obligation processing date for Supply Fund transactions
 ;
EN() ;
 N OPENQTR,PRIMARY,PODATE
 S RETDATE=""
 S OPENQTR=$$NP^PRC0B("^PRC(420,"_+PRC("SITE")_",",0,9)
 S PRIMARY=$$NP^PRC0B("^PRC(442,"_+PO_",",0,12)
 S PODATE=$$NP^PRC0B("^PRC(442,"_+PO_",",1,15)
REQ ; 2237 Request on Purchase Order
 I $G(PRIMARY)]"" D  G QUIT
 .S RETDATE=$G(OPENQTR)
 .I $G(PODATE)>$G(OPENQTR) S RETDATE=PODATE
 .I $G(PODATE)<$G(OPENQTR) D NOW^%DTC S RETDATE=X
 .Q
NOREQ ; No 2237 Request on Purchase Order
 I $G(PRIMARY)="" D  G QUIT
 .I $G(PODATE)<$G(OPENQTR) D NOW^%DTC S RETDATE=X Q
 .S RETDATE=PODATE
 .Q
QUIT I RETDATE="" D NOW^%DTC S RETDATE=X
 QUIT RETDATE
 ;
 ;A = RI OF 442 or 443.6, B = node 0 of file 442 or 443.6, C=file # 442 or 443.6,D=amend ri
DT442(A,B,C,D) ; set up prcfa(bbfy),prc(site),prc(fy),prc(qtr),prc(cp),prcfa(request),prc(rbdt),prc(bbfy),prc(podt),prc(amendt)
 N PRCA,Z
 S PRCA=$S($G(C)="":442,1:$G(C))
 I $G(D) S PRC("AMENDT")=$P($G(^PRC(PRCA,A,6,D,0)),U,2)
 S:$G(B)="" B=^PRC(PRCA,A,0)
 S PRCFA("REQUEST")=$P(B,U,12),PRC("RBDT")=""
 I PRCA=442 D GENDIQ^PRCFFU7(442,A,".1;.07;.03;17","IEN","")
 I PRCFA("REQUEST") S Z=$G(^PRCS(410,PRCFA("REQUEST"),0)),PRC("RBDT")=$P(Z,U,11),PRCFA("BBFY")=$P(^(3),U,11),PRC("SITE")=$P(Z,"-"),PRC("FY")=$P(Z,"-",2),PRC("QTR")=$P(Z,"-",3),PRC("CP")=$P(Z,"-",4) I 1
 S Z=$G(^PRC(PRCA,A,1)),PRC("PODT")=$P(Z,U,15) E  S PRCFA("BBFY")=$P(^(23),U,2),PRC("SITE")=$P(B,"-"),PRC("CP")=$P(B,U,3),Z=$$DATE^PRC0C($P(Z,U,15),"I"),PRC("FY")=$E(Z,3,4),PRC("QTR")=$P(Z,U,2)
 S PRCFA("BBFY")=+$$DATE^PRC0C(PRCFA("BBFY"),"I"),PRC("BBFY")=PRCFA("BBFY")
 S PRC("FYQDT")=$P($$QTRDATE^PRC0D(PRC("FY"),PRC("QTR")),"^",7)
 I 'PRC("RBDT") S PRC("RBDT")=$$RBDT^PRC0G(PRC("SITE")_U_PRC("FY")_U_PRC("QTR")_U_+PRC("CP")_U_PRCFA("BBFY"))
 QUIT
 ;
 ;a = running balance date (fileman), b = p.o date or amend date
DTOBL(A,B) ;ef = default obligation date
 QUIT $S(A<DT:DT,1:B)
 ;
OBLDAT(A,B) ; a new subroutine added as part of PRC*5.1*58.
 ;  This new subroutine will enable the software to look for 
 ;  amendment funds in the correct fiscal quarter.  The NOIS
 ;  addressed by this code is LAH-0602-61845.
 ;
 S RBDT=A,AMENDT=B
 I AMENDT]"",PRC("FY")=$E(DT,2,3) S OBLDAT=AMENDT
 E  S OBLDAT=RBDT
 K RBDT,AMENDT
 Q OBLDAT

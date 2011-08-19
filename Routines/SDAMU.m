SDAMU ;ALB/MJK - AM Utilities ; 12/1/91
 ;;5.3;Scheduling;**63**;Aug 13, 1993
 ;
SWITCH() ; -- date of ci switch over
 Q 2921001
 ;
NOW() ; -- return current date and time (NOW) 
 D NOW^%DTC
 Q %
 ;
BARC(TTYPE,ON,OFF) ; -- barcode on/off
 S ON=$S($D(^%ZIS(2,TTYPE,"BAR1")):^("BAR1"),1:""),OFF=$S($D(^("BAR0")):^("BAR0"),1:"")
 Q ON]""&(OFF]"")
 ;
CURRENT ; -- computed field (2.98,100)
 S X=$P($$STATUS^SDAM1(D0,D1,+$G(^DPT(D0,"S",D1,0)),$G(^(0))),";",3)
 Q
 ;
CLINIC(SDCL) ; -- generic screen for hos. loc. entries
 ; input:   SDCL := ifn of HOSPITAL LOCATION file
 ;      returned := [ 0 | do not use entry ; 1 | use entry ]
 ;
 ; -- must be not be a 'non-count' clinic and must be a clinic
 N X S X=$G(^SC(SDCL,0)),X("OOS")=+$G(^("OOS"))
 Q $S($P(X,"^",17)="Y":0,X("OOS"):0,1:$P(X,"^",3)="C")
 ;
DIV(SDCL,VAUTD,SDNAME,SDLEN) ; -- find division for clinic
 ;  input:   SDCL := clinic ifn
 ;          VAUTD := array defined by VAUTOMA
 ;          SDLEN := length of name to pass back [optional]
 ; output: SDNAME := name of division
 ; return:        := division ifn
 ;
 N X
 I '$D(SDLEN) N SDLEN S SDLEN=35
 S X=$S('$P($G(^DG(43,1,"GL")),U,2):+$O(^DG(40.8,0)),1:+$P($G(^SC(SDCL,0)),U,15))
 S SDNAME=$E($S($D(^DG(40.8,X,0)):$P(^(0),U),1:"UNKNOWN"),1,SDLEN)
 Q $S(VAUTD=1!($D(VAUTD(X))):X,1:0)
 ;
RT(SDRTOPT) ; -- rt call for newing and return to LM
 N DFN,RTE,R,RTPGM,RTJR,RTY,RTDIV,X,Y
 S X=$O(^DIC(19,"B",SDRTOPT,0))
 I +$G(^DIC(195.4,1,"UP")),X D
 .S X=X_";DIC(19," D EN^XQOR
 E  D
 .W !!?5,"'",$P($G(XQORNOD(0)),U,3),"' is not available on your system." D PAUSE^VALM1
 Q
 ;

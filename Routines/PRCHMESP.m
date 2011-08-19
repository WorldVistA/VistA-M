PRCHMESP ;ISC2/RWS-TRANSMIT PKE & PFA TRANSACTIONS TO MAILMAN ;8-25-92/10:07
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
READ ; READ SYSID AND LINE COUNT SEGMENTS
 S X=$Q(@TRANSIN),SYSEG=@X
 S X=$Q(@X),LCSEG=@X I $P(LCSEG,U,1)'="LC" S ERR="SEGMENT TYPE SHOULD BE LC" Q
 S LCNT=$P(LCSEG,U,2),ISNO=$P(SYSEG,U,7),IFNO=$P(LCSEG,U,3),IFNO=$E(IFNO,1,3)_"-"_$E(IFNO,4,99)
 S ^XMB(3.9,XMZ,2,1,0)="     Requisition  # "_IFNO_" ISMS # "_ISNO
 S ^XMB(3.9,XMZ,2,2,0)=" Line # - National Stock Number - ISMS TO/SO # - TO/SO Line # - Quantity "
 S ^XMB(3.9,XMZ,2,3,0)=""
 S LIN=3 F I=1:1:LCNT S X=$Q(@X) D  I $Q(@X)="" S ERR="LINE COUNT ERROR" Q
 .S Y=@X,Y(2)=$P(Y,U,2),Y(3)=$P(Y,U,3),Y(4)=$P(Y,U,4),Y(5)=$P(Y,U,5),Y(6)=$P(Y,U,6)/100,Y(7)=$P(Y,U,7),Y(7)=$S(Y(7)=1:"UNIT OF MEASURE",1:"PICKING EXCEPTION")
 .S Y(2)=$E(Y(2),1,4)_"-"_$E(Y(2),5,6)_"-"_$E(Y(2),7,9)_"-"_$E(Y(2),10,20)
 .S Y=$J(Y(3),3)_$J(Y(2),22)_$J(Y(4),17)_$J(Y(5),13)_$J(Y(6),13)
 .S LIN=LIN+1,^XMB(3.9,XMZ,2,LIN,0)=Y
 .S LIN=LIN+1,^XMB(3.9,XMZ,2,LIN,0)="REASON FOR MAINTAINANCE: "_Y(7)
 .Q
EXIT Q

PRCHMESE ;ISC2/RWS-TRANSMIT OPE TRANSACTIONS TO MAILMAN ;5-8-92/13:06
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
READ ; READ SYSID AND LINE COUNT SEGMENTS
 S X=$Q(@TRANSIN),SYSEG=@X
 S X=$Q(@X),LCSEG=@X I $P(LCSEG,U,1)'="LC" S ERR="SEGMENT TYPE SHOULD BE LC" Q
 S LCNT=$P(LCSEG,U,2),ISNO=$P(SYSEG,U,7),IFNO=$TR($P(LCSEG,U,3)," "),LN=$L(IFNO),IFNO=$P(SYSEG,U,3)_"-"_$E(IFNO,1,LN)
 S ^XMB(3.9,XMZ,2,1,0)="   There was an error on IFCAP Requisition Number "_IFNO
 S ^XMB(3.9,XMZ,2,2,0)="    These line items must be deleted from the PO and reordered.  "
 S ^XMB(3.9,XMZ,2,3,0)=" "
 S ^XMB(3.9,XMZ,2,4,0)=" Line # - National Stock # - Quantity - Invalid Field    -     Invalid Data "
 S ^XMB(3.9,XMZ,2,5,0)=""
 S LIN=5 F I=1:1:LCNT S X=$Q(@X) D  I $Q(@X)="" S ERR="LINE COUNT ERROR" Q
 .S Y=@X,Y(2)=$P(Y,U,2),Y(3)=$P(Y,U,3),Y(4)=$P(Y,U,4)/100,Y(5)=$P(Y,U,5),Y(6)=$P(Y,U,6)
 .S Y(2)=$E(Y(2),1,4)_"-"_$E(Y(2),5,6)_"-"_$E(Y(2),7,9)_"-"_$E(Y(2),10,20)
 .S Y=$J(Y(3),3)_$J(Y(2),22)_$J(Y(4),10)_"     "_Y(5)_$E("                    ",$L(Y(5)),20)_"  "_Y(6)
 .S LIN=LIN+1,^XMB(3.9,XMZ,2,LIN,0)=Y
EXIT Q

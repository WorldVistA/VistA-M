PRCOESE1 ;WISC/DJM-IFCAP EDI POA SERVER INTERFACE, CONT. ; [8/31/98 2:03pm]
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
MSG ; ENTER MAILMAN MESSAGE INFORMING WHOMEVER ABOUT PROBLEMS WITH
 ; INCOMMING 'POA' TRANSACTION.
 ;
 N BB,II,L
 S XMSUB="IFCAP 'POA' for Purchase Order "_$G(CC)
 S XMDUZ="IFCAP 'POA' SERVER"
 F I=1:1:5 D XMZ^XMA2 Q:XMZ>0
 I I=5,XMZ<1 Q  ;MIGHT NEED TO REDO 'GET^XMA2' IF I=5 AND THERE IS NO XMZ.
 I $G(ERR("SEG"))]"" S ^XMB(3.9,XMZ,2,1,0)="The "_A_" segment is not found in the POA transaction.",^XMB(3.9,XMZ,2,2,0)="Contact the EDI HELP DESK in Austin about this transaction.",L=3 G SEND
 I $G(ERR("STATION"))]"" S ^XMB(3.9,XMZ,2,1,0)="The "_STATION_" site listed in the POA transaction can not be found",^XMB(3.9,XMZ,2,2,0)="in the IFCAP ADMIN ACTIVITY SITE PARAMETER file.",L=3 G SEND
 I $G(ERR("RECORD"))]"" S ^XMB(3.9,XMZ,2,1,0)="Record "_CC_", "_$C(34)_"PHA"_$C(34)_", "_VENDOR_" was not found in file 443.75.",L=2 G SEND
 I $G(ERR("VENDOR"))]"" S ^XMB(3.9,XMZ,2,1,0)="Record "_CC_" does not have a VENDOR ID number.",L=2 G SEND
 S M1=""
 S L=1
 F  S M1=$O(ERR(CC,M1)) Q:M1=""  I ERR(CC,M1)]"" D
 . I M1=0,$P(ERR(CC,M1),U)]"" S ^XMB(3.9,XMZ,2,L,0)="Purchase Order Acknowledgment "_CC_" was not found in the PO file.",L=L+1
 . I M1>0,$P(ERR(CC,M1),U,2,99)]"" F II=2:1:13 S BB=$P(ERR(CC,M1),U,II) I BB]"" D
 . . I II=2 S ^XMB(3.9,XMZ,2,L,0)="Item "_M1_" was not found in PO "_CC_".",L=L+1 Q
 . . I II=3 S ^XMB(3.9,XMZ,2,L,0)="The Vendor Stock Number wasn't found in item "_M1_".",L=L+1 Q
 . . I II=5 S ^XMB(3.9,XMZ,2,L,0)="There is no quantity listed for item "_M1_".",L=L+1 Q
 . . I II=6 S ^XMB(3.9,XMZ,2,L,0)="There is no Unit of Purchase listed for item "_M1_".",L=L+1 Q
 . . I II=7 S ^XMB(3.9,XMZ,2,L,0)="There is no Unit Cost listed for item "_M1_".",L=L+1 Q
 . . I II=9 S ^XMB(3.9,XMZ,2,L,0)="The Vendor Stock Number from the POA doesn't match the one from item "_M1_".",L=L+1 Q
 . . I II=10 S ^XMB(3.9,XMZ,2,L,0)="The Quantity listed in the POA doesn't match the one listed in item "_M1_".",L=L+1 Q
 . . I II=11 S ^XMB(3.9,XMZ,2,L,0)="The Unit of Purchase listed in the POA doesn't match the one in item "_M1_".",L=L+1 Q
 . . I II=12 S ^XMB(3.9,XMZ,2,L,0)="The Unit Cost listed in the POA doesn't match the one in item "_M1_".",L=L+1 Q
        . . I II=13 S ^XMB(3.9,XMZ,2,L,0)="The POA for PO "_CC_" is missing a line item number.",L=L+1 Q
 . . Q
 . Q
 Q:L=1
 ;
SEND ; COME HERE TO SEND THE MAILMAN MESSAGE BUILT UP IN 'MSG' ABOVE.
 S L=L-1
 S ^XMB(3.9,XMZ,2,0)="^3.9A^"_L_"^"_L_"^"_DT
 S XMDUN="IFCAP 'POA' PROBLEM"
 S X="G.EDP"
 D WHO^XMA21
 S:'$L($O(XMY(""))) XMY(.5)=""
 S:$G(PPM)]"" XMY(PPM)=""
 D ENT1^XMD
 K XMY
 Q
 ;
BUL ; THIS BULLETIN WILL NOTIFY THAT A 'POA' TRANSACTION HAS ARRIVED
 ; FROM AUSTIN.
 N XMDUZ,XMB,DATE,X,Y,XMB,%,%DT
 S XMDUZ="POA Server Interface"
 S XMB="PRCOEDI ACKNOWLEDGE"
 D NOW^%DTC
 S Y=%
 S %DT="S"
 D DD^%DT
 S XMB(3)=$P(Y,"@")
 S XMB(4)=$P(Y,"@",2)
 S XMB(5)=CC
 S DATE=$P(LINE,U,5)
 S X1=$E(DATE,1,4)-1700_"0101"
 S X2=+$E(DATE,5,7)-1
 D C^%DTC
 S Y=X_"."_$P(LINE,U,6)
 D DD^%DT
 S XMB(1)=Y
 S XMB(2)=$P(LINE,U,3)
 S XMY(PPM)=""
 D ^XMB
 Q
 ;
DATE(DATE) ; THIS EXTRINSIC FUNCTION WILL RETURN THE DATE IN YYYYJJJ FORMAT
 ; WHERE YYYY IS 4 DIGIT YEAR AND JJJ IS THE DAY OF THE YEAR.
 ;
 ;  THE INPUT PARAMETER, DATE, IS THE DATE TO CONVERT ENTERED IN
 ;  VA FILEMAN FORMAT WITHOUT ANY TIME.  THE DATE MUST CONTAIN
 ;  YEAR, MONTH AND DAY.
 ;
 N X,%Y
 S X1=DATE
 S X2=$E(DATE,1,3)_"0101"
 D ^%DTC
 S X=X+1
 S X="000"_X
 S X=$E(X,$L(X)-2,99)
 Q $E(DATE,1,3)+1700_X
 ;
TEXT(ENTRY,M1,CC) ; HOW TO RETRIEVE TEXT OF ERROR LISTINGS AND INCLUDE IN
 ; THEM THE
 ; 'LINE ITEM NUMBER' ALONG WITH THE 'PURCHASE ORDER NUMBER' AS
 ; NEEDED.
 ;
 ; Call this entry as an EXTRINSIC FUNCTION call.
 ;    S AA=$$TEXT^PRCOESE1(ENTRY,M1,CC)
 ;
 ; On completion of function call AA will contain the text in PRCOER.
 ;
 ;    INPUT PARAMETERS              WHAT THEY MEAN
 ;       ENTRY            THE '^' SEPARATED PIECE THAT HAS A '*'
 ;                        FROM THE ERR(CC,B) ARRAY CREATED IN
 ;                        PRCOESE.
 ;        M1              THE 'B' FROM THE ARRAY.  THE 'LINE
 ;                        ITEM NUMBER' OF THE PO RECORD FROM THE
 ;                        'POA' TRANSACTION BEING ENTERED.
 ;        CC              THE 'PURCHASE ORDER NUMBER' FROM THE 'POA'
 ;                        TRANSACTION BEING ENTERED.
 ;
 ;    OUTPUT PARAMETER              WHAT IT MEANS
 ;       PRCOER           THIS IS THE TEXT FROM 'LINES' WITH 'M1'
 ;                        AND 'CC' REPLACED WITH THEIR VALUES.
 ;
 N PRCOER
 ;
 ; POINT TO THE CORRECT LOCATION FOR THE LINE WANTED.
 ;
 S PRCOER=""
 I ENTRY="" Q PRCOER
 ;
 ; GET THE TEXT WITHIN THE LINE.
 ;
 S PRCOER=$P($T(LINES+ENTRY),";;",2)
 ;
 ; NOW LETS RESOLVE ALL VARIAVLES WITHIN THE LINE TO ITS ACTUAL TEXT.
 ; START AFTER THE SECOND QUOTATION MARK (") AND REPLACE ALL VARIABLES
 ; WITH THE VALUE (TEXT) OF THE VARIABLE.
 ;
 I PRCOER["_M1_" S PRCOER=$P(PRCOER,"_M1_")_M1_$P(PRCOER,"_M1_",2)
 I PRCOER["_CC_" S PRCOER=$P(PRCOER,"_CC_")_CC_$P(PRCOER,"_CC_",2)
 Q PRCOER
 ;
LINES ;Error messages
 ;;
 ;;Item _M1_ was not found in PO _CC_.
 ;;The Vendor Stock Number wasn't found in item _M1_.
 ;;
 ;;There is no quantity listed for item _M1_.
 ;;There is no Unit of Purchase listed for item _M1_.
 ;;There is no Unit Cost listed for item _M1_.
 ;;
 ;;The Vendor Stock Number from the POA doesn't match the one from item _M1_.
 ;;The Quantity listed in the POA doesn't match the one listed in item _M1_.
 ;;The Unit of Purchase listed in the POA doesn't match the one in item _M1_.
 ;;The Unit Cost listed in the POA doesn't match the one in item _M1_.
 ;;The POA for PO _CC_ is missing a line item number.

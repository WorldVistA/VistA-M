PRCHQM2 ;WISC/KMB-MANUAL PRINT OF RFQ ;7/23/99  15:58
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 S P=1 U IO D HEADER^PRCHQM3
 ;print RFQ, vendor, PA, delivery info
 U IO W ! F I=1:1:90 W "_"
 W !,"REQUEST FOR MANUAL QUOTATIONS  |  The Notice of Small Business-Small Purchase Set-Aside"
 W !," (this is not an order)",?31,"|     on the last page of this form"
 W !,?31,"| _____is    _____is not applicable."
 W ! F I=1:1:31 W "_"
 W "|" F I=1:1:58 W "_"
 W !,"1. REQUEST NO. |2.DATE ISSUED  |3.REQUISITION/PURCHASE REQUEST |4.CERT.FOR.NAT.  |RATING"
 W !,?15,"|",?31,"| NO.",?63,"| DEF. UNDER BDSA |"
 W !,?15,"|",RDATE,?31,"|",?33,RFQNUM,?63,"| REG.2 AND/OR DMS|"
 W !,?15,"|",?31,"|",?63,"| REG.1->",?81,"|"
 W ! F I=1:1:15 W "_"
 W "|" F I=1:1:15 W "_"
 W "|" F I=1:1:31 W "_"
 W "|" F I=1:1:17 W "_"
 W "|" F I=1:1:8 W "_"
 W !,"5A.ISSUED BY   ",ISS(1),?63,"|6.DELIVER BY (Date)"
 W !,?15,ISS(2),?63,"|"
 W !,?15,ISS(4),",",ISS(5),"  ",ISS(6),?63,"|",?65,ADATE
 W !,?63,"|" F I=1:1:26 W "_"
 W ! F I=1:1:63 W "_"
DELIV ;
 W "|7.DELIVERY"
 W !,"5B.FOR INFORMATION CALL:(Name & phone no.) (No collect calls)  |(unless otherwise"
 W !,?63,"| specified)"
 W !?4,PA,?31,"PHONE: ",PPHONE,?63,"|  FOB",?83,"OTHER"
 W !?33,"FAX: ",$G(PAFAX),?63,"|",FOB1," DESTINATION",?81,FOB2,"(See",!
 W:$G(PRCEMAIL)'="" ?4,"E-MAIL: ",PRCEMAIL W ?63,"|",?81,"schedule)"
 W ! F I=1:1:63 W "_"
 W "|" F I=1:1:26 W "_"
 W !,"8.TO: NAME AND ADDRESS, INCLUDING ZIP CODE",?63,"|9.DESTINATION (Consignee"
 W !,?10,SRC(1),?63,"| and address, using ZIP)"
 W !,?10,SRC(2),?63,"|  ",$E(FDES1,1,21)
 W !,?10,SRC(3),?63,"|  ",FDES2
 W !,?10,SRC(6),",",SRC(7),"  ",SRC(8),?63,"|  ",FDES3
 W !,"PHONE: ",VENPH,?33,"FAX: "_$G(VENFAX),?63,"|  ",FDES4,!
 F I=1:1:63 W "_"
 W "|" F I=1:1:26 W "_"
 W !,"10.PLEASE FURNISH QUOTATIONS TO",?32,"|11.BUSINESS CLASSIFICATION (check appropriate boxes)"
 W !,"   THE ISSUING OFFICE ON OR BE-",?32,"|",?34,BC1,?36,"_SMALL",?58,BC2,?60,"_OTHER THAN SMALL"
 W !,"   FOR CLOSE OF BUSINESS (date)",?32,"|",?34,BC3,?36,"_VIETNAM VETERAN-OWNED",?58,BC4,?60,"_WOMEN-OWNED"
 W !,?5,CBDATE,?32,"|",?34,BC5,?36,"_DISADVANTAGED",?58,BC6,?60,"_DISABLED VETERAN-OWNED"
 W ! F I=1:1:32 W "_"
 W "|" F I=1:1:57 W "_"
 W !!,"IMPORTANT: This is a request for information, and quotations furnished are"
 W !,"not offers.  If you are unable to quote, please so indicate on this form and"
 W !,"return it.  This request does not commit the Government to pay any costs "
 W !,"incurred in the preparation of the submission of this quotation or to "
 W !,"contract for supplies or services.  Supplies are of domestic origin unless "
 W !,"otherwise indicated by quoter.  Any representations and/or certifications"
 W !,"attached to this Request for Quotations must be completed by the quoter."
 W ! F I=1:1:90 W "_"
SCH ;
 W !,?10,"12.SCHEDULE (Include applicable Federal, State and local taxes)",!
 F I=1:1:90 W "_"
 ;
 W !,"ITEM #",?7,"|  DELIVERY LOCATION &",?35,"|"," QTY ",?42,"| UNIT ",?47,"| UNIT PRICE ",?54,"|   AMOUNT   ",?62,"| DEL. DATE "
 W !,?7,"|    DESCRIPTION",?35,"|",?42,"|",?49,"|",?62,"|",?75,"|"
 W !,"__(a)__",?7,"|_____________(b)___________",?35,"|_(c)__",?42,"|_(d)__",?47,"|_____(e)____",?54,"|_____(f)____",?62,"|_____(g)_____"
 S LN="" F  S LN=$O(^TMP($J,LN)) Q:LN=""  D
 .S LD=0 F  S LD=$O(^TMP($J,LN,LD)) Q:LD=""  D
 ..I $Y>60 D HEADER^PRCHQM3
 ..W ! I LD=1 W $P(^TMP($J,LN,LD),"^")
 ..W ?7,"|",$P(^TMP($J,LN,LD),"^",2),?35,"|",$P(^TMP($J,LN,LD),"^",3),?42,"|",$P(^TMP($J,LN,LD),"^",4)
 ..W ?49,"|",?62,"|",?75,"|",$P(^TMP($J,LN,LD),"^",6)
 .D ITEMS^PRCHQM3
 D HEADER^PRCHQM3,METRIC^PRCHQM3
DISC ;
 W !,"13.DISCOUNT FOR PROMPT",?22,"|10 CALENDAR DAYS",?40,"|20 CALENDAR DAYS",?58,"|30 CALENDAR DAYS",?76,"|CALENDAR DAYS"
 W !,?6,"PAYMENT--->",?22,"|",?39,"%|",?57,"%|",?75,"%|         %"
 W !,?22,"|",?40,"|",?58,"|",?76,"|"
 W ! F I=1:1:90 W "_"
 W !,"NOTE: Last page must also be completed by the quoter."
 W ! F I=1:1:90 W "_"
 W !,"14.NAME AND ADDRESS OF QUOTER (Street,  |15.SIGNATURE OF PERSON AUTHORIZED  |16.QUOTATION"
 W !,"  city,county, State and ZIP code)",?40,"|   TO SIGN QUOTATION",?76,"|   DATE"
 W !,?40,"|",?76,"|",!,?40,"|"
 F I=1:1:35 W "_"
 W "|_____________"
 W !,?40,"|17.NAME AND TITLE OF SIGNER (Type  |18.PHONE NO."
 W !,?40,"|   or print)",?76,"| (area code)"
 W !,?40,"|",?76,"|"
 W ! F I=1:1:40 W "_"
 W "|" F I=1:1:35 W "_"
 W "|_____________"
 Q

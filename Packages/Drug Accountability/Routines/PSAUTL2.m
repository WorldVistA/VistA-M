PSAUTL2 ;BIR/JMB-Upload and Process Prime Vendor Invoice Data Utility ;9/19/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;; 10/24/97
 ;This routine is a utility that writes X12 errors to the screen. It is
 ;used during the uploading of prime vendor invoices. It is called by
 ;PSAUP2 and PSAUP3.
 ;
ERROR ;Writes X12 error messages.
 S PSASLN="",$P(PSASLN,"-",80)=""
 W @IOF,!,"The format of the invoice file is incorrect."
 W !,"Call your IRM staff and relay the error messages listed below."
 W !!,"ERROR MESSAGES:",!,PSASLN S PSAOUT=1
 S PSACTRL2="" F  S PSACTRL2=$O(PSAERR(PSACTRL2)) Q:PSACTRL2=""  W !!,"Control# "_PSACTRL2_":" D
 .S PSASEG="" F  S PSASEG=$O(PSAERR(PSACTRL2,PSASEG)) Q:PSASEG=""  W !,PSAERR(PSACTRL2,PSASEG)
 S PSAS=22-$Y F PSASS=1:1:PSAS W !
 S DIR(0)="E",DIR("A")="Press ESC, answer Yes to the ""EXIT SCRIPT?"" question, then press RETURN." D ^DIR K DIR
 Q
MSG S:$G(PSACTRL)="" PSACTRL="UNKNOWN"
 I PSASEG="ISA" S PSAERR(PSACTRL,PSASEG)="The ISA control# (piece 14) should be 9 characters in length." Q
 I PSASEG="IEA" S PSAERR(PSACTRL,PSASEG)="The IEA control# (piece 3) should equal the ISA control# (piece 14 = "_$P($G(PSAISA),"^",14)_")" Q
 I PSASEG="GS" S PSAERR(PSACTRL,PSASEG)="GS piece "_%_" should equal ISA's piece "_$G(PSAPC)_" ("_$TR($P($G(PSAISA),"^",$G(PSAPC))," ")_")." Q
 I PSASEG="GE" S PSAERR(PSACTRL,PSASEG)="The GE control# (piece 3) should equal GS's control# piece 7 ("_$P($G(PSAGS),"^",7)_")." Q
 I PSASEG="ST" S PSAERR(PSACTRL,PSASEG)="The ST control# (piece 3) should be 4 to 9 characters in length." Q
 I $E(PSASEG,1,2)="SE" D  Q
 .I PSASEG="SE1" S PSAERR(PSACTRL,PSASEG)="The SE control# (piece 3) should be equal to ST's control# (piece 3 = "_PSACTRL_")" Q
 .I PSASEG="SE2" S PSAERR(PSACTRL,PSASEG)="SE's count of segments (piece 2) should equal the number of segments ("_$G(PSASTCNT)_")."
 I PSASEG="N1" S PSAERR(PSACTRL,PSASEG)="N1's piece 2 should equal 'BY', 'DS' OR 'ST'."
 I PSASEG="NONTYPE" S PSAERR(PSACTRL,PSASEG)="The identifier segment 'N1' needs to come before the '"_$P($G(PSADATA),"^")_"' segment." Q
 I PSASEG="CTT" S PSAERR(PSACTRL,PSASEG)="CTT's line item count (piece 2) should equal the number of line items ("_$G(PSAITCNT)_")."
 I $E(PSASEG,1,3)="IT1" D  Q
 .I PSASEG="IT1-1" S PSAERR(PSACTRL,PSASEG)="The IT1 invoice line number "_$G(PSAITEM)_" (piece 2) is not defined." Q
 .I PSASEG="IT1-2" S PSAERR(PSACTRL,PSASEG)="The IT1 unit price code (piece 6) should equal 'DS' for discount." Q
 .I PSASEG="IT1-3" S PSAERR(PSACTRL,PSASEG)="The IT1 does not contain a NDC (piece 8) or an UPC (piece 12)."
 I PSASEG="ORDER1" S PSAERR(PSACTRL,PSASEG)="Segments are out of order. The starting segment should be 'ISA', not '"_$G(PSANEW)_"'." Q
 I PSASEG="ORDER2" S PSAERR(PSACTRL,PSASEG)="Segments are out of order. The segment following '"_$G(PSALAST)_"' should be '"_$G(PSAEXPEC)_"', not '"_$G(PSANEW)_"'."
 Q
NONTYPE ;
 I PSANTYPE="" S PSASEG="NONTYPE" D ERROR
 Q

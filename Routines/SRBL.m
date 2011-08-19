SRBL ;BIR/ADM - BLOOD PRODUCT VERIFICATION FOR VBECS ;09/01/05
 ;;3.0; Surgery ;**148,168**;24 Jun 93;Build 5
 ; 
 ; Reference to AVUNIT^VBECA1B supported by DBIA #4629
 ;
SCAN D BAR ; test bar code reader
 S SRQ=0,DFN=$P(^SRF(SRTN,0),"^") K ^TMP("SRBL",$J)
 D AVUNIT^VBECA1B("SRBL",DFN) ; get list of units available for the patient
TST K DIR S DIR(0)="FA^1:50",(SRPROMPT,DIR("A"))="Enter Blood Product Identifier: "
 S DIR("?")="Enter or scan the Blood Product Unit Id" D ^DIR K DIR G END:$D(DTOUT)!$D(DUOUT)
 D CODA,MATCH I 'SRMATCH G SRNO
 I SRMATCH=1 S SRY=SRMATCH D SRYES Q
 D LIST I SRQ G END
 S SRY=Y D SRYES
 Q
LIST W ! S Y=^TMP("SRBL",$J,0),Z=$P(Y,"^",7),SRSSN=$E(Z,1,3)_"-"_$E(Z,4,5)_"-"_$E(Z,6,12)
 S SRNAME=$P(Y,"^",5)_","_$P(Y,"^",4)_" "_SRSSN
 S (SRI,SRZ)=0 F  S SRZ=$O(SRBL(SRZ)) Q:'SRZ  D
 .S Z=SRBL(SRZ),SRPROD=$P(Z,"^",4),X=$P(Z,"^",2) D ^%DT S SREXP=Y
 .W !!," ",SRZ_") Unit ID: ",SRUID,?45,SRPROD
 .W !,?4,"Patient: ",SRNAME,?45,"Expiration Date: " S Y=SREXP D DD^%DT W Y
 .S SRI=SRI+1
 W ! K DIR S DIR(0)="NO^1:"_SRI,DIR("A")="Select the blood product matching the unit label"
 D ^DIR K DIR I $D(DTOUT)!$D(DUOUT)!'Y S SRQ=1 Q
 S SRY=Y
 Q
MATCH ; retrieve matching units from list of available units
 S (SRIDT,SRMATCH)=0 F  S SRIDT=$O(^TMP("SRBL",$J,SRIDT)) Q:'SRIDT  D
 .S X=^TMP("SRBL",$J,SRIDT)
 .I $P(X,"^",3)=SRUID!($P(X,"^",12)=SRUID) S SRMATCH=SRMATCH+1,SRBL(SRMATCH)=X W !,"Eye Readable ID: ",$P(X,"^",3),!
 ;RLM Match either scanned or eye-readable label
 Q
CODA ; interpret Codabar barcodes used to label the Unit ID of blood component
 I $$ISBTUID(.X) S SRUID=X Q
 S SRUID=$$STRIP(X)
 W ?45,"UNIT ID: ",SRUID
 Q
SRYES S X=$P(SRBL(SRY),"^",2) D ^%DT I Y<DT D  D ASK Q
 .I SRMATCH=1 D LIST
 .W !!,?30,"**WARNING**",!!,"Today's date exceeds the blood product expiration date.",!
 W !!!,?25,"No Discrepancies Found",!!! K DIR S DIR(0)="FOA",DIR("A")="Press RETURN to continue" D ^DIR G END
SRNO W !!,?30,"**WARNING**",!!
 W ?5,"There is no record that this unit has been assigned to this patient."
 W !!,?8,"      Please recheck the patient and blood product IDs.",!!
ASK K DIR S DIR(0)="Y",DIR("A")="Do you want to scan another product (Y/N)",DIR("B")="YES" D ^DIR I Y D END G SCAN
END K ^TMP("SRBL",$J),DIR,SR,SRBL,SREXP,SRI,SRIDT,SRMATCH,SRNAME,SRPROD,SRPROMPT,SRQ,SRSSN,SRUID,SRY,SRZ,X,Y,Z
 Q
STRIP(X) ; strip off any ISBT-128 barcode identifier characters
 S X=$TR(X,"=<>&%(","")
 Q X
BAR ; test bar code reader
 N A,SR,SRABO,SRRH,SRPROMPT,X,Y S SR=""
 K DIR S DIR(0)="FAO^1:20" S DIR("A",1)="",(SRPROMPT,DIR("A"))="                         => "
 S DIR("A",2)="                            To use BAR CODE READER"
 S DIR("A",3)="               Pass reader wand over a GROUP-TYPE (ABO/Rh) label"
 S DIR("?",2)="     To test scanner, scan a GROUP-TYPE (ABO/Rh) label. Otherwise, press"
 S DIR("?",1)="",DIR("?")="     the Enter key." D ^DIR K DIR Q:$D(DTOUT)!$D(DUOUT)!(X="")
 W $C(13),$J("",79),$C(13),SRPROMPT,"(Bar code)"
 D ISBTBG(X,.SRABO,.SRRH) I SRABO]"" D  Q
 .S SR=1,SR(2)=""
 .W " ",SRABO," ",SRRH
 S X=$$STRIP(X)
 F A=1:1 S Y=$P($T(G+A),";",4) Q:Y=""  S X(1)=$F(X,Y) I X(1),$L(X)<X(1) S SR=$L(X)-3,SR(2)=$E(X,1,SR),SR=SR+1 Q
 I SR="" W $C(7),!!?28,"Not a GROUP-TYPE label",!?15,"Press <ENTER> key if BAR CODE READER is not used",! G BAR
 W " ",$P($T(G+A),";",3)
 Q
ISBTBG(SRIN,SRBLABO,SRBLRH) ; check for ISBT-128 valid blood group and return ABO & Rh values
 ; Valid codes are prefixed by "=%".
 ;
 ; INPUT  : SRIN = input from Blood Group barcode label.
 ; OUTPUT : SRBLABO (passed by reference) = ABO value
 ;          SRBLRH  (passed by reference) = Rh value
 ;
 N Z S (SRBLABO,SRBLRH)=""
 Q:$L(SRIN)'>3
 Q:$E(SRIN,1,2)'="=%"
 S Z=$E(SRIN,3,4)
 S SRBLABO=$S(57<Z&(Z<66):"A POS",46<Z&(Z<55):"O POS",90<Z&(Z<99):"O NEG",1<Z&(Z<10):"A NEG",12<Z&(Z<21):"B NEG",68<Z&(Z<77):"B POS",23<Z&(Z<32):"AB NEG",79<Z&(Z<88):"AB POS",1:"")
 Q:SRBLABO=""
 S SRBLRH=$P(SRBLABO," ",2)
 S SRBLABO=$P(SRBLABO," ")
 Q
ISBTUID(SRBLIN) ; Check for and display valid ISBT-128 Unit Id
 ; Valid codes are prefixed by "="
 ;
 ; INPUT  : SRBLIN = input from Unit Id barcode label.
 ; OUTPUT : Boolean
 ;
 Q:$E(SRBLIN,1,2)'?1"="1(1A,1N) 0
 S SRBLIN=$E(SRBLIN,2,14)
 S SRBLIN=$$UP^XLFSTR(SRBLIN) ; make uppercase
 W $C(13),$J("",79),$C(13),SRPROMPT,?32,"(Bar code)"
 D EN^DDIOL("UNIT ID: "_SRBLIN,"","?46")
 Q 1
G ;;
51 ;;O POS;510
62 ;;A POS;620
73 ;;B POS;730
84 ;;AB POS;840
95 ;;O NEG;950
6 ;;A NEG;060
17 ;;B NEG;170
28 ;;AB NEG;280
55 ;;O;550
66 ;;A;660
77 ;;B;770
88 ;;AB;880
 ;;NA NA;

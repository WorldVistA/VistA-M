HDISDOC ;BPFO/DTG - COMPILE SDO LIST FROM 101.43; Apr 07, 2018@12:42
 ;;1.0;HEALTH DATA & INFORMATICS;**22**;Feb 22, 2005;Build 26
 ;
 ; ICR's:
 ; 6895 - HDI READ ORDERABLE ITEMS File (#101.43)
 ; 6901 - HDI READ LABORATORY SERVICE LABORATORY TEST FILE (#60)
 ; 6902 - HDI READ MASTER LABORATORY TEST FILE (#66.3)
 ;
 ; 1131 - XMB('NETNAME')
 ;
 ; This routine collects and returns the SDO's associated to items in the orderable item file 101.43
 ;
 ; HDIAREA - Search area 'L' for LAB
 ; HDITYPE - Type of lookup 'S' for Single, 'P' for Partial Match, 'ALL' for ALL items
 ; HDIOIEN - may be one of 3 values. A) the IEN for a select item from the 101.43
 ;                                B) the word 'ALL' for all items for the HDIAREA selected
 ;                                C) a partial match to a 101.43 terms name. this is to collect
 ;                                   101.43 items that partial match the name passed in and are
 ;                                   associated to the HDIAREA.
 ; HDIRET - this is the return array in XML form. 
 ; HDIERR - (optional) If defined, If there is an error then it is set to a number
 ;           1 - area not sent. 2 - lookup value not sent. 3 - return value not sent.
 ;           4 - Improper Search Area
 ;           5 - single item not found in 101.43.
 ;           6 - single item not in area.
 ;           7 - Partial Lookup Error.
 ;           8 - Orderable Items File Does Not Have Lab Pointer for Item.
 ;           9 - Orderable Item Lab Pointer Not Found in Lab File.
 ;          10 -
 ;          11 -
 ;          12 - Lookup type not sent
 ;
 ; HDICNT - This will contain counts of the various orders
 ;          Area - L.   The return will be different based on the area.
 ;
 ;          Laboratory L ^ Orderable Item Count (#101.43) ^ Number of Orderable Items Inactive 
 ;          ^ Number of Mnemonics ^ Number of Primary Lab Tests (#60) 
 ;          ^ Number of Primary Tests are Panels ^ Total Number of Tests (#60) ^ Number of Inactive tests 
 ;          ^ Total Number of Specimens (#60, #100) ^ number of inactive specimens 
 ;          ^ Number of Master Laboratory Tests (#66.3) ^ number of inactive MLTF's ^ number of unique tests referenced
 ;          ^ number of unique MLTF items referenced
 ;
 ; HDIMN   This is for further delineation of a 'SINGLE' look-up. If the Single item is identified as
 ;         an mnemonic by the calling routine the value would be 'Y' for yes.
 ;
 N MSG
 S MSG(1)="   This option may not be called directly from the menu options"
 S MSG(2)="   Please use option HDI REQUEST SDO."
 S MSG(3)=""
 D CLEAR^VALM1
 D BMES^XPDUTL(.MSG)
 K MSG
 Q 
 ;
 ;
EN(HDIAREA,HDITYPE,HDIOIEN,HDIRET,HDIERR,HDICNT,HDIMN) ; entry for lookup
 I $G(DT)="" S DT=$$DT^XLFDT
 I $G(U)="" S U="^"
 N A,B,C,D,E,F,G,I,DA,DR,ROOT,TMP,LAB,PHM,NAR,OK,XHEAD,WB,ORMN,PART,LKUP,O,LAM,RAM,PAM,OIC,OICI
 N ORDNM,ORIDT,ORIEN,ORST,DIC,DIQ,K,L,TMPCT,HDIERAR
 N HDIA1,HDIA2
 S A=$$SITE^VASITE,WB=$P(A,U,2)_"-"_$P(A,U,1),OIC=0,OICI=0,HDIERAR=""
 S HDIA1="^TMP(""HDIA1"",$J)",HDIA2="^TMP(""HDIA2"",$J)"
 I $G(HDIAREA)="" S HDIERAR=1 ; quit if no area selected
 I $G(HDITYPE)="" S HDIERAR=HDIERAR_$S(HDIERAR'="":",",1:"")_12 ; quit if no lookup value is sent
 I $G(HDIOIEN)="" S HDIERAR=HDIERAR_$S(HDIERAR'="":",",1:"")_2 ; quit if no lookup value is sent
 I $G(HDIRET)="" S HDIERAR=HDIERAR_$S(HDIERAR'="":",",1:"")_3 ; quit if return array is not defined
 I HDIERAR'="" Q HDIERAR
 ;
 K ^TMP("HDISDOLIST",$J),^TMP("HDITMCT",$J)
 S TMPCT="^TMP(""HDITMCT"",$J)"
 S TMP="^TMP(""HDISDOLIST"",$J)",@TMP@(0)=0
 S A=$$UP^XLFSTR(HDIAREA),ORMN="",HDIAREA=A
 S NAR=$S($E(A)="L":"LAB",1:"")
 I NAR="" S HDIERAR=HDIERAR_$S(HDIERAR'="":",",1:"")_4 Q HDIERAR ; proper area not selected
 I $G(HDICNT)'="" S @HDICNT=A
 ;xml header
 S XHEAD=$S(NAR="LAB":"Laboratory",1:"no area")_"_Orderable_Items",B="xmlns:xs="
 S @TMP@(0)=0
 S D=$$BTMP,@TMP@(D)=$$XMLHDR^MXMLUTL()
 S D=$$BTMP,@TMP@(D)="<"_XHEAD_" "_B_"""http://www.w3.org/2001/XMLSchema"">"
 S D=$$BTMP,@TMP@(D)="<Facility>"
 S D=$$BTMP,@TMP@(D)="<Facility_Name-Number>"_WB_"</Facility_Name-Number>"
 S A=$$PROD^XUPROD(),B=$S(A="1":"YES",1:"NO"),D=$$BTMP,@TMP@(D)="<Facility_Production_Account>"_B_"</Facility_Production_Account>"
 S A=$G(^XMB("NETNAME"))
 S LKUP=$S($E(HDITYPE,1)="S":"SINGLE",$E(HDITYPE,1)="P":"PARTIAL",HDITYPE="ALL":"ALL",1:"")
 S D=$$BTMP,@TMP@(D)="<Facility_Net_Name>"_A_"</Facility_Net_Name>"
 S D=$$BTMP,@TMP@(D)="<Look_up_Type>"_LKUP_"</Look_up_Type>"
 I LKUP="PARTIAL" S D=$$BTMP,@TMP@(D)="<Look_up_Partial_Name>"_HDIOIEN_"</Look_up_Partial_Name>"
 S D=$$BTMP,@TMP@(D)="</Facility>"
 I LKUP="" S D=$$BTMP,@TMP@(D)="<Look_up_Type_Error>Look up Type: "_HDIOIEN_", not Identified</Look_up_Type_Error>" G OUT
 ;
 ; set up allowable sets by area
 F I="RX","O RX","UD RX","NV RX","IVA RX","IVB RX","IVM RX","I RX" S PHM(I)=1
 F I="LAB","CH","MI","EM","SP","CY","AU" S LAB(I)=1
 ;set up if XML
 ;
 I HDIOIEN="ALL" G ALL
 I HDIOIEN?1N.N S A=$$GET1^DIQ(101.43,HDIOIEN_",",.01) I A'="" G IEN
 ;   test names may start with alpha, numeric, punctuation.
 G PARTIAL
 Q
 ;
ALL ; get all items for an area
 K @HDIA1,@HDIA2
 D LIST^DIC(101.43,,"@;.001I","MUQ",,,,,,,HDIA1)
 S A=0 F  S A=$O(@HDIA1@("DILIST",2,A)) Q:'A  S B=$G(@HDIA1@("DILIST",2,A)),@HDIA2@(B)=""
 K @HDIA1
 S HDIOIEN=0
A1 S HDIOIEN=$O(@HDIA2@(HDIOIEN)) I 'HDIOIEN K @HDIA2 G OUT
 ;check that orderable item is for the area
 S OK=$$CHKO(HDIOIEN)
 I 'OK G A1
 I NAR="LAB" D LAB(HDIOIEN)
 G A1
 ;
PARTIAL ; get items that partial match the name sent
 S PART=HDIOIEN K ^TMP("HDICHK",$J)
 K @HDIA1,@HDIA2
 ; this will pick up those items with mnemonics that are related to the partial name sent in.
 ; since a orderable name and its mnemonic can start the same place into a temp area to reduce duplication.
 D LIST^DIC(101.43,,";.01I","",,,PART,"B",,,HDIA1)
 S A=0 F  S A=$O(@HDIA1@("DILIST",2,A)) Q:'A  D  ;<
 . S D=$G(@HDIA1@("DILIST",2,A)),E=$G(@HDIA1@("DILIST",1,A)),F=$G(@HDIA1@("DILIST","ID",A,.01))
 . S B=$S(((E'=F)&($E(F,1,$L(PART))'=PART)):1,1:"")
 . S:'$D(@HDIA2@(D)) @HDIA2@(D)=B
 K @HDIA1
 S A=0
P1A S A=$O(@HDIA2@(A)) I 'A G P2
 ; make sure the item is for the correct area.
 S OK=$$CHKO(A)
 I 'OK D  ;<
 . K @HDIA2@(A)
 G P1A
 ;
P2 I $O(@HDIA2@(0))="" D  G OUT
 . S HDIERAR=HDIERAR_$S(HDIERAR'="":",",1:"")_7
 . I $G(HDIERR)'="" S D=$G(@HDIERR@(0)),D=D+1,@HDIERR@(0)=D,@HDIERR@(D)="Partial_lookup_Error. Partial Name: "_PART_", not found for Area: "_NAR
 S HDIOIEN=0
P2A S HDIOIEN=$O(@HDIA2@(HDIOIEN)) I 'HDIOIEN K @HDIA2 G OUT
 S ORMN=$S($G(@HDIA2@(HDIOIEN))=1:"YES",1:"")
 I NAR="LAB" D LAB(HDIOIEN)
 G P2A
 ;
IEN ; find entry for a single IEN in 101.43
 S D=$$GET1^DIQ(101.43,HDIOIEN_",",.01) I D="" S HDIERAR=HDIERAR_$S(HDIERAR'="":",",1:"")_5 D  G OUT
 . I $G(HDIERR)'="" S D=$G(@HDIERR@(0)),D=D+1,@HDIERR@(0)=D,@HDIERR@(D)="Single_Lookup_Error ("_$G(HDIOIEN)_") Entry Not Found in Orderable Items File"
 ; quit on first good
 S OK=$$CHKO(HDIOIEN)
 I 'OK S HDIERAR=HDIERAR_$S(HDIERAR'="":",",1:"")_6 D  G OUT
 . I $G(HDIERR)'="" S D=$G(@HDIERR@(0)),D=D+1,@HDIERR@(0)=D,@HDIERR@(D)="Single_Lookup_Error ("_$G(HDIOIEN)_") Entry Not Found in Orderable Items File"
 I $G(HDIMN)="Y" S ORMN="YES"
 I NAR="LAB" D LAB(HDIOIEN)
 G OUT
 ;
OUT ; return to calling routine
 S D=$$BTMP,@TMP@(D)="</"_XHEAD_">"
 I $G(HDICNT)'="" D  ;<
 . I NAR="LAB" D  ;<
 . . N A,B,C S (A,B)=0 F  S A=$O(@TMPCT@("T",A)) Q:'A  S B=B+1
 . . S L=@HDICNT,$P(L,U,13)=B
 . . S (A,B)=0 F  S A=$O(@TMPCT@("M",A)) Q:'A  S B=B+1
 . . I B S $P(L,U,14)=B
 . . S @HDICNT=L
 K @HDIRET
 M @HDIRET=@TMP
 K @TMP
 K A,B,C,D,E,F,G,I,DA,DR,ROOT,TMP,LAB,PHM,NAR,OK,XHEAD,WB,ORMN,PART,LKUP,O,LAM,RAM,PAM
 K ORDNM,ORIDT,ORIEN,ORST,DIC,DIQ
 K HDIA1,HDIA2
 I HDIERAR'="" Q HDIERAR
 Q "0"
 Q
 ;
LAB(LAM) ;get laboratory SDO's
 ;
 G LEN^HDISDOCL
 ;
ORDI(A) ; get info from 101.43
 S DA=A
 N OA,OB,B,C,D,E,F,O,R,K,M,AAA,AAB,AAC,AAD
 S C="",DIQ="OB",DIQ(0)="IE",DIC=101.43,DR=".01;2;.1" K ^UTILITY("DIQ1",$J) D EN^DIQ1 K ^UTILITY("DIQ1",$J)
 K OA M OA=OB(101.43,DA) K OB
 S ORDNM=$$CHKCHAR($G(OA(.01,"E"))),B=$G(OA(.1,"I")),ORIEN=DA,C=$P($G(OA(2,"I")),";",1)
 S ORIDT="",ORST=0 S:(B&(B<DT+1)) ORST=1 S:B ORIDT=$$FMTE^XLFDT($P(B,".",1),5)
 I $G(HDICNT)'="" D  ;<
 . S L=@HDICNT,K=$P(L,U,2),K=K+1,$P(L,U,2)=K
 . I ORIDT'="" S K=$P(L,U,3),K=K+1,$P(L,U,3)=K
 . I ORMN'="" S K=$P(L,U,4),K=K+1,$P(L,U,4)=K
 . S @HDICNT=L
 ; set up order info if XML
 S OIC=OIC+1
 S D=$$BTMP,@TMP@(D)="<Orderable_Item>"
 S D=$$BTMP,@TMP@(D)="<Orderable_Item_Number>"_ORIEN_"</Orderable_Item_Number>"
 S D=$$BTMP,@TMP@(D)="<Orderable_Item_Name>"_ORDNM_"</Orderable_Item_Name>"
 S D=$$BTMP,@TMP@(D)="<Orderable_Item_Mnemonic>"_ORMN_"</Orderable_Item_Mnemonic>"
 S D=$$BTMP,@TMP@(D)="<Orderable_Item_Inactive_Date>"_ORIDT_"</Orderable_Item_Inactive_Date>"
 S D=$$BTMP,@TMP@(D)="<Orderable_Item_Status>"_ORST_"</Orderable_Item_Status>"
 ; add in the synonym's
 S D=$$BTMP,@TMP@(D)="<Orderable_Item_Synonym>"
 K AAA D LIST^DIC(101.432,","_DA_",","@;.01I","",,,,,,,"AAA")
 K AAB,AAC,AAD M AAB=AAA("DILIST","ID"),AAD=AAA("DILIST",2)
 S M=0 F  S M=$O(AAD(M)) Q:'M  S F=$G(AAD(M)),AAC(F)=$G(AAB(M,.01))
 S O=0 F  S O=$O(AAC(O)) Q:'O  S R=$$CHKCHAR($G(AAC(O))) D  ;<
 . S D=$$BTMP,@TMP@(D)="<Orderable_Item_Synonym_Name>"_R_"</Orderable_Item_Synonym_Name>"
 S D=$$BTMP,@TMP@(D)="</Orderable_Item_Synonym>"
 K AAA,AAB,AAC,AAD
 Q C
 ;
 ;bump tmp counter
BTMP() ;
 N F
 S F=$G(@TMP@(0)),F=F+1,@TMP@(0)=F
 Q F
 ;
CHKCHAR(A) ; check for ctrl chars, <, >, &
 N B,C,I,L,M,N
 I A="" Q A
 S B="" F I=1:1:$L(A) S C=$E(A,I) D  S L=C
 . S M=$E(A,(I+1))
 . I $A(C)<32!($A(C)>126) Q  ; skip set
 . I C="&" S N="'AND'",B=B_N Q
 . I C="<" S N="'LESS THAN'",B=B_N Q
 . I C=">" S N="'GREATER THAN'",B=B_N Q
 . S B=B_C
 Q B
 ;
OH10143 ;header 101.43
 S D=$$BTMP,@TMP@(D)="<Orderable_Item>"
 Q
 ;
OT10143 ; trailer for 101.43
 S D=$$BTMP,@TMP@(D)="</Orderable_Item>"
 Q
 ;
OB10143 ; body for 101.43
 S D=$$BTMP,@TMP@(D)="<Orderable_Item_Number>"_ORIEN_"</Orderable_Item_Number>"
 S D=$$BTMP,@TMP@(D)="<Orderable_Item_Name>"_ORDNM_"</Orderable_Item_Name>"
 S D=$$BTMP,@TMP@(D)="<Orderable_Item_Inactive_Date>"_ORIDT_"</Orderable_Item_Inactive_Date>"
 S D=$$BTMP,@TMP@(D)="<Orderable_Item_Status>"_ORST_"</Orderable_Item_Status>"
 Q
 ;
CHKO(HOI) ;check if order belongs to the correct area
 N A,B,AA,AR,E
 S OK="" K AA D LIST^DIC(101.439,","_HOI_",","@;.01I","",,,,,,,"AA")
 K AR M AR=AA("DILIST","ID") K AA
 S E="" F  S E=$O(AR(E)) Q:'E  S B=$G(AR(E,.01)) S:$G(@NAR@(B))=1 OK=1 I (HDIAREA="L"&((B="BB")!(B="HEMA")!(B="AP")!(B="VBC")!(B="VBEC")!(B="Hemo"))) S OK="" Q
 K AR,A,B,AA,E
 Q OK
 ;

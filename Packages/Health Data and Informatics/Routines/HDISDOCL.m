HDISDOCL ;BPFO/DTG - COLLECT LABORTORY ITEMS FOR SDO LIST; Apr 07, 2018@12:42
 ;;1.0;HEALTH DATA & INFORMATICS;**22**;Feb 22, 2005;Build 26
 ;
 ; ICR's:
 ; 6901 - HDI READ LABORATORY SERVICE LABORATORY TEST FILE (#60)
 ; 6902 - HDI READ MASTER LABORATORY TEST FILE (#66.3)
 ;
 Q
 ;
 ;bump tmp counter
BTMP() ;
 N F
 S F=$G(@TMP@(0)),F=F+1,@TMP@(0)=F
 Q F
 ;
LEN ; lab entry point
 ;
 ; LAB TEST IEN, TEST NAME .01, TEST INACTIVE DATE 133, TEST INACTIVE STATUS 132, TEST TYPE 3,
 ; PANEL 200 SUB MULTIPLE, LOCATION DATA NAME #5,13, SITE/SPECIMEN 100, SITE/SPECIMEN IEN, R/S NAME .01,
 ; RESULT/SPECIMEN 33, R/S STATUS 32, MLTF PTR 30
 ; 66.3
 ; IEN, NAME .01, STATUS, LOINC CODE .04, ALT TEST NAME .02
 ;
 N DA,DR,DIR,I,D,B,DIQ,DIC,ORDNM,ORIEN,ORIDT,ORST,PLIEN,PLNAME,PLPN,LT,LG,LB,LC,LRUN,LRIEN,LRNAME,LRMLIDT
 N LRTYPE,LRDAT,LRDAP,LRSTAT,LRIDT,LRSPEC,LRSPN,LRSUN,LRSST,LRSIDT,LRMLTF,LRMLNM,LRMLAN,LRMLLON,LTMP,LRMLSTAT
 N LRMLCOM,LRMLPROP,LRMLTIM,LRMLSPEC,LRMLSCAL,LRMLMET,L60,LPRI,LE,LF,PNLNN
 N LTCNT,BA,LRAA,AA,AR,AB,ABC
 ; initialize vars to avoid undef
 S (DA,DR,DIR,I,D,B,DIQ,DIC,ORDNM,ORIEN,ORIDT,ORST,PLIEN,PLNAME,PLPN,LT,LG,LB,LC,LRUN,LRIEN,LRNAME,LRMLIDT)=""
 S (LRTYPE,LRDAT,LRDAP,LRSTAT,LRIDT,LRSPEC,LRSPN,LRSUN,LRSST,LRSIDT,LRMLTF,LRMLNM,LRMLAN,LRMLLON,LRMLSTAT)=""
 S (LRMLCOM,LRMLPROP,LRMLTIM,LRMLSPEC,LRMLSCAL,LRMLMET,L60,LPRI,LE,LF)=""
 ; get info from 101.43
 ;
 S L60=$$ORDI^HDISDOC(LAM),LPRI=L60
 ;
 S (PLIEN,DA)=L60,PLPN="NO",LT="",LTMP="^TMP(""HDILAB1"",$J)" K @LTMP K DD
 ; check if 60 IEN
 I 'L60 D  G LQUIT
 . S (PLIEN,PLNAME,PLPN)=""
 . S (LRIEN,LRNAME,LRTYPE,LRDAT,LRDAP,LRIDT,LRSTAT)=""
 . S (LRSPEC,LRSPN,LRSUN,LRSIDT,LRSST)=""
 . S (LRMLTF,LRMLNM,LRMLAN,LRMLIDT,LRMLSTAT,LRMLLON,LRMLCOM,LRMLPROP,LRMLTIM,LRMLSPEC,LRMLSCAL,LRMLMET)=""
 . D LH60P,LB60P,LH60T,LB60T,LH6001,LB6001,LH663,LB663,LT663,LT6001,LT60T
 . S HDIERAR=HDIERAR_$S(HDIERAR'="":",",1:"")_8
 . I $G(HDIERR)'="" S D=$G(@HDIERR@(0)),D=D+1,@HDIERR@(0)=D,@HDIERR@(D)="Orderable Item File Does Not Have a Lab File Number Associated. "_LAM_":"_ORDNM
 ;
 S A=$$GET1^DIQ(60,L60_",",.01) I A="" D  G LQUIT
 . S (PLIEN,PLNAME,PLPN)=""
 . S (LRIEN,LRNAME,LRTYPE,LRDAT,LRDAP,LRIDT,LRSTAT)=""
 . S (LRSPEC,LRSPN,LRSUN,LRSIDT,LRSST)=""
 . S (LRMLTF,LRMLNM,LRMLAN,LRMLIDT,LRMLSTAT,LRMLLON,LRMLCOM,LRMLPROP,LRMLTIM,LRMLSPEC,LRMLSCAL,LRMLMET)=""
 . D LH60P,LB60P,LH60T,LB60T,LH6001,LB6001,LH663,LB663,LT663,LT6001,LT60T
 . S HDIERAR=HDIERAR_$S(HDIERAR'="":",",1:"")_9
 . I $G(HDIERR)'="" S D=$G(@HDIERR@(0)),D=D+1,@HDIERR@(0)=D,@HDIERR@(D)="Orderable Item Lab Pointer Not Found in Lab File. "_LAM_":"_ORDNM_":"_L60
 ;
 ;build array
 ; first determine if panel
 K BA D LIST^DIC(60.02,","_L60_",","@;.01I","",,,,,,,"BA")
 S A=$O(BA("DILIST","ID",0)) I A S PLPN="YES"
 K PNLNN,BA
 D PNLCK(PLIEN),GETLAB(PLIEN)
 S PLNAME=$$CHKCHAR($G(LC(.01,"E")))
 I $G(HDICNT)'="" D  ;<
 . S L=@HDICNT,K=$P(L,U,5),K=K+1,$P(L,U,5)=K
 . I PLPN="YES" S K=$P(L,U,6),K=K+1,$P(L,U,6)=K
 . S @HDICNT=L
 D LH60P,LB60P
 ; go through the test array
 S (LRIEN,LRNAME,LRTYPE,LRDAT,LRDAP,LRSTAT,LRIDT,LRSPEC,LRSPN,LRSUN,LRSST,LRSIDT,LRMLTF,LRMLNM,LRMLAN,LRMLSTAT)=""
 S LRMLLON="N/F",(LRMLCOM,LRMLPROP,LRMLTIM,LRMLSPEC,LRMLSCAL,LRMLMET)=""
 S A=$O(@LTMP@(0)) I 'A D  G LQUIT
 . S (LRIEN,LRNAME,LRTYPE,LRDAT,LRDAP,LRIDT,LRSTAT)=""
 . S (LRSPEC,LRSPN,LRSUN,LRSIDT,LRSST)=""
 . S (LRMLTF,LRMLNM,LRMLAN,LRMLIDT,LRMLSTAT,LRMLLON,LRMLCOM,LRMLPROP,LRMLTIM,LRMLSPEC,LRMLSCAL,LRMLMET)=""
 . D LH60T,LB60T,LH6001,LB6001,LH663,LB663,LT663,LT6001,LT60T
 ;
 S LRUN=0
LRT S LRUN=$O(@LTMP@(LRUN)) I 'LRUN G LQUIT
 D GETLAB(LRUN) S LRIEN=LRUN,LRNAME=$$CHKCHAR($G(LC(.01,"E"))),LRTYPE=$G(LC(3,"E"))
 S LRDAT=$G(LC(5,"I")),LRDAP=$G(LC(13,"I"))
 S A=$G(LC(132,"I")),LRSTAT=$S(A="Y":1,1:0),A=$G(LC(133,"I")),LRIDT="" I A S LRIDT=$$FMTE^XLFDT(A,5)
 I $G(HDICNT)'="" D  ;<
 . S L=@HDICNT,K=$P(L,U,7),K=K+1,$P(L,U,7)=K
 . I LRIDT'="" S K=$P(L,U,8),K=K+1,$P(L,U,8)=K
 . S @HDICNT=L
 . ; collect unique tests for count
 . S @TMPCT@("T",LRUN)=""
 D LH60T,LB60T
 ; check specimens
 S (LRSPEC,LRSPN,LRSUN,LRSST,LRSIDT,LRMLTF,LRMLNM,LRMLAN,LRMLSTAT,LRMLIDT)=""
 S LRMLLON="N/F"
 ; S A=$$GET1^DIQ(60,L60_",",.01) I A="" D  G LRT
 K AA D LIST^DIC(60.01,","_LRUN_",","@;.001I","Q",,,,,,,"AA")
 S A=0,A=$O(AA("DILIST",2,A)) I 'A D  G LRT
 . S (LRSPEC,LRSPN,LRSUN,LRSIDT,LRSST)=""
 . S (LRMLTF,LRMLNM,LRMLAN,LRMLIDT,LRMLSTAT,LRMLLON,LRMLCOM,LRMLPROP,LRMLTIM,LRMLSPEC,LRMLSCAL,LRMLMET)=""
 . D LH6001,LB6001,LH663,LB663,LT663,LT6001,LT60T
 ;
 S LRSPEC=0
 K LRAA S A=0 F  S A=$O(AA("DILIST",2,A)) Q:'A  S LRAA($G(AA("DILIST",2,A)))=""
LRS ;S LRSPEC=$O(^LAB(60,LRUN,1,LRSPEC)) I 'LRSPEC D LT60T G LRT
 S LRSPEC=$O(LRAA(LRSPEC)) I 'LRSPEC D LT60T G LRT
 D GETSPEC(LRUN,LRSPEC)
 S LRSPN=$$CHKCHAR($G(LE(.01,"E"))),LRSUN=$G(LE(6,"E")),B=$G(LE(32,"I")),LRSST=$S(B="Y":1,1:"0")
 S B=$G(LE(33,"I")),LRSIDT="" I B S LRSIDT=$$FMTE^XLFDT(B,5)
 S LRMLTF=$G(LE(30,"I"))
 I $G(HDICNT)'="" D  ;<
 . S L=@HDICNT,K=$P(L,U,9),K=K+1,$P(L,U,9)=K
 . I LRSIDT'="" S K=$P(L,U,10),K=K+1,$P(L,U,10)=K
 . S @HDICNT=L
 D LH6001,LB6001
 I LRMLTF D  ;<
 . D GETMLTF(LRMLTF)
 . S LRMLNM=$$CHKCHAR($G(LF(.01,"E"))),LRMLAN=$$CHKCHAR($G(LF(.02,"E"))),LRMLLON=$G(LF(.04,"I")) S:LRMLLON="" LRMLLON="N/F"
 . S LRMLCOM=$$CHKCHAR($G(LF(.05,"E"))),LRMLPROP=$$CHKCHAR($G(LF(.06,"E"))),LRMLTIM=$$CHKCHAR($G(LF(.07,"E")))
 . S LRMLSPEC=$$CHKCHAR($G(LF(.08,"E"))),LRMLSCAL=$$CHKCHAR($G(LF(.09,"E"))),LRMLMET=$$CHKCHAR($G(LF(1,"E")))
 . ; get status
 . N DA,AA,LXH,A,B,C S DA=LRMLTF D LIST^DIC(66.399,","_DA_",","@;.01IE;.02IE","",,,,,,,"AA")
 . K LXH M LXH=AA("DILIST","ID") K AA
 . S A=$O(LXH(99999999),-1),B=$G(LXH(A,.02,"E")),C=$G(LXH(A,.01,"I"))
 . S LRMLSTAT=0,LRMLIDT="" S LRMLSTAT=$S(B="INACTIVE":1,1:0) I LRMLSTAT S LRMLIDT=$$FMTE^XLFDT($P(C,".",1),5)
 . I $G(HDICNT)'="" D  ;<
 . . S L=@HDICNT,K=$P(L,U,11),K=K+1,$P(L,U,11)=K
 . . I LRMLIDT'="" S K=$P(L,U,12),K=K+1,$P(L,U,12)=K
 . . S @HDICNT=L
 . . ; get unique mltf items
 . . S @TMPCT@("M",LRMLTF)=""
 I 'LRMLTF S (LRMLTF,LRMLNM,LRMLAN,LRMLCOM,LRMLPROP,LRMLTIM,LRMLSPEC,LRMLSCAL,LRMLMET,LRMLIDT,LRMLSTAT,LRMLLON)=""
 D LH663,LB663,LT663,LT6001
 G LRS
 ;
LQUIT ; quit back
 D LT60P,OT10143^HDISDOC
 K @LTMP
 K DA,DR,DIR,I,D,B,DIQ,DIC,ORDNM,ORIEN,ORIDT,ORST,PLIEN,PLNAME,PLPN,LT,LG,LB,LC,LRUN,LRIEN,LRNAME
 K LRTYPE,LRDAT,LRDAP,LRSTAT,LRIDT,LRSPEC,LRSPN,LRSUN,LRSST,LRSIDT,LRMLTF,LRMLNM,LRMLAN,LRMLLON,LTMP
 K LRMLCOM,LRMLPROP,LRMLTIM,LRMLSPEC,LRMLSCAL,LRMLMET,L60,LPRI,LE,LF,PNLNN
 K LTCNT,BA,LRAA,AA,AR,AB,ABC
 Q
 ;
PNLCK(LT) ; check for panel
 N A,B,C,D,AA,AR,BA,BR S A=0
 Q:'LT
 S PNLNN(LT)=1
 K AA D LIST^DIC(60.02,","_LT_",","@;.01I","",,,,,,,"AA")
 K AR M AR=AA("DILIST","ID") K AA
 S A=$O(AR(A)) I 'A S @LTMP@(LT)="" Q
 S A=0 F  S A=$O(AR(A)) Q:'A  D  ;<
 . S C=$G(AR(A,.01)) Q:'C
 . ; only have the test once for cycle of primary item
 . I $G(PNLNN(C))=1 Q
 . S PNLNN(C)=1
 . K BA D LIST^DIC(60.02,","_C_",","@;.01I","",,,,,,,"BA")
 . S B=$O(BA("DILIST","ID",0)) I B D PNLCK(C)
 . S @LTMP@(C)=""
 Q
 ;
CHKCHAR(A) ; check for ctrl chars, <, >, &, /
 N B,C,I,L,M,N
 I A="" Q A
 S B="" F I=1:1:$L(A) S C=$E(A,I) D  S L=C
 . S M=$E(A,(I+1))
 . I $A(C)<32!($A(C)>126) Q  ; skip set
 . I C="&" S N="'AND'",B=B_N Q
 . I C="<" S N="'LESS THAN'",B=B_N Q
 . I C=">" S N="'GREATER THAN'",B=B_N Q
 . ;I C="/" S N="'FORWARD SLASH'",B=B_N Q
 . S B=B_C
 Q B
 ;
GETLAB(LG) ; get lab test info
 N A,B,C,D,DA,DR,DIQ
 Q:'LG
 S DA=LG,DIQ="LB",DIQ(0)="IE",DIC=60,DR=".01;3;5;13;133;132" K ^UTILITY("DIQ1",$J) D EN^DIQ1 K ^UTILITY("DIQ1",$J)
 K LC M LC=LB(60,DA) K LB
 ;
GETSPEC(LG,LS) ; get lab test specimen info
 N A,B,C,D,DA,DR,DIQ
 S DIQ="LB",DIQ(0)="IE",DIC=60,DR=100,DA=+LG K LB,^UTILITY("DIQ1",$J)
 S DR(60.01)=".01;6;30;32;33",DA(60.01)=LS
 D EN^DIQ1 K ^UTILITY("DIQ1",$J)
 K LE M LE=LB("60.01",LS) K LB
 Q
 ;
GETMLTF(LM) ; get mltf info from file 66.3
 N A,B,C,D,DA,DR,DIQ
 Q:'LM
 S DA=LM,DIQ="LB",DIQ(0)="IE",DIC=66.3,DR=".01;.02;.04;.05;.06;.07;.08;.09;1" K ^UTILITY("DIQ1",$J) D EN^DIQ1 K ^UTILITY("DIQ1",$J)
 K LF M LF=LB(66.3,DA) K LB
 Q
 ;
LH60P ; header for primary item
 S D=$$BTMP,@TMP@(D)="<Lab_Primary_Order_Item>"
 Q
 ;
LT60P ; trailer for primary item
 S D=$$BTMP,@TMP@(D)="</Lab_Primary_Order_Item>"
 Q
 ;
LB60P ; body for primary item
 S D=$$BTMP,@TMP@(D)="<Lab_Primary_Test_IEN>"_PLIEN_"</Lab_Primary_Test_IEN>"
 S D=$$BTMP,@TMP@(D)="<Lab_Primary_Test_Name>"_PLNAME_"</Lab_Primary_Test_Name>"
 S D=$$BTMP,@TMP@(D)="<Lab_Primary_Test_Panel>"_PLPN_"</Lab_Primary_Test_Panel>"
 Q
 ;
LH60T ; test header for file 60
 S D=$$BTMP,@TMP@(D)="<Laboratory_Test_Item>"
 Q
 ;
LT60T ; test trailer for file 60
 S D=$$BTMP,@TMP@(D)="</Laboratory_Test_Item>"
 Q
 ;
LB60T ; test body for file 60
 S D=$$BTMP,@TMP@(D)="<Lab_Test_IEN>"_LRIEN_"</Lab_Test_IEN>"
 S D=$$BTMP,@TMP@(D)="<Lab_Test_Name>"_LRNAME_"</Lab_Test_Name>"
 S D=$$BTMP,@TMP@(D)="<Lab_Test_Type>"_LRTYPE_"</Lab_Test_Type>"
 S D=$$BTMP,@TMP@(D)="<Lab_Test_Data_Location>"_LRDAT_"</Lab_Test_Data_Location>"
 S D=$$BTMP,@TMP@(D)="<Lab_Test_Data_Loc_Physical>"_LRDAP_"</Lab_Test_Data_Loc_Physical>"
 S D=$$BTMP,@TMP@(D)="<Lab_Test_Inactive_Date>"_LRIDT_"</Lab_Test_Inactive_Date>"
 S D=$$BTMP,@TMP@(D)="<Lab_Test_Status>"_LRSTAT_"</Lab_Test_Status>"
 Q
 ;
LH6001 ; test specimen header for file 60.01
 S D=$$BTMP,@TMP@(D)="<Lab_Test_Specimen>"
 Q
 ;
LT6001 ; test specimen trailer for file 60.01
 S D=$$BTMP,@TMP@(D)="</Lab_Test_Specimen>"
 Q
 ;
LB6001 ; test spceimen body for file 60.01
 S D=$$BTMP,@TMP@(D)="<Lab_Test_Specimen_IEN>"_LRSPEC_"</Lab_Test_Specimen_IEN>"
 S D=$$BTMP,@TMP@(D)="<Lab_Test_Specimen_Name>"_LRSPN_"</Lab_Test_Specimen_Name>"
 S D=$$BTMP,@TMP@(D)="<Lab_Test_Specimen_Units>"_LRSUN_"</Lab_Test_Specimen_Units>"
 S D=$$BTMP,@TMP@(D)="<Lab_Test_Specimen_Inactive_Date>"_LRSIDT_"</Lab_Test_Specimen_Inactive_Date>"
 S D=$$BTMP,@TMP@(D)="<Lab_Test_Specimen_Status>"_LRSST_"</Lab_Test_Specimen_Status>"
 Q
 ;
LH663 ; header for mltf 66.3
 S D=$$BTMP,@TMP@(D)="<Master_Lab_Test_Item>"
 Q
 ;
LT663 ;trailer for mltf 66.3
 S D=$$BTMP,@TMP@(D)="</Master_Lab_Test_Item>"
 Q
 ;
LB663 ; body for mltf 66.3
 S D=$$BTMP,@TMP@(D)="<Master_Lab_Test_IEN>"_LRMLTF_"</Master_Lab_Test_IEN>"
 S D=$$BTMP,@TMP@(D)="<Master_Lab_Test_Name>"_LRMLNM_"</Master_Lab_Test_Name>"
 S D=$$BTMP,@TMP@(D)="<Master_Lab_Test_Alternate_Name>"_LRMLAN_"</Master_Lab_Test_Alternate_Name>"
 S D=$$BTMP,@TMP@(D)="<Master_Lab_Test_Inactive_Date>"_LRMLIDT_"</Master_Lab_Test_Inactive_Date>"
 S D=$$BTMP,@TMP@(D)="<Master_Lab_Test_Status>"_LRMLSTAT_"</Master_Lab_Test_Status>"
 S D=$$BTMP,@TMP@(D)="<Master_Lab_Test_LOINC_Code>"_LRMLLON_"</Master_Lab_Test_LOINC_Code>"
 S D=$$BTMP,@TMP@(D)="<Master_Lab_Test_Component>"_LRMLCOM_"</Master_Lab_Test_Component>"
 S D=$$BTMP,@TMP@(D)="<Master_Lab_Test_Property>"_LRMLPROP_"</Master_Lab_Test_Property>"
 S D=$$BTMP,@TMP@(D)="<Master_Lab_Test_Time_Aspect>"_LRMLTIM_"</Master_Lab_Test_Time_Aspect>"
 S D=$$BTMP,@TMP@(D)="<Master_Lab_Test_Specimen>"_LRMLSPEC_"</Master_Lab_Test_Specimen>"
 S D=$$BTMP,@TMP@(D)="<Master_Lab_Test_Scale>"_LRMLSCAL_"</Master_Lab_Test_Scale>"
 S D=$$BTMP,@TMP@(D)="<Master_Lab_Test_Method>"_LRMLMET_"</Master_Lab_Test_Method>"
 Q

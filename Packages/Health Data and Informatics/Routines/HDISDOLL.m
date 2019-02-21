HDISDOLL ;BPFO/DTG - DISPLAY LOOKUP ITEMS FOR LABORATORY; Apr 07, 2018@12:42
 ;;1.0;HEALTH DATA & INFORMATICS;**22**;Feb 22, 2005;Build 26
 ;
 ;
EN ; Display found orderable items for Lab
 ;
 ;
 ;
 ; put XML into tmp file
 ;^TMP("HDISDOLL",$J,"T")= Orderable Item Type (P, L, or R)
 ;^TMP("HDISDOLL",$J,"F",1)=FACILITY NAME-NUMBER^Production Y/N^NET NAME^type of lookup (single, Partial Match, ALL)^Partial Name
 ;^TMP("HDISDOLL",$J,0)= O# of orderable items
 ;^TMP("HDISDOLL",$J,O#,1)=orderable item IEN^orderable item name^mnemonic^status^inactive date
 ;^TMP("HDISDOLL",$J,O#,"S",0)= S# of synonyms
 ;^TMP("HDISDOLL",$J,O#,"S",S#)= synonym
 ;^TMP("HDISDOLL",$J,O#,"LPI",0)= LPI# of primary test items (#60) tests associated to 101.43 item
 ;^TMP("HDISDOLL",$J,O#,"LPI",LPI#,1)=IEN^name^Panel^ if error
 ;^TMP("HDISDOLL",$J,O#,"LPI",LPI#,"LTI",0)= LTI# of lab test items (#60)
 ;^TMP("HDISDOLL",$J,O#,"LPI",LPI#,"LTI",LTI,1)=IEN^name^type^data location^data physical location^status^inactive dt
 ;^TMP("HDISDOLL",$J,O#,"LPI",LPI#,"LTI",LTI,"LTS",0)= LTS# of specimens for LTI (60.01)
 ;^TMP("HDISDOLL",$J,O#,"LPI",LPI#,"LTI",LTI,"LTS",LTS,1)=IEN^name^units^inactive dt^status
 ;^TMP("HDISDOLL",$J,O#,"LPI",LPI#,"LTI",LTI,"LTS",LTS,2)=MLTF IEN^mltf name^mltf alt name^mltf inactive dt
 ;^TMP("HDISDOLL",$J,O#,"LPI",LPI#,"LTI",LTI,"LTS",LTS,3)=mltf status^mltf LOINC Code^mltf componet^mltf property
 ;^TMP("HDISDOLL",$J,O#,"LPI",LPI#,"LTI",LTI,"LTS",LTS,4)=mltf time aspect^mltf specimen^mltf scale^mltf method
 ;
 ;
EN1 ;
 N LPI,LPIEN,LPNM,LPO1,LPPN,LTI1,LTIDA,LTIDAP,LTIDT,LTIEN,LTINM,TAB,LTI,LTS,HDIORD
 N LTIST,LTITYP,LTMANM,LTMCOM,LTMDT,LTMIEN,LTMLON,LTMMET,LTMNM,LTMPRO,LTMSCA,LTMSPC
 N LTMST,LTMTIM,LTS1,LTS2,LTS3,LTS4,LTSDT,LTSIEN,LTSNM,LTSST,LTSUN,M,HDIV,HD,HD1,HD2
 N O10143,OIDT,OIEN,OIMEN,OINM,OIST,OISYN,OK,OK1,QUIT,R,D,HDIA,HDIFAC,HDIOI,HDIORD,LPPER
 S HDIV="^TMP(""HDISDOLP"",$J)" K @HDIV
 S A=1,TAB=$C(9),QUIT=""
 I HDITYPE="X" G XML
L1 S A=$O(@RET1@(A)) I 'A G L1E
 S B=$G(@RET1@(A)) I B["</Laboratory_Orderable_Items>" G L1E
 I A=2&(B["<Laboratory_Orderable_Items") S @HDIV@("T")="LABORATORY" G L1
 I B="<Facility>" S M="" G L1
 I B["<Facility_Name-Number>" S $P(M,U,1)=$$N(B) G L1
 I B["<Facility_Production_Account>" S $P(M,U,2)=$$N(B) G L1
 I B["<Facility_Net_Name>" S $P(M,U,3)=$$N(B) G L1
 I B["<Look_up_Type>" S $P(M,U,4)=$$N(B) G L1
 I B["<Look_up_Partial_Name>" S $P(M,U,5)=$$N(B) G L1
 I B["</Facility>" S @HDIV@("F",1)=M G L1
 I B="<Orderable_Item>" D  G L1
 . S C=$G(@HDIV@(0)),C=C+1,@HDIV@(0)=C,HDIORD=C,HDIOI="",OK=0,OK1=0
 . F  S A=$O(@RET1@(A)),B=$G(@RET1@(A)) Q:B["</Orderable_Item>"  D  ;<
 . . I B["<Orderable_Item_Number>" S $P(HDIOI,U,1)=$$N(B) Q
 . . I B["<Orderable_Item_Name>" S C=$$N(B),$P(HDIOI,U,2)=$$CHAR(C) Q
 . . I B["<Orderable_Item_Mnemonic>" S C=$$N(B),$P(HDIOI,U,3)=$$CHAR(C) Q
 . . I B["<Orderable_Item_Inactive_Date>" S $P(HDIOI,U,4)=$$N(B) Q
 . . I B["<Orderable_Item_Status>" S $P(HDIOI,U,5)=$$N(B),@HDIV@(HDIORD,1)=HDIOI Q
 . . I B["<Orderable_Item_Synonym>" F  S A=$O(@RET1@(A)),B=$G(@RET1@(A)) D  I OK1=1 Q
 . . . I B["<Orderable_Item_Synonym_Name>" D  Q
 . . . . S D=$G(@HDIV@(HDIORD,"S",0)),D=D+1,@HDIV@(HDIORD,"S",0)=D,C=$$N(B),@HDIV@(HDIORD,"S",D)=$$CHAR(C) Q
 . . . I B["</Orderable_Item_Synonym>" Q
 . . . I B["<Lab_Primary_Order_Item>" S A=A-1,OK1=1 Q
 . . I B="<Lab_Primary_Order_Item>" D  Q
 . . . S C=$G(@HDIV@(HDIORD,"LPI",0)),C=C+1,@HDIV@(HDIORD,"LPI",0)=C,LPI=C,(LPO1,OK,OK1)=""
 . . . F  S A=$O(@RET1@(A)),B=$G(@RET1@(A)) Q:B["</Lab_Primary_Order_Item>"  D  ;<
 . . . . I B["<Lab_Primary_Test_IEN>" S LPO1=$$N(B) Q
 . . . . I B["<Lab_Primary_Test_Name>" S R=$$N(B),$P(LPO1,U,2)=$$CHAR(R) Q
 . . . . I B["Lab_Primary_Test_Panel>" S $P(LPO1,U,3)=$$N(B),@HDIV@(HDIORD,"LPI",LPI,1)=LPO1 Q
 . . . . I B="<Laboratory_Test_Item>" S C=$G(@HDIV@(HDIORD,"LPI",LPI,"LTI",0)),C=C+1,@HDIV@(HDIORD,"LPI",LPI,"LTI",0)=C,LTI=C,LTI1="" F  S A=$O(@RET1@(A)),B=$G(@RET1@(A)) Q:B["</Laboratory_Test_Item>"  D  ;<
 . . . . . I B["<Lab_Test_IEN>" S LTI1=$$N(B) Q
 . . . . . I B["<Lab_Test_Name>" S C=$$N(B),$P(LTI1,U,2)=$$CHAR(C) Q
 . . . . . I B["<Lab_Test_Type>" S $P(LTI1,U,3)=$$N(B) Q
 . . . . . I B["<Lab_Test_Data_Location>" S $P(LTI1,U,4)=$$N(B) Q
 . . . . . I B["<Lab_Test_Data_Loc_Physical>" S $P(LTI1,U,5)=$$N(B) Q
 . . . . . I B["<Lab_Test_Inactive_Date>" S $P(LTI1,U,6)=$$N(B) Q
 . . . . . I B["<Lab_Test_Status>" S $P(LTI1,U,7)=$$N(B),@HDIV@(HDIORD,"LPI",LPI,"LTI",LTI,1)=LTI1 Q
 . . . . . I B="<Lab_Test_Specimen>" S C=$G(@HDIV@(HDIORD,"LPI",LPI,"LTI",LTI,"LTS",0)),C=C+1,@HDIV@(HDIORD,"LPI",LPI,"LTI",LTI,"LTS",0)=C,LTS=C,(LTS1,LTS2,LTS3,LTS4)="" F  S A=$O(@RET1@(A)),B=$G(@RET1@(A)) Q:B["</Lab_Test_Specimen>"  D  ;<
 . . . . . . I B["<Lab_Test_Specimen_IEN>" S LTS1=$$N(B) Q
 . . . . . . I B["<Lab_Test_Specimen_Name>" S C=$$N(B),$P(LTS1,U,2)=$$CHAR(C) Q
 . . . . . . I B["<Lab_Test_Specimen_Units>" S C=$$N(B),$P(LTS1,U,3)=$$CHAR(C) Q
 . . . . . . I B["<Lab_Test_Specimen_Inactive_Date>" S $P(LTS1,U,4)=$$N(B)
 . . . . . . I B["<Lab_Test_Specimen_Status>" S $P(LTS1,U,5)=$$N(B),@HDIV@(HDIORD,"LPI",LPI,"LTI",LTI,"LTS",LTS,1)=LTS1 Q
 . . . . . . I B="<Master_Lab_Test_Item>" Q
 . . . . . . I B="</Master_Lab_Test_Item>" Q
 . . . . . . I B["<Master_Lab_Test_IEN>" S LTS2=$$N(B) Q
 . . . . . . I B["<Master_Lab_Test_Name>" S C=$$N(B),$P(LTS2,U,2)=$$CHAR(C) Q
 . . . . . . I B["<Master_Lab_Test_Alternate_Name>" S C=$$N(B),$P(LTS2,U,3)=$$CHAR(C) Q
 . . . . . . I B["<Master_Lab_Test_Inactive_Date>" S $P(LTS2,U,4)=$$N(B),@HDIV@(HDIORD,"LPI",LPI,"LTI",LTI,"LTS",LTS,2)=LTS2 Q
 . . . . . . I B["<Master_Lab_Test_Status>" S LTS3=$$N(B) Q
 . . . . . . I B["<Master_Lab_Test_LOINC_Code>" S $P(LTS3,U,2)=$$N(B) Q
 . . . . . . I B["<Master_Lab_Test_Component>" S C=$$N(B),$P(LTS3,U,3)=$$CHAR(C) Q
 . . . . . . I B["<Master_Lab_Test_Property>" S C=$$N(B),$P(LTS3,U,4)=$$CHAR(C),@HDIV@(HDIORD,"LPI",LPI,"LTI",LTI,"LTS",LTS,3)=LTS3 Q
 . . . . . . I B["<Master_Lab_Test_Time_Aspect>" S LTS4=$$N(B) Q
 . . . . . . I B["<Master_Lab_Test_Specimen>" S C=$$N(B),$P(LTS4,U,2)=$$CHAR(C) Q
 . . . . . . I B["<Master_Lab_Test_Scale>" S C=$$N(B),$P(LTS4,U,3)=$$CHAR(C) Q
 . . . . . . I B["<Master_Lab_Test_Method>" S C=$$N(B),$P(LTS4,U,4)=$$CHAR(C),@HDIV@(HDIORD,"LPI",LPI,"LTI",LTI,"LTS",LTS,4)=LTS4 Q
 ;
L1E ; end of flip from XML
 ;
 ;
 I HDITYPE="R" G REPORT
 G EXPORT
 Q
 ;
REPORT ;
 ; basic repeats
 S HDIFAC=$G(@HDIV@("F",1)),HDIA=$G(@HDIV@("T")),QUIT="",PAGE=1
 S HD="HDI Orderable Items SDO List For: "_HDIA
 s HD1=$P(HDIFAC,U,1)_"  "_($S($P(HDIFAC,U,2)="NO":"NOT-",1:""))_"PRODUCTION"
 S HD2="Type of Lookup: "_$P(HDIFAC,U,4)
 I $P(HDIFAC,U,4)="PARTIAL" S HD2=HD2_"   Partial Name: "_$P(HDIFAC,U,5)
 S XDD=^DD("DD"),ULINE="",$P(ULINE,"_",79)="_"
 U IO
 S O10143=0,QUIT=""
R1 D GETORD I 'O10143 G PDONE
 D RHEAD,RORD S LPI=0
R2 D GETLPI I 'LPI D PAUSE G PDONE:QUIT,R1
 D RLPI I QUIT G PDONE
 I LPPER G R1
 S LTI=0
R3 D GETLTI I 'LTI G R2
 D RLTI I QUIT G PDONE
 S LTS=0
R4 D GETLTS I 'LTS G R3
 D RLTS1 I QUIT G PDONE
 D RLTS2 I QUIT G PDONE
 G R4
 ;
RCHKC I HDICRT,($Y>(IOSL-4)) D  I QUIT Q
 .D PAUSE
 .Q:QUIT
 .;W @IOF
 .W !
 .I HDITYPE'="X" D RHEAD
 E  I ('HDICRT),($Y>(IOSL-2)) D
 .W @IOF
 .I HDITYPE'="X" D RHEAD
 ;
 Q
 ;
PAUSE N DIR,DIRUT,X,Y
 ;F  Q:$Y>(IOSL-3)  W !
 I 'HDICRT Q
 ; W !
 S DIR(0)="E" D ^DIR
 I ('(+Y))!$D(DIRUT) S QUIT=1
 I 'QUIT S $Y=0
 Q
 ;
DONE ; final quit point
 K @HDIV,@RET1,RET1
 K LPI,LPIEN,LPNM,LPO1,LPPN,LTI1,LTIDA,LTIDAP,LTIDT,LTIEN,LTINM,TAB,LTI,LTS,HDIORD
 K LTIST,LTITYP,LTMANM,LTMCOM,LTMDT,LTMIEN,LTMLON,LTMMET,LTMNM,LTMPRO,LTMSCA,LTMSPC
 K LTMST,LTMTIM,LTS1,LTS2,LTS3,LTS4,LTSDT,LTSIEN,LTSNM,LTSST,LTSUN,M,HDIV,HD,HD1,HD2
 K O10143,OIDT,OIEN,OIMEN,OINM,OIST,OISYN,OK,OK1,QUIT,R,D,HDIA,HDIFAC,HDIOI,HDIORD,LPPER
 Q
 ;
PLE ;
PDONE ; print done
 I 'HDICRT D ^%ZISC
 U IO W !!,?29,$S(QUIT'=1:"--- Report Finished ---",1:"--- Report Aborted ---")
 G DONE
 Q
 ;
 ;
RHEAD ;Description: Prints the report header.
 Q:QUIT
 N LINE
 I $Y>1 W @IOF
 W !,?(40-($L(HD)\2)),HD
 W !,?(40-($L(HD1)\2)),HD1
 W !,?(40-($L(HD2)\2)),HD2
 W !,?27,"Date Printed: "_$$FMTE^XLFDT(DT),?70,"Page ",PAGE
 S PAGE=PAGE+1
 ;
 W !,ULINE
 Q
 ;
RORD ; print order info
 D RCHKC Q:QUIT
 W !,"Orderable Item Name: ",OINM
 D RCHKC Q:QUIT
 W !,"  IEN: ",OIEN,?15,"Mnemonic: ",$S(($E(OIMEN)="Y"):"Yes",1:"No"),?29,"Inactive Date: ",OIDT
 D RCHKC Q:QUIT
 W ?63,"Status: ",$S(OIST=1:"Inactive",1:"  Active")
 D RCHKC Q:QUIT
 W !,"  Synonyms: "
 S A=12,B=0,C="" F  S B=$O(OISYN(B)) Q:'B  S C=$G(OISYN(B)) D:(A+($L(C)+1)>78) RCHKC Q:QUIT  W:(A+($L(C)+1)>78) !,"  " W C W:(B'=OISYN(0)) ", " S A=$S((A+($L(C)+2)>78):2,1:A)+($L(C)+2)
 D RCHKC Q:QUIT
 W !,ULINE
 Q
 ;
RLPI ; print lab primary info
 D RCHKC Q:QUIT
 I LPPER D  Q
 . W !,"Laboratory Primary Item for Orderable Item: ",$E(LPNM,1,33),"..."
 . D RCHKC Q:QUIT
 . W !,"With IEN of: ",LTIEN,"  Not Found in Laboratory Test File"
 W !,"Laboratory Primary Item: ",LPNM,?70,"IEN: ",$E("     ",1,(5-$L(LPIEN))),LPIEN
 D RCHKC Q:QUIT
 W !,"  Panel: ",LPPN
 Q
 ;
RLTI ; print lab test
 D RCHKC Q:QUIT
 W !,"Laboratory Test: ",LTINM,?70,"IEN: ",$E("     ",1,(5-$L(LTIEN))),LTIEN
 D RCHKC Q:QUIT
 W !,"  Type: ",$P(LTITYP," ",1),?17,"Data Location: ",LTIDA,?46,"Data Loc Physical: ",LTIDAP
 D RCHKC Q:QUIT
 W !,"  Inactive Date: ",LTIDT,?61,"Status: " I LTIEN&(LTINM'="") W $S(($E(LTIST)=1):"Inactive",1:"  Active")
 Q
 ;
RLTS1 ; print specimen info
 D RCHKC Q:QUIT
 W !,"Specimen: ",LTSNM,?70,"IEN: ",$E("     ",1,(5-$L(LTSIEN))),LTSIEN
 D RCHKC I QUIT Q
 W !,"  Units: ",LTSUN,?22,"Inactive Date: ",LTSDT,?61,"Status: " I LTSIEN&(LTSNM'="") W $S(($E(LTSST)=1):"Inactive",1:"  Active")
 Q
 ;
RLTS2 ; print initial mltf info
 D RCHKC Q:QUIT
 I LTMNM="" D  Q
 . W !,"Master Lab Test Name: SPECIMEN NOT ASSOCIATED TO MASTER LABORATORY TEST File"
 W !,"Master Lab Test Name: "
 D DISPL(LTMNM,53,71) I QUIT Q
 ;
 D RCHKC Q:QUIT
 W !,"  IEN: ",LTMIEN,?18,"Inactive DT: ",LTMDT,?61,"Status: " I LTMIEN&(LTMNM'="") W $S(($E(LTMST)=1):"Inactive",1:"  Active")
 ;
 D RCHKC Q:QUIT
 W !,"  Alternate Name: "
 D DISPL(LTMANM,56,71) I QUIT Q
 ;
 D RCHKC Q:QUIT
 W !,"  LOINC Code: ",LTMLON
 ;
 D RCHKC Q:QUIT
 W !,"  Component: "
 D DISPL(LTMCOM,63,71) I QUIT Q
 ;
 D RCHKC Q:QUIT
 W !,"  Property: "
 D DISPL(LTMPRO,63,71) I QUIT Q
 ;
 D RCHKC Q:QUIT
 W !,"  Time Aspect: "
 D DISPL(LTMTIM,61,71) I QUIT Q
 ;
 W !,"  Specimen: "
 D DISPL(LTMSPC,63,71) I QUIT Q
 ;
 D RCHKC Q:QUIT
 W !,"  Scale: "
 D DISPL(LTMSCA,66,71) I QUIT Q
 ;
 D RCHKC Q:QUIT
 W !,"  Method: "
 D DISPL(LTMTIM,65,71) I QUIT Q
 Q
 ;
EXPORT ; output as export file
 ; basic repeats
 S HDIFAC=$G(@HDIV@("F",1)),HDIA=$G(@HDIV@("T"))
 ; walk collection
 S O10143=0 D EHEAD
E1 D GETORD I 'O10143 G EOUT
 S LPI=0
E2 D GETLPI I 'LPI G E1
 S LTI=0
E3 D GETLTI I 'LTI G E2
 S LTS=0
E4 D GETLTS I 'LTS G E3
 ; output data
 U IO W $P(HDIFAC,U,1),TAB,$P(HDIFAC,U,2),TAB,$P(HDIFAC,U,3),TAB,HDIA,TAB,$P(HDIFAC,U,4),TAB,$P(HDIFAC,U,5),TAB
 W OIEN,TAB,OINM,TAB,($S(($E(OIMEN)="Y"):"Yes",1:"No")),TAB,OIDT,TAB,($S(OIST=1:"Inactive",1:"Active")),TAB
 ; get synonyms
 S A=0 F I=1:1 S A=$O(OISYN(A)) Q:'A  S B=$G(OISYN(A)) W B W:(I'=$G(OISYN(0))) ", "
 S A="" I LTIEN&(LTINM'="") S A=$S(LTIST=1:"Inactive",1:"Active")
 W TAB,LPIEN,TAB,LPNM,TAB,LPPN,TAB,LTIEN,TAB,LTINM,TAB,LTITYP,TAB,LTIDA,TAB,LTIDAP,TAB,LTIDT,TAB,A,TAB
 S A="" I LTSIEN&(LTSNM'="") S A=$S(LTSST=1:"Inactive",1:"Active")
 W LTSIEN,TAB,LTSNM,TAB,LTSUN,TAB,LTSDT,TAB,A,TAB,LTMIEN,TAB,LTMNM,TAB,LTMANM,TAB,LTMDT,TAB
 S A="" I LTMIEN&(LTMNM'="") S A=$S(LTMST=1:"Inactive",1:"Active")
 W A,TAB,LTMLON,TAB,LTMCOM,TAB,LTMPRO,TAB,LTMTIM,TAB,LTMSPC,TAB,LTMSCA,TAB,LTMMET
 W !
 G E4
 ;
EOUT ;
 I 'HDICRT D ^%ZISC
 G DONE
 Q
 ;
EHEAD ; export header
 U IO W "Facility_Name-Number",TAB,"Production_Account",TAB,"Net_Name",TAB,"Area",TAB,"Type_of_Lookup",TAB
 W "Partial_Name",TAB,"Orderable_Item_IEN",TAB
 W "Orderable_Item_Name",TAB,"Orderable_Item_Mnemonic",TAB,"Orderable_Item_Inactive_Date",TAB,"Orderable_Item_Status",TAB
 W "Orderable_Item_Synonyms",TAB,"Lab_Primary_Test_IEN",TAB,"Lab_Primary_Test_Name",TAB,"Lab_Primary_Test_Panel",TAB
 W "Lab_Test_IEN",TAB,"Lab_Test_Name",TAB,"Lab_Test_Type",TAB,"Lab_Test_Data_Location",TAB,"Lab_Test_Data_Loc_Physical",TAB
 W "Lab_Test_Inactive_Date",TAB,"Lab_Test_Status",TAB,"Lab_Test_Specimen_IEN",TAB,"Lab_Test_Specimen_Name",TAB
 W "Lab_Test_Specimen_Units",TAB,"Lab_Test_Specimen_Inactive_Date",TAB,"Lab_Test_Specimen_Status",TAB
 W "Master_Lab_Test_IEN",TAB,"Master_Lab_Test_Name",TAB,"Master_Lab_Test_Alternate_Name",TAB,"Master_Lab_Test_Inactive_Date",TAB
 W "Master_Lab_Test_Status",TAB,"Master_Lab_Test_LOINC_Code",TAB,"Master_Lab_Test_Component",TAB
 W "Master_Lab_Test_Property",TAB,"Master_Lab_Test_Time_Aspect",TAB,"Master_Lab_Test_Specimen",TAB
 W "Master_Lab_Test_Scale",TAB,"Master_Lab_Test_Method"
 W !
 Q
 ;
GETORD S (OIEN,OINM,OIMEN,OIDT,OIST)=""
 S O10143=$O(@HDIV@(O10143)) I 'O10143 Q
 S B=$G(@HDIV@(O10143,1)),OIEN=$P(B,U,1),OINM=$P(B,U,2),OIMEN=$P(B,U,3),OIDT=$P(B,U,4),OIST=$P(B,U,5)
 K OISYN M OISYN=@HDIV@(O10143,"S")
 Q
 ;
GETLPI ; get primary lab item
 S (LPIEN,LPNM,LPPN,LPPER)=""
 N C
 S LPI=$O(@HDIV@(O10143,"LPI",LPI)) I 'LPI Q
 S B=$G(@HDIV@(O10143,"LPI",LPI,1)),LPIEN=$P(B,U,1),LPNM=$P(B,U,2),LPPN=$P(B,U,3)
 I $P(B,U,4)'="" S C=$P(B,U,4),LPIEN=$P(C,":",1),LPNM=$P(C,":",2),LPPER=1
 Q
 ;
GETLTI ; get lab test item
 S (LTIEN,LTINM,LTITYP,LTIDA,LTIDAP,LTIDT,LTIST)=""
 S LTI=$O(@HDIV@(O10143,"LPI",LPI,"LTI",LTI)) I 'LTI Q
 S B=$G(@HDIV@(O10143,"LPI",LPI,"LTI",LTI,1)),LTIEN=$P(B,U,1),LTINM=$P(B,U,2),LTITYP=$P(B,U,3)
 S LTIDA=$P(B,U,4),LTIDAP=$P(B,U,5),LTIDT=$P(B,U,6),LTIST=$P(B,U,7)
 Q
 ;
GETLTS ; get lab specimen and mltf item
 S (LTSIEN,LTSNM,LTSUN,LTSDT,LTSST,LTMIEN,LTMNM,LTMANM,LTMST,LTMLON,LTMCOM,LTMPRO,LTMTIM,LTMSPC,LTMSCA,LTMMET)=""
 S LTS=$O(@HDIV@(O10143,"LPI",LPI,"LTI",LTI,"LTS",LTS)) I 'LTS Q
 S B=$G(@HDIV@(O10143,"LPI",LPI,"LTI",LTI,"LTS",LTS,1)),LTSIEN=$P(B,U,1),LTSNM=$P(B,U,2),LTSUN=$P(B,U,3)
 S LTSDT=$P(B,U,4),LTSST=$P(B,U,5)
 S B=$G(@HDIV@(O10143,"LPI",LPI,"LTI",LTI,"LTS",LTS,2)),LTMIEN=$P(B,U,1),LTMNM=$P(B,U,2),LTMANM=$P(B,U,3)
 S LTMDT=$P(B,U,4)
 S B=$G(@HDIV@(O10143,"LPI",LPI,"LTI",LTI,"LTS",LTS,3)),LTMST=$P(B,U,1),LTMLON=$P(B,U,2),LTMCOM=$P(B,U,3),LTMPRO=$P(B,U,4)
 S B=$G(@HDIV@(O10143,"LPI",LPI,"LTI",LTI,"LTS",LTS,4)),LTMTIM=$P(B,U,1),LTMSPC=$P(B,U,2),LTMSCA=$P(B,U,3),LTMMET=$P(B,U,4)
 Q
 ;
CHAR(A) ; check for ctrl chars, <, >, &
 N B,C,D,I,L,M,N
 I A="" Q A
 S D=A
 I A["'AND'" D  ;<
 . S B=$F(A,"'AND'")
 . S A=$E(A,1,(B-6))_"&"_$E(A,B,$L(A))
 I A["'LESS THAN'" D  ;<
 . S B=$F(A,"'LESS THAN'")
 . S A=$E(A,1,(B-12))_"<"_$E(A,B,$L(A))
 I A["'GREATER THAN'" D  ;<
 . S B=$F(A,"'GREATER THAN'")
 . S A=$E(A,1,(B-15))_">"_$E(A,B,$L(A))
 I A["'FORWARD SLASH'" D  ;<
 . S B=$F(A,"'FORWARD SLASH'")
 . S A=$E(A,1,(B-16))_"/"_$E(A,B,$L(A))
 Q A
 ;
N(K) ;get value
 N F
 S F=$P($P(K,"<",2),">",2)
 Q F
 ;
XML ; entry if output is XML
 U IO
 N A,B,C S A=0
 F  S A=$O(@RET1@(A)) Q:'A  W $G(@RET1@(A)),! ; D RCHKC I QUIT Q
 K A,B,C
 ;G PDONE
 I 'HDICRT D ^%ZISC
 Q
 ;
DISPL(S,F,E) ; display lines
 N A,D
 I S="" Q
 I $L(S)<F W S G DISPL1
 S D=F F  Q:S=""  S A="" D  I QUIT Q  ;<
 . S A=$E(S,1,D),S=$E(S,(D+1),$L(S)),D=E
 . W A I S'="" W " <"
 . D RCHKC
 . Q:QUIT
 . I S'="" W !,"  > "
DISPL1 ;
 I QUIT Q
 D RCHKC Q:QUIT
 ;

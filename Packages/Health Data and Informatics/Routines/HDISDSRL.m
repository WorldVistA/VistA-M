HDISDSRL ;BPFO/DTG - HDI MAILMAN SERVER COLLECT ITEMS FOR LABORATORY; Apr 07, 2018@12:42
 ;;1.0;HEALTH DATA & INFORMATICS;**22**;Feb 22, 2005;Build 26
 ;
 ;
 ; ICR's:
 ; 6894 - HDI COLLECT SDOS
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
 ;^TMP("HDISDOLL",$J,O#,"LPI",LPI#,1)=IEN^name^Panel
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
 N O10143,OIDT,OIEN,OIMEN,OINM,OIST,OISYN,OK,OK1,QUIT,R,D,HDIA,HDIFAC,HDIOI,HDIORD
 N RET1,RERROR,RERRARY
 N HDFILEN1,HDFILENM,HDIFER,HDIFILN,LT,HDISUBJ,RCOUNT
 S HDIV="^TMP(""HDISDOLP"",$J)",RET1="^TMP(""HDISDSRP"",$J)",RCOUNT="",RERROR="",RERRARY="" K @HDIV,@RET1
 S RERROR=$$EN^HDISDOC("L","ALL","ALL",.RET1,"RERRARY","RCOUNT")
 S A=1,TAB=$C(9),QUIT="",LT=0
 ;
L1 S A=$O(@RET1@(A)) I 'A G L1E
 S B=$G(@RET1@(A)) I B["</Laboratory_Orderable_Items>" G L1E
 I A=2&(B["<Laboratory_Orderable_Items") S @HDIV@("T")="LABORATORY" G L1
 I B="<Facility>" S M="" G L1
 I B["<Facility_Name-Number>" S $P(M,U,1)=$$N(B) G L1
 I B["<Facility_Production_Account>" S $P(M,U,2)=$$N(B) G L1
 I B["<Facility_Net_Name>" S $P(M,U,3)=$$N(B) G L1
 I B["<Look_up_Type>" S $P(M,U,4)=$$N(B) G L1
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
 . . . . . ;S C=$G(@HDIV@(HDIORD,"LPI",LPI,"LTI",0)),C=C+1,@HDIV@(HDIORD,"LPI",LPI,"LTI",0)=C,LTI=C,LTI1=""
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
 D INIT^HDISDSR1
 ;HDISV                HPM
 ;^TMP($J,"HDIDATA"),^TMP($J,"LR60")
 S A="Report Generated.......: "_$$FMTE^XLFDT($$NOW^XLFDT)_" at "_HDISTN
 S LT=LT+$L(A),@HDISV@(1)=A
 S A="Report requested.......: "_HDISUB
 S LT=LT+$L(A),@HDISV@(2)=A
 S A="Extract version........: 1.0"
 S LT=LT+$L(A),@HDISV@(3)=A
 S A="Orderable Items File Count: "_$J($P(RCOUNT,U,2),6)
 S LT=LT+$L(A),@HDISV@(4)=A
 S A="Number of Orderable Items File That Are Inactive: "_$J($P(RCOUNT,U,3),6)
 S LT=LT+$L(A),@HDISV@(5)=A
 ;S A="Number of Orderable Items Mnemonics: "_$J($P(RCOUNT,U,4),6)
 ;S LT=LT+$L(A),@HDISV@(6)=A
 S A="Number of Primary Lab Tests Count: "_$J($P(RCOUNT,U,5),6)
 S LT=LT+$L(A),@HDISV@(6)=A
 S A="Number of Primary Tests that are Panels: "_$J($P(RCOUNT,U,6),6)
 S LT=LT+$L(A),@HDISV@(7)=A
 S A="Number of  Laboratory Tests: "_$J($P(RCOUNT,U,7),6)
 S LT=LT+$L(A),@HDISV@(8)=A
 S A="Number of Unique Laboratory Tests: "_$J($P(RCOUNT,U,13),6)
 S LT=LT+$L(A),@HDISV@(9)=A
 S A="Number of Inactive Laboratory Tests: "_$J($P(RCOUNT,U,8),6)
 S LT=LT+$L(A),@HDISV@(10)=A
 S A="Number of Specimens: "_$J($P(RCOUNT,U,9),6)
 S LT=LT+$L(A),@HDISV@(11)=A
 S A="Number of  Inactive Specimens: "_$J($P(RCOUNT,U,10),6)
 S LT=LT+$L(A),@HDISV@(12)=A
 S A="Number of Master Laboratory Tests: "_$J($P(RCOUNT,U,11),6)
 S LT=LT+$L(A),@HDISV@(13)=A
 S A="Number of Unique Master Laboratory Tests: "_$J($P(RCOUNT,U,14),6)
 S LT=LT+$L(A),@HDISV@(14)=A
 S A="Number of  Inactive Master Laboratory Tests: "_$J($P(RCOUNT,U,12),6)
 S LT=LT+$L(A),@HDISV@(15)=A
 S HDFILEN1=$TR(HDISTN," ","_")_"-"_HDISUB_"-"_$P($$FMTHL7^XLFDT($$NOW^XLFDT),"-")
 S HDIFER=$TR(HDISTN," ","_")_"-"_HDISUB_"-ERRORS-"_$P($$FMTHL7^XLFDT($$NOW^XLFDT),"-")_".TXT"
 S HDIFILN=1
 S HDFILENM=HDFILEN1_"_"_HDIFILN_".TXT"
 S A="Attached HDI SDO file.....: "_HDFILENM
 S LT=LT+$L(A)
 S @HDISV@(16)=$$REPEAT^XLFSTR("-",75),LT=LT+75
 S HDINODE=$O(@HDISV@(""),-1),HDINODE=HDINODE+1
 S @HDISV@(HDINODE)=" ",HDINODE=HDINODE+1
 S @HDISV@(HDINODE)=A_$J("       ",6),HDINODE=HDINODE+1
 I RERROR D
 . S @HDISV@(HDINODE)="Attached HDI SDO "_HDISUB_" Errors...: "_HDIFER
 . S HDINODE=HDINODE+1
 S @HDISV@(HDINODE)=" ",HDINODE=HDINODE+1
 I RERROR D DISER^HDISDSR1
 S HDINODE=$O(@HDISV@(""),-1),HDINODE=HDINODE+1
 S @HDISV@(HDINODE)=" ",HDINODE=HDINODE+1
 S @HDISV@(HDINODE)=$$UUBEGFN^HDISDSR1(HDFILENM)
 ;
 D EHEAD
 ;
 G EXPORT
 Q
 ;
DONE ; final quit point
 S HDISUBJ=HDIST_" "_HDISTN_" COMPLETED LAB ORDERABLE ITEMS SDO CODES "_$$HTE^XLFDT($H,"1M")
 D MAILSEND^HDISDSR1(HDISUBJ)
 D CLEAN^HDISDSR1
 K @HDIV,@RET1,RET1
 K LPI,LPIEN,LPNM,LPO1,LPPN,LTI1,LTIDA,LTIDAP,LTIDT,LTIEN,LTINM,TAB,LTI,LTS,HDIORD
 K LTIST,LTITYP,LTMANM,LTMCOM,LTMDT,LTMIEN,LTMLON,LTMMET,LTMNM,LTMPRO,LTMSCA,LTMSPC
 K LTMST,LTMTIM,LTS1,LTS2,LTS3,LTS4,LTSDT,LTSIEN,LTSNM,LTSST,LTSUN,M,HDIV,HD,HD1,HD2
 K O10143,OIDT,OIEN,OIMEN,OINM,OIST,OISYN,OK,OK1,QUIT,R,D,HDIA,HDIFAC,HDIOI,HDIORD
 K HDFILEN1,HDFILENM,HDIFER,HDIFILN,LT,HDISUBJ,RCOUNT
 Q
 ;
EXPORT ; output as export file
 ; basic repeats
 S HDIFAC=$G(@HDIV@("F",1)),HDIA=$G(@HDIV@("T"))
 ; walk collection
 S O10143=0,(OIEN,OINM,OIMEN,OIDT,OIST)=""
E1 D GETORD I 'O10143 G EOUT
 S LPI=0,(LPIEN,LPNM,LPPN)=""
E2 D GETLPI I 'LPI G E1
 S LTI=0,(LTIEN,LTINM,LTITYP,LTIDA,LTIDAP,LTIDT,LTIST)=""
E3 D GETLTI I 'LTI G E2
 S LTS=0,(LTSIEN,LTSNM,LTSUN,LTSDT,LTSST,LTMIEN,LTMNM,LTMANM,LTMST,LTMLON,LTMCOM,LTMPRO,LTMTIM,LTMSPC,LTMSCA,LTMMET)=""
E4 D GETLTS I 'LTS G E3
 ; output data
 S HDISTR=HDISTR_$P(HDIFAC,U,1)_TAB_$P(HDIFAC,U,2)_TAB_$P(HDIFAC,U,3)_TAB_HDIA_TAB_$P(HDIFAC,U,4)_TAB
 D SETDATA
 S HDISTR=HDISTR_OIEN_TAB_OINM_TAB_($S(($E(OIMEN)="Y"):"Yes",1:""))_TAB_OIDT_TAB_($S(OIST=1:"Inactive",1:"Active"))_TAB
 D SETDATA
 ; get synonyms
 S A=0 F I=1:1 S A=$O(OISYN(A)) Q:'A  S B=$G(OISYN(A)) S HDISTR=HDISTR_B S:(A'=OISYN(0)) HDISTR=HDISTR_", " I $L(HDISTR)>100 D SETDATA
 I $L(HDISTR)>55 D SETDATA
 S A="" I LTIEN&(LTINM'="") S A=$S(LTIST=1:"Inactive",1:"Active")
 S HDISTR=HDISTR_TAB_LPIEN_TAB_LPNM_TAB_LPPN_TAB_LTIEN_TAB_LTINM_TAB_LTITYP_TAB_LTIDA_TAB_LTIDAP_TAB_LTIDT_TAB_A_TAB
 D SETDATA
 S A="" I LTSIEN&(LTSNM'="") S A=$S(LTSST=1:"Inactive",1:"Active")
 S HDISTR=HDISTR_LTSIEN_TAB_LTSNM_TAB_LTSUN_TAB_LTSDT_TAB_A_TAB_LTMIEN_TAB_LTMNM_TAB_LTMANM_TAB_LTMDT_TAB
 D SETDATA
 S A="" I LTMIEN&(LTMNM'="") S A=$S(LTMST=1:"Inactive",1:"Active")
 S HDISTR=HDISTR_A_TAB_LTMLON_TAB_LTMCOM_TAB_LTMPRO_TAB_LTMTIM_TAB_LTMSPC_TAB_LTMSCA_TAB_LTMMET
 S HDISTR=HDISTR_HDICRLF
 D SETDATA
 I LT>HDIMAX D PSEND
 G E4
 ;
EOUT ;
 S HDINODE=$O(@HDISV@(""),-1)
 I HDISTR'="" S HDINODE=HDINODE+1,@HDISV@(HDINODE)=$$UUEN^HDISDSR1(HDISTR)
 S @HDISV@(HDINODE+1)=" "
 S @HDISV@(HDINODE+2)="end"
 G DONE
 ;
 ;
EHEAD ; export header
 S HDISTR="Facility_Name-Number"_TAB_"Production_Account"_TAB_"Net_Name"_TAB_"Area"_TAB_"Type_of_Lookup"_TAB_"Orderable_Item_IEN"_TAB
 D SETDATA
 S HDISTR=HDISTR_"Orderable_Item_Name"_TAB_"Orderable_Item_Mnemonic"_TAB_"Orderable_Item_Inactive_Date"_TAB_"Orderable_Item_Status"_TAB
 D SETDATA
 S HDISTR=HDISTR_"Orderable_Item_Synonyms"_TAB_"Lab_Primary_Test_IEN"_TAB_"Lab_Primary_Test_Name"_TAB_"Lab_Primary_Test_Panel"_TAB
 D SETDATA
 S HDISTR=HDISTR_"Lab_Test_IEN"_TAB_"Lab_Test_Name"_TAB_"Lab_Test_Type"_TAB_"Lab_Test_Data_Location"_TAB_"Lab_Test_Data_Loc_Physical"_TAB
 D SETDATA
 S HDISTR=HDISTR_"Lab_Test_Inactive_Date"_TAB_"Lab_Test_Status"_TAB_"Lab_Test_Specimen_IEN"_TAB_"Lab_Test_Specimen_Name"_TAB
 D SETDATA
 S HDISTR=HDISTR_"Lab_Test_Specimen_Units"_TAB_"Lab_Test_Specimen_Inactive_Date"_TAB_"Lab_Test_Specimen_Status"_TAB
 D SETDATA
 S HDISTR=HDISTR_"Master_Lab_Test_IEN"_TAB_"Master_Lab_Test_Name"_TAB_"Master_Lab_Test_Alternate_Name"_TAB_"Master_Lab_Test_Inactive_Date"_TAB
 D SETDATA
 S HDISTR=HDISTR_"Master_Lab_Test_Status"_TAB_"Master_Lab_Test_LOINC_Code"_TAB_"Master_Lab_Test_Component"_TAB
 D SETDATA
 S HDISTR=HDISTR_"Master_Lab_Test_Property"_TAB_"Master_Lab_Test_Time_Aspect"_TAB_"Master_Lab_Test_Specimen"_TAB
 D SETDATA
 S HDISTR=HDISTR_"Master_Lab_Test_Scale"_TAB_"Master_Lab_Test_Method"_HDICRLF
 D SETDATA
 Q
 ;
GETORD S O10143=$O(@HDIV@(O10143)) I 'O10143 Q
 S B=$G(@HDIV@(O10143,1)),OIEN=$P(B,U,1),OINM=$P(B,U,2),OIMEN=$P(B,U,3),OIDT=$P(B,U,4),OIST=$P(B,U,5)
 K OISYN M OISYN=@HDIV@(O10143,"S")
 Q
 ;
GETLPI ; get primary lab item
 S LPI=$O(@HDIV@(O10143,"LPI",LPI)) I 'LPI Q
 S B=$G(@HDIV@(O10143,"LPI",LPI,1)),LPIEN=$P(B,U,1),LPNM=$P(B,U,2),LPPN=$P(B,U,3)
 Q
 ;
GETLTI ; get lab test item
 S LTI=$O(@HDIV@(O10143,"LPI",LPI,"LTI",LTI)) I 'LTI Q
 S B=$G(@HDIV@(O10143,"LPI",LPI,"LTI",LTI,1)),LTIEN=$P(B,U,1),LTINM=$P(B,U,2),LTITYP=$P(B,U,3)
 S LTIDA=$P(B,U,4),LTIDAP=$P(B,U,5),LTIDT=$P(B,U,6),LTIST=$P(B,U,7)
 Q
 ;
GETLTS ; get lab specimen and mltf item
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
SETDATA ; Set data into report structure
 S HDINODE=$O(@HDISV@(""),-1)
 D ENCODE^HDISDSR1(.HDISTR)
 Q
 ;
PSEND ; SEND IF FILE TO BIG
 S HDINODE=$O(@HDISV@(""),-1)
 I HDISTR'="" S HDINODE=HDINODE+1,@HDISV@(HDINODE)=$$UUEN^HDISDSR1(HDISTR)
 S @HDISV@(HDINODE+1)=" "
 S @HDISV@(HDINODE+2)="end"
 S HDISTR=""
 ;
 S HDISUBJ=HDIST_" "_HDISTN_$S(HDIFILN>1:" CONTINUATION OF",1:"")_" LAB ORDERABLE ITEMS SDO CODES "_$$HTE^XLFDT($H,"1M")
 D MAILSEND^HDISDSR1(HDISUBJ)
 ;
 S HDIFILN=HDIFILN+1,LT=0
 K @HDISV
 S A="This is a continuation of: "_HDFILENM_$J("       ",6),LT=$L(A)
 S @HDISV@(1)=A
 S A=" ",LT=LT+1,@HDISV@(2)=A
 S A=" This file does not contain a header, only data"_$J("       ",6),LT=LT+$L(A)
 S @HDISV@(3)=A
 S A=" This file should be combined with the previous file(s)"_$J("       ",6),LT=LT+$L(A)
 S @HDISV@(4)=A
 S @HDISV@(5)=" "
 S HDFILENM=HDFILEN1_"_"_HDIFILN_".TXT"
 S @HDISV@(6)="Attached HDI SDO file.....: "_HDFILENM
 S @HDISV@(7)=$$REPEAT^XLFSTR("-",75),LT=LT+75
 S HDINODE=$O(@HDISV@(""),-1),HDINODE=HDINODE+1
 S @HDISV@(HDINODE)=" ",HDINODE=HDINODE+1
 S @HDISV@(HDINODE)=$$UUBEGFN^HDISDSR1(HDFILENM)
 Q
 ;

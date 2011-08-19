PRC5B ;WISC/PLT-IFCAP post install routine defined in package file ; 03/14/95  11:45 AM
V ;;5.0;IFCAP;**27**;4/21/95
 ;
 ;invoke by the post initial installation field of package file.
EN ;called from routine prcinit
 D EN^DDIOL("IFCAP POST-INITIALIZATION STARTS at "_$$NOW^PRC5A)
 D:PRCIVER<5
 . D ^PRCOSRV8 ;update 423.5, .01 field with 'FMS-'
 . D ALD^PRC5B1 ;move name to ald field for file 420.3
 . D CC^PRC5B3 ;deactivate subcost centers
 D EN^DDIOL("IFCAP POST-INITIALIZATION ENDS at "_$$NOW^PRC5A)
 QUIT
 ;
EN2 ;called from ifcap v5 installation 'PRC5PKG' option '2'
 D EN^DDIOL("IFCAP V5 INSTALLATION 'Option 2' STARTS at "_$$NOW^PRC5A)
 D:PRCIVER<5
 . D FND^PRC5B1 ;convert fms FND document (add fund code in file 420.3)
 . D PCL^PRC5B1 ;convert fms PCL document (set-up program dic)
 . D PAC^PRC5B1 ;convert fms ACC document (set-up fcp/prj dic)
 D:PRCIVER<5&PRCIVER
 . D CPF^PRC5B1 ;convert fms CPF document
 . D EN2^PRC5B6 ;converting posted current qtr IB txn in file 410
 . N L,DIC,FLDS,BY,FR,TO,DHD
 . D EN^DDIOL("Print FCP ACCOUNTING ELEMENTS LIST")
 . S L=0,DIC=420,FLDS="[PRCB CPF ACC ELEMENT]" D EN1^DIP
 . D EN^DDIOL("Ask Fiscal Service to check the FCP ACCOUNTING ELEMENTS LIST for each Fund Control Point with the Cross-walk Table.")
 .D EN^DDIOL("Your Accounting Elements should match your Cross-walk Table.")
 . D EN^DDIOL("Note: You can not run Option 3 or 4 if your site has an active SUPPLY FUND Control Point but the FCP Accounting Elements are missing or incorrect.")
 . D EN^DDIOL("You also can not run Option 3 or 4 if you have an active GPF Control Point and your FCP Accounting Elements List does not show a 'GPF FMS CONVERSION' Fund Control Point.")
 . I $$SPFCP^PRC5B7]"" QUIT
 . QUIT
 S PRCRI(420.92)=$O(^PRCU(420.92,"B",PRCFIXV,"")) D:PRCRI(420.92)
 . D EDIT^PRC0B(.X,"420.92;^PRCU(420.92,;"_PRCRI(420.92),"2.7///^S X=""N""","LS")
 D EN^DDIOL("IFCAP V5 INSTALLATION 'Option 2' ENDS at "_$$NOW^PRC5A)
 QUIT
 ;
EN3 ;called from ifcap v5 installation 'PRC5PKG' option '3'
 I $$SPFCP^PRC5B7]"" QUIT
 D EN^DDIOL("IFCAP V5 INSTALLATION 'Option 3' STARTS at "_$$NOW^PRC5A)
 S PRCRI(420.92)=$O(^PRCU(420.92,"B",PRCFIXV,"")) D:PRCRI(420.92)
 . D EDIT^PRC0B(.X,"420.92;^PRCU(420.92,;"_PRCRI(420.92),"2///^S X=""N"";2.5///^S X=""@""","LS")
 . QUIT
 D ^PRCFOOR1 ;recalculate all FCP and snap shot fcp balance
 D FCPFY^PRC5B7 ;delete all fcp fiscal yearly account elements
 D CEIL96^PRC5B7 ;reset 1-4 qtr code sheet  generated flags in file 421
 S PRCRI(420.92)=$O(^PRCU(420.92,"B",PRCFIXV,"")) D:PRCRI(420.92)
 . D EDIT^PRC0B(.X,"420.92;^PRCU(420.92,;"_PRCRI(420.92),"2.5///^S X=""N""","LS")
 . QUIT
 D
 . N L,DIC,FLDS,BY,FR,TO,DHD
 . D EN^DDIOL("Print SNAP SHOT FCP BALANCE")
 . S L=0,DIC=420.99,FLDS=".01,1;""DATE"",2.5;""QTR"",2;""FCP BAL"",9" D EN1^DIP
 . QUIT
 D EN^DDIOL("IFCAP V5 INSTALLATION 'Option 3' ENDS at "_$$NOW^PRC5A)
 QUIT
EN4 ;FILLE 442 conversion called from PRC5PKG option 4
 I $$SPFCP^PRC5B7]"" QUIT
 D EN^DDIOL("IFCAP V5 INSTALLATION 'Option 4' STARTS at "_$$NOW^PRC5A)
 D START^PRC5B7("ALL")
 D EN442
 D EN^DDIOL("IFCAP V5 INSTALLATION 'Option 4' ENDS at "_$$NOW^PRC5A)
 D EN^DDIOL("This is the last installation option you just finished.")
 I PRCQ21=1 D EN^DDIOL("Check file 442 conversion task is running.")
 QUIT
 ;
 I PRCQ21=1 D  QUIT
EN442 N PRCDUZ
 S PRCDUZ=DUZ
 I PRCQ21=1 D  QUIT
 . D EN^DDIOL("IFCAP V5 FILE 442 CONVERSION SUBMITTED TO TASK MANAGER AT "_$$NOW^PRC5A)
 . S A=$$TASK^PRC0B2("LOOP^PRCHPRCV~IFCAP V5 FILE 442 CONVERSION","PRCDUZ","")
 . D EN^DDIOL("IFCAP V5 FILE 442 CONVERSION HAS TASK NUMBER "_$P(A,"^"))
 . QUIT
 D LOOP^PRCHPRCV
 QUIT
 ;
MM442 ;send conversion done message
 N A,B,X,Y
 S (A,B)=0 F  S B=$O(^GECS(2100.1,B)) QUIT:'B  S A=A+1
 S X(1)="IFCAP V5 file 442 conversion done. Total FMS documents = "_A
 S Y(.5)="",Y(PRCDUZ)="",Y("G.CSFISMGMT@FORUM.VA.GOV")=""
 D MM^PRC0B2("IFCAP V5 FILE 442 CONVERSION DONE^IFCAP V5 Installer","X(",.Y)
 K PRCDUZ
 QUIT

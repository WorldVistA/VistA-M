FBUTL8 ;DSS/BPD - FEE BASIS UTILITY FOR PROVIDER INFORMATION ;5/11/2011
 ;;3.5;FEE BASIS;**122,133**;JAN 30, 1995;Build 5
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
RPROV(FBPROV,FBPROVD) ; Prompt for line item rendering providers
 ;
 ; Input
 ;   FBPROV - required, array passed by reference
 ;            will be initialized (killed)
 ;            array of any entered line item rendering providers
 ;            format
 ;              FBPROV(#)=NAME^NPI^TAXONOMY
 ;   FBPROVD-  optional, array passed by reference
 ;             same format as FBPROV
 ;             if passed, it will be used to supply default values
 ;             normally only used when editing an existing payment 
 ; Result (value of $$ADJ extrinsic function)
 ;   FBRET  - boulean value (0 or 1)
 ;             = 1 when valid line item rendering providers entered
 ;             = 0 when processed ended due to time-out or entry of '^'
 ; Output
 ;   FBPROV  - the FBPROV input array passed by reference will be modified
 ;            if the result = 1 then it will contain entered line item rendering providers
 ;            if the result = 0 then it will be undefined
 ;
 N FBADJR,FBCAS,FBCNT,FBEDIT,FBERR,FBI,FBNEW,FBRET
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S FBRET=1,FBEDIT=0
 S FBNOOUT=$G(FBNOOUT,0)
 K FBPROV
 ;
 ; if existing LI Rendering Provider exist then load them into array
 I $D(FBPROVD) M FBPROV=FBPROVD
 S (FBCNT,FBCAS)=0
 I $D(FBPROV) S FBI=0 F  S FBI=$O(FBPROV(FBI)) Q:'FBI  D
 . S FBCNT=FBCNT+1
 ;
ASKRPROV ; multiply prompt for rendering providers
 ;
 ; display current list of Rendering Providers
 I FBCNT>0 D
 . W !!,"Current list of Line Item Rendering Providers: "
 . I '$O(FBPROV(0)) W "none"
 . S FBI=0 F  S FBI=$O(FBPROV(FBI)) Q:'FBI  D
 . . W !?3,"Line Item: "_FBI
 . . W ?25,"Rendering Provider Name: "_$P(FBPROV(FBI),U)
 . . W !?3,"Rendering Provider NPI: "_$P(FBPROV(FBI),U,2)
 . . W ?45,"Taxonomy Code: "_$P(FBPROV(FBI),U,3)
 ;
 ; prompt for Line Item Rendering Provider
 N FBI,FBPROVR
 S DIR(0)="162.579,.01",DIR("A")="Enter LINE ITEM NUMBER"
 S DIR("?",1)="Please enter the Rendering Provider information for a specific line item."
 S DIR("?",2)="This information is only required if the line item transaction has a different Rendering Provider than the claim."
 D ^DIR K DIR I $D(DTOUT)!($D(DUOUT))!(Y="") G EXIT
 S FBI=+Y I Y'=0,$G(FBPROV(+Y))'="" S FBEDIT=1
 I 'FBEDIT S FBPROV(FBI)=""
 S DIR(0)="162.579,.02" I FBEDIT=1,$D(FBPROV(FBI)) S DIR("B")=$P(FBPROV(FBI),U)
 S DIR("A")="LINE ITEM RENDERING PROV NAME",DIR("?",1)="Enter the Rendering Provider's Name for the specified line item,"
 S DIR("?",2)="if different than the claim level Rendering Provider" D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) G EXIT
 I X="@" D DEL(FBI)
 S $P(FBPROV(FBI),U)=Y
 S DIR(0)="162.579,.03" I FBEDIT=1,$D(FBPROV(FBI)) S DIR("B")=$P(FBPROV(FBI),U,2)
 S DIR("A")="LINE ITEM RENDERING PROV NPI",DIR("?",1)="Enter the Rendering Provider's NPI for the specified line item."
 S DIR("?",2)="if different than the claim level Rendering Provider" D ^DIR K DIR I $D(DTOUT)!($D(DIOUT)) G EXIT
 S $P(FBPROV(FBI),U,2)=Y
 S DIR(0)="162.579,.04",DIR("A")="LINE ITEM RENDERING PROV TAXONOMY CODE" I FBEDIT=1,$D(FBPROV(FBI)) S DIR("B")=$P(FBPROV(FBI),U,3)
 S DIR("?",1)="Enter the Rendering Provider's Name for the specified line item,"
 S DIR("?",2)="if different than the claim level Rendering Provider" D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) G EXIT
 S $P(FBPROV(FBI),U,3)=Y
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="ENTER ANOTHER LINE ITEM RENDERING PROVIDER"
 S DIR("?")="Do you need to enter another Line Item level Rendering Provider?",DIR("?",1)="Answering yes will prompt you for more information or allow"
 S DIR("?",2)="you to modify an entered record." D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) G EXIT
 I FBPROV(FBI)="" K FBPROV(FBI)
 G:Y ASKRPROV G:'Y EXIT
 ;
EXIT Q FBRET
 ;
DEL(FBI) ; delete Rendering Provider from list
 K FBPROV(FBI)
 W "   (provider deleted)"
 Q
 ;
 ;FBUTL2
FILERP(FBIENS,FBPROV) ; Routine to file Rendering Provider information to 162.5
 ; 
 ; Input
 ;       IENS - Required - DA_"," for the record to save the Rendering Provider information to
 ;       FBPROV - Required - Passed by reference array that contains the information to save
 ;
  ; Output
 ;   Data in File 162.5 will be modified
 ;
 N FB,FBFDA,FBI
 ;
 ; delete line item rendering providers currently on file
 D GETS^DIQ(162.5,FBIENS,"79*","","FB")
 K FBFDA
 S FBSIENS="" F  S FBSIENS=$O(FB(162.579,FBSIENS)) Q:FBSIENS=""  D
 .S FBFDA(162.579,FBSIENS,.01)="@"
 I $D(FBFDA) D FILE^DIE("","FBFDA")
 ;
 ; file line item rendering providers from input array
 K FBFDA
 S FBI=0 F  S FBI=$O(FBPROV(FBI)) Q:'FBI  D
 .S FBFDA(162.579,"+"_FBI_","_FBIENS,.01)=FBI
 .S FBFDA(162.579,"+"_FBI_","_FBIENS,.02)=$P(FBPROV(FBI),U)
 .S FBFDA(162.579,"+"_FBI_","_FBIENS,.03)=$P(FBPROV(FBI),U,2)
 .S FBFDA(162.579,"+"_FBI_","_FBIENS,.04)=$P(FBPROV(FBI),U,3)
 I $D(FBFDA) D UPDATE^DIE("","FBFDA")
 ;
 Q
LOADRP(FBIENS,FBPROV) ; Load Line Item Rendering Providers
 ; Input
 ;   FBIENS -  required, internal entry numbers for subfile 162.5
 ;             in standard format as specified for FileMan DBS calls
 ;   FBPROV - required, array passed by reference
 ;             array to load line item rendering providers into
 ; Output
 ;   FBPROV - the FBPROV input array passed by reference will be modified
 ;             format
 ;               FBPROV(#)=IEN^NAME^NPI^TAXONOMY
 ;             if no line item rendering providers are on file then the array will be undefined
 N FB,FBC,FBSIENS
 ;
 K FBPROV
 ;
 S FBC=0
 D GETS^DIQ(162.5,FBIENS,"79*","I","FB")
 S FBSIENS="" F  S FBSIENS=$O(FB(162.579,FBSIENS)) Q:FBSIENS=""  D
 . S FBC=FB(162.579,FBSIENS,.01,"I")
 . S FBPROV(FBC)=FB(162.579,FBSIENS,.02,"I")
 . S $P(FBPROV(FBC),U,2)=FB(162.579,FBSIENS,.03,"I")
 . S $P(FBPROV(FBC),U,3)=FB(162.579,FBSIENS,.04,"I")
 ;
 Q

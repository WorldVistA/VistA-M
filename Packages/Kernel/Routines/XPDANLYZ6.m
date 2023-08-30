XPDANLYZ6 ;OAK/RSF- BUILD ANALYZER ;10/28/22
 ;;8.0;KERNEL;**782**;Jul 10, 1995;Build 4
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
BUILDME ;Ask for build and build user choices on the type of report when running the option
 ; Called from line START^XPDANLYZ1
 N X,Y D COMP1^XPDANLYZ2 ;SETS COMPONENT ARRAY XPDCS
 S XPPATH=$$PWD^%ZISH()
 W @IOF,!,"This tool is used to analyze and list the components of a build to identify",!,"adherence to standards and best practices.",!! ;p732
 S XPDLINE="Analysis of a KIDS BUILD" ;XPDBN is the build patch name and XPDCS is a set of all components
 N DIRUT,DIC S DIC=9.6,DIC(0)="QEAM",DIC("A")="Select Build Name: "
 D ^DIC I Y=-1 K DIC S END=1 Q
 I $D(DIRUT) K DIC S END=1 Q
 I $G(Y)]"" S XPDTOP=Y ;BUILD ien ^ NAME, 11045^SRA*3.0*1
 S XPDBIEN=$P(XPDTOP,"^")
 Q:'+XPDBIEN
 S XPDARR("BUILD",XPDBIEN,"NAME")=$P(XPDTOP,"^",2)
 S:$P(XPDTOP,"^",2)["*" XPDSPC=$P($P(XPDTOP,"^",2),"*"),XPNS(XPDSPC)=""
 S PFL=$$GET1^DIQ(9.6,XPDBIEN_",",1,"I") I PFL?.N S PFL=$$GET1^DIQ(9.6,XPDBIEN_",",1,"E")
 I $G(PFL)]"",$G(XPDSPC)']"" S XPDSPC=PFL,XPNS(XPDSPC)=""
 N XPNSM,J S J=" " F  S J=$O(^XPD(9.6,XPDBIEN,"ABNS","B",J)) Q:J']""  S XPNSM(J)="",XPNS(J)="" ;BUILD CROSS REF
 N XPDLL S XPDLL=$O(^DIC(9.4,"C",XPDSPC,9999),-1) S:'$G(XPDLL) XPDLL=$O(^DIC(9.4,"C2",XPDSPC,0))
 I XPDLL  D  ;D GETS^DIQ(9.4,XPDLL_",","14*","I","XPNS") ;DIC(9.4 - package file
 . N J S J=" " F  S J=$O(^DIC(9.4,XPDLL,14,"B",J)) Q:J']""  S XPNS(J)=""
 . S J=0 F  S J=$O(^DIC(9.4,XPDLL,"EX",J)) Q:'J  S XPEX(^DIC(9.4,XPDLL,"EX",J,0))=""
 S XPDN=PFL I $G(XPDN)']"" S XPDN=$$GET1^DIQ(9.4,XPDLL_",",.01)
 I $D(XPNSM),'$D(XPNSM(XPDSPC)) W !!,"*** Warning: BUILD namespace not consistent with PACKAGE NAMESPACE OR",!,"PREFIX (#23) field of BUILD file."
 I '$G(XPDSPC),'$D(XPNS) W !!,"*** Warning: No namespace found for this build. ****"
 I $G(XPDSPC)]"" W !!,"Namespace: ",XPDSPC,!,"Package: ",$G(XPDN)
 I XPDIS2 S XPQR=1 G TX1
 N Y W !! N DIRUT K DIR S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="specific code references reviewed on the SQA checklist",DIR("A",1)="Do you want to include a section that displays the routine lines containing"
 S DIR("?",1)="The analysis report always displays the routine and line numbers that",DIR("?",2)="include specific code references that are checked as part of the SQA"
 S DIR("?",3)="Checklist.",DIR("?",4)=""
 S DIR("?",5)="Enter YES if you want the analysis report to include a detailed",DIR("?")="display of the code contained on those lines."
 D ^DIR S:$D(DTOUT) END=1 S:$D(DIRUT) END=1 Q:END
 S XPQR=Y
TX1 W !! N DIRUT K DIR,Y S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="and text found in routines",DIR("A",1)="Do you want to include a section that displays the component descriptions"
 S DIR("?",1)="Enter YES if you want the analysis report to include a display of the"
 S DIR("?",2)="descriptions for each component included in the build and text within"
 S DIR("?",3)="the routines included.  This additional display can be copied into another"
 S DIR("?")="product (like MS WORD) to do a spell check."
 D ^DIR S:$D(DTOUT) END=1 S:$D(DIRUT) END=1 Q:END
 S XPDR=Y
 W !!,"Analysis Results Display Choices:"
 W !!,"1. Print the Report"
 W !,"2. Create the Report in .TXT Files"
 W !,"3. Send the Report in MailMan Messages"
 W ! K DIR,Y S DIR(0)="N^1:3"
 S DIR("?")="captured into text files, or compiled into MailMan messages.",DIR("?",1)="Enter your preference for displaying the findings. Reports can be printed,"
 S DIR("A")="Select number"
 D ^DIR S:$D(DTOUT) END=1 S:$D(DIRUT) END=1 Q:END
 S XPDIS=Y I XPDIS=1 H .5 W " . " H .5  W ". " H .5 W "." W !
 N XPDIENS S XPDIENS=XPDBIEN_","
 N TARR D GINFO("9.6",XPDIENS,"3","TARR") ;GET DESCRIPTION ARRAY
 I '$D(TARR(9.6,XPDIENS,3)) S XPDARR("BUILD",XPDBIEN,"DESCRIPT")="No",XPDARR("BUILD",XPDBIEN,"WARNING","DESCRIPTION")="BUILD "_$P(XPDTOP,"^",2)_"("_XPDBIEN_") - DESCRIPTION field (#3) missing."
 I $D(TARR(9.6,XPDIENS,3)) D
 . S XPDARR("BUILD",XPDBIEN,"DESCRIPT")="Yes" N LL S LL=0 F  S LL=$O(TARR(9.6,XPDIENS,3,LL)) Q:'LL  S XPDARR("BUILD",XPDBIEN,"DESCRIPTION",LL)=TARR(9.6,XPDIENS,3,LL)
 ; FILES
 N LL
 I $D(^XPD(9.6,XPDBIEN,4,"B")) S LL=0 F  S LL=$O(^XPD(9.6,XPDBIEN,4,"B",LL)) Q:'LL!($P(^XPD(9.6,XPDBIEN,4,0),"^",4)<1)  S XPDARR("BUILD",XPDBIEN,"FILES",LL)="" D FCHK^XPDANLYZ4(XPDBIEN,LL)
 S LL=0 F  S LL=$O(^XPD(9.6,XPDBIEN,"KRN","B",LL)) Q:'LL  I $D(^XPD(9.6,XPDBIEN,"KRN",LL,"NM")) D
 . Q:$P(^XPD(9.6,XPDBIEN,"KRN",LL,"NM",0),"^",4)<1  S XPDCAR(LL,0)=$$GET1^DIQ(1,LL,.01)
 . N KK S KK=0 F  S KK=$O(^XPD(9.6,XPDBIEN,"KRN",LL,"NM",KK)) Q:'KK  D
 .. I $$GET1^DIQ(9.68,KK_","_LL_","_XPDBIEN,.03)'["DELETE AT SITE" S XPDCAR(LL,KK)=$$GET1^DIQ(9.68,KK_","_LL_","_XPDBIEN,.01)
 .. I $$GET1^DIQ(9.68,KK_","_LL_","_XPDBIEN,.03)["DELETE AT SITE" S XPDARR("DELETE",XPDBIEN,XPDCAR(LL,0),$$GET1^DIQ(9.68,KK_","_LL_","_XPDBIEN,.01))=""
 N XPDL S XPDL=0 F  S XPDL=$O(XPDCAR(XPDL)) Q:'XPDL  D
 . D NSST^XPDANLYZ3(XPDL) ;SET COMPONENTS
 I $D(XPDARR("BUILD",XPDBIEN,"ROUTINE"))>0 D RLINES^XPDANLYZ2 ;CAPTURES ROUTINE INFO; XPDSQA ARRAY OF SQA ROUTINE LINES
 S XPDBN=XPDARR("BUILD",XPDBIEN,"NAME")
 Q
 ;
BTXT ; build routine, XPDARR ARRAY check settings
 I $D(XPDARR("BUILD",XPDNUM,"ROUTINE")) D
 . N XPDL1 S XPDL1=0 F  S XPDL1=$O(XPDARR("BUILD",XPDNUM,"ROUTINE",XPDL1)) Q:'XPDL1  S XPDRTN(XPDARR("BUILD",XPDNUM,"ROUTINE",XPDL1))=""
 ;RPC routine calls
 N LKJ,HHH S LKJ=0,HHH=" " F  S LKJ=$O(XPDARR("REMOTE PROCEDURE",LKJ)) Q:'LKJ  F  S HHH=$O(XPDARR("REMOTE PROCEDURE",LKJ,"ROUTINE",HHH)) Q:HHH']""  D
 . N INCL S INCL=1 I $D(XPDRTN(HHH)) S INCL=0 ;IF INCL=1 ROUTINE IS NOT INCLUDED IN THE BUILD
 . N NSP S NSP=0 I '$$NSPACE^XPDANLYZ6(HHH) S NSP=1 ;IF NSP=1 ROUTINE IS NOT IS PATCH NAMESPACE
 . ;N NSP S NSP=0 I $E(HHH,1,$L(XPDSPC))'=XPDSPC S NSP=1 ;IF NSP=1 ROUTINE IS NOT IS PATCH NAMESPACE
 . I '(NSP),'(INCL) Q
 . I INCL,NSP S XPDARR("REMOTE PROCEDURE",LKJ,"WARNING",HHH)="Routine field (#.03): Calls "_HHH_" not found in build or patch namespace." Q
 . I 'INCL,NSP S XPDARR("REMOTE PROCEDURE",LKJ,"WARNING",HHH)="Routine field (#.03): Calls "_HHH_" not found in patch namespace." Q
 . I INCL,'NSP S XPDARR("REMOTE PROCEDURE",LKJ,"WARNING",HHH)="Routine field (#.03): Calls "_HHH_" not found in build." Q
 ;DIALOG routine calls
 N LKJ,HHH S LKJ=0,HHH=" " F  S LKJ=$O(XPDARR("DIALOG",LKJ)) Q:'LKJ  F  S HHH=$O(XPDARR("DIALOG",LKJ,"ROUTINE",HHH)) Q:HHH']""  D
 . N INCL S INCL=1 I $D(XPDRTN(HHH)) S INCL=0 ;IF INCL=1 ROUTINE IS NOT INCLUDED IN THE BUILD
 . N NSP S NSP=0 I '$$NSPACE^XPDANLYZ6(HHH) S NSP=1 ;IF NSP=1 ROUTINE IS NOT IS PATCH NAMESPACE
 . ;N NSP S NSP=0 I $E(HHH,1,$L(XPDSPC))'=XPDSPC S NSP=1 ;IF NSP=1 ROUTINE IS NOT IS PATCH NAMESPACE
 . I '(NSP),'(INCL) Q
 . N TXT1 S TXT1="ROUTINE NAME (subfield #.01) within the CALLED FROM ENTRY POINTS sub-file (#8) calls "
 . I INCL,NSP S XPDARR("DIALOG",LKJ,"WARNING",HHH)=TXT1_HHH_" not found in build or patch namespace." Q
 . I 'INCL,NSP S XPDARR("DIALOG",LKJ,"WARNING",HHH)=TXT1_HHH_" not found in patch namespace." Q
 . I INCL,'NSP S XPDARR("DIALOG",LKJ,"WARNING",HHH)=TXT1_HHH_" not found in build." Q
 ;TEMPLATE (INPUT,PRINT,SORT) ROUTINE CALLS
 N TY1,LKJ,HHH  F TY1="INPUT TEMPLATE","PRINT TEMPLATE","SORT TEMPLATE" D
 . S LKJ=0,HHH=" " F  S LKJ=$O(XPDARR(TY1,LKJ)) Q:'LKJ  F  S HHH=$O(XPDARR(TY1,LKJ,"ROUTINE",HHH)) Q:HHH']""  D
 .. N INCL S INCL=1 I $D(XPDRTN(HHH)) S INCL=0 ;IF INCL=1 ROUTINE IS NOT INCLUDED IN THE BUILD
 .. N NSP S NSP=0 I '$$NSPACE^XPDANLYZ6(HHH) S NSP=1 ;IF NSP=1 ROUTINE IS NOT IS PATCH NAMESPACE
 .. ;N NSP S NSP=0 I $E(HHH,1,$L(XPDSPC))'=XPDSPC S NSP=1 ;IF NSP=1 ROUTINE IS NOT IS PATCH NAMESPACE
 .. I '(NSP),'(INCL) Q
 .. N TXT1 S TXT1=XPDARR(TY1,LKJ,"ROUTINE",HHH)
 .. I INCL,NSP S XPDARR(TY1,LKJ,"WARNING",HHH)=TXT1_" not found in build or patch namespace." Q
 .. I 'INCL,NSP S XPDARR(TY1,LKJ,"WARNING",HHH)=TXT1_" not found in patch namespace." Q
 .. I INCL,'NSP S XPDARR(TY1,LKJ,"WARNING",HHH)=TXT1_" not found in build." Q
 ;CONSOLODATE OPTIONS ENTRY/EXIT INFO, SEE CEE^XPDANLYZ3
 N LKJ,EE1,ROU6,T1,LJJ,LEE S LEE="",LJJ=0,LKJ=0,EE1=" ",ROU6=" " F  S LKJ=$O(XPOPT(LKJ)) Q:'LKJ  F  S EE1=$O(XPOPT(LKJ,EE1)) Q:EE1']""  F  S ROU6=$O(XPOPT(LKJ,EE1,ROU6)) Q:ROU6']""  D
 . N TMK S TMK=$S(EE1="ENT":"b",EE1="EXT":"c",EE1="ROU":"a",1:"") S T1=XPOPT(LKJ,EE1,ROU6)
 . I XPOPT(LKJ,EE1,ROU6)["file:" S XPDARR("OPTION",LKJ,"WARNING",TMK_ROU6)=XPOPT(LKJ,EE1,ROU6) Q
 . I XPOPT(LKJ,EE1,ROU6)["global" S XPDARR("OPTION",LKJ,"WARNING",TMK_ROU6)=XPOPT(LKJ,EE1,ROU6) Q
 . N INCL S INCL=1 I $D(XPDRTN(ROU6)) S INCL=0 ;IF INCL=1 ROUTINE IS NOT INCLUDED IN THE BUILD
 . N NSP S NSP=0 I '$$NSPACE^XPDANLYZ6(ROU6) S NSP=1 ;IF NSP=1 ROUTINE IS NOT IS PATCH NAMESPACE
 . ;N NSP S NSP=0 I $E(ROU6,1,$L(XPDSPC))'=XPDSPC S NSP=1 ;IF NSP=1 ROUTINE IS NOT IS PATCH NAMESPACE 
 . I '(NSP),'(INCL) Q
 . I LJJ=LKJ,LEE=EE1 S T1=$J(" ",$L(XPOPT(LKJ,EE1,ROU6)))
 . S:LJJ'=LKJ LJJ=LKJ S:LEE'=EE1 LEE=EE1
 . I INCL,NSP S XPDARR("OPTION",LKJ,"WARNING",TMK_ROU6)=T1_" Calls routine "_ROU6_" not in build or namespace." Q
 . I 'INCL,NSP S XPDARR("OPTION",LKJ,"WARNING",TMK_ROU6)=T1_" Calls routine "_ROU6_" not in patch namespace." Q
 . I INCL,'NSP S XPDARR("OPTION",LKJ,"WARNING",TMK_ROU6)=T1_" Calls routine "_ROU6_" not in build." Q
 ;FILES TO CHECK AGAINST OPTION ENTRY/EXIT
 N XPDC2,FN1 S XPDC2=0 F  S XPDC2=$O(XPDARR("FILE",XPDC2)) Q:'XPDC2  S FN1=XPDARR("FILE",XPDC2,"NAME") D
 . N LKJ S LKJ=0 F  S LKJ=$O(XPDARR("OPTION",LKJ)) Q:'LKJ  I $D(XPDARR("OPTION",LKJ,"WARNING",FN1)) K XPDARR("OPTION",LKJ,"WARNING",FN1)
 I $D(XPDARR("DELETE",XPDNUM)) D
 . S XPDCNT=XPDCNT+1,XPDW(XPDCNT)="",XPDCNT=XPDCNT+1,XPDW(XPDCNT)="",XPDCNT=XPDCNT+1,XPDW(XPDCNT)=$J(" ",5)_"The following components are listed as ""DELETE AT SITE""."
 . S XPDCNT=XPDCNT+1,XPDW(XPDCNT)=$J(" ",5)_"Review to validate these are accurately identified."
 . S XPDCNT=XPDCNT+1,XPDW(XPDCNT)="",XPDCNT=XPDCNT+1,XPDW(XPDCNT)=$J(" ",10)_"Component"_$J(" ",20)_"Name"
 . S XPDCNT=XPDCNT+1,XPDW(XPDCNT)=$J(" ",10)_$TR($J("=",40)," ","=")
 . N XPDME S XPDME=" " F  S XPDME=$O(XPDARR("DELETE",XPDNUM,XPDME)) Q:XPDME']""  D
 .. N XPDIT S XPDIT=" " F  S XPDIT=$O(XPDARR("DELETE",XPDNUM,XPDME,XPDIT)) Q:XPDIT']""  S XPDCNT=XPDCNT+1,XPDW(XPDCNT)=$J(" ",10)_XPDME_$J(" ",(40-(10+$L(XPDME))))_XPDIT
 ;if TRACK PACKAGE NATIONALLY not set to YES
 S TRKN=$$GET1^DIQ(9.6,XPDNUM_",",5)
 I TRKN'["Y" D
 . S XPDCNT=XPDCNT+1,XPDW(XPDCNT)="",XPDCNT=XPDCNT+1,XPDW(XPDCNT)="",XPDCNT=XPDCNT+1,XPDW(XPDCNT)="Warning:  Build not set to track package nationally"
 . S XPDCNT=XPDCNT+1,XPDW(XPDCNT)=$J(" ",10)_"Please validate that is correct.",XPDCNT=XPDCNT+1,XPDW(XPDCNT)=""
 ;PACKAGE FILE LINK PFL set in BUILDME
 I PFL]"" S XPDCNT=XPDCNT+1,XPDW(XPDCNT)="",XPDCNT=XPDCNT+1,XPDW(XPDCNT)="Package File link: "_PFL
 I PFL']"" D
 . S XPDCNT=XPDCNT+1,XPDW(XPDCNT)="",XPDCNT=XPDCNT+1,XPDW(XPDCNT)="Warning:  The PACKAGE FILE LINK is missing."
 . S XPDCNT=XPDCNT+1,XPDW(XPDCNT)=$J(" ",10)_"This should be defined for a national VISTA product build."
 ;ENVIRONMENT CHECK ROUTINE CHECK
 N ENV1,ENVD S ENV1=$$GET1^DIQ(9.6,XPDNUM_",",913)
 I $G(ENV1)]"" S ENVD=$$GET1^DIQ(9.6,XPDNUM_",",913.1) S:ENVD["N" XPDCNT=XPDCNT+1,XPDW(XPDCNT)="",XPDCNT=XPDCNT+1,XPDW(XPDCNT)="Warning:  ENVIRONMENT CHECK routine is NOT set to DELETE AT SITE."
 ;Post-Install check
 N ENV1,ENVD S ENV1=$$GET1^DIQ(9.6,XPDNUM_",",914)
 I $G(ENV1)]"" S ENVD=$$GET1^DIQ(9.6,XPDNUM_",",914.1) S:ENVD["N" XPDCNT=XPDCNT+1,XPDW(XPDCNT)="",XPDCNT=XPDCNT+1,XPDW(XPDCNT)="Warning:  POST-INSTALL routine is NOT set to DELETE AT SITE."
 ;Pre-Install check
 N ENV1,ENVD S ENV1=$$GET1^DIQ(9.6,XPDNUM_",",916)
 I $G(ENV1)]"" S ENVD=$$GET1^DIQ(9.6,XPDNUM_",",916.1) S:ENVD["N" XPDCNT=XPDCNT+1,XPDW(XPDCNT)="",XPDCNT=XPDCNT+1,XPDW(XPDCNT)="Warning:  PRE-INSTALL routine is NOT set to DELETE AT SITE."
 S XPDCNT=XPDCNT+1,XPDW(XPDCNT)=$TR($J("-",79)," ","-")
 S XPDCNT=XPDCNT+1,XPDW(XPDCNT)="",XPDCNT=XPDCNT+1,XPDW(XPDCNT)="",XPDCNT=XPDCNT+1,XPDW(XPDCNT)="*** Detailed results for components included in build "_XPDARR("BUILD",XPDBB,"NAME")_"  ***",XPDHR(XPDCNT)="Component Analysis"
 Q
 ;
GINFO(XPDF,XPDI,XPDFLDS,QRR) ;XPDF IS FILE NUMBER, XPDI IS IENS, XPDFLDS CAN BE ONE FIELD, OR SEPARATED BY COMMAS
 D GETS^DIQ(XPDF,XPDI,XPDFLDS,"N",QRR)
 Q
 ;
ADIC(GLB) ;DIC COMMENTS
 S XPDW(XPDCNT)="     Data for this file is stored in "_GLB
 S XPDCNT=XPDCNT+1,XPDW(XPDCNT)="     The global ^DIC should no longer be used for data storage. Data should be"
 S XPDCNT=XPDCNT+1,XPDW(XPDCNT)="     stored in a namespaced global or in ^DIZ followed by the file number."
 ;S XPDCNT=XPDCNT+1,XPDW(XPDCNT)=""
 Q
 ;
ADIZ(ZLB) ;DIZ COMMENTS
 Q:TRKN'["Y"
 S XPDW(XPDCNT)="     Data for this file is stored in "_ZLB
 S XPDCNT=XPDCNT+1,XPDW(XPDCNT)="     National packages should use a global storage location in a"
 S XPDCNT=XPDCNT+1,XPDW(XPDCNT)="     namespaced global."
 ;S XPDCNT=XPDCNT+1,XPDW(XPDCNT)=""
 Q
 ;
PWARN(COMP2) ;
 S XPDCNT=XPDCNT+1,XPDW(XPDCNT)=""
 N JKL S JKL=0 F  S JKL=$O(XPDARR(COMP2,"WARNING",JKL)) Q:'JKL  S XPDCNT=XPDCNT+1,XPDW(XPDCNT)=XPDARR(COMP2,"WARNING",JKL)
 Q
NSPACE(TNAME) ;returns 1 if in namespace, 0 if not
 Q:'$D(XPNS) 0
 N CHK S CHK=0
 N J S J=" " F  S J=$O(XPNS(J)) Q:J']""  I $E(TNAME,1,$L(J))=J S CHK=1
 I CHK,$D(XPEX) D  ;CHECK IF EXCLUDED NAMESPACE
 . S J=" " F  S J=$O(XPEX(J)) Q:J']""  I $E(TNAME,1,$L(J))=J S CHK=0  ;EXCLUDED
 Q CHK

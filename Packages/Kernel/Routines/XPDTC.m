XPDTC ;SFISC/RSD - Transport calls ;10/15/2008
 ;;8.0;KERNEL;**10,15,21,39,41,44,58,83,92,95,100,108,124,131,463,511,517,559**;Jul 10, 1995;Build 4
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;^XTMP("XPDT",XPDA,data type,file #,
 ;XPDA=ien of File 9.6, XPDNM=.01 field
DD ;build DD
 N FILE,FGR,FNAM,Z2,Z3,Z4
 S FILE=0,FGR="^XTMP(""XPDT"",XPDA)",FNAM=$NA(^XPD(9.6,XPDA,4,"APDD"))
 F  S FILE=$O(^XPD(9.6,XPDA,4,FILE)) Q:'FILE  D
 .S Z2=$G(^XPD(9.6,XPDA,4,FILE,222)),Z3=$G(^(223)),Z4=$G(^(224))
 .Q:'$$DATA^XPDV(FILE,Z2)
 .D FIA^DIFROMSU(FILE,"",FNAM,FGR,Z2,Z3,Z4,XPDVER),DIERR:$D(DIERR)
 Q:'$D(^XTMP("XPDT",XPDA,"FIA"))
 ;send DD and Data
 D DDOUT^DIFROMS("","","",FGR),DIERR:$D(DIERR),DATAOUT^DIFROMS("","","",FGR),DIERR:$D(DIERR)
 Q
 ;XPDERR is checked in XPDT and will abort transport
DIERR ;record error
 D MSG^DIALOG("EW",.XPD) S XPDERR=1
 Q
KRN ;build Kernel Files
 ;XPDFILE=file #, XPDOLDA=ien in Build file
 N %,%1,%2,DA,EACT,FACT,FGR,XPDFILE,XPDFL,XPDOLDA,XPDI
 F XPDFILE=1:1 S Y0=$P($T(FILES+XPDFILE^XPDE),";;",2,99) Q:Y0=""  S XPDI(+Y0)=Y0
 ;XPDI(XPDFILE)=file;order;x-ref;fact;eact;fpre;epre;fpos;epos;fdel
 S XPDFILE=0
 ;check we are sending something and have the executes
 F  S XPDFILE=$O(^XPD(9.6,XPDA,"KRN",XPDFILE)) Q:'XPDFILE  S XPDI=$G(XPDI(XPDFILE)) I $O(^(XPDFILE,"NM",0)),XPDI D  Q:$D(XPDERR)  D:FACT]"" ACT(FACT)
 .S FACT=$P(XPDI,";",4),EACT=$P(XPDI,";",5)
 .;need to add code to check if File and data is already being sent in the File
 .;mult. If it is, don't bother sending it again.  DTL(XPDFILE)
 .S XPDOLDA=0,FGR=$$FILE^XPDV(XPDFILE) I FGR="" S XPDERR=1 Q
 .K ^TMP($J,"XPD")
 .F  S XPDOLDA=$O(^XPD(9.6,XPDA,"KRN",XPDFILE,"NM",XPDOLDA)) Q:'XPDOLDA  S Y0=$G(^(XPDOLDA,0)) D
 ..;XPDFL= 0-send,1-delete,2-link,3-merge,4-attach,5-disable
 ..S XPDFL=$P(Y0,U,3)
 ..;If deleting at site get an unused DA
 ..I XPDFL=1 S DA=$O(@FGR@(" "),-1)+1 F DA=DA:1 Q:'$D(^XTMP("XPDT",XPDA,"KRN",XPDFILE,DA))
 ..;$P(Y0,U,2) is file # for this template, reset Y0 before getting DA
 ..E  S:$P(Y0,U,2) $P(Y0,U)=$P(Y0,"    FILE #") S DA=$$ENTRY^XPDV(Y0)
 ..I 'DA S XPDERR=1 Q
 ..;(-1)=action ^ ien in Build file
 ..S ^XTMP("XPDT",XPDA,"KRN",XPDFILE,DA,-1)=+XPDFL_"^"_XPDOLDA
 ..;action 2 - verify children, 4 - verify parent
 ..I XPDFL=2!(XPDFL=4),'$$MENU^XPDV(XPDFILE,DA,XPDFL) S XPDERR=1 Q
 ..;if action is 1,4 or 5 then only send .01 field and set checksum to ""
 ..I XPDFL=1!(XPDFL>3) S ^XTMP("XPDT",XPDA,"KRN",XPDFILE,DA,0)=$P(Y0,U),$P(^XPD(9.6,XPDA,"KRN",XPDFILE,"NM",XPDOLDA,0),U,4)="" Q
 ..M ^XTMP("XPDT",XPDA,"KRN",XPDFILE,DA)=@FGR@(DA)
 ..;execute entry build action
 ..D:EACT]"" ACT(EACT)
 .;quit if no entries were saved
 .Q:'$O(^XTMP("XPDT",XPDA,"KRN",XPDFILE,0))
 .;XPDI=XPDI(XPDFILE), build x-ref of order to install
 .S %=$P(^DIC(XPDFILE,0),U),^XTMP("XPDT",XPDA,"ORD",+$P(XPDI,";",2),XPDFILE)=XPDI,^(XPDFILE,0)=%
 .Q
 Q
QUES ;build from Install Questions multiple
 N I,J,K,X,%
 S X=""
 ;the "B" x-ref will give me the order of the questions
 F  S X=$O(^XPD(9.6,XPDA,"QUES","B",X)) Q:X=""  S I=$$QUES^XPDV(X) S:'I XPDERR=1 D:I
 .S J=0 F  S J=$O(^XPD(9.6,XPDA,"QUES",I,J)) Q:J=""  D
 ..;tranform J to DIR subscripts
 ..I $L(J)=1!(J="QQ") S ^XTMP("XPDT",XPDA,"QUES",X,$TR(J,"1ABQ","0AB?"))=^(J) Q  ;^(J) ref to ^XPD(9.6,XPDA,"QUES",I,J)
 ..;set the word processing fields into DIR("?",#) structure
 ..F %=1:1 Q:'$D(^XPD(9.6,XPDA,"QUES",I,J,%,0))  S ^XTMP("XPDT",XPDA,"QUES",X,$TR(J,"AQ10","A?"),%)=^(0)
 ;send the File questions
 S K=$G(^XPD(9.6,XPDA,"QDEF")) ;Developer Defaults for Questions
 F I=1:2 S X=$P($T(QUESTION+I),";;",2,99) Q:X=""  S Y=$P($T(QUESTION+I+1),";;",2) D
 .S ^XTMP("XPDT",XPDA,"QUES",$P(X,";"),0)=$P(X,";",2),^("A")=$P(X,";",3),^("B")=$S($L($P(K,U,I)):$P(K,U,I),1:$P(X,";",4)),^("??")=$P(X,";",5) S:Y]"" ^("M")=Y
 Q
INT ;build pre,post, & enviroment init routines
 N %,I,R,X,Z
 F I="PRE","INI","INIT" I $G(^XPD(9.6,XPDA,I))]"" S X=^(I) D
 .;remove parameters and seperate routine name from tag^routine
 .S ^XTMP("XPDT",XPDA,I)=X,X=$P(X,"("),R=$P(X,U,$L(X,U)) Q:$D(^("RTN",R))
 .I '$$RTN^XPDV(X,.Z) W !,"Routine ",X,Z S XPDERR=1 Q
 .S %=$$LOAD^XPDTA(R,"0^")
 Q
BLD ;build Build file, Package file and Order Parameter file
 N %,DIC,X,XPD,XPDI,XPDV,Y
 ;Update the 'Date Distributed' field
 S XPD(9.6,XPDA_",",.02)=$$DT^XLFDT()
 D FILE^DIE("","XPD") K XPD
 ;save version of kernel and fm
 S ^XTMP("XPDT",XPDA,"VER")=$$VERSION^XPDUTL("XU")_U_$$VERSION^XPDUTL("VA FILEMAN")
 S ^XTMP("XPDT",XPDA,"MBREQ")=$P($G(XPDT(XPDT)),U,4)
 M ^XTMP("XPDT",XPDA,"BLD",XPDA)=^XPD(9.6,XPDA)
 ;check national package file pointer
 S XPDI=$P(^XPD(9.6,XPDA,0),U,2)
 I XPDI="" W !,"No Package File Link" Q
 S $P(^XTMP("XPDT",XPDA,"BLD",XPDA,0),U,2)=$$PT^XPDTA("^DIC(9.4)",XPDI)
 ;quit if no pointer to package file
 I '$D(^DIC(9.4,XPDI)) W !,"Package File Link is corrupted" S XPDERR=1 Q
 ;update version multiple in package file,XPD=version^date distributed
 S XPD=$$VER^XPDUTL(XPDNM)_U_$P(^XTMP("XPDT",XPDA,"BLD",XPDA,0),U,4)
 ;XPD(1)=root of description field
 S:$D(^XTMP("XPDT",XPDA,"BLD",XPDA,1)) XPD(1)=$NA(^(1))
 S ^XTMP("XPDT",XPDA,"PKG",XPDI,0)=^DIC(9.4,XPDI,0),^XTMP("XPDT",XPDA,"PKG",XPDI,22,0)="^"_$P(^DD(9.4,22,0),U,2)_"^1^1"
 ;add node 20 to XTMP for Patient Merge
 M ^XTMP("XPDT",XPDA,"PKG",XPDI,20)=^DIC(9.4,XPDI,20)
 ;XPDNM'["*" is a version release
 I XPDNM'["*" D
 .S XPDV=$$PKGVER^XPDIP(XPDI,.XPD)
 .;Merge is used to set single nodes and merge multiples
 .F %=1,5,7,20,"DEV","VERSION" M ^XTMP("XPDT",XPDA,"PKG",XPDI,%)=^DIC(9.4,XPDI,%)
 .;XPDV=ien of Version Multiple
 .I $D(^DIC(9.4,XPDI,22,XPDV))'>9 W !!,"**Version multiple in Package file wasn't updated**",!! S XPDERR=1 Q
 .;get just the current version multiple and make it the first entry in version multiple
 .M ^XTMP("XPDT",XPDA,"PKG",XPDI,22,1)=^DIC(9.4,XPDI,22,XPDV)
 .;check if SEND PATCH HISTORY is NO, kill PAH
 .I $P(XPDT(XPDT),U,5) K ^XTMP("XPDT",XPDA,"PKG",XPDI,22,1,"PAH")
 ;this is a patch, %=version number, $P(XPD,U)=patch number
 E  D
 .S %=$P(XPD,U),$P(XPD,U)=$P(XPDNM,"*",3),XPDV=$$PKGPAT^XPDIP(XPDI,%,.XPD)
 .S ^XTMP("XPDT",XPDA,"PKG",XPDI,22,1,0)=^DIC(9.4,XPDI,22,+XPDV,0)
 .I $D(^DIC(9.4,XPDI,22,+XPDV,"PAH",+$P(XPDV,U,2)))'>9 W !!,"**Patch multiple in Package file wasn't updated**",!! S XPDERR=1 Q
 .M ^XTMP("XPDT",XPDA,"PKG",XPDI,22,1,"PAH",1)=^DIC(9.4,XPDI,22,+XPDV,"PAH",+$P(XPDV,U,2))
 .;if CURRENT VERSION was updated in $$PKGPAT, save to TG
 .I $P(XPDV,U,3) S ^XTMP("XPDT",XPDA,"PKG",XPDI,"VERSION")=$P(XPDV,U,3)
 ;save the version ien^patch ien on -1 node
 S ^XTMP("XPDT",XPDA,"PKG",XPDI,-1)="1^1"
 ;resolve Primary Help Frame (0;4)
 S %=+$P(^DIC(9.4,XPDI,0),U,4) S:% $P(^XTMP("XPDT",XPDA,"PKG",XPDI,0),U,4)=$$PT^XPDTA("^DIC(9.2)",%)
 Q
 ;
ACT(%) ;execute action
 ;user can count on DA,XPDFILE,XPDFL,XPDNM,XPDOLDA being around
 ;DA=ien in ^XTMP("XPDT",XPDA,"KRN",XPDFILE,DA)
 ;XPDOLDA=ien in ^XPD(9.6,XPDA,"KRN",XPDIFLE,"NM",XPDOLDA)
 N EACT,FACT,FGR,K0,Y0
 S:%'["^" %="^"_%
 D @% Q
 ;
 ;the following are the default questions for the INSTALL QUESTIONS
 ;in file 9.6, the format is:
 ;;field .01;field 1;field 2;field 4;field 7
 ;;field 10
QUESTION ;package install questions
 ;;XPF1;Y;Shall I write over your |FLAG| File;YES;^D REP^XPDH
 ;;D XPF1^XPDIQ
 ;;XPF2;Y;Want my data |FLAG| yours;YES;^D DTA^XPDH
 ;;D XPF2^XPDIQ
 ;;XPI1;YO;Want KIDS to INHIBIT LOGONs during the install;NO;^D INHIBIT^XPDH
 ;;D XPI1^XPDIQ
 ;;XPM1;PO^VA(200,:EM;Enter the Coordinator for Mail Group '|FLAG|';;^D MG^XPDH
 ;;D XPM1^XPDIQ
 ;;XPO1;Y;Want KIDS to Rebuild Menu Trees Upon Completion of Install;NO;^D MENU^XPDH
 ;;D XPO1^XPDIQ
 ;;XPZ1;Y;Want to DISABLE Scheduled Options, Menu Options, and Protocols;NO;^D OPT^XPDH
 ;;D XPZ1^XPDIQ
 ;;XPZ2;Y;Want to MOVE routines to other CPUs;NO;^D RTN^XPDH
 ;;D XPZ2^XPDIQ

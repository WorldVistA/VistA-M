VAFCEHU3 ;BIR/LTL,PTD-File utilities for 391.98 ;10/23/02
 ;;5.3;Registration;**149,295,384,474,477,479,620,756**;Aug 13, 1993;Build 5
 ;
 ;Check for select fields that if edited can update without review
EN ;
 N VAFC,VAFCE,VAFCF S VAFCF=1
 ;Save the array so a new one can be built for edit
 M VAFC=@VAFCB K @VAFCB
 F  S VAFCE=$P(VAFC(2,"FLD"),";",VAFCF) Q:'VAFCE  S VAFCF=VAFCF+1 D
 .Q:(VAFCE>.01&(VAFCE<.111))!(VAFCE>.219)
 .S @VAFCB@(2,VAFCE)=$G(VAFC(2,VAFCE)) ;**756 added $get
 ;save the sending site's station number
 I $D(VAFC(2,"SENDING SITE")) S @VAFCB@(2,"SENDING SITE")=VAFC(2,"SENDING SITE")
ED ;D:$D(VAFCB) EDIT^VAFCPTED(PAT,VAFCB_"(2)",".01") ;**295 auto-updated fields - removed .111;.112;.113;.114;.115;.1112;.117;.131;.132;.211;.219 ;**474 stop all auto-updates
 ;restore the array for possible exceptions
 M @VAFCB=VAFC
CH ;Any differences?
 N DFN,DGNAME ;**295,**384
 S DFN=PAT,VAFCQ=0,VAFCF=@VAFCB@(2,"FLD") D DEM^VADPT
 ;reformat problem data
 I @VAFCB@(2,.05)="N" S @VAFCB@(2,.05)="NEVER MARRIED" ;**477
 ;If not null and different or null and edited and different,
 ;we got an exception, we're out of here
 ;NAME - .01 - VADM(1)
 I '$$COMP^VAFCUTL(VADM(1),@VAFCB@(2,.01)) S VAFCQ=1 G CHQ
 ;SEX - .02 - VADM(5)
 I (@VAFCB@(2,.02)'[U)&(($P(VADM(5),U,2)'=@VAFCB@(2,.02))) S VAFCQ=1 G CHQ
 ;DOB - .03 - VADM(3)
 I (@VAFCB@(2,.03)'=$P(VADM(3),U)) S VAFCQ=1 G CHQ
 ;MARITAL STATUS - .05 - VADM(10)
 I (@VAFCB@(2,.05)'="""@"""),($P(VADM(10),U,2)'=@VAFCB@(2,.05)),(@VAFCB@(2,.05)'[U) S VAFCQ=1 G CHQ
 ;RELIGION - .08 - VADM(9)
 I (@VAFCB@(2,.08)'[U),($P(VADM(9),U,2)'=@VAFCB@(2,.08)) S VAFCQ=1 G CHQ
 ;SSN - .09 - VADM(2)
 I (@VAFCB@(2,.09)'=$P(VADM(2),U)) S VAFCQ=1 G CHQ
 ;get some address stuff
 D ADD^VADPT
 ;STREET ADDRESS [1] - .111 - VAPA(1)
 ;I (@VAFCB@(2,.111)'="""@"""),'$$COMP^VAFCUTL(@VAFCB@(2,.111),VAPA(1)) S VAFCQ=1 G CHQ ;**479
 ;STREET ADDRESS [2] - .112 - VAPA(2)
 ;I (@VAFCB@(2,.112)'="""@"""),'$$COMP^VAFCUTL(@VAFCB@(2,.112),VAPA(2)) S VAFCQ=1 G CHQ ;**479
 ;STREET ADDRESS [3] - .113 - VAPA(3)
 ;I (@VAFCB@(2,.113)'="""@"""),'$$COMP^VAFCUTL(@VAFCB@(2,.113),VAPA(3)) S VAFCQ=1 G CHQ ;**479
 ;CITY - .114 - VAPA(4)
 ;I (@VAFCB@(2,.114)'="""@"""),'$$COMP^VAFCUTL(VAPA(4),@VAFCB@(2,.114)) S VAFCQ=1 G CHQ ;**479
 ;STATE - .115 - VAPA(5)
 ;I (@VAFCB@(2,.115)'="""@"""),($P(VAPA(5),U,2)'=@VAFCB@(2,.115)) S VAFCQ=1 G CHQ ;**479
 ;ZIP+4 - .1112 - VAPA(11)
 ;I (@VAFCB@(2,.1112)'="""@"""),(@VAFCB@(2,.1112)'=$P(VAPA(11),U,2)) S VAFCQ=1 G CHQ ;**477 added u,2) ;**479
 ;COUNTY CODE - .117 - VAPA(7)
 ;I @VAFCB@(2,.117),(@VAFCB@(2,.117)'=$P(VAPA(7),U)) S VAFCQ=1 G CHQ ;**479
 ;PHONE HOME - .131 - VAPA(8)
 I ($G(@VAFCB@(2,.131))'="""@"""),'$$COMP^VAFCUTL($$HLPHONE^HLFNC(VAPA(8)),$$HLPHONE^HLFNC($G(@VAFCB@(2,.131)))) S VAFCQ=1 G CHQ ;**384 ;**756 added $get's
 ;Get the rest
 D GETS^DIQ(2,DFN_",",".132;.211;.219;.2403;.301;.302;.31115;.323;.361;391;1901","","VAPA")
 ;PHONE WORK - .132 - VAPA(2,DFN,.132)
 I ($G(@VAFCB@(2,.132))'="""@"""),'$$COMP^VAFCUTL($$HLPHONE^HLFNC(VAPA(2,DFN_",",.132)),$$HLPHONE^HLFNC($G(@VAFCB@(2,.132)))) S VAFCQ=1 G CHQ ;**384 ;**756 added $get's
 ;K-NAME - .211 - VAPA(2,DFN,.211)
 I $S(VAPA(2,DFN_",",.211)="":0,1:1) S DGNAME=VAPA(2,DFN_",",.211) D STDNAME^XLFNAME(.DGNAME,"P") S DGNAME=$$FORMAT^XLFNAME7(.DGNAME,3,35),VAPA(2,DFN_",",.211)=DGNAME ;**384 **477
 I $S(@VAFCB@(2,.211)="":0,@VAFCB@(2,.211)["@":0,1:1) S DGNAME=@VAFCB@(2,.211) D STDNAME^XLFNAME(.DGNAME,"P") S DGNAME=$$FORMAT^XLFNAME7(.DGNAME,3,35),@VAFCB@(2,.211)=DGNAME ;**384 **477
 I (@VAFCB@(2,.211)'="""@"""),'$$COMP^VAFCUTL(VAPA(2,DFN_",",.211),@VAFCB@(2,.211)) S VAFCQ=1 G CHQ
 ;K-PHONE - .219 - VAPA(2,DFN,.219)
 I (@VAFCB@(2,.219)'="""@"""),'$$COMP^VAFCUTL($$HLPHONE^HLFNC(VAPA(2,DFN_",",.219)),$$HLPHONE^HLFNC(@VAFCB@(2,.219))) S VAFCQ=1 G CHQ ;**384
 ;MOTHER'S MAIDEN NAME - .2403 - VAPA(2,DFN,.2403)
 I $S(VAPA(2,DFN_",",.2403)="":0,1:1) S DGNAME=VAPA(2,DFN_",",.2403) D STDNAME^XLFNAME(.DGNAME,"P") S DGNAME=$$FORMAT^XLFNAME7(.DGNAME,3,35,,2,,1),VAPA(2,DFN_",",.2403)=DGNAME ;**384 **477
 I $S(@VAFCB@(2,.2403)="":0,@VAFCB@(2,.2403)["@":0,1:1) S DGNAME=@VAFCB@(2,.2403) D STDNAME^XLFNAME(.DGNAME,"P") S DGNAME=$$FORMAT^XLFNAME7(.DGNAME,3,35,,2,,1),@VAFCB@(2,.2403)=DGNAME ;**384 **477
 I ((@VAFCB@(2,.2403)'="""@""")&('$$COMP^VAFCUTL(VAPA(2,DFN_",",.2403),@VAFCB@(2,.2403))))!((@VAFCB@(2,.2403)="""@""")&((VAFCF[".2403;"))&((VAPA(2,DFN_",",.2403)]""))) S VAFCQ=1 G CHQ
 ;SERVICE CONNECTED - .301 - VAPA(2,DFN,.301)
 ;I ((@VAFCB@(2,.301)'="""@""")&((VAPA(2,DFN_",",.301)'=@VAFCB@(2,.301))))!((@VAFCB@(2,.301)="""@""")&((VAFCF[".301;"))&((VAPA(2,DFN_",",.301)]""))) S VAFCQ=1 G CHQ
 ;SC% - .302 - VAPA(2,DFN,.302)
 ;I (@VAFCB@(2,.302)&((VAPA(2,DFN_",",.302)'=@VAFCB@(2,.302))))!((@VAFCB@(2,.302)="""@""")&((VAFCF[".302;"))&((VAPA(2,DFN_",",.302)]""))) S VAFCQ=1 G CHQ
 ;EMPLOYMENT STATUS - .31115 - VAPA(2,DFN,.31115)
 I ((@VAFCB@(2,.31115)'="""@""")&((VAPA(2,DFN_",",.31115)'=@VAFCB@(2,.31115))))!((@VAFCB@(2,.31115)="""@""")&((VAFCF[".31115;"))&((VAPA(2,DFN_",",.31115)]""))) S VAFCQ=1 G CHQ
 ;PERIOD OF SERVICE - .323 - VAPA(2,DFN,.323)
 ;I ((@VAFCB@(2,.323)'="""@""")&((VAPA(2,DFN_",",.323)'=@VAFCB@(2,.323))))!((@VAFCB@(2,.323)="""@""")&((VAFCF[".323;"))&((VAPA(2,DFN_",",.323)]""))) S VAFCQ=1 G CHQ
 ;DATE OF DEATH - .351 - VAPA(2,DFN,.351)
 S VAPA(2,DFN_",",.351)=$$GET1^DIQ(2,DFN_",",.351,"I")
 I ((@VAFCB@(2,.351)'="""@""")&((@VAFCB@(2,.351)'=VAPA(2,DFN_",",.351))))!((@VAFCB@(2,.351)="""@""")&((VAFCF[".351"))&(VAPA(2,DFN_",",.351))) S VAFCQ=1 G CHQ
 ;PRIMARY ELIG CODE - .361 - VAPA(2,DFN,.361)
 ;I (@VAFCB@(2,.361)]"")&(@VAFCB@(2,.361)'=VAPA(2,DFN_",",.361))!((@VAFCB@(2,.361)="")&((VAFCF[".361;"))&((@VAFCB@(2,.361)'=VAPA(2,DFN_",",.361)))) S VAFCQ=1 G CHQ
 ;PATIENT TYPE - 391 - VAPA(2,DFN,391)
 ;I ((@VAFCB@(2,391)'="""@""")&(@VAFCB@(2,391)'=VAPA(2,DFN_",",391)))!((@VAFCB@(2,391)="""@""")&((VAFCF["391;"))&((VAPA(2,DFN_",",391)]""))) S VAFCQ=1 G CHQ
 ;VETERAN (Y/N) - 1901 - VAPA(2,DFN,1901)
 ;I ((@VAFCB@(2,1901)'="""@""")&(@VAFCB@(2,1901)'=VAPA(2,DFN_",",1901)))!((@VAFCB@(2,1901)="""@""")&((VAFCF["1901;"))&((VAPA(2,DFN_",",1901)]""))) S VAFCQ=1
CHQ D:'$G(VAFCQ) EN^VAFCEHU4
 D KVA^VADPT Q

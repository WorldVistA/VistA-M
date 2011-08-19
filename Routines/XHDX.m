XHDX ; SLC/JER - Desktop Config Calls ; 01 Aug 2003  12:18 AM
 ;;1.0;HEALTHEVET DESKTOP;;Jul 15, 2003
PERSEL(LST)     ; List perspectives for a user
 N OPT,X,I
 S OPT=$$GET^XPAR($$ENTSTR,"XHD PRISM PERSPECTIVE SELECTOR",1,"I")
 Q:'OPT
 S I=0 F  S I=$O(^DIC(19,+OPT,10,I)) Q:'I  D
 . S X=^DIC(19,+OPT,10,I,0)
 . S LST($S($P(X,U,3):$P(X,U,3),1:99999+I))=$P(^DIC(19,+X,0),U,2)
 Q
ENTSTR()        ; Build entities string
 Q "ALL^USR.`"_DUZ_$S(+$G(^VA(200,DUZ,5)):"^SRV.`"_+$G(^(5)),1:"")
VERSRV(LST,OPT) ; Return option versions
 N I,X
 S I=0 F  S I=$O(OPT(I)) Q:'I  D
 . N XHDLST
 . S X=$P(OPT(I),U),LST(I)=X
 . D FIND^DIC(19,"",1,"X",X,1,,,,"XHDLST")
 . I 'XHDLST("DILIST",0) Q
 . S $P(LST(I),U,2)=$RE($P($RE(XHDLST("DILIST","ID",1,1))," ",1))
 Q
ASSIGN ; Assign perspectives to users
 N DIC,DONE,X,Y,USR,OPT,ANERR,CUR,CURNM,REP,DIR,DIRUT,DUOUT,DTOUT
 S DIC=19,DIC(0)="AEMQ",DIC("A")="Select Perspective Option: "
 D ^DIC Q:Y<1  S OPT=+Y
 W !!,"Assigning "_$P(Y,U,2)_" to Users"
 S DONE=0 F  D  Q:DONE
 . S DIC=200,DIC(0)="AEMQ",DIC("A")="Assign to: "
 . D ^DIC I Y<1 S DONE=1 Q
 . S USR=+Y
 . S CUR=+$$GET^XPAR(USR_";VA(200,","XHD PRISM PERSPECTIVE SELECTOR",1)
 . I +CUR,(CUR'=OPT) D  Q:'REP
 . . S CURNM=$$GET^XPAR(USR_";VA(200,","XHD PRISM PERSPECTIVE SELECTOR",1,"E")
 . . S DIR(0)="Y",DIR("A")="Currently Assigned "_CURNM_".  Replace",DIR("B")="Y"
 . . D ^DIR S REP=Y
 . D EN^XPAR(USR_";VA(200,","XHD PRISM PERSPECTIVE SELECTOR",1,"`"_OPT,.ANERR)
 . I ANERR W !,$P(ANERR,U,2)
 . D CHKCTXT(OPT,USR)
 Q
CHKCTXT(OPT,USR)        ; Check context
 N HASOPT,ALLCTXT
 S HASOPT=$$ACCESS^XQCHK(USR,OPT)
 I +HASOPT<1 D
 . S ALLCTXT=$$FIND1^DIC(19,"","QX","ORRCM CLIENT")
 . S HASOPT=$$ACCESS^XQCHK(USR,ALLCTXT)
 I +HASOPT<1 D
 . N USRNM,OPTNM
 . S USRNM=$$GET1^DIQ(200,USR_",",.01)
 . S OPTNM=$$GET1^DIQ(19,OPT_",",.01)
 . W !,USRNM_" does not have the "_OPTNM_" in the menu tree."
 . W !,"You many need to add this as a secondary menu for this user.",!
 Q
BYUSR ; Assign a perspective to a single user
 N DIC,DIR,DIRUT,DUOUT,DTOUT,X,Y,USR,OPT,ANERR
 S DIC=200,DIC(0)="AEMQ"  ;,DIC("A")="Assign to: "
 D ^DIC Q:Y<1  S USR=+Y
 S DIR(0)="PAO^19:EM",DIR("A")="Select Perspective Option: "
 S DIR("B")=$$GET^XPAR(USR_";VA(200,","XHD PRISM PERSPECTIVE SELECTOR",1,"E")
 I DIR("B")="" K DIR("B")
 D ^DIR
 S OPT="" S:(Y<1)&(X="@") OPT="@" S:+Y>0 OPT="`"_+Y
 Q:OPT=""
 D EN^XPAR(USR_";VA(200,","XHD PRISM PERSPECTIVE SELECTOR",1,OPT,.ANERR)
 I ANERR W !,$P(ANERR,U,2)
 S OPT=+$P(OPT,"`",2) I OPT D CHKCTXT(OPT,USR)
 Q
BYSVC ; Assign a perspective to a service
 N DIC,DIR,DIRUT,DUOUT,DTOUT,X,Y,SVC,SVCNM,OPT,OPTNM,ANERR
 S DIC=49,DIC(0)="AEMQ"
 D ^DIC Q:Y<1  S SVC=+Y,SVCNM=$P(Y,U,2)
 S DIR(0)="PAO^19:EM",DIR("A")="Select Perspective Option: "
 S DIR("B")=$$GET^XPAR(SVC_";DIC(49,","XHD PRISM PERSPECTIVE SELECTOR",1,"E")
 I DIR("B")="" K DIR("B")
 D ^DIR
 S OPT="" S:(Y<1)&(X="@") OPT="@" S:+Y>0 OPT="`"_+Y S OPTNM=$P(Y,U,2)
 Q:OPT=""
 D EN^XPAR(SVC_";DIC(49,","XHD PRISM PERSPECTIVE SELECTOR",1,OPT,.ANERR)
 I ANERR W !,$P(ANERR,U,2)
 I 'ANERR,(+$P(OPT,"`",2)) D
 . W !,OPTNM_" has been set for "_SVCNM_"."
 . W !,"Note:  "_OPTNM_" must also be available in each user's menu tree."
 Q

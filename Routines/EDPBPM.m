EDPBPM ;SLC/KCM - Parameters for Tracking Area
 ;;1.0;EMERGENCY DEPARTMENT;;Sep 30, 2009;Build 74
 ;
LOAD(AREA) ; load parameters for area
 N X,X1,TOKEN
 D READL^EDPBLK(AREA,"param",.TOKEN)  ; read param config -- LOCK
 D XML^EDPX("<paramToken>"_TOKEN_"</paramToken>")
 S X1=$G(^EDPB(231.9,AREA,1))
 S X("reqDiag")=+$P(X1,U,1)
 S X("codedDiag")=+$P(X1,U,2)
 S X("reqDisp")=+$P(X1,U,3)
 S X("reqDelay")=+$P(X1,U,4)
 S X("minDelay")=+$P(X1,U,5)
 S X("shiftOne")=$P(X1,U,6)
 S X("shiftLen")=$P(X1,U,7)
 S X("residents")=$P(X1,U,8)
 S X("clinics")=$P(X1,U,9)
 S X("ambulance")=$P(X1,U,11)
 S X("dfltroom")=$P(X1,U,12)
 D XML^EDPX($$XMLA^EDPX("params",.X))
 D READU^EDPBLK(AREA,"param",.TOKEN)  ; read param config -- UNLOCK
 Q
SAVE(AREA,PARAM) ; save updated parameters
 I '$D(^EDPB(231.9,AREA,0)) D SAVERR^EDPX("fail","Area not set up") Q
 ;
 N TOKEN,LOCKERR
 S TOKEN=$G(REQ("paramToken",1))
 D SAVEL^EDPBLK(AREA,"param",.TOKEN,.LOCKERR) ; save param config -- LOCK
 I $L(LOCKERR) D SAVERR^EDPX("collide",LOCKERR),LOAD(AREA) Q
 ;
 N FLD D NVPARSE^EDPX(.FLD,PARAM)
 N FDA,FDAIEN,DIERR
 S AREA=AREA_","
 I FLD("ambulance")=-1 S FLD("ambulance")="@"
 I FLD("dfltroom")=-1 S FLD("dfltroom")="@"
 S FDA(231.9,AREA,1.1)=FLD("reqDiag")
 S FDA(231.9,AREA,1.2)=FLD("codedDiag")
 S FDA(231.9,AREA,1.3)=FLD("reqDisp")
 S FDA(231.9,AREA,1.4)=FLD("reqDelay")
 S FDA(231.9,AREA,1.5)=FLD("minDelay")
 S FDA(231.9,AREA,1.6)=FLD("shiftOne")
 S FDA(231.9,AREA,1.7)=FLD("shiftLen")
 S FDA(231.9,AREA,1.8)=FLD("residents")
 S FDA(231.9,AREA,1.9)=FLD("clinics")
 S FDA(231.9,AREA,1.11)=FLD("ambulance")
 S FDA(231.9,AREA,1.12)=FLD("dfltroom")
 D FILE^DIE("","FDA","ERR")
 D SAVEU^EDPBLK(+AREA,"param",.TOKEN)         ; save param config -- UNLOCK
 ;
 I $D(DIERR) D SAVERR^EDPX("fail",$G(ERR("DIERR",1,"TEXT",1))) Q
 D XML^EDPX("<save status='ok' />")
 D LOAD(+AREA)
 Q
TZSAVE(AREA,TZDIFF) ; save time zone difference in minutes
 N FDA,FDAIEN,DIERR
 S AREA=AREA_","
 S FDA(231.9,AREA,.03)=TZDIFF
 D FILE^DIE("","FDA","ERR")
 Q

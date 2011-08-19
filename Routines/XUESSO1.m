XUESSO1 ;LUKE/SEA Single Sign-on utilities;02/11/10  14:57;08/18/09  14:29
 ;;8.0;KERNEL;**165,183,196,245,254,269,337,395,466,523**;Jul 10, 1995;Build 16
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
GET(INDUZ) ;Gather identifying data from user's home site.
 ;Must have Name, Access&Verify codes, SSN (no pseudo), station name&number
 N %,NAME,SITE,SSN,PHONE,X,N,VPID
 I '$D(DUZ) G BOMB
 I '$D(DUZ(2)) G BOMB
 ;I '$D(INDUZ) S INDUZ=DUZ
 S N=$G(^VA(200,DUZ,0))
 I '$L(N) G BOMB
 S %=$P(N,U,3) I $L(%)<1 G BOMB ;No Access Code
 S %=$P($G(^VA(200,DUZ,.1)),U,2) I $L(%)<1 G BOMB ;No Verify Code
 S %=$P(N,U,11) I $L(%)>1,(DT>%) G BOMB ;Terminated
 S NAME=$P(N,U)
 I '$L(NAME) G BOMB
 ;
 S SITE=$$NS^XUAF4(DUZ(2)) ;Site is name^station#
 I $P(SITE,U,2)="" G BOMB ;Need a station number
 ;
 S SSN=$P($G(^VA(200,DUZ,1)),U,9)
 I $$SPECIAL($P(SITE,"^",2)) S SSN=999999999 G G4 ;Manila RO doesn't need SSN
 I 'SSN G BOMB
 ;Don't allow if the SSN is pseudo
 I $E(SSN,10)="P" G BOMB
 ;Don't allow if the SSN is not real, (e.g. 00000NNNN)
 I $E(SSN,1,5)="00000" G BOMB
 ;
G4 S PHONE=$$PH
 S VPID=$$VPID^XUPS(DUZ) ;(p337)
 S X=SSN_U_NAME_U_SITE_U_DUZ
 I $L(PHONE)>2&($L(PHONE<20)) S X=X_U_PHONE
 S $P(X,U,7)=VPID ;(p337)
 ;ssn^name^station name^station number^DUZ^phone^vpid
 Q X
 ;
 ;
BOMB ;Insufficient information to allow visiting
 S X="-1^Insufficient User Information On File.  ssn,name,station name,station number,DUZ,phone"
 Q X
 ;
 ;
PH() ; Try for a phone number or pager
 N %,X
 S %=""
 S X=$G(^VA(200,DUZ,.13))
 I '$L(X) Q ""
 ;
 S %=$P(X,U,5) I $L(%)>6 Q %  ;Commercial #
 S %=$P(X,U,2) I $L(%)>2 Q %  ;Office
 S %=$P(X,U,8) I $L(%)>6 Q %  ;Digital Pager
 S %=$P(X,U,7) I $L(%)>6 Q %  ;Pager
 S %=$P(X,U,3) I $L(%)>2 Q %  ;Phone #3
 S %=$P(X,U,4) I $L(%)>2 Q %  ;Phone #4
 S %=$P(X,U,1) I $L(%)>2 Q %  ;Home Phone
 Q "" ;Couldn't find one.
 ;
SPECIAL(SN) ;Special Manila RO site
 Q 358=SN
 ;
 ;
PUT(DATIN) ;;Setup data from authenticating site GET() at receiving site
 ;Return: 0=fail, 1=OK
 N NEWDUZ,FDR,TODAY,IEN,DIC,USER,X,%T
 N SSN,NAME,SITE,SITENUM,RMTDUZ,PHONE,VPID,XUMF
 S U="^",TODAY=$$HTFM^XLFDT($H),DT=$P(TODAY,"."),NEWDUZ=0
 K ^TMP("DIERR",$J)
 ;
 S SSN=$P(DATIN,U,1),NAME=$P(DATIN,U,2),SITE=$P(DATIN,U,3)
 S SITENUM=$P(DATIN,U,4),RMTDUZ=$P(DATIN,U,5),PHONE=$P(DATIN,U,6)
 S VPID=$P(DATIN,U,7) ;(p337)
 ;Format checks
 I NAME'?1U.E1","1U.E Q 0
 I SSN'?9N Q 0
 I '$L(SITE)!('$L(SITENUM)) Q 0
 S XUMF=1 D CHK^DIE(4,99,,SITENUM,.%T) I %T=U Q 0 ;p533
 D CHK^DIE(200.06,1,,SITE,.%T) I %T=U Q 0 ;p533
 I RMTDUZ'>0 Q 0 ;p337
 ;
 ;Get a LOCK. Block if can't get.
 L +^VA(200,"HL7"):10 Q:'$T 0
 S %T=$$TALL($G(DUZ,0)) L -^VA(200,"HL7")
 I %T Q $$SET(NEWDUZ) ;Return 1 if OK.
 Q 0
 ;
 ;Per PSIM don't load VPID's, Only done by PSIM.
 ;Code for adding VPID removed in p466.
TALL(DUZ) ;Test for existing user or adds a new one
 N FLAG,NEWREC
 S FLAG=0,DUZ(0)="@" ;Make sure we can add the entry
 ;See if match VPID, Per PSIM only use for lookup.
 I $L(VPID) D
 . S NEWDUZ=+$$IEN^XUPS(VPID) Q:NEWDUZ<1
 . I '$D(^VA(200,NEWDUZ,8910,"B",SITENUM)) D VISM
 . D UPDT S FLAG=1
 . Q
 I FLAG Q 1 ;Quit here if we found a match on VPID
 ;See if the SSN is in the NPF cross reference
 I '$$SPECIAL(SITENUM),$D(^VA(200,"SSN",SSN)) D
 .S NEWDUZ=$O(^VA(200,"SSN",SSN,0))
 .I '$D(^VA(200,NEWDUZ,8910,"B",SITENUM)) D VISM
 .D UPDT
 .S FLAG=1
 .Q
 ;See if in the AVISIT cross reference
 I 'FLAG,$$SPECIAL(SITENUM) D
 . S NEWDUZ=$O(^VA(200,"AVISIT",SITENUM,RMTDUZ,0))
 . Q:NEWDUZ'>0
 . D UPDT S FLAG=1
 . Q
 I FLAG Q 1 ;Quit here if we found a match for SSN or AVISIT
 ;
 ;
 ;There is no matching SSN, try for a NAME match in "B"
 S FLAG=0,NAME=$$UP^XLFSTR(NAME)
 I $D(^VA(200,"B",NAME)) D
 .N %,USER,USER2
 .S NEWDUZ=$O(^VA(200,"B",NAME,0))
 .S USER2=$O(^VA(200,"B",NAME,NEWDUZ)) ;More then one?
 .Q:$L(USER2)>0
 .;
 .S %=$P($G(^VA(200,NEWDUZ,1)),U,9)
 .Q:%'=SSN  ;Don't use this name if it has a different SSN
 .;
 .I '$L($P(^VA(200,NEWDUZ,1),U,9)) D ADDS
 .I '$D(^VA(200,NEWDUZ,8910,"B",SITENUM)) D VISM
 .D UPDT S FLAG=1
 .Q
 I FLAG Q 1 ;Quit here if we found an exact match for NAME (w/o SSN)
 ;
NEWU ;We didn't find anybody under SSN or NAME so we add a new user
 ;
 S DIC(0)="" ;Turn off ^XUA4A7 (work around)
 ;
 ;Put the name in the .01 field first.
 D ADDU ;ADDU will set NEWDUZ
 ;If NEWDUZ is still 0, the User add didn't work so exit.
 I NEWDUZ=0 Q 0
 ; Add SSN and Alias.
 D ADDS,ADDA ;(p337)
 ; Fill in the  VISITED FROM multiple
 D VISM,UPDT ;Do update for all data in UPDT
 ;
 I $D(^TMP("DIERR",$J)) Q 0  ;FileMan Error
 ;
 I NEWDUZ D BULL Q 1  ;Every thing OK
 Q 0  ;Couldn't add user
 ;
 ;
 ;              *****Subroutines*****
 ;
 ;
SET(NEWDUZ) ;Set the user up to go
 Q:NEWDUZ'>0 0
 N XUSER,XOPT
 S DUZ=NEWDUZ,U="^",DUZ("VISITOR")=SITENUM_U_RMTDUZ ;p533
 D DUZ^XUS1A
 Q 1
 ;
ADDU ;Add a new name to the New Person File
 N DD,DO,DIC,DA,X,Y
 S DIC="^VA(200,",DIC(0)="L",X=NAME,NEWREC=1 ;p533
 D FILE^DICN
 S:Y>0 NEWDUZ=+Y
 Q
 ;
ADDS ;Add a SSN to the file
 Q:$$SPECIAL(SITENUM)
 S IEN=NEWDUZ_","
 S FDR(200,IEN,9)=SSN
 ;Do update for all data in UPDT
 Q
 ;
ADDA ;Add a new Alias to file 200.04
 Q:$D(^VA(200,NEWDUZ,3,"B","VISITOR"))
 S IEN="+2,"_NEWDUZ_","
 S FDR("200.04",IEN,.01)="VISITOR"
 ;Do update for all data in UPDT
 Q
 ;
VISM ;Create a multiple for this site number in the VISTED FROM file
 S IEN="+3,"_NEWDUZ_","
 S FDR("200.06",IEN,.01)=SITENUM
 ;
 S FDR("200.06",IEN,1)=SITE
 S FDR("200.06",IEN,2)=RMTDUZ
 S FDR("200.06",IEN,3)=TODAY
 ;I $D(PHONE),($L(PHONE)>2) S FDR("200.06",IEN,5)=PHONE
 ;Do update for all data in UPDT
 Q
 ;
UPDT ;Update the LAST VISIT field
 I $D(FDR(200.06)) S IEN=$O(FDR(200.06,""))
 E  S IEN=$O(^VA(200,NEWDUZ,8910,"B",SITENUM,0))_","_NEWDUZ_","
 S FDR(200.06,IEN,4)=TODAY
 ;Update the phone each time
 I $D(PHONE),($L(PHONE)>2) S FDR("200.06",IEN,5)=PHONE ;p466
 K IEN D UPDATE^DIE("E","FDR","IEN") ;File all the data
 I $D(^TMP("DIERR",$J)) D
 . N DIK,DA
 . D FAIL
 . I $D(NEWREC) S DIK="^VA(200,",DA=NEWDUZ D ^DIK ;Remove partial entry ;p533
 . S NEWDUZ=0 ;Tell failed
 Q
 ;
BULL ;Set up the bulletin and fire it off, Let MM see if bulletin is there
 N XMB
 S XMB="XUVISIT"
 S XMB(1)=$$FMTE^XLFDT(TODAY)
 S XMB(2)=NAME,XMB(3)=NEWDUZ,XMB(4)=SITE
 S XMB(5)=SITENUM,XMB(6)=RMTDUZ,XMB(7)=PHONE
 D ^XMB
 Q
 ;
FAIL ;Send bulletin if fail to add user.
 N I,XMTEXT,XMY,XUTEXT,XMSUB,XMZ,XMMG,ZTQUEUED
 S XMSUB="XUESSO-VISIT ADD FAILED",ZTQUEUED=1
 D MSG^DIALOG("AEST",.XMTEXT)
 S XUTEXT(1)="Attempting to add "_NAME_" from "_SITE
 S XUTEXT(2)=$G(DATIN),XUTEXT(3)=" ",XUTEXT=3,I=0
 F  S I=$O(XMTEXT(I)) Q:'I  S XUTEXT=XUTEXT+1,XUTEXT(XUTEXT)=XMTEXT(I)
 S XMTEXT="XUTEXT(",XMY("G.XUSVISITFAIL@FO-OAKLAND.MED.VA.GOV")=""
 D ^XMD
 Q

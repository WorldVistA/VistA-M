DGOTHMG1 ;SHRPE/YMG - OTH Management actions ;04/30/19
 ;;5.3;Registration;**952**;Aug 13, 1993;Build 160
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
SP ; select patient
 ;
 ; DGDFN, DGIEN33, and DSPMODE are defined in ^DGOTHMGT
 ;
 N DIC,DTOUT,DUOUT,X,Y
 D FULL^VALM1
 S VALMBCK="R"
 S DIC="^DGOTH(33,",DIC(0)="AEQZV",DIC("A")="Select OTH Eligibility Patient: "
 ;screen out all that are not active or not OTH-90
 S DIC("S")="I $P(^(0),U,2)=1,$$GET1^DIQ(2,$P(^(0),U)_"","",.5501,""I"")=""OTH-90"""
 D ^DIC K DIC
 I +Y>0 D
 .S DGIEN33=+Y,DGDFN=+Y(0)
 .D BLD^DGOTHMGT(DSPMODE) ; rebuild list
 .D BLDHDR^DGOTHMGT(DSPMODE) ; rebuild header
 .Q
 Q
 ;
PI ; patient inquiry
 ;
 ; DGDFN and DGIEN33 are defined in ^DGOTHMGT
 ;
 D FULL^VALM1
 D CLEAR^VALM1
 S VALMBCK="R"
 D PATDISP^DGOTHINQ
 D ASKCONT^DGOTHMG2
 Q
 ;
VD ; view denied requests
 ;
 ; DGSVDDF and DSPMODE are defined in ^DGOTHMGT
 ;
 S VALMBCK="R"
 S DSPMODE=1
 ; change caption
 K VALMDDF M VALMDDF=DGSVDDF("D") D CHGCAP^VALM("LINE","Line") ; use CHGCAP^VALM to reload VALMDDF array
 D BLD^DGOTHMGT(DSPMODE) ; rebuild list
 D BLDHDR^DGOTHMGT(DSPMODE) ; rebuild header
 Q
 ;
VA ; view approved requests
 ;
 ; DGSVDDF and DSPMODE are defined in ^DGOTHMGT
 ;
 S VALMBCK="R"
 S DSPMODE=0
 ; change caption
 K VALMDDF M VALMDDF=DGSVDDF("A") D CHGCAP^VALM("LINE","Line") ; use CHGCAP^VALM to reload VALMDDF array
 D BLD^DGOTHMGT(DSPMODE) ; rebuild list
 D BLDHDR^DGOTHMGT(DSPMODE) ; rebuild header
 Q
 ;
SD ; show request details
 ;
 ; DGIEN33 and DSPMODE are defined in ^DGOTHMGT
 ;
 N DATASTR,DENIEN,DGIEN365,DGIEN90,SEL,Z
 D FULL^VALM1
 S VALMBCK="R"
 D EN^VALM2($G(XQORNOD(0)),"S")
 S SEL=$O(VALMY("")) I 'SEL Q
 I DSPMODE D
 .; denied request
 .S DENIEN=$G(@VALMAR@("IDX",SEL,SEL))
 .S DATASTR=$$GETDEN^DGOTHUT1(DGIEN33,DENIEN) I +DATASTR<0 W !!,"Error: ",$P(DATASTR,U,2) Q
 .W !!,$$CJ^XLFSTR("Denied authorization request details",80)
 .W !,$$CJ^XLFSTR("------------------------------------",80)
 .W !,"             Request #: ",$P(DATASTR,U)
 .W !,"Date request submitted: ",$$FMTE^XLFDT($P(DATASTR,U,2))
 .W !," Authorization comment: ",$P(DATASTR,U,3)
 .W !,"    Request entered on: ",$$FMTE^XLFDT($P(DATASTR,U,5))
 .W !,"    Request entered by: ",$P(DATASTR,U,4)
 .;W !,"              Facility: ",$$NAME^XUAF4($P(DATASTR,U,6))
 .W !,"              Facility: ",$P(DATASTR,U,6)
 .W !
 .Q
 I 'DSPMODE D
 .; approved request
 .S Z=$G(@VALMAR@("IDX",SEL,SEL)),DGIEN365=$P(Z,U),DGIEN90=$P(Z,U,2)
 .S DATASTR=$$GETAUTH^DGOTHUT1(DGIEN33,DGIEN365,DGIEN90) I +DATASTR<0 W !!,"Error: ",$P(DATASTR,U,2) Q
 .I $P(DATASTR,U,2)=1 D
 ..W !!,$$CJ^XLFSTR("Period details",80)
 ..W !,$$CJ^XLFSTR("--------------",80)
 ..Q
 .I $P(DATASTR,U,2)'=1 D
 ..W !!,$$CJ^XLFSTR("Approved authorization request details",80)
 ..W !,$$CJ^XLFSTR("--------------------------------------",80)
 ..Q
 .W !,"      365 day period number: ",$P(DATASTR,U)
 .W !,"       90 day period number: ",$P(DATASTR,U,2)
 .W !,"                 Start date: ",$$FMTE^XLFDT($P(DATASTR,U,3))
 .I $P(DATASTR,U,2)'=1 D
 ..W !,"     Date request submitted: ",$$FMTE^XLFDT($P(DATASTR,U,4))
 ..W !,"              Authorized by: ",$P(DATASTR,U,8)
 ..W !,"Authorization received date: ",$$FMTE^XLFDT($P(DATASTR,U,5))
 ..Q
 .W !,"        Entered / edited on: ",$$FMTE^XLFDT($P(DATASTR,U,7))
 .W !,"        Entered / edited by: ",$P(DATASTR,U,6)
 .;W !,"                   Facility: ",$$NAME^XUAF4($P(DATASTR,U,9))
 .W !,"                   Facility: ",$P(DATASTR,U,9)
 .Q
 D ASKCONT^DGOTHMG2
 Q
 ;
PR ; show pending request
 ;
 ; DGDFN is defined in ^DGOTHMGT
 ;
 N DATASTR
 D FULL^VALM1
 S VALMBCK="R"
 S DATASTR=$$GETPEND^DGOTHUT1(DGDFN)
 I +DATASTR'>0 W !!,"Error: ",$P(DATASTR,U,2)
 I +DATASTR>0 D
 .W !!,$$CJ^XLFSTR("Pending authorization request details",80)
 .W !,$$CJ^XLFSTR("-------------------------------------",80)
 .W !,"Date request submitted: ",$$FMTE^XLFDT($P(DATASTR,U,2))
 .W !,"    Request entered on: ",$$FMTE^XLFDT($P(DATASTR,U,4))
 .W !,"    Request entered by: ",$P(DATASTR,U,3)
 .;W !,"              Facility: ",$$NAME^XUAF4($P(DATASTR,U,5))
 .W !,"              Facility: ",$P(DATASTR,U,5)
 .Q
 D ASKCONT^DGOTHMG2
 Q
 ;
CHKKEY(DGKEY) ; check if current user has a given security key
 ;
 ; DGKEY - name of the security key to check
 ;
 ; assumes that DUZ is defined
 ;
 ; returns 1 if user has the key in question, 0 otherwise
 ;
 N RES
 D OWNSKEY^XUSRB(.RES,DGKEY)
 Q RES(0)

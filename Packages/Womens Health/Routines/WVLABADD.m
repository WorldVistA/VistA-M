WVLABADD ;HCIOFO/FT-SAVE A LAB TEST AS A WH PROCEDURE ;5/10/99  12:10
 ;;1.0;WOMEN'S HEALTH;**6**;Sep 30, 1998
 ;
EN ; Entry point from [WV SAVE LAB TEST] option.
 ; Converts a lab test stored in the WV LAB TESTS file (#790.08) 
 ; into an entry in the WV PROCEDURES file (#790.1)
 N WVDICB
 S (WVDICB,WVPOP)=0
 F  D  Q:WVPOP
 .D SELECT Q:WVPOP
 .D DISPLAY
 .Q
 D KILL
 Q
SELECT ; Select a lab test entry from File 790.08
 N DIC,DTOUT,DUOUT,WVDFN
 S DIC="^WV(790.08,",DIC(0)="AEMQZ"
 S DIC("A")="Select Lab Test Accession#: "
 D DEFAULT
 D ^DIC
 I Y<0!($D(DTOUT))!($D(DUOUT)) S WVPOP=1 Q
 S WVIEN=+Y
 S WVDFN=+$P(^WV(790.08,+Y,0),U,2)
 S:WVDFN ^DISV(DUZ,"^DPT(")=WVDFN ;space bar/return save for File 790
 Q
DISPLAY ; Display lab test data
 Q:'$G(WVIEN)
 N LRDFN,LRSS,WVDATE,WVLABACC,WVNAME,WVNODE,WVVALUE
 S WVNODE=$G(^WV(790.08,+WVIEN,0))
 Q:WVNODE=""
 S WVLABACC=$P(WVNODE,U,1) ;lab accession#
 S LRDFN=$P(WVNODE,U,36) ;File 63 ien (+^DPT(DFN,"LR"))
 S WVDATE=$P(WVNODE,U,37) ;File 63 inverse date/time
 S LRSS=$P(WVNODE,U,38) ;File 63 subscript (CY or SP)
 I WVLABACC=""!(LRDFN="")!(WVDATE="")!(LRSS="") D  Q
 .W !,"Sorry, lab test "_WVLABACC_" is not available after all."
 .W !,"Will delete this lab test from the list of choices.",!
 .D DELETE(WVIEN)
 .Q
 I $D(^WV(790.1,"F",WVLABACC)) D  Q
 .S WVVALUE=$O(^WV(790.1,"F",WVLABACC,0))
 .S WVVALUE=$P($G(^WV(790.1,WVVALUE,0)),U,1)
 .W !,"Sorry, lab test "_WVLABACC_" is already saved as a procedure."
 .W !,"It is logged as WH accession# "_WVVALUE_"."
 .W !,"Will delete this lab test from the list of choices.",!
 .D DELETE(WVIEN)
 .Q
 K ^TMP("WVLAB",$J)
 D HS^WVLABWP ;call Health Summary, returns lab data in ^TMP("WVLAB",$J) 
 I '$D(^TMP("WVLAB",$J)) D  Q
 .W !,"Sorry, lab test data is not available for this choice."
 .W !,"Will delete this lab test from the list of choices.",!
 .D DELETE(WVIEN)
 .Q
 S WVNAME=$P(WVNODE,U,2) ;dfn
 S WVNAME=$$GET1^DIQ(2,WVNAME,.01,"E") ;get patient name for Browser call
 D BROWSE^DDBR("^TMP(""WVLAB"",$J)","N",WVNAME)
KEEP ; Save lab test as procedure OR delete lab test from File 790.08 OR
 ; ignore it for now.
 N DIR
 S DIR(0)="S^A:add to the WH package;D:delete from the list of choices;I:ignore for now"
 S DIR("A")="What action should be taken with this lab test"
 S DIR("?",1)="Please determine what to do with this lab test."
 S DIR("?",2)="  Ignore this lab test for now."
 S DIR("?",3)="  Delete from the list. It shouldn't be a Women's Health procedure."
 S DIR("?")="  Add this lab test as a Women's Health procedure entry."
 D ^DIR
 I $D(DIRUT) S WVPOP=1 Q
 I Y="I" Q
 I Y="D" D DELETE(WVIEN) Q
 I Y="A" D CONVERT
 Q
CONVERT ; Add the lab test data to the WV PROCEDURE file (#790.1)
 Q:'$G(WVIEN)
 N DFN,DIC,DTOUT,DUOUT
 N WVDATE,WVDR,WVERR,WVNODE,WVPROC
 S WVNODE=$G(^WV(790.08,+WVIEN,0))
 S DIC="^WV(790.2,",DIC(0)="AEMQZ"
 S DIC("A")="Select the procedure type for this lab test: "
 D ^DIC
 W !
 I Y<0!($D(DTOUT))!($D(DUOUT)) S WVPOP=1 Q
 S WVPROC=+Y
 S WVERR=1,DFN=$P(WVNODE,U,2),WVDATE=$P(WVNODE,U,12)
 I '$D(^WV(790,DFN,0)) D  ;add patient to File 790, if not there
 .D AUTOADD^WVPATE(DFN,DUZ(2),.WVERR)
 .Q
 Q:WVERR<0  ;quit if new patient could not be added to File 790
 D FIND^WVLABAD1 ;check for 'unlinked' entry in File 790.1
 I $D(^WV(790.1,"F",WVLABACC)) D  Q  ;link was made to existing entry
 .D DELETE(WVIEN) ;delete lab test from list of choices
 .S Y=+$O(^WV(790.1,"F",WVLABACC,0)) ;ien of procedure entry
 .D EDIT ;edit procedure entry
 .Q
 S WVDR=".02////"_DFN
 S WVDR=WVDR_";.04////"_WVPROC ;File 790.2 pointer
 S:$P(WVNODE,U,7)]"" WVDR=WVDR_";.07////"_$P(WVNODE,U,7) ;provider
 S WVDR=WVDR_";.1////"_$G(DUZ(2)) ;health care facility
 S:$P(WVNODE,U,11)]"" WVDR=WVDR_";.11////"_$P(WVNODE,U,11) ;patient location
 S WVDR=WVDR_";.12////"_$P(WVNODE,U,12) ;procedure date/time
 S WVDR=WVDR_";.14////"_"o" ;status
 S WVDR=WVDR_";.18////.5;.19////"_DT ;entering user and date
 S WVDR=WVDR_";.34////"_$G(DUZ(2)) ;accessioning facility
 S WVDR=WVDR_";2.17////"_$P(WVNODE,U,1) ;lab accession#
 S WVDR=WVDR_";2.18////"_$P(WVNODE,U,36) ;Lab Data file (#63) pointer
 S WVDR=WVDR_";2.19////"_$P(WVNODE,U,37) ;Lab Data file inverse d/t
 S WVDR=WVDR_";2.2////"_$P(WVNODE,U,38) ;Lab Data file subscript (CY/SP)
 ; add procedure to File 790.1
 D NEW2^WVPROC(DFN,WVPROC,WVDATE,WVDR,"","",.WVERR)
 I Y D DELETE(WVIEN)
 I Y D EDIT
 Q
KILL ; Kill variables
 K WVIEN,WVPOP,X,Y
 K ^TMP("WVLAB",$J)
 Q
DELETE(WVIEN) ; Delete an entry from File 790.08
 Q:'$G(WVIEN)
 N DA,DIK,Y
 S DA=WVIEN,DIK="^WV(790.08,"
 D ^DIK
 Q
EDIT ; Edit WV PROCEDURE (#790.1) file entry
 Q:'$G(Y)
 D LT^WVPROC ;edit the new entry
 S WVPOP=0 ;reset WVPOP which is killed by ^WVPROC call
 Q
DEFAULT ; Find next default look-up value.
 ; WVQUIT - ien of File 790.08 entry
 ; WVDICB - last entry checked (don't show an entry they bypassed)
 N WVLOOP,WVNODE,WVQUIT
 Q:$G(WVDICB)=""
 S WVQUIT=0,WVLOOP=+WVDICB
 F  S WVLOOP=$O(^WV(790.08,WVLOOP)) Q:'WVLOOP  D  Q:WVQUIT
 .S WVNODE=$G(^WV(790.08,WVLOOP,0)) Q:WVNODE=""
 .I $P(WVNODE,U,7)=DUZ D  Q  ;duz is requesting provider
 ..S (WVDICB,WVQUIT)=WVLOOP
 ..Q
 .I $P($G(^WV(790,+$P(WVNODE,U,2),0)),U,10)=DUZ D  ;case mgr
 ..S (WVDICB,WVQUIT)=WVLOOP
 ..Q
 .Q
 S DIC("B")=$S(WVQUIT:$P(^WV(790.08,+WVQUIT,0),U,1),1:"")
 K:DIC("B")="" DIC("B")
 Q

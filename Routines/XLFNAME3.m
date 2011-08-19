XLFNAME3 ;CIOFO-SF/MKO-CONVERSION OF NEW PERSON FILE ENTRIES ;10:39 AM  10 Mar 2000
 ;;8.0;KERNEL;**134**;Jul 10, 1995
 ;
NEWPERS(XUFLAG,XUIEN) ;Convert New Person file names
 ;In: XUFLAG [ "C"  : Update Name Components file (#20) and pointer
 ;           [ "K"  : Kill ^XTMP("XLFNAME") up front
 ;           [ "P"  : Update New Person Names
 ;           [ "R"  : Record changes/problems in ^XTMP
 ;    XUIEN  = ien of last record converted;
 ;             conversion will begin with the next record
 ;
 N XUCNT,XUDEG,XUF,XUIENL,XUIENS,XUMSG,XUNAM,XUNMSP,XUNODEGT,XUNOTRIG
 N XUNOSIGT,XUPVAL,XUSTOP,XPDIDTOT,I
 S XUFLAG=$G(XUFLAG)_"M35"
 S (XUNOTRIG,XUNOSIGT,XUNODEGT)=1
 S XUNMSP="XLFNAME",XUCNT=0
 ;
 K:XUFLAG["K" ^XTMP("XLFNAME")
 S:XUFLAG["R" $P(^XTMP(XUNMSP,0),U,1,2)=$$FMADD^XLFDT(DT,90)_"^"_DT
 ;
 ;Loop through New Person file
 I '$D(ZTQUEUED),'$D(XPDNM) D
 . W !!," NOTE: To cancel this process, type '^' at any time."
 . W !," Please wait..."
 ;
 S XUIEN=+$G(XUIEN)
 ;
 ;Get XPDIDTOT = total number of entries to convert
 I XUFLAG["P" D
 . I 'XUIEN S XPDIDTOT=$P($G(^VA(200,0)),U,4) Q:XPDIDTOT>0
 . S XUMSG="   Obtaining number of entries to convert. Please wait..."
 . I '$D(XPDNM) W !,XUMSG
 . E  D MES^XPDUTL(XUMSG)
 . K XUMSG
 . S I=XUIEN,XPDIDTOT=0
 . F  S I=$O(^VA(200,I)) Q:'I  S:$P($G(^(I,0)),U)]"" XPDIDTOT=XPDIDTOT+1
 . S:'XUIEN $P(^VA(200,0),U,4)=XPDIDTOT
 ;
 S XUMSG="   Converting New Person Names..."
 I '$D(XPDNM) W !,XUMSG
 E  D MES^XPDUTL(XUMSG)
 K XUMSG
 ;
 S XUSTOP=0
 F  S XUIEN=$O(^VA(200,XUIEN)) Q:'XUIEN  D  D STPCHK Q:XUSTOP
 . S XUNAM=$P($G(^VA(200,XUIEN,0)),U)
 . I XUNAM=""!$D(^VA(200,XUIEN,-9))!(XUNAM?1"MERGING INTO".E) Q
 . S XUIENS=XUIEN_","
 . ;
 . S XUPVAL=$P($G(^VA(200,XUIEN,3.1)),U)
 . S XUDEG=$P($G(^VA(200,XUIEN,3.1)),U,6)
 . ;
 . ;Process .01 field of file 200
 . S XUF=$S(XUNAM="POSTMASTER"&(XUIEN=.5):$TR(XUFLAG,"R"),1:XUFLAG)
 . D UPDATE(XUF,200,XUIENS,.01,XUNAM,10.1,XUPVAL,XUNMSP,XUDEG) K XUF
 . ;
 . ;Remember this ien if entries are being converted
 . I XUFLAG["P",XUFLAG["R" S $P(^XTMP(XUNMSP,0),U,4)=XUIEN
 ;
 S XUMSG(1)=$S(XUSTOP:"   Process cancelled.",1:"   DONE!")
 S XUMSG(2)="   Number of records processed: "_XUCNT
 S:XUCNT XUMSG(3)="   Entry number last processed: "_$G(XUIENL)
 I '$D(XPDNM) W ! F I=1:1:3 W:$D(XUMSG(I))#2 !,XUMSG(I)
 E  D MES^XPDUTL(.XUMSG)
 Q
 ;
STPCHK ;Every 200 records, check whether to stop
 S XUCNT=XUCNT+1,XUIENL=XUIEN
 D:'(XUCNT#200)
 . I $D(ZTQUEUED),$$S^%ZTLOAD S (ZTSTOP,XUSTOP)=1 Q
 . I '$D(ZTQUEUED),'$D(XPDNM) W "." I $$STOP S XUSTOP=1 Q
 . I '$D(ZTQUEUED),$D(XPDNM) D UPDATE^XPDID(XUCNT)
 Q
 ;
UPDATE(XUFLAG,XUFIL,XUIENS,XUFLD,XUNAM,XUPTR,XUPVAL,XUNMSP,XUDEG) ;Process name field
 N XUAUD,XUDA,XUFDA,XUMAX,XUMSG,XUORIG,DIERR
 S XUFLAG=$G(XUFLAG)
 I '$G(XUNOTRIG) N XUNOTRIG S XUNOTRIG=1
 ;
 ;Get maximum length of standard name
 S XUMAX=+$P(XUFLAG,"M",2,999)
 ;
 ;Standardize/parse name; Record uncertainties in ^XTMP
 D STDNAME^XLFNAME(.XUNAM,"CP",.XUAUD)
 I XUMAX,$L(XUNAM)>XUMAX D
 . S XUNAM=$$NAMEFMT^XLFNAME(.XUNC,"F","CSL"_+$G(XUMAX))
 . S XUAUD("TRUNC")=""
 S:$D(XUAUD("STRIP")) XUNAM("NOTES")=XUAUD
 S:XUNAM'=XUAUD XUAUD("DIFFERENT")=""
 I $D(XUAUD)>9,XUFLAG["R" D RECORD(XUFIL,XUFLD,XUIENS,.XUNAM,.XUAUD,XUNMSP)
 ;
 ;Update file #20 and pointer to file #20
 I XUFLAG["C" D
 . S:$D(XUDEG)#2 XUNAM("DEGREE")=XUDEG
 . D UPDCOMP^XLFNAME2(XUFIL,XUIENS,XUFLD,.XUNAM,XUPTR,.XUPVAL)
 ;
 ;Update source name if different
 I XUFLAG["P",XUNAM'=XUAUD D
 . S XUFDA(XUFIL,XUIENS,XUFLD)=XUNAM
 . D FILE^DIE("","XUFDA","XUMSG") K DIERR,XUMSG
 Q
 ;
RECORD(XUFIL,XUFLD,XUREC,XUNAM,XUAUD,XUNMSP) ;Record problems in ^XTMP
 N XUIENS,XUINV
 Q:$G(XUNMSP)=""
 ;
 ;Get IENS from XUREC
 I $G(XUREC)'["," S XUIENS=$$IENS^DILF(.XUREC)
 E  S XUIENS=XUREC S:XUIENS'?.E1"," XUIENS=XUIENS_","
 S XUINV=$$INV(XUIENS)
 ;
 ;Record values
 K ^XTMP(XUNMSP,XUFIL,XUFLD,XUINV)
 M ^XTMP(XUNMSP,XUFIL,XUFLD,XUINV)=XUAUD
 S $P(^XTMP(XUNMSP,XUFIL,XUFLD,XUINV),U,2,6)=XUNAM_U_$G(XUNAM("GIVEN"))_U_$G(XUNAM("MIDDLE"))_U_$G(XUNAM("FAMILY"))_U_$G(XUNAM("SUFFIX"))
 Q
 ;
STOP() ;Check whether to stop
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 R Y#1:0 Q:Y="" 0
 F  R *X:0 E  Q
 Q:Y'=U 0
 S DIR(0)="Y",DIR("A")="Are you sure you want to stop",DIR("B")="NO"
 S:XUFLAG["P" DIR("?")="If you stop a conversion, you can continue later where you left off."
 W ! D ^DIR
 Q Y=1
 ;
INV(IENS) ;Invert the IENS
 N I,X
 Q:IENS?."," ""
 S:IENS'?.E1"," IENS=IENS_","
 S X="" F I=$L(IENS,",")-1:-1:1 S X=X_$P(IENS,",",I)_":"
 S:X?.E1":" X=$E(X,1,$L(X)-1)
 Q X
 ;
PRE ;The Pre-Install entry point
 N XUMSG,DIERR
 ;
 ;Delete the "AF"-xref on 200,.01
 I $P($G(^DD(200,.01,1,3,0)),U,2)="AF" D
 . D DELIX^DDMOD(200,.01,3,"","","XUMSG")
 . I '$G(DIERR),$D(XPDNM) D BMES^XPDUTL("The 'AF' cross-reference on file #200, field #.01 was deleted.")
 ;
 ;Delete the traditional "B" index on 200,.01
 I $P($G(^DD(200,.01,1,1,0)),U,2)="B" D
 . D DELIX^DDMOD(200,.01,1,"","","XUMSG")
 Q
 ;
POST ;The Post-Install entry point (run conversion)
 N XUIEN,XUNMSP
 S XUNMSP="XLFNAME"
 S XUIEN=+$P($G(^XTMP(XUNMSP,0)),U,4)
 D NEWPERS("CPR"_$E("K",'XUIEN),+XUIEN)
 I $D(^XTMP(XUNMSP,0))#2,XUIEN'=+$P(^(0),U,4) S $P(^(0),U,3)="Created by POST~XLFNAME (Post Install Conversion of XU*8.0*134)"
 Q
